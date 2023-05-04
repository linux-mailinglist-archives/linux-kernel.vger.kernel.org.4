Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74986F7405
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjEDTrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjEDTqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05FDA247;
        Thu,  4 May 2023 12:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72DC663773;
        Thu,  4 May 2023 19:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE25AC433A0;
        Thu,  4 May 2023 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229490;
        bh=ZDpaaRyf/2z6KTrKXSfxuTRt3NtW4e5+JRI1L/NAYzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWFGGikspgjoImdVqlSCqtpniY4u6heow8btR1egWBXHQCnxEF9h96SI4r7vwJGm7
         XrHpQjkGZWO10ybO55CRSkLm8aPTtZDV0xS4PLIl9gXRiw2yOeHo3KPqfoW+ZH5icz
         jn1i4BaldQOLO8XZrRnLbUB7wexCtUIc1qc3FDnnD5F8P2NF4RzeAJBUlSjwtwD6dh
         ktwfx4PtndJDHCjhaqFJwH9wp6xcDgYH6zi1JGx/usILhcxCY7crJ0mvHIutGL3bsH
         bDIQU1BCovD5G9idmCWyas1oiNkOUf/I4dxV6zfUPenuz+IY+F5lJUOW1Y4pE8HoeP
         KhWGa3n/BZ9Iw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxim Korotkov <korotkov.maxim.s@gmail.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, michael.chan@broadcom.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 12/53] bnxt: avoid overflow in bnxt_get_nvram_directory()
Date:   Thu,  4 May 2023 15:43:32 -0400
Message-Id: <20230504194413.3806354-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Korotkov <korotkov.maxim.s@gmail.com>

[ Upstream commit 7c6dddc239abe660598c49ec95ea0ed6399a4b2a ]

The value of an arithmetic expression is subject
of possible overflow due to a failure to cast operands to a larger data
type before performing arithmetic. Used macro for multiplication instead
operator for avoiding overflow.

Found by Security Code and Linux Verification
Center (linuxtesting.org) with SVACE.

Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://lore.kernel.org/r/20230309174347.3515-1-korotkov.maxim.s@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 6bd18eb5137f4..2dd8ee4a6f75b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2864,7 +2864,7 @@ static int bnxt_get_nvram_directory(struct net_device *dev, u32 len, u8 *data)
 	if (rc)
 		return rc;
 
-	buflen = dir_entries * entry_length;
+	buflen = mul_u32_u32(dir_entries, entry_length);
 	buf = hwrm_req_dma_slice(bp, req, buflen, &dma_handle);
 	if (!buf) {
 		hwrm_req_drop(bp, req);
-- 
2.39.2

