Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34466A021E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjBWEqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjBWEp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:45:56 -0500
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924941B562;
        Wed, 22 Feb 2023 20:45:55 -0800 (PST)
Received: by mail-pl1-f193.google.com with SMTP id e5so12496859plg.8;
        Wed, 22 Feb 2023 20:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DprxN7O14xjPIePWpRkm0bD78pGEpcOS4w+9+vyIqHo=;
        b=OfVjDQWIdlcrnO8w7K+iBH25FuOrXnfYq2+WT4Dj3DFf6rkQQEZB3dWhSQQc+GVOxt
         mBkQ/B9s4FPGEHMA6Nx6QVPmIvjfvmfZSFbyqYlduZx7D5XnGvla0JEegv8m/EeC8OR1
         xdyywYrq0OvzZVnddR7SgXF4LrYEFmwiCe9Q+ymylkIdRn37XBh5MASjQa6dVIX5KpBW
         92N0x2reWSlHOjlM69vwncUT9qaKPwn95pVGM+kNq95ekTA9H/GzKISZ23bvbJXh1oxg
         inY5wx0mYL92NjB3FdMHdXrFFueqtO1T21sIPjkddWj1XF91Yx1EWdB+9e+3nbVqDe8a
         JHLw==
X-Gm-Message-State: AO0yUKWv2Dw0nId4XD0kbFYswaHkQeHsTk2LFlp8vRZCCrzV6aicg6cp
        PQ+yWnglseGws5V/6/tYPv8f09TPpn7urfDB
X-Google-Smtp-Source: AK7set/yZ9WqKfIoJ/60JFqVq8kMpo1svcmV2bkETxPzTOumJrgwGfp4QnIvqnz21i2lsUc7Vvl+mQ==
X-Received: by 2002:a05:6a20:8e05:b0:bf:269e:9644 with SMTP id y5-20020a056a208e0500b000bf269e9644mr12817764pzj.45.1677127554942;
        Wed, 22 Feb 2023 20:45:54 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b005d3901948d8sm2507402pfh.44.2023.02.22.20.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:45:54 -0800 (PST)
From:   Xueqin Luo <luoxueqin@kylinos.cn>
To:     todd.e.brandt@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH -next] PM: tools: add "CPU killed" timeline on arm64 platform
Date:   Thu, 23 Feb 2023 12:45:50 +0800
Message-Id: <20230223044550.339811-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
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

'smpboot: CPU (?P<cpu>[0-9]*) is now offline' cannot be applied
to the arm64 platform, which caused the loss of the suspend
machine stage in S3. Here I added core code to fix this issue.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
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

