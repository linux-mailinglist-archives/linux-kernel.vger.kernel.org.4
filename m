Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3E5EF1ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiI2J1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiI2J0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:26:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B713E7C2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:26:46 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e75e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e75e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 912591EC064F;
        Thu, 29 Sep 2022 11:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664443600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=gWjLX0XrWEHTuwnj47hhxQx9fIE75Bt4t5rtFB3qxnk=;
        b=GtusXaOZSeaj2O/yXQx3c9agySixhE/S4b9m43/gpODRarGKPiSq14BDTjXzKS9x9v/SNL
        Y63qzT8aRIvmxF80fo9p3Ep7wRuGn+G31/K34s+j0Q7wkEDoI5gtiAlAhp2S0jHUg5Cvzx
        Nk2SV4wZ2vqULAHQ84eRuUtMye0tXEU=
Date:   Thu, 29 Sep 2022 11:26:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: INFO: task rcu_gp:3 blocked for more than 122 seconds.
Message-ID: <YzVkyxSjifFghj8H@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Mr. Z says I should show this to you.

It is latest Linus + latest tip/master. Happens at boot on one of my
test boxes.

[  249.149378] INFO: task rcu_gp:3 blocked for more than 122 seconds.
[  249.155726]       Not tainted 6.0.0-rc7+ #1
[  249.160025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.168000] task:rcu_gp          state:I stack:0     pid:3     ppid:2      flags:0x00004000
[  249.176483] Call Trace:
[  249.178997]  <TASK>
[  249.181171]  __schedule+0x38f/0x1490
[  249.184864]  schedule+0x5d/0xe0
[  249.188086]  rescuer_thread+0x2f8/0x390
[  249.192044]  ? worker_thread+0x3f0/0x3f0
[  249.196043]  kthread+0xe6/0x110
[  249.199282]  ? kthread_complete_and_exit+0x20/0x20
[  249.204179]  ret_from_fork+0x22/0x30
[  249.207914]  </TASK>
[  249.210157] INFO: task rcu_par_gp:4 blocked for more than 122 seconds.
[  249.216785]       Not tainted 6.0.0-rc7+ #1
[  249.221040] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.228974] task:rcu_par_gp      state:I stack:0     pid:4     ppid:2      flags:0x00004000
[  249.237449] Workqueue:  0x0 (rcu_par_gp)
[  249.241437] Call Trace:
[  249.243944]  <TASK>
[  249.246099]  __schedule+0x38f/0x1490
[  249.249743]  schedule+0x5d/0xe0
[  249.252941]  rescuer_thread+0x2f8/0x390
[  249.256831]  ? worker_thread+0x3f0/0x3f0
[  249.260811]  kthread+0xe6/0x110
[  249.263997]  ? kthread_complete_and_exit+0x20/0x20
[  249.268836]  ret_from_fork+0x22/0x30
[  249.272482]  </TASK>
[  249.274699] INFO: task slub_flushwq:5 blocked for more than 123 seconds.
[  249.281463]       Not tainted 6.0.0-rc7+ #1
[  249.285692] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.293596] task:slub_flushwq    state:I stack:0     pid:5     ppid:2      flags:0x00004000
[  249.302039] Call Trace:
[  249.304535]  <TASK>
[  249.306669]  __schedule+0x38f/0x1490
[  249.310314]  schedule+0x5d/0xe0
[  249.313496]  rescuer_thread+0x2f8/0x390
[  249.317388]  ? worker_thread+0x3f0/0x3f0
[  249.321355]  kthread+0xe6/0x110
[  249.324536]  ? kthread_complete_and_exit+0x20/0x20
[  249.329380]  ret_from_fork+0x22/0x30
[  249.333019]  </TASK>
[  249.335236] INFO: task kworker/0:0:6 blocked for more than 123 seconds.
[  249.341926]       Not tainted 6.0.0-rc7+ #1
[  249.346157] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.354062] task:kworker/0:0     state:I stack:0     pid:6     ppid:2      flags:0x00004000
[  249.362506] Workqueue:  0x0 (rcu_par_gp)
[  249.366471] Call Trace:
[  249.368953]  <TASK>
[  249.371087]  __schedule+0x38f/0x1490
[  249.374724]  schedule+0x5d/0xe0
[  249.377897]  worker_thread+0xbc/0x3f0
[  249.381599]  ? process_one_work+0x580/0x580
[  249.385821]  kthread+0xe6/0x110
[  249.389009]  ? kthread_complete_and_exit+0x20/0x20
[  249.393851]  ret_from_fork+0x22/0x30
[  249.397489]  </TASK>
[  249.399713] INFO: task kworker/0:0H:7 blocked for more than 123 seconds.
[  249.406479]       Not tainted 6.0.0-rc7+ #1
[  249.410710] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.418614] task:kworker/0:0H    state:I stack:0     pid:7     ppid:2      flags:0x00004000
[  249.427053] Workqueue:  0x0 (events_highpri)
[  249.431608] Call Trace:
[  249.434336]  <TASK>
[  249.436697]  __schedule+0x38f/0x1490
[  249.440554]  schedule+0x5d/0xe0
[  249.443952]  worker_thread+0xbc/0x3f0
[  249.447877]  ? process_one_work+0x580/0x580
[  249.452317]  kthread+0xe6/0x110
[  249.455716]  ? kthread_complete_and_exit+0x20/0x20
[  249.460779]  ret_from_fork+0x22/0x30
[  249.464632]  </TASK>
[  249.467064] INFO: task kworker/u64:0:8 blocked for more than 123 seconds.
[  249.474146]       Not tainted 6.0.0-rc7+ #1
[  249.478601] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.486736] task:kworker/u64:0   state:I stack:0     pid:8     ppid:2      flags:0x00004000
[  249.495407] Workqueue:  0x0 (scsi_tmf_1)
[  249.499603] Call Trace:
[  249.502340]  <TASK>
[  249.504699]  __schedule+0x38f/0x1490
[  249.508556]  schedule+0x5d/0xe0
[  249.511951]  worker_thread+0xbc/0x3f0
[  249.515876]  ? process_one_work+0x580/0x580
[  249.520321]  kthread+0xe6/0x110
[  249.523719]  ? kthread_complete_and_exit+0x20/0x20
[  249.528781]  ret_from_fork+0x22/0x30
[  249.532636]  </TASK>
[  249.535080] INFO: task kworker/0:1H:9 blocked for more than 123 seconds.
[  249.542069]       Not tainted 6.0.0-rc7+ #1
[  249.546527] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.554665] task:kworker/0:1H    state:I stack:0     pid:9     ppid:2      flags:0x00004000
[  249.563331] Workqueue:  0x0 (kblockd)
[  249.567268] Call Trace:
[  249.569989]  <TASK>
[  249.572348]  __schedule+0x38f/0x1490
[  249.576205]  schedule+0x5d/0xe0
[  249.579607]  worker_thread+0xbc/0x3f0
[  249.583535]  ? process_one_work+0x580/0x580
[  249.587975]  kthread+0xe6/0x110
[  249.591371]  ? kthread_complete_and_exit+0x20/0x20
[  249.596430]  ret_from_fork+0x22/0x30
[  249.600289]  </TASK>
[  249.602726] INFO: task mm_percpu_wq:10 blocked for more than 123 seconds.
[  249.609811]       Not tainted 6.0.0-rc7+ #1
[  249.614262] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.622398] task:mm_percpu_wq    state:I stack:0     pid:10    ppid:2      flags:0x00004000
[  249.631063] Call Trace:
[  249.633781]  <TASK>
[  249.636142]  __schedule+0x38f/0x1490
[  249.640006]  schedule+0x5d/0xe0
[  249.643419]  rescuer_thread+0x2f8/0x390
[  249.647524]  ? worker_thread+0x3f0/0x3f0
[  249.651703]  kthread+0xe6/0x110
[  249.655105]  ? kthread_complete_and_exit+0x20/0x20
[  249.660167]  ret_from_fork+0x22/0x30
[  249.664033]  </TASK>
[  249.666489] INFO: task rcu_tasks_kthre:11 blocked for more than 123 seconds.
[  249.673828]       Not tainted 6.0.0-rc7+ #1
[  249.678277] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.686413] task:rcu_tasks_kthre state:I stack:0     pid:11    ppid:2      flags:0x00004000
[  249.695068] Call Trace:
[  249.697802]  <TASK>
[  249.700161]  __schedule+0x38f/0x1490
[  249.704020]  ? mark_held_locks+0x49/0x80
[  249.708229]  ? rcu_tasks_one_gp+0x3e0/0x3e0
[  249.712728]  schedule+0x5d/0xe0
[  249.716133]  rcu_tasks_one_gp+0x19e/0x3e0
[  249.720428]  ? rcu_tasks_one_gp+0x3e0/0x3e0
[  249.724879]  rcu_tasks_kthread+0x31/0x40
[  249.729072]  kthread+0xe6/0x110
[  249.732482]  ? kthread_complete_and_exit+0x20/0x20
[  249.737565]  ret_from_fork+0x22/0x30
[  249.741429]  </TASK>
[  249.743865] INFO: task rcu_tasks_rude_:12 blocked for more than 123 seconds.
[  249.751224]       Not tainted 6.0.0-rc7+ #1
[  249.755698] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.763861] task:rcu_tasks_rude_ state:I stack:0     pid:12    ppid:2      flags:0x00004000
[  249.772515] Call Trace:
[  249.775256]  <TASK>
[  249.777629]  __schedule+0x38f/0x1490
[  249.781482]  ? mark_held_locks+0x49/0x80
[  249.785667]  ? rcu_tasks_one_gp+0x3e0/0x3e0
[  249.790148]  schedule+0x5d/0xe0
[  249.793559]  rcu_tasks_one_gp+0x19e/0x3e0
[  249.797866]  ? rcu_tasks_one_gp+0x3e0/0x3e0
[  249.802315]  rcu_tasks_kthread+0x31/0x40
[  249.806515]  kthread+0xe6/0x110
[  249.809945]  ? kthread_complete_and_exit+0x20/0x20
[  249.815007]  ret_from_fork+0x22/0x30
[  249.818904]  </TASK>
[  249.821366] 
               Showing all locks held in the system:
[  249.828044] 1 lock held by rcu_tasks_kthre/11:
[  249.832767]  #0: ffffffff8273bdf0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
[  249.842684] 1 lock held by rcu_tasks_rude_/12:
[  249.847389]  #0: ffffffff8273bb70 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
[  249.857732] 1 lock held by khungtaskd/56:
[  249.862000]  #0: ffffffff8273c800 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x15/0x16b
[  249.871288] 1 lock held by in:imklog/1289:
[  249.875633]  #0: ffff888100f309a8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x65/0xb0

[  249.885886] =============================================


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
