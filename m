Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D03668B02
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjAMEtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjAMEtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:49:17 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C825B145
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:16 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id fd15so8340271qtb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKL+FkRBVGdlcDPsmoeX6zsOGWo6bw9MhMVT8FhJJdU=;
        b=ThajRpZiQS+ExcexJ90RPZlFJIxRsZQjG67taK6tWkRw9iMA3nan6BucM5DTe4h9zw
         VuF25zZYkp7yPwo26kEeiPLtEHt+4ZiKwSJ0sKf16Bdcuoz1Q04Sm6usexU2OigzL5Yi
         /iGZLdM4lZHliaMCBWlR1YYumF/AWcpL/1ZUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKL+FkRBVGdlcDPsmoeX6zsOGWo6bw9MhMVT8FhJJdU=;
        b=gdDaJfJlS2v8zQR2dVKV1mrGkBq5VcB4YrJaGaiKkXl9Odau0B1O7OJPiyweKuyVqf
         Q0Ewy6IEhSGQ1Yu6exi1wmhk4+OYIC5HnuK1MWph/ItFBHH7qXgbH3G+w4PIazNxr8Zh
         Gw27QAkHl2OYQr+MeIOIsmyGcLyLasUWMsvk2TdGzIXE0sUpIbbEjstxefnPFbjnn2Gt
         x54SHTcbu0j8C1B/yxKWIxrCVumYDjJfqpbtjgZMbFTb+MjyeHM6qC/LjJnSnJsM764N
         aFLtyNKAAWCHRZcuYciZ8YrVY8J0+F+zIcWfUU77oEU/3fSBPi41IiewYl3JI73CxkIn
         rJtQ==
X-Gm-Message-State: AFqh2kp2uVWYdE4HXWJDdulyvSqsolIEk5vTkl75T5cKfuuNqi0WxW2A
        F2af86jb3QaJisOAyc21m19NfA==
X-Google-Smtp-Source: AMrXdXu6WsXDkaK3qQyqiRnnE21ZhANn7yzKVtm6zCjaqywxitsRsQfF5r/SyGQmxC6Ta4YBcz0Ddg==
X-Received: by 2002:a05:622a:1e8c:b0:3ad:14d0:e8b8 with SMTP id bz12-20020a05622a1e8c00b003ad14d0e8b8mr27510609qtb.26.1673585355803;
        Thu, 12 Jan 2023 20:49:15 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:15 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Thu, 12 Jan 2023 23:49:08 -0500
Subject: [PATCH 2/4] um: Avoid pcap multiple definition errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230112-um-v1-2-6bec9e97ad13@pefoley.com>
References: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
In-Reply-To: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1145;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=6+vpUXmt9fMS9wiEsw48LBnr2Y8Q2+1VbsxVT5rxS4s=;
 b=ivWCsOmTeN9z2HCdfQL6ie4FA5ZbD21inE4lJMPPNuOfy5kT9In2CLmOBuwihABF5gX12oK1JB1R
 IxexZ61xBZ6QMNZ2ZjMihtKqGDBkWxJbBR7xVqq7XtCA1LMymnK9
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the function name in pcap_kern to avoid conflicting with
libpcap.a.

e.g.
ld: /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../lib64/libpcap.a(pcap.o): in function `pcap_init':
(.text+0x7f0): multiple definition of `pcap_init'; arch/um/drivers/pcap_kern.o:pcap_kern.c:(.text.unlikely+0x0): first defined here
---
 arch/um/drivers/pcap_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
index cfe4cb17694c..25ee2c97ca21 100644
--- a/arch/um/drivers/pcap_kern.c
+++ b/arch/um/drivers/pcap_kern.c
@@ -15,7 +15,7 @@ struct pcap_init {
 	char *filter;
 };
 
-void pcap_init(struct net_device *dev, void *data)
+void pcap_init_kern(struct net_device *dev, void *data)
 {
 	struct uml_net_private *pri;
 	struct pcap_data *ppri;
@@ -44,7 +44,7 @@ static int pcap_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
 }
 
 static const struct net_kern_info pcap_kern_info = {
-	.init			= pcap_init,
+	.init			= pcap_init_kern,
 	.protocol		= eth_protocol,
 	.read			= pcap_read,
 	.write			= pcap_write,

-- 
2.39.0
