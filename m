Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02F66A8707
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCBQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCBQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:41:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D680F26B9;
        Thu,  2 Mar 2023 08:41:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g3so14548309eda.1;
        Thu, 02 Mar 2023 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677775311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCbSLcdXBN5AxQderjzc9KOZWeLSCuHpmkG/hHKOcd0=;
        b=R364aA+zzF3hkjpWZsGbbClnipBuge10Ar+Cup44xKvbmdUt2gplOq0VgGcQaOI1BC
         Jo/8zWx9VfhlyzfPZGGJ/p5xAVt3WsMPmj1AggB7ly89zyPEpMK7sr3S38wMUW4SP5QF
         doXk1YbKu/mwJLxSfb0mZa5MplNeWlk31iawkQJcAAMU/qI+MBWM3uN6qWBcRTTMn37U
         M6xX2xL55z+BmLK14DtEnqJEMVZR28lBHiXmWATRRbEe6malRrXd3Ifphb+BC+bWb0ug
         DbdhrZqxlpqf9RfgkcSuYiDjX8pHjiSyoCb+CuBi2IpHrnJGUPeHcIWcbjAEeT+UPERK
         JB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677775311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCbSLcdXBN5AxQderjzc9KOZWeLSCuHpmkG/hHKOcd0=;
        b=oqNVO1C/txvjJA9h1+VHLmdGJHTMl56Xc9ptYw3fqqb3uH0vZ0tBLpzX4m/bubeJ+8
         vH2WOvKJSHVtnBA5DfKR9gsymtXfZGxW/XnVit7W33qnDYs6JKF5pGLI0aN3fIU/Lb/H
         eB0jgnfX6U0XUg5jXo2gdpRwYFF9BlB+T9NfALYzriCrCTiE/qWbDA2ER5Uw/dLPE72k
         RMdEm2DS3h5D6Z4lQYKrL2rl+/JPsCesAH7DTI7odwm6ldp2VnzTlLTWPnXe7Ux9Q8yY
         7m0pWhlxGXSN6ualpIXtKETSLaAHY0ztY4C+o9R6e8Xk0xjds93RI3gGeKlJsO+jODR8
         P+Aw==
X-Gm-Message-State: AO0yUKXUFOv6E+ojGCSW4lK/4ADdFqKSgcrt5hD1v5TBwjaLZRDdeQQc
        fZjqdNAsMvq+dsQA6BJ0Safhl6btL7fuAg==
X-Google-Smtp-Source: AK7set9MjHqRegLglKJSD7ou4x6e5GQF8LTrO8hjMwx30bYlYKTv8gONAHsZgVqvOuWqV8CTVPUcRA==
X-Received: by 2002:a17:906:3983:b0:88a:b6ca:7d3d with SMTP id h3-20020a170906398300b0088ab6ca7d3dmr10696112eje.8.1677775310982;
        Thu, 02 Mar 2023 08:41:50 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a22-20020a170906191600b008c327bef167sm7230998eje.7.2023.03.02.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:41:50 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 1/3] ring_buffer: Change some static functions to void
Date:   Thu,  2 Mar 2023 17:41:27 +0100
Message-Id: <20230302164129.4862-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302164129.4862-1-ubizjak@gmail.com>
References: <20230302164129.4862-1-ubizjak@gmail.com>
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
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
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

