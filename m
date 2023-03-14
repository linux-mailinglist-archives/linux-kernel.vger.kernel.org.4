Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4DE6BA0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCNUjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCNUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:38:53 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC481F93F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:38:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cu4so9575220qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678826330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MbviwZ9aPtBhKMJt0xAhfvjag7IUKbs0D6Z8ztPm0A=;
        b=K6WH0ppsbhLixeO5XppGQbKYT/nj06c8vXj6egUJlelvVZiVbj2RnCABbHOnFbufSA
         j/inxQUvSTssPa/OqKhp3ThM0YHfk9RGWZDHtQ94Htu1ChQPm3i25gKackitSMNrA2QO
         tFoDXHoxztoqS7EqKAyM0iPavFf5RiqSvFPsDiyw4nvCoxwLgUn/rQPtE4YPygBgLPrH
         OLoeTuhfM622kR+zoaRbgEdPgdzurxdpA54iUovjmODgFnLE9RMtj8cywe4SN76GKzoa
         HcPp8YzFbrDDMUpHxMT9dUOVwI0170w0SJXbaxJi+lsXiPSPYiVCr/gFdk3+h3JalIHy
         VbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MbviwZ9aPtBhKMJt0xAhfvjag7IUKbs0D6Z8ztPm0A=;
        b=cAS4k8qELTYYJnErHRZ9gwX8pNC69T9oxfMXLVnWSUU/EJuhJ3anX0SoAIH1lZIxHl
         mihDVsJkAcf5n3bMjA5h9katm4UNfhlfbS92nD7aNMx+ciK9TOecqH5JApuVDL+G9rtj
         vacVdihr65j4MkqcbrmKDpiViJ2q4HCAW17fyD384Z3/J0KVvOuO05nWnUFgawsQM6t7
         RqP0MqcQuLF1K+r/ImHxmFGUFkfqzVypL945IltMW/Rp6OzzrxD/27V1eSZNpbIGPMhY
         fkQ2Fwacpfdxn6GJpP6wgoaMoOkNEwyJw8roiaAQlomMrwsqtarkJ1oY5GCk53FlcnYj
         0ECw==
X-Gm-Message-State: AO0yUKXfqDhT2GKXbIR2j0JgfLgsHmlIxbimSYPlWpGC2XTgWork0Pva
        yoKIV6mSNLrVFKDC87dE85DV8w==
X-Google-Smtp-Source: AK7set9bf/e1JH8gdyHh9aGSNWRMX9/fsVTmd+jjCa5ZqmWf7EJ0bxQLvrTRjdWUcaDIN9dLLr2ZZw==
X-Received: by 2002:a05:6214:1c88:b0:5a9:3882:f4c9 with SMTP id ib8-20020a0562141c8800b005a93882f4c9mr11540145qvb.5.1678826330626;
        Tue, 14 Mar 2023 13:38:50 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id c2-20020a379a02000000b00745ca1c0eb6sm1947828qke.2.2023.03.14.13.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:38:50 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 3/4] net: ipa: kill FILT_ROUT_CACHE_CFG IPA register
Date:   Tue, 14 Mar 2023 15:38:40 -0500
Message-Id: <20230314203841.1574172-4-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314203841.1574172-1-elder@linaro.org>
References: <20230314203841.1574172-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit defined a few IPA registers used for IPA v5.0+.
One of those was a mistake.  Although the filter and router caches
get *flushed* using a single register, they use distinct registers
(ENDP_FILTER_CACHE_CFG and ENDP_ROUTER_CACHE_CFG) for configuration.

And although there *exists* a FILT_ROUT_CACHE_CFG register, it is
not needed in upstream code.  So get rid of definitions related to
FILT_ROUT_CACHE_CFG, because they are not needed.

Fixes: de101ca79f97 ("net: ipa: define IPA v5.0+ registers")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_reg.c | 4 ++--
 drivers/net/ipa/ipa_reg.h | 9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
index 735fa65916097..463a31dfa9f47 100644
--- a/drivers/net/ipa/ipa_reg.c
+++ b/drivers/net/ipa/ipa_reg.c
@@ -39,7 +39,8 @@ static bool ipa_reg_id_valid(struct ipa *ipa, enum ipa_reg_id reg_id)
 		return version <= IPA_VERSION_3_1;
 
 	case ENDP_FILTER_ROUTER_HSH_CFG:
-		return version != IPA_VERSION_4_2;
+		return version < IPA_VERSION_5_0 &&
+			version != IPA_VERSION_4_2;
 
 	case IRQ_SUSPEND_EN:
 	case IRQ_SUSPEND_CLR:
@@ -52,7 +53,6 @@ static bool ipa_reg_id_valid(struct ipa *ipa, enum ipa_reg_id reg_id)
 	case QSB_MAX_WRITES:
 	case QSB_MAX_READS:
 	case FILT_ROUT_HASH_EN:
-	case FILT_ROUT_CACHE_CFG:
 	case FILT_ROUT_HASH_FLUSH:
 	case FILT_ROUT_CACHE_FLUSH:
 	case STATE_AGGR_ACTIVE:
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index 28aa1351dd488..ff2be8be0f683 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -61,7 +61,6 @@ enum ipa_reg_id {
 	QSB_MAX_WRITES,
 	QSB_MAX_READS,
 	FILT_ROUT_HASH_EN,				/* Not IPA v5.0+ */
-	FILT_ROUT_CACHE_CFG,				/* IPA v5.0+ */
 	FILT_ROUT_HASH_FLUSH,				/* Not IPA v5.0+ */
 	FILT_ROUT_CACHE_FLUSH,				/* IPA v5.0+ */
 	STATE_AGGR_ACTIVE,
@@ -206,14 +205,6 @@ enum ipa_reg_qsb_max_reads_field_id {
 	GEN_QMB_1_MAX_READS_BEATS,			/* IPA v4.0+ */
 };
 
-/* FILT_ROUT_CACHE_CFG register */
-enum ipa_reg_filt_rout_cache_cfg_field_id {
-	ROUTER_CACHE_EN,
-	FILTER_CACHE_EN,
-	LOW_PRI_HASH_HIT_DISABLE,
-	LRU_EVICTION_THRESHOLD,
-};
-
 /* FILT_ROUT_HASH_EN and FILT_ROUT_HASH_FLUSH registers */
 enum ipa_reg_filt_rout_hash_field_id {
 	IPV6_ROUTER_HASH,
-- 
2.34.1

