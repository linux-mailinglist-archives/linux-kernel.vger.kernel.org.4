Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC8681C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjA3VD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjA3VD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:03:27 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753FD14217
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:03:20 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id u7so4174110ilg.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOMLzNh0yK/0qTgNUqpARcKHC/PDBTSkI4Jf9pY8gkc=;
        b=Am8GWon3yO+XZpbh2vH4WXuITnbyYP6+zqEC6IYJV5Zo8ApLD4K4QnCyfwph0c2GeP
         iVYFTxNcTH9ds5rT8rxSGn+xgS4FFh0VlIiT1ZzKo8EUq7t29YQQU6IzgURvR3uxYNyK
         YOInMA9M9a8FUWOIWkGQg3zDfEwEWVY4hpTTWwtOlfwBFY3bwNbttozjR7KAReXREqW5
         0KshzktYoMfi4dqMUZKMngEG3/v/c+0MTVQxuJLGEVC551B6nAzW6w1ZeupF92sIkned
         qtggfxDLkRdxj7r2vtddlmIgHYRGT3jj8gQ2sT05Hj9yUGrQFW2EUG7KF/2eFCMlHbdX
         IP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOMLzNh0yK/0qTgNUqpARcKHC/PDBTSkI4Jf9pY8gkc=;
        b=Iy8MTo/9YN5QSbEbgXDHE/oYn5S1cJqkqhWEv/X3FJWkzKIO1CmJpxEV2LduZrLKDw
         oU+wazYJdkLkwivDDVnbqNs8So9LlC7Y4A+y79YAYD3yJ8LKyIswz98F0jVoDelu94mD
         89YsARIycRQBuN8RAeVqdRtUY8na/Q99yoG1GyzogTM1ceDFKqsvTRu0AYLXbGymjVGP
         ode+OEDDgYzbO/Ls/33jrpBrbysJ4oRV6qbgA/UNHZ79JAUbzFyRvO/evtncJhMAJyXc
         nvZvDExDbE8Smkel5X7MDEaXDErg4+ptGKUJX97I93QdZAj4X9e+OOoJxUecEJrx6Npp
         zUfQ==
X-Gm-Message-State: AO0yUKUZitdy3vQK3Y0N3p2U9MiC51vm+Jntj5Qthzld/mXU+98Pqav4
        /GKch7bSijUZO6IQBbxDjGi88Q==
X-Google-Smtp-Source: AK7set87Oiqf2yVURDq65Vgtj7g6BYcFlvHTkqi6hILl58lH3403noiOUroQUBwzZr/riR7osXHz9w==
X-Received: by 2002:a05:6e02:1aa2:b0:310:cc76:5c9d with SMTP id l2-20020a056e021aa200b00310cc765c9dmr11970789ilv.28.1675112599598;
        Mon, 30 Jan 2023 13:03:19 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id a30-20020a02735e000000b003aef8fded9asm1992046jae.127.2023.01.30.13.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:03:12 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/8] net: ipa: extend endpoints in packet init command
Date:   Mon, 30 Jan 2023 15:01:52 -0600
Message-Id: <20230130210158.4126129-3-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130210158.4126129-1-elder@linaro.org>
References: <20230130210158.4126129-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP_PACKET_INIT immediate command defines the destination
endpoint to which a packet should be sent.  Prior to IPA v5.0, a
5 bit field in that command represents the endpoint, but starting
with IPA v5.0, the field is extended to 8 bits to support more than
32 endpoints.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_cmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index aa2b594ca5067..5d3a875e50fee 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -94,11 +94,11 @@ struct ipa_cmd_register_write {
 /* IPA_CMD_IP_PACKET_INIT */
 
 struct ipa_cmd_ip_packet_init {
-	u8 dest_endpoint;
+	u8 dest_endpoint;	/* Full 8 bits used for IPA v5.0+ */
 	u8 reserved[7];
 };
 
-/* Field masks for ipa_cmd_ip_packet_init dest_endpoint field */
+/* Field mask for ipa_cmd_ip_packet_init dest_endpoint field (unused v5.0+) */
 #define IPA_PACKET_INIT_DEST_ENDPOINT_FMASK		GENMASK(4, 0)
 
 /* IPA_CMD_DMA_SHARED_MEM */
@@ -491,8 +491,13 @@ static void ipa_cmd_ip_packet_init_add(struct gsi_trans *trans, u8 endpoint_id)
 	cmd_payload = ipa_cmd_payload_alloc(ipa, &payload_addr);
 	payload = &cmd_payload->ip_packet_init;
 
-	payload->dest_endpoint = u8_encode_bits(endpoint_id,
-					IPA_PACKET_INIT_DEST_ENDPOINT_FMASK);
+	if (ipa->version < IPA_VERSION_5_0) {
+		payload->dest_endpoint =
+			u8_encode_bits(endpoint_id,
+				       IPA_PACKET_INIT_DEST_ENDPOINT_FMASK);
+	} else {
+		payload->dest_endpoint = endpoint_id;
+	}
 
 	gsi_trans_cmd_add(trans, payload, sizeof(*payload), payload_addr,
 			  opcode);
-- 
2.34.1

