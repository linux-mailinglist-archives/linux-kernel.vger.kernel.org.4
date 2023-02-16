Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD42698A29
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBPBjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBPBjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:39:49 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC81460BE;
        Wed, 15 Feb 2023 17:39:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id dr8so1491361ejc.12;
        Wed, 15 Feb 2023 17:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=baCgf247aKa2TbgJPaFGuC/xQDQ/fJaWhZ2ZJNR1qUI=;
        b=NVAZhArqamb6Vu5aWK4HGmDcgxpj6Ds4yBBzsiezVZeOz8wvpA+MsvkFLc9bXSVJKB
         ToZFSZlfkrd5ODpUten0X32c+/3L+eY/FpKT/70bns1K1rWF/BwRrazUbL/J0lfQDN3l
         tcL1TvS0d7aHGjQcP2Y+nkt7NeJfujdPfzQEedE6lwSOHK8/AuGEYwWC3VmigAvfZfqK
         uZP27zQNCqDRiw8fsRZelUbTxd6/zzH8B4IvdRchCoVaXR/hWRH5fOim0MNOLXLT9Wv+
         Mix79QsLpLdS+LG7mcOo486cBTJdHsfC7ZKxTYHleWOU+KrdomROEf5WuYIwej3KqU2x
         7XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baCgf247aKa2TbgJPaFGuC/xQDQ/fJaWhZ2ZJNR1qUI=;
        b=dMaEQRRuqCGJPlGEJbLbrrSUB+ik+ogA2To0UHcj00F7EFHeVO2YmlOvfrjiPItKTa
         KVevBXHe2kc70Nw1UiF7uyhJe58dAGjoEPi9nW3JoAwx1xhtMifP0rinsR62uNKbUnU1
         HuwK8pIKqYVl7pm4PmPxnaxvZ+2kJldVKz1FkuhFjvUNbLeZDYOL63ZA7N9HNvIi+kYb
         D5+bwhPyAOMfeYrjtZw90JEFSRkHi9x2cebtnTsgfhp0LsT+anxYglMoNUaR9tdTlKu7
         BxGbAJvmZcaIIgwAdLB1BnCUePWfevTrJPjYjhGXgjEoeNeJOm6pCx9GBQPHTmvmxxYH
         Bntg==
X-Gm-Message-State: AO0yUKXfUp4i9nmhYc5wFEGFxwLfp+mDSsfO4K6Jf74Y1vUpfeJRU0Kd
        bMH0i4zXWye8LlU1z+6HInVYvn+Y3RSDqNlH
X-Google-Smtp-Source: AK7set8eCDLr8j3KGb/GwZNd0CjttI/ZuImTr7X4gxOdiX8Gl2eEzzbYHTgljlxU1SU0IXobKMT5Ag==
X-Received: by 2002:a17:906:f1d4:b0:8aa:c0d5:166d with SMTP id gx20-20020a170906f1d400b008aac0d5166dmr5027724ejb.71.1676511462256;
        Wed, 15 Feb 2023 17:37:42 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id k2-20020a508ac2000000b004aac44175e7sm152937edk.12.2023.02.15.17.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:37:41 -0800 (PST)
Date:   Thu, 16 Feb 2023 02:37:15 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] Don't test for NULL firmware before releasing
Message-ID: <1af763de-dbb8-a6f8-1a8a-2d76610d8776@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 4fe34831e2e7677b1c9616356f0a2e0a36ec092f Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Thu, 16 Feb 2023 02:33:05 +0100
Subject: [PATCH] Don't test for NULL firmware before releasing

release_firmware() tests for a NULL pointer itself, no need to do it up-front.

Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>

---
  drivers/gpu/drm/tegra/falcon.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/falcon.c b/drivers/gpu/drm/tegra/falcon.c
index c0d85463eb1a..ae599441f031 100644
--- a/drivers/gpu/drm/tegra/falcon.c
+++ b/drivers/gpu/drm/tegra/falcon.c
@@ -153,8 +153,7 @@ int falcon_init(struct falcon *falcon)

  void falcon_exit(struct falcon *falcon)
  {
-	if (falcon->firmware.firmware)
-		release_firmware(falcon->firmware.firmware);
+       	release_firmware(falcon->firmware.firmware);
  }

  int falcon_boot(struct falcon *falcon)
-- 
2.39.2

