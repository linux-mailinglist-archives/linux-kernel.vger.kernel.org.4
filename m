Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D4626F6C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 13:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiKMMVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 07:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiKMMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 07:21:28 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51527DF93;
        Sun, 13 Nov 2022 04:21:27 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2ADCKpCI013379;
        Sun, 13 Nov 2022 21:20:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2ADCKpCI013379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668342052;
        bh=KQYMcQ8jyCMguJ5gunXZ5HdXL7ZJ1Kcn3ixoiC6kUSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yhqpitGJQ8FQwYg9kz0GRzkATS45oGtEerUKlTpvXagoEVXFjFhaR3Cgi8s8SSkdZ
         1RJPdtiq5Zfg6DdNHD9eMDsw5hfZRffCB+jmaiz3Cgod6bdlVb70uODD6U2MmTTyqX
         +NORRfrywCVy77nm8tBjq8uC23HCENwQay7IQrmRxZ+S7RSd5U4gq0erkdXx/et5HZ
         1ck16MBW05e6wf9Apr/n94mg+zMG8pA6teQlltimHwWyxHDMeC7obCtgbE4py5egQ3
         G1EbTvpXKigretY9fvy5PzAiTpPqioZBy6EJi2hUqrnIYtYAtAQQm6qcRpopbpTsDA
         4VB5n558ZDHWQ==
X-Nifty-SrcIP: [209.85.210.41]
Received: by mail-ot1-f41.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso5229188otq.11;
        Sun, 13 Nov 2022 04:20:51 -0800 (PST)
X-Gm-Message-State: ANoB5pkt4UcIeQj7qK+RShRka/wZAu8VrzmNSYx8t06nGc9uGoizg08+
        ZeDXHKIcjmsiavOSNmyWTUAa+wKEeE/MZB+AAbQ=
X-Google-Smtp-Source: AA0mqf7Ak1td9ZHTtIIvy5gbQpT6D9VV2glo01Ebzq37Ls700skUqQzE+cxSwsEqe5ri6T8fVlzXTVrPkBnh2QaKiMA=
X-Received: by 2002:a05:6830:109:b0:661:8d9e:1959 with SMTP id
 i9-20020a056830010900b006618d9e1959mr4762382otp.225.1668342050599; Sun, 13
 Nov 2022 04:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20221113111525.3762483-1-masahiroy@kernel.org> <20221113111525.3762483-3-masahiroy@kernel.org>
In-Reply-To: <20221113111525.3762483-3-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Nov 2022 21:20:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQiwNB6GQ1kt9ig7TCDJkZBd5M=8PWkd0xM6KjHj0W9PA@mail.gmail.com>
Message-ID: <CAK7LNAQiwNB6GQ1kt9ig7TCDJkZBd5M=8PWkd0xM6KjHj0W9PA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: warn objects shared among multiple modules
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 8:15 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> If an object is shared among multiple modules, some of them are
> configured as 'm', but the others as 'y', the shared object is
> linked to the modules and vmlinux. This is a potential issue because
> the expected CFLAGS are different between modules and builtins.
>
> Commit 637a642f5ca5 ("zstd: Fixing mixed module-builtin objects")
> reported that this could be even more fatal in some cases such as
> Clang LTO.
>
> That commit fixed lib/zlib/zstd_{compress,decompress}, but there are
> still more instances of breakage.
>
> This commit adds a W=1 warning for shared objects, so that the kbuild
> test robot, which provides build tests with W=1, will avoid a new
> breakage slipping in.
>
> Quick compile tests on v6.1-rc4 detected the following:
>

Also

    scripts/Makefile.build:252: ./drivers/block/rnbd/Makefile:
rnbd-common.o is added to multiple modules: rnbd-client rnbd-server



> scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile: cn10k_cpt.o is added to multiple modules: rvu_cptpf rvu_cptvf
> scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile: otx2_cptlf.o is added to multiple modules: rvu_cptpf rvu_cptvf
> scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile: otx2_cpt_mbox_common.o is added to multiple modules: rvu_cptpf rvu_cptvf
> scripts/Makefile.build:252: ./drivers/edac/Makefile: skx_common.o is added to multiple modules: i10nm_edac skx_edac
> scripts/Makefile.build:252: ./drivers/gpu/drm/bridge/imx/Makefile: imx-ldb-helper.o is added to multiple modules: imx8qm-ldb imx8qxp-ldb
> scripts/Makefile.build:252: ./drivers/mfd/Makefile: rsmu_core.o is added to multiple modules: rsmu-i2c rsmu-spi
> scripts/Makefile.build:252: ./drivers/mtd/tests/Makefile: mtd_test.o is added to multiple modules: mtd_nandbiterrs mtd_oobtest mtd_pagetest mtd_readtest mtd_speedtest mtd_stresstest mtd_subpagetest mtd_torturetest
> scripts/Makefile.build:252: ./drivers/net/dsa/ocelot/Makefile: felix.o is added to multiple modules: mscc_felix mscc_seville
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: cn23xx_pf_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: cn23xx_vf_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: cn66xx_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: cn68xx_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: lio_core.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: lio_ethtool.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_droq.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_mailbox.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_mem_ops.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: octeon_nic.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: request_manager.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefile: response_manager.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/enetc/Makefile: enetc_cbdr.o is added to multiple modules: fsl-enetc fsl-enetc-vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/enetc/Makefile: enetc_ethtool.o is added to multiple modules: fsl-enetc fsl-enetc-vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/enetc/Makefile: enetc.o is added to multiple modules: fsl-enetc fsl-enetc-vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_cmd.o is added to multiple modules: hclge hclgevf
> scripts/Makefile.build:252: ./drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_rss.o is added to multiple modules: hclge hclgevf
> scripts/Makefile.build:252: ./drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_tqp_stats.o is added to multiple modules: hclge hclgevf
> scripts/Makefile.build:252: ./drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_dcbnl.o is added to multiple modules: rvu_nicpf rvu_nicvf
> scripts/Makefile.build:252: ./drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_ale.o is added to multiple modules: keystone_netcp keystone_netcp_ethss ti_cpsw ti_cpsw_new
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_ethtool.o is added to multiple modules: ti_cpsw ti_cpsw_new
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_priv.o is added to multiple modules: ti_cpsw ti_cpsw_new
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_sl.o is added to multiple modules: ti_cpsw ti_cpsw_new
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: davinci_cpdma.o is added to multiple modules: ti_cpsw ti_cpsw_new ti_davinci_emac
> scripts/Makefile.build:252: ./drivers/platform/x86/intel/int3472/Makefile: common.o is added to multiple modules: intel_skl_int3472_discrete intel_skl_int3472_tps68470
> scripts/Makefile.build:252: ./sound/soc/codecs/Makefile: wcd-clsh-v2.o is added to multiple modules: snd-soc-wcd9335 snd-soc-wcd934x snd-soc-wcd938x
>
> Once all the warnings are fixed, it can become an error irrespective of
> W= option.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.build | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 37cf88d076e8..799df12b53f3 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -222,6 +222,10 @@ endif
>
>  cmd_check_local_export = $(srctree)/scripts/check-local-export $@
>
> +ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
> +cmd_warn_shared_object = $(if $(word 2, $(modname-multi)),$(warning $(kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
> +endif
> +
>  define rule_cc_o_c
>         $(call cmd_and_fixdep,cc_o_c)
>         $(call cmd,gen_ksymdeps)
> @@ -231,6 +235,7 @@ define rule_cc_o_c
>         $(call cmd,gen_objtooldep)
>         $(call cmd,gen_symversions_c)
>         $(call cmd,record_mcount)
> +       $(call cmd,warn_shared_object)
>  endef
>
>  define rule_as_o_S
> @@ -239,6 +244,7 @@ define rule_as_o_S
>         $(call cmd,check_local_export)
>         $(call cmd,gen_objtooldep)
>         $(call cmd,gen_symversions_S)
> +       $(call cmd,warn_shared_object)
>  endef
>
>  # Built-in and composite module parts
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
