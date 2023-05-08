Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8A6FBA23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjEHVpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjEHVo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:44:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADFB138
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:44:55 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6437923cca9so5120779b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683582295; x=1686174295;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YWAqI/Kk7C1aWuQUx3p0nPdIT/a5Kqtc/ZwtQTnIWi4=;
        b=7kGs2scBYldQX+e+k2+m1q6fU/9c9u6Vb1STUfW0e1BlcplFBmLBusMn2WStRMaf/q
         sDAJO5hcwd7J7ZOIW+DkVpSUtojg1OfxSIMuT17etWTdyr+NBdFb2taBNCBTNN9t/YCV
         j1TQTmlLCc2gIydnSJFQOsbiDBghwfZBZ3mtz5XNN4MTKct/vxS6dL30ngBYPtIh1d/A
         jOFXWgTnZLKRG0ha1QKL+yqW91DtGOlvfHFxk12e4bWsYfUSwnPkXFZaqLi/drexzaqQ
         v+4tA/R/ZBRFWxjBynQJynJRKBjrvtjpmgHMMwXcO4U1z8n5GqbHgRd8YsYCtAaQ8Y2v
         JDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683582295; x=1686174295;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWAqI/Kk7C1aWuQUx3p0nPdIT/a5Kqtc/ZwtQTnIWi4=;
        b=lpSd7MN23xa0gTcFfPzhwGAl7dfbtnuFAdMpn4dhco9QC0dkDBrjMZWZAjMFkfYqqm
         76aL/6ZqQZV8ZFqGF/IlIhpeIBNZd+JYZ7VclgVp3fNjYn0dsQmJxJ5VoHFJams3cj7a
         pXGOxDLf9zaePrMfrobRQiUo8N/FJTQkSJF4kDSguf3xMXFEnCk9cLBW7HUILq7xzs60
         rhc1yQjRuvfW1UUBkGNfAVVJrJHqBk24GlELLcyUTZoWzKSLMCZtv3LTjH5OekEIclpZ
         beWmuuPmsCjR4mfXUUAKJ55cUNODyWZTrBoYpqHBbLyjAUPMxcFM9XDyNMGzi8nn206X
         R1Tg==
X-Gm-Message-State: AC+VfDy+v55q6AnhctV9gsGYrr6N8SYsHNbuaUn21AjbmkivvijK872O
        AmwtCj1W2hhEaYPnKw1RWI6D4csvmnk=
X-Google-Smtp-Source: ACHHUZ61341pA9qEScQl2VDXrr3EWfRPmN1j2nEY8MJxum0m00avLJW6vDpsnFV9QEBwWteJvfIlUv/R0zA=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a05:6a00:d68:b0:643:6fa8:e7f4 with SMTP id
 n40-20020a056a000d6800b006436fa8e7f4mr3494658pfv.0.1683582294746; Mon, 08 May
 2023 14:44:54 -0700 (PDT)
Date:   Mon,  8 May 2023 21:44:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230508214443.893436-1-badhri@google.com>
Subject: [PATCH v1] usb: typec: altmodes/displayport: fix pin_assignment_show
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdbabiera@google.com, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes negative indexing of buf array in pin_assignment_show
when get_current_pin_assignments returns 0 i.e. no compatible pin
assignments are found.

BUG: KASAN: use-after-free in pin_assignment_show+0x26c/0x33c
...
Call trace:
dump_backtrace+0x110/0x204
dump_stack_lvl+0x84/0xbc
print_report+0x358/0x974
kasan_report+0x9c/0xfc
__do_kernel_fault+0xd4/0x2d4
do_bad_area+0x48/0x168
do_tag_check_fault+0x24/0x38
do_mem_abort+0x6c/0x14c
el1_abort+0x44/0x68
el1h_64_sync_handler+0x64/0xa4
el1h_64_sync+0x78/0x7c
pin_assignment_show+0x26c/0x33c
dev_attr_show+0x50/0xc0

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/altmodes/displayport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 8f3e884222ad..66de880b28d0 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -516,6 +516,10 @@ static ssize_t pin_assignment_show(struct device *dev,
 
 	mutex_unlock(&dp->lock);
 
+	/* get_current_pin_assignments can return 0 when no matching pin assignments are found */
+	if (len == 0)
+		len++;
+
 	buf[len - 1] = '\n';
 	return len;
 }

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1.521.gf1e218fcd8-goog

