Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A919F732B26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbjFPJLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344813AbjFPJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED5B420F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50DF76326F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A41EC433C0;
        Fri, 16 Jun 2023 09:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686906544;
        bh=iPWPXNvnYRe2+h21DBS9ZfvzMiWbCC13nR/zPknLFF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgxB3PPe7xDo5i1HoqL5Nkc8iI3Igjm7zkJRKSoXXGviq3rQZkC+DUKVcBcKTuX1l
         Y+v+WN/zaUD1H7JdvtbQq9E9sWKNvEpbaa1U4ahwYGjKTJ9yoPn6R3kfuJvJ8v/Qdb
         Y0E+he2nJLOvJusREIyfzy4yl7zqQ+mtsk8GtM6D8POPXd3rpY8A6sIqjDOLjw5be/
         T78yns/TYvPxei64/CIZgxtYSi9tCKIaEWbKx74gpSHxR5zcmUjXtR42Rk82XBITfG
         ZX0iAEUNCEUHkzWCgUwHqnKTmcL4OQveGOaiDzHXDQclQxW56DqQ/Eh6B2R3mjWJFR
         rnmjGGAv+AWLw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alejandro Lucero <alejandro.lucero-palau@amd.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sfc: add CONFIG_INET dependency for TC offload
Date:   Fri, 16 Jun 2023 11:08:19 +0200
Message-Id: <20230616090844.2677815-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616090844.2677815-1-arnd@kernel.org>
References: <20230616090844.2677815-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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

