Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491166B0AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCHOPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjCHOOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:14:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993DB2570;
        Wed,  8 Mar 2023 06:13:30 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j11so46769593edq.4;
        Wed, 08 Mar 2023 06:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678284809;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYJgnl+7Us7KVNz74ou1/RTlLrV9+lTS5g77LiBuQ3c=;
        b=V9sCNW+1YZWFT2DWSHIkc5h4/h1AyHtAH0y4hmTxYqQa7bxZKtkozguy7/MR2R/ynu
         LtD7g6IMp4PRRj11DohjjcRDf+l4vp6Cabl8oX78gtNRyrX0pzKO6lT8DE1lvfKhRaA9
         nXBy3yNr9k5TFRN3qfuee4BgcYdd5RaJKqQS1oE0OrV1+mfdYN6LILVuQhOKrTWVjpgJ
         sOld3AdWulIj7Fa9D9WL3tZs4GfJnfKA+H+Ge3C7gSBTrHFiRmCy24gOJcCzz5caRY9V
         8YWS/0tw24asfyeqkuKAcdzkvqjlHC0rROblChFfjD4vPyrkz0jd7aXBEHG/1s5N0KCP
         BKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284809;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYJgnl+7Us7KVNz74ou1/RTlLrV9+lTS5g77LiBuQ3c=;
        b=XCTjRmX/KlRm7wApElvPKaP+nXXqp2fZ4hypY3gmFpdK92RmMFCu3oaMo9yqLd2O6g
         BhwRCrOjxQwvD1G9taHrZDJ17sZU63X+FFqLSAeUBNyjvhIRWZ9w3yyR9TZ9i7EBEegZ
         IHDppC42nLakSHZp7gfLoNPl65MlEW5Btv9yQBWXzU7uWczwshEEvDfXj9FqT6ZFhH3H
         6XXRl92df8/rjUZ2/zxPI5CN+I4y1seIiivzQ/4LKPGWI+jZkbUUKzLMleqmmTxwdWYp
         x/rGRtxeCydC6tQ4yhIcE39pP3Jq1/yoc6gSJUfjkeCjJGXhby7hqK+wZjXTvucFhtNS
         AtoA==
X-Gm-Message-State: AO0yUKXIS0W5BzEMKyp2bocL5QgqNLU0XKI3trKKdIWA5cFAf4PuBku1
        6/aRqLVHjquN8OYmidZNcGI=
X-Google-Smtp-Source: AK7set9KCSNRGEm9sChY9O0wotWq3iIMBNWylAEhP+Ubz3oleChgvVargNdNb4crfUiCIX8/U+bswg==
X-Received: by 2002:a17:906:fa82:b0:8ea:a647:a5aa with SMTP id lt2-20020a170906fa8200b008eaa647a5aamr23318599ejb.38.1678284808714;
        Wed, 08 Mar 2023 06:13:28 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:c4be:f7db:77fd:b9e5])
        by smtp.gmail.com with ESMTPSA id h7-20020a50cdc7000000b004bc15a440f1sm8283607edj.78.2023.03.08.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:13:28 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: update the 01.org website entries
Date:   Wed,  8 Mar 2023 15:13:22 +0100
Message-Id: <20230308141322.25201-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 01.org links in MAINTAINERS now forward to different other pages or do
not resolve.

The link https://01.org/linuxgraphics/ resolves to the Intel Graphics for
Linux - Programmer's Reference Manuals. Update this webpage entry.

The link
https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
does not resolve. Remove this webpage entry.

The link https://01.org/igvt-g resolves to
https://github.com/intel/gvt-linux. Remove the webpage entry, as the
github repository is already referred to by the T: entry in that section.

The link resolves the pm-graph project page in Intel's Open Ecosystem area
at intel.com. Update this webpage entry.

M:      "Todd E Brandt" <todd.e.brandt@linux.intel.com>
L:      linux-pm@vger.kernel.org

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1333928a7be4..99adcd74b06a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6747,7 +6747,6 @@ M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
 M:	Maxime Ripard <mripard@kernel.org>
 M:	Thomas Zimmermann <tzimmermann@suse.de>
 S:	Maintained
-W:	https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/gpu/
 F:	drivers/gpu/drm/*
@@ -10250,7 +10249,7 @@ M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
 M:	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
 L:	intel-gfx@lists.freedesktop.org
 S:	Supported
-W:	https://01.org/linuxgraphics/
+W:	https://www.intel.com/content/www/us/en/develop/documentation/intel-graphics-for-linux-programmers-reference-guide/top.html
 Q:	http://patchwork.freedesktop.org/project/intel-gfx/
 B:	https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
 C:	irc://irc.oftc.net/intel-gfx
@@ -10312,7 +10311,6 @@ M:	Zhi Wang <zhi.a.wang@intel.com>
 L:	intel-gvt-dev@lists.freedesktop.org
 L:	intel-gfx@lists.freedesktop.org
 S:	Supported
-W:	https://01.org/igvt-g
 T:	git https://github.com/intel/gvt-linux.git
 F:	drivers/gpu/drm/i915/gvt/
 
@@ -16668,7 +16666,7 @@ PM-GRAPH UTILITY
 M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
-W:	https://01.org/pm-graph
+W:	https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/overview.html
 B:	https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
 T:	git git://github.com/intel/pm-graph
 F:	tools/power/pm-graph
-- 
2.17.1

