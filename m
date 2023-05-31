Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0147717A69
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjEaIoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjEaIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:44:25 -0400
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2662139
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:44:02 -0700 (PDT)
X-QQ-mid: bizesmtp88t1685522565t2l3mhjk
Received: from [10.7.13.54] ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 May 2023 16:42:43 +0800 (CST)
X-QQ-SSF: 01400000000000C0G000000A0000000
X-QQ-FEAT: q+EIYT+FhZpO2RFB20DsmFECDaJGO91x8w+wNl4XDHHAajtQ9f5E8NOLnnpy8
        k+i7Z+2QMoNh2nL4KZUC63TwRvq6JjM5hs93tZuCF2LaUSmmK61Y1KZLfrKdgm2TAOSL+GY
        M3ahetdg9PHC/IAE7uEvKMx9/GeLtxbxCdXj/WLJth5+J05O/0KGxaWZo3L5WsWqkjRImAW
        uz6WVKPUlUjmuZFJTZgqwUC1pQSm/eil6vl5sBsrGglBBtDkq5ACjVzdD10VudVpBTogCL/
        HomMQapV5Ae5dsyhU6Ap3d+ONnQ5/2kSEqBQrli1WQ2s9ZcnIHAUTp+7zN4Svsq/Qgt8L14
        lsuRZZ5JjFC0xPwEZpZrBcKVyAHOlucSC2hN4nLqmYU7qTdekrRiJt4E6D7dg==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7957098482953656911
Message-ID: <A31B3EA06AF77F13+c7278bd0-2695-4cc0-5a56-531a06ac2389@uniontech.com>
Date:   Wed, 31 May 2023 16:42:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
From:   Gou Hao <gouhao@uniontech.com>
Subject: Question about oom-killer
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello everyone,

Recently, my kernel restarted while I was running ltp-oom02(It allocates 
memory infinitely in a loop, testing whether the oom-killer works 
properly ).
log:
```
[480156.950100] Tasks state (memory values in pages):
[480156.950101] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes 
swapents oom_score_adj name
[480156.950302] [   2578]    81  2578      523        0 393216        
6          -900 dbus-daemon
[480156.950309] [   2648]   172  2596     2435        0 393216        
5             0 rtkit-daemon
[480156.950322] [   5256]     0  2826    25411        0 589824        
0             0 DetectThread
[480156.950328] [   5404]     0  5404      412        2 393216       
64         -1000 sshd
[480156.950357] [  10518]     0 10518     2586        0 393216       
10             0 at-spi2-registr
[480156.950361] [  10553]     0 10551    10543        0 458752        
9             0 QXcbEventQueue
[480156.950365] [  10867]     0 10567    17579        0 589824       
16             0 QXcbEventQueue
[480156.950370] [  10928]     0 10921     6999        0 458752       
17             0 QXcbEventQueue
[480156.950390] [  11882]     0 11811     7377        0 458752       
10             0 QXcbEventQueue
[480156.950394] [  12052]     0 12052     5823        0 458752       
21             0 fcitx
[480156.950404] [  12115]     0 12114    11678        0 524288       
21             0 QXcbEventQueue
[480156.950408] [ 101558]     0 101558     3549        0 393216        
0             0 runltp
[480156.950486] [1068864]     0 1068864      771        6 327680       
85         -1000 systemd-udevd
[480156.950552] [1035639]     0 1035639       52        0 393216       
14         -1000 oom02
[480156.950556] [1035640]     0 1035640       52        0 393216       
23         -1000 oom02
[480156.950561] [1036065]     0 1036065      493       60 393216        
0          -250 systemd-journal
[480156.950565] [1036087]     0 1036073  6258739  3543942 
37814272        0             0 oom02
[480156.950572] Out of memory and no killable processes...
[480156.950575] Kernel panic - not syncing: System is deadlocked on memory
```

oom02-1036073 has been already killed before crash.
log:
```
[480152.242506] [1035177]     0 1035177     4773       20 393216      
115             0 sssd_nss
[480152.242510] [1035376]     0 1035376    25500      391 589824      
602             0 tuned
[480152.242514] [1035639]     0 1035639       52        0 393216       
14         -1000 oom02
[480152.242517] [1035640]     0 1035640       52        0 393216       
19         -1000 oom02
[480152.242522] [1036065]     0 1036065      493      114 393216       
62          -250 systemd-journal
[480152.242525] [1036073]     0 1036073  6258739  3540314 37814272      
104             0 oom02
[480152.242529] Out of memory: Kill process 1036073 (oom02) score 755 or 
sacrifice child
[480152.243869] Killed process 1036073 (oom02) total-vm:400559296kB, 
anon-rss:226578368kB, file-rss:1728kB, shmem-rss:0kB
[480152.365804] oom_reaper: reaped process 1036073 (oom02), now 
anon-rss:226594048kB, file-rss:0kB, shmem-rss:0kB
```
but its memory can not be reclaimed.I add trace-log to oom_reaper code 
in kernel,
I found that there is a large range vma in the memory that cannot be 
reclaimed, and the vma has the  `VM_LOCKED` flag, so cannot be reclaimed 
immediately.
```log
       oom_reaper-57    [007] ....   126.063581: __oom_reap_task_mm: gh: 
vma is anon:1048691, range=65536
       oom_reaper-57    [007] ....   126.063581: __oom_reap_task_mm: gh: 
vma is anon:1048691, range=196608
       oom_reaper-57    [007] ....   126.063582: __oom_reap_task_mm: gh: 
vma continue: 1056883, range:3221225472
       oom_reaper-57    [007] ....   126.063583: __oom_reap_task_mm: gh: 
vma is anon:112, range=65536
       oom_reaper-57    [007] ....   126.063584: __oom_reap_task_mm: gh: 
vma is anon:1048691, range=8388608
```
`vma continue: 1056883, range:3221225472` is the memory that can not 
reclaims. 1057883(0x102073) is vma->vm_flags, it has VM_LOCKED` flag

oom02 created `nr_cpu` threads and used mmap to allocate memory. mmap 
will merge continuous vma into one,
so as long as one thread is still running, the entire vma will not be 
released.

In extreme cases, crashes may occur due to the lack of memory reclamation.

I'm not sure if this is a kernel's bug ?

-- 
thanks,
Gou Hao <gouhao@uniontech.com>

