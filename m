Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3F5F763A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJGJ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJGJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:26:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E56FDB7E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:26:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 70so3935642pjo.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD3O1L1ojBhgR+j1WVoN6w4Vq4fXYzVbRBriwzwY8XQ=;
        b=OwW1Pnkg6++3R7dfzassb1BzGQNvxGiMWgBknPF6qEVCitKiSpSdB0a2z4A4hu0rJS
         o1Dxd4LzyKUxW1nfhBLLz3HgMz8PpMWbFXkgyS5o5qDZRhb2pmkR4WTxtNcstz831Cmm
         hs08O0AmhERjCNky7UutIISJB4vpnaYrYkw1Aad/E0SZSKSpUsHaXMK3YBuksVXxgiAt
         /uBWosUhzlupHlUKHu2oPRu3/vJ3DYkvzHepFyz8si4gbWQReryzXjMGnIIdG6pZPQw/
         rjqEzhqrZ0mCfR3X+OpJoF82Jc0JOVx0R7BydFGH9k7iCmkaqP17g0TdaVp5cMOCwJ77
         S1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zD3O1L1ojBhgR+j1WVoN6w4Vq4fXYzVbRBriwzwY8XQ=;
        b=P+gSYr/6KKOSTqz+2sk1aK2IQMHT03Vwk6MttMrJB8zfmvQFmejLOXB9RZEE5+Lo6C
         HBD5o3p3e7QYSA1DPQCOPfsWCG642le3mpEjC1n2LMfXoI6i6J0wmZhBQtl3SSXw+EG/
         ToDmGIMAdjKcyipqD8JNryj+OIQZdIIJv9tYyMoRTUITj4n3oKahAdVG9qmvkciKMNxF
         5tkykGwPib0LwGrWJ5LqSsOFw7QCoDd0TM4uB5nSK3XZXga6GSfJ+71ITG07zA6XShHa
         S9d8kUSWPFdJ8MQ8PJZDnEEkGeLYYEjaqfM4PMXXyJ++rqAmT/zLR5zhGQclppBHM291
         f2qw==
X-Gm-Message-State: ACrzQf3P7usZo6R3CzEwUxeinUu+UW2c2q+MOygN4VsJL+railc1hxbl
        paqXZDWptKIlgJ1Lgp+ALcNQEw==
X-Google-Smtp-Source: AMsMyM62HDWdtXV+hj6G0UxkKeuYhoJ/5th07sKDOtsbYnp8MUdIF1o9hB5IycxViMiliwGEcgof9w==
X-Received: by 2002:a17:90b:1bc2:b0:200:a97b:4ae5 with SMTP id oa2-20020a17090b1bc200b00200a97b4ae5mr4483809pjb.147.1665134797159;
        Fri, 07 Oct 2022 02:26:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b0016ef87334aesm1069394plf.162.2022.10.07.02.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:26:36 -0700 (PDT)
From:   Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH 3/3] ipmi: fix memleak when unload ipmi driver
Date:   Fri,  7 Oct 2022 17:26:17 +0800
Message-Id: <20221007092617.87597-4-zhangyuchen.lcr@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
References: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
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
 drivers/char/ipmi/ipmi_msghandler.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index c8a3b208f923..7a7534046b5b 100644
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
 	/* It's an error, so it will never requeue, no need to check return. */
-	handle_one_recv_msg(intf, msg);
+	rv = handle_one_recv_msg(intf, msg);
+	if (rv == 0)
+		ipmi_free_smi_msg(msg);
 }
 
 static void cleanup_smi_msgs(struct ipmi_smi *intf)
-- 
2.30.2

