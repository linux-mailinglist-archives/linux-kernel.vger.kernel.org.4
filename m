Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2035B7C58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIMUzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMUzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:55:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DAE47BB5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i194-20020a253bcb000000b00676d86fc5d7so11044288yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=s33IIyZmc8+UOGDwcegpipUma0relN3TBfpMpfz2BtE=;
        b=RjSvDvpURFWYgxGTp+hsMgMlof5mN8kvxLIrfLqX4X89vJU6vIXFtmx0+5iAbRnMOl
         AmhQI6ePnBrDnOU4psWJxluoIzalZblllUZva2TEr4N95hjhgz8ZGbLOHTFqvjKegQex
         HWb6RVL597rKKcH75a2RB2G/IRszLtafu+XLKFjl5XN0LrxBPn+c8Q69aA2uJCuI/Pre
         OXID5G2XefTpi4prdWtlr5n9LEccAWLjjHsNyMBuF2bFZow0uM/4qIe4sCcbuQskeeTU
         RRC0VCjDJWvklrNi5KxKkgKM/2yq4MoRMOQLvTqdqMcd8Wtu6wIc4NGkOeV8JKsRLtea
         TIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=s33IIyZmc8+UOGDwcegpipUma0relN3TBfpMpfz2BtE=;
        b=1zmrUmImkoib5g600ovLEjMQYLw17XobCgZdhIgUaOobnOsixf8j2U+kp5A0OWGHPK
         oye5LexHfP8BNQC2r7NKto6Pc4vQOQe7UZHlk5oXc7fno2RwO/JhdEeLqRoV+Ghe2V4p
         yTHzwCsP/vOMOO3lZ2JNoDa0jOQs3jQdFhxtvQwpQwL6r0G1TrONTu0eN5kVazhOq4vB
         2kQguaF+PAFTlg6lyUMc8KDAzNjspHDxW7wt/lDx0TiIguH7iAT27oKn9eUgJ971zgXr
         vRmgUre+T770ohI5VGMXMRnU1sElkNMQsHpbT3/rifv7hXDAXfS6Yla1ag2dr37iMQ3/
         2UVA==
X-Gm-Message-State: ACgBeo3W7ffFIVv53Dj8oehDDrqj8/Uame3r9KVeEijq8b1XWEMF4ttk
        yGFOhNUoITUlwpkXzxREcHJKQ/j9og==
X-Google-Smtp-Source: AA6agR5dsFGBClGYLD+8MsGw7ygyHU5aaKZYuov7XnCqBY5RuEfzGEGGFNkCWySIkMRmAQ8phfbVgpv1BQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:a26a:0:b0:6ae:a723:f721 with SMTP id
 b97-20020a25a26a000000b006aea723f721mr15192009ybi.200.1663102541983; Tue, 13
 Sep 2022 13:55:41 -0700 (PDT)
Date:   Tue, 13 Sep 2022 13:55:27 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913205531.155046-1-nhuck@google.com>
Subject: [PATCH] drm/i915: Fix return type of mode_valid function hook
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the functions used for intel_dvo_dev_ops.mode_valid have a return
type of enum drm_mode_status, but the mode_valid field in the struct
definition has a return type of int.

The mismatched return type breaks forward edge kCFI since the underlying
function definitions do not match the function hook definition.

The return type of the mode_valid field should be changed from int to
enum drm_mode_status.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/gpu/drm/i915/display/intel_dvo_dev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dvo_dev.h b/drivers/gpu/drm/i915/display/intel_dvo_dev.h
index d96c3cc46e50..50205f064d93 100644
--- a/drivers/gpu/drm/i915/display/intel_dvo_dev.h
+++ b/drivers/gpu/drm/i915/display/intel_dvo_dev.h
@@ -75,8 +75,8 @@ struct intel_dvo_dev_ops {
 	 *
 	 * \return MODE_OK if the mode is valid, or another MODE_* otherwise.
 	 */
-	int (*mode_valid)(struct intel_dvo_device *dvo,
-			  struct drm_display_mode *mode);
+	enum drm_mode_status (*mode_valid)(struct intel_dvo_device *dvo,
+					   struct drm_display_mode *mode);
 
 	/*
 	 * Callback for preparing mode changes on an output
-- 
2.37.2.789.g6183377224-goog

