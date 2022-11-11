Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B25D626445
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiKKWRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiKKWRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:17:23 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62CB4B997
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:21 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id i5so3152415ilc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPOs7canY8wqG4KDShIXdJ4wyqX/yN9ym9g6Duzre1k=;
        b=BLsxlWp51LE68mNY1QtMJxd/5OLjpMI44pN5/FtWjIwjpz7LHmHfClHptIP71SlcFC
         p7L8ojwDEZFNI/MnALg5SnzDLD0o1tboINKncqZu8mXZ6AVEV+8OyI2jloiBrXTe0GVY
         N36VG9LIA4K3qCONQQmkHB7DtPPxspsHcjb52IbiIgy0M5Lg0aHwETOw2SzNoXYv2yi/
         vOsXPxUk8LY9ng5bWr+XeKL5bQMU6E2k9IJv2KN1S4Znxje0k3cD4MgwBgM1aLGWBwL7
         Y7UYVHLDYgTNw+hdmnqHbJvAYxLPJiY4YR+oo0+opXKrIeucUwoH5jpQCLzlS61eM/AF
         i/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPOs7canY8wqG4KDShIXdJ4wyqX/yN9ym9g6Duzre1k=;
        b=LWyJv2nMFUqpT3z9ph3Fi8MeAYOkJZ3B9p4VaaOetjEDrChyJ+/5geYxPUBGhQ/4+o
         cQ++7bIdqBYxr4sNZ9+/ACmy+UksXydQ6Gwl6j57OhTiUwrUnkeCk5qdrUZ/CrHgd9Ye
         RgIIN8t64Y2B7KOzA1QNX0RIAB76G1nayQUUma+nDCmcn3hHrtlCCB6y6cCkXFLqqh3q
         D53KP2aC31fsBpq3RN5giDJZtImmaWnZMa9+NMCRSsOCxt82Caz7hvSH/kOiqh4x8g4x
         vYTSPESXsnFUsQRMzugwAknZDCYHTHyYU9h4N7WYT6PkSJV3uCv0Y/NL2MKCmIMB9GoZ
         bskA==
X-Gm-Message-State: ANoB5pnSVF+H/8BP6ETvqR9c6nCAbUoXoVeuzS64vLsmhhkzK4erVpQo
        a7Hr3B//Fsi0tnSAF20bD/8=
X-Google-Smtp-Source: AA0mqf7lBsqhkLm6RfCggnWUpU8zoWMTs3GVQb2sVJxvR44svzNa9Pkri6984fGQZVaiz+BEW3xFpw==
X-Received: by 2002:a05:6e02:663:b0:2ff:f77c:161f with SMTP id l3-20020a056e02066300b002fff77c161fmr2101888ilt.110.1668205040967;
        Fri, 11 Nov 2022 14:17:20 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id c5-20020a928e05000000b002f611806ae9sm1113457ild.60.2022.11.11.14.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:17:20 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/7] DYNAMIC_DEBUG fixups for rc
Date:   Fri, 11 Nov 2022 15:17:08 -0700
Message-Id: <20221111221715.563020-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20220912052852.1123868-1-jim.cromie@gmail.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
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

hi Jason, Greg, DRM-folk,

drm.debug-on-dyndbg has a regression due to a chicken-&-egg problem;
drm.debug is applied to enable dyndbg callsites before the dependent
modules' callsites are available to be enabled.

My "fixes" are unready, so lets just mark it BROKEN for now.

Meanwhile, heres some other fixes, a comment tweak, a proof of
non-bug, an internal simplification, and a cleanup/improvement to the
main macro (API):

Split DECLARE_DYNDBG_CLASSMAP in 1/2; REFERENCE_DYNDBG_CLASSMAP now
refers to a classmap DECLARE'd just once.  I think this gives a path
away from the coordination-by-identical-classmaps "feature" that Jani
and others thought was "weird" (my term).


Jim Cromie (7):
  drm: mark drm.debug-on-dyndbg as BROKEN for now
  drm_print: fixup improve stale comment
  test-dyndbg: fixup CLASSMAP usage error
  test-dyndbg: show that DEBUG enables prdbgs at compiletime
  dyndbg: fix readback value on LEVEL_NAMES interfaces
  dyndbg: clone DECLARE_DYNDBG_CLASSMAP to REFERENCE_DYNDBG_CLASSMAP
  dyndbg: replace classmap list with a vector

 drivers/gpu/drm/Kconfig                 |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/display/drm_dp_helper.c |  2 +-
 drivers/gpu/drm/drm_crtc_helper.c       |  2 +-
 drivers/gpu/drm/i915/i915_params.c      |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  2 +-
 include/drm/drm_print.h                 |  5 +-
 include/linux/dynamic_debug.h           | 10 ++++
 lib/dynamic_debug.c                     | 63 +++++++++++++------------
 lib/test_dynamic_debug.c                |  4 +-
 10 files changed, 57 insertions(+), 36 deletions(-)

-- 
2.38.1

