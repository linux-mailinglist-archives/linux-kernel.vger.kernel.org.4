Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA05B7C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIMU4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIMUz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:55:57 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECFB5FF68
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:55 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id z44-20020a9f372f000000b00390af225beaso3882955uad.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=u98YH0jx3OdeW4UquaiRdtASz50xZgF9GmW5yVmKS+A=;
        b=MPz2hm1dNp3wtK0Q6VOZj4HijDeEPDlqtG4P+GnwI1ScUXpTtAiMFQURP2+l0rCUxA
         qmrDRKPBY9MbWm16lKVZvzyIUdJdDUkzzrXDRzHRTJ6GX/yvA5wXbbFrPXBsVfmK5Eo4
         9ogkCukA16YVJLYlQyC6GDCLXZsEW5Jth3oYNbG/63WjVVZ1gvealfQW8jCDjky728Oe
         PBJlPLftoNRA5YfGbbYdkSf/WXE0SzNerEGMYnvyd8sR0THOr0GsvrAeMrBEU6VKtlok
         /9MFSeRwtKp+B3qVEYRyAMqDCg2EYB4UlKeFmcJPYJLNDLU7NZi7lqkjGWIHLveewJpg
         hb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=u98YH0jx3OdeW4UquaiRdtASz50xZgF9GmW5yVmKS+A=;
        b=Vp0pdG+Kni3YxWbAPiomhfx0uNPlIGbNDHs6qwCSRjKKCmBKjtl507Rk57xpNOw6Ky
         OIorQyACatq/f+lDVV/K+H1Z9gjZVIVRvG2MFqHXVV5DklRSE5IrsrAmeEGC5MBfAPRr
         DtoB0JIgz5lFxXk6Id+826GbatVvIO+dCFxHUw+d9/Jr6KeNBTHXoDmsA/RTdv//0Neq
         Y4k4m9kQz7+Sn14gNL1nFyaDN3RU6VXhbHjBM5k9g9voFmzGn6XO3jpNLYGz2kEcKkL6
         kVevs/Rr9gWHAQ+1Jj4yNGaUWKrnLyEhMpK0X10/nnrXA1BNs4/jwQgrZ9nUlp8rWknk
         oBnw==
X-Gm-Message-State: ACgBeo1mfSanhQO+T2JQxlxBC2jMardJtQ3ucXnytM4k42C+uIkLea+C
        ETyIr5RQmt2L+emTVDHEwS0stOvLXA==
X-Google-Smtp-Source: AA6agR5NeheBAt2f63oLFPCmdLpznilELhZXE8PxzUyHeV2qLgMAkY7E8Tau4uJxbQ4Q64hU2nMVSO1q4Q==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a1f:2548:0:b0:3a2:5fbb:6485 with SMTP id
 l69-20020a1f2548000000b003a25fbb6485mr3366058vkl.18.1663102554926; Tue, 13
 Sep 2022 13:55:54 -0700 (PDT)
Date:   Tue, 13 Sep 2022 13:55:48 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913205551.155128-1-nhuck@google.com>
Subject: [PATCH] drm/msm: Fix return type of mdp4_lvds_connector_mode_valid
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
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

The mode_valid field in drm_connector_helper_funcs is expected to be of
type:
enum drm_mode_status (* mode_valid) (struct drm_connector *connector,
                                     struct drm_display_mode *mode);

The mismatched return type breaks forward edge kCFI since the underlying
function definition does not match the function hook definition.

The return type of mdp4_lvds_connector_mode_valid should be changed from
int to enum drm_mode_status.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
index 7288041dd86a..7444b75c4215 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
@@ -56,8 +56,9 @@ static int mdp4_lvds_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int mdp4_lvds_connector_mode_valid(struct drm_connector *connector,
-				 struct drm_display_mode *mode)
+static enum drm_mode_status
+mdp4_lvds_connector_mode_valid(struct drm_connector *connector,
+			       struct drm_display_mode *mode)
 {
 	struct mdp4_lvds_connector *mdp4_lvds_connector =
 			to_mdp4_lvds_connector(connector);
-- 
2.37.2.789.g6183377224-goog

