Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D3F6A9A77
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjCCPRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCCPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:17:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08271969C;
        Fri,  3 Mar 2023 07:17:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so11520600edb.12;
        Fri, 03 Mar 2023 07:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677856652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5fcDJmBSqQASrUS8VChowm/7aLNy1wBEoT0cPfBX4k=;
        b=Ej5Zkdvy9ePkCDCTHrvJjMLnSQkKLuyND0SJU7GEWkvPbwBMMKkEe58t0mW4hQZp4L
         wD3InpR4NeZOKZlWnt+K7byMjPQTyWPm4mewu4KCJ08A3qrvAQs7SCqubKXx7NaIVIiE
         JaWe9QksnBDKk6LT3WP72HL0ZzP6fI2vfN5MUt5btos2bgOCyJ74ZWy/Q6j6F5pa8Qa0
         +H3R81xmIl8TdwHly4RESRRrUeoO/HJmNf+/SqNFmZ0oaJEexr3/2OsiE6D6wqUXgHtW
         6FPAQjk28w1b3Xq8I+aaLTNpM5KjkcbctwGTUzvaONdmtSDs+vWTkWxIOv89MkNWTp+o
         L5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5fcDJmBSqQASrUS8VChowm/7aLNy1wBEoT0cPfBX4k=;
        b=kszPHR8vohGTxr4qrMNx4BCCdRE/Kmiir1A+osKOpv6wlnny+/TLLU5oXZUaEZ8aXU
         7QqGVoS2KOrCE9Kl/EQdXNKv+0fOsLnAMyTTEhmZ3HNP7ss70Lbf3rTXwdJIeY3AGbM7
         aSARfh2aes150FtRNmRXUfTR/H/vpIINJAx+bjBJ52kP5PbefeeoEegz68V6VSTYRQqs
         YE4O+DTFEFHMJRUCGJt5WyWNK2pXgYzbCGyguuPvx/BsM2DLW45ojO7uziMpRVDPTuYY
         ABlLDHZAIfcTI/TlRq1QuRBi4Nqt0MOejeTd+02D6PCwh4gWNd/fBIFvaPrT3Cg6rHOi
         wnPQ==
X-Gm-Message-State: AO0yUKWyf9f2tY2mKTIMQ3X/E+lUT9TQxbcITKXzFHR50qjlWQc7Z/Xt
        sVQGnWcAxVKgRDa/1mwnINCR8h0FSOip6g==
X-Google-Smtp-Source: AK7set/4lcjLzYeHOJtpuDJo9ZjPnJJI2eaSBahq1FGLZHm/UR8ggT+Kb36qDQ/60079eqGRSewvpg==
X-Received: by 2002:aa7:c493:0:b0:4ae:eb0f:892e with SMTP id m19-20020aa7c493000000b004aeeb0f892emr1766910edq.20.1677856651945;
        Fri, 03 Mar 2023 07:17:31 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id o13-20020a1709062e8d00b008e22978b98bsm1048390eji.61.2023.03.03.07.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:17:31 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 1/3] ring_buffer: Change some static functions to void
Date:   Fri,  3 Mar 2023 16:17:04 +0100
Message-Id: <20230303151706.57851-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303151706.57851-1-ubizjak@gmail.com>
References: <20230303151706.57851-1-ubizjak@gmail.com>
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

The results of some static functions are not used. Change the
type of these function to void and remove unnecessary returns.

No functional change intended.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index af50d931b020..05fdc92554df 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1569,15 +1569,12 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 }
 
-static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
+static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 			  struct buffer_page *bpage)
 {
 	unsigned long val = (unsigned long)bpage;
 
-	if (RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK))
-		return 1;
-
-	return 0;
+	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
 }
 
 /**
@@ -1587,30 +1584,28 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
  */
-static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
+static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct list_head *head = rb_list_head(cpu_buffer->pages);
 	struct list_head *tmp;
 
 	if (RB_WARN_ON(cpu_buffer,
 			rb_list_head(rb_list_head(head->next)->prev) != head))
-		return -1;
+		return;
 
 	if (RB_WARN_ON(cpu_buffer,
 			rb_list_head(rb_list_head(head->prev)->next) != head))
-		return -1;
+		return;
 
 	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
 		if (RB_WARN_ON(cpu_buffer,
 				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
-			return -1;
+			return;
 
 		if (RB_WARN_ON(cpu_buffer,
 				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
-			return -1;
+			return;
 	}
-
-	return 0;
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
@@ -4500,7 +4495,6 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 	default:
 		RB_WARN_ON(cpu_buffer, 1);
 	}
-	return;
 }
 
 static void
@@ -4531,7 +4525,6 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 	default:
 		RB_WARN_ON(iter->cpu_buffer, 1);
 	}
-	return;
 }
 
 static struct buffer_page *
@@ -4946,7 +4939,6 @@ rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked)
 {
 	if (likely(locked))
 		raw_spin_unlock(&cpu_buffer->reader_lock);
-	return;
 }
 
 /**
-- 
2.39.2

