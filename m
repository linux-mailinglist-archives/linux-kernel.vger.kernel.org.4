Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8E5B7934
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiIMSMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiIMSLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:11:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B779EC9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:18:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v1so12502509plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3ZodDSu6Cw5hgKhb4h9fYDsQ0BBEjxdpwaIiLy4Endc=;
        b=RAdhZsbxcXy9FNvxHeLOh50hx7eC9LAPfpuSPoZggO0QhJdrVW+IcJ3UgIVjAIM2TZ
         ss3TwsJgXUTGZWLTULS7aM166J6Dn/RyMsmVHuJu1NW6aYXCU+sI41nAe+27GSZqE9p0
         f0MVv0MBHctbYJOAUnhIsKv/RXCNoa3/OFf31x/BhyElHAZgGE3kIycQC5z648KACPFj
         aMNi8z/Ic1J21tMSr709IYAbdXi/7Mvs1DNaj2QyMQfbESJ54sPbwh41NUZQeBYmXF/w
         8yZx0rGqsOUwEofguW05YvyUd13zDVdDX/wQykmokSiAy9jsoJTQ9/G2h+nES3hiKEyj
         htpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3ZodDSu6Cw5hgKhb4h9fYDsQ0BBEjxdpwaIiLy4Endc=;
        b=6IWL4dfH3SFoE2KyZY+ER3/0+GzTRv95MZ6vonpfa12bpkFW6IxuJmb7OE9p0tIhgD
         jyBT4WNiZjxZMNi/6d4geiA4xUkI5ypxUNmEZBs80PUn2Bp8IiJw0hIyjTqoHSCXVS+r
         jrwN2wUMk3uWZaFEtS45o4TGPQALyEzToNeELcjMY7QwLD98i5k5XhFKZaW2ENgTlJ9d
         X7GvPm38b3OrRXkbiQ243nl48WLQl+2uxaWcdLuGRE6X0tZv+7AGTLiFOGvBx/+zgd6h
         ckwmgpsWePWyiOJZh9LY7nkgqqrd4EqVzoBRS985o+B4Y7NXQczqIZ2vB82LHUeUwVpx
         M47A==
X-Gm-Message-State: ACrzQf266EVDUI1Hro3UV9xEfsBavtpVqj62W23cJ5PilBoESaA9NWnI
        LJha3WtzkeXJWf9GJcmbr6mHFp4k8ptAjg==
X-Google-Smtp-Source: AMsMyM5YvOwt78O+hZ4wxWriRsafI7QgmSTmB6I//55n/kYzrhAa7rSVgFfXAffFia5CzE0NVm6SiA==
X-Received: by 2002:a17:90a:39c9:b0:1fa:c50d:11f4 with SMTP id k9-20020a17090a39c900b001fac50d11f4mr314167pjf.166.1663089483248;
        Tue, 13 Sep 2022 10:18:03 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id z27-20020aa79e5b000000b0053e5b905843sm796474pfq.203.2022.09.13.10.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 10:18:02 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 3/3] vmw_balloon: open-code vmballoon_compaction_init()
Date:   Tue, 13 Sep 2022 02:43:06 -0700
Message-Id: <20220913094306.317734-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913094306.317734-1-namit@vmware.com>
References: <20220913094306.317734-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Following commit 68f2736a85832 ("mm: Convert all PageMovable users to
movable_operations"), the code of vmballoon_compaction_init() is very
simple and does not worth a separate function.

Instead, open code vmballoon_compaction_init. As migratepage is always
defined, use IS_ENABLED(), which makes the code easier to read. No
functional change is intended.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 762442b9ece8..46212cd09854 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1848,28 +1848,6 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	return ret;
 }
 
-/**
- * vmballoon_compaction_init() - initialized compaction for the balloon.
- *
- * @b: pointer to the balloon.
- *
- * If during the initialization a failure occurred, this function does not
- * perform cleanup. The caller must call vmballoon_compaction_deinit() in this
- * case.
- *
- * Return: zero on success or error code on failure.
- */
-static __init void vmballoon_compaction_init(struct vmballoon *b)
-{
-	b->b_dev_info.migratepage = vmballoon_migratepage;
-}
-
-#else /* CONFIG_BALLOON_COMPACTION */
-static inline void vmballoon_compaction_init(struct vmballoon *b)
-{
-}
-#endif /* CONFIG_BALLOON_COMPACTION */
-
 static int __init vmballoon_init(void)
 {
 	int error;
@@ -1909,7 +1887,9 @@ static int __init vmballoon_init(void)
 	 * balloon_devinfo_init() .
 	 */
 	balloon_devinfo_init(&balloon.b_dev_info);
-	vmballoon_compaction_init(&balloon);
+
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		b->b_dev_info.migratepage = vmballoon_migratepage;
 
 	queue_delayed_work(system_freezable_wq, &balloon.dwork, 0);
 
-- 
2.25.1

