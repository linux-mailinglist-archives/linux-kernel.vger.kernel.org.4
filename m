Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565356FF120
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbjEKMJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbjEKMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:09:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1140F7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-552cb28adfeso93956597b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683806944; x=1686398944;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4BIGv8cvhYCnj6Dn22WjXXNn/Va5F3LdRC3PtF/nvIA=;
        b=2jcOSJhmLEN7/bRj7Sj6znaj1Kl0FHZXElxAlbn6RkdBwDTuGByQ3mWkAGu9MMPYsf
         7RpDO2qYYqXMrz7jKDpAUD7ybqdtzRcCvy+sH8ofFNtv0UpHkGTXzgBh9Mpjz7yTnxZz
         yw95lVbx+YCVSGglSUunEeQGj37yy4fJP5uW2Bs9pN0xZBBFfUscjGPRSJX1OHZ1d0eM
         Q4IO16YOw9aV10I0AnXHjxaiw8x3YW+xSP1vEWSbOsIs/ybMwlnkP3K09hLE8FhdA8gm
         zNYnl40i5eTBuFbUBWGpK02SoOrDKJgc/aSlIqRqSs9WqzdHYUNqrootAX0oPeHFPH3f
         2fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806944; x=1686398944;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BIGv8cvhYCnj6Dn22WjXXNn/Va5F3LdRC3PtF/nvIA=;
        b=k55+Ut7eXIFgsot9ovSCwOuYZQ9WOgdxF7/BJnQCvuuj4+kRQkPq71g6UHPN9QNg1K
         Oke2HhdGcmZ/lkm0OI3ZE2BETLqrRR8IKMF8+uZTmKGsu4Q24BAF6IXO5xSmyX+SCIE9
         m2sjuiub3zZUlv/rwkuNDwWEoX2gxV7JEJkdWUYYz7g9qpIMf2k+zRyDGGmWHMTIJDXf
         2WHsFuKuOZxPNdIPjRMw5tAj0gdETlvyBi1o23xzbuA4AK81UxL6bfqT4VvQkgZqkMBy
         K3DoLYKvJPssBB3Bcc3q2+LIIUXQnAy0kDG9NaFqu4OHiyZtc4KPO4vaXWf1ZYB10Ky+
         a7aQ==
X-Gm-Message-State: AC+VfDwZe4tX8YJIn46IBxaiidkXl/wL5dLktTU1wV/2zdrI2Mg5TYNi
        Qgcuo0yzvK9hjUO4SLocN6kGlayRZpBMeJGgHQ==
X-Google-Smtp-Source: ACHHUZ4dvFqDJaqvl8s88DKFUSl7ZkE2AINynt5A9USiNed4MrNIKY0HgqUNVoSf+FaBQWxYBrI469iC5WrZlfaHHQ==
X-Received: from yixuanjiang.ntc.corp.google.com ([2401:fa00:fc:202:6c9a:64c9:7e44:6b1d])
 (user=yixuanjiang job=sendgmr) by 2002:a25:1d84:0:b0:ba2:526a:c84e with SMTP
 id d126-20020a251d84000000b00ba2526ac84emr10416404ybd.9.1683806944462; Thu,
 11 May 2023 05:09:04 -0700 (PDT)
Date:   Thu, 11 May 2023 20:08:35 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511120841.2096524-1-yixuanjiang@google.com>
Subject: [PATCH 0/6] Fix soc compress playback deadlock in 5.15
From:   yixuanjiang <yixuanjiang@google.com>
To:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        yixuanjiang <yixuanjiang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch in 5.15
 aa9ff6a4955f ("ASoC: soc-compress: Reposition and add pcm_mutex")
will cause the deadlock when close compress playback.

It needs backport patch
 b7898396f4 ("ASoC: soc-pcm: Fix and cleanup DPCM locking commit")
to prevent the deadlock issue.

Rootcause is patch b7898396f4 will remove pcm_mutex in soc_pcm_hw_clean
 then patch aa9ff6a4955f add pcm_mutex acqurie back in snd_compr_free
 to fix regression cause from b7898396f4.
If only apply aa9ff6a4955f, it will acqurie pcm_mutex twice cause the deadlock.

There are total 6 patches on these related backport

[  212.063445] sysrq: Show Blocked State
[  212.064964] Call trace:
[  212.064974] __switch_to+0x244/0x454
[  212.065075] __schedule+0x5fc/0xbdc
[  212.065092] schedule+0x154/0x258
[  212.065103] schedule_preempt_disabled+0x30/0x50
[  212.065115] __mutex_lock+0x36c/0x794
[  212.065135] __mutex_lock_slowpath+0x1c/0x2c
[  212.065145] soc_pcm_hw_clean+0x6c/0x364
[  212.065177] dpcm_be_dai_hw_free+0x20c/0x304
[  212.065188] soc_compr_free_fe+0x130/0x448
[  212.065230] snd_compr_free+0xac/0x148
[  212.065316] __fput+0x104/0x438
[  212.065347] ____fput+0x18/0x28
[  212.065409] task_work_run+0x144/0x1f8
[  212.065474] do_notify_resume+0x1d24/0x27b0
[  212.065518] el0_svc+0x68/0xc4
[  212.065601] el0t_64_sync_handler+0x8c/0xfc
[  212.065610] el0t_64_sync+0x1b0/0x1b4

*** BLURB HERE ***

Pierre-Louis Bossart (4):
  ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
  ASoC: soc-pcm: align BE 'atomicity' with that of the FE
  ASoC: soc-pcm: test refcount before triggering
  ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE

Takashi Iwai (2):
  ASoC: soc-pcm: Fix and cleanup DPCM locking
  ASoC: soc-pcm: serialize BE triggers

 include/sound/soc-dpcm.h |   2 +
 include/sound/soc.h      |   2 -
 sound/soc/soc-core.c     |   1 -
 sound/soc/soc-pcm.c      | 351 +++++++++++++++++++++++++++------------
 4 files changed, 246 insertions(+), 110 deletions(-)

-- 
2.40.1.521.gf1e218fcd8-goog

