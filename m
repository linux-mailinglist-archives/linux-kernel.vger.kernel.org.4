Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DAC60D17C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiJYQUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJYQUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:20:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3237CB47
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:20:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j14so17646331ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s53x+nJuJzQXZZ8xIG3UoaBPvSj9GLUN61aOWqvjPbk=;
        b=fmlyNG02R5wPSQmaT7mCq+Tp1GXMFdyykFhnVmxVFKgk2bP+7H7mUuRdls1ejlfymv
         nwAbpLqSS4xWyJoKQ79Y47SFIikXg/70YNcmnF5fMiy+5BHQzMKfQJ/N2qR085/5+wYk
         CO+BIjE0lTKTWB2xUGnEBOmC8ul0XMgwdlrLEDojS29H+k9RX4vGj4MDy5SxjMy4MOTi
         0BKdT0jYgyAf6+KhrBvxMY8JYcphKs82gCX9r/twr2yH1P8ldvltwfOKIHj1yMZRExRw
         wLJ1p41G4IZXkpwOwXybJzpzSGdYs6VaOseQtcLhJKV1pp1zvksgE3qaJHaNpldd/3ha
         IIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s53x+nJuJzQXZZ8xIG3UoaBPvSj9GLUN61aOWqvjPbk=;
        b=rueUgs0V0oBm2A49Sc34CYD3vzYb+0/qysk4EZCCMaGjLX35Or9LOsuidzohe32XtN
         yAHTBv6GaljaXP4djFgR4RaP+1C5lKQ922HfAFA8XteLkmuPZnj1m4bfrimwsh74l3Bb
         /rV1NgFb/oASs4yqRFSTcx6z/lXqYL5o3gxR8Ds0rXainVXTd8Hb616e7ZmAluZdA7Ms
         z7F1YFlQ4mHPS6zKtAPMtUk5iUTFJeHEg8X5WaObZsDAoU8isTf0qtwNXb7jh0G9+ZOj
         PMLTymZ1fZkO+ZRIukJF3yngRu+wJZILoNbSSeMeuG0v1nKjSsrlmTC3ToSsuECT1drP
         joUA==
X-Gm-Message-State: ACrzQf0G3k6FT2Bd2ZB++BOuOY1JOBxWQsD/RtEHVxIvZUipqJ2QrDuB
        LjWMr9dj3HPeY/PY4itK4mc=
X-Google-Smtp-Source: AMsMyM6faqKizlNwmmsyhdfdxjCXQ6dkHWEVrkrCBzAwMgu6P/AcUuOk+eV32z0fVYbZdVn+Qd7yNQ==
X-Received: by 2002:a2e:a910:0:b0:26a:ed13:cda6 with SMTP id j16-20020a2ea910000000b0026aed13cda6mr13710361ljq.250.1666714809166;
        Tue, 25 Oct 2022 09:20:09 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id a16-20020a2eb550000000b002770302bdffsm540136ljn.105.2022.10.25.09.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:20:08 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH V4 0/2] xen/virtio: Handle PCI devices which Host controller is described in DT
Date:   Tue, 25 Oct 2022 19:20:02 +0300
Message-Id: <20221025162004.8501-1-olekstysh@gmail.com>
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

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Hello all.

Prior to V4 there was a single patch, for V4 an additional prereq patch appeared according
to the discussion at:
https://lore.kernel.org/xen-devel/alpine.DEB.2.22.394.2210211258050.3873@ubuntu-linux-20-04-desktop/

Based on:
https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=for-linus-6.1

Oleksandr Tyshchenko (2):
  xen/virtio: Optimize the setup of "xen-grant-dma" devices
  xen/virtio: Handle PCI devices which Host controller is described in
    DT

 arch/arm/xen/enlighten.c    |   2 +-
 drivers/xen/grant-dma-ops.c | 105 ++++++++++++++++++++----------------
 include/xen/arm/xen-ops.h   |   4 +-
 include/xen/xen-ops.h       |  16 ------
 4 files changed, 60 insertions(+), 67 deletions(-)

-- 
2.25.1

