Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF4746156
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjGCRWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjGCRWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:22:47 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F76E60;
        Mon,  3 Jul 2023 10:22:43 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-777a6ebb542so183473939f.0;
        Mon, 03 Jul 2023 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688404962; x=1690996962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnKwwBMUflpvArQ9dgNRUkrt++2jq7wbS1H/2FICAXE=;
        b=gS57i0sYM8MpwaJcA9vfG5DIl4TCd5/sGeypkK2nA9HNLeX3cUJA8b9dI1EUWE0q3K
         A4Nsotm5LWTJB5OcIXzQOSTqaICubkOnvulplKJ2VKgRU4jom151lbzidTnhEpnwxjGb
         agrEWg3pfLAFCAA3cT1lGYP4AKdnSajm7ezIDPAk/6mhi1/yb/5iU18k6N5L6vvxeitd
         oJKN1AlD3dIQPPo9EeMUMuoWpIGI2JWSNCmHkQfWqHseWADCbKlmtH/zAXnUZzLS6cCh
         j9SEo1dF9Pjs5qj8/QwRC1ViOdxqxjytL0Dw2pR/3Zw/+Eg9c0rucACdrGp8ca6hK3to
         N2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404962; x=1690996962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnKwwBMUflpvArQ9dgNRUkrt++2jq7wbS1H/2FICAXE=;
        b=N7MiQnq7MSGxB84/Mo1624eM/qCY4rnwtKfr7SlhtNPM1Xi72Ytz+d5wwA4UAS9p/u
         WJJ3FcPHtFkq5hv0qk9s8vPgWZPka+dknZLmpiISGqHQ6HElhQRo1ZaxYubDKZCHxI21
         0e2ydMvNOkhqIHchhgsTRrf64zj0zvex01yxhHN4JbLJP/fqx8/WRon64yQfQqRCxM/L
         we0WP/4bvTGt8141R/menPWmnQMaQfZl3/zxCQu428u1HBrddNTijQ2uUvCGJgJT8lQk
         uup/AkCDn/GyROxDBbYOq+mqjBvEAcXScJ8M5czWDNWHIJy1fDy+pufJt2xRZTlmzNoQ
         Nk0w==
X-Gm-Message-State: AC+VfDxlD1NCq9qLA0gfPcbuFB+10cS60OZZLXzkUrtBhCXpz7muJLUt
        oqMpqPTU0zpDQcXM2Q0SF6M=
X-Google-Smtp-Source: ACHHUZ6XJi0K1PCW7k+QpZdwdcS6iMy4VV6gsMtUim2gW+bPLuVVGHN14vOsYfMttAOkK1skD74aNQ==
X-Received: by 2002:a5e:c64c:0:b0:784:314f:8d5b with SMTP id s12-20020a5ec64c000000b00784314f8d5bmr11030969ioo.11.1688404962269;
        Mon, 03 Jul 2023 10:22:42 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id ed22-20020a056638291600b0042b3e2e5ca1sm1033860jab.122.2023.07.03.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:22:42 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] blk-wbt: Replace strlcpy with strscpy
Date:   Mon,  3 Jul 2023 17:21:59 +0000
Message-ID: <20230703172159.3668349-3-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
References: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 include/trace/events/wbt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 9c66e59d859c..4661f0d27062 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -33,7 +33,7 @@ TRACE_EVENT(wbt_stat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		strscpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->rmean		= stat[0].mean;
 		__entry->rmin		= stat[0].min;
@@ -68,7 +68,7 @@ TRACE_EVENT(wbt_lat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		strscpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->lat = div_u64(lat, 1000);
 	),
@@ -105,7 +105,7 @@ TRACE_EVENT(wbt_step,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		strscpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->msg	= msg;
 		__entry->step	= step;
@@ -141,7 +141,7 @@ TRACE_EVENT(wbt_timer,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		strscpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->status		= status;
 		__entry->step		= step;
-- 
2.41.0.255.g8b1d071c50-goog

