Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FA96B798F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCMNzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCMNzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:55:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1296828841
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:55:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id cy23so48945593edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678715712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RY44wE5Zf3Qg2T9mU72PQt2uHP5JYVZeIe8fJ7oNxPM=;
        b=pcGnzneuaKGE4blA3zuuNOqNY9NMtQDjpckvbe1I+lLf07kBZICQT7L3As0gtmwhgv
         6cIAL6PMjQ4ZVTEfHSlj74klXNN4DyrhbM3ujzSLnZBV9dxligmZNkiBZHWRSV+1S9o2
         151UDKg9FElIjqL5jwz/4KrJ51KUhNFfUK+LHPH/dyakaw+VjGcQEPyKraUl4I+ptMLX
         SltvBrXCXF3plq+lBWmLe1hGUg15EJwbeHSBgAQyh2srJkWnrKdgqYJuD+SjGobqI+Mt
         5/2U9KgROelHxnSvalJp9VhtZT4wOanaogjQKXKTALBkhYkYsuVLbNLxYjeawtGfJ5nR
         IYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY44wE5Zf3Qg2T9mU72PQt2uHP5JYVZeIe8fJ7oNxPM=;
        b=KwhiERRpNI+sCdhP1kysCfWs8RHVVO9fLLz711UUhKfvGoOhX0Ji4EfuJr5sV49xKy
         rIhUV+0klPqovkub0RUh3BnYg3Bz/zpkX2Hooi1N9fjdXeSbgF8gIPgRM+OC0QVvvJg+
         2+m723EgGTa88Le8vMXPJAG5WpsWcKxVmT/Mh8/OO8e/zexM06Sz3cRYqu5CS9PACxmL
         E8xaWCTHnCWpPhAUdE7X3fgLcRlevKSt/8PBhlhgTtWjcnxlOJcki822YGJC1odgMW1J
         Ho2j8Q/Rkp3WBrm0CekfuSGgs2vT5Cm09gO2bM/uKN5MR7wnnYaoTWpR1hs9SVJHQtpc
         fK1A==
X-Gm-Message-State: AO0yUKVkbgb4UTNkPdzxK/gGjLMd6ZNr16aay7ynAuSKJxRlwg6Ttx3M
        pOwVuGZRQ1WTa3DWtQII2tM=
X-Google-Smtp-Source: AK7set/oUpv9sBq1JPG9coxkkekJhneZsLg56G1jZS+XVI5QRGYu30go1o76ONx7s2BXms9DRo/hTw==
X-Received: by 2002:aa7:dad2:0:b0:4fb:fd9f:7372 with SMTP id x18-20020aa7dad2000000b004fbfd9f7372mr4275567eds.8.1678715712509;
        Mon, 13 Mar 2023 06:55:12 -0700 (PDT)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id t29-20020a50d71d000000b004fb419921e2sm2100094edi.57.2023.03.13.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:55:12 -0700 (PDT)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Mon, 13 Mar 2023 14:54:50 +0100
Subject: [PATCH v2 2/2] drm/nouveau/clk: avoid usage of list iterator after
 loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230301-drm-nouveau-avoid-iter-after-loop-v2-2-1e6428cc7fa8@gmail.com>
References: <20230301-drm-nouveau-avoid-iter-after-loop-v2-0-1e6428cc7fa8@gmail.com>
In-Reply-To: <20230301-drm-nouveau-avoid-iter-after-loop-v2-0-1e6428cc7fa8@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678715710; l=1752;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=+zVBUXeTd83iixQiNFVbeFsaMnjJfrzAURHoSipLKdE=;
 b=+Ppw0na6R2sFWbyq4/6Xs6V1INOYzd/bKFad33nQ+IyQdKHYoeWHWQPP5Vy45XD7U8t4YJZ2Kd84
 xukkecmDBAbu5sAbRfBxiBNJg8Hj8Ty1jNCO8Cg/hDBEqRXkD2qT
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If potentially no valid element is found, 'pstate' would contain an
invalid pointer past the iterator loop. To ensure 'pstate' is always
valid, we only set it if the correct element was found. That allows
adding a WARN_ON() in case the code works incorrectly, exposing
currently undetectable potential bugs.

Additionally, Linus proposed to avoid any use of the list iterator
variable after the loop, in the attempt to move the list iterator
variable declaration into the macro to avoid any potential misuse after
the loop [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index da07a2fbef06..d914cce6d0b8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -269,14 +269,18 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int pstatei)
 	struct nvkm_subdev *subdev = &clk->subdev;
 	struct nvkm_fb *fb = subdev->device->fb;
 	struct nvkm_pci *pci = subdev->device->pci;
-	struct nvkm_pstate *pstate;
+	struct nvkm_pstate *pstate = NULL, *iter;
 	int ret, idx = 0;
 
-	list_for_each_entry(pstate, &clk->states, head) {
-		if (idx++ == pstatei)
+	list_for_each_entry(iter, &clk->states, head) {
+		if (idx++ == pstatei) {
+			pstate = iter;
 			break;
+		}
 	}
 
+	if (WARN_ON(!pstate))
+		return -EINVAL;
 	nvkm_debug(subdev, "setting performance state %d\n", pstatei);
 	clk->pstate = pstatei;
 

-- 
2.34.1

