Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16D62FDD1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbiKRTQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiKRTQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:16:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F5848774;
        Fri, 18 Nov 2022 11:16:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D3C8626B2;
        Fri, 18 Nov 2022 19:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731E8C43470;
        Fri, 18 Nov 2022 19:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668798962;
        bh=3oaypFAauEKT+WjnVA3nrmkQ0TB+gA+2N8zEi8VAFLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cl8DePJfdv9aA0NMSkSSc/zpoCaWvkFV8xxuw4hQbl+k9Ne0G9b3f+m5FXGolow08
         jaGGGXWSBUgjp47BgFkOYTBMIyTlNybmxEzqkK0NFG3jEG2uKoH/SL+USCqZje5uaS
         nGz7S+L68y+igN8pP2t72D9BAUTsTdsHods01hzBBKYzxf/jsKNfvYDRQK9hZ0bh1Y
         5Tt2RpfvLxKh3DyUMyYYyGorLWL41JUFfxhzSUajleqXPqOaimbi6KwJcyXNZMaO+9
         6PtYQl0s792Xmji33/yLX/7dQJ4KgqExhWx7VPFOhTA9CQDhoqErtVQrXFNbAz1XXc
         Ukav6xclsceyw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 2/2] kbuild: warn objects shared among multiple modules
Date:   Sat, 19 Nov 2022 04:15:51 +0900
Message-Id: <20221118191551.66448-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118191551.66448-1-masahiroy@kernel.org>
References: <20221118191551.66448-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an object is shared among multiple modules, amd some of them are
configured as 'm', but the others as 'y', the shared object is built
as modular, then linked to the modules and vmlinux. This is a potential
issue because the expected CFLAGS are different between modules and
builtins.

Commit 637a642f5ca5 ("zstd: Fixing mixed module-builtin objects")
reported that this could be even more fatal in some cases such as
Clang LTO.

That commit fixed lib/zlib/zstd_{compress,decompress}, but there are
still more instances of breakage.

This commit adds a W=1 warning for shared objects, so that the kbuild
test robot, which provides build tests with W=1, will avoid a new
breakage slipping in.

Quick compile tests on v6.1-rc4 detected the following:

scripts/Makefile.build:252: ./drivers/block/rnbd/Makefile: rnbd-common.o is added to multiple modules: rnbd-client rnbd-server
scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile: cn10k_cpt.o is added to multiple modules: rvu_cptpf rvu_cptvf
scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile: otx2_cptlf.o is added to multiple modules: rvu_cptpf rvu_cptvf
scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile: otx2_cpt_mbox_common.o is added to multiple modules: rvu_cptpf rvu_cptvf
scripts/Makefile.build:252: ./drivers/edac/Makefile: skx_common.o is added to multiple modules: i10nm_edac skx_edac
scripts/Makefile.build:252: ./drivers/gpu/drm/bridge/imx/Makefile: imx-ldb-helper.o is added to multiple modules: imx8qm-ldb imx8qxp-ldb
scripts/Makefile.build:252: ./drivers/mfd/Makefile: rsmu_core.o is added to multiple modules: rsmu-i2c rsmu-spi
scripts/Makefile.build:252: ./drivers/mtd/tests/Makefile: mtd_test.o is added to multiple modules: mtd_nandbiterrs mtd_oobtest mtd_pagetest mtd_readtest mtd_speedtest mtd_stresstest mtd_subpagetest mtd_torturetest
scripts/Makefile.build:252: ./drivers/net/dsa/ocelot/Makefile: felix.o is added to multiple modules: mscc_felix mscc_seville
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: cn23xx_pf_device.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: cn23xx_vf_device.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: cn66xx_device.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: cn68xx_device.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: lio_core.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: lio_ethtool.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_device.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_droq.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_mailbox.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_mem_ops.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_nic.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: request_manager.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: response_manager.o is added to multiple modules: liquidio liquidio_vf
scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/enetc/Makefile: enetc_cbdr.o is added to multiple modules: fsl-enetc fsl-enetc-vf
scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/enetc/Makefile: enetc_ethtool.o is added to multiple modules: fsl-enetc fsl-enetc-vf
scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/enetc/Makefile: enetc.o is added to multiple modules: fsl-enetc fsl-enetc-vf
scripts/Makefile.build:252: ./drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_cmd.o is added to multiple modules: hclge hclgevf
scripts/Makefile.build:252: ./drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_rss.o is added to multiple modules: hclge hclgevf
scripts/Makefile.build:252: ./drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_tqp_stats.o is added to multiple modules: hclge hclgevf
scripts/Makefile.build:252: ./drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_dcbnl.o is added to multiple modules: rvu_nicpf rvu_nicvf
scripts/Makefile.build:252: ./drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_ale.o is added to multiple modules: keystone_netcp keystone_netcp_ethss ti_cpsw ti_cpsw_new
scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_ethtool.o is added to multiple modules: ti_cpsw ti_cpsw_new
scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_priv.o is added to multiple modules: ti_cpsw ti_cpsw_new
scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_sl.o is added to multiple modules: ti_cpsw ti_cpsw_new
scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: davinci_cpdma.o is added to multiple modules: ti_cpsw ti_cpsw_new ti_davinci_emac
scripts/Makefile.build:252: ./drivers/platform/x86/intel/int3472/Makefile: common.o is added to multiple modules: intel_skl_int3472_discrete intel_skl_int3472_tps68470
scripts/Makefile.build:252: ./sound/soc/codecs/Makefile: wcd-clsh-v2.o is added to multiple modules: snd-soc-wcd9335 snd-soc-wcd934x snd-soc-wcd938x

Once all the warnings are fixed, it can become an error irrespective of
W= option.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Add drivers/block/rnbd/Makefile for commit log

 scripts/Makefile.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 37cf88d076e8..799df12b53f3 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -222,6 +222,10 @@ endif
 
 cmd_check_local_export = $(srctree)/scripts/check-local-export $@
 
+ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
+cmd_warn_shared_object = $(if $(word 2, $(modname-multi)),$(warning $(kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
+endif
+
 define rule_cc_o_c
 	$(call cmd_and_fixdep,cc_o_c)
 	$(call cmd,gen_ksymdeps)
@@ -231,6 +235,7 @@ define rule_cc_o_c
 	$(call cmd,gen_objtooldep)
 	$(call cmd,gen_symversions_c)
 	$(call cmd,record_mcount)
+	$(call cmd,warn_shared_object)
 endef
 
 define rule_as_o_S
@@ -239,6 +244,7 @@ define rule_as_o_S
 	$(call cmd,check_local_export)
 	$(call cmd,gen_objtooldep)
 	$(call cmd,gen_symversions_S)
+	$(call cmd,warn_shared_object)
 endef
 
 # Built-in and composite module parts
-- 
2.34.1

