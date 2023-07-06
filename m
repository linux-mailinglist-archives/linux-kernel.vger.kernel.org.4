Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E867074929F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjGFAar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjGFAan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:30:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548F519B2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:30:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b89b75dc1cso9205795ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 17:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688603441; x=1691195441;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8Jhj6afcnoCn+BxeDwfU74i3bb4E3uZLGQ1h/Zplhs=;
        b=XvtSueIVj2DbVpiQ3SULx9iOP69/r5l1+DwOc1Aq5zh5oUIFp03CoqDBLg1mIpJeq4
         cVyDZLKM7wA6LBYncxTsbUvogx/hTYLcrkWfxa3+NyEa7ceelvijiUn/cVPnffbFdgiA
         IIqvkqTeLvnKs9FFbR+9WSerGsrZg9WStILEIqzPIN0v6dWAUabCdwLxpeoA1olUv3Qf
         OZ5m/7MwgdJyX+SgvNs2A6yf76jEnWDsSwJSbboXMzRJ5kP8LZ05rUrZ544MrwVFh7Bs
         68gi5LNqSkvf6oBzT3XlzpJU2g6kTSe13b0/nM1dmtchJQngAje3YbanJ8I+vok80ESY
         b09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688603441; x=1691195441;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8Jhj6afcnoCn+BxeDwfU74i3bb4E3uZLGQ1h/Zplhs=;
        b=MEXUZRLMg2/MULTeS3EUa3tAd8QKDMwcsCdwMUpOmERhE1GT/RvRgQXsbjg8GNfATn
         ECVrnJwNn1A8sMcBaWbqBh8C9GSDZdQl8/yDRa2O0SveFLL14QUXNyV50MY7hgqxU1+u
         FFAU+dWu0IFuAl3BP9jSk+r8Esk2SVQyn0A42xo0HxwJNGS+1sD3uTfRH1r07JCIo708
         r4JdOuQZseNI9aaFlq636IOpNNXScN5WpRT7WgdEYfi0MNepp3SmNVx0hvUrS7nSFD4y
         krhH2IloMtY2NH2tbNJ0DNfdrakWknFrs5rXxR4wqMW4QUV3MNa7Fx1j57O7bV27woi0
         zvKw==
X-Gm-Message-State: ABy/qLZGAXOLhlFjNnsD3JTJRgUMkhTzuJGp7lR+A35UVjfRBZTRz2PP
        WM3lWyeWj4KOGt8AibN40DgJRZDmwKo=
X-Google-Smtp-Source: APBJJlE6oJ9KpW+EmfwA4bZbgZjGHlEgaG/78WXn16doRBLh2RyfuNM2HnxPwCyq11e4g4GmCU1fFg==
X-Received: by 2002:a17:902:c94c:b0:1b5:674d:2aa5 with SMTP id i12-20020a170902c94c00b001b5674d2aa5mr988197pla.13.1688603441424;
        Wed, 05 Jul 2023 17:30:41 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9fac:a99f:7f0a:397])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902b28700b001b89119aa30sm47889plr.289.2023.07.05.17.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 17:30:41 -0700 (PDT)
Date:   Wed, 5 Jul 2023 17:30:38 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] Input: gameport - use IS_REACHABLE() instead of open-coding
 it
Message-ID: <ZKYLLmsdCH0Gp7TO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace an open-coded preprocessor conditional with an equivalent helper.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/gameport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gameport.h b/include/linux/gameport.h
index 0a221e768ea4..07e370113b2b 100644
--- a/include/linux/gameport.h
+++ b/include/linux/gameport.h
@@ -63,7 +63,7 @@ struct gameport_driver {
 int gameport_open(struct gameport *gameport, struct gameport_driver *drv, int mode);
 void gameport_close(struct gameport *gameport);
 
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+#if IS_REACHABLE(CONFIG_GAMEPORT)
 
 void __gameport_register_port(struct gameport *gameport, struct module *owner);
 /* use a define to avoid include chaining to get THIS_MODULE */
-- 
2.41.0.255.g8b1d071c50-goog


-- 
Dmitry
