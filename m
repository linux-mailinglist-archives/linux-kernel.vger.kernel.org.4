Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8A730BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFNXzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFNXzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:55:12 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE871FD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:55:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-65313d304e6so4387378b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686786908; x=1689378908;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Db8KxnSVPTgowcGe/Isx7RarF8FooosNlupn6FMqKw=;
        b=68d1A1Tig/1eII5XPEXfOHqu8vpkYRpuCsx6V036uwEMnTYmARW+qtNlVFv2rP+VWC
         uo3W/U8U+kL4Jub3FaVUEkCksUs4NZtX/RP/E97McWOR8Hn9ATAfO1iIoNMbi7FoQeXO
         Oj+lL7ZfXaFg0Mxk72zcyhcrDagaT/KVbr1+/vtcVgKVtwHe/E12VdTqjsHZlSN+UH56
         AChyg27Vj4/vL+rUQdhZvLfQ1xpQmGOLlYA+/WL/QWYoctM6tR2XkuEgY8hmPF9idUfP
         M52HcGC1uy8xT1XxvHFK9K5h+BfR3cnWBw+DZBNt9qZECy7Me42syUKKxmefvPww3pHo
         HcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686786908; x=1689378908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Db8KxnSVPTgowcGe/Isx7RarF8FooosNlupn6FMqKw=;
        b=AVaA91cmbt/FGwEH/I1D/yXPZAtt5gZFPBrOcDiPIQh9GYoNS08Dt9VVbeCKip2AuH
         ATzvUWrakgBNLZfJh6CFOiOy7g2+wTZo9alRh9C84lmAgna+vSkgV9tAaG3LxEklDOUe
         Csg35u2NR9B0pKCsxWY4beYb4KVBfHZm7hbQUJ8Rjc911j97mDAsOo678R3SKuxoW7+L
         Kf4OR6NEWDtD1hqHmQovE9KgSpNW0VHdCFjGRvw5cm1B18RQuozvkXP+eVko7T85nOgE
         ZXO+s4lQLi2kO+/57Wo4e0y1C3VD1H3/aKLmEH5bNpH2kQ9yEIbgflFHux8zJuHGblLp
         kzaA==
X-Gm-Message-State: AC+VfDxafJZIE4V7GBKnKnWdkfSxrwYLVkZccs5lGsFz3EKGfrjgtzuH
        VgpWfVzJJSPbmHEW27XJNHVyBrl/5KJAc0k=
X-Google-Smtp-Source: ACHHUZ4yAK39q4ouqLMpS+/Pahz2jLeOi1I3Slr+1pfwmFRaJ8eG44NErNa8BnzbvcHJLnhPEQ6oL68eBiUoG8I=
X-Received: from pceballos.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:128c])
 (user=pceballos job=sendgmr) by 2002:a05:6a00:1909:b0:64d:2cb0:c623 with SMTP
 id y9-20020a056a00190900b0064d2cb0c623mr1109527pfi.4.1686786908572; Wed, 14
 Jun 2023 16:55:08 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:54:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614235452.3765265-1-pceballos@google.com>
Subject: [PATCH v2] drm/i915/display/lspcon: Increase LSPCON mode settle timeout
From:   Pablo Ceballos <pceballos@google.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>, Sam Ravnborg <sam@ravnborg.org>,
        Pablo Ceballos <pceballos@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to eliminate all cases of "*ERROR* LSPCON mode hasn't settled",
followed by link training errors. Intel engineers recommended increasing
this timeout and that does resolve the issue.

On some CometLake-based device designs the Parade PS175 takes more than
400ms to settle in PCON mode. 100 reboot trials on one device resulted
in a median settle time of 440ms and a maximum of 444ms. Even after
increasing the timeout to 500ms, 2% of devices still had this error. So
this increases the timeout to 800ms.

Signed-off-by: Pablo Ceballos <pceballos@google.com>
---

Changelog since v1:
- Added more details in the commit message

 drivers/gpu/drm/i915/display/intel_lspcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
index bb3b5355a0d9..d7299fdc43ad 100644
--- a/drivers/gpu/drm/i915/display/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
@@ -167,7 +167,7 @@ static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
 	drm_dbg_kms(&i915->drm, "Waiting for LSPCON mode %s to settle\n",
 		    lspcon_mode_name(mode));
 
-	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 400);
+	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 800);
 	if (current_mode != mode)
 		drm_err(&i915->drm, "LSPCON mode hasn't settled\n");
 
-- 
2.41.0.162.gfafddb0af9-goog

