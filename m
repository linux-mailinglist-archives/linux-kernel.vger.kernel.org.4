Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF0734F41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjFSJM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjFSJMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:12:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CB9E0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21D860B09
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B276C433C0;
        Mon, 19 Jun 2023 09:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687165942;
        bh=nncO+JSw+gBGPePnGvsYe6987xslG26sNKILTCu8PE4=;
        h=From:To:Cc:Subject:Date:From;
        b=QZNSuDHyR+NEwIyN6E2jYjgAtNB48IQjhFe8x2s3pxhMNGzSGmsNTXyPd2gykDoPL
         sBqVtHd4Z/33TJ/t2Oywi2StoIJZh68DINrmETA5ac33mNmEexDL32E0ftRnf5EMJ5
         3AX4uY5OVTCtAmN03yHzRiske2zy1xLKdXxqcd/UvzXz+ftWba/cxbedupBamO18D9
         ddf27cJwmnYPVdYVCUwEttD+7fcUCo2GvFcDDfQOph48Mf61PC+oax3Uf5IVNtaBqX
         xIu00ZRJ83gFTBcUxDHL8wwJbAjSLEV0A97jx/PiMes/nzOy7qSINMSMa8VmzA2trP
         /AnnttSR2STeA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@resnulli.us>,
        Alejandro Lucero <alejandro.lucero-palau@amd.com>,
        netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [v2] sfc: add CONFIG_INET dependency for TC offload
Date:   Mon, 19 Jun 2023 11:12:09 +0200
Message-Id: <20230619091215.2731541-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver now fails to link when CONFIG_INET is disabled, so
add an explicit Kconfig dependency:

ld.lld: error: undefined symbol: ip_route_output_flow
>>> referenced by tc_encap_actions.c
>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_tc_flower_create_encap_md) in archive vmlinux.a

ld.lld: error: undefined symbol: ip_send_check
>>> referenced by tc_encap_actions.c
>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_gen_encap_header) in archive vmlinux.a
>>> referenced by tc_encap_actions.c
>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_gen_encap_header) in archive vmlinux.a

ld.lld: error: undefined symbol: arp_tbl
>>> referenced by tc_encap_actions.c
>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_tc_netevent_event) in archive vmlinux.a
>>> referenced by tc_encap_actions.c
>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_tc_netevent_event) in archive vmlinux.a

Fixes: a1e82162af0b8 ("sfc: generate encap headers for TC offload")
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306151656.yttECVTP-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add Fixes and Closes tags
---
 drivers/net/ethernet/sfc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 4af36ba8906ba..3eb55dcfa8a61 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -50,6 +50,7 @@ config SFC_MCDI_MON
 config SFC_SRIOV
 	bool "Solarflare SFC9100-family SR-IOV support"
 	depends on SFC && PCI_IOV
+	depends on INET
 	default y
 	help
 	  This enables support for the Single Root I/O Virtualization
-- 
2.39.2

