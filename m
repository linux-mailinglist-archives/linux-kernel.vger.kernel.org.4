Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D756439FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLFAfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFAe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:34:57 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD41D67A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:34:57 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id o189so3099624iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oll6l9lDa1YzuMAbRwQ0w/RLOsi7h8EqrYGzxo3MxIc=;
        b=UD9DWHz/UiGFDtsU3HDSrNzMZNDuCpetOaCUNlHtv0S6U0MQYLIfcmL3jLYBuz0Q5h
         eRd7MHClCouL9L03xTA089WBIsiCEySm2/x5gzjAtQS43+ojIgeKbrYxMsN0Clz3bkV6
         yAnID7BIdH493G2rS4XD+Zk6RXZPjx6NrWwPiUpJ4acsMtlhyvGIunczW4FgCYDMpSDl
         C0NT6MJ9m1EZ/RnxPEr+OKNFglmYnIurtVrPiQo7TkLtectGVdrqj6AofOOzo8UvBEEk
         76Rxq1dUlmjcVHhag7ETkTymPiSovZYHAyIFRrc2u11HUvGMpUYAecdIuS3bvhPCFRUh
         tGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oll6l9lDa1YzuMAbRwQ0w/RLOsi7h8EqrYGzxo3MxIc=;
        b=wWfmEqGgOwiGaETVayoHOfLF5xigRddp9wcnWh6d2PCTE7mN5dHKuLCbANJ5b90Vp6
         sbSujzonU2rAu7mfx3VGOh2LIm5Yuh3uXKM9tC56/JqB6Hrvltv2HhAESjSEpDEiaLj7
         R0JpMJjkh7NpDT+Xc9PBFiwfNjitcfKnK6IibmFRnXez5dS7zUHfY5lPGgaAQpnnZpcB
         5fLxYOOm3fdXZa0KgwJzz4FPQLztNbcPPmpL97Rd7/DG9gXW7rENzEpVZLO8l/DkT9Cz
         ZULhsxV4ezckEK/aJygIHgWK0NmKoZxxCmdwCSJe/WVjsVXGmd9EAXgl5Im10Qb9uzLR
         9uaw==
X-Gm-Message-State: ANoB5pkHexJwHnFe0GBVa0wYJX6z0If11DdagvFve/PQJVY7toY7u8Ad
        td+8wZSSM9+VrrDf3qK3LMOSZxiQodg3Yg==
X-Google-Smtp-Source: AA0mqf5PWVymzCnbWJXpMIHyTjb22OYxykYQ86bDxVxB4HjTi4ucYqEGKfdpkztJZ/eaV/plIOquCQ==
X-Received: by 2002:a05:6638:3720:b0:38a:3771:cbff with SMTP id k32-20020a056638372000b0038a3771cbffmr4702557jav.223.1670286896073;
        Mon, 05 Dec 2022 16:34:56 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:34:55 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 00/17] DRM_USE_DYNAMIC_DEBUG regression
Date:   Mon,  5 Dec 2022 17:34:07 -0700
Message-Id: <20221206003424.592078-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Hi everyone,

DRM_USE_DYNAMIC_DEBUG=y has a regression on rc-*

Regression is due to a chicken-egg problem loading modules; on
`modprobe i915`, drm is loaded 1st, and drm.debug is set.  When
drm_debug_enabled() tested __drm_debug at runtime, that just worked.

But with DRM_USE_DYNAMIC_DEBUG=y, the runtime test is replaced with a
post-load enablement of drm_dbg/dyndbg callsites (static-keys), via
dyndbg's callback on __drm_debug.  Since all drm-drivers need drm.ko,
it is loaded 1st, then drm.debug=X is applied, then drivers load, but
too late for drm_dbgs to be enabled.

STATUS

For all-loadable drm,i915,amdgpu configs, it almost works, but
propagating drm.debug to dependent modules doesnt actually apply,
though the motions are there.  This is not the problem I want to chase
here.

The more basic trouble is:

For builtin drm + helpers, things are broken pretty early; at the
beginning of dynamic_debug_init().  As the ddebug_sanity() commit-msg
describes in some detail, the records added by _USE fail to reference
the struct ddebug_class_map created and exported by _DEFINE, but get
separate addresses to "other" data that segv's when used as the
expected pointer. FWIW, the pointer val starts with "revi".

OVERVIEW

DECLARE_DYNDBG_CLASSMAP is broken: it is one-size-fits-all-poorly.
It muddles the distinction between a (single) definition, and multiple
references.  Something exported should suffice.

The core of this patchset splits it into:

DYNDBG_CLASSMAP_DEFINE	used once per subsystem to define each classmap
DYNDBG_CLASSMAP_USE	declare dependence on a DEFINEd classmap

This makes the weird coordinated-changes-by-identical-classmaps
"feature" unnecessary; the DEFINE can export the var, and USE refers
to the exported var.

So this patchset adds another section: __dyndbg_class_refs.

It is like __dyndbg_classes; it is scanned under ddebug_add_module(),
and attached to each module's ddebug_table.  Once attached, it can be
used like classes to validate and apply class FOO >control queries.

It also maps the class user -> definer explicitly, so that when the
module is loaded, the section scan can find the kernel-param that is
wired to dyndbg's kparam-callback, and apply its state-var, forex:
__drm_debug to the just loaded helper/driver module.

Theres plenty to address Im sure.

Jim Cromie (17):
  test-dyndbg: fixup CLASSMAP usage error
  test-dyndbg: show that DEBUG enables prdbgs at compiletime
  dyndbg: fix readback value on LEVEL_NAMES interfaces
  dyndbg: replace classmap list with a vector
  dyndbg: make ddebug_apply_class_bitmap more selective
  dyndbg: dynamic_debug_init - use pointer inequality, not strcmp
  dyndbg: drop NUM_TYPE_ARRAY
  dyndbg: reduce verbose/debug clutter
  dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP with
    DYNDBG_CLASSMAP(_DEFINE|_USE)
  dyndbg-API: specialize DYNDBG_CLASSMAP_(DEFINE|USE)
  dyndbg-API: DYNDBG_CLASSMAP_USE drop extra args
  dyndbg-API: DYNDBG_CLASSMAP_DEFINE() improvements
  drm_print: fix stale macro-name in comment
  dyndbg: unwrap __ddebug_add_module inner function NOTYET
  dyndbg: ddebug_sanity()
  dyndbg: mess-w-dep-class
  dyndbg: miss-on HACK

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  14 +-
 drivers/gpu/drm/display/drm_dp_helper.c |  14 +-
 drivers/gpu/drm/drm_crtc_helper.c       |  14 +-
 drivers/gpu/drm/drm_print.c             |  22 +--
 drivers/gpu/drm/i915/i915_params.c      |  14 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  14 +-
 include/asm-generic/vmlinux.lds.h       |   3 +
 include/drm/drm_print.h                 |   6 +-
 include/linux/dynamic_debug.h           |  57 ++++--
 include/linux/map.h                     |  54 ++++++
 kernel/module/main.c                    |   2 +
 lib/dynamic_debug.c                     | 240 +++++++++++++++++++-----
 lib/test_dynamic_debug.c                |  47 ++---
 13 files changed, 344 insertions(+), 157 deletions(-)
 create mode 100644 include/linux/map.h

-- 
2.38.1

