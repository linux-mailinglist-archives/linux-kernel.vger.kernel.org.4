Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C828642C91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiLEQKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiLEQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:10:23 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02C91D0CB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:10:21 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x11so4444081ilo.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbmxPiWbeCY24/0fxJySXsMJKh2ule5cB9SoQHkfWSI=;
        b=oY7/tOVLT7ZaLoT67yYMq/eFqiehA24XdsIwGpNNYf+B8gCqmI8rWNcYImF64zepQg
         EgP+CUYLXZwEwIaKz874gILPZKH7AvEEzblLoo3wQR0cZKrgEzTZOAtxTO5LkySkZMCY
         /LceIecIJ3BFUCfsRoLyp7J7dBxHj5l4+2yLX84O7D3aOEsLRXjU+l8/pnzXRvkYGUbH
         kROvjQd9BxaztDCnKiZQS+ZZPR9GnR7IC1FLaRzxPePdVcnGaJ8xWqwcFRXvZI4GgvE0
         1ehmr9j2fcfQ9fOI/WL5nhYUdAQyNyp8mtdB1mSgV+3P3wyn5XBrp/CiaI0G+feng159
         rWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbmxPiWbeCY24/0fxJySXsMJKh2ule5cB9SoQHkfWSI=;
        b=dB/+n9LjcPN96G42Bb9+eyYe6J206phRLs7WWcaoAaschYkrC3L27kqHjoRG60h55/
         fugMlHlJrcAlk2LT3dMjJpjGXNl8L2nv0ZCE31xsEMbfbXhIHT+rGe5iAfLDTypBJmDF
         me6ZZ3awAU6N/nq5L3POfbpzlcH3Dsgu2ju0UqbBcIHHdZwZhLeoT0YfCNB68qBoqkGS
         Qb2HM7aAfbMuKj8d9E/FHJbUgyOaw77gCOzq1NqF75HR0ZAy6/gZKPH3SLLpO0LvN3TR
         aZf84HetCMB4SLMgVZSS1FilDwNEcIUCgkZBTxOjbnwvxZZ7aqr5OXQ/V2481yN8Pu5R
         YJ0w==
X-Gm-Message-State: ANoB5pmKja5eLMv/vcFa48ZOQfBakQwpEdLlUM54Qxho9ImWOLyuADl8
        iOjBW6Nvis784/NlDgkYEH9pnHGG6bA=
X-Google-Smtp-Source: AA0mqf4EKMXBFjNrHPrB0JsxhSsyuLXuw60uEbtHeYkPjibNFJuD7jtEaYQc3AG9lCKffBLKz9xALw==
X-Received: by 2002:a92:c6d2:0:b0:303:40e4:5f7 with SMTP id v18-20020a92c6d2000000b0030340e405f7mr6079770ilm.185.1670256620713;
        Mon, 05 Dec 2022 08:10:20 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id g19-20020a05660226d300b006bcd45fe42bsm6017753ioo.29.2022.12.05.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:10:20 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/2] DRM - avoid regression in -rc, fix comment
Date:   Mon,  5 Dec 2022 09:10:03 -0700
Message-Id: <20221205161005.222274-1-jim.cromie@gmail.com>
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

hi DRM-folks,

DRM_USE_DYNAMIC_DEBUG has regression, mark as BROKEN for now.
Also correct a comment.

Jim Cromie (2):
  drm: mark CONFIG_DRM_USE_DYNAMIC_DEBUG as BROKEN for now
  drm_print: fix stale macro-name in comment

 drivers/gpu/drm/Kconfig | 3 ++-
 include/drm/drm_print.h | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.38.1

