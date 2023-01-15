Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435B366B40E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAOVHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjAOVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:07:50 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C0144A2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:07:47 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vm8so63854668ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AfQqV82MfqCTkqi+JFVujPJySbqXceDsA7yHZUhQU0o=;
        b=bYsdL8d999TdaNref95ZP6prSkX1Hb9ktXNMyZC6ZY6WtZGdEQI4UZZ/EIiDIcvSWL
         TB1Zf+0P2T0BvtECPdZ3pIygJFq1WgVl1FvTLpyhfrrl0zUygDXt70veARKusjpOpmdO
         Y0WKTjXwlh/6i3aZw3qHLw25ElusLg1Gt3hgsdMGhp+JluZm4jzmK/XuJo+lHRe3usTa
         f26CTrX4Odr5SLp6b5j7bUqFGXnFIG/oBECGCPSN7Nplu5JRMWcABh/+2atEehKSWO90
         V0tkTMzYWqIGVZNQefGo/0r+1xlG8XR/GjfSs0bz/WNGaBB7hJaF2GrXaJr+9/ckGZzC
         BspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfQqV82MfqCTkqi+JFVujPJySbqXceDsA7yHZUhQU0o=;
        b=vWw5LmykWfrLOpYqptiZz3gL71F3FNj+vmDmv4zdu8Iwzl+ZUwOqS5bnicjXq3uCAZ
         njd9TsnTzCR3lMk7UCLju9KEPA4L6zFuyZD8bLUnK5dTl9JpvKduhAKErhFOZgc3cC4B
         2yOdBBeVGvgWi8zZEmZd3wJ/mU3UdHQLnxNJmPT3MikfYWjC0ldfXAzfpvJ/KYPAoalU
         D1aIZjI4rUfuHBSmyVJbBDB0dj1ivOogFlVwfZeuiodnH+ARRjBgy/qJnQWDj7EH4EKo
         +w3UBl4reiM72dkyFLGnNK5rdZbA2cy6alZMTiL6YSRa4d8hH2N0CaLWi8L9vl8eRatM
         RWKA==
X-Gm-Message-State: AFqh2kqqCT9RvC96kYXXr2m77P/3CgfvTKGNxzjLvFHx6cYG9RCPizmx
        7IXyVzU20KrzJllF6hXfdKLpG7ealfw=
X-Google-Smtp-Source: AMrXdXsDOxij77MgD3b8rp+35Lewl4KVR75a9ZFsUXoTJiuUSDh7eFLPeFWJlyLPF7r2tfA0iZBkmQ==
X-Received: by 2002:a17:906:3d6a:b0:85b:daf9:dcde with SMTP id r10-20020a1709063d6a00b0085bdaf9dcdemr11248955ejf.61.1673816866035;
        Sun, 15 Jan 2023 13:07:46 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbb0.dynamic.kabel-deutschland.de. [95.90.187.176])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7d74b000000b0049e08f781e3sm1010421eds.3.2023.01.15.13.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 13:07:45 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: some error logic cleanups
Date:   Sun, 15 Jan 2023 22:07:30 +0100
Message-Id: <20230115210734.18610-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.0
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

This series converts some more functions away from returning _SUCCESS
and _FAIL.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: convert PHY_MACConfig8188E() to common error logic
  staging: r8188eu: convert phy_RF6052_Config_ParaFile() to common error
    logic
  staging: r8188eu: convert phy_BB8188E_Config_ParaFile() to common
    error logic
  staging: r8188eu: convert PHY_BBConfig8188E() to common error logic

 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 35 ++++++++++---------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  7 ++--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 15 ++++----
 3 files changed, 27 insertions(+), 30 deletions(-)

-- 
2.39.0

