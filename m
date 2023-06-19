Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE53734F43
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFSJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjFSJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E84CC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F30060AB1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D1EC433C8;
        Mon, 19 Jun 2023 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687165952;
        bh=C9Nk9/QP6OPS4jxNq9hz3jeu3Lte1JDyc4vSyqZJLlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EI4Wja3flSrNux6FdpjGVJbrxdVm96gT6eM4VzNrbswJM0uodSDk5Ny98EBcrTPAX
         M+nJCf9Y4F2zYmbmZMFjWR5Ux53L2VGT8pN+U65LD9Qbec8/wLQcrXn5BY2CtpVZ1/
         7LRnas0WmzZJjvBIaOtxVE1XfMvucTnC1gxS56itWF8nnJr3YChTrmgs51sA45plAV
         EWvlI3oOmInYXr1EEkHJWQCtgQmUQqb54Hs1UMr1olj96m/e613rbUH+fL+wnoO5Yp
         81NdcYmSMl36difwuNyajHwFZEq0UZirKi1sjoCOJyePipnlFGL348WmynOogkR6nw
         zZFlxlU4VoYbw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] [v2] sfc: fix uninitialized variable use
Date:   Mon, 19 Jun 2023 11:12:10 +0200
Message-Id: <20230619091215.2731541-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619091215.2731541-1-arnd@kernel.org>
References: <20230619091215.2731541-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new efx_bind_neigh() function contains a broken code path when IPV6 is
disabled:

drivers/net/ethernet/sfc/tc_encap_actions.c:144:7: error: variable 'n' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                if (encap->type & EFX_ENCAP_FLAG_IPV6) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/sfc/tc_encap_actions.c:184:8: note: uninitialized use occurs here
                if (!n) {
                     ^
drivers/net/ethernet/sfc/tc_encap_actions.c:144:3: note: remove the 'if' if its condition is always false
                if (encap->type & EFX_ENCAP_FLAG_IPV6) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/sfc/tc_encap_actions.c:141:22: note: initialize the variable 'n' to silence this warning
                struct neighbour *n;
                                   ^
                                    = NULL

Change it to use the existing error handling path here.

Fixes: 7e5e7d800011a ("sfc: neighbour lookup for TC encap action offload")
Suggested-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use 'goto' instead of incorrectly entering another error path
---
 drivers/net/ethernet/sfc/tc_encap_actions.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index aac259528e73e..7e8bcdb222ad1 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -164,6 +164,7 @@ static int efx_bind_neigh(struct efx_nic *efx,
 			 */
 			rc = -EOPNOTSUPP;
 			NL_SET_ERR_MSG_MOD(extack, "No IPv6 support (neigh bind)");
+			goto out_free;
 #endif
 		} else {
 			rt = ip_route_output_key(net, &flow4);
-- 
2.39.2

