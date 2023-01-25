Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B40C67BD42
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbjAYUqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbjAYUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:45:54 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13C527E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:45:53 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id b15so8231ils.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjjPa5eXz2MKX1ckJw/qBJ/DxwniIRJxEckC8kdtjaw=;
        b=Q4IFVqmH0X1HduLYAg4tXY0n8p80rTfmieraR4ARmeEp93dT1VZIYMwlx7O3gE4Z54
         v+dOguu1HJLsb2lr+0ptPwUoMKII7+OOSEWRWsqc+E7IKEv0GeZaTvBDI/1b+PLy2OsU
         Q6yrvmQBbCpwCXlAJ8+GwiBLJURSI1pE3nNBY+k8j81/5Vr9csvqLFMA9aoSJDiqrafW
         R3NfyoiAdz6rkEb+yJBbTuagKzcHh+FJo88qrDst5g4vkFtsXUR3bL+RNXaLiBDLQuWR
         /D0TSe1okjwNNWfpJEnspOyYTuIb5jyBLYEUrXhqD1MWOfE6cqo2wQPlRxyPzDzzUOdm
         YMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjjPa5eXz2MKX1ckJw/qBJ/DxwniIRJxEckC8kdtjaw=;
        b=cAq9u1KlsPN0wjSjNua3QO2CxTi3G6aEfw3O5scD6+Ffamsk5Me2kfi+hbgD/Wn9Gk
         N7TV6rMuGhzfiNnLhyDIYUu6y3+Guyr1KXHq+tWGq0aJvFv2uZwctPvOuzCyIw+U6ion
         SBfcL0+5XXUHsClge5HFxqRqCd3/lW2kPq9iANWvDmn4uK3gf56rrfjIfc/3L7FrBhQa
         7ke2sdq1VkURDQlGKXGOo+KgcQvPtIavnkMN4dsPPUCDNciCU3VssyRZZpafqmiqtBC7
         XQo55VmNdir9vhf6OfGkC5DshJ3czseFDroOmc1b2CkkzcGUqARHnn6dR5uLwVovFyTW
         2Ysg==
X-Gm-Message-State: AO0yUKUbOcORNg15wpiv7TaDVqAV4dtwrjcCm/UwvBvvwBpDSlW5AhEj
        5ftyvGRUYU7QJCzxLUisFQPTJw==
X-Google-Smtp-Source: AK7set8rj6rUV2/lsvjOLQ6lKi2esQROazXF2atha5xsx5FuBP+pm7BXEwXjUCW5Ue2fGNMhWsbWdw==
X-Received: by 2002:a05:6e02:1c02:b0:310:a195:5cb with SMTP id l2-20020a056e021c0200b00310a19505cbmr2873468ilh.17.1674679552653;
        Wed, 25 Jan 2023 12:45:52 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id w14-20020a02968e000000b00389c2fe0f9dsm1960696jai.85.2023.01.25.12.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:45:52 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/8] net: ipa: define all IPA status mask bits
Date:   Wed, 25 Jan 2023 14:45:40 -0600
Message-Id: <20230125204545.3788155-4-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125204545.3788155-1-elder@linaro.org>
References: <20230125204545.3788155-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a 16 bit status mask defined in the IPA packet status
structure, of which only one (TAG_VALID) is currently used.

Define all other IPA status mask values in an enumerated type whose
numeric values are bit mask values (in CPU byte order) in the status
mask.  Use the TAG_VALID value from that type rather than defining a
separate field mask.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index dd4b2b073aae9..5cf3ac2b5c85a 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -48,11 +48,31 @@ enum ipa_status_exception {
 	IPA_STATUS_EXCEPTION_DEAGGR		= 0x01,
 };
 
+/** enum ipa_status_mask - IPA status mask field bitmask hardware values */
+enum ipa_status_mask {
+	IPA_STATUS_MASK_FRAG_PROCESS		= BIT(0),
+	IPA_STATUS_MASK_FILT_PROCESS		= BIT(1),
+	IPA_STATUS_MASK_NAT_PROCESS		= BIT(2),
+	IPA_STATUS_MASK_ROUTE_PROCESS		= BIT(3),
+	IPA_STATUS_MASK_TAG_VALID		= BIT(4),
+	IPA_STATUS_MASK_FRAGMENT		= BIT(5),
+	IPA_STATUS_MASK_FIRST_FRAGMENT		= BIT(6),
+	IPA_STATUS_MASK_V4			= BIT(7),
+	IPA_STATUS_MASK_CKSUM_PROCESS		= BIT(8),
+	IPA_STATUS_MASK_AGGR_PROCESS		= BIT(9),
+	IPA_STATUS_MASK_DEST_EOT		= BIT(10),
+	IPA_STATUS_MASK_DEAGGR_PROCESS		= BIT(11),
+	IPA_STATUS_MASK_DEAGG_FIRST		= BIT(12),
+	IPA_STATUS_MASK_SRC_EOT			= BIT(13),
+	IPA_STATUS_MASK_PREV_EOT		= BIT(14),
+	IPA_STATUS_MASK_BYTE_LIMIT		= BIT(15),
+};
+
 /* Status element provided by hardware */
 struct ipa_status {
 	u8 opcode;		/* enum ipa_status_opcode */
 	u8 exception;		/* enum ipa_status_exception */
-	__le16 mask;
+	__le16 mask;		/* enum ipa_status_bit (bitmask) */
 	__le16 pkt_len;
 	u8 endp_src_idx;
 	u8 endp_dst_idx;
@@ -64,7 +84,6 @@ struct ipa_status {
 };
 
 /* Field masks for struct ipa_status structure fields */
-#define IPA_STATUS_MASK_TAG_VALID_FMASK		GENMASK(4, 4)
 #define IPA_STATUS_SRC_IDX_FMASK		GENMASK(4, 0)
 #define IPA_STATUS_DST_IDX_FMASK		GENMASK(4, 0)
 #define IPA_STATUS_FLAGS1_RT_RULE_ID_FMASK	GENMASK(31, 22)
@@ -1344,7 +1363,7 @@ static bool ipa_endpoint_status_tag(struct ipa_endpoint *endpoint,
 	struct ipa *ipa = endpoint->ipa;
 	u32 endpoint_id;
 
-	if (!le16_get_bits(status->mask, IPA_STATUS_MASK_TAG_VALID_FMASK))
+	if (!le16_get_bits(status->mask, IPA_STATUS_MASK_TAG_VALID))
 		return false;	/* No valid tag */
 
 	/* The status contains a valid tag.  We know the packet was sent to
-- 
2.34.1

