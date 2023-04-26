Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DBD6EEC45
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbjDZCOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbjDZCOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:14:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBE46A1;
        Tue, 25 Apr 2023 19:14:20 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q5j4z0mJdz18KLb;
        Wed, 26 Apr 2023 10:10:27 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 10:14:18 +0800
Subject: Re: Bug: "perf record" reporting buffer overflow when writing data
To:     Will Ochowicz <Will.Ochowicz@genusplc.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CWLP265MB497033A5B448268D677F03DD9C649@CWLP265MB4970.GBRP265.PROD.OUTLOOK.COM>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <6c88ac58-a2c8-0b15-a106-9c8b0e26b3ac@huawei.com>
Date:   Wed, 26 Apr 2023 10:14:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CWLP265MB497033A5B448268D677F03DD9C649@CWLP265MB4970.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/4/26 0:54, Will Ochowicz wrote:
> Hi all,
> 
> [1.] One line summary of the problem: "perf record" reporting buffer overflow when writing data
> [2.] Full description of the problem/report:
> I was using perf to monitor the performance of a node server, and when I stopped the server, perf crashed while writing the data with a message of
> 
>> [ perf record: Woken up 96 times to write data ]
>> *** buffer overflow detected ***: terminated
> 
> I downloaded perf version 5.10.158 (the same version that caused the issue) and compiled with debug symbols, but did not run into issues. However, after I started adding libraries to enable additional features, the buffer overflow began again.
> Below is the stack trace from where the crash occurred:
>       
> Thread 1 "perf" received signal SIGABRT, Aborted.
> __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
>      at ./nptl/pthread_kill.c:44
> 44      ./nptl/pthread_kill.c: No such file or directory.
> (gdb) bt
> #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
>      at ./nptl/pthread_kill.c:44
> #1  0x00007ffff72d4d2f in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
> #2  0x00007ffff7285ef2 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> #3  0x00007ffff7270472 in __GI_abort () at ./stdlib/abort.c:79
> #4  0x00007ffff72c92d0 in __libc_message (action=action@entry=do_abort,
>      fmt=fmt@entry=0x7ffff73e3210 "*** %s ***: terminated\n") at ../sysdeps/posix/libc_fatal.c:155
> #5  0x00007ffff7361e82 in __GI___fortify_fail (msg=msg@entry=0x7ffff73e31b6 "buffer overflow detected")
>      at ./debug/fortify_fail.c:26
> #6  0x00007ffff7360990 in __GI___chk_fail () at ./debug/chk_fail.c:28
> #7  0x00005555557e7ddd in memcpy (__len=40, __src=0x555556a28b38, __dest=0x7fffffff843c)
>      at /usr/include/x86_64-linux-gnu/bits/string_fortified.h:29
> #8  write_buildid (fd=0x7fffffff8590, misc=<optimized out>, pid=-1, bid=0x555556a28b38,
>      name_len=<optimized out>, name=0x555556a28c0c "/opt/pylon/lib/libpylonbase-6.1.1.so") at util/build-id.c:312
> #9  machine__write_buildid_table (machine=machine@entry=0x555555d9bef0, fd=fd@entry=0x7fffffff8590)
>      at util/build-id.c:361
> #10 0x00005555557e865e in perf_session__write_buildid_table (session=session@entry=0x555555d9bd00,
>      fd=fd@entry=0x7fffffff8590) at util/build-id.c:374
> #11 0x000055555581c4b9 in write_build_id (ff=ff@entry=0x7fffffff8590, evlist=evlist@entry=0x555555d96d60)
>      at util/header.c:320
> #12 0x0000555555824fa3 in do_write_feat (evlist=0x555555d96d60, p=<synthetic pointer>, type=2, ff=0x7fffffff8590)
>      at util/header.c:3224
> #13 perf_header__adds_write (fd=3, evlist=0x555555d96d60, header=<optimized out>) at util/header.c:3269
> #14 perf_session__write_header (session=<optimized out>, evlist=0x555555d96d60, fd=3, at_exit=at_exit@entry=true)
>      at util/header.c:3353
> #15 0x0000555555760777 in record__finish_output (rec=0x555555b9bb40 <record>) at builtin-record.c:1236
> #16 0x0000555555763560 in __cmd_record (rec=0x555555b9bb40 <record>, argv=<optimized out>, argc=<optimized out>)
>      at builtin-record.c:2026
> #17 cmd_record (argc=<optimized out>, argv=<optimized out>) at builtin-record.c:2835
> #18 0x00005555557dc8a3 in run_builtin (p=p@entry=0x555555ba6cb8 <commands+216>, argc=argc@entry=8,
>      argv=argv@entry=0x7fffffffdb90) at perf.c:312
> #19 0x000055555574af48 in handle_internal_command (argv=0x7fffffffdb90, argc=8) at perf.c:364
> #20 run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at perf.c:408
> #21 main (argc=8, argv=0x7fffffffdb90) at perf.c:538


Can you confirm the following two questions on your environment?
1. readelf -n /opt/pylon/lib/libpylonbase-6.1.1.so
Let's see what the output is.

2. Patch the following fix and check whether the problem recurs:

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 41882ae8452e..059f88eca630 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -903,7 +903,7 @@ static int elf_read_build_id(Elf *elf, void *bf, 
size_t size)
                                 size_t sz = min(size, descsz);
                                 memcpy(bf, ptr, sz);
                                 memset(bf + sz, 0, size - sz);
-                               err = descsz;
+                               err = sz;
                                 break;
                         }
                 }

Thanks,
Yang.
