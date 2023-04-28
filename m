Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD73C6F1D10
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbjD1RA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjD1RAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:00:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BB359D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:00:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF4XUT031610;
        Fri, 28 Apr 2023 17:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=mqo/JZDIJbycM9fSFgKaoBSU2ULFKXZN23kkVlB8UlE=;
 b=ADgphnlTclM6+V7LdPfLaEAzZuV+rLtN/XrAgsfslAR0fpj0RGdzvMBpOwe+fRQTI293
 7XUPp3fIiOwNaxqc6zR3x93AlZYHVwm1727v9vlY4NVUFvGUYnZB1Jiiu5dJrKgKX7LL
 Fu1gaJJXypo8VyCpRHmKMYfayzVQrQBD4ja1AjKyVRjHaQG6/pe91Z7VJlRlmGaG9VLa
 xwNDbt+gb4sAX7sAF/4IecMrrErcFKIe0O2mlmqwKTzBo0etERhbZqXHwN4UTb+VJNk6
 3YE2iVCyWfs1fHxruL4a0MJDToBbM2hKYP2DeDHRjXyi8dfdc1qNe24TkMQCRAdWknPb Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbxwq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 17:00:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SFlOMb029935;
        Fri, 28 Apr 2023 17:00:20 GMT
Received: from localhost.localdomain (dhcp-10-191-130-53.vpn.oracle.com [10.191.130.53])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3q461b1n2g-1;
        Fri, 28 Apr 2023 17:00:19 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     peterz@infradead.org, paulmck@kernel.org, jgross@suse.com,
        vschneid@redhat.com, yury.norov@gmail.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] smp: Reduce logging due to dump_stack of CSD waiters
Date:   Sat, 29 Apr 2023 03:00:04 +1000
Message-Id: <20230428170006.1241472-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=857
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280136
X-Proofpoint-GUID: vgNvYQYbAiNOIfwwagCuZB0Pp0xhNFuz
X-Proofpoint-ORIG-GUID: vgNvYQYbAiNOIfwwagCuZB0Pp0xhNFuz
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset intends to reduce the logging due to csdlock_debug=1, when a CSD
hang is detected by multiple CPUs or for a duartion spanning multiple 
csd_lock_timeout units or both.

csdlock_debug=1 is very useful feature due to its low overhead and suitability
for production systems.
It can help detecting issues such as CPU(s) not coming out of idle even
after getting IPIs or CPU(s) not handling IPIs because they have irq
disabled for long or IPIs getting lost etc.

The usual overhead of csdlock_debug=1 is minimal but for large scale systems
sometimes the dump_stack and backtrace NMIs emanating from CSD hang detection,
simply bog down the system and create altogether different problem on its own.

For example say there is a 8 socket system with 448 CPUs. Out of these 448
CPUs, 400+ CPUs issued smp_call_function_single (almost at same time) to
CPU 10 and the servicing of those IPIs got delayed for 10+ secs.
Now each of these 400+ CPUs will detect csd hang and dump their current
call stack and issue backtrace NMI to CPU 10 and thus CPU 10 needs to
handle these 400+ NMIs, besides what it was doing at that point of time.
Further since IPI handling at CPU 10 got delayed by 10+ secs, each of
these 400+ CPUs will continue with the hang detection and dump their
call stack again (even though they have not changed context since last
dump_stack.)

This excessive logging bogs down the system and sometimes obfuscates/overwrites
other useful log messages.

Below I have included log snipptes from a 8 CPU system, just to show logging aspect.
Full log from a 448 CPUs will be too big to include here.
In the below snippet(s) 7 out of 8 CPUs sent IPI to one remaining
CPU(#3) almost at the same time but the destination CPU could not serve these
IPIs timely giving rise to CSD hang detection at each CPU and NMI being 
sent from each CPU. We can see that destination CPU is handling backtrace NMI
multiple times and source CPUs are dumping their call stacks multiple times as well.

[   83.716344] smp: csd: Detected non-responsive CSD lock (#1) on CPU#5, waiting 5000000868 ns for CPU#03 say_hello+0x0/0x20.
[   83.716350] smp: csd: Detected non-responsive CSD lock (#2) on CPU#4, waiting 5000003655 ns for CPU#03 say_hello+0x0/0x20.
[   83.716572] smp: csd: Detected non-responsive CSD lock (#6) on CPU#1, waiting 5000000313 ns for CPU#03 say_hello+0x0/0x20.
[   83.716349] smp: csd: Detected non-responsive CSD lock (#4) on CPU#6, waiting 5000001502 ns for CPU#03 say_hello+0x0/0x20.
[   83.716346] smp: csd: Detected non-responsive CSD lock (#3) on CPU#2, waiting 5000001796 ns for CPU#03 say_hello+0x0/0x20.
[   83.716385] smp: csd: Detected non-responsive CSD lock (#5) on CPU#0, waiting 5000000430 ns for CPU#03 say_hello+0x0/0x20.
[   83.717231] smp: 	csd: CSD lock (#1) unresponsive.
[   83.717232] smp: 	csd: CSD lock (#4) unresponsive.
[   83.717235] smp: 	csd: CSD lock (#5) unresponsive.
[   83.717242] smp: 	csd: CSD lock (#3) unresponsive.
[   83.717335] smp: csd: Re-sending CSD lock (#1) IPI from CPU#05 to CPU#03
[   83.717339] smp: csd: Re-sending CSD lock (#3) IPI from CPU#02 to CPU#03
[   83.717342] smp: csd: Re-sending CSD lock (#4) IPI from CPU#06 to CPU#03
[   83.717491] smp: csd: Detected non-responsive CSD lock (#7) on CPU#7, waiting 5000022897 ns for CPU#03 say_hello+0x0/0x20.
[   83.717353] Sending NMI from CPU 0 to CPUs 3:
[   83.717549] smp: 	csd: CSD lock (#7) unresponsive.
[   83.717559] smp: csd: Re-sending CSD lock (#7) IPI from CPU#07 to CPU#03
[   83.717630] CPU: 2 PID: 223 Comm: ipi_sender_3 Tainted: G           O       6.3.0 #163
[   83.717747] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   83.717833] smp: 	csd: CSD lock (#2) unresponsive.
[   83.717895] Call Trace:
[   83.718546] smp: 	csd: CSD lock (#6) unresponsive.
[   83.718565] smp: csd: Re-sending CSD lock (#6) IPI from CPU#01 to CPU#03
[   83.719232] smp: csd: Re-sending CSD lock (#2) IPI from CPU#04 to CPU#03
[   83.718200]  <TASK>
[   83.718200]  dump_stack_lvl+0x37/0x50
[   83.718200]  __csd_lock_wait+0x1df/0x280
[   83.718200]  smp_call_function_single+0x166/0x1b0
[   83.718200]  ipi_sender_thread_3+0x40/0x50 [smp_csd_study]
[   83.718200]  kthread+0xd7/0x100
[   83.718200]  ret_from_fork+0x2c/0x50
[   83.718200]  </TASK>
[   83.729820] CPU: 6 PID: 226 Comm: ipi_sender_6 Tainted: G           O       6.3.0 #163
[   83.730285] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   83.730621] Call Trace:
[   83.730679]  <TASK>
[   83.730679]  dump_stack_lvl+0x37/0x50
[   83.730679]  __csd_lock_wait+0x1df/0x280
[   83.730679]  smp_call_function_single+0x166/0x1b0
[   83.730679]  ipi_sender_thread_6+0x40/0x50 [smp_csd_study]
[   83.730679]  kthread+0xd7/0x100
[   83.730679]  ret_from_fork+0x2c/0x50
[   83.730679]  </TASK>
[   83.733766] CPU: 5 PID: 225 Comm: ipi_sender_5 Tainted: G           O       6.3.0 #163
[   83.734181] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   83.734181] Call Trace:
[   83.734181]  <TASK>
[   83.734181]  dump_stack_lvl+0x37/0x50
[   83.734181]  __csd_lock_wait+0x1df/0x280
[   83.734181]  smp_call_function_single+0x166/0x1b0
[   83.734181]  ipi_sender_thread_5+0x40/0x50 [smp_csd_study]
[   83.734181]  kthread+0xd7/0x100
[   83.734181]  ret_from_fork+0x2c/0x50
[   83.734181]  </TASK>
[   83.737580] CPU: 7 PID: 227 Comm: ipi_sender_7 Tainted: G           O       6.3.0 #163
[   83.737998] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   83.738032] Call Trace:
[   83.738032]  <TASK>
[   83.738032]  dump_stack_lvl+0x37/0x50
[   83.738032]  __csd_lock_wait+0x1df/0x280
[   83.738032]  smp_call_function_single+0x166/0x1b0
[   83.738032]  ipi_sender_thread_7+0x40/0x50 [smp_csd_study]
[   83.738032]  kthread+0xd7/0x100
[   83.738032]  ret_from_fork+0x2c/0x50
[   83.738032]  </TASK>
[   78.717016] NMI backtrace for cpu 3
[   78.717016] CPU: 3 PID: 228 Comm: local_irq_disab Tainted: G           O       6.3.0 #163
[   78.717016] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   78.717016] RIP: 0010:delay_tsc+0x2f/0xa0
[   78.717016] Code: ff 05 ad ae a3 6c 65 44 8b 0d a9 ae a3 6c 0f ae e8 0f 31 48 c1 e2 20 48 09 c2 49 89 d0 eb 21 65 ff 0d 81
[   78.717016] RSP: 0018:ffffb22e0043ff08 EFLAGS: 00000087
[   78.717016] RAX: 000000371fb6bbab RBX: 000000000000273b RCX: 0000000000000000
[   78.717016] RDX: 00000000001e6a5a RSI: 0000000000000003 RDI: 00000000002ac5a1
[   78.717016] RBP: ffff8b2242273cc0 R08: 000000371f985151 R09: 0000000000000003
[   78.717016] R10: ffff8b2242b30ed0 R11: ffff8b22bfdeb2f0 R12: ffffb22e004d3bc0
[   78.717016] R13: ffff8b2242215580 R14: ffffffffc02c2060 R15: 0000000000000000
[   78.717016] FS:  0000000000000000(0000) GS:ffff8b22bfcc0000(0000) knlGS:0000000000000000
[   78.717016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.717016] CR2: 00007fc5e727f960 CR3: 0000000002f0a000 CR4: 00000000000006e0
[   78.717016] Call Trace:
[   78.717016]  <TASK>
[   78.717016]  irq_disabling_thread+0x75/0x90 [smp_csd_study]
[   78.717016]  kthread+0xd7/0x100
[   78.717016]  ret_from_fork+0x2c/0x50
[   78.717016]  </TASK>
[   83.752294] CPU: 4 PID: 224 Comm: ipi_sender_4 Tainted: G           O       6.3.0 #163
[   78.717016] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 33.837 msecs
[   83.753313] smp: csd: Re-sending CSD lock (#5) IPI from CPU#00 to CPU#03
[   83.752991] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   83.752991] Call Trace:
[   83.752991]  <TASK>
[   83.752991]  dump_stack_lvl+0x37/0x50
[   83.752991]  __csd_lock_wait+0x1df/0x280
[   83.752991]  smp_call_function_single+0x166/0x1b0
[   83.752991]  ipi_sender_thread_4+0x40/0x50 [smp_csd_study]
[   83.752991]  kthread+0xd7/0x100
[   83.752991]  ret_from_fork+0x2c/0x50
[   83.752991]  </TASK>
[   83.763939] CPU: 1 PID: 222 Comm: ipi_sender_2 Tainted: G           O       6.3.0 #163
[   83.764011] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   83.764011] Call Trace:
[   83.764011]  <TASK>
[   83.764011]  dump_stack_lvl+0x37/0x50
[   83.764011]  __csd_lock_wait+0x1df/0x280
[   83.764011]  smp_call_function_single+0x166/0x1b0
[   83.764011]  ipi_sender_thread_2+0x40/0x50 [smp_csd_study]
[   83.764011]  kthread+0xd7/0x100
[   83.764011]  ret_from_fork+0x2c/0x50
[   83.764011]  </TASK>
[   83.767807] CPU: 0 PID: 221 Comm: ipi_sender_1 Tainted: G           O       6.3.0 #163
[   83.768004] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   83.768004] Call Trace:
[   83.768004]  <TASK>
[   83.768004]  dump_stack_lvl+0x37/0x50
[   83.768004]  __csd_lock_wait+0x1df/0x280
[   83.768004]  smp_call_function_single+0x166/0x1b0
[   83.768004]  ipi_sender_thread_1+0x40/0xcc0 [smp_csd_study]
[   83.768004]  kthread+0xd7/0x100
[   83.768004]  ret_from_fork+0x2c/0x50
[   83.768004]  </TASK>
[   88.716186] smp: csd: Continued non-responsive CSD lock (#2) on CPU#4, waiting 10000003683 ns for CPU#03 say_hello+0x0/0x.
[   88.716186] smp: csd: Continued non-responsive CSD lock (#1) on CPU#5, waiting 10000001110 ns for CPU#03 say_hello+0x0/0x.
[   88.716170] smp: csd: Continued non-responsive CSD lock (#3) on CPU#2, waiting 10000003612 ns for CPU#03 say_hello+0x0/0x.
[   88.716237] smp: csd: Continued non-responsive CSD lock (#4) on CPU#6, waiting 10000003146 ns for CPU#03 say_hello+0x0/0x.
[   88.716297] smp: 	csd: CSD lock (#1) unresponsive.
[   88.716298] smp: 	csd: CSD lock (#3) unresponsive.
[   88.716307] smp: 	csd: CSD lock (#4) unresponsive.
[   88.716309] smp: csd: Re-sending CSD lock (#1) IPI from CPU#05 to CPU#03
[   88.716310] Sending NMI from CPU 2 to CPUs 3:
[   88.716320] smp: csd: Re-sending CSD lock (#4) IPI from CPU#06 to CPU#03
[   88.716347] CPU: 6 PID: 226 Comm: ipi_sender_6 Tainted: G           O       6.3.0 #163
[   88.716367] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   88.716345] smp: csd: Continued non-responsive CSD lock (#5) on CPU#0, waiting 10000007406 ns for CPU#03 say_hello+0x0/0x.
[   88.716377] Call Trace:
[   88.716394] smp: 	csd: CSD lock (#5) unresponsive.
[   88.716402]  <TASK>
[   88.716402] smp: csd: Re-sending CSD lock (#5) IPI from CPU#00 to CPU#03
[   88.716415]  dump_stack_lvl+0x37/0x50
[   88.716455]  __csd_lock_wait+0x1df/0x280
[   88.716520]  smp_call_function_single+0x166/0x1b0
[   88.716570] smp: csd: Continued non-responsive CSD lock (#6) on CPU#1, waiting 10000036097 ns for CPU#03 say_hello+0x0/0x.
[   88.716588]  ipi_sender_thread_6+0x40/0x50 [smp_csd_study]
[   88.716619]  kthread+0xd7/0x100
[   88.716627] smp: 	csd: CSD lock (#6) unresponsive.
[   88.716636] smp: csd: Re-sending CSD lock (#6) IPI from CPU#01 to CPU#03
[   88.716662]  ret_from_fork+0x2c/0x50
[   88.716688]  </TASK>
[   78.717016] NMI backtrace for cpu 3
[   78.717016] CPU: 3 PID: 228 Comm: local_irq_disab Tainted: G           O       6.3.0 #163
[   78.717016] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   78.717016] RIP: 0010:delay_tsc+0x2f/0xa0
[   78.717016] Code: ff 05 ad ae a3 6c 65 44 8b 0d a9 ae a3 6c 0f ae e8 0f 31 48 c1 e2 20 48 09 c2 49 89 d0 eb 21 65 ff 0d 81
[   78.717016] RSP: 0018:ffffb22e0043ff08 EFLAGS: 00000087
[   78.717016] RAX: 0000003a62ede93f RBX: 00000000000013fb RCX: 0000000000000000
[   78.717016] RDX: 0000000000116e75 RSI: 0000000000000003 RDI: 00000000002ac5a1
[   78.717016] RBP: ffff8b2242273cc0 R08: 0000003a62dc7aca R09: 0000000000000003
[   78.717016] R10: ffff8b2242b30ed0 R11: ffff8b22bfdeb2f0 R12: ffffb22e004d3bc0
[   78.717016] R13: ffff8b2242215580 R14: ffffffffc02c2060 R15: 0000000000000000
[   78.717016] FS:  0000000000000000(0000) GS:ffff8b22bfcc0000(0000) knlGS:0000000000000000
[   78.717016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.717016] CR2: 00007fc5e727f960 CR3: 0000000002f0a000 CR4: 00000000000006e0
[   78.717016] Call Trace:
[   78.717016]  <TASK>
[   88.717198] smp: 	csd: CSD lock (#2) unresponsive.
[   78.717016]  irq_disabling_thread+0x75/0x90 [smp_csd_study]
[   78.717016]  kthread+0xd7/0x100
[   78.717016]  ret_from_fork+0x2c/0x50
[   78.717016]  </TASK>
[   88.717596] smp: csd: Continued non-responsive CSD lock (#7) on CPU#7, waiting 10000171823 ns for CPU#03 say_hello+0x0/0x.
[   88.717609] CPU: 1 PID: 222 Comm: ipi_sender_2 Tainted: G           O       6.3.0 #163
[   88.717632] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   88.717641] Call Trace:
[   88.717660] smp: 	csd: CSD lock (#7) unresponsive.
[   88.717656]  <TASK>
[   88.717671] smp: csd: Re-sending CSD lock (#7) IPI from CPU#07 to CPU#03
[   88.717667]  dump_stack_lvl+0x37/0x50
[   88.717692]  __csd_lock_wait+0x1df/0x280
[   88.717740]  smp_call_function_single+0x166/0x1b0
[   88.717806]  ipi_sender_thread_2+0x40/0x50 [smp_csd_study]
[   88.718421] smp: csd: Re-sending CSD lock (#3) IPI from CPU#02 to CPU#03
[   88.718571] Sending NMI from CPU 4 to CPUs 3:
[   88.718087]  kthread+0xd7/0x100
[   88.718087]  ret_from_fork+0x2c/0x50
[   88.718087]  </TASK>
[   88.740789] CPU: 2 PID: 223 Comm: ipi_sender_3 Tainted: G           O       6.3.0 #163
[   88.741123] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   88.741123] Call Trace:
[   88.741123]  <TASK>
[   88.741123]  dump_stack_lvl+0x37/0x50
[   88.741123]  __csd_lock_wait+0x1df/0x280
[   88.741123]  smp_call_function_single+0x166/0x1b0
[   88.741123]  ipi_sender_thread_3+0x40/0x50 [smp_csd_study]
[   88.741123]  kthread+0xd7/0x100
[   88.741123]  ret_from_fork+0x2c/0x50
[   88.741123]  </TASK>
[   88.746307] CPU: 5 PID: 225 Comm: ipi_sender_5 Tainted: G           O       6.3.0 #163
[   88.746744] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   88.747022] Call Trace:
[   88.747022]  <TASK>
[   88.747022]  dump_stack_lvl+0x37/0x50
[   88.747022]  __csd_lock_wait+0x1df/0x280
[   88.747022]  smp_call_function_single+0x166/0x1b0
[   88.747022]  ipi_sender_thread_5+0x40/0x50 [smp_csd_study]
[   88.747022]  kthread+0xd7/0x100
[   88.747022]  ret_from_fork+0x2c/0x50
[   88.747022]  </TASK>
[   88.750569] CPU: 0 PID: 221 Comm: ipi_sender_1 Tainted: G           O       6.3.0 #163
[   88.751042] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   88.751133] Call Trace:
[   88.751133]  <TASK>
[   88.751133]  dump_stack_lvl+0x37/0x50
[   88.751133]  __csd_lock_wait+0x1df/0x280
[   88.751133]  smp_call_function_single+0x166/0x1b0
[   88.751133]  ipi_sender_thread_1+0x40/0xcc0 [smp_csd_study]
[   88.751133]  kthread+0xd7/0x100
[   88.751133]  ret_from_fork+0x2c/0x50
[   88.751133]  </TASK>
[   78.717016] NMI backtrace for cpu 3
[   78.717016] CPU: 3 PID: 228 Comm: local_irq_disab Tainted: G           O       6.3.0 #163
[   78.717016] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   78.717016] RIP: 0010:delay_tsc+0x2f/0xa0
[   78.717016] Code: ff 05 ad ae a3 6c 65 44 8b 0d a9 ae a3 6c 0f ae e8 0f 31 48 c1 e2 20 48 09 c2 49 89 d0 eb 21 65 ff 0d 81
[   78.717016] RSP: 0018:ffffb22e0043ff08 EFLAGS: 00000087
[   78.717016] RAX: 0000003a637a6115 RBX: 00000000000013f8 RCX: 0000000000000000
[   78.717016] RDX: 00000000000058ec RSI: 0000000000000003 RDI: 00000000002ac5a1
[   78.717016] RBP: ffff8b2242273cc0 R08: 0000003a637a0829 R09: 0000000000000003
[   78.717016] R10: ffff8b2242b30ed0 R11: ffff8b22bfdeb2f0 R12: ffffb22e004d3bc0
[   78.717016] R13: ffff8b2242215580 R14: ffffffffc02c2060 R15: 0000000000000000
[   78.717016] FS:  0000000000000000(0000) GS:ffff8b22bfcc0000(0000) knlGS:0000000000000000
[   78.717016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.717016] CR2: 00007fc5e727f960 CR3: 0000000002f0a000 CR4: 00000000000006e0
[   78.717016] Call Trace:
[   78.717016]  <TASK>
[   78.717016]  irq_disabling_thread+0x75/0x90 [smp_csd_study]
[   78.717016]  kthread+0xd7/0x100
[   78.717016]  ret_from_fork+0x2c/0x50
[   78.717016]  </TASK>
[   88.755341] CPU: 7 PID: 227 Comm: ipi_sender_7 Tainted: G           O       6.3.0 #163
[   78.717016] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 35.704 msecs
[   88.755831] smp: csd: Re-sending CSD lock (#2) IPI from CPU#04 to CPU#03
[   88.756010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   88.756010] Call Trace:
[   88.756010]  <TASK>
[   88.756010]  dump_stack_lvl+0x37/0x50
[   88.756010]  __csd_lock_wait+0x1df/0x280
[   88.756010]  smp_call_function_single+0x166/0x1b0
[   88.756010]  ipi_sender_thread_7+0x40/0x50 [smp_csd_study]
[   88.756010]  kthread+0xd7/0x100
[   88.756010]  ret_from_fork+0x2c/0x50
[   88.756010]  </TASK>
[   88.767189] CPU: 4 PID: 224 Comm: ipi_sender_4 Tainted: G           O       6.3.0 #163
[   88.767664] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   88.768032] Call Trace:
[   88.768032]  <TASK>
[   88.768032]  dump_stack_lvl+0x37/0x50
[   88.768032]  __csd_lock_wait+0x1df/0x280
[   88.768032]  smp_call_function_single+0x166/0x1b0
[   88.768032]  ipi_sender_thread_4+0x40/0x50 [smp_csd_study]
[   88.768032]  kthread+0xd7/0x100
[   88.768032]  ret_from_fork+0x2c/0x50
[   88.768032]  </TASK>
[   93.716132] smp: csd: Continued non-responsive CSD lock (#3) on CPU#2, waiting 15000010115 ns for CPU#03 say_hello+0x0/0x.
[   93.716138] smp: csd: Continued non-responsive CSD lock (#1) on CPU#5, waiting 15000003291 ns for CPU#03 say_hello+0x0/0x.
[   93.716153] smp: csd: Continued non-responsive CSD lock (#2) on CPU#4, waiting 15000009824 ns for CPU#03 say_hello+0x0/0x.
[   93.716196] smp: csd: Continued non-responsive CSD lock (#4) on CPU#6, waiting 15000003905 ns for CPU#03 say_hello+0x0/0x.
[   93.716256] smp: 	csd: CSD lock (#1) unresponsive.
[   93.716256] smp: 	csd: CSD lock (#2) unresponsive.
[   93.716269] smp: csd: Re-sending CSD lock (#2) IPI from CPU#04 to CPU#03
[   93.716270] smp: 	csd: CSD lock (#4) unresponsive.
[   93.716269] Sending NMI from CPU 5 to CPUs 3:
[   93.716284] smp: csd: Re-sending CSD lock (#4) IPI from CPU#06 to CPU#03
[   93.716309] CPU: 6 PID: 226 Comm: ipi_sender_6 Tainted: G           O       6.3.0 #163
[   93.716330] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   93.716342] Call Trace:
[   93.716369]  <TASK>
[   93.716343] smp: csd: Continued non-responsive CSD lock (#5) on CPU#0, waiting 15000048173 ns for CPU#03 say_hello+0x0/0x.
[   93.716401] smp: 	csd: CSD lock (#5) unresponsive.
[   93.716387]  dump_stack_lvl+0x37/0x50
[   93.716410] smp: csd: Re-sending CSD lock (#5) IPI from CPU#00 to CPU#03
[   93.716431]  __csd_lock_wait+0x1df/0x280
[   93.716500]  smp_call_function_single+0x166/0x1b0
[   93.716561] smp: csd: Continued non-responsive CSD lock (#6) on CPU#1, waiting 15000071374 ns for CPU#03 say_hello+0x0/0x.
[   93.716586]  ipi_sender_thread_6+0x40/0x50 [smp_csd_study]
[   93.716603] smp: 	csd: CSD lock (#6) unresponsive.
[   93.716611] smp: csd: Re-sending CSD lock (#6) IPI from CPU#01 to CPU#03
[   93.716618]  kthread+0xd7/0x100
[   93.716657]  ret_from_fork+0x2c/0x50
[   93.716694]  </TASK>
[   78.717016] NMI backtrace for cpu 3
[   78.717016] CPU: 3 PID: 228 Comm: local_irq_disab Tainted: G           O       6.3.0 #163
[   78.717016] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   78.717016] RIP: 0010:delay_tsc+0x2f/0xa0
[   78.717016] Code: ff 05 ad ae a3 6c 65 44 8b 0d a9 ae a3 6c 0f ae e8 0f 31 48 c1 e2 20 48 09 c2 49 89 d0 eb 21 65 ff 0d 81
[   78.717016] RSP: 0018:ffffb22e0043ff08 EFLAGS: 00000087
[   78.717016] RAX: 0000003da65b6860 RBX: 00000000000000ea RCX: 0000000000000000
[   93.717049] smp: 	csd: CSD lock (#3) unresponsive.
[   78.717016] RDX: 000000000004f850 RSI: 0000000000000003 RDI: 00000000002ac5a1
[   93.717070] smp: csd: Re-sending CSD lock (#3) IPI from CPU#02 to CPU#03
[   78.717016] RBP: ffff8b2242273cc0 R08: 0000003da6567010 R09: 0000000000000003
[   78.717016] R10: ffff8b2242b30ed0 R11: ffff8b22bfdeb2f0 R12: ffffb22e004d3bc0
[   78.717016] R13: ffff8b2242215580 R14: ffffffffc02c2060 R15: 0000000000000000
[   78.717016] FS:  0000000000000000(0000) GS:ffff8b22bfcc0000(0000) knlGS:0000000000000000
[   78.717016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.717016] CR2: 00007fc5e727f960 CR3: 0000000002f0a000 CR4: 00000000000006e0
[   78.717016] Call Trace:
[   78.717016]  <TASK>
[   78.717016]  irq_disabling_thread+0x75/0x90 [smp_csd_study]
[   78.717016]  kthread+0xd7/0x100
[   78.717016]  ret_from_fork+0x2c/0x50
[   78.717016]  </TASK>
[   93.717551] CPU: 1 PID: 222 Comm: ipi_sender_2 Tainted: G           O       6.3.0 #163
[   93.717577] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   93.717551] smp: csd: Continued non-responsive CSD lock (#7) on CPU#7, waiting 15000171829 ns for CPU#03 say_hello+0x0/0x.
[   93.717584] Call Trace:
[   93.717599]  <TASK>
[   93.717615] smp: 	csd: CSD lock (#7) unresponsive.
[   93.717611]  dump_stack_lvl+0x37/0x50
[   93.717625] smp: csd: Re-sending CSD lock (#7) IPI from CPU#07 to CPU#03
[   93.717638]  __csd_lock_wait+0x1df/0x280
[   93.717696]  smp_call_function_single+0x166/0x1b0
[   93.717774]  ipi_sender_thread_2+0x40/0x50 [smp_csd_study]
[   93.717803]  kthread+0xd7/0x100
[   93.717842]  ret_from_fork+0x2c/0x50
[   93.717874]  </TASK>
[   93.717884] CPU: 0 PID: 221 Comm: ipi_sender_1 Tainted: G           O       6.3.0 #163
[   93.717906] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   93.717913] Call Trace:
[   93.717922]  <TASK>
[   93.717930]  dump_stack_lvl+0x37/0x50
[   93.717957]  __csd_lock_wait+0x1df/0x280
[   93.718024]  smp_call_function_single+0x166/0x1b0
[   93.718024]  ipi_sender_thread_1+0x40/0xcc0 [smp_csd_study]
[   93.718024]  kthread+0xd7/0x100
[   93.718024]  ret_from_fork+0x2c/0x50
[   93.718024]  </TASK>
[   93.718353] CPU: 7 PID: 227 Comm: ipi_sender_7 Tainted: G           O       6.3.0 #163
[   93.718422] smp: csd: Re-sending CSD lock (#1) IPI from CPU#05 to CPU#03
[   93.719081] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   93.719081] Call Trace:
[   93.719081]  <TASK>
[   93.719081]  dump_stack_lvl+0x37/0x50
[   93.719081]  __csd_lock_wait+0x1df/0x280
[   93.719081]  smp_call_function_single+0x166/0x1b0
[   93.719081]  ipi_sender_thread_7+0x40/0x50 [smp_csd_study]
[   93.719081]  kthread+0xd7/0x100
[   93.719081]  ret_from_fork+0x2c/0x50
[   93.719081]  </TASK>
[   93.752163] CPU: 2 PID: 223 Comm: ipi_sender_3 Tainted: G           O       6.3.0 #163
[   93.752625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   93.753136] Call Trace:
[   93.753136]  <TASK>
[   93.753136]  dump_stack_lvl+0x37/0x50
[   93.753136]  __csd_lock_wait+0x1df/0x280
[   93.753136]  smp_call_function_single+0x166/0x1b0
[   93.753136]  ipi_sender_thread_3+0x40/0x50 [smp_csd_study]
[   93.753136]  kthread+0xd7/0x100
[   93.753136]  ret_from_fork+0x2c/0x50
[   93.753136]  </TASK>
[   93.756701] CPU: 5 PID: 225 Comm: ipi_sender_5 Tainted: G           O       6.3.0 #163
[   93.757013] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   93.757013] Call Trace:
[   93.757013]  <TASK>
[   93.757013]  dump_stack_lvl+0x37/0x50
[   93.757013]  __csd_lock_wait+0x1df/0x280
[   93.757013]  smp_call_function_single+0x166/0x1b0
[   93.757013]  ipi_sender_thread_5+0x40/0x50 [smp_csd_study]
[   93.757013]  kthread+0xd7/0x100
[   93.757013]  ret_from_fork+0x2c/0x50
[   93.757013]  </TASK>
[   93.762853] CPU: 4 PID: 224 Comm: ipi_sender_4 Tainted: G           O       6.3.0 #163
[   93.763146] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   93.763146] Call Trace:
[   93.763146]  <TASK>
[   93.763146]  dump_stack_lvl+0x37/0x50
[   93.763146]  __csd_lock_wait+0x1df/0x280
[   93.763146]  smp_call_function_single+0x166/0x1b0
[   93.763146]  ipi_sender_thread_4+0x40/0x50 [smp_csd_study]
[   93.763146]  kthread+0xd7/0x100
[   93.763146]  ret_from_fork+0x2c/0x50
[   93.763146]  </TASK>
[   78.717016]  Hello cpu 3 
[   78.717016]  Hello cpu 3 
[   93.960507] smp: csd: CSD lock (#2) got unstuck on CPU#04, CPU#03 released the lock.
[   78.717016]  Hello cpu 3 
[   93.960898] smp: csd: CSD lock (#3) got unstuck on CPU#02, CPU#03 released the lock.
[   78.717016]  Hello cpu 3 
[   93.961652] smp: csd: CSD lock (#1) got unstuck on CPU#05, CPU#03 released the lock.
[   78.717016]  Hello cpu 3 
[   93.962416] smp: csd: CSD lock (#4) got unstuck on CPU#06, CPU#03 released the lock.
[   78.717016]  Hello cpu 3 
[   93.962550] smp: csd: CSD lock (#5) got unstuck on CPU#00, CPU#03 released the lock.
[   78.717016]  Hello cpu 3 
[   93.962577] smp: csd: CSD lock (#7) got unstuck on CPU#07, CPU#03 released the lock.


[   93.962844] smp: csd: CSD lock (#6) got unstuck on CPU#01, CPU#03 released the lock.
# 

In the following snippet, with the patched kernel, we can see that for the same
scenario logging has reduced a lot. CSD destination CPU is handling one backtrace NMI and 
each of the waiters are doing dump_stack just once.

[   30.469752] smp: csd: Detected non-responsive CSD lock (#5) on CPU#4, waiting 5000003717 ns for CPU#03 do_kernel_range_fl.
[   30.469342] smp: csd: Detected non-responsive CSD lock (#4) on CPU#6, waiting 5000000473 ns for CPU#03 say_hello+0x0/0x20.
[   30.469776] smp: csd: Detected non-responsive CSD lock (#6) on CPU#2, waiting 5000002392 ns for CPU#03 say_hello+0x0/0x20.
[   30.469345] smp: csd: Detected non-responsive CSD lock (#2) on CPU#7, waiting 5000001082 ns for CPU#03 say_hello+0x0/0x20.
[   30.469346] smp: csd: Detected non-responsive CSD lock (#1) on CPU#0, waiting 5000003664 ns for CPU#03 say_hello+0x0/0x20.
[   30.469343] smp: csd: Detected non-responsive CSD lock (#3) on CPU#1, waiting 5000002429 ns for CPU#03 say_hello+0x0/0x20.
[   30.470180] smp: 	csd: CSD lock (#1) unresponsive.
[   30.470181] smp: 	csd: CSD lock (#3) unresponsive.
[   30.470190] smp: 	csd: CSD lock (#5) unresponsive.
[   30.470193] smp: 	csd: CSD lock (#4) unresponsive.
[   30.470192] smp: 	csd: CSD lock (#2) unresponsive.
[   30.470247] smp: csd: Re-sending CSD lock (#4) IPI from CPU#06 to CPU#03
[   30.470247] smp: csd: Re-sending CSD lock (#2) IPI from CPU#07 to CPU#03
[   30.470245] smp: csd: Re-sending CSD lock (#3) IPI from CPU#01 to CPU#03
[   30.470328] Sending NMI from CPU 4 to CPUs 3:
[   30.470651] CPU: 7 PID: 224 Comm: ipi_sender_7 Tainted: G           O       6.3.0-00002-gba88dee916db #162
[   30.470771] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   30.470934] Call Trace:
[   30.471002] smp: 	csd: CSD lock (#6) unresponsive.
[   30.471039] smp: csd: Re-sending CSD lock (#6) IPI from CPU#02 to CPU#03
[   30.471665] smp: csd: Re-sending CSD lock (#1) IPI from CPU#00 to CPU#03
[   30.471145]  <TASK>
[   30.471145]  dump_stack_lvl+0x37/0x50
[   30.471145]  __csd_lock_wait+0x217/0x2b0
[   30.471145]  smp_call_function_single+0x166/0x1b0
[   30.480264] smp: csd: Detected non-responsive CSD lock (#7) on CPU#5, waiting 5000000697 ns for CPU#03 say_hello+0x0/0x20.
[   30.471145]  ipi_sender_thread_7+0x40/0x50 [smp_csd_study]
[   30.481444] smp: 	csd: CSD lock (#7) unresponsive.
[   30.471145]  kthread+0xd7/0x100
[   30.481926] smp: csd: Re-sending CSD lock (#7) IPI from CPU#05 to CPU#03
[   30.471145]  ret_from_fork+0x2c/0x50
[   30.471145]  </TASK>
[   30.483387] CPU: 6 PID: 223 Comm: ipi_sender_6 Tainted: G           O       6.3.0-00002-gba88dee916db #162
[   30.483899] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   30.484091] Call Trace:
[   30.484091]  <TASK>
[   30.484091]  dump_stack_lvl+0x37/0x50
[   30.484091]  __csd_lock_wait+0x217/0x2b0
[   30.484091]  smp_call_function_single+0x166/0x1b0
[   30.484091]  ipi_sender_thread_6+0x40/0x50 [smp_csd_study]
[   30.484091]  kthread+0xd7/0x100
[   30.484091]  ret_from_fork+0x2c/0x50
[   30.484091]  </TASK>
[   30.487889] CPU: 5 PID: 222 Comm: ipi_sender_5 Tainted: G           O       6.3.0-00002-gba88dee916db #162
[   30.488241] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   30.488241] Call Trace:
[   30.488241]  <TASK>
[   30.488241]  dump_stack_lvl+0x37/0x50
[   30.488241]  __csd_lock_wait+0x217/0x2b0
[   30.488241]  smp_call_function_single+0x166/0x1b0
[   30.488241]  ipi_sender_thread_5+0x40/0x50 [smp_csd_study]
[   30.488241]  kthread+0xd7/0x100
[   30.488241]  ret_from_fork+0x2c/0x50
[   30.488241]  </TASK>
[   25.469919] NMI backtrace for cpu 3
[   25.469919] CPU: 3 PID: 225 Comm: local_irq_disab Tainted: G           O       6.3.0-00002-gba88dee916db #162
[   25.469919] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   25.469919] RIP: 0010:delay_tsc+0x2f/0xa0
[   25.469919] Code: ff 05 ad ae 03 5d 65 44 8b 0d a9 ae 03 5d 0f ae e8 0f 31 48 c1 e2 20 48 09 c2 49 89 d0 eb 21 65 ff 0d 81
[   25.469919] RSP: 0018:ffffa81f0041ff08 EFLAGS: 00000087
[   25.469919] RAX: 00000014622a05c3 RBX: 0000000000002740 RCX: 0000000000000000
[   25.469919] RDX: 00000000000a942b RSI: 0000000000000003 RDI: 00000000002ac5a3
[   25.469919] RBP: ffff97aec221d340 R08: 00000014621f7198 R09: 0000000000000003
[   25.469919] R10: ffff97aec19c0090 R11: ffff97af3fd2b2f0 R12: ffffa81f00427bc0
[   25.469919] R13: ffff97aec2e01100 R14: ffffffffc021d060 R15: 0000000000000000
[   25.469919] FS:  0000000000000000(0000) GS:ffff97af3fcc0000(0000) knlGS:0000000000000000
[   25.469919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.469919] CR2: 00007ffed78b36b8 CR3: 0000000047e2e000 CR4: 00000000000006e0
[   25.469919] Call Trace:
[   25.469919]  <TASK>
[   25.469919]  irq_disabling_thread+0x75/0x90 [smp_csd_study]
[   25.469919]  kthread+0xd7/0x100
[   25.469919]  ret_from_fork+0x2c/0x50
[   25.469919]  </TASK>
[   30.502001] CPU: 2 PID: 220 Comm: ipi_sender_3 Tainted: G           O       6.3.0-00002-gba88dee916db #162
[   30.502618] smp: csd: Re-sending CSD lock (#5) IPI from CPU#04 to CPU#03
[   30.502038] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   25.469919] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 30.287 msecs
[   30.502038] Call Trace:
[   30.502038]  <TASK>
[   30.502038]  dump_stack_lvl+0x37/0x50
[   30.502038]  __csd_lock_wait+0x217/0x2b0
[   30.502038]  smp_call_function_single+0x166/0x1b0
[   30.502038]  ipi_sender_thread_3+0x40/0x50 [smp_csd_study]
[   30.502038]  kthread+0xd7/0x100
[   30.502038]  ret_from_fork+0x2c/0x50
[   30.502038]  </TASK>
[   30.512677] CPU: 4 PID: 217 Comm: insmod Tainted: G           O       6.3.0-00002-gba88dee916db #162
[   30.513080] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   30.513345] Call Trace:
[   30.513345]  <TASK>
[   30.513345]  dump_stack_lvl+0x37/0x50
[   30.513345]  __csd_lock_wait+0x217/0x2b0
[   30.513345]  smp_call_function_many_cond+0x33c/0x570
[   30.513345]  on_each_cpu_cond_mask+0x24/0x40
[   30.513345]  flush_tlb_kernel_range+0x93/0xb0
[   30.513345]  __purge_vmap_area_lazy+0xd3/0x760
[   30.513345]  _vm_unmap_aliases.part.0+0x112/0x150
[   30.513345]  change_page_attr_set_clr+0x8a/0x250
[   30.513345]  set_memory_ro+0x25/0x30
[   30.513345]  module_enable_ro+0x66/0xf0
[   30.513345]  do_init_module+0xdc/0x1d0
[   30.513345]  load_module+0x1cfc/0x1fb0
[   30.513345]  __do_sys_finit_module+0xa6/0x100
[   30.513345]  do_syscall_64+0x3f/0x90
[   30.513345]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   30.513345] RIP: 0033:0x7ff286980bc9
[   30.513345] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8
[   30.513345] RSP: 002b:00007ffe879f02b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000139
[   30.513345] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff286980bc9
[   30.513345] RDX: 0000000000000000 RSI: 00000000011532a0 RDI: 0000000000000003
[   30.513345] RBP: 00000000011532a0 R08: 0000000000000003 R09: 0000000000000000
[   30.513345] R10: 00000000011532a0 R11: 0000000000000206 R12: 00007ffe879f0f49
[   30.513345] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   30.513345]  </TASK>
[   30.523228] CPU: 1 PID: 219 Comm: ipi_sender_2 Tainted: G           O       6.3.0-00002-gba88dee916db #162
[   30.523635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   30.523970] Call Trace:
[   30.524043]  <TASK>
[   30.524043]  dump_stack_lvl+0x37/0x50
[   30.524043]  __csd_lock_wait+0x217/0x2b0
[   30.524043]  smp_call_function_single+0x166/0x1b0
[   30.524043]  ipi_sender_thread_2+0x40/0x50 [smp_csd_study]
[   30.524043]  kthread+0xd7/0x100
[   30.524043]  ret_from_fork+0x2c/0x50
[   30.524043]  </TASK>
[   30.526850] CPU: 0 PID: 218 Comm: ipi_sender_1 Tainted: G           O       6.3.0-00002-gba88dee916db #162
[   30.527158] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   30.527158] Call Trace:
[   30.527158]  <TASK>
[   30.527158]  dump_stack_lvl+0x37/0x50
[   30.527158]  __csd_lock_wait+0x217/0x2b0
[   30.527158]  smp_call_function_single+0x166/0x1b0
[   30.527158]  ipi_sender_thread_1+0x40/0xcc0 [smp_csd_study]
[   30.527158]  kthread+0xd7/0x100
[   30.527158]  ret_from_fork+0x2c/0x50
[   30.527158]  </TASK>
[   35.469170] smp: csd: Continued non-responsive CSD lock (#1) on CPU#0, waiting 10000009665 ns for CPU#03 say_hello+0x0/0x.
[   35.469212] smp: csd: Continued non-responsive CSD lock (#3) on CPU#1, waiting 10000005859 ns for CPU#03 say_hello+0x0/0x.
[   35.469216] smp: csd: Continued non-responsive CSD lock (#4) on CPU#6, waiting 10000001791 ns for CPU#03 say_hello+0x0/0x.
[   35.469228] smp: csd: Continued non-responsive CSD lock (#2) on CPU#7, waiting 10000002096 ns for CPU#03 say_hello+0x0/0x.
[   35.469295] smp: 	csd: CSD lock (#3) unresponsive.
[   35.469295] smp: 	csd: CSD lock (#4) unresponsive.
[   35.469297] smp: 	csd: CSD lock (#2) unresponsive.
[   35.469306] smp: csd: Re-sending CSD lock (#3) IPI from CPU#01 to CPU#03
[   35.469304] smp: csd: Re-sending CSD lock (#4) IPI from CPU#06 to CPU#03
[   35.469307] smp: csd: Re-sending CSD lock (#2) IPI from CPU#07 to CPU#03
[   35.469715] smp: csd: Continued non-responsive CSD lock (#5) on CPU#4, waiting 10000010019 ns for CPU#03 do_kernel_range_.
[   35.469762] smp: 	csd: CSD lock (#5) unresponsive.
[   35.469770] smp: csd: Re-sending CSD lock (#5) IPI from CPU#04 to CPU#03
[   35.469762] smp: csd: Continued non-responsive CSD lock (#6) on CPU#2, waiting 10000030233 ns for CPU#03 say_hello+0x0/0x.
[   35.469824] smp: 	csd: CSD lock (#6) unresponsive.
[   35.469830] smp: csd: Re-sending CSD lock (#6) IPI from CPU#02 to CPU#03
[   35.470198] smp: 	csd: CSD lock (#1) unresponsive.
[   35.477315] smp: csd: Re-sending CSD lock (#1) IPI from CPU#00 to CPU#03
[   35.480100] smp: csd: Continued non-responsive CSD lock (#7) on CPU#5, waiting 10000090810 ns for CPU#03 say_hello+0x0/0x.
[   35.481281] smp: 	csd: CSD lock (#7) unresponsive.
[   35.481697] smp: csd: Re-sending CSD lock (#7) IPI from CPU#05 to CPU#03
[   40.469139] smp: csd: Continued non-responsive CSD lock (#1) on CPU#0, waiting 15000022345 ns for CPU#03 say_hello+0x0/0x.
[   40.469187] smp: csd: Continued non-responsive CSD lock (#2) on CPU#7, waiting 15000003606 ns for CPU#03 say_hello+0x0/0x.
[   40.469178] smp: csd: Continued non-responsive CSD lock (#4) on CPU#6, waiting 15000005344 ns for CPU#03 say_hello+0x0/0x.
[   40.469169] smp: csd: Continued non-responsive CSD lock (#3) on CPU#1, waiting 15000012409 ns for CPU#03 say_hello+0x0/0x.
[   40.469259] smp: 	csd: CSD lock (#2) unresponsive.
[   40.469254] smp: 	csd: CSD lock (#3) unresponsive.
[   40.469259] smp: 	csd: CSD lock (#4) unresponsive.
[   40.469267] smp: csd: Re-sending CSD lock (#2) IPI from CPU#07 to CPU#03
[   40.469264] smp: csd: Re-sending CSD lock (#3) IPI from CPU#01 to CPU#03
[   40.469270] smp: csd: Re-sending CSD lock (#4) IPI from CPU#06 to CPU#03
[   40.469676] smp: csd: Continued non-responsive CSD lock (#5) on CPU#4, waiting 15000010365 ns for CPU#03 do_kernel_range_.
[   40.469740] smp: 	csd: CSD lock (#5) unresponsive.
[   40.469749] smp: csd: Re-sending CSD lock (#5) IPI from CPU#04 to CPU#03
[   40.469736] smp: csd: Continued non-responsive CSD lock (#6) on CPU#2, waiting 15000046488 ns for CPU#03 say_hello+0x0/0x.
[   40.469786] smp: 	csd: CSD lock (#6) unresponsive.
[   40.469794] smp: csd: Re-sending CSD lock (#6) IPI from CPU#02 to CPU#03
[   40.470159] smp: 	csd: CSD lock (#1) unresponsive.
[   40.470173] smp: csd: Re-sending CSD lock (#1) IPI from CPU#00 to CPU#03
[   40.480266] smp: csd: Continued non-responsive CSD lock (#7) on CPU#5, waiting 15000091593 ns for CPU#03 say_hello+0x0/0x.
[   40.480866] smp: 	csd: CSD lock (#7) unresponsive.
[   40.481225] smp: csd: Re-sending CSD lock (#7) IPI from CPU#05 to CPU#03
[   25.469919]  Hello cpu 3 
[   25.469919]  Hello cpu 3 
[   40.637182] smp: csd: CSD lock (#3) got unstuck on CPU#01, CPU#03 released the lock.
[   25.469919]  Hello cpu 3 
[   40.637240] smp: csd: CSD lock (#1) got unstuck on CPU#00, CPU#03 released the lock.
[   25.469919]  Hello cpu 3 
[   40.637664] smp: csd: CSD lock (#2) got unstuck on CPU#07, CPU#03 released the lock.
[   40.637713] smp: csd: CSD lock (#4) got unstuck on CPU#06, CPU#03 released the lock.
[   40.637763] smp: csd: CSD lock (#5) got unstuck on CPU#04, CPU#03 released the lock.
[   25.469919]  Hello cpu 3 
[   25.469919]  Hello cpu 3 
[   40.637811] smp: csd: CSD lock (#6) got unstuck on CPU#02, CPU#03 released the lock.
[   40.637941] sending ipi from 4 to 3 
[   40.638001]  Hello cpu 3 
[   40.638131] smp: csd: CSD lock (#7) got unstuck on CPU#05, CPU#03 released the lock.


I have kept the changes as RFC as one may argue that if we are bothered
about logs we may simply not use csdlock_debug but intention here is to
address/optimize the logging behaviour so that the feature can be used
for other bug detections.

Imran Khan (2):
  smp: Reduce logging due to dump_stack of CSD waiters.
  smp: Reduce NMI traffic from CSD waiters to CSD destination.

 kernel/smp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)


base-commit: 84e2893b4573da3bc0c9f24e2005442e420e3831
-- 
2.34.1

