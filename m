Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685D35F6E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiJFT3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiJFT3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C46BE2FB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665084569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=08jbpfBTd1YQoRYfrXDErR4SgE4lO6QGJjAUK4zNVW0=;
        b=FB7I0zDE3m8a0QZURjfAaKerlydmF4VgNHQwrL4X22CQd7FtaU6iIDjxFQT23nikLX6Z3G
        YgBmCBawVa7nkFWt5SOvRzjBlC5xfU0uc3sgy3oSnGuMfl8bCp0pLef4GKRFBpR2kAhpqM
        RJHU0AiYFPGEzYVF4AJPMfnzIT98+wM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-16-7SJL4xwNPFq3NUZ5TOkLlg-1; Thu, 06 Oct 2022 15:29:28 -0400
X-MC-Unique: 7SJL4xwNPFq3NUZ5TOkLlg-1
Received: by mail-oi1-f198.google.com with SMTP id f16-20020a05680814d000b003506268b99fso1507042oiw.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08jbpfBTd1YQoRYfrXDErR4SgE4lO6QGJjAUK4zNVW0=;
        b=YmLgRcn9ufpgKen2vHy0eDQlJM+WseG2/Xk+/AReRDlD6HWTn6PYIyXAczlvuVS/qx
         B0n3kVp2HKTZZ7svdvTcgdRazBny9DBkgflsMXcmTZo3CdOb+29JLmG4S5R1ssiXd5H3
         /GljUfH9SShDJCW3FbpGP18CFZRZRfqsjx/tbABWBk0kWRIt4DFUOMVeA1CqCR4e3Pe9
         poeXS0NoRVuBG7sSg+lrjW5/3FvtAUGZCSpiec0DgcagcnDT8H3SARfYuRoGBAq+gQTo
         h26sKZosUPrRTY3wHVMwAeK/wlaoAW3fqNTS8Xd33XYCsXZnKKjAgz0OcMfX+Phwd2Nf
         6EGw==
X-Gm-Message-State: ACrzQf19y3LGVJTnFXeU8NOlw0xRBsXXSigwTBGUEYOSVnHaLyNO4gNb
        UEya/oOrPuM8vG6igyTFV8Ayy80qQfR4bn7m3YVTGGO+wb6qWUOawQ76xEe6ERzG5z1K2xMkZmn
        s4C1rb/WWWol/eGT8P1HVUC8M
X-Received: by 2002:a05:6808:e90:b0:345:6ee0:9a68 with SMTP id k16-20020a0568080e9000b003456ee09a68mr633822oil.173.1665084566577;
        Thu, 06 Oct 2022 12:29:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Tft7TyzQPnpWaWyWuOlVkW+RxIUVgBIRxRwmiIs7DA8kbsZ6Pfmd2dIYuXYjbu29i+hBWDg==
X-Received: by 2002:a05:6808:e90:b0:345:6ee0:9a68 with SMTP id k16-20020a0568080e9000b003456ee09a68mr633803oil.173.1665084566347;
        Thu, 06 Oct 2022 12:29:26 -0700 (PDT)
Received: from localhost (pool-100-0-210-47.bstnma.fios.verizon.net. [100.0.210.47])
        by smtp.gmail.com with ESMTPSA id w107-20020a9d3674000000b00638ef9bb847sm170071otb.79.2022.10.06.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:29:25 -0700 (PDT)
From:   Eric Chanudet <echanude@redhat.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
Subject: [PATCH v2] mailbox: qcom-ipcc: flag IRQ NO_THREAD
Date:   Thu,  6 Oct 2022 15:28:56 -0400
Message-Id: <20221006192856.2546702-1-echanude@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PREEMPT_RT forces qcom-ipcc's handler to be threaded with interrupts
enabled, which triggers a warning in __handle_irq_event_percpu():
    irq 173 handler irq_default_primary_handler+0x0/0x10 enabled interrupts
    WARNING: CPU: 0 PID: 77 at kernel/irq/handle.c:161 __handle_irq_event_percpu+0x4c4/0x4d0

Mark it IRQF_NO_THREAD. This is an IRQ-multiplexer and as such it should
not be threaded, otherwise its child-interrupts would be invoked from
the thread handler which is not desired.

This is noticed by PREEMPT_RT, but also on a non-PREEMPT_RT kernel where
`threadirqs' has been used.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Changes since v1:
- Reformulate the patch description using Sebastian's response.

v1 can be found at
https://lore.kernel.org/linux-arm-msm/20221003170849.383005-1-echanude@redhat.com/

 drivers/mailbox/qcom-ipcc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 31d58b7d55fe..7e27acf6c0cc 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -308,7 +308,8 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
 		goto err_mbox;
 
 	ret = devm_request_irq(&pdev->dev, ipcc->irq, qcom_ipcc_irq_fn,
-			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, name, ipcc);
+			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND |
+			       IRQF_NO_THREAD, name, ipcc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
 		goto err_req_irq;
-- 
2.37.3

