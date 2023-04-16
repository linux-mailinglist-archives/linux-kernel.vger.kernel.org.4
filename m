Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D546E3894
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDPNQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDPNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:16:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BA02698;
        Sun, 16 Apr 2023 06:16:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5050491cb04so2874368a12.0;
        Sun, 16 Apr 2023 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681651002; x=1684243002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CtBhR8YOpDqMIofOmWwuAA+9qpS9Sa8zpuzMOiM4dE=;
        b=o+aE5sz6hjs+PU7P6jpKpEYd/ddQAMkZwZEdi4i5+0TJc893iZu3zdUdN+TZ/m7tmp
         /ZlMtzc/ldAuQQ6rYiaX77Nx2twfzEHJ7nRxs50ymAsIaukE2OjGRAag+yygtssbzi2S
         cuyqpWSRE5K526kbgLolZf5DkfBQ7KrKjDG5e/SryNcrhdzNbXG0NJ+wuqI8iz9+BILq
         ZrEr9I73Kz5y3ZYLK19U6Pk5cvZ9dceCmxe6AiWow7zC1G5stu2wGp6eIXXq1tQ2mpq0
         Btsa8TI/T3BrS+mFliXe8Jr21P8gX481u1B+NslPYuVgCZzT4jQE/UNz1+KBfnqCbj0G
         LFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681651002; x=1684243002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CtBhR8YOpDqMIofOmWwuAA+9qpS9Sa8zpuzMOiM4dE=;
        b=ZMzkDAF2nQbtMKOUJu7v7N1jAcanHPeBi5y6eVcsHu5auH3MM5/FHTJsytw2tdESui
         GxxMybY2Yb6H/+/ROEgZwy068e+xr9NZxGBht6/sw0UBfstSs2X8gSj+2u0fT0/BHU9S
         p6lbYLiU5K6BpoCfResUd4H34kS8/Qi85HN7jJqJWyRt5IaohfbG4l7IUWI4g0372BRS
         1PNfUV2+XDRQL0Y1YcYFB5rt0BkE+sSt7GCfMgIWowfbPZzfi4UM0z+oDg/IoDMJuyLX
         YzMidhzgIbdwUIq6lFQnKmFMpYJummVaiUelfPBhyiOGAEs0klBxRuA77C0mWAKz+dRy
         QZcQ==
X-Gm-Message-State: AAQBX9fOVvvORapthJZ3mR26a0s02B/e4TxQJXuCJ6WCyZlL3izC42Sy
        gtQbgsxx8ovbUJJ8/kKTCYo=
X-Google-Smtp-Source: AKy350aXeAkH9jYFdGqlBTS31BvhP/sjNVYULPpdbxeCz/nFrJ3kEGRykCB1cjBPgkoQPALudjRWFw==
X-Received: by 2002:a05:6402:14ca:b0:506:7f78:c4d3 with SMTP id f10-20020a05640214ca00b005067f78c4d3mr7817582edx.27.1681651002057;
        Sun, 16 Apr 2023 06:16:42 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640204c900b005068d7ccfb0sm2396594edw.83.2023.04.16.06.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:16:41 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for Samsung S6D7AA0 LCD panel controller driver
Date:   Sun, 16 Apr 2023 15:16:32 +0200
Message-Id: <20230416131632.31673-4-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416131632.31673-1-aweber.kernel@gmail.com>
References: <20230416131632.31673-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add myself as maintainer of the Samsung S6D7AA0 panel driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..6a55e6e3ac59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6623,6 +6623,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
 F:	drivers/gpu/drm/panel/panel-samsung-s6d27a1.c
 
+DRM DRIVER FOR SAMSUNG S6D7AA0 PANELS
+M:	Artur Weber <aweber.kernel@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
+F:	drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+
 DRM DRIVER FOR SITRONIX ST7703 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
-- 
2.40.0

