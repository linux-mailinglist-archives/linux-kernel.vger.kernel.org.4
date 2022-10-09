Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1706E5F8A58
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiJIJSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJIJSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:18:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64342B63D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:18:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so8081372plo.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=260/9mSp6N4PpoN+t1d8Szrje/MbRn7Uh6Ecn3s2qCU=;
        b=zJER6xqZquJ/D6Jn6QCwMKJQKP0O8vuTCfztN0u7I4uVIW8F9fysfOJhyloKWH03b9
         rT1mwwjyFDrbMIk6uUuB1va9N6qkz6dfHnKLsvX36Om4cILlHvh90JnI3/MkIE27+DOL
         BVbKeCLk/OOHz0qYSWO1VFVV6nesf2YOzWHOGfZLlRMESh6eoBzCM5KbiMfHHTkisquB
         0BYHKDWu+REcQozKfAcqNSxNxhE0WsLoRKsObc9YQHBXAvutEY6JJirtUxzvzzyYQOHJ
         CIinOXqVH5g1dPDi20DbS5k6XJnXdmwUuUcB11dN7OPMld8FztoBkSd3NmpyPj1sjkcq
         Q+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=260/9mSp6N4PpoN+t1d8Szrje/MbRn7Uh6Ecn3s2qCU=;
        b=5QMUeXdckoJy0cDIwg5Xqedxb7lWUuABVdZqt3W3xbMC57Qzj4mJDIFX8IphTfDNJL
         SKvet/4gxCtSviJLPlfpW+GOarUT03/9nSDEi802dmrCzrdk3WiktZmqvgskXCPmk/hW
         j7u1CVmKyGf9Yfpl+jhTyXDCQec8dDrn9nRR4JjAApxtZuAhSZioBCEHqMN7y/gYQpT+
         f/8aGUtNcLnlYN2lazfiGg961zHIWzOd+tpIaa86VAQWVGv/cYEFTZRGCWXnP/JWJljf
         YnjSPCWVeGMyd7JvgFj3OCAtZ9pyHPh6WX53oqsWUkRw2qj2f2TwZxKSPYB5Q0oPpRp7
         UcgA==
X-Gm-Message-State: ACrzQf2YDJeXkDVbU58kpbfbZUvO7kCjZ/ky/YIAB9PCnR39FjOfso+F
        xc2i6rnBm4dhhy8S8vuaoQjIGw==
X-Google-Smtp-Source: AMsMyM7rJdAD6jzLSqpd5byQGnIXhnyu1XJxY73dndrP6nl4twcAIGjdUQT+yuvVkQdugSwgSiCLSg==
X-Received: by 2002:a17:902:bb96:b0:17d:9ed7:e9af with SMTP id m22-20020a170902bb9600b0017d9ed7e9afmr13013182pls.15.1665307110193;
        Sun, 09 Oct 2022 02:18:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id f38-20020a635566000000b004405c6eb962sm4328711pgm.4.2022.10.09.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:18:29 -0700 (PDT)
From:   Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH v2 3/3] ipmi: fix memleak when unload ipmi driver
Date:   Sun,  9 Oct 2022 17:18:11 +0800
Message-Id: <20221009091811.40240-4-zhangyuchen.lcr@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221009091811.40240-1-zhangyuchen.lcr@bytedance.com>
References: <20221009091811.40240-1-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the IPMI disconnect problem, the memory kept rising and we tried
to unload the driver to free the memory. However, only part of the
free memory is recovered after the driver is uninstalled. Using
ebpf to hook free functions, we find that neither ipmi_user nor
ipmi_smi_msg is free, only ipmi_recv_msg is free.

We find that the deliver_smi_err_response call in clean_smi_msgs does
the destroy processing on each message from the xmit_msg queue without
checking the return value and free ipmi_smi_msg.

deliver_smi_err_response is called only at this location. Adding the
free handling has no effect.

To verify, try using ebpf to trace the free function.

  $ bpftrace -e 'kretprobe:ipmi_alloc_recv_msg {printf("alloc rcv
      %p\n",retval);} kprobe:free_recv_msg {printf("free recv %p\n",
      arg0)} kretprobe:ipmi_alloc_smi_msg {printf("alloc smi %p\n",
        retval);} kprobe:free_smi_msg {printf("free smi  %p\n",arg0)}'

Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index c8a3b208f923..bd522868efef 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3710,12 +3710,15 @@ static void deliver_smi_err_response(struct ipmi_smi *intf,
 				     struct ipmi_smi_msg *msg,
 				     unsigned char err)
 {
+	int rv;
 	msg->rsp[0] = msg->data[0] | 4;
 	msg->rsp[1] = msg->data[1];
 	msg->rsp[2] = err;
 	msg->rsp_size = 3;
-	/* It's an error, so it will never requeue, no need to check return. */
-	handle_one_recv_msg(intf, msg);
+
+	rv = handle_one_recv_msg(intf, msg);
+	if (rv == 0)
+		ipmi_free_smi_msg(msg);
 }
 
 static void cleanup_smi_msgs(struct ipmi_smi *intf)
-- 
2.30.2

