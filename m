Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A482064A899
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiLLUQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiLLUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:16:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993AB123
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:16:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kw15so31143184ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=o8XjUvB5FxdbMV+WWh+uuHuSp5zsbn4AEG/mibe0l88=;
        b=bm2YZleHyyiDCc+NlFIOP6m55WrXypqGCKif9M4HAx9OeFL6rBNltRyYgDd4n0w6v9
         OrbkDGlCkwgUBjotQtUAbcGydEZdnj9JuiLHziBb2sdiy4Rdauw5yzoO/ooKU6OI09PH
         PoBtJ7DJF3A0v/7n03qEdbrYeqDnPAc2ZOPN13ZSIjDMr6V2r/SBZPZGJu3/d9CJxZDR
         MuctQUbE/sbG8/zW1R79cjGw1vgMK2vCrkQU2xXdwgsydRL6Tjg3BlcbtNxq3sLZJic5
         523Z/RcUiaWSA6n8/TD2HKIs9DFAq8RfED+q4XLpL6+gdIO8sYjOU8lJd1p/L67xyrw/
         A+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8XjUvB5FxdbMV+WWh+uuHuSp5zsbn4AEG/mibe0l88=;
        b=wbtqFBjIfDJvxiYO3SmBD7TavZst1z+ueAE+BvwqxF+S5wP+fNk2YUG03dta2g3QoV
         NBNMLYvGTLUtXMPeyxrOknjLddvWOxc9DtnfnWThXwGTQ6WxHPdCY4CVIOLHap0nceYd
         mgVUKPSHAbKIWVNnkUWrhVn4DBSLnGwrX6xTJWLz/zxezTwlaYy9sRa6AjYiLLJBIIoQ
         twz1hzWfHMZI/tpNgoRIncRiU6+WPVlK1T1oyJdph28vaOsU71Auv7KMV0cYIB4WethW
         V+Yy+cXAZf+59Xh2EQiv0UWYPXW7oIS31a+/Ll1esDO1lY7opVr9jgQtnoyJxhFS5NmO
         bFAg==
X-Gm-Message-State: ANoB5pnM8ySUdlZA9IQchK+jQ/KH7+B0xqcH6BLPLxVU9HfGi7Kf643O
        CN+lwyPJ5C6JkMXOZQ49IQ4=
X-Google-Smtp-Source: AA0mqf7GlleFQt3SBeMHpNNy8bXwKFazwWRBXMVTOQJafgdQnBOmJcZDAgC1yRCWyfxfLlWqpx77Mw==
X-Received: by 2002:a17:906:f102:b0:78d:f456:1ef2 with SMTP id gv2-20020a170906f10200b0078df4561ef2mr14597592ejb.67.1670876176065;
        Mon, 12 Dec 2022 12:16:16 -0800 (PST)
Received: from gmail.com (1F2EF155.nat.pool.telekom.hu. [31.46.241.85])
        by smtp.gmail.com with ESMTPSA id l3-20020a170907914300b007bc30c06aa1sm3593995ejs.186.2022.12.12.12.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:16:15 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Dec 2022 21:16:13 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v6.2
Message-ID: <Y5eMDYABnSszN9/s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-12-12

   # HEAD: 90d758896787048fa3d4209309d4800f3920e66f futex: Resend potentially swallowed owner death notification

Two changes in this cycle:

 - a micro-optimization in static_key_slow_inc_cpuslocked()
 - fix futex death-notification wakeup bug

 Thanks,

	Ingo

------------------>
Alexey Izbyshev (1):
      futex: Resend potentially swallowed owner death notification

Uros Bizjak (1):
      jump_label: Use atomic_try_cmpxchg() in static_key_slow_inc_cpuslocked()


 kernel/futex/core.c | 26 +++++++++++++++++---------
 kernel/jump_label.c |  8 ++------
 2 files changed, 19 insertions(+), 15 deletions(-)
