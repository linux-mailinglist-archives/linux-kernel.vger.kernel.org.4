Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407736CAE03
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjC0S56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0S54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:57:56 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720E94
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 11:57:55 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g19so9582869qts.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679943474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XS8wwv8ptwz4F6/9PSxWEmUWc2CGzYarPSG8lT31fJI=;
        b=RLIQgdQnIjQbcNwXOpHsQO9TrhShODFMT+EPokbjhVXBWrOrIb9XStz3DFIkSnWr/6
         qXpZ8xvS0UwrUjBL5taDu8JkfAL4IP9tw0rAlin62bH0GxoElx3eUouvK9ldCdK3OalY
         OKDZlB4BwUfK9tiCUfzwUxm9CzNpant7cTXInONeD5n0OgSYX5QAeRnmuOHp32ogHKc9
         hUJbfj7cDlv3ezeGnvtv0WF836YxR0vENmjyyy3iHeI5eQfHtICs2iINT1BMXMWuhv8M
         p/aPn2zZVyqpPf7iAz1weUIk4IXQLdCOTwVTJBVfKpoMCRDziJO+L6M4jf5gn2ddLo2X
         SBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XS8wwv8ptwz4F6/9PSxWEmUWc2CGzYarPSG8lT31fJI=;
        b=Xh/k/YAdjKj83MDnTRH7g5xHswUtMOrKMyJUbwY3m3EMNEKnlkoPXImr1WIF2WnAu7
         xhuDmq1EO3iNkTEr3eOpT7wWaKhviFgEY2WSvVaeuSkz1ka9yUW0KwhQ8hH2oAfXZ6Ew
         5hUF1FpuFTWt47VVpAfO/BTeNQ+pouaC+6HxOdWwjnJsounjGlsDiZ/0yTui/ZSK2JZo
         QqyodTvAufBIoLjb8YmDtjUmEbfHoTHBEYhaQqA87xWoAYzwpD+bPBSwfwrsOxfiSYF6
         +b+bOjL0CgvzMx1F38+TdgtYWCGWDW9Qr8yFW9+uSniSeW9BEIsIZx5KKH/xYrUFreLj
         K6Sg==
X-Gm-Message-State: AAQBX9e8qFdk09/o3PwnR+nsmiQQChxmsssRFk2wawL9kQWT7mKz1vS2
        RPum4S/elt1k7xEUb/HVBwgDHaCDuwk=
X-Google-Smtp-Source: AKy350a2QLPf3Z1Tw9oU67F2p8DGYVQguYu8yNN3vUtS7bcNx7oPu50GFuMgs35LvAdUNQ30c6hYtA==
X-Received: by 2002:a05:622a:1886:b0:3e4:d6bb:d1c6 with SMTP id v6-20020a05622a188600b003e4d6bbd1c6mr19334389qtc.56.1679943474062;
        Mon, 27 Mar 2023 11:57:54 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x17-20020a376311000000b00741a8e96f25sm6526143qkb.88.2023.03.27.11.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:57:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, cdleonard@gmail.com
Subject: [PATCH v2] scripts/gdb: Bail early if there are no generic PD
Date:   Mon, 27 Mar 2023 11:57:46 -0700
Message-Id: <20230327185746.3856407-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid generating an exception if there are no generic power domain(s)
registered:

(gdb) lx-genpd-summary
domain                          status          children
    /device                                             runtime status
----------------------------------------------------------------------
Python Exception <class 'gdb.error'>: No symbol "gpd_list" in current context.
Error occurred in Python: No symbol "gpd_list" in current context.
(gdb) quit

Fixes: 8207d4a88e1e ("scripts/gdb: add lx-genpd-summary command")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- correctly invoke gdb_eval_or_none

 scripts/gdb/linux/genpd.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/genpd.py b/scripts/gdb/linux/genpd.py
index 39cd1abd8559..b53649c0a77a 100644
--- a/scripts/gdb/linux/genpd.py
+++ b/scripts/gdb/linux/genpd.py
@@ -5,7 +5,7 @@
 import gdb
 import sys
 
-from linux.utils import CachedType
+from linux.utils import CachedType, gdb_eval_or_none
 from linux.lists import list_for_each_entry
 
 generic_pm_domain_type = CachedType('struct generic_pm_domain')
@@ -70,6 +70,8 @@ Output is similar to /sys/kernel/debug/pm_genpd/pm_genpd_summary'''
             gdb.write('    %-50s  %s\n' % (kobj_path, rtpm_status_str(dev)))
 
     def invoke(self, arg, from_tty):
+        if gdb_eval_or_none("&gpd_list") is None:
+            raise gdb.GdbError("No power domain(s) registered")
         gdb.write('domain                          status          children\n');
         gdb.write('    /device                                             runtime status\n');
         gdb.write('----------------------------------------------------------------------\n');
-- 
2.34.1

