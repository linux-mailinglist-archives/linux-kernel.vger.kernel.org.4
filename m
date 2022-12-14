Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1666064CB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbiLNNrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiLNNrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:47:16 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93A26AC7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:47:13 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-14455716674so16624445fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4ljuQ7r5eawTP9AYtmQg66pjpmwPq6OF2qaNotjINk=;
        b=B3XFXhZiDgd0oWwQL7Yd6aRgTziZcIYOgQ+ij1bK3M0gH+yczzesPE1QbLF525gMID
         nJCA61BKcmKKD2DbicC20B3vniRev/z8PPQzI+VFYrNawiP8XDOdXRgZjMa3RqMh9a+n
         1/gsR/KXYuOx+x9Dsa8FR1XBrvacmAdpz8EElz1XY7cFi3+yV67ZVsifRwWdDmBmWyBj
         CGno38lQ9/4+Bpy2mP+VBQ58jH7go2ZYVR+lBHOB90NBl/65bzdo2ALU7Z+BLm0JZf26
         P1dumJc38CE+XXsxcZVOKx1V2YXg9GRgU3fJkLiHFtvUGejQBjCP4Q3YCwvrac4HEGOR
         LDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4ljuQ7r5eawTP9AYtmQg66pjpmwPq6OF2qaNotjINk=;
        b=fJfmzrKzvPlo+eNoVftY0ab82IQ4OFDNV+eo/D5bZz4VyuvoMXSLC2zymRxFkO0FE3
         3wvDUqX6XijXFqrVloiHtW/L978gT360Sv56AzSI24FCPnTinbY3AXJNW1X2GY8j2wZ+
         yUmcXmWSBffmqgtkWPILN5rbYMXJZzg6TfDzRFMhnGoAbsuXRuqJkgtTwqOaSl9shMir
         fjA4je0llF+ABY5KhenE4PcZpSTqnvkhpc4wrYb4JySyb7534Od7VsVa4s6P4Y6MXpZ5
         rOIhXrbVWHq9yDajsrusKTVYFC1nIuqkn/oN7lOibPE1/A7ysiGaBWjB4PcPdPAAE9bZ
         RPGQ==
X-Gm-Message-State: ANoB5pk2BxUcg6geFraU/UdZ60E3NGfi5DWBXqpTzh6KWVkPtzDf/1pZ
        pkm0TUNieFDDadI615GyNQ+S4hu3WW2dSg==
X-Google-Smtp-Source: AA0mqf4VFIY2+bpRdwaQRvye7iKujy/Q14kTtAZ8E+HbmKenirz27SRBunSxaOiw/RqnxJTFwZIANw==
X-Received: by 2002:a05:6870:b420:b0:13b:6696:578a with SMTP id x32-20020a056870b42000b0013b6696578amr12098053oap.53.1671025631803;
        Wed, 14 Dec 2022 05:47:11 -0800 (PST)
Received: from MBP.lan ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id n39-20020a056870972700b0013bc40b09dasm2742455oaq.17.2022.12.14.05.47.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 05:47:11 -0800 (PST)
From:   Schspa Shi <schspa@gmail.com>
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com,
        syzbot+c92c6a251d49ceceb625@syzkaller.appspotmail.com
Subject: [PATCH v2] umh: fix out of scope usage when the process is being killed
Date:   Wed, 14 Dec 2022 21:46:56 +0800
Message-Id: <20221214134656.21228-1-schspa@gmail.com>
X-Mailer: git-send-email 2.37.3
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

When the process is killed, wait_for_completion_state will return with
-ERESTARTSYS, and the completion variable in the stack will be unavailable,
even freed. If the user-mode thread is complete at the same time, there
will be a race to use a unavailable variable.

Please refer to the following scenarios.
            T1                                  T2
------------------------------------------------------------------
call_usermodehelper_exec
                                   call_usermodehelper_exec_async
                                   << do something >>
                                   umh_complete(sub_info);
                                   comp = xchg(&sub_info->complete, NULL);
                                   /* we got the completion */
                                   << context switch >>

    << Being killed >>
	retval = wait_for_completion_state(sub_info->complete, state);
	if (!retval)
		goto wait_done;

	if (wait & UMH_KILLABLE) {
		/* umh_complete() will see NULL and free sub_info */
		if (xchg(&sub_info->complete, NULL))
			goto unlock;
        << we can't got the completion, because T2 take it already >>
	}
	....
	return retval;
}

/**
 * the completion variable in stack is end of life cycle.
 * and maybe freed due to process is recycled.
 */
                                   -------- BUG here----------
                                   if (comp)
                                       complete(comp);

To fix it, we can add an additional wait_for_completion to ensure the
completion object is completely unused. And this is what
kthread_create_on_node does to handle this race.

Reported-by: syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com
Reported-by: syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com
Reported-by: syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Reported-by: syzbot+c92c6a251d49ceceb625@syzkaller.appspotmail.com
Signed-off-by: Schspa Shi <schspa@gmail.com>
---

v1->v2:
  - Use a new way to fix the race as kthread_create_on_node do.
  - Optimize comments and use more accurate words to describe the problem.

 kernel/umh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/umh.c b/kernel/umh.c
index 850631518665..d8350a195c7f 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -452,6 +452,10 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 		/* umh_complete() will see NULL and free sub_info */
 		if (xchg(&sub_info->complete, NULL))
 			goto unlock;
+		/*
+		 * umh_complete will call complete() shortly.
+		 */
+		wait_for_completion(&done);
 	}
 
 wait_done:
-- 
2.37.3

