Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACAD64BA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiLMRHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiLMRHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:07:40 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BE4C35
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:07:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so4220744pje.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SqyBXZt6rhori4MA2ij9SbaGXQsLFds4Gdndt7QvNaI=;
        b=AyBpxBjzyuO04zfxrUxnx9S3B71FqrvcptMlB1Q/VeuihsEF71fRUUwqBgKRzNKj23
         frlR80l7W4azG2pfjQFFertgU38xWKeIWX1oybsEtaL8Eu1LXTu8VKD9FdVFZMFsj70j
         TULmRY0BYCfoNwxrQ6cjKBBpWGqPrf8/xwP7vZhWswFdHrWLeGe2nPvXFYj4hdtnIQvk
         b8BqTudtZBdEsNW6Yr7Y4jhvJeXHSYtSLhgIkbtc4KgmGi/NqpuWYl6Xfl5ixjhboIVR
         FigW5Nr7Oo6sdaxIC/eHQqjvposWyNTZbIsb9nEq9s9zxotdECu8CJ0bp5Ca1SnNf+yq
         wEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqyBXZt6rhori4MA2ij9SbaGXQsLFds4Gdndt7QvNaI=;
        b=rUnRadZDN/pB3U0sN75+BPrZXkILE/oClVjO4wcjuSYUDXJAxE2od2j58q4WZ8wFN0
         /RBshezCX5U7SN+XY6wWoBALgQuBrfjbw1dNn29VhK28oO7TtymTrcFgi1nWST/SW8p0
         Tm1aZYX4oVJ2jdDcPUi5Fzo4FzlX7BjmX1YWJE91ICY5CLG7VXJzD3eW94GSx/3E5w7d
         1m1Dl1OVje0LuRhOFS7cqbK09Ji3zS86Ngr/FpAB8o6lNEqNrizF6U8tF+do3xlzgkMi
         YRfP9n3Uc3oLIl3ddmtMyDRyVm7P+f4ZyQCC1qDD0I5exFIoVbnwD0YsP34zCdeAck5g
         C7xA==
X-Gm-Message-State: ANoB5pnyzElHSIrOX1y/Frt1kJdMSoXIB3zNKrnoB06VmdcCQ3LDIRYY
        hvtv+i/j9NGpZv0U2qE/eR5DacXrgUI=
X-Google-Smtp-Source: AA0mqf4HhfAKRvKIIuvM5Gy8W3p4dFRIT8+3ATOkjqTyrTtD6yJEIchufCvby9KTBdIIDlnvygeOpQ==
X-Received: by 2002:a17:902:9a43:b0:187:16c2:d52c with SMTP id x3-20020a1709029a4300b0018716c2d52cmr19564005plv.50.1670951258425;
        Tue, 13 Dec 2022 09:07:38 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:f1b7:8795:1cd1:4eed])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b00176ab6a0d5fsm159108plg.54.2022.12.13.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:07:38 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] MAINTAINERS: zram: zsmalloc: Add an additional co-maintainer
Date:   Tue, 13 Dec 2022 09:07:31 -0800
Message-Id: <20221213170731.796121-1-minchan@kernel.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move Sergey to co-maintainer for zram/zsmalloc since he has helped
to contribute/review those areas actively for eight years, which
is quite helpful. Since Nitin has been inactive for several years,
it's time to move his name into CREDITS.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 6 ++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index 198f675c419e..4e302a459ddf 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1439,6 +1439,10 @@ N: Justin Guyett
 E: jguyett@andrew.cmu.edu
 D: via-rhine net driver hacking
 
+N: Nitin Gupta
+E: ngupta@vflare.org
+D: zsmalloc memory allocator and zram block device driver
+
 N: Danny ter Haar
 E: dth@cistron.nl
 D: /proc/cpuinfo, reboot on panic , kernel pre-patch tester ;)
diff --git a/MAINTAINERS b/MAINTAINERS
index 3274b6db8be9..65c5aafb128a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23068,8 +23068,7 @@ F:	drivers/media/pci/zoran/
 
 ZRAM COMPRESSED RAM BLOCK DEVICE DRVIER
 M:	Minchan Kim <minchan@kernel.org>
-M:	Nitin Gupta <ngupta@vflare.org>
-R:	Sergey Senozhatsky <senozhatsky@chromium.org>
+M:	Sergey Senozhatsky <senozhatsky@chromium.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/blockdev/zram.rst
@@ -23082,8 +23081,7 @@ F:	drivers/tty/serial/zs.*
 
 ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR
 M:	Minchan Kim <minchan@kernel.org>
-M:	Nitin Gupta <ngupta@vflare.org>
-R:	Sergey Senozhatsky <senozhatsky@chromium.org>
+M:	Sergey Senozhatsky <senozhatsky@chromium.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/mm/zsmalloc.rst
-- 
2.39.0.rc1.256.g54fd8350bd-goog

