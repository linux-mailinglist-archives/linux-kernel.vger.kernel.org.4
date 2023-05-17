Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B794E706C18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjEQPFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjEQPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:04:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9887EE7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30644c18072so607480f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684335831; x=1686927831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oipxQEZj91stE4t+lxud7GTslgXbD/udBSL61+uH1L8=;
        b=nYRCTEvOWhb0FzekCMnJ6+34uErlW9tdW8D7eUgNnDXRCvoUVAdioTe4bDYStyLbtZ
         +wOkz4pBqp/FKbfovlnRGHcbww4zHsdW1pobdsCTi7FymG/8pUeZAv4ix9bN6fTKR5K0
         yeoouszxWZdws1CxpHmjxNcnk9WQ5iIHC5Qms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335831; x=1686927831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oipxQEZj91stE4t+lxud7GTslgXbD/udBSL61+uH1L8=;
        b=Gx9noDoJncCDjnI2jPkT310rwAwaX0iUYQdKvP+lHzIZnptNn+lmq3G5TGdML5znoK
         kLkUFsGFnkCRGBB4ps6yIHXbW7573AjqVEvvv+pZqD3KVouWQ2Wp9AH8Rz1stTwurEjO
         SmPXagSA1YxDFXf7xBVxvbrBfBEKoPE2mkWuW+Okp8VxaEgF45x94d3q4RkACBMyYpHY
         L8ml1DzKEC45N85mjQJCQeaPP9dv0Qgj1njqh77Llv2PwDMwLCD17CzvQ/qVUvEnXBpn
         wk7/WHTXG96SIqlAu97x2Xp4Sjpyn6xRHZSn9EXAi2ft0nv6rPVgTJyJDNT0KGznHyb4
         3pIg==
X-Gm-Message-State: AC+VfDwyqt5I4Ni9s6X4GBSbBfMrAtywlz20xmfBKfhChLj7XT0izKZR
        DZzYxsPdKyzUI5eZ54mIy9VMePHe8nVHcD3tIH0=
X-Google-Smtp-Source: ACHHUZ4TlxSSHFz+e4rSAsGydvOiw2BlLkeaeXVAkr1EEg9gHoiubCodrjA6vz2o/fUYubTcNwOvcQ==
X-Received: by 2002:a5d:4cc9:0:b0:2fb:7099:6070 with SMTP id c9-20020a5d4cc9000000b002fb70996070mr866319wrt.47.1684335831152;
        Wed, 17 May 2023 08:03:51 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:e223:a0c2:d2c:c371])
        by smtp.gmail.com with ESMTPSA id e17-20020adffd11000000b003047ea78b42sm3038211wrr.43.2023.05.17.08.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:03:50 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Date:   Wed, 17 May 2023 17:03:19 +0200
Message-ID: <20230517150321.2890206-4-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230517150321.2890206-1-revest@chromium.org>
References: <20230517150321.2890206-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey pointed out that defining a prctl flag as an int is a footgun
because, under some circumstances, when used as a flag to prctl, it can
be casted to long with garbage upper bits which would result in
unexpected behaviors.

This patch changes the constant to a UL to eliminate these
possibilities.

Signed-off-by: Florent Revest <revest@chromium.org>
Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
---
 include/uapi/linux/prctl.h       | 2 +-
 tools/include/uapi/linux/prctl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index f23d9a16507f..6e9af6cbc950 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -283,7 +283,7 @@ struct prctl_mm_map {
 
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
-# define PR_MDWE_REFUSE_EXEC_GAIN	1
+# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
 
 #define PR_GET_MDWE			66
 
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 759b3f53e53f..6e6563e97fef 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -283,7 +283,7 @@ struct prctl_mm_map {
 
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
-# define PR_MDWE_REFUSE_EXEC_GAIN	1
+# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
 
 #define PR_GET_MDWE			66
 
-- 
2.40.1.606.ga4b1b128d6-goog

