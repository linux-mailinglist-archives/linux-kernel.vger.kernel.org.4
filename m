Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB0D638E33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKYQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKYQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:23:41 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708614A068
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=1Xj0qjpg+yYr8OjlhmKxIIj96tMZd7CEOEmBe02j11k=; b=6H
        bA3xg3vdbdYp5Yh9noPb0H6/F1luuPvfrxfMy4ClgzliniIhcPYhAgerJ5Oca2lP35GacrYuO+cWR
        q72o9ENIITLIzi6BDYVK7H1/murC2nK7UPBPWHS0+U25Gw6/sXiBtymyKt9nHp3FBc7ADRQdNRUqB
        exGE0V0YxmdVK9PUDQ7aX3gTnMlN3U3xBUSoLj9MQsLTm0Y1SEblvxjvQPBAzHyxHM4uKMrinRlfu
        8MrMyfi8u8R2XwvmDYQ3R4QHTm8XSJp5RPUrknnYMB96k3Zh1SciIZELkaTl0Msx7UQQltUvlT2vz
        W8izeRcwyXbWSq56Bn9DYD6rDY8RKIOg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oybUD-0002ir-Ud;
        Fri, 25 Nov 2022 16:23:34 +0000
From:   John Keeping <john@metanate.com>
To:     alsa-devel@alsa-project.org
Cc:     John Keeping <john@metanate.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcm: fix tracing reason in hw_ptr_error
Date:   Fri, 25 Nov 2022 16:23:26 +0000
Message-Id: <20221125162327.297440-1-john@metanate.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strings need to be specially marked in trace events to ensure the
content is captured, othewise the trace just shows the value of the
pointer.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/core/pcm_trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_trace.h b/sound/core/pcm_trace.h
index f18da2050772..350b40b906ca 100644
--- a/sound/core/pcm_trace.h
+++ b/sound/core/pcm_trace.h
@@ -88,19 +88,19 @@ TRACE_EVENT(hw_ptr_error,
 		__field( unsigned int, device )
 		__field( unsigned int, number )
 		__field( unsigned int, stream )
-		__field( const char *, reason )
+		__string( reason, why )
 	),
 	TP_fast_assign(
 		__entry->card = (substream)->pcm->card->number;
 		__entry->device = (substream)->pcm->device;
 		__entry->number = (substream)->number;
 		__entry->stream = (substream)->stream;
-		__entry->reason = (why);
+		__assign_str(reason, why);
 	),
 	TP_printk("pcmC%dD%d%s/sub%d: ERROR: %s",
 		  __entry->card, __entry->device,
 		  __entry->stream == SNDRV_PCM_STREAM_PLAYBACK ? "p" : "c",
-		  __entry->number, __entry->reason)
+		  __entry->number, __get_str(reason))
 );
 
 TRACE_EVENT(applptr,
-- 
2.38.1

