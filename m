Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA1660C48
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 04:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjAGDnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 22:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjAGDnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 22:43:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C5521B3;
        Fri,  6 Jan 2023 19:43:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so7208697pjj.2;
        Fri, 06 Jan 2023 19:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5qWs5TiJGPW/EDw2KXWPEsaSCWYGVrAbslcVFl/3Fs=;
        b=eBc5KvTLSvzQmnGq6Ti5p9SaLEb8oHku7eo/zzrqvPHTnNWD7jPCH+IScPF2BiNV66
         nIUI0DzOJlWwcBfvU91z77YvvWx6Zv5gDgEJLcPf+JVJi9RtvLDTAnG4QrbNARik2DcH
         WCeESg4DeUQ5Te1iO+nU1RXf1QT1OkBA53U6Jjwse32cXDc2HXHDv6FpGakEvEnUrm+U
         YyUt0MiWq8BkkuJ84FDwH93HZVJifRA6zzm3hPHG5EIxCA3OtanmKRG2mOGzeKrUKWOE
         GWZiId5RfycshJr2c3mAi8zhU2Tru9kyy96ew5kAJ6/Rr/UlHtuE4+dCcUgSglfObrZZ
         Qrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5qWs5TiJGPW/EDw2KXWPEsaSCWYGVrAbslcVFl/3Fs=;
        b=vkkxkESNayWuSyR0NAsUAdhaki0XUGme0Jvw9zVUErpu0SI9ukQVsmdSloz6U190wI
         ztvbuhi0zhyoYiSVjb6W+pkw8l6xfKZjMOe7O5toXzFZe35VkrPtUOcM3QbZ1rhR8e6w
         dd37JoBodNygrnY5JAYwRTCpIu0zWsemmFfmRteQj9299hDPBPTlpPCJGIak8xu544vW
         WE5ch4kEGJ9tlzJiwggQiSnk489XDZETPf9AnjeCfMkRhjajG3Pn6QsrxW6qpqLohrP3
         jiVfA7bJ6z4s4DqxL3l+5mwPj+kUgUb4AROieWMQFoT7NdpS4N6sZ3VBVrajY9KIDXF5
         wYPQ==
X-Gm-Message-State: AFqh2krBXSk/jckYN1vutfMPN9HsYmqAMvT0q2p2uxsfmzBKeqcHCMIu
        sHLabYYeOqKCx1qFg4T/ZIOhKSbgxJg=
X-Google-Smtp-Source: AMrXdXuVM9mF8FyJ4YSOfu0Of5hD4h5YbR1HDHqeCefSgGqYrJ2V0v7uJ72IhJYLeZRVNasunpYtVg==
X-Received: by 2002:a17:902:f80c:b0:185:441e:90dd with SMTP id ix12-20020a170902f80c00b00185441e90ddmr64501798plb.67.1673063023979;
        Fri, 06 Jan 2023 19:43:43 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b00186727e5f5csm1597728plb.248.2023.01.06.19.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 19:43:43 -0800 (PST)
From:   Quanfa Fu <quanfafu@gmail.com>
To:     rostedt@goodmis.or, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Quanfa Fu <quanfafu@gmail.com>
Subject: [PATCH] tracing/eprobe: Replace kzalloc with kmalloc
Date:   Sat,  7 Jan 2023 11:43:35 +0800
Message-Id: <20230107034335.1154374-1-quanfafu@gmail.com>
X-Mailer: git-send-email 2.31.1
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

Since this memory will be filled soon below, I feel that there is
no need for a memory of all zeros here. 'snprintf' does not return
negative num according to ISO C99, so I feel that no judgment is
needed here.

No functional change intended.

Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
---
 kernel/trace/trace_eprobe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 352b65e2b910..cd1d271a74e7 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -917,15 +917,13 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
 	for (i = 0; i < argc; i++)
 		len += strlen(argv[i]) + 1;
 
-	ep->filter_str = kzalloc(len, GFP_KERNEL);
+	ep->filter_str = kmalloc(len, GFP_KERNEL);
 	if (!ep->filter_str)
 		return -ENOMEM;
 
 	p = ep->filter_str;
 	for (i = 0; i < argc; i++) {
 		ret = snprintf(p, len, "%s ", argv[i]);
-		if (ret < 0)
-			goto error;
 		if (ret > len) {
 			ret = -E2BIG;
 			goto error;
-- 
2.31.1

