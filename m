Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E345BA6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIPGcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIPGb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:31:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CB7726B0;
        Thu, 15 Sep 2022 23:31:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 78so19427927pgb.13;
        Thu, 15 Sep 2022 23:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZmowVWWRmWocJjPgWDw2ZalH/Av3o/R31s38SjsWoiI=;
        b=K8iwJPV0dZif8U+5GjpaEh333xmUojgSqrpCXhk94yfRb5731bgocIRuX/EDCI9SvW
         rR/zBCM/ZijUHjs3V+//iPjM1dU2wd5Enf/hTOLs32ho/K8A755MsW99g8tQCwhLzwqo
         jt/N8/RlaQW7xAkQwVGWDehT2NpdJtcLTzMbMuVJFsdS7nAp/ikElttEU8BVJpfGbQpO
         m+cjovW/oroujWx+2TCw2PaFVIIE02AOHAeB0tnCMvFzQA1vqE7PiPXvC23M/FR2XFKr
         oQsRj9S45QPZ2bGm7vm2uS31u2elXivEH/itahepzQ7U0CXSVKKLGGPCdNeV2WUroSwW
         VNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZmowVWWRmWocJjPgWDw2ZalH/Av3o/R31s38SjsWoiI=;
        b=YNpMIx1ZzJnu/vuXvFdh1xJbINBBkj0wp/LrMEzEiNH6pneodQbgy6YalwOEuhpPCT
         dbjy7xqBqE7gIXuFoc6tPtXvWZcruETCxamyET2igh+GSB7vhaVNUuz1jg6NmyybwKUi
         iQ83xGES8+mhb36ulGZYvhrPF72QRlSH++LgPu/yNWea5N6qWh3tcjnXF1Thpw1nM8Yy
         Fn/3fOBRuWMlveYVBbGs3nisEFQMwCBt9wjRtMr7k2ba92bMLw0+Q3bYsmH3sCG/H4Rt
         IvRxxoFz0v4MmZ/3RhqgDgdyv59Hr+Woj9zYiTZUKxwbPjA8ja6wHoCeBCyv0ys+QsXr
         nEQg==
X-Gm-Message-State: ACrzQf2ohDNcgWj96iauXMDVtwUXBJUSzeefyKqrD0JWAMdIIkNeeWs2
        4Tg7YWqARoImJYxp9+QVMrqfnKG9mTM=
X-Google-Smtp-Source: AMsMyM6uCFnr0zMkH2Fblyo61mCd4o4GMS/d2jGZqVplmezgaEe+fdsJwx1cUQVqtDOJQYy8wyq4+Q==
X-Received: by 2002:a05:6a00:b8d:b0:545:e7de:78e5 with SMTP id g13-20020a056a000b8d00b00545e7de78e5mr3266569pfj.72.1663309916926;
        Thu, 15 Sep 2022 23:31:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b001fbb6d73da5sm735561pjb.21.2022.09.15.23.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:31:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     sumit.semwal@linaro.org
Cc:     christian.koenig@amd.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>
Subject: [PATCH] dma-buf: use strscpy() is more robust and safer
Date:   Fri, 16 Sep 2022 06:31:52 +0000
Message-Id: <20220916063152.155257-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/dma-buf/dma-buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index dd0f83ee505b..51cdd4060539 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -50,7 +50,7 @@ static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
 	dmabuf = dentry->d_fsdata;
 	spin_lock(&dmabuf->name_lock);
 	if (dmabuf->name)
-		ret = strlcpy(name, dmabuf->name, DMA_BUF_NAME_LEN);
+		ret = strscpy(name, dmabuf->name, DMA_BUF_NAME_LEN);
 	spin_unlock(&dmabuf->name_lock);
 
 	return dynamic_dname(buffer, buflen, "/%s:%s",
-- 
2.25.1
