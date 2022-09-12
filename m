Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEE65B5388
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiILF3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILF3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:29:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41782408F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:06 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g12so3456724ilj.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qg9to7hIZo/tNgDGQnKxNsyMgfHTsJfmQeKWAWjBM3Y=;
        b=fwweiZkkxgOj9IkckstUmzr3+NSlljXdQmamHEHFjSjjln6iHltmY3l7o+HzWFaYEG
         Lb5aJYHZeN3aVoSi0wv3JIexy4kqaX0r9ZoBwqGwD5QLF3qY0rqLGqYOQyH3nVTiw+jF
         Be9qUsrDDXn1SiWxtQzMbaXkRHkJz3b/oTcbxzPQl6uSFoqPbb+tuxVlAhaVwUhrf6qK
         ObYNR0eEdla8tydXUacWQ5EkvI7UvdcDElX3vsKx7xKZJyG7qZ4snHR4GxLhd2RkzRR9
         K8H7GHVGPDwTyMox6Wzdb9p2n5WnKC6KpDb4FIQ/leaQbmFI7jFryPR65ncRBxpm5S5I
         eGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qg9to7hIZo/tNgDGQnKxNsyMgfHTsJfmQeKWAWjBM3Y=;
        b=VpCtl1+svDxklcRkwphlabfsoy8BqyDHKb54p18AeU+2oS/ntco8yYGW7NwCQUSC7z
         rVV9sAqPEdGVyWRMn4Kg6wBfw3grTBDrTlOh7QYljRCFWEoUr+uod14ZkiF117j3iDj7
         MwaXWrEOXJhplKpBBpwtNDzNsG5JEe8cxXTJg9O7Z72heIga7O2L1zYNVsjsjERx6aQ2
         +R7ANQF9Sf3iNr5/3p/13ZmVZkVzDn/SL6Sensum4E8pGnDLnpKOWsUTS9LBy7qKlFWe
         6j8xiANFFap9UXt3f91ZnZkaZLCQCccreINzGnQluXy/zeZZo2c0BgUNiiSeY1zrcz9N
         f2dg==
X-Gm-Message-State: ACgBeo1rRCrrXmoHDT7XXos7tXU3eojwuie69nVGLWQGBR+rHqLiJtnb
        gSRFx5OKvAGnApwz+QPV5kCIqZn5oeRE1g==
X-Google-Smtp-Source: AA6agR6PqOG3cAeMUhS/dA7RYLxwnEszf0aSW5+mVVBkyci+q1M/IQ4stFHaBuDia3OjYj44LDJH6A==
X-Received: by 2002:a05:6e02:168e:b0:2f3:33d5:19bd with SMTP id f14-20020a056e02168e00b002f333d519bdmr8684638ila.112.1662960545031;
        Sun, 11 Sep 2022 22:29:05 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id q16-20020a056e02079000b002eb75fb01dbsm3006057ils.28.2022.09.11.22.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:29:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 0/9] dyndbg: drm.debug adaptation
Date:   Sun, 11 Sep 2022 23:28:43 -0600
Message-Id: <20220912052852.1123868-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Greg, Dan, Jason, DRM-folk,

heres follow-up to V6:
  rebased on driver-core/driver-core-next for -v6 applied bits (thanks)
  rework drm_debug_enabled{_raw,_instrumented,} per Dan.

It excludes:
  nouveau parts (immature)
  tracefs parts (I missed --to=Steve on v6)
  split _ddebug_site and de-duplicate experiment (way unready)

IOW, its the remaining commits of V6 on which Dan gave his Reviewed-by.

If these are good to apply, I'll rebase and repost the rest separately.

These are also available at:
https://github.com/jimc/linux/releases/tag/dyndbg%2Fdd-drm-class-911

RFC:

DECLARE_DYNDBG_CLASSMAP's interface can be improved: class-names are
currently strings, like "DRM_UT_CORE", which must have corresponding
ENUM symbols defined.  It would be better to just pass DRM_UT_CORE,
etc, and stringify the va-args inside the macro while initializing
classnames member.  But how ?


Jim Cromie (9):
  drm_print: condense enum drm_debug_category
  drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.
  drm_print: interpose drm_*dbg with forwarding macros
  drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro
  drm-print.h: include dyndbg header
  drm-print: add drm_dbg_driver to improve namespace symmetry
  drm_print: optimize drm_debug_enabled for jump-label
  drm_print: prefer bare printk KERN_DEBUG on generic fn
  drm_print: add _ddebug descriptor to drm_*dbg prototypes

 drivers/gpu/drm/Kconfig                 | 12 ++++
 drivers/gpu/drm/Makefile                |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++
 drivers/gpu/drm/display/drm_dp_helper.c | 13 +++++
 drivers/gpu/drm/drm_crtc_helper.c       | 13 +++++
 drivers/gpu/drm/drm_print.c             | 48 +++++++++++----
 drivers/gpu/drm/i915/i915_params.c      | 12 ++++
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 13 +++++
 include/drm/drm_print.h                 | 78 +++++++++++++++++++------
 9 files changed, 174 insertions(+), 31 deletions(-)

-- 
2.37.3

