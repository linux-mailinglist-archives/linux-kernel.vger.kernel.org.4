Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFDA60B5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJXSeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiJXSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:33:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3763DED3B;
        Mon, 24 Oct 2022 10:15:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h9so6181905wrt.0;
        Mon, 24 Oct 2022 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcT81dsOX50qiaKz4vINoGth0qfnpFewSvnJVe0v6GM=;
        b=RD2hU3KoduxI2YfWHayb28ysUwpHbeEzDpkWXSRe1hQVBB7vI5HJkjAEOIp9GG2e7S
         Wb8q5wX5u3AoTjSl5a5sbj/7i5czN8IYwPyD7tCuhNgz9d6u4YJtwfNSYMSbwf3gEEaf
         /407NCLoWXbwhgNM/ZT9cIH+9qgVRjxEGcw0sNpl6mcjbTO7mnAA3pOMxDjLLRGjymV/
         DxX+D/Qf16djnAO0Cr5LUZLE3sUzs8Y4Tq8Xm44cc3n2Ws8abt1d2qWmvUey02whjXzQ
         Ct1pgHdNW6H2JeMtgJ8VSygtxcbi+fwPiy80AP5If1uw5PDmCDn76/gs4jErczN/c86b
         BOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcT81dsOX50qiaKz4vINoGth0qfnpFewSvnJVe0v6GM=;
        b=QGII1mYkhqYZEsjt0j+NFpiQJ5pC0y/n4rkPDvr81JvQhpdqBq9RaO2hvTddv6iHKR
         ao3uaNUmBVSCq6mGHjqF8mSX0cw1xGDIJB8nKRDkz/94yrDfkxq10V+cJcefB7nlJM76
         hpTPyN2DpMARYXzwkJ1CsO++Eprldpralnp0WroiMmODQ2LLMG8DDjnlx/nVbL7LONGQ
         aJ0IHXSYGBt2x3/MB/RYEWl9fsjmmmDiBCGlzoj8lvM13nMrbWRGKUpkLD666tw55tes
         NbFeDA9mCTcKUj1794as2+uM7WKCjRRXsEKJNEu3wBhkDhB20QcdruwRclC5EOF8zY8r
         k4sA==
X-Gm-Message-State: ACrzQf3/XbkwMxI3LWpmiCxPxIZ5xoafuDRxuexXJUhmvBI7BYLJLOFQ
        5QAYVbHfYkOcx/WTyoCxcIpwxGXuo0PHZg==
X-Google-Smtp-Source: AMsMyM5PWCQoY1oCIj0f9q6/UiAGZDAiFpyTTtXsShfeswh89X4+ely/gnqcv+fClVfORRlZZaNl6w==
X-Received: by 2002:a05:6000:1882:b0:230:9046:122 with SMTP id a2-20020a056000188200b0023090460122mr20371363wri.49.1666616657310;
        Mon, 24 Oct 2022 06:04:17 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f8-20020a0560001b0800b0023677fd2657sm1378422wrz.52.2022.10.24.06.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:04:16 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: rawmidi: remove variable dest_frames
Date:   Mon, 24 Oct 2022 14:04:15 +0100
Message-Id: <20221024130415.2155860-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable dest_frames is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/core/rawmidi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index d8edb6055072..7147fda66d93 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1050,7 +1050,6 @@ static int receive_with_tstamp_framing(struct snd_rawmidi_substream *substream,
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 	struct snd_rawmidi_framing_tstamp *dest_ptr;
 	struct snd_rawmidi_framing_tstamp frame = { .tv_sec = tstamp->tv_sec, .tv_nsec = tstamp->tv_nsec };
-	int dest_frames = 0;
 	int orig_count = src_count;
 	int frame_size = sizeof(struct snd_rawmidi_framing_tstamp);
 
@@ -1077,7 +1076,6 @@ static int receive_with_tstamp_framing(struct snd_rawmidi_substream *substream,
 		runtime->avail += frame_size;
 		runtime->hw_ptr += frame_size;
 		runtime->hw_ptr %= runtime->buffer_size;
-		dest_frames++;
 	}
 	return orig_count - src_count;
 }
-- 
2.37.3

