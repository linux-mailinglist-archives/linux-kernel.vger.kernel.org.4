Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918A265FFD9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjAFL54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjAFL5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:57:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E616C19C1D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:57:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso902606wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 03:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uqn3mQGjfprH1rWo7J/GVbJ8MDxMwLe8ZGhcyU28Kk0=;
        b=U0R0pFPm3Tc7cEN5cy5a4/JNSrzO6jPWmvnZjpxCTPD8kn6LSfbDM8SET0/Pu7WkjN
         feQLHe0xrhJ9aiEXmi/x7Zrxa4Bf8HzXsQVrt6CXO5jqLmzBoItJrodxooxQnX6UXSbm
         Z7eB8N4TT5Z5rVHmXI0HqyppSDWsvf/aOQQDjzeGfYtXsliEE8FmLO8r1aEq2++T+B2u
         GtSE1o1zeZLU5l3lvgHWK/OqRo4Ak3blLp6e7lVymJPRsWRTTWtO8i6XeW0gyabcOJy/
         k2p2lYLGVxpTotmhG29hpv9G+Dr/S8orpI6/TqEPhjt60GjnHYy264EudeUDw9jtyjbI
         XqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqn3mQGjfprH1rWo7J/GVbJ8MDxMwLe8ZGhcyU28Kk0=;
        b=JMX5bwCaRvglU+n3KJjRGdh1WbvtQNkMNudaCRwmGUqNxmuDV9s+Yu/EtN7P8SYMwo
         Wa2NIqBaBrg+2er+3Uv0lbk5IBnYo5zBUzzxRTNexa1gZ9bltMt0aesTpguXG4SY8kFQ
         /dUGtdTEC2RDLvwOQSqUQZ4e5YhOA8rFXdbeh2C/Eq1h5ZvZOX+yGpY8OgPf9XjAvPv9
         GrPMTKPkbgaHpivAQlV+40bX1J2QtG9LwPgy+06jcGB4697Hy4ZboLErb2KC6JTYNp24
         S5+p0rR0GdQ4nP4ASsIN26r6gXSpPIXAkQZHGiDlrfcXVshp74hEzeIm28BKLclWU9Lj
         axxg==
X-Gm-Message-State: AFqh2krEK/CkJkPHYBk9nTBk5T7ugHCWgBxJ8MelbBcAUxWws4GaDVmQ
        Qf4uidOWC2/2We/lOf4z6Ws=
X-Google-Smtp-Source: AMrXdXuSoNUb6vHR404wC0WJatwP953geQgp52V1FYQgel/u+4E58mCe6nD1v7Hudbi1OJ0coLwGMQ==
X-Received: by 2002:a7b:c3c1:0:b0:3c7:1359:783b with SMTP id t1-20020a7bc3c1000000b003c71359783bmr38939246wmj.1.1673006271464;
        Fri, 06 Jan 2023 03:57:51 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003d9dee823a3sm469577wmq.5.2023.01.06.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 03:57:50 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Jan 2023 12:57:48 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <Y7gMvFPLjvCv2Jx1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-01-06

   # HEAD: 57512b57dcfaf63c52d8ad2fb35321328cde31b0 perf/x86/rapl: Add support for Intel Emerald Rapids

Intel RAPL updates for new model IDs.

NOTE: technically this is hardware-enablement, but we generally make an 
exception for trivial expansions of model check tables that only affect 
those models. Let me know if it's a bridge too far for -rc3.

 Thanks,

	Ingo

------------------>
Chris Wilson (1):
      perf/x86/rapl: Treat Tigerlake like Icelake

Zhang Rui (2):
      perf/x86/rapl: Add support for Intel Meteor Lake
      perf/x86/rapl: Add support for Intel Emerald Rapids


 arch/x86/events/rapl.c | 5 +++++
 1 file changed, 5 insertions(+)
