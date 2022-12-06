Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB6643A24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiLFAgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiLFAfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:38 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C03F2127F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:13 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id d123so3305766iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoWT3whneSiQzTAYd5Vl5dubMxD0/e5Afaj7/WmcC8o=;
        b=hI/CwpgBrv4FuN2UQf8ufrGEGWB3NLRMuEPL1gFEIujpHxwkfRV1QX1TD7RlOKnUjN
         wotsSjDJJYp77gKIDb6M6VvDv3dkVrpTi/b+lqk41/l+j3m1ZtggdhCEHN+9rnG09LXY
         EKqhFJSGtMtM4JE0WaHl49/OpjtHwTxZzFc1lkjFgGxgrx6ZkZR100GXh1qM/Gl4ZEe9
         j9xnM8mlK8JDE6gz+sVwd5f0SqLBK5v1oPwOTS6WkFSbE+XLSydLHJQXjEZWc+MJ3mQz
         42AuQhhU01H99SK0cwAuLJwvkCNpmI291UFZcFB++2WNpXQDgZVa6ehyw+7GUgdgLa/A
         knEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoWT3whneSiQzTAYd5Vl5dubMxD0/e5Afaj7/WmcC8o=;
        b=J+u4ZQk7/nFueLyodJh0fpwCJkikTM1JB5LWw1yGoLIN4IGAjZg4BaTcSVzINwB20U
         kR6L6fHf1besnXBsaXpvmID6vIxGran0MgPSFY7l041IEIDkm9uDOB2zBqnHVJ52DOKr
         X9mSl+J+sLRS81ZK+BPJhInuNEmX6vhm0fJ3EG2m/934FQKH4SyScSpxSslYVvqxpoqF
         pRFZ34jV3itFqc+ZHwdXysf6b0LNDsotckgwqvv9VF5kMI2WOa7pDtw2iem4WJePLV9n
         8zY4XsM1qC2IK72bx0ICPDRbLKJ8aBcfJRK6rqhGVfykIhIV22fUPGgsOcUURyRNDUnV
         H0mg==
X-Gm-Message-State: ANoB5pnXSZbnrAwSC0M8/bE0NRvv4SKeICv65ey1PsNASCPXrCUtPGj6
        dMFS6Nbqvr1VZCuObTdeKcsLWWUHjf6jtw==
X-Google-Smtp-Source: AA0mqf6ZFOuU7OcSMzy2rMDNBXi5b1ArqAGWmJJqL2EE6cRi4TBp7GPbwMCqNP+DcXnAP9J5+j8DaQ==
X-Received: by 2002:a02:6a43:0:b0:375:4725:4b4f with SMTP id m3-20020a026a43000000b0037547254b4fmr39159172jaf.52.1670286912140;
        Mon, 05 Dec 2022 16:35:12 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:11 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 13/17] drm_print: fix stale macro-name in comment
Date:   Mon,  5 Dec 2022 17:34:20 -0700
Message-Id: <20221206003424.592078-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206003424.592078-1-jim.cromie@gmail.com>
References: <20221206003424.592078-1-jim.cromie@gmail.com>
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

Cited commit uses stale macro name, fix this, and explain better.

When DRM_USE_DYNAMIC_DEBUG=y, DYNDBG_CLASSMAP_DEFINE() maps DRM_UT_*
onto BITs in drm.debug.  This still uses enum drm_debug_category, but
it is somewhat indirect, with the ordered set of DRM_UT_* enum-vals.
This requires that the macro args: DRM_UT_* list must be kept in sync
and in order.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
. emphasize ABI non-change despite enum val change - Jani Nikula
. reorder to back of patchset to follow API name changes.
---
 include/drm/drm_print.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 6a27e8f26770..7695ba31b3a4 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -276,7 +276,10 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
  *
  */
 enum drm_debug_category {
-	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
+	/*
+	 * Keep DYNDBG_CLASSMAP_DEFINE args in sync with changes here,
+	 * the enum-values define BIT()s in drm.debug, so are ABI.
+	 */
 	/**
 	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
 	 * drm_memory.c, ...
-- 
2.38.1

