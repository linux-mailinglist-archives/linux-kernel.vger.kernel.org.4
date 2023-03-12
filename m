Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5786B62FB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 03:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCLC6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 21:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCLC6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 21:58:11 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A6BDD4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:58:06 -0800 (PST)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32C2vAh1091464;
        Sun, 12 Mar 2023 11:57:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sun, 12 Mar 2023 11:57:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32C2vA1j091460
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 12 Mar 2023 11:57:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c1f4cc16-feea-b83c-82cf-1a1f007b7eb9@I-love.SAKURA.ne.jp>
Date:   Sun, 12 Mar 2023 11:57:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [syzbot] [kernel?] WARNING in c_start (2)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <0000000000004d318a05f6810a9f@google.com>
Cc:     syzbot <syzbot+96cae094d90877641f32@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000004d318a05f6810a9f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

syzbot is unable to test kernels due to hitting WARN_ON_ONCE(cpu >= bits) upon
"cat /proc/cpuinfo" request.

Since commit 596ff4a09b898179 ("cpumask: re-introduce constant-sized cpumask optimizations")
changed to pass "small_cpumask_bits" instead of "nr_cpumask_bits" to find_next_bit(),
find_next_bit() returning small_cpumask_bits causes c_next() to go beyond nr_cpumask_bits.
I think that we need to make sure that cpumask_next() and friends would not return cpu id
beyond nr_cpumask_bits.



Before commit 596ff4a09b898179:

----------
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..d2e49c74284a 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -152,10 +152,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
+	pr_info("*pos = %u, nr_cpu_ids = %u\n", *pos, nr_cpu_ids);
 	if ((*pos) < nr_cpu_ids)
 		return &cpu_data(*pos);
 	return NULL;
 }
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 10c92bd9b807..3d7127ebeb44 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -172,10 +172,11 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
  * Returns >= nr_cpu_ids if no further cpus set.
  */
 static inline
 unsigned int cpumask_next(int n, const struct cpumask *srcp)
 {
+	pr_info("bits = 0x%016lx, nr_cpumask_bits = %u, n + 1 = %u\n", *cpumask_bits(srcp), nr_cpumask_bits, n + 1);
 	/* -1 is a legal arg here. */
 	if (n != -1)
 		cpumask_check(n);
 	return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
 }
----------

----------
[   11.626748] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 0
[   11.626751] *pos = 0, nr_cpu_ids = 10
[   11.626765] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 1
[   11.626766] *pos = 1, nr_cpu_ids = 10
[   11.626775] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 2
[   11.626775] *pos = 2, nr_cpu_ids = 10
[   11.626783] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 3
[   11.626783] *pos = 3, nr_cpu_ids = 10
[   11.626791] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 4
[   11.626791] *pos = 4, nr_cpu_ids = 10
[   11.626819] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 4
[   11.626820] *pos = 4, nr_cpu_ids = 10
[   11.626828] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 5
[   11.626828] *pos = 5, nr_cpu_ids = 10
[   11.626835] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 6
[   11.626836] *pos = 6, nr_cpu_ids = 10
[   11.626843] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 7
[   11.626844] *pos = 7, nr_cpu_ids = 10
[   11.626851] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 8
[   11.626851] *pos = 8, nr_cpu_ids = 10
[   11.626862] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 8
[   11.626863] *pos = 8, nr_cpu_ids = 10
[   11.626870] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 9
[   11.626871] *pos = 9, nr_cpu_ids = 10
[   11.626878] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 10
[   11.626879] *pos = 10, nr_cpu_ids = 10
[   11.626883] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 10
[   11.626884] *pos = 10, nr_cpu_ids = 10
[   11.639390] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 0
[   11.639392] *pos = 0, nr_cpu_ids = 10
[   11.639406] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 1
[   11.639407] *pos = 1, nr_cpu_ids = 10
[   11.639416] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 2
[   11.639417] *pos = 2, nr_cpu_ids = 10
[   11.639424] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 3
[   11.639425] *pos = 3, nr_cpu_ids = 10
[   11.639432] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 4
[   11.639433] *pos = 4, nr_cpu_ids = 10
[   11.639459] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 4
[   11.639459] *pos = 4, nr_cpu_ids = 10
[   11.639467] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 5
[   11.639467] *pos = 5, nr_cpu_ids = 10
[   11.639475] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 6
[   11.639475] *pos = 6, nr_cpu_ids = 10
[   11.639483] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 7
[   11.639483] *pos = 7, nr_cpu_ids = 10
[   11.639490] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 8
[   11.639491] *pos = 8, nr_cpu_ids = 10
[   11.639503] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 8
[   11.639503] *pos = 8, nr_cpu_ids = 10
[   11.639510] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 9
[   11.639511] *pos = 9, nr_cpu_ids = 10
[   11.639518] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 10
[   11.639519] *pos = 10, nr_cpu_ids = 10
[   11.639524] bits = 0x00000000000003ff, nr_cpumask_bits = 10, n + 1 = 10
[   11.639524] *pos = 10, nr_cpu_ids = 10
----------

After commit 596ff4a09b898179:

----------
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..d2e49c74284a 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -152,10 +152,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
+	pr_info("*pos = %u, nr_cpu_ids = %u\n", *pos, nr_cpu_ids);
 	if ((*pos) < nr_cpu_ids)
 		return &cpu_data(*pos);
 	return NULL;
 }
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 8fbe76607965..0aaa0a32a39f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -205,10 +205,11 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
  * Returns >= nr_cpu_ids if no further cpus set.
  */
 static inline
 unsigned int cpumask_next(int n, const struct cpumask *srcp)
 {
+	pr_info("bits = 0x%016lx, small_cpumask_bits = %u, n + 1 = %u\n", *cpumask_bits(srcp), small_cpumask_bits, n + 1);
 	/* -1 is a legal arg here. */
 	if (n != -1)
 		cpumask_check(n);
 	return find_next_bit(cpumask_bits(srcp), small_cpumask_bits, n + 1);
 }
----------

----------
[   10.954521] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 0
[   10.954525] *pos = 0, nr_cpu_ids = 10
[   10.954544] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 1
[   10.954545] *pos = 1, nr_cpu_ids = 10
[   10.954557] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 2
[   10.954557] *pos = 2, nr_cpu_ids = 10
[   10.954568] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 3
[   10.954569] *pos = 3, nr_cpu_ids = 10
[   10.954580] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 4
[   10.954580] *pos = 4, nr_cpu_ids = 10
[   10.954625] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 4
[   10.954627] *pos = 4, nr_cpu_ids = 10
[   10.954638] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 5
[   10.954638] *pos = 5, nr_cpu_ids = 10
[   10.954649] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 6
[   10.954649] *pos = 6, nr_cpu_ids = 10
[   10.954660] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 7
[   10.954660] *pos = 7, nr_cpu_ids = 10
[   10.954671] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 8
[   10.954671] *pos = 8, nr_cpu_ids = 10
[   10.954689] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 8
[   10.954689] *pos = 8, nr_cpu_ids = 10
[   10.954700] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 9
[   10.954701] *pos = 9, nr_cpu_ids = 10
[   10.954711] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 10
[   10.954712] *pos = 64, nr_cpu_ids = 10
[   10.954720] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 64
[   10.954830] ------------[ cut here ]------------
[   10.954832] WARNING: CPU: 0 PID: 417 at include/linux/cpumask.h:143 c_start+0xb4/0xe0
[   10.954838] Modules linked in: sch_fq_codel(E) msr(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E) raid6_pq(E) xor(E) libcrc32c(E) raid1(E) raid0(E) multipath(E) linear(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) aesni_intel(E) crypto_simd(E) ahci(E) cryptd(E) psmouse(E) libahci(E) e1000(E) i2c_piix4(E) pata_acpi(E)
[   10.954862] CPU: 0 PID: 417 Comm: grep Tainted: G            E      6.2.0+ #950
[   10.954865] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[   10.954866] RIP: 0010:c_start+0xb4/0xe0
[   10.954868] Code: 82 e9 01 48 39 c3 7d 17 48 83 fb 40 73 2a 48 c7 c0 a0 98 01 00 48 03 04 dd e0 c9 c7 a6 eb 02 31 c0 48 83 c4 08 5b 41 5e 5d c3 <0f> 0b 83 fb 3f 76 8e be 40 00 00 00 eb ad 48 c7 c7 10 59 24 a7 48
[   10.954870] RSP: 0018:ffff9d5d80943d58 EFLAGS: 00010293
[   10.954872] RAX: 000000000000003f RBX: 0000000000000040 RCX: e79682b5424b6f00
[   10.954874] RDX: 0000000000001fff RSI: 0000000000000000 RDI: ffff8eb1db821608
[   10.954877] RBP: ffff9d5d80943d70 R08: 3436203d2031202b R09: 206e202c3436203d
[   10.954878] R10: 203d20737469625f R11: 6b73616d7570635f R12: ffff8eb1c764e650
[   10.954879] R13: ffff9d5d80943e20 R14: ffff8eb1c764e640 R15: 0000000000000000
[   10.954880] FS:  00007ff2c79b7740(0000) GS:ffff8eb1db800000(0000) knlGS:0000000000000000
[   10.954882] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.954884] CR2: 0000559fdf1c6000 CR3: 0000000108b9a004 CR4: 00000000000306f0
[   10.954887] Call Trace:
[   10.954888]  <TASK>
[   10.954890]  seq_read_iter+0x11c/0x410
[   10.954895]  proc_reg_read_iter+0xe3/0x110
[   10.954898]  vfs_read+0x23c/0x2a0
[   10.954901]  ksys_read+0x6d/0xd0
[   10.954902]  __x64_sys_read+0x1f/0x30
[   10.954904]  do_syscall_64+0x68/0x90
[   10.954907]  ? exc_page_fault+0x92/0x240
[   10.954909]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   10.954911] RIP: 0033:0x7ff2c7714992
[   10.954913] Code: c0 e9 b2 fe ff ff 50 48 8d 3d fa b2 0c 00 e8 c5 1d 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[   10.954915] RSP: 002b:00007fff5a069b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   10.954917] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007ff2c7714992
[   10.954918] RDX: 0000000000016000 RSI: 0000559fdf1c658a RDI: 0000000000000003
[   10.954919] RBP: 0000559fdf1c658a R08: 0000000000019000 R09: 0000000000000000
[   10.954920] R10: 0000000000000066 R11: 0000000000000246 R12: 0000000000000003
[   10.954921] R13: 0000000000016000 R14: 00007fff5a069be0 R15: 0000000000016000
[   10.954923]  </TASK>
[   10.954924] ---[ end trace 0000000000000000 ]---
[   10.954925] *pos = 64, nr_cpu_ids = 10
[   10.977061] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 0
[   10.977064] *pos = 0, nr_cpu_ids = 10
[   10.977079] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 1
[   10.977080] *pos = 1, nr_cpu_ids = 10
[   10.977089] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 2
[   10.977090] *pos = 2, nr_cpu_ids = 10
[   10.977098] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 3
[   10.977098] *pos = 3, nr_cpu_ids = 10
[   10.977106] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 4
[   10.977107] *pos = 4, nr_cpu_ids = 10
[   10.977133] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 4
[   10.977134] *pos = 4, nr_cpu_ids = 10
[   10.977142] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 5
[   10.977143] *pos = 5, nr_cpu_ids = 10
[   10.977150] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 6
[   10.977151] *pos = 6, nr_cpu_ids = 10
[   10.977159] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 7
[   10.977159] *pos = 7, nr_cpu_ids = 10
[   10.977167] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 8
[   10.977167] *pos = 8, nr_cpu_ids = 10
[   10.977179] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 8
[   10.977180] *pos = 8, nr_cpu_ids = 10
[   10.977187] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 9
[   10.977188] *pos = 9, nr_cpu_ids = 10
[   10.977196] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 10
[   10.977196] *pos = 64, nr_cpu_ids = 10
[   10.977201] bits = 0x00000000000003ff, small_cpumask_bits = 64, n + 1 = 64
[   10.979923] *pos = 64, nr_cpu_ids = 10
----------

On 2023/03/10 9:42, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    44889ba56cbb Merge tag 'net-6.3-rc2' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13933824c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d677dcd743eef09
> dashboard link: https://syzkaller.appspot.com/bug?extid=96cae094d90877641f32
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+96cae094d90877641f32@syzkaller.appspotmail.com

