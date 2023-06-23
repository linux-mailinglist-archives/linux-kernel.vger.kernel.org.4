Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4873AF44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjFWEHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFWEHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:07:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0F2114;
        Thu, 22 Jun 2023 21:07:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3112f256941so198399f8f.1;
        Thu, 22 Jun 2023 21:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687493259; x=1690085259;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfr4aHtExKCjhX8/rfHVnmOqxjAsOewVsr3RQTrb4Ps=;
        b=PZGIC4e5GlPnSZSwaatuVGl+7FwpRbN7D3kl8h7U/PdQzYuJZ2lfvZvnHezsX45RCY
         Ncv2PlGe8MIK5Y/SgLxIbNIt5sbIimMtFdiKyfmQI0MxvWlXuaxcdLFroNrQZDMuQqUt
         Ae8/EUwr02EsrhZJo2upRM3Xp/ZBXDWvmvGx+KB1eskjb1vIegE6UMOLCnzL0J0MiDaR
         UhKIZ1JhYkJnJ172G0Z3QOzBSQ/brHtGqSUpJQk40Qr+KhAylFeOGyBm8H/7sg7TKFkv
         h0WjtYvg5vP4FyghFdBc+1sGkAqvnzj+mwKGZV+ANz3tRf4UV8yFnqr1SkD0BwmsNf+a
         mEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493259; x=1690085259;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfr4aHtExKCjhX8/rfHVnmOqxjAsOewVsr3RQTrb4Ps=;
        b=b78RKUi2PY1nS0XT+MwtV4ymEtCOAKbvUoTm+70GZM1EANJ3KeHKdQ6fzMNJo2c2Qq
         3vJaMKqN40aA68ptnUnCEKaCmiq3L6NJr7N4fD2+XiUcWbbs16oC35zrGTBOQZDZ6C7T
         ttEEzJUDBJ/WXKVjRseGi7kihcO+jdSVhRsGIrrDYNcp1jfcMGeL/cZRYoP4iSJXIRsl
         ELbNkzxWavJBDberXG0U6r3ly+mRLazQYaeuNKKCVbYPisxzYKA1c3qg+xCfbZUmX7zr
         BuFKOP4keY0irH5vLolmkhyEkz5caado5MC6GfA6U2/3TxArpG+WsFk9fLElYhn8O8Q0
         YT1w==
X-Gm-Message-State: AC+VfDwksJ1dL6jj+3bpz2xSIPSHJPpA7OW8SqcoH6TLxSEmmqXc2c6f
        zzslj83C4sKHaSTGhnMzm07uc6vZUdc=
X-Google-Smtp-Source: ACHHUZ4bJ7yS6ZD3ioE6Qng90F9n0ELRAyLZg88+aPuX+QJBSsmH1HUmvPgTqornneVCSn8kwE3pTw==
X-Received: by 2002:adf:d092:0:b0:307:7f38:37f with SMTP id y18-20020adfd092000000b003077f38037fmr13245166wrh.66.1687493259449;
        Thu, 22 Jun 2023 21:07:39 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:851e:d01d:5e81:992f])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d4d8d000000b003048477729asm8445713wru.81.2023.06.22.21.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 21:07:39 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust entry in VIA UNICHROME(PRO)/CHROME9 FRAMEBUFFER DRIVER
Date:   Fri, 23 Jun 2023 06:07:36 +0200
Message-Id: <20230623040736.9026-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d4313a68ec91 ("fbdev/media: Use GPIO descriptors for VIA GPIO")
moves via-gpio.h from include/linux to drivers/video/fbdev/via, but misses
to adjust the file entry for the VIA UNICHROME(PRO)/CHROME9 FRAMEBUFFER
DRIVER section.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Remove the file entry in VIA UNICHROME(PRO)/CHROME9 FRAMEBUFFER DRIVER, as
the new location of the header is already covered by the file entry
drivers/video/fbdev/via/.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88954a1c0017..e12ac544aa9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22415,7 +22415,6 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/via/
 F:	include/linux/via-core.h
-F:	include/linux/via-gpio.h
 F:	include/linux/via_i2c.h
 
 VIA VELOCITY NETWORK DRIVER
-- 
2.17.1

