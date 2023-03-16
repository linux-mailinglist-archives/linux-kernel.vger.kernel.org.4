Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07906BC359
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCPBdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCPBdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:33:14 -0400
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F0AD38;
        Wed, 15 Mar 2023 18:33:13 -0700 (PDT)
Received: by mail-pl1-f196.google.com with SMTP id i5so173927pla.2;
        Wed, 15 Mar 2023 18:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678930393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wr/Fzc5HFGOPjcLhGyD874SBWN1YYWXj06dZJbwaAIg=;
        b=289pyiRc73aR/m87IJ72w3bXnkGNNeGUUashg71HYPGgn1L5yWjX/QZW4jwNW/lD6+
         Hv/sJz1Q/Ccz4WAToqeG2abMsoiasAgUTc1YixbZj9pSIX4cV6jEwH7c9kCD7Vo9p+Yf
         PeaA9Xn/K938tkOOAVEvTM9VSNXvdcGTRxfugtvgA0Dtr7W5EVT0mPlEXUF90ZiWwBW+
         vbLcMnXUIlxy4o6JWFmJSgvCzT/6/9ztkSQe+BmWOhHTUiNXF92HRTop1mIPqoIoHmwl
         dyyJ5FxbKHuKN9KwPTHKFUDlKcfdZVcKia5VhBJOnx4naq9t0BeuJXh1hb1uwCm2is4u
         wKfg==
X-Gm-Message-State: AO0yUKUArT1Q+QntrPCYDslZNocfR/ZP70e4Kcjvu1TqXKRgA0vuXvdl
        y7g6MMrL5ybrP+b5sngk/Xnz9hfYAypfOg==
X-Google-Smtp-Source: AK7set/OV9D4WmMO24yP28dXGBgMZhAWq2rOLCHotiYAgVlaEFJqnqUxGxr/27C/aRKf8LF+QNVQMw==
X-Received: by 2002:a17:903:32ce:b0:1a0:67b1:a777 with SMTP id i14-20020a17090332ce00b001a067b1a777mr1627154plr.61.1678930392683;
        Wed, 15 Mar 2023 18:33:12 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b0019460ac7c6asm4226017ple.283.2023.03.15.18.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:33:12 -0700 (PDT)
From:   Xueqin Luo <luoxueqin@kylinos.cn>
To:     rafael@kernel.org, todd.e.brandt@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     luoxueqin@kylinos.cn, xiongxin@kylinos.cn
Subject: [PATCH v2] PM: tools: add "CPU killed" messages to fix an error in suspend flow
Date:   Thu, 16 Mar 2023 09:33:07 +0800
Message-Id: <20230316013307.322402-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the arm64 platform, the core log of cpu offline is as follows:

[  100.431501] CPU1: shutdown
[  100.454820] psci: CPU1 killed (polled 20 ms)
[  100.459266] CPU2: shutdown
[  100.482575] psci: CPU2 killed (polled 20 ms)
[  100.486057] CPU3: shutdown
[  100.513974] psci: CPU3 killed (polled 28 ms)
[  100.518068] CPU4: shutdown
[  100.541481] psci: CPU4 killed (polled 24 ms)

And this goal of this patch is to prevent sleepgraph from mistakenly
treating the "CPU up" message as part of the suspend flow (because it
should be regarded as part of the resume flow).

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---

v2: update changelog

 tools/power/pm-graph/sleepgraph.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 82c09cd25cc2..d816970b0a3d 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -4132,9 +4132,12 @@ def parseKernelLog(data):
 			elif(re.match('Enabling non-boot CPUs .*', msg)):
 				# start of first cpu resume
 				cpu_start = ktime
-			elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)):
+			elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)) \
+				or re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)):
 				# end of a cpu suspend, start of the next
 				m = re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)
+				if(not m):
+					m = re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)
 				cpu = 'CPU'+m.group('cpu')
 				if(cpu not in actions):
 					actions[cpu] = []
-- 
2.25.1

