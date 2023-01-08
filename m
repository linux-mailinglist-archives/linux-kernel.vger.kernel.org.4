Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D603661499
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 11:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjAHKum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 05:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAHKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 05:50:40 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD8A1208F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 02:50:39 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so8675238lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 02:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqcFZHij4zwbI6pLct7xw2FGomCWZuw6fe7LHJp/R+A=;
        b=Pf/GLhx5GbNWdUXv9lIYFFhtJ2l7GLTTmB0RpduVzy3GwFsvrMVsrL63XxL+srnswK
         Cm2YX1vm7txzzhWut60mVSs9nVIPsQ0KOF0qR9YDnpMzKrnjRUq3fqB70EVCqH+MEpAt
         tWhskIabuvMS9/dGyEN9Huf1xXjtOK3HcxbEylggCWxRNUcQl0hDHGJETIp9oXN60dyW
         042XzvCGXC2H8vBGV/bM7G7IHm2hGbh31LMiyfZLwmbx8oF3PrTQIZAuN5kAXcMvtO+/
         MCZBcB/X14eyEQK7dmFf0NNDT5it354MfW/WCj9eINHitTfQQIMz/Tg4P8y8o9Qd8cLl
         8rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqcFZHij4zwbI6pLct7xw2FGomCWZuw6fe7LHJp/R+A=;
        b=Pl9IFN0/er5b0ph8HUw2Hm4k/xCiGjyZmJOZFLaGdaDYAyoswOPfEyR5Mc3j0R/CZ8
         XXQVK9DTs9LvxxIBvaLRs6LQKACuQvSX/7GfNlfSk0vdNg3V6PZ9mCfbQkuV/H17Sbvf
         ZIuNri8RARQKW8wgVs49JmX2qylXVfjeGQep9La+ddHhR1lv32g88nVVhPnEjtu+JeQ2
         8/ug2l8E/OjaIlfYhAk+WXWx+xK8cRK18mAgbz1SifKUnYdda1OhiM/FP7yjNyz7klMM
         H1AcQzaP0AMLjFjOHI8reTzPW3ZmAk5bQZF8m3YWo7zMGqBp6wD2xHW3zqln+qJtRyvE
         Fhgg==
X-Gm-Message-State: AFqh2krdrtRXHMh4KbG6eubLS05YkkS+L+tU8GuAd0wxq8czA6xgmCY/
        yaVAv0Dmc4P/OUpJtxXwyNtw7xWc4MkjOHgx
X-Google-Smtp-Source: AMrXdXtEdElUHehfbPWk2rwhoxrCSVtSoIiuqtDYJV14T7X7CVQBcudCHaxjstAUd90Sw2D8BB7O5g==
X-Received: by 2002:ac2:5f46:0:b0:4c2:7049:5fae with SMTP id 6-20020ac25f46000000b004c270495faemr14802504lfz.20.1673175037245;
        Sun, 08 Jan 2023 02:50:37 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.10])
        by smtp.gmail.com with ESMTPSA id o4-20020ac25e24000000b004cb35d88265sm997725lfg.216.2023.01.08.02.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 02:50:36 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, roman.gushchin@linux.dev,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH] tools:cgroup:memcg_shrinker remove redundant import
Date:   Sun,  8 Jan 2023 15:50:23 +0500
Message-Id: <20230108105023.4289-1-apantykhin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Remove redundant import of the sys module.

Also use the sort function  instead of sorted.
It sorts the direct array without create the new one in memory.

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 tools/cgroup/memcg_shrinker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/cgroup/memcg_shrinker.py b/tools/cgroup/memcg_shrinker.py
index 706ab27666a4..e81c3017ada9 100644
--- a/tools/cgroup/memcg_shrinker.py
+++ b/tools/cgroup/memcg_shrinker.py
@@ -5,7 +5,6 @@
 
 import os
 import argparse
-import sys
 
 
 def scan_cgroups(cgroup_root):
@@ -44,7 +43,7 @@ def main():
 
     cgroups = scan_cgroups("/sys/fs/cgroup/")
     shrinkers = scan_shrinkers("/sys/kernel/debug/shrinker/")
-    shrinkers = sorted(shrinkers, reverse = True, key = lambda x: x[0])
+    shrinkers.sort(reverse = True, key = lambda x: x[0])
 
     n = 0
     for s in shrinkers:
-- 
2.25.1

