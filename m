Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F335703D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244931AbjEOTWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbjEOTWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FE7A270;
        Mon, 15 May 2023 12:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B1063173;
        Mon, 15 May 2023 19:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04484C433EF;
        Mon, 15 May 2023 19:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684178520;
        bh=dzKqueiaHaieX4+u+VL0PHmUBtkteWDdFF1DX61gWSE=;
        h=Date:From:To:Cc:Subject:From;
        b=V5k6DIgiH/dlVpUdsMUEr8rKPeg7MPaQ60Bo5vOUKYZ+ZhNZVVZxwVgNFWRs/PyE+
         815d/HlzGv/AsqhaZIJa+eAxpzJVczrik3YjSBNBB1Qbb9NVPwNSVncciDaxzO2TwU
         surfV1shNXy8mxM5ph3+IOaSCmxSitMoeuac9dfkikbLllgRvUbk+6tUX5zqPdORcu
         LlMQNu1uLuSmGgZLyVUi+SdoGBdLR8lqhmXduFSaF1gILEzT+xXDhO+TECAsoAfbns
         WtiGrJ5k//Onnyle/pkcsKyXmLb92tcE3hALUi5gGuEDdx+/LsDKvQcb1QidcxDP62
         jKNQHRzlQ67KA==
Date:   Mon, 15 May 2023 13:22:48 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     mlxsw@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] mlxfw: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <ZGKGiBxP0zHo6XSK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length arrays
declarations alone in structs with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for flexible-array members alone in structs.

Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/285
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2_format.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2_format.h b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2_format.h
index b001e5258091..47f6cc0401c3 100644
--- a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2_format.h
+++ b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2_format.h
@@ -44,7 +44,7 @@ MLXFW_MFA2_TLV(multi, struct mlxfw_mfa2_tlv_multi,
 	       MLXFW_MFA2_TLV_MULTI_PART);
 
 struct mlxfw_mfa2_tlv_psid {
-	u8 psid[0];
+	DECLARE_FLEX_ARRAY(u8, psid);
 } __packed;
 
 MLXFW_MFA2_TLV_VARSIZE(psid, struct mlxfw_mfa2_tlv_psid,
-- 
2.34.1

