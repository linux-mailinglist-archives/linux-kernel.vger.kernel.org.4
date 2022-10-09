Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73515F8A54
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJIJSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJIJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:18:21 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45C29C91
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:18:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q9so8104498pgq.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c06vT1tTPVLhSjiDtSw7P/lMUVOV+4NakOUkmc7Sjy8=;
        b=w1TFRHD0SeT/pmbr0js9hNBvhXIyM993AaQMjjMtyyLMW0jGsSINsekjNidvj8wuPu
         Gd2M310ffRhfGikgFtxNmvysSYKEjZ1G/cfFGvrU1QOVUHGTM4TR3f5qCoIpvHYZsNFB
         kyiugeuBqvZcTVIIaRck/AU4i9yeVvKSIk79imh4dx8yNVDpszDM92KFVRIpgdeTyTEk
         BkgBTqd0xqH6XLx7jRBXJ90lxLGv1K2VsVVnnEu6K/ceZ6fvQvmLQt5a3651j8vm8Sa0
         HEzJUdBSYy0TpjIrIXctmHOWly0Gd4ARZggDc9xpy3wLeWn0cBoaglO0f8KlI2ffYRsG
         s4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c06vT1tTPVLhSjiDtSw7P/lMUVOV+4NakOUkmc7Sjy8=;
        b=dDMNuEEG+fue2ddiXzsizDId3J6j1LeWW1pW5WgiWIDGswk2QcUrivUlwiGjmlZjjm
         MD5V+338cKcbd7naNU0BKoNs5Ev9rDJBePUAvCq2H/pbe4QUIHxA0AfOeFfNzFNgKcXE
         fDaiR42DH6vLEbfxA1XhvqSOD8zwPuLz1FvVQRIdIDZ+paXumMyj4qTPNPQbUjNe7HiA
         0qFJwo1xxliXlcTRXo95Ex1IUMS2IN3P8vSaye2u/wh9QMg/wkjyTP0iQ7IENTZ5cVC2
         lYzBsTfgRFaj2aINMMUKabpp/V3DGjdGqEOoVYxz5v0CcFoOml39qK+F3vb8XXW+RXqH
         gjFQ==
X-Gm-Message-State: ACrzQf0SUCGVDFiaq9t1dN4i16AodnzowjB+9hinW8cZz58KsxaXQjJg
        naESWNT8qGD2f/DU3Kx5bafx7wbK/NTkWQ==
X-Google-Smtp-Source: AMsMyM5oASkCz+aHt3lQVY8qf3o3DB9vnyGCnH02sG9l4RpaUOEVXzzk4KCBR2ME7OAWa/v5Cv/13w==
X-Received: by 2002:a63:1e05:0:b0:451:31d0:8c0f with SMTP id e5-20020a631e05000000b0045131d08c0fmr11829727pge.227.1665307100429;
        Sun, 09 Oct 2022 02:18:20 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id f38-20020a635566000000b004405c6eb962sm4328711pgm.4.2022.10.09.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:18:19 -0700 (PDT)
From:   Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH v2 0/3] ipmi: fix ipmi memleak and unload bug
Date:   Sun,  9 Oct 2022 17:18:08 +0800
Message-Id: <20221009091811.40240-1-zhangyuchen.lcr@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our users have reported a memory leak. The IPMI driver consumes a lot of
memory.

We found this problem because IPMI was slow to release messages after
being disconnected, causing what appeared to be a memory leak.

Fix commit as:
  ipmi: fix msg stack when IPMI is disconnected

Two other issues were addressed in the process of solving this problem.

1. Unloading the driver takes a long time.

Fix commit as:
  ipmi: fix long wait in unload when IPMI disconnect

2. Memory leaks during driver unloading.

Fix commit as:
  ipmi: fix memleak when unload ipmi driver


v1: https://lore.kernel.org/lkml/20221007092617.87597-1-zhangyuchen.lcr@bytedance.com/

Changelog in v1 -> v2 (suggested by corey):
 - Change HOSED to the invalid state and not allowed to send.[TESTED]
 - Remove incorrect comment.

Zhang Yuchen (3):
  ipmi: fix msg stack when IPMI is disconnected
  ipmi: fix long wait in unload when IPMI disconnect
  ipmi: fix memleak when unload ipmi driver

 drivers/char/ipmi/ipmi_kcs_sm.c     | 16 +++++++++++-----
 drivers/char/ipmi/ipmi_msghandler.c |  5 ++++-
 drivers/char/ipmi/ipmi_si_intf.c    | 27 +++++++++++++++++++--------
 3 files changed, 34 insertions(+), 14 deletions(-)

-- 
2.30.2

