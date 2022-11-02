Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDC4617078
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiKBWLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiKBWLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:11:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485AA6179
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 15:11:45 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o65so16238841iof.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 15:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4nuwgGkQOaib3BwT5hOD0oPhyITqBv+siRpxH4LVLA=;
        b=QWAql5sruNOYapQ8D3iedsH3hR0D8NvgG5miWD7mQ2egdNW9qeymNJSEPbNeqX8rtt
         PnEoUfiE2PNslqNekLVwrC7U3xCPwCeTTcCA4dlwffSIPNJSlWLtDj1Y84nf6kauIZ7c
         HzYyXPIiJ7ZTGRMmVnGVBwc/X/mIGvBlCy39CU0WVYa7PndE/GrfDU3ln3aSO/N6lpNR
         y2rzM8Pkpk0EbIO6LcEkqCcZWBWaO2lhhw6b9FVTMnQ/EphPsPTKhcOrH68qOQHwAmjG
         7OkSn79SVka13cLXQrBGRXoHJCrnoLJjoTW2hwLna/uqV0gAS45MOFG9VjcQtcMzW3xx
         CNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4nuwgGkQOaib3BwT5hOD0oPhyITqBv+siRpxH4LVLA=;
        b=gCjNlvdDBx7eBcZs6hySBE1bstZ1hulu7nUVZfMSqTR3r7rlmAaKeP+IbG3U27UNQJ
         OWCEf+bkwicacJX2UenPPTVbDUY5L3z2avvz2zH7BCUTrNitpdBicgj9uGciaU3eP4dx
         jEtaTbIKYEbdL54Z5BoKXt2BKOD/O+uisOrvebMpa33ZmuNw/xl8fEFAW87G2UHPTAmG
         dHwyzTvekD3shK6+DjYqrfEBNZ9wzuxp3mzB4/6NQhqDYBwWmdl53CEZRQYFer24cRjf
         D2UutROPquliqBathGA0lvqubtI59EX/WSzFRJh0GhBAzBF4pLxQUbezRVnQfGJruP6W
         E6OQ==
X-Gm-Message-State: ACrzQf1e+rja2N0Q7hZxalLApAHpDmNwe9bbiumcRH57A0+Wp5Sz1tbX
        X8KSV/SNm+YF6HGQpowiki97yQ==
X-Google-Smtp-Source: AMsMyM7FJU56e1gpPyVNrFfjvVxKPEZim8DHPH4XiYspfzma0k5BkqJ313w6+XHhnHkPzukAzOJduA==
X-Received: by 2002:a05:6602:3420:b0:6ce:3066:181a with SMTP id n32-20020a056602342000b006ce3066181amr13433619ioz.98.1667427104655;
        Wed, 02 Nov 2022 15:11:44 -0700 (PDT)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id f8-20020a02a108000000b0037465a1dd3fsm5073974jag.156.2022.11.02.15.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:11:44 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, andersson@kernel.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/9] net: ipa: reduce arguments to ipa_table_init_add()
Date:   Wed,  2 Nov 2022 17:11:31 -0500
Message-Id: <20221102221139.1091510-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102221139.1091510-1-elder@linaro.org>
References: <20221102221139.1091510-1-elder@linaro.org>
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

Recently ipa_table_mem() was added as a way to look up one of 8
possible memory regions by indicating whether it was a filter or
route table, hashed or not, and IPv6 or not.

We can simplify the interface to ipa_table_init_add() by passing two
flags to it instead of the opcode and both hashed and non-hashed
memory region IDs.  The "filter" and "ipv6" flags are sufficient to
determine the opcode to use, and with ipa_table_mem() can look up
the correct memory region as well.

It's possible to not have hashed tables, but we already verify the
number of entries in a filter or routing table is nonzero.  Stop
assuming a hashed table entry exists in ipa_table_init_add().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index cf3a3de239dc3..94bb7611e574b 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -376,14 +376,12 @@ int ipa_table_hash_flush(struct ipa *ipa)
 	return 0;
 }
 
-static void ipa_table_init_add(struct gsi_trans *trans, bool filter,
-			       enum ipa_cmd_opcode opcode,
-			       enum ipa_mem_id mem_id,
-			       enum ipa_mem_id hash_mem_id)
+static void ipa_table_init_add(struct gsi_trans *trans, bool filter, bool ipv6)
 {
 	struct ipa *ipa = container_of(trans->gsi, struct ipa, gsi);
-	const struct ipa_mem *hash_mem = ipa_mem_find(ipa, hash_mem_id);
-	const struct ipa_mem *mem = ipa_mem_find(ipa, mem_id);
+	const struct ipa_mem *hash_mem;
+	enum ipa_cmd_opcode opcode;
+	const struct ipa_mem *mem;
 	dma_addr_t hash_addr;
 	dma_addr_t addr;
 	u32 zero_offset;
@@ -393,6 +391,14 @@ static void ipa_table_init_add(struct gsi_trans *trans, bool filter,
 	u16 count;
 	u16 size;
 
+	opcode = filter ? ipv6 ? IPA_CMD_IP_V6_FILTER_INIT
+			       : IPA_CMD_IP_V4_FILTER_INIT
+			: ipv6 ? IPA_CMD_IP_V6_ROUTING_INIT
+			       : IPA_CMD_IP_V4_ROUTING_INIT;
+
+	mem = ipa_table_mem(ipa, filter, false, ipv6);
+	hash_mem = ipa_table_mem(ipa, filter, true, ipv6);
+
 	/* Compute the number of table entries to initialize */
 	if (filter) {
 		/* The number of filtering endpoints determines number of
@@ -401,13 +407,13 @@ static void ipa_table_init_add(struct gsi_trans *trans, bool filter,
 		 * table is either the same as the non-hashed one, or zero.
 		 */
 		count = 1 + hweight32(ipa->filter_map);
-		hash_count = hash_mem->size ? count : 0;
+		hash_count = hash_mem && hash_mem->size ? count : 0;
 	} else {
 		/* The size of a route table region determines the number
 		 * of entries it has.
 		 */
 		count = mem->size / sizeof(__le64);
-		hash_count = hash_mem->size / sizeof(__le64);
+		hash_count = hash_mem && hash_mem->size / sizeof(__le64);
 	}
 	size = count * sizeof(__le64);
 	hash_size = hash_count * sizeof(__le64);
@@ -458,17 +464,10 @@ int ipa_table_setup(struct ipa *ipa)
 		return -EBUSY;
 	}
 
-	ipa_table_init_add(trans, false, IPA_CMD_IP_V4_ROUTING_INIT,
-			   IPA_MEM_V4_ROUTE, IPA_MEM_V4_ROUTE_HASHED);
-
-	ipa_table_init_add(trans, false, IPA_CMD_IP_V6_ROUTING_INIT,
-			   IPA_MEM_V6_ROUTE, IPA_MEM_V6_ROUTE_HASHED);
-
-	ipa_table_init_add(trans, true, IPA_CMD_IP_V4_FILTER_INIT,
-			   IPA_MEM_V4_FILTER, IPA_MEM_V4_FILTER_HASHED);
-
-	ipa_table_init_add(trans, true, IPA_CMD_IP_V6_FILTER_INIT,
-			   IPA_MEM_V6_FILTER, IPA_MEM_V6_FILTER_HASHED);
+	ipa_table_init_add(trans, false, false);
+	ipa_table_init_add(trans, false, true);
+	ipa_table_init_add(trans, true, false);
+	ipa_table_init_add(trans, true, true);
 
 	gsi_trans_commit_wait(trans);
 
-- 
2.34.1

