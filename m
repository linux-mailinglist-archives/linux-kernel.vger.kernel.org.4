Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058CF5B7C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIMUz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIMUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:55:49 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD9543E4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:48 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id n33-20020ab013e4000000b0039f1bede4c9so3823547uae.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=B2mqYDiaNl85Fwjyeejod1j2C23kkV3KpQaZ/IDd3G0=;
        b=n5/3ZUe5YW7iVEaFTC1C/QTXggGwKQwtjWMw3jPI0BgMfRYYaenAHMYA7hmpH78woh
         lZrsAverREXV5LS1eNSZiEiLKiM+JXW0zOmxWAdX3LhCwLd9Qf/j9Y5hHtz2sPDqVpOO
         3LE27kbTv/4DXc2cgdQMCkC3yessqW+eRLrKkgNWQ+Ghdk/GB4Xyotg4WWPaHI8nr0ZJ
         DFR3Zt4imBoTKoWRLhRctbaodxm4ndTXJF9eHcqbrD4UR0gehFkZtZ22JU5AJxGutNXu
         2/qLLlTx4A77Jsxp0TXTu22DWntV2xma0eZbyML/CoROivz9n2Cnhwlejron+u+9bLkh
         E7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=B2mqYDiaNl85Fwjyeejod1j2C23kkV3KpQaZ/IDd3G0=;
        b=RqPsQkdEa1CLkb31Q+gdZ0UvKcwzFRkRehzQc4osslR5tP9bhihVigqRkM1p4i7zGX
         9daTX66B+vpg5+CUepWE2JlTC86jwlNyG5R+c/OEzKB2dGHR/EVCSizWStboX31nzZnk
         LNXHNDCxgHWISxQJtrJJt2jT918u7o8EEfT+rIWvS5JwKtrP1+r3HriZVDFnDZ7efKsS
         cfJno0cVX/gYbTH9lGSBh2tlO1ppa1cvrXIDwBSORC7i6T7CJpMZQ1+mBZWv8G8mTlIn
         6lXR+KkvbcbLxVP1DVFEak6JjcnkEcBmWpyw/dOKpoVxVpuw6evCTYxJO+6BaSmEbTey
         MQsg==
X-Gm-Message-State: ACgBeo23v+AbyUsEpU3pDuC2n2dDNBgZUl99eUyOy9IVUhZ+RhVegQiT
        MHbwdOcOnXbrhlJlKPF0Y79onKYCeQ==
X-Google-Smtp-Source: AA6agR6tnOJoQpNye/EaN3VzNTXwqOI2huVgh67Hj9kUaRNfdC+l6rBv/TSOXU4i5MQmCNQ7VhuyBZdcNQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a67:f6d5:0:b0:398:3cdb:3f99 with SMTP id
 v21-20020a67f6d5000000b003983cdb3f99mr9320922vso.85.1663102547645; Tue, 13
 Sep 2022 13:55:47 -0700 (PDT)
Date:   Tue, 13 Sep 2022 13:55:44 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913205544.155106-1-nhuck@google.com>
Subject: [PATCH] drm/imx: imx-tve: Fix return type of imx_tve_connector_mode_valid
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

The return type of imx_tve_connector_mode_valid should be changed from
int to enum drm_mode_status.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/gpu/drm/imx/imx-tve.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index 6b34fac3f73a..ab4d1c878fda 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -218,8 +218,9 @@ static int imx_tve_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int imx_tve_connector_mode_valid(struct drm_connector *connector,
-					struct drm_display_mode *mode)
+static enum drm_mode_status
+imx_tve_connector_mode_valid(struct drm_connector *connector,
+			     struct drm_display_mode *mode)
 {
 	struct imx_tve *tve = con_to_tve(connector);
 	unsigned long rate;
-- 
2.37.2.789.g6183377224-goog

