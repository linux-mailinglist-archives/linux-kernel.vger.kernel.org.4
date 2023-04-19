Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE16E716D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjDSDIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjDSDI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:08:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787187EC2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:08:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so2223213b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1681873700; x=1684465700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn1RBm/Mor5mDf6XpgrvR7fGB9zm/SepD40w5P+k+Fo=;
        b=CFDTP8UpamOjSkf6uSwJOpfoEuiWUQFQkpRmx0iuOyVqPiTd0RG1EizK+6m/2ENflQ
         zuvXS1EccxoMvzutlUsLWIQ0GKWF+zHw9ZIz6D87a19z3vrERVD//Dz+e9Ree6yCZe+9
         S3TUoEPer+uzdJo+Bo2qfHlWJupVYHAsxFVCZfTd1AN5d6BI0RDJasSzG/Crc6HuLTz5
         EGpIFM+AgVt2olBdg0YR1L+tuK/zLXOFQqCSaKEyQgHDI/bnyoDBvXAUWFbCL+g3CYv8
         bxiDHUoy6ZcX98Y78K1+cx+BOoPYoNQ4tNlSu/eyRlIUpgNJOPylspmFfjaS8EL3/4jN
         IKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681873700; x=1684465700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn1RBm/Mor5mDf6XpgrvR7fGB9zm/SepD40w5P+k+Fo=;
        b=H9h60BJn5/P/C0dE/asgind3ZyK/N63o8zIoMjt7q56U1KAFzbynPTh4Dgj7WErRpb
         Z9d2kFfTqYME0xxeXT7spX2+c6YCvHDusWxcVlDL/5Dfr4U7It+7b3ntF55FrdYe3QuW
         P19XNSwPrVEdDluZOvbsx4p/9pa2/bmMHxzvj+u9NBc2AGzLyiDevA91/csxmnVk47cC
         2vgTRTk0mnwemKCRkATxf5+i2WwhE2hplQwWXBFYPhoV6JNIYAnS0u++z1F926I2uJBn
         tUpX3lhBbn8skfWMWPZZt6Hdr71QiqKzl4611IeU8EyGCuSYOOT5TPL09I02C2pQlPsc
         WIWg==
X-Gm-Message-State: AAQBX9fmfzkXR1NGhLXG9PczAVHf9UrQXe1ONROaCikTCJmm54asNL8E
        ShwM7p/Z7vLpCJmZ8cwoa1ojjw==
X-Google-Smtp-Source: AKy350asA5G5VYeryy5kXjQ+H+m8URTVhHjZnwlLzTm1vK5ZivoG1Vzfns0ISy6SAVDuEobZ1E3z8A==
X-Received: by 2002:a05:6a00:ad0:b0:63d:2333:84e6 with SMTP id c16-20020a056a000ad000b0063d233384e6mr2130939pfl.33.1681873699794;
        Tue, 18 Apr 2023 20:08:19 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b00639a1f7b54fsm9900150pfo.60.2023.04.18.20.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:08:19 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@suse.com
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2 2/2] memcg, oom: remove explicit wakeup in mem_cgroup_oom_synchronize()
Date:   Wed, 19 Apr 2023 03:07:39 +0000
Message-Id: <20230419030739.115845-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZDUxVG2otm5i12o2@dhcp22.suse.cz>
References: <ZDUxVG2otm5i12o2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to
the charge path"), all memcg oom killers were delayed to page fault
path. And the explicit wakeup is used in this case:

thread A:
        ...
        if (locked) {           // complete oom-kill, hold the lock
                mem_cgroup_oom_unlock(memcg);
                ...
        }
        ...

thread B:
        ...

        if (locked && !memcg->oom_kill_disable) {
                ...
        } else {
                schedule();     // can't acquire the lock
                ...
        }
        ...

The reason is that thread A kicks off the OOM-killer, which leads to
wakeups from the uncharges of the exiting task. But thread B is not
guaranteed to see them if it enters the OOM path after the OOM kills
but before thread A releases the lock.

Now only oom_kill_disable case is handled from the #PF path. In that
case it is userspace to trigger the wake up not the #PF path itself.
All potential paths to free some charges are responsible to call
memcg_oom_recover() , so the explicit wakeup is not needed in the
mem_cgroup_oom_synchronize() path which doesn't release any memory
itself.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
---
v2: split original into two and improve patch description
---
 mm/memcontrol.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fbf4d2bb1003..710ce3e7824f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2003,15 +2003,8 @@ bool mem_cgroup_oom_synchronize(bool handle)
 	mem_cgroup_unmark_under_oom(memcg);
 	finish_wait(&memcg_oom_waitq, &owait.wait);
 
-	if (locked) {
+	if (locked)
 		mem_cgroup_oom_unlock(memcg);
-		/*
-		 * There is no guarantee that an OOM-lock contender
-		 * sees the wakeups triggered by the OOM kill
-		 * uncharges.  Wake any sleepers explicitly.
-		 */
-		memcg_oom_recover(memcg);
-	}
 cleanup:
 	current->memcg_in_oom = NULL;
 	css_put(&memcg->css);
-- 
2.25.1

