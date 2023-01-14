Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F13266A7D7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjANBA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjANBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:00:26 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F8F6084B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:00:25 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i1so8090829ilu.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M97B1poe5E1m8pRKPWmlzH7xdRB/G7s4vd7sxOh8JfU=;
        b=iCpVgOW0Qk7d39TEoAOHyhjb8/9UP9uv+s2E0M9CdmFRAT3u+1r+IUvnkCllC2ZGzu
         ZXg20Jpls8I0DfZGWFIX2pglh4cMNeO/cmpNf8biDpdM30lGwubkmav09F26N6t3bIK5
         owfVc6PdFHphzx9l6UpIm3FO/7qCxveL4n5MXxTNW8FnJCu8JWLQQf12ijLb9fjzfeac
         ymixjL2QcF8AxgbLTuWTwOvBedmkN+hPbK1GZ9QMsEYqgcy58kyYgwtEvjVh0TLwCRI9
         tI5CRzvwbYlQ4id7m1Bg4KVjX12zAe58SyUD6l0Zcb21sX0LH1+HTppRxSTgwpLEzhCB
         TrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M97B1poe5E1m8pRKPWmlzH7xdRB/G7s4vd7sxOh8JfU=;
        b=w+wDUwasvcGE1dcrhXCbgzrxaR//Rkc+mYZD5YMlmY62a23eLSHx9uLKyAMeCR7miK
         2JkBhx2JT3YNqhagBGJ9JBFaISD8eufiIvCbn+UIldjKUHfxhdEo4b9fP+6J0LkeDu4n
         zgt7/58k0vg3P0ZJAhjBv+7ADP3rbdDhAbuwkXXNL/OLR98LRcJi3tTZaKU4zX1TN4v4
         /eVZBY8TFPfhILAdj6ak16Bji1T5iQ2eeNzjoMjSjxCMXs8ZmDISLrADZBRzX8REOZOF
         Mlo1rjI9h0P2sljVGlVZ22lBgz36B7cE8Ntou7mpp40kG7fs5tfm6DA6aaBtlMgnJUcv
         mMSA==
X-Gm-Message-State: AFqh2kpR1l3T82t1+xVioKLhHEDjmPGvFSCb1Vl+Mf3dYZb4DdS4STj2
        pq3SEch8wdIUZN4pfCkfaBIY8FOmAo0=
X-Google-Smtp-Source: AMrXdXs4tO6gubNamHO0YTrHBNKzl7KOApYhShlUDiJyp9pUHqFWHMYvjSSYIC4F9zr3L+Gs6pyv7w==
X-Received: by 2002:a92:de0a:0:b0:30c:699e:7f42 with SMTP id x10-20020a92de0a000000b0030c699e7f42mr25924210ilm.9.1673658024476;
        Fri, 13 Jan 2023 17:00:24 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::6463])
        by smtp.gmail.com with ESMTPSA id m9-20020a92cac9000000b003036d1ee5cbsm1787300ilq.41.2023.01.13.17.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:00:23 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Daniel Mentz <danielmentz@google.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Richard Acayan <mailingradian@gmail.com>
Subject: [RFC PATCH v2 0/2] drm/dsi-mipi: 16-bit Brightness Endianness Fix
Date:   Fri, 13 Jan 2023 20:00:04 -0500
Message-Id: <20230114010006.50471-1-mailingradian@gmail.com>
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

Changes since v1:
 - move 16-bit brightness handling to new functions and revert API
   change (1/2)
 - remove Change-Id in compliance with checkpatch.pl (1/2)
 - separate panel driver changes (2/2)

This series adds proper support for 16-bit MIPI DSI brightness and
cleans up existing panel drivers.

I cannot test the SOFEF00 change, although I tested an equivalent change
to an external S6E3FA7 driver generated with the same generator. Both
setting and getting works on S6E3FA7.

Daniel Mentz (1):
  drm/dsi-mipi: Fix byte order of DCS set/get brightness

Richard Acayan (1):
  drm/panel: sofef00: Use 16-bit panel brightness

 drivers/gpu/drm/drm_mipi_dsi.c                | 52 +++++++++++++++++++
 drivers/gpu/drm/panel/panel-samsung-sofef00.c |  9 +---
 include/drm/drm_mipi_dsi.h                    |  4 ++
 3 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.39.0

