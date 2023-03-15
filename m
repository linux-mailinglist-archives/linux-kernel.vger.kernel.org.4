Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D266BACF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCOKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjCOKDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:03:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8491A49C;
        Wed, 15 Mar 2023 03:02:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k2so11563893pll.8;
        Wed, 15 Mar 2023 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678874573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6BuA3/IaA3KWYlTwYpc4ySsD7kuUXxU+Kj5w0UtdhE=;
        b=SLTsblRQDj3hkyp3w7oJr7oob7FDAHKjv2+Mreuy9faOMpQ7icqe5dw5uCylZCciyJ
         Xx7cvS6o7nhMbC6NBIS4bqtP+Wo3In5uefBukxOSquIk1W73whijpnXXEYAF3evfY2oA
         15PBs1SkBZorbn3pGJz6dNwsdRAmW2A26fuZjQkUW1cgAcq0vQjauOmpEjhmVpNXxsia
         NWNA1MulpyMl9p1oqL741Kt9ZJCk5oLTHOId2Njqp0O5tbrTPHKVO1KyAsLCDG36o1za
         85dtDX7pDAbZH4kxejKGLPsBMtzlYMc6RQcmpik72VDm4Ed1eX5ee0gwLONpgrn2gr4k
         ssKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678874573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6BuA3/IaA3KWYlTwYpc4ySsD7kuUXxU+Kj5w0UtdhE=;
        b=5beM/ZBGsQCeamwbgXJPRyyM/rFBws16HPrThKYw+S3pZwlN0tQjVFCVv36VN17XzD
         +GUHEeXe8bZpiYBFkVdcz+GoFEQ28jkdV7GYeP+f+ok2WlUJbqzh4KvMwYPI6sWhvOIn
         2ABf709fTwb4s39H+OKXyQ/0U5mAI+Ml866Hj4cGFaGvcEMDtfO3bDESWgWVq8Y2v2gu
         OkiL0xT5V1x6K4jXKofdQ9NlYxJI7ADsLjTwJvtyoHiTDIWTUw8z3ONAdV+RK+KPODiD
         UPTwBdyhXVQGefHvkoOuaMfA831+iC+bObjYqc7WtRjzljQRfXirv7SXmjTATvrl4Yae
         /wmQ==
X-Gm-Message-State: AO0yUKUY0cxKDI2hJyLnWb1d4tcjhUvsa7cE533IMMYaxLwn2+RmjFxT
        TVV87g9lDbofNdprBf0u6Cs=
X-Google-Smtp-Source: AK7set81/JklFphaEtwIIoFmsuM5gRmI6FUFj9z2LVAn9V3Ecdj2lCJC9Wnd8qKsGwmL3O9zPhtvAQ==
X-Received: by 2002:a17:902:f687:b0:19c:e440:9256 with SMTP id l7-20020a170902f68700b0019ce4409256mr2673849plg.35.1678874572753;
        Wed, 15 Mar 2023 03:02:52 -0700 (PDT)
Received: from debian.me (subs09b-223-255-225-224.three.co.id. [223.255.225.224])
        by smtp.gmail.com with ESMTPSA id kc13-20020a17090333cd00b0019a82ff8c38sm3269378plb.29.2023.03.15.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 03:02:52 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0925510653F; Wed, 15 Mar 2023 17:02:48 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>
Cc:     Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] Documentation: kernel-parameters: Remove meye entry
Date:   Wed, 15 Mar 2023 17:02:46 +0700
Message-Id: <20230315100246.62324-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=bagasdotme@gmail.com; h=from:subject; bh=avfJeM8iBKx7EY1UHi3pTSAbm1wMcUWal73uKqAUeY8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCmC0/d8vt5u6LT2o/pedX42YbZ6FW79kzLX3rDVGuxst PM1UWrtKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQ6uxj+Kbs9OSl663765V3r 5qTnhPJcLvvya077/29avGd+9QVLFzH84Zef/42Le5Wrp87unKJb/x0ffrBP3278Y7PLy8v5s/Y p8AEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ba47652ba65523 ("media: meye: remove this deprecated driver")
removes meye driver but forgets to purge its kernel-parameters.txt
entry, hence broken reference.

Remove the entry.

Link: https://lore.kernel.org/all/202302070341.OVqstpMM-lkp@intel.com/
Fixes: ba47652ba65523 ("media: meye: remove this deprecated driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 This patch is based on staging-next tree, because the driver removal
 touched drivers/staging/.

 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd58..e54d4ce7870c00 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3184,9 +3184,6 @@
 			deep    - Suspend-To-RAM or equivalent (if supported)
 			See Documentation/admin-guide/pm/sleep-states.rst.
 
-	meye.*=		[HW] Set MotionEye Camera parameters
-			See Documentation/admin-guide/media/meye.rst.
-
 	mfgpt_irq=	[IA-32] Specify the IRQ to use for the
 			Multi-Function General Purpose Timers on AMD Geode
 			platforms.

base-commit: 458219ca9246076971961d695eef9eb56e05fcf7
-- 
An old man doll... just what I always wanted! - Clara

