Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5E766997C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjAMOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241732AbjAMOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:05:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1688461B;
        Fri, 13 Jan 2023 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MhcwWrz8FiVfMvlDL3gkNgnbhWSxUx3D4Ds0lnCP4Fw=; b=E0ex6CpT5mEiVPEFmSYjH/Omzj
        5WGv8TKeezWxzHhwlaCmKGmmIVYkHo6BI1ES/81BV/DCqzx4ZmAwF/Q+0bfNBgh3hVLTPxjtDMyn/
        eWeUuC08j7CyMEsb0H+W05l9EOcbAMBStJxEr7thF92B1h37gJyGJzwr7VWJdM+J9QHMmIz4jImwa
        sNShapw9/Vp4RA2NlmxTmguX/X/UefJFJE+xsi6K7bQ2oyhdGosz2fp96tGJMHGqUUJD7VvZaX0ry
        5gkSNNOI4MrJrvSiHqXNUxKO8Uwf9qgqrCgWtBZYeVfRLNv3ykStOkgz+RM65O4dUWliLkL028mk+
        oPotB1CQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGKdz-0069LE-EO; Fri, 13 Jan 2023 14:02:55 +0000
Date:   Fri, 13 Jan 2023 14:02:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: BUG: kernel NULL pointer dereference, address:
 0000000000000008 - RIP: 0010:do_wp_page
Message-ID: <Y8Fkjxsq5EOtGiql@casper.infradead.org>
References: <CA+G9fYt_b04YNCCv-iTZTtwb5fmNEQ0abiO46qW_-SrA1GQX8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+G9fYt_b04YNCCv-iTZTtwb5fmNEQ0abiO46qW_-SrA1GQX8w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 06:53:01PM +0530, Naresh Kamboju wrote:
> Linux next tag 20230113 boot failed on x86_64, arm64, arm and i386.

Why are you still not running these stack dumps through
scripts/decode_stacktrace.sh ?  That seems like it's much easier for you
to do than expecting everybody who might be interested in investigating
your reports to pull down enough of the build artifacts to make it work.

> Good: next-20230112
> Bad: next-20230113
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> [    0.000000] Linux version 6.2.0-rc3-next-20230113 (tuxmake@tuxmake)
> (x86_64-linux-gnu-gcc (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils
> for Debian) 2.39) #1 SMP PREEMPT_DYNAMIC @1673583678
> ...
> [   15.743593] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [   15.750037] x86/mm: Checking user space page tables
> [   15.799837] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [   15.806286] Run /sbin/init as init process
> [   15.945626] BUG: kernel NULL pointer dereference, address: 00000000000=
00008
> [   15.952588] #PF: supervisor read access in kernel mode
> [   15.957720] #PF: error_code(0x0000) - not-present page
> [   15.962850] PGD 8000000103213067 P4D 8000000103213067 PUD 103212067 PM=
D 0
> [   15.969724] Oops: 0000 [#1] PREEMPT SMP PTI
> [   15.973909] CPU: 3 PID: 1 Comm: init Not tainted 6.2.0-rc3-next-202301=
13 #1
> [   15.980869] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   15.988336] RIP: 0010:do_wp_page+0x236/0xef0
> [   15.992611] Code: 83 ea 01 49 89 d7 48 85 d2 0f 85 00 ff ff ff 49
> 8b 7c 24 60 e8 0b f2 e9 00 41 8b 44 24 28 4d 8b 74 24 50 4d 8b 2c 24
> 89 45 88 <49> 8b 46 08 49 8b 5d 10 a8 01 0f 85 78 02 00 00 0f 1f 44 00
> 00 4c
> [   16.011356] RSP: 0000:ffffb3f640027d18 EFLAGS: 00010286
> [   16.016583] RAX: 0000000000000a55 RBX: 0400000000000080 RCX: 000000000=
0000000
> [   16.023715] RDX: 0000000000000000 RSI: ffffffff8d3d2bd5 RDI: ffffffff8=
e271dfa
> [   16.030838] RBP: ffffb3f640027db0 R08: 8000000432ee9225 R09: ffff8ac34=
31e3100
> [   16.037962] R10: 0000000000000000 R11: 00007fe169f2f598 R12: ffffb3f64=
0027de0
> [   16.045087] R13: ffff8ac3431e2000 R14: 0000000000000000 R15: 040000000=
0000000
> [   16.052211] FS:  00007fe16973e800(0000) GS:ffff8ac69fd80000(0000)
> knlGS:0000000000000000
> [   16.060319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.066060] CR2: 0000000000000008 CR3: 00000001008d4002 CR4: 000000000=
03706e0
> [   16.073183] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   16.080322] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   16.087446] Call Trace:
> [   16.089893]  <TASK>
> [   16.091991]  ? trace_preempt_off+0x2d/0xd0
> [   16.096087]  ? __handle_mm_fault+0x7ee/0x12f0
> [   16.100439]  __handle_mm_fault+0xabf/0x12f0
> [   16.104617]  handle_mm_fault+0xf8/0x320
> [   16.108457]  do_user_addr_fault+0x1d9/0x650
> [   16.112642]  exc_page_fault+0x6b/0x170
> [   16.116394]  asm_exc_page_fault+0x2b/0x30
> [   16.120408] RIP: 0033:0x7fe169dbf31e
> [   16.123986] Code: ba ff ff ff ff 0f 9f c0 0f b6 c0 0f 4c c2 c3 66
> 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 54 31 c0 ba ff ff ff ff 53 48
> 83 ec 08 <f0> 0f b1 15 72 02 17 00 83 f8 ff 74 35 41 89 c4 85 c0 75 21
> 31 c0
> [   16.142724] RSP: 002b:00007ffcd0edec80 EFLAGS: 00010202
> [   16.147948] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000=
0555bd8
> [   16.155074] RDX: 00000000ffffffff RSI: 00007ffcd0edefa8 RDI: 000000000=
0000001
> [   16.162198] RBP: 00007ffcd0edefa8 R08: 00007fe169bc5a10 R09: 00007fe16=
9f37a10
> [   16.169319] R10: 00007fe169adf3ee R11: 0000000000000246 R12: 00007ffcd=
0edefa8
> [   16.176445] R13: 000000000041b9a0 R14: 0000000000555bd8 R15: 00007fe16=
9f69000
> [   16.183569]  </TASK>
> [   16.185752] Modules linked in:
> [   16.188803] CR2: 0000000000000008
> [   16.192114] ---[ end trace 0000000000000000 ]---
> [   16.196723] RIP: 0010:do_wp_page+0x236/0xef0
> [   16.200986] Code: 83 ea 01 49 89 d7 48 85 d2 0f 85 00 ff ff ff 49
> 8b 7c 24 60 e8 0b f2 e9 00 41 8b 44 24 28 4d 8b 74 24 50 4d 8b 2c 24
> 89 45 88 <49> 8b 46 08 49 8b 5d 10 a8 01 0f 85 78 02 00 00 0f 1f 44 00
> 00 4c
> [   16.219724] RSP: 0000:ffffb3f640027d18 EFLAGS: 00010286
> [   16.224943] RAX: 0000000000000a55 RBX: 0400000000000080 RCX: 000000000=
0000000
> [   16.232065] RDX: 0000000000000000 RSI: ffffffff8d3d2bd5 RDI: ffffffff8=
e271dfa
> [   16.239197] RBP: ffffb3f640027db0 R08: 8000000432ee9225 R09: ffff8ac34=
31e3100
> [   16.246324] R10: 0000000000000000 R11: 00007fe169f2f598 R12: ffffb3f64=
0027de0
> [   16.253447] R13: ffff8ac3431e2000 R14: 0000000000000000 R15: 040000000=
0000000
> [   16.260571] FS:  00007fe16973e800(0000) GS:ffff8ac69fd80000(0000)
> knlGS:0000000000000000
> [   16.268646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.274384] CR2: 0000000000000008 CR3: 00000001008d4002 CR4: 000000000=
03706e0
> [   16.281510] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   16.288641] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   16.295799] Kernel panic - not syncing: Attempted to kill init!
> exitcode=3D0x00000009
> [   16.303496] Kernel Offset: 0xc000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   16.314190] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=3D0x00000009 ]---
>=20
> test log link,
> https://lkft.validation.linaro.org/scheduler/job/6053089#L1041
>=20
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 6b31ffe9c8b9947d6d3552d6e10752fd96d0f80f
>   git_describe: next-20230113
>   kernel_version: 6.2.0-rc3
>   kernel-config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2KFwDAHYQ8Mozgm557=
8uo8SCCin/config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pip=
elines/746141614
>   artifact-location:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2KFwDAHYQ8Mozgm557=
8uo8SCCin/
>   toolchain: gcc-11
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org

> 2023-01-13T04:28:24 lava-dispatcher, installed at version: 2022.11.1
> 2023-01-13T04:28:24 start: 0 validate
> 2023-01-13T04:28:24 Start time: 2023-01-13 04:28:24.323888+00:00 (UTC)
> 2023-01-13T04:28:24 Using caching service: 'http://lkft-cache.lkftlab/api=
/v1/fetch?url=3D%s'
> 2023-01-13T04:28:24 Validating that http://lkft-cache.lkftlab/api/v1/fetc=
h?url=3Dhttps%3A%2F%2Fstorage.tuxsuite.com%2Fpublic%2Flinaro%2Flkft%2Fbuild=
s%2F2KFwDAHYQ8Mozgm5578uo8SCCin%2FbzImage exists
> 2023-01-13T04:28:26 Using caching service: 'http://lkft-cache.lkftlab/api=
/v1/fetch?url=3D%s'
> 2023-01-13T04:28:26 Validating that http://lkft-cache.lkftlab/api/v1/fetc=
h?url=3Dhttps%3A%2F%2Fstorage.tuxsuite.com%2Fpublic%2Flinaro%2Flkft%2Foebui=
lds%2F2JrJTF7S8iQYtcHKhPM1Od8tdu4%2Fimages%2Fintel-corei7-64%2Flkft-console=
-image-intel-corei7-64-20230104120429.rootfs.tar.xz exists
> 2023-01-13T04:28:26 Using caching service: 'http://lkft-cache.lkftlab/api=
/v1/fetch?url=3D%s'
> 2023-01-13T04:28:26 Validating that http://lkft-cache.lkftlab/api/v1/fetc=
h?url=3Dhttps%3A%2F%2Fstorage.tuxsuite.com%2Fpublic%2Flinaro%2Flkft%2Fbuild=
s%2F2KFwDAHYQ8Mozgm5578uo8SCCin%2Fmodules.tar.xz exists
> 2023-01-13T04:28:27 validate duration: 3.24
> 2023-01-13T04:28:27 {'case': 'validate', 'definition': 'lava', 'result': =
'pass'}
> 2023-01-13T04:28:27 start: 1 tftp-deploy (timeout 00:40:00) [common]
> 2023-01-13T04:28:27 start: 1.1 download-retry (timeout 00:40:00) [common]
> 2023-01-13T04:28:27 start: 1.1.1 http-download (timeout 00:40:00) [common]
> 2023-01-13T04:28:27 downloading https://storage.tuxsuite.com/public/linar=
o/lkft/builds/2KFwDAHYQ8Mozgm5578uo8SCCin/bzImage
> 2023-01-13T04:28:27 saving as /var/lib/lava/dispatcher/tmp/6053089/tftp-d=
eploy-qytnh1b1/kernel/bzImage
> 2023-01-13T04:28:27 total size: 14908928 (14MB)
> 2023-01-13T04:28:27 No compression specified
> 2023-01-13T04:28:27 progress   0% (0MB)
> 2023-01-13T04:28:27 progress   5% (0MB)
> 2023-01-13T04:28:27 progress  10% (1MB)
> 2023-01-13T04:28:27 progress  15% (2MB)
> 2023-01-13T04:28:27 progress  20% (2MB)
> 2023-01-13T04:28:27 progress  25% (3MB)
> 2023-01-13T04:28:27 progress  30% (4MB)
> 2023-01-13T04:28:27 progress  35% (5MB)
> 2023-01-13T04:28:27 progress  40% (5MB)
> 2023-01-13T04:28:27 progress  45% (6MB)
> 2023-01-13T04:28:27 progress  50% (7MB)
> 2023-01-13T04:28:27 progress  55% (7MB)
> 2023-01-13T04:28:27 progress  60% (8MB)
> 2023-01-13T04:28:27 progress  65% (9MB)
> 2023-01-13T04:28:27 progress  70% (9MB)
> 2023-01-13T04:28:27 progress  75% (10MB)
> 2023-01-13T04:28:27 progress  80% (11MB)
> 2023-01-13T04:28:27 progress  85% (12MB)
> 2023-01-13T04:28:27 progress  90% (12MB)
> 2023-01-13T04:28:27 progress  95% (13MB)
> 2023-01-13T04:28:27 progress 100% (14MB)
> 2023-01-13T04:28:27 14MB downloaded in 0.21s (66.42MB/s)
> 2023-01-13T04:28:27 end: 1.1.1 http-download (duration 00:00:00) [common]
> 2023-01-13T04:28:27 {'case': 'http-download', 'definition': 'lava', 'dura=
tion': '0.22', 'extra': {'label': 'kernel', 'md5sum': '88bdc1409ad92956d9fa=
2f61086fd351', 'sha256sum': '4dac414ad5261b00908293452994a8d7b8647bcd10abed=
caa4f3a401f96a69ad', 'sha512sum': '53105c34aed4f7b7b847d326c9ad31ef884cc68e=
09e26e0113a4a62bebb2fd2d3711416d7bf22d4aac265b3eb37e31d95038d5bef3929e31526=
4e681549a7ca4', 'size': 14908928}, 'level': '1.1.1', 'namespace': 'common',=
 'result': 'pass'}
> 2023-01-13T04:28:27 end: 1.1 download-retry (duration 00:00:00) [common]
> 2023-01-13T04:28:27 start: 1.2 download-retry (timeout 00:40:00) [common]
> 2023-01-13T04:28:27 start: 1.2.1 http-download (timeout 00:40:00) [common]
> 2023-01-13T04:28:27 downloading https://storage.tuxsuite.com/public/linar=
o/lkft/oebuilds/2JrJTF7S8iQYtcHKhPM1Od8tdu4/images/intel-corei7-64/lkft-con=
sole-image-intel-corei7-64-20230104120429.rootfs.tar.xz
> 2023-01-13T04:28:27 saving as /var/lib/lava/dispatcher/tmp/6053089/tftp-d=
eploy-qytnh1b1/nfsrootfs/lkft-console-image-intel-corei7-64-20230104120429.=
rootfs.tar
> 2023-01-13T04:28:27 total size: 452476652 (431MB)
> 2023-01-13T04:28:27 Using unxz to decompress xz
> 2023-01-13T04:28:27 progress   0% (0MB)
> 2023-01-13T04:28:30 progress   5% (21MB)
> 2023-01-13T04:28:32 progress  10% (43MB)
> 2023-01-13T04:28:34 progress  15% (64MB)
> 2023-01-13T04:28:34 progress  20% (86MB)
> 2023-01-13T04:28:36 progress  25% (107MB)
> 2023-01-13T04:28:37 progress  30% (129MB)
> 2023-01-13T04:28:37 progress  35% (151MB)
> 2023-01-13T04:28:39 progress  40% (172MB)
> 2023-01-13T04:28:39 progress  45% (194MB)
> 2023-01-13T04:28:39 progress  50% (215MB)
> 2023-01-13T04:28:41 progress  55% (237MB)
> 2023-01-13T04:28:43 progress  60% (258MB)
> 2023-01-13T04:28:44 progress  65% (280MB)
> 2023-01-13T04:28:45 progress  70% (302MB)
> 2023-01-13T04:28:47 progress  75% (323MB)
> 2023-01-13T04:28:50 progress  80% (345MB)
> 2023-01-13T04:28:52 progress  85% (366MB)
> 2023-01-13T04:28:53 progress  90% (388MB)
> 2023-01-13T04:28:55 progress  95% (409MB)
> 2023-01-13T04:28:57 progress 100% (431MB)
> 2023-01-13T04:28:57 431MB downloaded in 29.31s (14.72MB/s)
> 2023-01-13T04:28:57 end: 1.2.1 http-download (duration 00:00:29) [common]
> 2023-01-13T04:28:57 {'case': 'http-download', 'definition': 'lava', 'dura=
tion': '29.31', 'extra': {'label': 'nfsrootfs', 'md5sum': '753af3e9c15f1a7d=
3d5481c54a71bb90', 'sha256sum': '78b4eda2b0fb06389fa77b979af00e226c3aaa4a0d=
c3fa38a39d415e268ea72e', 'sha512sum': '04939458fa8e8c238264cd19922e9c2733a4=
e17935f1a8d778fbc88d56239d3f9d45064a7780a50e11f32f6c0f6f64c48731a34ab1487ef=
6151bdea2a82b8123', 'size': 452476652}, 'level': '1.2.1', 'namespace': 'com=
mon', 'result': 'pass'}
> 2023-01-13T04:28:57 end: 1.2 download-retry (duration 00:00:29) [common]
> 2023-01-13T04:28:57 start: 1.3 download-retry (timeout 00:39:30) [common]
> 2023-01-13T04:28:57 start: 1.3.1 http-download (timeout 00:39:30) [common]
> 2023-01-13T04:28:57 downloading https://storage.tuxsuite.com/public/linar=
o/lkft/builds/2KFwDAHYQ8Mozgm5578uo8SCCin/modules.tar.xz
> 2023-01-13T04:28:57 saving as /var/lib/lava/dispatcher/tmp/6053089/tftp-d=
eploy-qytnh1b1/modules/modules.tar
> 2023-01-13T04:28:57 total size: 207796 (0MB)
> 2023-01-13T04:28:57 Using unxz to decompress xz
> 2023-01-13T04:28:57 progress  15% (0MB)
> 2023-01-13T04:28:57 progress  31% (0MB)
> 2023-01-13T04:28:57 progress  47% (0MB)
> 2023-01-13T04:28:57 progress  63% (0MB)
> 2023-01-13T04:28:57 progress  78% (0MB)
> 2023-01-13T04:28:57 progress  94% (0MB)
> 2023-01-13T04:28:57 progress 100% (0MB)
> 2023-01-13T04:28:57 0MB downloaded in 0.11s (1.75MB/s)
> 2023-01-13T04:28:57 end: 1.3.1 http-download (duration 00:00:00) [common]
> 2023-01-13T04:28:57 {'case': 'http-download', 'definition': 'lava', 'dura=
tion': '0.11', 'extra': {'label': 'modules', 'md5sum': '0bc1e0e368e01319a68=
6c964daf6ee1f', 'sha256sum': '1b0d75ef814233446a51d952e8040bebdfd8da6a6365d=
6213a81dfeeffd6e3d2', 'sha512sum': '3ecb5e778f9b7dc9252a332dcc88ad7bc053ac9=
270b71a0155442e72c8a4d5bad4e86b9679f15924b51a39183c5c75c3d25c60da46ecb23c12=
6e98d7ceedd287', 'size': 207796}, 'level': '1.3.1', 'namespace': 'common', =
'result': 'pass'}
> 2023-01-13T04:28:57 end: 1.3 download-retry (duration 00:00:00) [common]
> 2023-01-13T04:28:57 start: 1.4 prepare-tftp-overlay (timeout 00:39:30) [c=
ommon]
> 2023-01-13T04:28:57 start: 1.4.1 extract-nfsrootfs (timeout 00:39:30) [co=
mmon]
> 2023-01-13T04:29:08 Extracted nfsroot to /var/lib/lava/dispatcher/tmp/605=
3089/extract-nfsrootfs-bwf2gbp6
> 2023-01-13T04:29:08 end: 1.4.1 extract-nfsrootfs (duration 00:00:11) [com=
mon]
> 2023-01-13T04:29:08 start: 1.4.2 lava-overlay (timeout 00:39:19) [common]
> 2023-01-13T04:29:08 [common] Preparing overlay tarball in /var/lib/lava/d=
ispatcher/tmp/6053089/lava-overlay-n9cz5ml5
> 2023-01-13T04:29:08 makedir: /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin
> 2023-01-13T04:29:08 makedir: /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/tests
> 2023-01-13T04:29:08 makedir: /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/results
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-add-keys
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-add-sources
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-background-process-start
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-background-process-stop
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-common-functions
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-echo-ipv4
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-install-packages
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-installed-packages
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-os-build
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-probe-channel
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-probe-ip
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-target-ip
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-target-mac
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-target-storage
> 2023-01-13T04:29:08 storage methods:	SATA	/dev/disk/by-id/ata-TOSHIBA_MG0=
3ACA100_37O9KGL0F
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-test-case
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-test-event
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-test-feedback
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-test-raise
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-test-reference
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-test-runner
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-test-set
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-test-shell
> 2023-01-13T04:29:08 Updating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-install-packages (oe)
> 2023-01-13T04:29:08 Updating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/bin/lava-installed-packages (oe)
> 2023-01-13T04:29:08 Creating /var/lib/lava/dispatcher/tmp/6053089/lava-ov=
erlay-n9cz5ml5/lava-6053089/environment
> 2023-01-13T04:29:08 storage_info:
> 2023-01-13T04:29:08 - LAVA_STORAGE_INFO_0_SATA=3D/dev/disk/by-id/ata-TOSH=
IBA_MG03ACA100_37O9KGL0F
> 2023-01-13T04:29:08 LAVA metadata
> 2023-01-13T04:29:08 - LAVA_JOB_ID=3D6053089
> 2023-01-13T04:29:08 - LAVA_DISPATCHER_IP=3D10.66.16.124
> 2023-01-13T04:29:08 start: 1.4.2.1 ssh-authorize (timeout 00:39:19) [comm=
on]
> 2023-01-13T04:29:08 end: 1.4.2.1 ssh-authorize (duration 00:00:00) [commo=
n]
> 2023-01-13T04:29:08 start: 1.4.2.2 lava-vland-overlay (timeout 00:39:19) =
[common]
> 2023-01-13T04:29:08 skipped lava-vland-overlay
> 2023-01-13T04:29:08 end: 1.4.2.2 lava-vland-overlay (duration 00:00:00) [=
common]
> 2023-01-13T04:29:08 start: 1.4.2.3 lava-multinode-overlay (timeout 00:39:=
19) [common]
> 2023-01-13T04:29:08 skipped lava-multinode-overlay
> 2023-01-13T04:29:08 end: 1.4.2.3 lava-multinode-overlay (duration 00:00:0=
0) [common]
> 2023-01-13T04:29:08 start: 1.4.2.4 test-definition (timeout 00:39:19) [co=
mmon]
> 2023-01-13T04:29:08 Loading test definitions
> 2023-01-13T04:29:08 start: 1.4.2.4.1 inline-repo-action (timeout 00:39:19=
) [common]
> 2023-01-13T04:29:08 Using /lava-6053089 at stage 0
> 2023-01-13T04:29:08 uuid=3D6053089_1.4.2.4.1 testdef=3DNone
> 2023-01-13T04:29:08 end: 1.4.2.4.1 inline-repo-action (duration 00:00:00)=
 [common]
> 2023-01-13T04:29:08 start: 1.4.2.4.2 test-overlay (timeout 00:39:19) [com=
mon]
> 2023-01-13T04:29:08 end: 1.4.2.4.2 test-overlay (duration 00:00:00) [comm=
on]
> 2023-01-13T04:29:08 {'case': 'test-overlay', 'definition': 'lava', 'durat=
ion': '0.00', 'extra': {'from': 'inline', 'name': 'prep-tmp-disk', 'path': =
'inline/prep.yaml', 'uuid': '6053089_1.4.2.4.1'}, 'level': '1.4.2.4.2', 'na=
mespace': 'common', 'result': 'pass'}
> 2023-01-13T04:29:08 start: 1.4.2.4.3 test-install-overlay (timeout 00:39:=
19) [common]
> 2023-01-13T04:29:08 end: 1.4.2.4.3 test-install-overlay (duration 00:00:0=
0) [common]
> 2023-01-13T04:29:08 {'case': 'test-install-overlay', 'definition': 'lava'=
, 'duration': '0.03', 'extra': {'from': 'inline', 'name': 'prep-tmp-disk', =
'path': 'inline/prep.yaml', 'skipped test-install-overlay': '6053089_1.4.2.=
4.1', 'uuid': '6053089_1.4.2.4.1'}, 'level': '1.4.2.4.3', 'namespace': 'com=
mon', 'result': 'pass'}
> 2023-01-13T04:29:08 start: 1.4.2.4.4 test-runscript-overlay (timeout 00:3=
9:19) [common]
> 2023-01-13T04:29:08 runner path: /var/lib/lava/dispatcher/tmp/6053089/lav=
a-overlay-n9cz5ml5/lava-6053089/0/tests/0_prep-tmp-disk test_uuid 6053089_1=
=2E4.2.4.1
> 2023-01-13T04:29:08 end: 1.4.2.4.4 test-runscript-overlay (duration 00:00=
:00) [common]
> 2023-01-13T04:29:08 {'case': 'test-runscript-overlay', 'definition': 'lav=
a', 'duration': '0.00', 'extra': {'filename': '/var/lib/lava/dispatcher/tmp=
/6053089/lava-overlay-n9cz5ml5/lava-6053089/0/tests/0_prep-tmp-disk/run.sh'=
, 'from': 'inline', 'name': 'prep-tmp-disk', 'path': 'inline/prep.yaml', 'u=
uid': '6053089_1.4.2.4.1'}, 'level': '1.4.2.4.4', 'namespace': 'common', 'r=
esult': 'pass'}
> 2023-01-13T04:29:08 start: 1.4.2.4.5 git-repo-action (timeout 00:39:19) [=
common]
> 2023-01-13T04:29:08 Using /lava-6053089 at stage 1
> 2023-01-13T04:29:08 Fetching tests from https://github.com/Linaro/test-de=
finitions.git
> 2023-01-13T04:29:08 Running '/usr/bin/git clone --depth=3D1 https://githu=
b.com/Linaro/test-definitions.git /var/lib/lava/dispatcher/tmp/6053089/lava=
-overlay-n9cz5ml5/lava-6053089/1/tests/1_ltp-smoketest'
> 2023-01-13T04:29:21 Tests stored (tmp) in /var/lib/lava/dispatcher/tmp/60=
53089/lava-overlay-n9cz5ml5/lava-6053089/1/tests/1_ltp-smoketest/automated/=
linux/ltp/ltp.yaml
> 2023-01-13T04:29:21 uuid=3D6053089_1.4.2.4.5 testdef=3DNone
> 2023-01-13T04:29:21 end: 1.4.2.4.5 git-repo-action (duration 00:00:13) [c=
ommon]
> 2023-01-13T04:29:21 {'case': 'git-repo-action', 'definition': 'lava', 'du=
ration': '12.85', 'extra': {'commit': '952f6f6d7c3c1137c0511522d8503616baee=
f078', 'path': 'automated/linux/ltp/ltp.yaml', 'repository': 'https://githu=
b.com/Linaro/test-definitions.git'}, 'level': '1.4.2.4.5', 'namespace': 'co=
mmon', 'result': 'pass'}
> 2023-01-13T04:29:21 start: 1.4.2.4.6 test-overlay (timeout 00:39:06) [com=
mon]
> 2023-01-13T04:29:21 end: 1.4.2.4.6 test-overlay (duration 00:00:00) [comm=
on]
> 2023-01-13T04:29:21 {'case': 'test-overlay', 'definition': 'lava', 'durat=
ion': '0.00', 'extra': {'from': 'git', 'name': 'ltp-smoketest', 'path': 'au=
tomated/linux/ltp/ltp.yaml', 'repository': 'https://github.com/Linaro/test-=
definitions.git', 'uuid': '6053089_1.4.2.4.5'}, 'level': '1.4.2.4.6', 'name=
space': 'common', 'result': 'pass'}
> 2023-01-13T04:29:21 start: 1.4.2.4.7 test-install-overlay (timeout 00:39:=
06) [common]
> 2023-01-13T04:29:21 end: 1.4.2.4.7 test-install-overlay (duration 00:00:0=
0) [common]
> 2023-01-13T04:29:21 {'case': 'test-install-overlay', 'definition': 'lava'=
, 'duration': '0.28', 'extra': {'from': 'git', 'name': 'ltp-smoketest', 'pa=
th': 'automated/linux/ltp/ltp.yaml', 'repository': 'https://github.com/Lina=
ro/test-definitions.git', 'skipped test-install-overlay': '6053089_1.4.2.4.=
5', 'uuid': '6053089_1.4.2.4.5'}, 'level': '1.4.2.4.7', 'namespace': 'commo=
n', 'result': 'pass'}
> 2023-01-13T04:29:21 start: 1.4.2.4.8 test-runscript-overlay (timeout 00:3=
9:06) [common]
> 2023-01-13T04:29:21 runner path: /var/lib/lava/dispatcher/tmp/6053089/lav=
a-overlay-n9cz5ml5/lava-6053089/1/tests/1_ltp-smoketest test_uuid 6053089_1=
=2E4.2.4.5
> 2023-01-13T04:29:21 BOARD=3D'x86'
> 2023-01-13T04:29:21 BRANCH=3D'default'
> 2023-01-13T04:29:21 ENVIRONMENT=3D'production'
> 2023-01-13T04:29:21 LTP_TMPDIR=3D'/scratch'
> 2023-01-13T04:29:21 SKIPFILE=3D'skipfile-lkft.yaml'
> 2023-01-13T04:29:21 SKIP_INSTALL=3D'true'
> 2023-01-13T04:29:21 TIMEOUT_MULTIPLIER=3D'10'
> 2023-01-13T04:29:21 TST_CMDFILES=3D'smoketest'
> 2023-01-13T04:29:21 end: 1.4.2.4.8 test-runscript-overlay (duration 00:00=
:00) [common]
> 2023-01-13T04:29:21 {'case': 'test-runscript-overlay', 'definition': 'lav=
a', 'duration': '0.11', 'extra': {'filename': '/var/lib/lava/dispatcher/tmp=
/6053089/lava-overlay-n9cz5ml5/lava-6053089/1/tests/1_ltp-smoketest/run.sh'=
, 'from': 'git', 'name': 'ltp-smoketest', 'path': 'automated/linux/ltp/ltp.=
yaml', 'repository': 'https://github.com/Linaro/test-definitions.git', 'uui=
d': '6053089_1.4.2.4.5'}, 'level': '1.4.2.4.8', 'namespace': 'common', 'res=
ult': 'pass'}
> 2023-01-13T04:29:21 Creating lava-test-runner.conf files
> 2023-01-13T04:29:21 Using lava-test-runner path: /var/lib/lava/dispatcher=
/tmp/6053089/lava-overlay-n9cz5ml5/lava-6053089/0 for stage 0
> 2023-01-13T04:29:21 - 0_prep-tmp-disk
> 2023-01-13T04:29:21 Using lava-test-runner path: /var/lib/lava/dispatcher=
/tmp/6053089/lava-overlay-n9cz5ml5/lava-6053089/1 for stage 1
> 2023-01-13T04:29:21 - 1_ltp-smoketest
> 2023-01-13T04:29:21 end: 1.4.2.4 test-definition (duration 00:00:13) [com=
mon]
> 2023-01-13T04:29:21 start: 1.4.2.5 compress-overlay (timeout 00:39:06) [c=
ommon]
> 2023-01-13T04:29:32 end: 1.4.2.5 compress-overlay (duration 00:00:11) [co=
mmon]
> 2023-01-13T04:29:32 start: 1.4.2.6 persistent-nfs-overlay (timeout 00:38:=
55) [common]
> 2023-01-13T04:29:32 end: 1.4.2.6 persistent-nfs-overlay (duration 00:00:0=
0) [common]
> 2023-01-13T04:29:32 end: 1.4.2 lava-overlay (duration 00:00:24) [common]
> 2023-01-13T04:29:32 start: 1.4.3 extract-overlay-ramdisk (timeout 00:38:5=
5) [common]
> 2023-01-13T04:29:32 end: 1.4.3 extract-overlay-ramdisk (duration 00:00:00=
) [common]
> 2023-01-13T04:29:32 start: 1.4.4 extract-modules (timeout 00:38:55) [comm=
on]
> 2023-01-13T04:29:32 extracting modules file /var/lib/lava/dispatcher/tmp/=
6053089/tftp-deploy-qytnh1b1/modules/modules.tar to /var/lib/lava/dispatche=
r/tmp/6053089/extract-nfsrootfs-bwf2gbp6
> 2023-01-13T04:29:32 end: 1.4.4 extract-modules (duration 00:00:00) [commo=
n]
> 2023-01-13T04:29:32 start: 1.4.5 apply-overlay-tftp (timeout 00:38:55) [c=
ommon]
> 2023-01-13T04:29:32 [common] Applying overlay to NFS
> 2023-01-13T04:29:32 [common] Applying overlay /var/lib/lava/dispatcher/tm=
p/6053089/compress-overlay-p0guf450/overlay-1.4.2.5.tar.gz to directory /va=
r/lib/lava/dispatcher/tmp/6053089/extract-nfsrootfs-bwf2gbp6
> 2023-01-13T04:29:33 end: 1.4.5 apply-overlay-tftp (duration 00:00:01) [co=
mmon]
> 2023-01-13T04:29:33 start: 1.4.6 configure-preseed-file (timeout 00:38:54=
) [common]
> 2023-01-13T04:29:33 end: 1.4.6 configure-preseed-file (duration 00:00:00)=
 [common]
> 2023-01-13T04:29:33 start: 1.4.7 compress-ramdisk (timeout 00:38:54) [com=
mon]
> 2023-01-13T04:29:33 end: 1.4.7 compress-ramdisk (duration 00:00:00) [comm=
on]
> 2023-01-13T04:29:33 end: 1.4 prepare-tftp-overlay (duration 00:00:36) [co=
mmon]
> 2023-01-13T04:29:33 start: 1.5 lxc-create-udev-rule-action (timeout 00:38=
:54) [common]
> 2023-01-13T04:29:33 No LXC device requested
> 2023-01-13T04:29:33 end: 1.5 lxc-create-udev-rule-action (duration 00:00:=
00) [common]
> 2023-01-13T04:29:33 start: 1.6 deploy-device-env (timeout 00:38:54) [comm=
on]
> 2023-01-13T04:29:33 end: 1.6 deploy-device-env (duration 00:00:00) [commo=
n]
> 2023-01-13T04:29:33 Checking files for TFTP limit of 4294967296 bytes.
> 2023-01-13T04:29:33 end: 1 tftp-deploy (duration 00:01:06) [common]
> 2023-01-13T04:29:33 start: 2 bootloader-action (timeout 00:15:00) [common]
> 2023-01-13T04:29:33 start: 2.1 bootloader-overlay (timeout 00:15:00) [com=
mon]
> 2023-01-13T04:29:33 substitutions:
> 2023-01-13T04:29:33 - {DTB}: None
> 2023-01-13T04:29:33 - {INITRD}: None
> 2023-01-13T04:29:33 - {KERNEL}: 6053089/tftp-deploy-qytnh1b1/kernel/bzIma=
ge
> 2023-01-13T04:29:33 - {LAVA_MAC}: 00:90:05:af:00:7d
> 2023-01-13T04:29:33 - {NFSROOTFS}: /var/lib/lava/dispatcher/tmp/6053089/e=
xtract-nfsrootfs-bwf2gbp6
> 2023-01-13T04:29:33 - {NFS_SERVER_IP}: 10.66.16.124
> 2023-01-13T04:29:33 - {PRESEED_CONFIG}: None
> 2023-01-13T04:29:33 - {PRESEED_LOCAL}: None
> 2023-01-13T04:29:33 - {RAMDISK}: None
> 2023-01-13T04:29:33 - {ROOT_PART}: None
> 2023-01-13T04:29:33 - {ROOT}: None
> 2023-01-13T04:29:33 - {SERVER_IP}: 10.66.16.124
> 2023-01-13T04:29:33 - {TEE}: None
> 2023-01-13T04:29:33 Parsed boot commands:
> 2023-01-13T04:29:33 - dhcp net0
> 2023-01-13T04:29:33 - set console console=3DttyS0,115200n8 lava_mac=3D00:=
90:05:af:00:7d
> 2023-01-13T04:29:33 - set extraargs root=3D/dev/nfs rw nfsroot=3D10.66.16=
=2E124:/var/lib/lava/dispatcher/tmp/6053089/extract-nfsrootfs-bwf2gbp6,tcp,=
hard,vers=3D3  ip=3Ddhcp
> 2023-01-13T04:29:33 - kernel tftp://10.66.16.124/6053089/tftp-deploy-qytn=
h1b1/kernel/bzImage ${extraargs} ${console}
> 2023-01-13T04:29:33 - boot
> 2023-01-13T04:29:33 end: 2.1 bootloader-overlay (duration 00:00:00) [comm=
on]
> 2023-01-13T04:29:33 start: 2.2 connect-device (timeout 00:15:00) [common]
> 2023-01-13T04:29:33 [common] connect-device Connecting to device using 't=
elnet serial-box02 7016'
> 2023-01-13T04:29:33 Setting prompt string to ['lava-test: # ']
> 2023-01-13T04:29:33 end: 2.2 connect-device (duration 00:00:00) [common]
> 2023-01-13T04:29:33 start: 2.3 bootloader-retry (timeout 00:15:00) [commo=
n]
> 2023-01-13T04:29:33 start: 2.3.1 reset-device (timeout 00:15:00) [common]
> 2023-01-13T04:29:33 start: 2.3.1.1 pdu-reboot (timeout 00:15:00) [common]
> 2023-01-13T04:29:33 Calling: 'nice' 'ipmitool' '-U' 'ADMIN' '-P' 'ADMIN' =
'-I' 'lanplus' '-H' '10.66.16.51' 'chassis' 'power' 'off'
> 2023-01-13T04:29:33 >> Chassis Power Control: Down/Off
> 2023-01-13T04:29:33 Returned 0 in 0 seconds
> 2023-01-13T04:29:33 Calling: 'nice' 'sleep' '5'
> 2023-01-13T04:29:38 Returned 0 in 5 seconds
> 2023-01-13T04:29:38 Calling: 'nice' 'ipmitool' '-U' 'ADMIN' '-P' 'ADMIN' =
'-I' 'lanplus' '-H' '10.66.16.51' 'chassis' 'power' 'on'
> 2023-01-13T04:29:38 >> Chassis Power Control: Up/On
> 2023-01-13T04:29:38 Returned 0 in 0 seconds
> 2023-01-13T04:29:38 end: 2.3.1.1 pdu-reboot (duration 00:00:05) [common]
> 2023-01-13T04:29:38 {'case': 'pdu-reboot', 'definition': 'lava', 'duratio=
n': '5.37', 'extra': {'status': 'success'}, 'level': '2.3.1.1', 'namespace'=
: 'common', 'result': 'pass'}
> 2023-01-13T04:29:38 end: 2.3.1 reset-device (duration 00:00:05) [common]
> 2023-01-13T04:29:38 start: 2.3.2 bootloader-interrupt (timeout 00:14:55) =
[common]
> 2023-01-13T04:29:38 Setting prompt string to ['Press Ctrl-B for the iPXE =
command line']
> 2023-01-13T04:29:38 bootloader-interrupt: Wait for prompt ['Press Ctrl-B =
for the iPXE command line'] (timeout 00:15:00)
> 2023-01-13T04:29:38 Trying 10.66.16.132...
> 2023-01-13T04:29:38 Connected to serial-box02.lkftlab.
> 2023-01-13T04:29:38 Escape character is '^]'.
> 2023-01-13T04:29:38=20
> 2023-01-13T04:29:38 lkft x86 01 7016 [115200 N81]
> 2023-01-13T04:29:38=20
> 2023-01-13T04:30:28 iPXE initialising devices...ok
> 2023-01-13T04:30:28 [0m
> 2023-01-13T04:30:28=20
> 2023-01-13T04:30:28=20
> 2023-01-13T04:30:28 [1miPXE 1.20.1+ (ge3ca)[0m -- Open Source Network Boo=
t Firmware -- [36mhttp://ipxe.org[0m
> 2023-01-13T04:30:28 Features: DNS HTTP iSCSI TFTP SRP AoE ELF MBOOT PXE b=
zImage Menu PXEXT
> 2023-01-13T04:30:28=20
> 2023-01-13T04:30:28 b
> 2023-01-13T04:30:28 end: 2.3.2 bootloader-interrupt (duration 00:00:50) [=
common]
> 2023-01-13T04:30:28 start: 2.3.3 bootloader-commands (timeout 00:14:05) [=
common]
> 2023-01-13T04:30:28 Setting prompt string to ['iPXE>']
> 2023-01-13T04:30:28 bootloader-commands: Wait for prompt ['iPXE>'] (timeo=
ut 00:14:05)
> 2023-01-13T04:30:28 Setting prompt string to ['iPXE>', 'No configuration =
methods succeeded', 'Connection timed out']
> 2023-01-13T04:30:28 Sending with 1 millisecond of delay
> 2023-01-13T04:30:28 dhcp net0
> 2023-01-13T04:30:29 Press Ctrl-B for the iPXE command line...=02=08 =08=
=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =
=08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=
=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =
=08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08iPXE> dhcp net0
> 2023-01-13T04:30:29 bootloader-commands: Wait for prompt ['iPXE>', 'No co=
nfiguration methods succeeded', 'Connection timed out'] (timeout 00:14:04)
> 2023-01-13T04:30:29 [?25hdhcp net0
> 2023-01-13T04:30:32 Configuring (net0 ac:1f:6b:1a:b3:4e)...... ok
> 2023-01-13T04:30:32 Sending with 1 millisecond of delay
> 2023-01-13T04:30:32 set console console=3DttyS0,115200n8 lava_mac=3D00:90=
:05:af:00:7d
> 2023-01-13T04:30:35 iPXE> [?25hset console console=3DttyS0,115200n8 lava_=
mac=3D00:90:05:af:00:7d
> 2023-01-13T04:30:35 bootloader-commands: Wait for prompt ['iPXE>', 'No co=
nfiguration methods succeeded', 'Connection timed out'] (timeout 00:13:58)
> 2023-01-13T04:30:35 set console console=3DttyS0,115200n8 lava_mac=3D00:90=
:05:af:00:7d
> 2023-01-13T04:30:35 Sending with 1 millisecond of delay
> 2023-01-13T04:30:35 set extraargs root=3D/dev/nfs rw nfsroot=3D10.66.16.1=
24:/var/lib/lava/dispatcher/tmp/6053089/extract-nfsrootfs-bwf2gbp6,tcp,hard=
,vers=3D3  ip=3Ddhcp
> 2023-01-13T04:30:42 iPXE> [?25hset extraargs root=3D/dev/nfs rw nfsroot=
=3D10.66.16.124:/var/lib/lava/dispatcher/tmp/6053089/extract-nfsrootfs-bwf2=
gbp6,tcp,hard,vers=3D3  ip=3Ddhcp
> 2023-01-13T04:30:42 bootloader-commands: Wait for prompt ['iPXE>', 'No co=
nfiguration methods succeeded', 'Connection timed out'] (timeout 00:13:50)
> 2023-01-13T04:30:42 set extraargs root=3D/dev/nfs rw nfsroot=3D10.66.16.1=
24:/var/lib/lava/dispatcher/tmp/6053089/extract-nfsrootfs-bwf2gbp6,tcp,hard=
,vers=3D3  ip=3Ddhcp
> 2023-01-13T04:30:42 Sending with 1 millisecond of delay
> 2023-01-13T04:30:42 kernel tftp://10.66.16.124/6053089/tftp-deploy-qytnh1=
b1/kernel/bzImage ${extraargs} ${console}
> 2023-01-13T04:30:47 iPXE> [?25hkernel tftp://10.66.16.124/6053089/tftp-de=
ploy-qytnh1b1/kernel/bzImage ${extraargs} ${console}
> 2023-01-13T04:30:47 bootloader-commands: Wait for prompt ['iPXE>', 'No co=
nfiguration methods succeeded', 'Connection timed out'] (timeout 00:13:45)
> 2023-01-13T04:30:47 kernel tftp://10.66.16.124/6053089/tftp-deploy-qytnh1=
b1/kernel/bzImage ${extraargs} ${console}
> 2023-01-13T04:30:51 tftp://10.66.16.124/6053089/tftp-deploy-qytnh1b1/kern=
el/bzImage... 24%=08=08=08=08    =08=08=08=08 51%=08=08=08=08    =08=08=08=
=08 78%=08=08=08=08    =08=08=08=08 ok
> 2023-01-13T04:30:51 Sending with 1 millisecond of delay
> 2023-01-13T04:30:51 boot
> 2023-01-13T04:30:52 iPXE> [?25hboot
> 2023-01-13T04:30:52 end: 2.3.3 bootloader-commands (duration 00:00:23) [c=
ommon]
> 2023-01-13T04:30:52 start: 2.3.4 auto-login-action (timeout 00:13:41) [co=
mmon]
> 2023-01-13T04:30:52 Setting prompt string to ['Linux version [0-9]']
> 2023-01-13T04:30:52 Setting prompt string to ['Linux version [0-9]', 'No =
configuration methods succeeded', 'Connection timed out']
> 2023-01-13T04:30:52 auto-login-action: Wait for prompt ['Linux version [0=
-9]', 'No configuration methods succeeded', 'Connection timed out'] (timeou=
t 00:15:00)
> 2023-01-13T04:30:52 boot
> 2023-01-13T04:30:52 start: 2.3.4.1 login-action (timeout 00:13:40) [commo=
n]
> 2023-01-13T04:30:52 Setting prompt string to ['-\\[ cut here \\]', 'Unhan=
dled fault', 'BUG: KCSAN:', 'BUG: KASAN:', 'BUG: KFENCE:', 'Oops(?: -|:)', =
'WARNING:', '(kernel BUG at|BUG:)', 'invalid opcode:', 'Kernel panic - not =
syncing']
> 2023-01-13T04:30:52 Using line separator: #'\n'#
> 2023-01-13T04:30:52 Waiting for the login prompt
> 2023-01-13T04:30:52 Parsing kernel messages
> 2023-01-13T04:30:52 ['-\\[ cut here \\]', 'Unhandled fault', 'BUG: KCSAN:=
', 'BUG: KASAN:', 'BUG: KFENCE:', 'Oops(?: -|:)', 'WARNING:', '(kernel BUG =
at|BUG:)', 'invalid opcode:', 'Kernel panic - not syncing', 'root@intel-cor=
ei7-64:', 'root@(.*):[/~]#', 'login:', 'Login incorrect']
> 2023-01-13T04:30:52 [login-action] Waiting for messages, (timeout 00:13:4=
0)
> 2023-01-13T04:30:52 [    0.000000] Linux version 6.2.0-rc3-next-20230113 =
(tuxmake@tuxmake) (x86_64-linux-gnu-gcc (Debian 11.3.0-8) 11.3.0, GNU ld (G=
NU Binutils for Debian) 2.39) #1 SMP PREEMPT_DYNAMIC @1673583678
> 2023-01-13T04:30:52 [    0.000000] Command line: root=3D/dev/nfs rw nfsro=
ot=3D10.66.16.124:/var/lib/lava/dispatcher/tmp/6053089/extract-nfsrootfs-bw=
f2gbp6,tcp,hard,vers=3D3 ip=3Ddhcp console=3DttyS0,115200n8 lava_mac=3D00:9=
0:05:af:00:7d
> 2023-01-13T04:30:52 [    0.000000] x86/fpu: Supporting XSAVE feature 0x00=
1: 'x87 floating point registers'
> 2023-01-13T04:30:52 [    0.000000] x86/fpu: Supporting XSAVE feature 0x00=
2: 'SSE registers'
> 2023-01-13T04:30:52 [    0.000000] x86/fpu: Supporting XSAVE feature 0x00=
4: 'AVX registers'
> 2023-01-13T04:30:52 [    0.000000] x86/fpu: Supporting XSAVE feature 0x00=
8: 'MPX bounds registers'
> 2023-01-13T04:30:52 [    0.000000] x86/fpu: Supporting XSAVE feature 0x01=
0: 'MPX CSR'
> 2023-01-13T04:30:52 [    0.000000] x86/fpu: xstate_offset[2]:  576, xstat=
e_sizes[2]:  256
> 2023-01-13T04:30:52 [    0.000000] x86/fpu: xstate_offset[3]:  832, xstat=
e_sizes[3]:   64
> 2023-01-13T04:30:52 [    0.000000] x86/fpu: xstate_offset[4]:  896, xstat=
e_sizes[4]:   64
> 2023-01-13T04:30:52 [    0.000000] x86/fpu: Enabled xstate features 0x1f,=
 context size is 960 bytes, using 'compacted' format.
> 2023-01-13T04:30:52 [    0.000000] signal: max sigframe size: 2032
> 2023-01-13T04:30:52 [    0.000000] BIOS-provided physical RAM map:
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0=
000000000098bff] usable
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x0000000000098c00-0x0=
00000000009ffff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x0=
0000000000fffff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0=
000000088766fff] usable
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x0000000088767000-0x0=
000000088767fff] ACPI NVS
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x0000000088768000-0x0=
000000088791fff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x0000000088792000-0x0=
00000008cba0fff] usable
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x000000008cba1000-0x0=
00000008cf2efff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x000000008cf2f000-0x0=
00000008d11efff] usable
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x000000008d11f000-0x0=
00000008d891fff] ACPI NVS
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x000000008d892000-0x0=
00000008fafefff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x000000008faff000-0x0=
00000008fafffff] usable
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x0=
0000000efffffff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x0=
0000000fe010fff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x0=
0000000fec00fff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x0=
0000000fee00fff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x0=
0000000ffffffff] reserved
> 2023-01-13T04:30:52 [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0=
00000046fffffff] usable
> 2023-01-13T04:30:52 [    0.000000] NX (Execute Disable) protection: active
> 2023-01-13T04:30:52 [    0.000000] SMBIOS 3.0 present.
> 2023-01-13T04:30:52 [    0.000000] DMI: Supermicro SYS-5019S-ML/X11SSH-F,=
 BIOS 2.0b 07/27/2017
> 2023-01-13T04:30:52 [    0.000000] tsc: Detected 3000.000 MHz processor
> 2023-01-13T04:30:52 [    0.000426] last_pfn =3D 0x470000 max_arch_pfn =3D=
 0x400000000
> 2023-01-13T04:30:52 [    0.000429] x86/PAT: Configuration [0-7]: WB  WC  =
UC- UC  WB  WP  UC- WT =20
> 2023-01-13T04:30:52 [    0.000658] last_pfn =3D 0x8fb00 max_arch_pfn =3D =
0x400000000
> 2023-01-13T04:30:52 [    0.007494] found SMP MP-table at [mem 0x000fcc10-=
0x000fcc1f]
> 2023-01-13T04:30:52 [    0.007503] Using GB pages for direct mapping
> 2023-01-13T04:30:52 [    0.007872] ACPI: Early table checksum verificatio=
n disabled
> 2023-01-13T04:30:52 [    0.007875] ACPI: RSDP 0x00000000000F05B0 000024 (=
v02 SUPERM)
> 2023-01-13T04:30:52 [    0.007878] ACPI: XSDT 0x000000008D8250B0 0000E4 (=
v01 SUPERM SUPERM   01072009 AMI  00010013)
> 2023-01-13T04:30:53 [    0.007883] ACPI: FACP 0x000000008D8479A0 00010C (=
v05                 01072009 AMI  00010013)
> 2023-01-13T04:30:53 [    0.007888] ACPI: DSDT 0x000000008D825230 022770 (=
v02 SUPERM SMCI--MB 01072009 INTL 20120913)
> 2023-01-13T04:30:53 [    0.007891] ACPI: FACS 0x000000008D890F80 000040
> 2023-01-13T04:30:53 [    0.007893] ACPI: APIC 0x000000008D847AB0 000084 (=
v03                 01072009 AMI  00010013)
> 2023-01-13T04:30:53 [    0.007896] ACPI: FPDT 0x000000008D847B38 000044 (=
v01                 01072009 AMI  00010013)
> 2023-01-13T04:30:53 [    0.007898] ACPI: FIDT 0x000000008D847B80 00009C (=
v01                 01072009 AMI  00010013)
> 2023-01-13T04:30:53 [    0.007901] ACPI: SPMI 0x000000008D847C20 000041 (=
v05 SUPERM SMCI--MB 00000000 AMI. 00000000)
> 2023-01-13T04:30:53 [    0.007904] ACPI: MCFG 0x000000008D847C68 00003C (=
v01 SUPERM SMCI--MB 01072009 MSFT 00000097)
> 2023-01-13T04:30:53 [    0.007906] ACPI: HPET 0x000000008D847CA8 000038 (=
v01 SUPERM SMCI--MB 01072009 AMI. 0005000B)
> 2023-01-13T04:30:53 [    0.007909] ACPI: LPIT 0x000000008D847CE0 000094 (=
v01 INTEL  GNLR     00000000 MSFT 0000005F)
> 2023-01-13T04:30:53 [    0.007911] ACPI: SSDT 0x000000008D847D78 000248 (=
v02 INTEL  sensrhub 00000000 INTL 20120913)
> 2023-01-13T04:30:53 [    0.007914] ACPI: SSDT 0x000000008D847FC0 002BAE (=
v02 INTEL  PtidDevc 00001000 INTL 20120913)
> 2023-01-13T04:30:53 [    0.007917] ACPI: SSDT 0x000000008D84AB70 000BE3 (=
v02 INTEL  Ther_Rvp 00001000 INTL 20120913)
> 2023-01-13T04:30:53 [    0.007920] ACPI: DBGP 0x000000008D84B758 000034 (=
v01 INTEL           00000000 MSFT 0000005F)
> 2023-01-13T04:30:53 [    0.007922] ACPI: DBG2 0x000000008D84B790 000054 (=
v00 INTEL           00000000 MSFT 0000005F)
> 2023-01-13T04:30:53 [    0.007925] ACPI: SSDT 0x000000008D84B7E8 000615 (=
v02 INTEL  xh_Zumba 00000000 INTL 20120913)
> 2023-01-13T04:30:53 [    0.007927] ACPI: PRAD 0x000000008D84BE00 0000CA (=
v02 PRADID PRADTID  00000001 INTL 20120913)
> 2023-01-13T04:30:53 [    0.007930] ACPI: SSDT 0x000000008D84BED0 00547E (=
v02 SaSsdt SaSsdt   00003000 INTL 20120913)
> 2023-01-13T04:30:53 [    0.007933] ACPI: UEFI 0x000000008D851350 000042 (=
v01                 00000000      00000000)
> 2023-01-13T04:30:53 [    0.007935] ACPI: SSDT 0x000000008D851398 000E73 (=
v02 CpuRef CpuSsdt  00003000 INTL 20120913)
> 2023-01-13T04:30:53 [    0.007938] ACPI: DMAR 0x000000008D852210 000070 (=
v01 INTEL  SKL      00000001 INTL 00000001)
> 2023-01-13T04:30:53 [    0.007941] ACPI: SPCR 0x000000008D852280 000050 (=
v01 A M I  APTIO V  01072009 AMI. 0005000B)
> 2023-01-13T04:30:53 [    0.007943] ACPI: EINJ 0x000000008D8522D0 000130 (=
v01 AMI    AMI.EINJ 00000000 AMI. 00000000)
> 2023-01-13T04:30:53 [    0.007946] ACPI: ERST 0x000000008D852400 000230 (=
v01 AMIER  AMI.ERST 00000000 AMI. 00000000)
> 2023-01-13T04:30:53 [    0.007949] ACPI: BERT 0x000000008D852630 000030 (=
v01 AMI    AMI.BERT 00000000 AMI. 00000000)
> 2023-01-13T04:30:53 [    0.007951] ACPI: HEST 0x000000008D852660 00027C (=
v01 AMI    AMI.HEST 00000000 AMI. 00000000)
> 2023-01-13T04:30:53 [    0.007954] ACPI: Reserving FACP table memory at [=
mem 0x8d8479a0-0x8d847aab]
> 2023-01-13T04:30:53 [    0.007955] ACPI: Reserving DSDT table memory at [=
mem 0x8d825230-0x8d84799f]
> 2023-01-13T04:30:53 [    0.007956] ACPI: Reserving FACS table memory at [=
mem 0x8d890f80-0x8d890fbf]
> 2023-01-13T04:30:53 [    0.007957] ACPI: Reserving APIC table memory at [=
mem 0x8d847ab0-0x8d847b33]
> 2023-01-13T04:30:53 [    0.007957] ACPI: Reserving FPDT table memory at [=
mem 0x8d847b38-0x8d847b7b]
> 2023-01-13T04:30:53 [    0.007958] ACPI: Reserving FIDT table memory at [=
mem 0x8d847b80-0x8d847c1b]
> 2023-01-13T04:30:53 [    0.007959] ACPI: Reserving SPMI table memory at [=
mem 0x8d847c20-0x8d847c60]
> 2023-01-13T04:30:53 [    0.007960] ACPI: Reserving MCFG table memory at [=
mem 0x8d847c68-0x8d847ca3]
> 2023-01-13T04:30:53 [    0.007960] ACPI: Reserving HPET table memory at [=
mem 0x8d847ca8-0x8d847cdf]
> 2023-01-13T04:30:53 [    0.007961] ACPI: Reserving LPIT table memory at [=
mem 0x8d847ce0-0x8d847d73]
> 2023-01-13T04:30:53 [    0.007962] ACPI: Reserving SSDT table memory at [=
mem 0x8d847d78-0x8d847fbf]
> 2023-01-13T04:30:53 [    0.007962] ACPI: Reserving SSDT table memory at [=
mem 0x8d847fc0-0x8d84ab6d]
> 2023-01-13T04:30:53 [    0.007963] ACPI: Reserving SSDT table memory at [=
mem 0x8d84ab70-0x8d84b752]
> 2023-01-13T04:30:53 [    0.007964] ACPI: Reserving DBGP table memory at [=
mem 0x8d84b758-0x8d84b78b]
> 2023-01-13T04:30:53 [    0.007965] ACPI: Reserving DBG2 table memory at [=
mem 0x8d84b790-0x8d84b7e3]
> 2023-01-13T04:30:53 [    0.007965] ACPI: Reserving SSDT table memory at [=
mem 0x8d84b7e8-0x8d84bdfc]
> 2023-01-13T04:30:53 [    0.007966] ACPI: Reserving PRAD table memory at [=
mem 0x8d84be00-0x8d84bec9]
> 2023-01-13T04:30:53 [    0.007967] ACPI: Reserving SSDT table memory at [=
mem 0x8d84bed0-0x8d85134d]
> 2023-01-13T04:30:53 [    0.007968] ACPI: Reserving UEFI table memory at [=
mem 0x8d851350-0x8d851391]
> 2023-01-13T04:30:53 [    0.007968] ACPI: Reserving SSDT table memory at [=
mem 0x8d851398-0x8d85220a]
> 2023-01-13T04:30:53 [    0.007969] ACPI: Reserving DMAR table memory at [=
mem 0x8d852210-0x8d85227f]
> 2023-01-13T04:30:53 [    0.007970] ACPI: Reserving SPCR table memory at [=
mem 0x8d852280-0x8d8522cf]
> 2023-01-13T04:30:53 [    0.007971] ACPI: Reserving EINJ table memory at [=
mem 0x8d8522d0-0x8d8523ff]
> 2023-01-13T04:30:53 [    0.007971] ACPI: Reserving ERST table memory at [=
mem 0x8d852400-0x8d85262f]
> 2023-01-13T04:30:53 [    0.007972] ACPI: Reserving BERT table memory at [=
mem 0x8d852630-0x8d85265f]
> 2023-01-13T04:30:53 [    0.007973] ACPI: Reserving HEST table memory at [=
mem 0x8d852660-0x8d8528db]
> 2023-01-13T04:30:53 [    0.008089] No NUMA configuration found
> 2023-01-13T04:30:53 [    0.008089] Faking a node at [mem 0x00000000000000=
00-0x000000046fffffff]
> 2023-01-13T04:30:53 [    0.008092] NODE_DATA(0) allocated [mem 0x46fffc00=
0-0x46fffffff]
> 2023-01-13T04:30:53 [    0.008116] Zone ranges:
> 2023-01-13T04:30:53 [    0.008117]   DMA      [mem 0x0000000000001000-0x0=
000000000ffffff]
> 2023-01-13T04:30:53 [    0.008118]   DMA32    [mem 0x0000000001000000-0x0=
0000000ffffffff]
> 2023-01-13T04:30:53 [    0.008120]   Normal   [mem 0x0000000100000000-0x0=
00000046fffffff]
> 2023-01-13T04:30:53 [    0.008121] Movable zone start for each node
> 2023-01-13T04:30:53 [    0.008122] Early memory node ranges
> 2023-01-13T04:30:53 [    0.008123]   node   0: [mem 0x0000000000001000-0x=
0000000000097fff]
> 2023-01-13T04:30:53 [    0.008124]   node   0: [mem 0x0000000000100000-0x=
0000000088766fff]
> 2023-01-13T04:30:53 [    0.008125]   node   0: [mem 0x0000000088792000-0x=
000000008cba0fff]
> 2023-01-13T04:30:53 [    0.008126]   node   0: [mem 0x000000008cf2f000-0x=
000000008d11efff]
> 2023-01-13T04:30:53 [    0.008126]   node   0: [mem 0x000000008faff000-0x=
000000008fafffff]
> 2023-01-13T04:30:53 [    0.008127]   node   0: [mem 0x0000000100000000-0x=
000000046fffffff]
> 2023-01-13T04:30:53 [    0.008129] Initmem setup node 0 [mem 0x0000000000=
001000-0x000000046fffffff]
> 2023-01-13T04:30:53 [    0.008132] On node 0, zone DMA: 1 pages in unavai=
lable ranges
> 2023-01-13T04:30:53 [    0.008152] On node 0, zone DMA: 104 pages in unav=
ailable ranges
> 2023-01-13T04:30:53 [    0.010807] On node 0, zone DMA32: 43 pages in una=
vailable ranges
> 2023-01-13T04:30:53 [    0.010819] On node 0, zone DMA32: 910 pages in un=
available ranges
> 2023-01-13T04:30:53 [    0.010899] On node 0, zone DMA32: 10720 pages in =
unavailable ranges
> 2023-01-13T04:30:53 [    0.027654] On node 0, zone Normal: 1280 pages in =
unavailable ranges
> 2023-01-13T04:30:53 [    0.027860] ACPI: PM-Timer IO Port: 0x1808
> 2023-01-13T04:30:53 [    0.027865] ACPI: LAPIC_NMI (acpi_id[0x01] high ed=
ge lint[0x1])
> 2023-01-13T04:30:53 [    0.027866] ACPI: LAPIC_NMI (acpi_id[0x02] high ed=
ge lint[0x1])
> 2023-01-13T04:30:53 [    0.027867] ACPI: LAPIC_NMI (acpi_id[0x03] high ed=
ge lint[0x1])
> 2023-01-13T04:30:53 [    0.027868] ACPI: LAPIC_NMI (acpi_id[0x04] high ed=
ge lint[0x1])
> 2023-01-13T04:30:53 [    0.027904] IOAPIC[0]: apic_id 2, version 32, addr=
ess 0xfec00000, GSI 0-23
> 2023-01-13T04:30:53 [    0.027906] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 glo=
bal_irq 2 dfl dfl)
> 2023-01-13T04:30:53 [    0.027908] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 glo=
bal_irq 9 high level)
> 2023-01-13T04:30:53 [    0.027912] ACPI: Using ACPI (MADT) for SMP config=
uration information
> 2023-01-13T04:30:53 [    0.027913] ACPI: HPET id: 0x8086a701 base: 0xfed0=
0000
> 2023-01-13T04:30:53 [    0.027915] ACPI: SPCR: SPCR table version 1
> 2023-01-13T04:30:53 [    0.027916] ACPI: SPCR: console: uart,io,0x3f8,115=
200
> 2023-01-13T04:30:53 [    0.027918] TSC deadline timer available
> 2023-01-13T04:30:53 [    0.027918] smpboot: Allowing 4 CPUs, 0 hotplug CP=
Us
> 2023-01-13T04:30:53 [    0.027931] PM: hibernation: Registered nosave mem=
ory: [mem 0x00000000-0x00000fff]
> 2023-01-13T04:30:53 [    0.027933] PM: hibernation: Registered nosave mem=
ory: [mem 0x00098000-0x00098fff]
> 2023-01-13T04:30:53 [    0.027934] PM: hibernation: Registered nosave mem=
ory: [mem 0x00099000-0x0009ffff]
> 2023-01-13T04:30:53 [    0.027935] PM: hibernation: Registered nosave mem=
ory: [mem 0x000a0000-0x000dffff]
> 2023-01-13T04:30:53 [    0.027935] PM: hibernation: Registered nosave mem=
ory: [mem 0x000e0000-0x000fffff]
> 2023-01-13T04:30:53 [    0.027937] PM: hibernation: Registered nosave mem=
ory: [mem 0x88767000-0x88767fff]
> 2023-01-13T04:30:53 [    0.027937] PM: hibernation: Registered nosave mem=
ory: [mem 0x88768000-0x88791fff]
> 2023-01-13T04:30:53 [    0.027939] PM: hibernation: Registered nosave mem=
ory: [mem 0x8cba1000-0x8cf2efff]
> 2023-01-13T04:30:53 [    0.027940] PM: hibernation: Registered nosave mem=
ory: [mem 0x8d11f000-0x8d891fff]
> 2023-01-13T04:30:53 [    0.027941] PM: hibernation: Registered nosave mem=
ory: [mem 0x8d892000-0x8fafefff]
> 2023-01-13T04:30:53 [    0.027942] PM: hibernation: Registered nosave mem=
ory: [mem 0x8fb00000-0xdfffffff]
> 2023-01-13T04:30:53 [    0.027942] PM: hibernation: Registered nosave mem=
ory: [mem 0xe0000000-0xefffffff]
> 2023-01-13T04:30:53 [    0.027943] PM: hibernation: Registered nosave mem=
ory: [mem 0xf0000000-0xfdffffff]
> 2023-01-13T04:30:53 [    0.027944] PM: hibernation: Registered nosave mem=
ory: [mem 0xfe000000-0xfe010fff]
> 2023-01-13T04:30:53 [    0.027944] PM: hibernation: Registered nosave mem=
ory: [mem 0xfe011000-0xfebfffff]
> 2023-01-13T04:30:53 [    0.027945] PM: hibernation: Registered nosave mem=
ory: [mem 0xfec00000-0xfec00fff]
> 2023-01-13T04:30:53 [    0.027946] PM: hibernation: Registered nosave mem=
ory: [mem 0xfec01000-0xfedfffff]
> 2023-01-13T04:30:53 [    0.027946] PM: hibernation: Registered nosave mem=
ory: [mem 0xfee00000-0xfee00fff]
> 2023-01-13T04:30:53 [    0.027947] PM: hibernation: Registered nosave mem=
ory: [mem 0xfee01000-0xfeffffff]
> 2023-01-13T04:30:53 [    0.027947] PM: hibernation: Registered nosave mem=
ory: [mem 0xff000000-0xffffffff]
> 2023-01-13T04:30:53 [    0.027949] [mem 0x8fb00000-0xdfffffff] available =
for PCI devices
> 2023-01-13T04:30:53 [    0.027950] Booting paravirtualized kernel on bare=
 hardware
> 2023-01-13T04:30:53 [    0.027952] clocksource: refined-jiffies: mask: 0x=
ffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> 2023-01-13T04:30:53 [    0.027956] setup_percpu: NR_CPUS:64 nr_cpumask_bi=
ts:4 nr_cpu_ids:4 nr_node_ids:1
> 2023-01-13T04:30:53 [    0.028070] percpu: Embedded 54 pages/cpu s183912 =
r8192 d29080 u524288
> 2023-01-13T04:30:53 [    0.028093] Fallback order for Node 0: 0=20
> 2023-01-13T04:30:53 [    0.028096] Built 1 zonelists, mobility grouping o=
n.  Total pages: 4115761
> 2023-01-13T04:30:53 [    0.028097] Policy zone: Normal
> 2023-01-13T04:30:53 [    0.028098] Kernel command line: root=3D/dev/nfs r=
w nfsroot=3D10.66.16.124:/var/lib/lava/dispatcher/tmp/6053089/extract-nfsro=
otfs-bwf2gbp6,tcp,hard,vers=3D3 ip=3Ddhcp console=3DttyS0,115200n8 lava_mac=
=3D00:90:05:af:00:7d
> 2023-01-13T04:30:53 [    0.028142] Unknown kernel command line parameters=
 \"lava_mac=3D00:90:05:af:00:7d\", will be passed to user space.
> 2023-01-13T04:30:53 [    0.028159] random: crng init done
> 2023-01-13T04:30:53 [    0.028837] Dentry cache hash table entries: 20971=
52 (order: 12, 16777216 bytes, linear)
> 2023-01-13T04:30:53 [    0.029167] Inode-cache hash table entries: 104857=
6 (order: 11, 8388608 bytes, linear)
> 2023-01-13T04:30:53 [    0.029302] mem auto-init: stack:off, heap alloc:o=
ff, heap free:off
> 2023-01-13T04:30:53 [    0.029310] software IO TLB: area num 4.
> 2023-01-13T04:30:53 [    0.062285] Memory: 16329104K/16724984K available =
(22528K kernel code, 3246K rwdata, 8020K rodata, 3624K init, 1116K bss, 395=
620K reserved, 0K cma-reserved)
> 2023-01-13T04:30:53 [    0.062327] SLUB: HWalign=3D64, Order=3D0-3, MinOb=
jects=3D0, CPUs=3D4, Nodes=3D1
> 2023-01-13T04:30:53 [    0.062334] Kernel/User page tables isolation: ena=
bled
> 2023-01-13T04:30:53 [    0.062355] ftrace: allocating 57338 entries in 22=
4 pages
> 2023-01-13T04:30:53 [    0.071374] ftrace: allocated 224 pages with 3 gro=
ups
> 2023-01-13T04:30:53 [    0.072400] Dynamic Preempt: voluntary
> 2023-01-13T04:30:53 [    0.072422] rcu: Preemptible hierarchical RCU impl=
ementation.
> 2023-01-13T04:30:53 [    0.072422] rcu: 	RCU event tracing is enabled.
> 2023-01-13T04:30:53 [    0.072423] rcu: 	RCU restricting CPUs from NR_CPU=
S=3D64 to nr_cpu_ids=3D4.
> 2023-01-13T04:30:53 [    0.072424] 	Trampoline variant of Tasks RCU enabl=
ed.
> 2023-01-13T04:30:53 [    0.072424] 	Rude variant of Tasks RCU enabled.
> 2023-01-13T04:30:53 [    0.072425] rcu: RCU calculated value of scheduler=
-enlistment delay is 100 jiffies.
> 2023-01-13T04:30:53 [    0.072426] rcu: Adjusting geometry for rcu_fanout=
_leaf=3D16, nr_cpu_ids=3D4
> 2023-01-13T04:30:53 [    0.073833] NR_IRQS: 4352, nr_irqs: 456, prealloca=
ted irqs: 16
> 2023-01-13T04:30:53 [    0.074043] rcu: srcu_init: Setting srcu_struct si=
zes based on contention.
> 2023-01-13T04:30:53 [    0.074251] kfence: initialized - using 2097152 by=
tes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
> 2023-01-13T04:30:53 [    0.076620] Console: colour VGA+ 80x25
> 2023-01-13T04:30:53 [    0.076641] printk: console [ttyS0] enabled
> 2023-01-13T04:30:53 [    1.346444] ACPI: Core revision 20221020
> 2023-01-13T04:30:53 [    1.350613] clocksource: hpet: mask: 0xffffffff ma=
x_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> 2023-01-13T04:30:53 [    1.359749] APIC: Switch to symmetric I/O mode set=
up
> 2023-01-13T04:30:54 [    1.365553] ..TIMER: vector=3D0x30 apic1=3D0 pin1=
=3D2 apic2=3D0 pin2=3D0
> 2023-01-13T04:30:54 [    1.375697] clocksource: tsc-early: mask: 0xffffff=
ffffffffff max_cycles: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
> 2023-01-13T04:30:54 [    1.386215] Calibrating delay loop (skipped), valu=
e calculated using timer frequency.. 6000.00 BogoMIPS (lpj=3D3000000)
> 2023-01-13T04:30:54 [    1.387214] pid_max: default: 32768 minimum: 301
> 2023-01-13T04:30:54 [    1.388228] LSM: initializing lsm=3Dcapability,int=
egrity,selinux
> 2023-01-13T04:30:54 [    1.389217] SELinux:  Initializing.
> 2023-01-13T04:30:54 [    1.390252] Mount-cache hash table entries: 32768 =
(order: 6, 262144 bytes, linear)
> 2023-01-13T04:30:54 [    1.391234] Mountpoint-cache hash table entries: 3=
2768 (order: 6, 262144 bytes, linear)
> 2023-01-13T04:30:54 [    1.392379] CPU0: Thermal monitoring enabled (TM1)
> 2023-01-13T04:30:54 [    1.393241] process: using mwait in idle threads
> 2023-01-13T04:30:54 [    1.394215] Last level iTLB entries: 4KB 128, 2MB =
8, 4MB 8
> 2023-01-13T04:30:54 [    1.395214] Last level dTLB entries: 4KB 64, 2MB 0=
, 4MB 0, 1GB 4
> 2023-01-13T04:30:54 [    1.396216] Spectre V1 : Mitigation: usercopy/swap=
gs barriers and __user pointer sanitization
> 2023-01-13T04:30:54 [    1.397214] Spectre V2 : Mitigation: Retpolines
> 2023-01-13T04:30:54 [    1.398214] Spectre V2 : Spectre v2 / SpectreRSB m=
itigation: Filling RSB on context switch
> 2023-01-13T04:30:54 [    1.399214] Spectre V2 : Spectre v2 / SpectreRSB :=
 Filling RSB on VMEXIT
> 2023-01-13T04:30:54 Matched prompt #6: WARNING:
> 2023-01-13T04:30:54 Setting prompt string to ['end trace[^\\r]*\\r\\n', '=
root@intel-corei7-64:', 'root@(.*):[/~]#', 'login:', 'Login incorrect']
> 2023-01-13T04:30:54 [    1.400214] RETBleed: WARNING: Spectre v2 mitigati=
on leaves CPU vulnerable to RETBleed attacks, data leaks possible!
> 2023-01-13T04:30:54 [    1.401214] RETBleed: Vulnerable
> 2023-01-13T04:30:54 [    1.402214] Speculative Store Bypass: Vulnerable
> 2023-01-13T04:30:54 [    1.403220] MDS: Vulnerable: Clear CPU buffers att=
empted, no microcode
> 2023-01-13T04:30:54 [    1.404214] TAA: Vulnerable: Clear CPU buffers att=
empted, no microcode
> 2023-01-13T04:30:54 [    1.405214] MMIO Stale Data: Vulnerable: Clear CPU=
 buffers attempted, no microcode
> 2023-01-13T04:30:54 [    1.406214] SRBDS: Vulnerable: No microcode
> 2023-01-13T04:30:54 [    1.430344] Freeing SMP alternatives memory: 52K
> 2023-01-13T04:30:54 [    1.432275] smpboot: CPU0: Intel(R) Xeon(R) CPU E3=
-1220 v6 @ 3.00GHz (family: 0x6, model: 0x9e, stepping: 0x9)
> 2023-01-13T04:30:54 [    1.433327] cblist_init_generic: Setting adjustabl=
e number of callback queues.
> 2023-01-13T04:30:54 [    1.434215] cblist_init_generic: Setting shift to =
2 and lim to 1.
> 2023-01-13T04:30:54 [    1.435227] cblist_init_generic: Setting shift to =
2 and lim to 1.
> 2023-01-13T04:30:54 [    1.436227] Performance Events: PEBS fmt3+, Skylak=
e events, 32-deep LBR, full-width counters, Intel PMU driver.
> 2023-01-13T04:30:54 [    1.437215] ... version:                4
> 2023-01-13T04:30:54 [    1.438214] ... bit width:              48
> 2023-01-13T04:30:54 [    1.439214] ... generic registers:      8
> 2023-01-13T04:30:54 [    1.440214] ... value mask:             0000ffffff=
ffffff
> 2023-01-13T04:30:54 [    1.441214] ... max period:             00007fffff=
ffffff
> 2023-01-13T04:30:54 [    1.442214] ... fixed-purpose events:   3
> 2023-01-13T04:30:54 [    1.443214] ... event mask:             0000000700=
0000ff
> 2023-01-13T04:30:54 [    1.444338] Estimated ratio of average max frequen=
cy by base frequency (times 1024): 1126
> 2023-01-13T04:30:54 [    1.445230] rcu: Hierarchical SRCU implementation.
> 2023-01-13T04:30:54 [    1.446214] rcu: 	Max phase no-delay instances is =
400.
> 2023-01-13T04:30:54 [    1.447456] smp: Bringing up secondary CPUs ...
> 2023-01-13T04:30:54 [    1.448283] x86: Booting SMP configuration:
> 2023-01-13T04:30:54 [    1.449215] .... node  #0, CPUs:      #1 #2 #3
> 2023-01-13T04:30:54 [    1.450634] smp: Brought up 1 node, 4 CPUs
> 2023-01-13T04:30:54 [    1.452214] smpboot: Max logical packages: 1
> 2023-01-13T04:30:54 [    1.453214] smpboot: Total of 4 processors activat=
ed (24000.00 BogoMIPS)
> 2023-01-13T04:30:54 [    1.455538] devtmpfs: initialized
> 2023-01-13T04:30:54 [    1.456363] ACPI: PM: Registering ACPI NVS region =
[mem 0x88767000-0x88767fff] (4096 bytes)
> 2023-01-13T04:30:54 [    1.457215] ACPI: PM: Registering ACPI NVS region =
[mem 0x8d11f000-0x8d891fff] (7811072 bytes)
> 2023-01-13T04:30:54 [    1.458325] clocksource: jiffies: mask: 0xffffffff=
 max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> 2023-01-13T04:30:54 [    1.459216] futex hash table entries: 1024 (order:=
 4, 65536 bytes, linear)
> 2023-01-13T04:30:54 [    1.460385] PM: RTC time: 04:30:54, date: 2023-01-=
13
> 2023-01-13T04:30:54 [    1.461276] NET: Registered PF_NETLINK/PF_ROUTE pr=
otocol family
> 2023-01-13T04:30:54 [    1.462290] audit: initializing netlink subsys (di=
sabled)
> 2023-01-13T04:30:54 [    1.463232] audit: type=3D2000 audit(1673584252.08=
5:1): state=3Dinitialized audit_enabled=3D0 res=3D1
> 2023-01-13T04:30:54 [    1.463277] thermal_sys: Registered thermal govern=
or 'step_wise'
> 2023-01-13T04:30:54 [    1.464215] thermal_sys: Registered thermal govern=
or 'user_space'
> 2023-01-13T04:30:54 [    1.465223] cpuidle: using governor menu
> 2023-01-13T04:30:54 [    1.475303] PCI: MMCONFIG for domain 0000 [bus 00-=
ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> 2023-01-13T04:30:54 [    1.484216] PCI: MMCONFIG at [mem 0xe0000000-0xeff=
fffff] reserved as E820 entry
> 2023-01-13T04:30:54 [    1.491222] PCI: Using configuration type 1 for ba=
se access
> 2023-01-13T04:30:54 [    1.497321] ENERGY_PERF_BIAS: Set to 'normal', was=
 'performance'
> 2023-01-13T04:30:54 [    1.498243] kprobes: kprobe jump-optimization is e=
nabled. All kprobes are optimized if possible.
> 2023-01-13T04:30:54 [    1.499240] HugeTLB: registered 2.00 MiB page size=
, pre-allocated 0 pages
> 2023-01-13T04:30:54 [    1.500215] HugeTLB: 28 KiB vmemmap can be freed f=
or a 2.00 MiB page
> 2023-01-13T04:30:54 [    1.501250] cryptd: max_cpu_qlen set to 1000
> 2023-01-13T04:30:54 [    1.502281] ACPI: Added _OSI(Module Device)
> 2023-01-13T04:30:54 [    1.503216] ACPI: Added _OSI(Processor Device)
> 2023-01-13T04:30:54 [    1.504214] ACPI: Added _OSI(3.0 _SCP Extensions)
> 2023-01-13T04:30:54 [    1.505214] ACPI: Added _OSI(Processor Aggregator =
Device)
> 2023-01-13T04:30:54 [    1.529435] ACPI: 7 ACPI AML tables successfully a=
cquired and loaded
> 2023-01-13T04:30:54 [    1.533265] ACPI: [Firmware Bug]: BIOS _OSI(Linux)=
 query ignored
> 2023-01-13T04:30:54 [    1.536216] ACPI: Dynamic OEM Table Load:
> 2023-01-13T04:30:54 [    1.539907] ACPI: Dynamic OEM Table Load:
> 2023-01-13T04:30:54 [    1.540219] ACPI: SSDT 0xFFFF8AC34098A800 000660 (=
v02 PmRef  Cpu0Ist  00003000 INTL 20120913)
> 2023-01-13T04:30:54 [    1.542694] ACPI: \_PR_.CPU0: _OSC native thermal =
LVT Acked
> 2023-01-13T04:30:54 [    1.544381] ACPI: Dynamic OEM Table Load:
> 2023-01-13T04:30:54 [    1.545217] ACPI: SSDT 0xFFFF8AC340354800 00037F (=
v02 PmRef  Cpu0Cst  00003001 INTL 20120913)
> 2023-01-13T04:30:54 [    1.548237] ACPI: Dynamic OEM Table Load:
> 2023-01-13T04:30:54 [    1.549223] ACPI: SSDT 0xFFFF8AC34098B800 0005AA (=
v02 PmRef  ApIst    00003000 INTL 20120913)
> 2023-01-13T04:30:54 [    1.551871] ACPI: Dynamic OEM Table Load:
> 2023-01-13T04:30:54 [    1.552216] ACPI: SSDT 0xFFFF8AC34084B600 000119 (=
v02 PmRef  ApCst    00003000 INTL 20120913)
> 2023-01-13T04:30:54 [    1.557169] ACPI: Interpreter enabled
> 2023-01-13T04:30:54 [    1.557241] ACPI: PM: (supports S0 S4 S5)
> 2023-01-13T04:30:54 [    1.558220] ACPI: Using IOAPIC for interrupt routi=
ng
> 2023-01-13T04:30:54 [    1.559243] PCI: Using host bridge windows from AC=
PI; if necessary, use \"pci=3Dnocrs\" and report a bug
> 2023-01-13T04:30:54 [    1.560214] PCI: Using E820 reservations for host =
bridge windows
> 2023-01-13T04:30:54 [    1.561977] ACPI: Enabled 8 GPEs in block 00 to 7F
> 2023-01-13T04:30:54 [    1.564212] ACPI: \_SB_.PCI0.PEG0.PG00: New power =
resource
> 2023-01-13T04:30:54 [    1.564689] ACPI: \_SB_.PCI0.PEG1.PG01: New power =
resource
> 2023-01-13T04:30:54 [    1.565490] ACPI: \_SB_.PCI0.PEG2.PG02: New power =
resource
> 2023-01-13T04:30:54 [    1.568791] ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.569550] ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.570467] ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.571468] ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.572466] ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.573465] ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.574509] ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.575488] ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.576489] ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.577488] ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.578465] ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.579464] ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.580510] ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.581657] ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.582549] ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.583478] ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.584480] ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.585478] ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.586469] ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.587465] ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New p=
ower resource
> 2023-01-13T04:30:54 [    1.596917] ACPI: \_TZ_.FN00: New power resource
> 2023-01-13T04:30:54 [    1.597287] ACPI: \_TZ_.FN01: New power resource
> 2023-01-13T04:30:54 [    1.598285] ACPI: \_TZ_.FN02: New power resource
> 2023-01-13T04:30:54 [    1.599285] ACPI: \_TZ_.FN03: New power resource
> 2023-01-13T04:30:54 [    1.600283] ACPI: \_TZ_.FN04: New power resource
> 2023-01-13T04:30:54 [    1.602474] ACPI: PCI Root Bridge [PCI0] (domain 0=
000 [bus 00-fe])
> 2023-01-13T04:30:54 [    1.603218] acpi PNP0A08:00: _OSC: OS supports [Ex=
tendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> 2023-01-13T04:30:54 [    1.605253] acpi PNP0A08:00: _OSC: OS now controls=
 [PME PCIeCapability LTR]
> 2023-01-13T04:30:54 [    1.607085] PCI host bridge to bus 0000:00
> 2023-01-13T04:30:54 [    1.607215] pci_bus 0000:00: root bus resource [io=
  0x0000-0x0cf7 window]
> 2023-01-13T04:30:54 [    1.608214] pci_bus 0000:00: root bus resource [io=
  0x0d00-0xffff window]
> 2023-01-13T04:30:54 [    1.609214] pci_bus 0000:00: root bus resource [me=
m 0x000a0000-0x000bffff window]
> 2023-01-13T04:30:54 [    1.610214] pci_bus 0000:00: root bus resource [me=
m 0x90000000-0xdfffffff window]
> 2023-01-13T04:30:54 [    1.611214] pci_bus 0000:00: root bus resource [me=
m 0xfd000000-0xfe7fffff window]
> 2023-01-13T04:30:54 [    1.612214] pci_bus 0000:00: root bus resource [bu=
s 00-fe]
> 2023-01-13T04:30:54 [    1.613299] pci 0000:00:00.0: [8086:5918] type 00 =
class 0x060000
> 2023-01-13T04:30:54 [    1.614372] pci 0000:00:13.0: [8086:a135] type 00 =
class 0x000000
> 2023-01-13T04:30:54 [    1.615232] pci 0000:00:13.0: reg 0x10: [mem 0xdf3=
22000-0xdf322fff 64bit]
> 2023-01-13T04:30:54 [    1.616477] pci 0000:00:14.0: [8086:a12f] type 00 =
class 0x0c0330
> 2023-01-13T04:30:54 [    1.617229] pci 0000:00:14.0: reg 0x10: [mem 0xdf3=
00000-0xdf30ffff 64bit]
> 2023-01-13T04:30:54 [    1.618277] pci 0000:00:14.0: PME# supported from =
D3hot D3cold
> 2023-01-13T04:30:54 [    1.619746] pci 0000:00:14.2: [8086:a131] type 00 =
class 0x118000
> 2023-01-13T04:30:54 [    1.620229] pci 0000:00:14.2: reg 0x10: [mem 0xdf3=
21000-0xdf321fff 64bit]
> 2023-01-13T04:30:54 [    1.621410] pci 0000:00:16.0: [8086:a13a] type 00 =
class 0x078000
> 2023-01-13T04:30:54 [    1.622248] pci 0000:00:16.0: reg 0x10: [mem 0xdf3=
20000-0xdf320fff 64bit]
> 2023-01-13T04:30:54 [    1.623344] pci 0000:00:16.0: PME# supported from =
D3hot
> 2023-01-13T04:30:54 [    1.624337] pci 0000:00:16.1: [8086:a13b] type 00 =
class 0x078000
> 2023-01-13T04:30:54 [    1.625248] pci 0000:00:16.1: reg 0x10: [mem 0xdf3=
1f000-0xdf31ffff 64bit]
> 2023-01-13T04:30:54 [    1.626344] pci 0000:00:16.1: PME# supported from =
D3hot
> 2023-01-13T04:30:54 [    1.627340] pci 0000:00:17.0: [8086:a102] type 00 =
class 0x010601
> 2023-01-13T04:30:54 [    1.628224] pci 0000:00:17.0: reg 0x10: [mem 0xdf3=
10000-0xdf311fff]
> 2023-01-13T04:30:54 [    1.629219] pci 0000:00:17.0: reg 0x14: [mem 0xdf3=
1e000-0xdf31e0ff]
> 2023-01-13T04:30:54 [    1.630219] pci 0000:00:17.0: reg 0x18: [io  0xf05=
0-0xf057]
> 2023-01-13T04:30:55 [    1.631219] pci 0000:00:17.0: reg 0x1c: [io  0xf04=
0-0xf043]
> 2023-01-13T04:30:55 [    1.632219] pci 0000:00:17.0: reg 0x20: [io  0xf02=
0-0xf03f]
> 2023-01-13T04:30:55 [    1.633219] pci 0000:00:17.0: reg 0x24: [mem 0xdf3=
1d000-0xdf31d7ff]
> 2023-01-13T04:30:55 [    1.634252] pci 0000:00:17.0: PME# supported from =
D3hot
> 2023-01-13T04:30:55 [    1.635456] pci 0000:00:1c.0: [8086:a110] type 01 =
class 0x060400
> 2023-01-13T04:30:55 [    1.636293] pci 0000:00:1c.0: PME# supported from =
D0 D3hot D3cold
> 2023-01-13T04:30:55 [    1.637628] pci 0000:00:1c.1: [8086:a111] type 01 =
class 0x060400
> 2023-01-13T04:30:55 [    1.638292] pci 0000:00:1c.1: PME# supported from =
D0 D3hot D3cold
> 2023-01-13T04:30:55 [    1.639629] pci 0000:00:1c.6: [8086:a116] type 01 =
class 0x060400
> 2023-01-13T04:30:55 [    1.640280] pci 0000:00:1c.6: PME# supported from =
D0 D3hot D3cold
> 2023-01-13T04:30:55 [    1.641619] pci 0000:00:1f.0: [8086:a149] type 00 =
class 0x060100
> 2023-01-13T04:30:55 [    1.642555] pci 0000:00:1f.2: [8086:a121] type 00 =
class 0x058000
> 2023-01-13T04:30:55 [    1.643227] pci 0000:00:1f.2: reg 0x10: [mem 0xdf3=
18000-0xdf31bfff]
> 2023-01-13T04:30:55 [    1.644483] pci 0000:00:1f.4: [8086:a123] type 00 =
class 0x0c0500
> 2023-01-13T04:30:55 [    1.645269] pci 0000:00:1f.4: reg 0x10: [mem 0xdf3=
1c000-0xdf31c0ff 64bit]
> 2023-01-13T04:30:55 [    1.646282] pci 0000:00:1f.4: reg 0x20: [io  0xf00=
0-0xf01f]
> 2023-01-13T04:30:55 [    1.647537] pci 0000:01:00.0: working around ROM B=
AR overlap defect
> 2023-01-13T04:30:55 [    1.648215] pci 0000:01:00.0: [8086:1533] type 00 =
class 0x020000
> 2023-01-13T04:30:55 [    1.649245] pci 0000:01:00.0: reg 0x10: [mem 0xdf2=
00000-0xdf27ffff]
> 2023-01-13T04:30:55 [    1.650246] pci 0000:01:00.0: reg 0x18: [io  0xe00=
0-0xe01f]
> 2023-01-13T04:30:55 [    1.651234] pci 0000:01:00.0: reg 0x1c: [mem 0xdf2=
80000-0xdf283fff]
> 2023-01-13T04:30:55 [    1.652371] pci 0000:01:00.0: PME# supported from =
D0 D3hot D3cold
> 2023-01-13T04:30:55 [    1.653497] pci 0000:00:1c.0: PCI bridge to [bus 0=
1]
> 2023-01-13T04:30:55 [    1.654216] pci 0000:00:1c.0:   bridge window [io =
 0xe000-0xefff]
> 2023-01-13T04:30:55 [    1.655215] pci 0000:00:1c.0:   bridge window [mem=
 0xdf200000-0xdf2fffff]
> 2023-01-13T04:30:55 [    1.656297] pci 0000:02:00.0: working around ROM B=
AR overlap defect
> 2023-01-13T04:30:55 [    1.657214] pci 0000:02:00.0: [8086:1533] type 00 =
class 0x020000
> 2023-01-13T04:30:55 [    1.658244] pci 0000:02:00.0: reg 0x10: [mem 0xdf1=
00000-0xdf17ffff]
> 2023-01-13T04:30:55 [    1.659246] pci 0000:02:00.0: reg 0x18: [io  0xd00=
0-0xd01f]
> 2023-01-13T04:30:55 [    1.660234] pci 0000:02:00.0: reg 0x1c: [mem 0xdf1=
80000-0xdf183fff]
> 2023-01-13T04:30:55 [    1.661370] pci 0000:02:00.0: PME# supported from =
D0 D3hot D3cold
> 2023-01-13T04:30:55 [    1.662495] pci 0000:00:1c.1: PCI bridge to [bus 0=
2]
> 2023-01-13T04:30:55 [    1.663216] pci 0000:00:1c.1:   bridge window [io =
 0xd000-0xdfff]
> 2023-01-13T04:30:55 [    1.664215] pci 0000:00:1c.1:   bridge window [mem=
 0xdf100000-0xdf1fffff]
> 2023-01-13T04:30:55 [    1.665277] pci 0000:03:00.0: [1a03:1150] type 01 =
class 0x060400
> 2023-01-13T04:30:55 [    1.666275] pci 0000:03:00.0: enabling Extended Ta=
gs
> 2023-01-13T04:30:55 [    1.667292] pci 0000:03:00.0: supports D1 D2
> 2023-01-13T04:30:55 [    1.668214] pci 0000:03:00.0: PME# supported from =
D0 D1 D2 D3hot D3cold
> 2023-01-13T04:30:55 [    1.669488] pci 0000:03:00.0: disabling ASPM on pr=
e-1.1 PCIe device.  You can enable it with 'pcie_aspm=3Dforce'
> 2023-01-13T04:30:55 [    1.670222] pci 0000:00:1c.6: PCI bridge to [bus 0=
3-04]
> 2023-01-13T04:30:55 [    1.671215] pci 0000:00:1c.6:   bridge window [io =
 0xc000-0xcfff]
> 2023-01-13T04:30:55 [    1.672215] pci 0000:00:1c.6:   bridge window [mem=
 0xde000000-0xdf0fffff]
> 2023-01-13T04:30:55 [    1.673258] pci_bus 0000:04: extended config space=
 not accessible
> 2023-01-13T04:30:55 [    1.674245] pci 0000:04:00.0: [1a03:2000] type 00 =
class 0x030000
> 2023-01-13T04:30:55 [    1.675234] pci 0000:04:00.0: reg 0x10: [mem 0xde0=
00000-0xdeffffff]
> 2023-01-13T04:30:55 [    1.676225] pci 0000:04:00.0: reg 0x14: [mem 0xdf0=
00000-0xdf01ffff]
> 2023-01-13T04:30:55 [    1.677225] pci 0000:04:00.0: reg 0x18: [io  0xc00=
0-0xc07f]
> 2023-01-13T04:30:55 [    1.678278] pci 0000:04:00.0: Video device with sh=
adowed ROM at [mem 0x000c0000-0x000dffff]
> 2023-01-13T04:30:55 [    1.679254] pci 0000:04:00.0: supports D1 D2
> 2023-01-13T04:30:55 [    1.680216] pci 0000:04:00.0: PME# supported from =
D0 D1 D2 D3hot D3cold
> 2023-01-13T04:30:55 [    1.681320] pci 0000:03:00.0: PCI bridge to [bus 0=
4]
> 2023-01-13T04:30:55 [    1.682220] pci 0000:03:00.0:   bridge window [io =
 0xc000-0xcfff]
> 2023-01-13T04:30:55 [    1.683217] pci 0000:03:00.0:   bridge window [mem=
 0xde000000-0xdf0fffff]
> 2023-01-13T04:30:55 [    1.686060] ACPI: PCI: Interrupt link LNKA configu=
red for IRQ 11
> 2023-01-13T04:30:55 [    1.686277] ACPI: PCI: Interrupt link LNKB configu=
red for IRQ 10
> 2023-01-13T04:30:55 [    1.687274] ACPI: PCI: Interrupt link LNKC configu=
red for IRQ 11
> 2023-01-13T04:30:55 [    1.688274] ACPI: PCI: Interrupt link LNKD configu=
red for IRQ 11
> 2023-01-13T04:30:55 [    1.689275] ACPI: PCI: Interrupt link LNKE configu=
red for IRQ 11
> 2023-01-13T04:30:55 [    1.690275] ACPI: PCI: Interrupt link LNKF configu=
red for IRQ 11
> 2023-01-13T04:30:55 [    1.691270] ACPI: PCI: Interrupt link LNKG configu=
red for IRQ 11
> 2023-01-13T04:30:55 [    1.692273] ACPI: PCI: Interrupt link LNKH configu=
red for IRQ 11
> 2023-01-13T04:30:55 [    1.698764] iommu: Default domain type: Translated=
=20
> 2023-01-13T04:30:55 [    1.699215] iommu: DMA domain TLB invalidation pol=
icy: lazy mode=20
> 2023-01-13T04:30:55 [    1.700257] SCSI subsystem initialized
> 2023-01-13T04:30:55 [    1.701244] ACPI: bus type USB registered
> 2023-01-13T04:30:55 [    1.702224] usbcore: registered new interface driv=
er usbfs
> 2023-01-13T04:30:55 [    1.703218] usbcore: registered new interface driv=
er hub
> 2023-01-13T04:30:55 [    1.704219] usbcore: registered new device driver =
usb
> 2023-01-13T04:30:55 [    1.705224] mc: Linux media interface: v0.10
> 2023-01-13T04:30:55 [    1.706219] videodev: Linux video capture interfac=
e: v2.00
> 2023-01-13T04:30:55 [    1.707217] pps_core: LinuxPPS API ver. 1 register=
ed
> 2023-01-13T04:30:55 [    1.708214] pps_core: Software ver. 5.3.6 - Copyri=
ght 2005-2007 Rodolfo Giometti <giometti@linux.it>
> 2023-01-13T04:30:55 [    1.709215] PTP clock support registered
> 2023-01-13T04:30:55 [    1.710237] Advanced Linux Sound Architecture Driv=
er Initialized.
> 2023-01-13T04:30:55 [    1.711378] NetLabel: Initializing
> 2023-01-13T04:30:55 [    1.712214] NetLabel:  domain hash size =3D 128
> 2023-01-13T04:30:55 [    1.713214] NetLabel:  protocols =3D UNLABELED CIP=
SOv4 CALIPSO
> 2023-01-13T04:30:55 [    1.714227] NetLabel:  unlabeled traffic allowed b=
y default
> 2023-01-13T04:30:55 [    1.715228] PCI: Using ACPI for IRQ routing
> 2023-01-13T04:30:55 [    1.744100] pci 0000:04:00.0: vgaarb: setting as b=
oot VGA device
> 2023-01-13T04:30:55 [    1.744213] pci 0000:04:00.0: vgaarb: bridge contr=
ol possible
> 2023-01-13T04:30:55 [    1.744213] pci 0000:04:00.0: vgaarb: VGA device a=
dded: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
> 2023-01-13T04:30:55 [    1.744215] vgaarb: loaded
> 2023-01-13T04:30:55 [    1.745255] hpet0: at MMIO 0xfed00000, IRQs 2, 8, =
0, 0, 0, 0, 0, 0
> 2023-01-13T04:30:55 [    1.746214] hpet0: 8 comparators, 64-bit 24.000000=
 MHz counter
> 2023-01-13T04:30:55 [    1.749241] clocksource: Switched to clocksource t=
sc-early
> 2023-01-13T04:30:55 [    1.754785] VFS: Disk quotas dquot_6.6.0
> 2023-01-13T04:30:55 [    1.758722] VFS: Dquot-cache hash table entries: 5=
12 (order 0, 4096 bytes)
> 2023-01-13T04:30:55 [    1.765646] pnp: PnP ACPI init
> 2023-01-13T04:30:55 [    1.769016] system 00:00: [io  0x0a00-0x0a0f] has =
been reserved
> 2023-01-13T04:30:55 [    1.774949] system 00:00: [io  0x0a10-0x0a1f] has =
been reserved
> 2023-01-13T04:30:55 [    1.780866] system 00:00: [io  0x0a20-0x0a2f] has =
been reserved
> 2023-01-13T04:30:55 [    1.786785] system 00:00: [io  0x0a30-0x0a3f] has =
been reserved
> 2023-01-13T04:30:55 [    1.792703] system 00:00: [io  0x0a40-0x0a4f] has =
been reserved
> 2023-01-13T04:30:55 [    1.799361] system 00:03: [io  0x0680-0x069f] has =
been reserved
> 2023-01-13T04:30:55 [    1.805291] system 00:03: [io  0xffff] has been re=
served
> 2023-01-13T04:30:55 [    1.810609] system 00:03: [io  0xffff] has been re=
served
> 2023-01-13T04:30:55 [    1.815920] system 00:03: [io  0xffff] has been re=
served
> 2023-01-13T04:30:55 [    1.821225] system 00:03: [io  0x1800-0x18fe] has =
been reserved
> 2023-01-13T04:30:55 [    1.827144] system 00:03: [io  0x164e-0x164f] has =
been reserved
> 2023-01-13T04:30:55 [    1.833136] system 00:04: [io  0x0800-0x087f] has =
been reserved
> 2023-01-13T04:30:55 [    1.839116] system 00:06: [io  0x1854-0x1857] has =
been reserved
> 2023-01-13T04:30:55 [    1.845290] system 00:07: [mem 0xfed10000-0xfed17f=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.851921] system 00:07: [mem 0xfed18000-0xfed18f=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.858541] system 00:07: [mem 0xfed19000-0xfed19f=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.865147] system 00:07: [mem 0xe0000000-0xefffff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.871759] system 00:07: [mem 0xfed20000-0xfed3ff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.878371] system 00:07: [mem 0xfed90000-0xfed93f=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.884984] system 00:07: [mem 0xfed45000-0xfed8ff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.891595] system 00:07: [mem 0xff000000-0xffffff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.898199] system 00:07: [mem 0xfee00000-0xfeefff=
ff] could not be reserved
> 2023-01-13T04:30:55 [    1.905150] system 00:07: [mem 0xdffe0000-0xdfffff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.911803] system 00:08: [mem 0xfd000000-0xfdabff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.918418] system 00:08: [mem 0xfdad0000-0xfdadff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.925031] system 00:08: [mem 0xfdb00000-0xfdffff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.931645] system 00:08: [mem 0xfe000000-0xfe01ff=
ff] could not be reserved
> 2023-01-13T04:30:55 [    1.938605] system 00:08: [mem 0xfe036000-0xfe03bf=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.945215] system 00:08: [mem 0xfe03d000-0xfe3fff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.951827] system 00:08: [mem 0xfe410000-0xfe7fff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.958649] system 00:09: [io  0xff00-0xfffe] has =
been reserved
> 2023-01-13T04:30:55 [    1.965425] system 00:0a: [mem 0xfdaf0000-0xfdafff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.972048] system 00:0a: [mem 0xfdae0000-0xfdaeff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.978658] system 00:0a: [mem 0xfdac0000-0xfdacff=
ff] has been reserved
> 2023-01-13T04:30:55 [    1.985976] pnp: PnP ACPI: found 11 devices
> 2023-01-13T04:30:55 [    1.995942] clocksource: acpi_pm: mask: 0xffffff m=
ax_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> 2023-01-13T04:30:55 [    2.004825] NET: Registered PF_INET protocol family
> 2023-01-13T04:30:55 [    2.009834] IP idents hash table entries: 262144 (=
order: 9, 2097152 bytes, linear)
> 2023-01-13T04:30:55 [    2.020017] tcp_listen_portaddr_hash hash table en=
tries: 8192 (order: 5, 131072 bytes, linear)
> 2023-01-13T04:30:55 [    2.028640] Table-perturb hash table entries: 6553=
6 (order: 6, 262144 bytes, linear)
> 2023-01-13T04:30:55 [    2.036391] TCP established hash table entries: 13=
1072 (order: 8, 1048576 bytes, linear)
> 2023-01-13T04:30:55 [    2.044577] TCP bind hash table entries: 65536 (or=
der: 9, 2097152 bytes, linear)
> 2023-01-13T04:30:55 [    2.052212] TCP: Hash tables configured (establish=
ed 131072 bind 65536)
> 2023-01-13T04:30:55 [    2.058896] MPTCP token hash table entries: 16384 =
(order: 6, 393216 bytes, linear)
> 2023-01-13T04:30:55 [    2.066503] UDP hash table entries: 8192 (order: 6=
, 262144 bytes, linear)
> 2023-01-13T04:30:55 [    2.073320] UDP-Lite hash table entries: 8192 (ord=
er: 6, 262144 bytes, linear)
> 2023-01-13T04:30:55 [    2.080595] NET: Registered PF_UNIX/PF_LOCAL proto=
col family
> 2023-01-13T04:30:55 [    2.086324] RPC: Registered named UNIX socket tran=
sport module.
> 2023-01-13T04:30:55 [    2.092251] RPC: Registered udp transport module.
> 2023-01-13T04:30:55 [    2.096956] RPC: Registered tcp transport module.
> 2023-01-13T04:30:55 [    2.101659] RPC: Registered tcp NFSv4.1 backchanne=
l transport module.
> 2023-01-13T04:30:55 [    2.108313] pci 0000:00:1c.0: PCI bridge to [bus 0=
1]
> 2023-01-13T04:30:55 [    2.113290] pci 0000:00:1c.0:   bridge window [io =
 0xe000-0xefff]
> 2023-01-13T04:30:55 [    2.119387] pci 0000:00:1c.0:   bridge window [mem=
 0xdf200000-0xdf2fffff]
> 2023-01-13T04:30:55 [    2.126175] pci 0000:00:1c.1: PCI bridge to [bus 0=
2]
> 2023-01-13T04:30:55 [    2.131136] pci 0000:00:1c.1:   bridge window [io =
 0xd000-0xdfff]
> 2023-01-13T04:30:55 [    2.137231] pci 0000:00:1c.1:   bridge window [mem=
 0xdf100000-0xdf1fffff]
> 2023-01-13T04:30:55 [    2.144020] pci 0000:03:00.0: PCI bridge to [bus 0=
4]
> 2023-01-13T04:30:55 [    2.148981] pci 0000:03:00.0:   bridge window [io =
 0xc000-0xcfff]
> 2023-01-13T04:30:55 [    2.155076] pci 0000:03:00.0:   bridge window [mem=
 0xde000000-0xdf0fffff]
> 2023-01-13T04:30:55 [    2.161865] pci 0000:00:1c.6: PCI bridge to [bus 0=
3-04]
> 2023-01-13T04:30:55 [    2.167083] pci 0000:00:1c.6:   bridge window [io =
 0xc000-0xcfff]
> 2023-01-13T04:30:55 [    2.173176] pci 0000:00:1c.6:   bridge window [mem=
 0xde000000-0xdf0fffff]
> 2023-01-13T04:30:55 [    2.179967] pci_bus 0000:00: resource 4 [io  0x000=
0-0x0cf7 window]
> 2023-01-13T04:30:55 [    2.186142] pci_bus 0000:00: resource 5 [io  0x0d0=
0-0xffff window]
> 2023-01-13T04:30:55 [    2.192320] pci_bus 0000:00: resource 6 [mem 0x000=
a0000-0x000bffff window]
> 2023-01-13T04:30:56 [    2.199194] pci_bus 0000:00: resource 7 [mem 0x900=
00000-0xdfffffff window]
> 2023-01-13T04:30:56 [    2.206064] pci_bus 0000:00: resource 8 [mem 0xfd0=
00000-0xfe7fffff window]
> 2023-01-13T04:30:56 [    2.212929] pci_bus 0000:01: resource 0 [io  0xe00=
0-0xefff]
> 2023-01-13T04:30:56 [    2.218500] pci_bus 0000:01: resource 1 [mem 0xdf2=
00000-0xdf2fffff]
> 2023-01-13T04:30:56 [    2.224760] pci_bus 0000:02: resource 0 [io  0xd00=
0-0xdfff]
> 2023-01-13T04:30:56 [    2.230330] pci_bus 0000:02: resource 1 [mem 0xdf1=
00000-0xdf1fffff]
> 2023-01-13T04:30:56 [    2.236589] pci_bus 0000:03: resource 0 [io  0xc00=
0-0xcfff]
> 2023-01-13T04:30:56 [    2.242160] pci_bus 0000:03: resource 1 [mem 0xde0=
00000-0xdf0fffff]
> 2023-01-13T04:30:56 [    2.248418] pci_bus 0000:04: resource 0 [io  0xc00=
0-0xcfff]
> 2023-01-13T04:30:56 [    2.253989] pci_bus 0000:04: resource 1 [mem 0xde0=
00000-0xdf0fffff]
> 2023-01-13T04:30:56 [    2.265143] PCI: CLS 0 bytes, default 64
> 2023-01-13T04:30:56 [    2.269081] DMAR: Host address width 39
> 2023-01-13T04:30:56 [    2.272927] DMAR: DRHD base: 0x000000fed90000 flag=
s: 0x1
> 2023-01-13T04:30:56 [    2.278244] DMAR: dmar0: reg_base_addr fed90000 ve=
r 1:0 cap d2008c40660462 ecap f050da
> 2023-01-13T04:30:56 [    2.286160] DMAR: RMRR base: 0x0000008ccae000 end:=
 0x0000008cccdfff
> 2023-01-13T04:30:56 [    2.292432] PCI-DMA: Using software bounce bufferi=
ng for IO (SWIOTLB)
> 2023-01-13T04:30:56 [    2.298873] software IO TLB: mapped [mem 0x0000000=
088ba1000-0x000000008cba1000] (64MB)
> 2023-01-13T04:30:56 [    2.306823] RAPL PMU: API unit is 2^-32 Joules, 3 =
fixed counters, 655360 ms ovfl timer
> 2023-01-13T04:30:56 [    2.314744] RAPL PMU: hw unit of domain pp0-core 2=
^-14 Joules
> 2023-01-13T04:30:56 [    2.320487] RAPL PMU: hw unit of domain package 2^=
-14 Joules
> 2023-01-13T04:30:56 [    2.326137] RAPL PMU: hw unit of domain dram 2^-14=
 Joules
> 2023-01-13T04:30:56 [    2.335047] kvm: already loaded vendor module 'kvm=
_intel'
> 2023-01-13T04:30:56 [    2.341150] Initialise system trusted keyrings
> 2023-01-13T04:30:56 [    2.345632] workingset: timestamp_bits=3D40 max_or=
der=3D22 bucket_order=3D0
> 2023-01-13T04:30:56 [    2.352182] NFS: Registering the id_resolver key t=
ype
> 2023-01-13T04:30:56 [    2.357246] Key type id_resolver registered
> 2023-01-13T04:30:56 [    2.361438] Key type id_legacy registered
> 2023-01-13T04:30:56 [    2.365475] 9p: Installing v9fs 9p2000 file system=
 support
> 2023-01-13T04:30:56 [    2.378638] NET: Registered PF_ALG protocol family
> 2023-01-13T04:30:56 [    2.383441] Key type asymmetric registered
> 2023-01-13T04:30:56 [    2.387538] Asymmetric key parser 'x509' registered
> 2023-01-13T04:30:56 [    2.392418] Block layer SCSI generic (bsg) driver =
version 0.4 loaded (major 250)
> 2023-01-13T04:30:56 [    2.399828] io scheduler mq-deadline registered
> 2023-01-13T04:30:56 [    2.404370] io scheduler kyber registered
> 2023-01-13T04:30:56 [    2.408615] pcieport 0000:00:1c.0: PME: Signaling =
with IRQ 24
> 2023-01-13T04:30:56 [    2.414594] pcieport 0000:00:1c.1: PME: Signaling =
with IRQ 25
> 2023-01-13T04:30:56 [    2.420558] pcieport 0000:00:1c.6: PME: Signaling =
with IRQ 26
> 2023-01-13T04:30:56 [    2.426511] input: Sleep Button as /devices/LNXSYS=
TM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
> 2023-01-13T04:30:56 [    2.434891] ACPI: button: Sleep Button [SLPB]
> 2023-01-13T04:30:56 [    2.439288] input: Power Button as /devices/LNXSYS=
TM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> 2023-01-13T04:30:56 [    2.447657] ACPI: button: Power Button [PWRB]
> 2023-01-13T04:30:56 [    2.452052] input: Power Button as /devices/LNXSYS=
TM:00/LNXPWRBN:00/input/input2
> 2023-01-13T04:30:56 [    2.459481] ACPI: button: Power Button [PWRF]
> 2023-01-13T04:30:56 [    2.464189] ACPI: \_PR_.CPU0: Found 3 idle states
> 2023-01-13T04:30:56 [    2.469065] ACPI: \_PR_.CPU1: Found 3 idle states
> 2023-01-13T04:30:56 [    2.473940] ACPI: \_PR_.CPU2: Found 3 idle states
> 2023-01-13T04:30:56 [    2.478825] ACPI: \_PR_.CPU3: Found 3 idle states
> 2023-01-13T04:30:56 [    2.483994] thermal LNXTHERM:00: registered as the=
rmal_zone0
> 2023-01-13T04:30:56 [    2.489667] ACPI: thermal: Thermal Zone [TZ00] (28=
 C)
> 2023-01-13T04:30:56 [    2.494838] thermal LNXTHERM:01: registered as the=
rmal_zone1
> 2023-01-13T04:30:56 [    2.500508] ACPI: thermal: Thermal Zone [TZ01] (30=
 C)
> 2023-01-13T04:30:56 [    2.505653] Serial: 8250/16550 driver, 4 ports, IR=
Q sharing enabled
> 2023-01-13T04:30:56 [    2.511997] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, =
base_baud =3D 115200) is a 16550A
> 2023-01-13T04:30:56 [    2.519412] 00:02: ttyS1 at I/O 0x2f8 (irq =3D 3, =
base_baud =3D 115200) is a 16550A
> 2023-01-13T04:30:56 [    2.527204] Non-volatile memory driver v1.3
> 2023-01-13T04:30:56 [    2.531406] Linux agpgart interface v0.103
> 2023-01-13T04:30:56 [    2.535629] ACPI: bus type drm_connector registered
> 2023-01-13T04:30:56 [    2.541968] loop: module loaded
> 2023-01-13T04:30:56 [    2.555758] ahci 0000:00:17.0: AHCI 0001.0301 32 s=
lots 8 ports 6 Gbps 0xff impl SATA mode
> 2023-01-13T04:30:56 [    2.563941] ahci 0000:00:17.0: flags: 64bit ncq sn=
tf led clo only pio slum part ems deso sadm sds apst=20
> 2023-01-13T04:30:56 [    2.595156] scsi host0: ahci
> 2023-01-13T04:30:56 [    2.598363] scsi host1: ahci
> 2023-01-13T04:30:56 [    2.601529] scsi host2: ahci
> 2023-01-13T04:30:56 [    2.604741] scsi host3: ahci
> 2023-01-13T04:30:56 [    2.607933] scsi host4: ahci
> 2023-01-13T04:30:56 [    2.611111] scsi host5: ahci
> 2023-01-13T04:30:56 [    2.614226] scsi host6: ahci
> 2023-01-13T04:30:56 [    2.617379] scsi host7: ahci
> 2023-01-13T04:30:56 [    2.620327] ata1: SATA max UDMA/133 abar m2048@0xd=
f31d000 port 0xdf31d100 irq 27
> 2023-01-13T04:30:56 [    2.627722] ata2: SATA max UDMA/133 abar m2048@0xd=
f31d000 port 0xdf31d180 irq 27
> 2023-01-13T04:30:56 [    2.635114] ata3: SATA max UDMA/133 abar m2048@0xd=
f31d000 port 0xdf31d200 irq 27
> 2023-01-13T04:30:56 [    2.642504] ata4: SATA max UDMA/133 abar m2048@0xd=
f31d000 port 0xdf31d280 irq 27
> 2023-01-13T04:30:56 [    2.649888] ata5: SATA max UDMA/133 abar m2048@0xd=
f31d000 port 0xdf31d300 irq 27
> 2023-01-13T04:30:56 [    2.657271] ata6: SATA max UDMA/133 abar m2048@0xd=
f31d000 port 0xdf31d380 irq 27
> 2023-01-13T04:30:56 [    2.664656] ata7: SATA max UDMA/133 abar m2048@0xd=
f31d000 port 0xdf31d400 irq 27
> 2023-01-13T04:30:56 [    2.672041] ata8: SATA max UDMA/133 abar m2048@0xd=
f31d000 port 0xdf31d480 irq 27
> 2023-01-13T04:30:56 [    2.679742] e100: Intel(R) PRO/100 Network Driver
> 2023-01-13T04:30:56 [    2.684460] e100: Copyright(c) 1999-2006 Intel Cor=
poration
> 2023-01-13T04:30:56 [    2.689959] e1000: Intel(R) PRO/1000 Network Driver
> 2023-01-13T04:30:56 [    2.694843] e1000: Copyright (c) 1999-2006 Intel C=
orporation.
> 2023-01-13T04:30:56 [    2.700595] e1000e: Intel(R) PRO/1000 Network Driv=
er
> 2023-01-13T04:30:56 [    2.705571] e1000e: Copyright(c) 1999 - 2015 Intel=
 Corporation.
> 2023-01-13T04:30:56 [    2.711498] igb: Intel(R) Gigabit Ethernet Network=
 Driver
> 2023-01-13T04:30:56 [    2.716907] igb: Copyright (c) 2007-2014 Intel Cor=
poration.
> 2023-01-13T04:30:56 [    2.750538] pps pps0: new PPS source ptp0
> 2023-01-13T04:30:56 [    2.754645] igb 0000:01:00.0: added PHC on eth0
> 2023-01-13T04:30:56 [    2.759193] igb 0000:01:00.0: Intel(R) Gigabit Eth=
ernet Network Connection
> 2023-01-13T04:30:56 [    2.766062] igb 0000:01:00.0: eth0: (PCIe:2.5Gb/s:=
Width x1) ac:1f:6b:1a:b3:4e
> 2023-01-13T04:30:56 [    2.773242] igb 0000:01:00.0: eth0: PBA No: 012700=
-000
> 2023-01-13T04:30:56 [    2.778378] igb 0000:01:00.0: Using MSI-X interrup=
ts. 4 rx queue(s), 4 tx queue(s)
> 2023-01-13T04:30:56 [    2.816488] pps pps1: new PPS source ptp1
> 2023-01-13T04:30:56 [    2.820594] igb 0000:02:00.0: added PHC on eth1
> 2023-01-13T04:30:56 [    2.825137] igb 0000:02:00.0: Intel(R) Gigabit Eth=
ernet Network Connection
> 2023-01-13T04:30:56 [    2.832013] igb 0000:02:00.0: eth1: (PCIe:2.5Gb/s:=
Width x1) ac:1f:6b:1a:b3:4f
> 2023-01-13T04:30:56 [    2.839205] igb 0000:02:00.0: eth1: PBA No: 012700=
-000
> 2023-01-13T04:30:56 [    2.844335] igb 0000:02:00.0: Using MSI-X interrup=
ts. 4 rx queue(s), 4 tx queue(s)
> 2023-01-13T04:30:56 [    2.851939] sky2: driver version 1.30
> 2023-01-13T04:30:56 [    2.855629] QLogic FastLinQ 4xxxx Core Module qed
> 2023-01-13T04:30:56 [    2.860345] qede init: QLogic FastLinQ 4xxxx Ether=
net Driver qede
> 2023-01-13T04:30:56 [    2.866462] usbcore: registered new interface driv=
er asix
> 2023-01-13T04:30:56 [    2.871873] usbcore: registered new interface driv=
er ax88179_178a
> 2023-01-13T04:30:56 [    2.877969] usbcore: registered new interface driv=
er cdc_ether
> 2023-01-13T04:30:56 [    2.883810] usbcore: registered new interface driv=
er net1080
> 2023-01-13T04:30:56 [    2.889475] usbcore: registered new interface driv=
er cdc_subset
> 2023-01-13T04:30:56 [    2.895395] usbcore: registered new interface driv=
er zaurus
> 2023-01-13T04:30:56 [    2.900967] usbcore: registered new interface driv=
er cdc_ncm
> 2023-01-13T04:30:56 [    2.906630] usbcore: registered new interface driv=
er r8153_ecm
> 2023-01-13T04:30:56 [    2.912606] usbcore: registered new interface driv=
er usblp
> 2023-01-13T04:30:56 [    2.912777] xhci_hcd 0000:00:14.0: xHCI Host Contr=
oller
> 2023-01-13T04:30:56 [    2.918103] usbcore: registered new interface driv=
er usb-storage
> 2023-01-13T04:30:56 [    2.923418] xhci_hcd 0000:00:14.0: new USB bus reg=
istered, assigned bus number 1
> 2023-01-13T04:30:56 [    2.929361] i8042: PNP: No PS/2 controller found.
> 2023-01-13T04:30:56 [    2.937858] xhci_hcd 0000:00:14.0: hcc params 0x20=
0077c1 hci version 0x100 quirks 0x0000000001109810
> 2023-01-13T04:30:56 [    2.941747] rtc_cmos 00:05: RTC can wake from S4
> 2023-01-13T04:30:56 [    2.950994] xhci_hcd 0000:00:14.0: xHCI Host Contr=
oller
> 2023-01-13T04:30:56 [    2.955966] rtc_cmos 00:05: registered as rtc0
> 2023-01-13T04:30:56 [    2.960512] xhci_hcd 0000:00:14.0: new USB bus reg=
istered, assigned bus number 2
> 2023-01-13T04:30:56 [    2.964893] rtc_cmos 00:05: alarms up to one month=
, y3k, 242 bytes nvram
> 2023-01-13T04:30:56 [    2.972254] xhci_hcd 0000:00:14.0: Host supports U=
SB 3.0 SuperSpeed
> 2023-01-13T04:30:56 [    2.978966] fail to initialize ptp_kvm
> 2023-01-13T04:30:56 [    2.979147] i801_smbus 0000:00:1f.4: SPD Write Dis=
able is set
> 2023-01-13T04:30:56 [    2.979201] i801_smbus 0000:00:1f.4: SMBus using P=
CI interrupt
> 2023-01-13T04:30:56 [    2.979255] pci 0000:00:1f.1: [8086:a120] type 00 =
class 0x058000
> 2023-01-13T04:30:56 [    2.979321] pci 0000:00:1f.1: reg 0x10: [mem 0xfd0=
00000-0xfdffffff 64bit]
> 2023-01-13T04:30:56 [    2.980530] i2c i2c-0: 2/4 memory slots populated =
(from DMI)
> 2023-01-13T04:30:56 [    2.982802] ata2: SATA link down (SStatus 0 SContr=
ol 300)
> 2023-01-13T04:30:56 [    2.982902] ata4: SATA link down (SStatus 0 SContr=
ol 300)
> 2023-01-13T04:30:56 [    2.983969] ata3: SATA link up 6.0 Gbps (SStatus 1=
33 SControl 300)
> 2023-01-13T04:30:56 [    2.985210] ata5: SATA link down (SStatus 0 SContr=
ol 300)
> 2023-01-13T04:30:56 [    2.985270] ata6: SATA link down (SStatus 0 SContr=
ol 300)
> 2023-01-13T04:30:56 [    2.985332] usb usb1: New USB device found, idVend=
or=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.02
> 2023-01-13T04:30:56 [    2.985334] usb usb1: New USB device strings: Mfr=
=3D3, Product=3D2, SerialNumber=3D1
> 2023-01-13T04:30:56 [    2.985335] usb usb1: Product: xHCI Host Controller
> 2023-01-13T04:30:56 [    2.985337] usb usb1: Manufacturer: Linux 6.2.0-rc=
3-next-20230113 xhci-hcd
> 2023-01-13T04:30:56 [    2.985338] usb usb1: SerialNumber: 0000:00:14.0
> 2023-01-13T04:30:56 [    2.985571] hub 1-0:1.0: USB hub found
> 2023-01-13T04:30:56 [    2.985604] hub 1-0:1.0: 16 ports detected
> 2023-01-13T04:30:56 [    2.987391] usb usb2: New USB device found, idVend=
or=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.02
> 2023-01-13T04:30:56 [    2.987394] usb usb2: New USB device strings: Mfr=
=3D3, Product=3D2, SerialNumber=3D1
> 2023-01-13T04:30:56 [    2.987395] usb usb2: Product: xHCI Host Controller
> 2023-01-13T04:30:56 [    2.987396] usb usb2: Manufacturer: Linux 6.2.0-rc=
3-next-20230113 xhci-hcd
> 2023-01-13T04:30:56 [    2.987397] usb usb2: SerialNumber: 0000:00:14.0
> 2023-01-13T04:30:56 [    2.987478] hub 2-0:1.0: USB hub found
> 2023-01-13T04:30:56 [    2.987500] hub 2-0:1.0: 10 ports detected
> 2023-01-13T04:30:56 [    2.988211] usb: port power management may be unre=
liable
> 2023-01-13T04:30:56 [    2.995251] i2c i2c-0: Successfully instantiated S=
PD at 0x51
> 2023-01-13T04:30:56 [    3.000633] ata7: SATA link down (SStatus 0 SContr=
ol 300)
> 2023-01-13T04:30:56 [    3.007167] i2c i2c-0: Successfully instantiated S=
PD at 0x53
> 2023-01-13T04:30:56 [    3.011328] kwatchdog (84) used greatest stack dep=
th: 15624 bytes left
> 2023-01-13T04:30:56 [    3.013441] ata1: SATA link down (SStatus 0 SContr=
ol 300)
> 2023-01-13T04:30:56 [    3.013534] device-mapper: ioctl: 4.47.0-ioctl (20=
22-07-28) initialised: dm-devel@redhat.com
> 2023-01-13T04:30:56 [    3.013540] intel_pstate: Intel P-state driver ini=
tializing
> 2023-01-13T04:30:56 [    3.041506] intel_pstate: Disabling energy efficie=
ncy optimization
> 2023-01-13T04:30:56 [    3.046887] ata8: SATA link down (SStatus 0 SContr=
ol 300)
> 2023-01-13T04:30:56 [    3.055073] intel_pstate: HWP enabled
> 2023-01-13T04:30:56 [    3.055566] kworker/u8:1 (89) used greatest stack =
depth: 14392 bytes left
> 2023-01-13T04:30:56 [    3.062297] ata3.00: ATA-8: TOSHIBA MG03ACA100, FL=
1A, max UDMA/100
> 2023-01-13T04:30:57 [    3.067617] hid: raw HID events driver (C) Jiri Ko=
sina
> 2023-01-13T04:30:57 [    3.074594] ata3.00: 1953525168 sectors, multi 16:=
 LBA48 NCQ (depth 32), AA
> 2023-01-13T04:30:57 [    3.078752] usbcore: registered new interface driv=
er usbhid
> 2023-01-13T04:30:57 [    3.083395] ata3.00: configured for UDMA/100
> 2023-01-13T04:30:57 [    3.086502] usbhid: USB HID core driver
> 2023-01-13T04:30:57 [    3.087089] Initializing XFRM netlink socket
> 2023-01-13T04:30:57 [    3.094840] scsi 2:0:0:0: Direct-Access     ATA   =
   TOSHIBA MG03ACA1 FL1A PQ: 0 ANSI: 5
> 2023-01-13T04:30:57 [    3.101993] NET: Registered PF_INET6 protocol fami=
ly
> 2023-01-13T04:30:57 [    3.106975] scsi 2:0:0:0: Attached scsi generic sg=
0 type 0
> 2023-01-13T04:30:57 [    3.107064] sd 2:0:0:0: [sda] 1953525168 512-byte =
logical blocks: (1.00 TB/932 GiB)
> 2023-01-13T04:30:57 [    3.107129] sd 2:0:0:0: [sda] Write Protect is off
> 2023-01-13T04:30:57 [    3.107149] sd 2:0:0:0: [sda] Write cache: enabled=
, read cache: enabled, doesn't support DPO or FUA
> 2023-01-13T04:30:57 [    3.107171] sd 2:0:0:0: [sda] Preferred minimum I/=
O size 512 bytes
> 2023-01-13T04:30:57 [    3.113947] Segment Routing with IPv6
> 2023-01-13T04:30:57 [    3.231252] usb 1-6: new high-speed USB device num=
ber 2 using xhci_hcd
> 2023-01-13T04:30:57 [    3.232351] In-situ OAM (IOAM) with IPv6
> 2023-01-13T04:30:57 [    3.292643] sd 2:0:0:0: [sda] Attached SCSI disk
> 2023-01-13T04:30:57 [    3.292655] sit: IPv6, IPv4 and MPLS over IPv4 tun=
neling driver
> 2023-01-13T04:30:57 [    3.303296] NET: Registered PF_PACKET protocol fam=
ily
> 2023-01-13T04:30:57 [    3.308375] 9pnet: Installing 9P2000 support
> 2023-01-13T04:30:57 [    3.312702] Key type dns_resolver registered
> 2023-01-13T04:30:57 [    3.317639] microcode: Microcode Update Driver: v2=
=2E2.
> 2023-01-13T04:30:57 [    3.317644] IPI shorthand broadcast: enabled
> 2023-01-13T04:30:57 [    3.327042] AVX2 version of gcm_enc/dec engaged.
> 2023-01-13T04:30:57 [    3.332261] AES CTR mode by8 optimization enabled
> 2023-01-13T04:30:57 [    3.339544] sched_clock: Marking stable (203517897=
7, 1304035566)->(4501291417, -1162076874)
> 2023-01-13T04:30:57 [    3.348097] registered taskstats version 1
> 2023-01-13T04:30:57 [    3.352222] Loading compiled-in X.509 certificates
> 2023-01-13T04:30:57 [    3.358696] PM:   Magic number: 7:843:514
> 2023-01-13T04:30:57 [    3.362776] platform ACPI000C:00: hash matches
> 2023-01-13T04:30:57 [    3.367254] acpi ACPI000C:00: hash matches
> 2023-01-13T04:30:57 [    3.367898] usb 1-6: New USB device found, idVendo=
r=3D0781, idProduct=3D5567, bcdDevice=3D 1.00
> 2023-01-13T04:30:57 [    3.371390] printk: console [netcon0] enabled
> 2023-01-13T04:30:57 [    3.379541] usb 1-6: New USB device strings: Mfr=
=3D1, Product=3D2, SerialNumber=3D3
> 2023-01-13T04:30:57 [    3.383898] netconsole: network logging started
> 2023-01-13T04:30:57 [    3.391022] usb 1-6: Product: Cruzer Blade
> 2023-01-13T04:30:57 [    3.393286] tsc: Refined TSC clocksource calibrati=
on: 2999.967 MHz
> 2023-01-13T04:30:57 [    3.393290] clocksource: tsc: mask: 0xffffffffffff=
ffff max_cycles: 0x2b3e261bc34, max_idle_ns: 440795261167 ns
> 2023-01-13T04:30:57 [    3.415809] usb 1-6: Manufacturer: SanDisk
> 2023-01-13T04:30:57 [    3.419907] usb 1-6: SerialNumber: 20042103220284D=
0CB42
> 2023-01-13T04:30:57 [    3.425137] clocksource: Switched to clocksource t=
sc
> 2023-01-13T04:30:57 [    3.426141] usb-storage 1-6:1.0: USB Mass Storage =
device detected
> 2023-01-13T04:30:57 [    3.436521] scsi host8: usb-storage 1-6:1.0
> 2023-01-13T04:30:57 [    3.554432] usb 1-14: new high-speed USB device nu=
mber 3 using xhci_hcd
> 2023-01-13T04:30:57 [    3.687893] usb 1-14: New USB device found, idVend=
or=3D0557, idProduct=3D7000, bcdDevice=3D 0.00
> 2023-01-13T04:30:57 [    3.696194] usb 1-14: New USB device strings: Mfr=
=3D0, Product=3D0, SerialNumber=3D0
> 2023-01-13T04:30:57 [    3.705172] hub 1-14:1.0: USB hub found
> 2023-01-13T04:30:57 [    3.709202] hub 1-14:1.0: 4 ports detected
> 2023-01-13T04:30:57 [    4.005425] usb 1-14.1: new low-speed USB device n=
umber 4 using xhci_hcd
> 2023-01-13T04:30:57 [    4.117348] usb 1-14.1: New USB device found, idVe=
ndor=3D0557, idProduct=3D2419, bcdDevice=3D 1.00
> 2023-01-13T04:30:57 [    4.125801] usb 1-14.1: New USB device strings: Mf=
r=3D0, Product=3D0, SerialNumber=3D0
> 2023-01-13T04:30:57 [    4.140645] input: HID 0557:2419 as /devices/pci00=
00:00/0000:00:14.0/usb1/1-14/1-14.1/1-14.1:1.0/0003:0557:2419.0001/input/in=
put3
> 2023-01-13T04:30:58 [    4.205048] hid-generic 0003:0557:2419.0001: input=
,hidraw0: USB HID v1.00 Keyboard [HID 0557:2419] on usb-0000:00:14.0-14.1/i=
nput0
> 2023-01-13T04:30:58 [    4.218431] input: HID 0557:2419 as /devices/pci00=
00:00/0000:00:14.0/usb1/1-14/1-14.1/1-14.1:1.1/0003:0557:2419.0002/input/in=
put4
> 2023-01-13T04:30:58 [    4.230503] hid-generic 0003:0557:2419.0002: input=
,hidraw1: USB HID v1.00 Mouse [HID 0557:2419] on usb-0000:00:14.0-14.1/inpu=
t1
> 2023-01-13T04:30:58 [    4.482040] scsi 8:0:0:0: Direct-Access     SanDis=
k  Cruzer Blade     1.00 PQ: 0 ANSI: 6
> 2023-01-13T04:30:58 [    4.492945] sd 8:0:0:0: Attached scsi generic sg1 =
type 0
> 2023-01-13T04:30:58 [    4.498775] sd 8:0:0:0: [sdb] 30595072 512-byte lo=
gical blocks: (15.7 GB/14.6 GiB)
> 2023-01-13T04:30:58 [    4.508178] sd 8:0:0:0: [sdb] Write Protect is off
> 2023-01-13T04:30:58 [    4.513770] sd 8:0:0:0: [sdb] Write cache: disable=
d, read cache: enabled, doesn't support DPO or FUA
> 2023-01-13T04:30:58 [    4.527531]  sdb: sdb3 sdb4
> 2023-01-13T04:30:58 [    4.530518] sd 8:0:0:0: [sdb] Attached SCSI remova=
ble disk
> 2023-01-13T04:31:00 [    6.279091] igb 0000:01:00.0 eth0: igb: eth0 NIC L=
ink is Up 1000 Mbps Full Duplex, Flow Control: RX
> 2023-01-13T04:31:00 [    6.288551] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: l=
ink becomes ready
> 2023-01-13T04:31:09 [    6.306446] Sending DHCP requests ..., OK
> 2023-01-13T04:31:09 [   15.462477] IP-Config: Got DHCP answer from 10.66.=
16.15, my address is 10.66.27.116
> 2023-01-13T04:31:09 [   15.470168] IP-Config: Complete:
> 2023-01-13T04:31:09 [   15.473404]      device=3Deth0, hwaddr=3Dac:1f:6b:=
1a:b3:4e, ipaddr=3D10.66.27.116, mask=3D255.255.240.0, gw=3D10.66.16.1
> 2023-01-13T04:31:09 [   15.483421]      host=3D10.66.27.116, domain=3Dlkf=
tlab, nis-domain=3D(none)
> 2023-01-13T04:31:09 [   15.489876]      bootserver=3D0.0.0.0, rootserver=
=3D10.66.16.124, rootpath=3D
> 2023-01-13T04:31:09 [   15.489877]      nameserver0=3D10.66.16.10
> 2023-01-13T04:31:09 [   15.529269] cfg80211: Loading compiled-in X.509 ce=
rtificates for regulatory database
> 2023-01-13T04:31:09 [   15.537710] cfg80211: Loaded X.509 cert 'sforshee:=
 00b28ddf47aef9cea7'
> 2023-01-13T04:31:09 [   15.544300] platform regulatory.0: Direct firmware=
 load for regulatory.db failed with error -2
> 2023-01-13T04:31:09 [   15.545394] ALSA device list:
> 2023-01-13T04:31:09 [   15.552920] cfg80211: failed to load regulatory.db
> 2023-01-13T04:31:09 [   15.560728]   No soundcards found.
> 2023-01-13T04:31:09 [   15.564380] md: Waiting for all devices to be avai=
lable before autodetect
> 2023-01-13T04:31:09 [   15.571186] md: If you don't use raid, use raid=3D=
noautodetect
> 2023-01-13T04:31:09 [   15.576836] md: Autodetecting RAID arrays.
> 2023-01-13T04:31:09 [   15.580953] md: autorun ...
> 2023-01-13T04:31:09 [   15.583770] md: ... autorun DONE.
> 2023-01-13T04:31:09 [   15.665422] VFS: Mounted root (nfs filesystem) on =
device 0:17.
> 2023-01-13T04:31:09 [   15.672273] devtmpfs: mounted
> 2023-01-13T04:31:09 [   15.676342] Freeing unused kernel image (initmem) =
memory: 3624K
> 2023-01-13T04:31:09 [   15.684349] Write protecting the kernel read-only =
data: 30720k
> 2023-01-13T04:31:09 [   15.690412] Freeing unused kernel image (rodata/da=
ta gap) memory: 172K
> 2023-01-13T04:31:09 [   15.743593] x86/mm: Checked W+X mappings: passed, =
no W+X pages found.
> 2023-01-13T04:31:09 [   15.750037] x86/mm: Checking user space page tables
> 2023-01-13T04:31:09 [   15.799837] x86/mm: Checked W+X mappings: passed, =
no W+X pages found.
> 2023-01-13T04:31:09 [   15.806286] Run /sbin/init as init process
> 2023-01-13T04:31:09 [   15.945626] BUG: kernel NULL pointer dereference, =
address: 0000000000000008
> 2023-01-13T04:31:09 [   15.952588] #PF: supervisor read access in kernel =
mode
> 2023-01-13T04:31:09 [   15.957720] #PF: error_code(0x0000) - not-present =
page
> 2023-01-13T04:31:09 [   15.962850] PGD 8000000103213067 P4D 8000000103213=
067 PUD 103212067 PMD 0=20
> 2023-01-13T04:31:09 [   15.969724] Oops: 0000 [#1] PREEMPT SMP PTI
> 2023-01-13T04:31:09 [   15.973909] CPU: 3 PID: 1 Comm: init Not tainted 6=
=2E2.0-rc3-next-20230113 #1
> 2023-01-13T04:31:09 [   15.980869] Hardware name: Supermicro SYS-5019S-ML=
/X11SSH-F, BIOS 2.0b 07/27/2017
> 2023-01-13T04:31:09 [   15.988336] RIP: 0010:do_wp_page+0x236/0xef0
> 2023-01-13T04:31:09 [   15.992611] Code: 83 ea 01 49 89 d7 48 85 d2 0f 85=
 00 ff ff ff 49 8b 7c 24 60 e8 0b f2 e9 00 41 8b 44 24 28 4d 8b 74 24 50 4d=
 8b 2c 24 89 45 88 <49> 8b 46 08 49 8b 5d 10 a8 01 0f 85 78 02 00 00 0f 1f =
44 00 00 4c
> 2023-01-13T04:31:09 [   16.011356] RSP: 0000:ffffb3f640027d18 EFLAGS: 000=
10286
> 2023-01-13T04:31:09 [   16.016583] RAX: 0000000000000a55 RBX: 04000000000=
00080 RCX: 0000000000000000
> 2023-01-13T04:31:09 [   16.023715] RDX: 0000000000000000 RSI: ffffffff8d3=
d2bd5 RDI: ffffffff8e271dfa
> 2023-01-13T04:31:09 [   16.030838] RBP: ffffb3f640027db0 R08: 8000000432e=
e9225 R09: ffff8ac3431e3100
> 2023-01-13T04:31:09 [   16.037962] R10: 0000000000000000 R11: 00007fe169f=
2f598 R12: ffffb3f640027de0
> 2023-01-13T04:31:09 [   16.045087] R13: ffff8ac3431e2000 R14: 00000000000=
00000 R15: 0400000000000000
> 2023-01-13T04:31:09 [   16.052211] FS:  00007fe16973e800(0000) GS:ffff8ac=
69fd80000(0000) knlGS:0000000000000000
> 2023-01-13T04:31:09 [   16.060319] CS:  0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
> 2023-01-13T04:31:09 [   16.066060] CR2: 0000000000000008 CR3: 00000001008=
d4002 CR4: 00000000003706e0
> 2023-01-13T04:31:09 [   16.073183] DR0: 0000000000000000 DR1: 00000000000=
00000 DR2: 0000000000000000
> 2023-01-13T04:31:09 [   16.080322] DR3: 0000000000000000 DR6: 00000000fff=
e0ff0 DR7: 0000000000000400
> 2023-01-13T04:31:09 [   16.087446] Call Trace:
> 2023-01-13T04:31:09 [   16.089893]  <TASK>
> 2023-01-13T04:31:09 [   16.091991]  ? trace_preempt_off+0x2d/0xd0
> 2023-01-13T04:31:09 [   16.096087]  ? __handle_mm_fault+0x7ee/0x12f0
> 2023-01-13T04:31:09 [   16.100439]  __handle_mm_fault+0xabf/0x12f0
> 2023-01-13T04:31:09 [   16.104617]  handle_mm_fault+0xf8/0x320
> 2023-01-13T04:31:09 [   16.108457]  do_user_addr_fault+0x1d9/0x650
> 2023-01-13T04:31:09 [   16.112642]  exc_page_fault+0x6b/0x170
> 2023-01-13T04:31:09 [   16.116394]  asm_exc_page_fault+0x2b/0x30
> 2023-01-13T04:31:09 [   16.120408] RIP: 0033:0x7fe169dbf31e
> 2023-01-13T04:31:09 [   16.123986] Code: ba ff ff ff ff 0f 9f c0 0f b6 c0=
 0f 4c c2 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 54 31 c0 ba ff ff ff=
 ff 53 48 83 ec 08 <f0> 0f b1 15 72 02 17 00 83 f8 ff 74 35 41 89 c4 85 c0 =
75 21 31 c0
> 2023-01-13T04:31:09 [   16.142724] RSP: 002b:00007ffcd0edec80 EFLAGS: 000=
10202
> 2023-01-13T04:31:09 [   16.147948] RAX: 0000000000000000 RBX: 00000000000=
00000 RCX: 0000000000555bd8
> 2023-01-13T04:31:09 [   16.155074] RDX: 00000000ffffffff RSI: 00007ffcd0e=
defa8 RDI: 0000000000000001
> 2023-01-13T04:31:09 [   16.162198] RBP: 00007ffcd0edefa8 R08: 00007fe169b=
c5a10 R09: 00007fe169f37a10
> 2023-01-13T04:31:09 [   16.169319] R10: 00007fe169adf3ee R11: 00000000000=
00246 R12: 00007ffcd0edefa8
> 2023-01-13T04:31:09 [   16.176445] R13: 000000000041b9a0 R14: 00000000005=
55bd8 R15: 00007fe169f69000
> 2023-01-13T04:31:09 [   16.183569]  </TASK>
> 2023-01-13T04:31:09 [   16.185752] Modules linked in:
> 2023-01-13T04:31:09 [   16.188803] CR2: 0000000000000008
> 2023-01-13T04:31:09 [   16.192114] ---[ end trace 0000000000000000 ]---
> 2023-01-13T04:31:09 [   16.196723] RIP: 0010:do_wp_page+0x236/0xef0
> 2023-01-13T04:31:09 Setting prompt string to ['-\\[ cut here \\]', 'Unhan=
dled fault', 'BUG: KCSAN:', 'BUG: KASAN:', 'BUG: KFENCE:', 'Oops(?: -|:)', =
'WARNING:', '(kernel BUG at|BUG:)', 'invalid opcode:', 'Kernel panic - not =
syncing', 'root@intel-corei7-64:', 'root@(.*):[/~]#', 'login:', 'Login inco=
rrect']
> 2023-01-13T04:31:09 login-action: kernel 'warning'
> 2023-01-13T04:31:09 [login-action] Waiting for messages, (timeout 00:13:2=
3)
> 2023-01-13T04:31:10 [   16.200986] Code: 83 ea 01 49 89 d7 48 85 d2 0f 85=
 00 ff ff ff 49 8b 7c 24 60 e8 0b f2 e9 00 41 8b 44 24 28 4d 8b 74 24 50 4d=
 8b 2c 24 89 45 88 <49> 8b 46 08 49 8b 5d 10 a8 01 0f 85 78 02 00 00 0f 1f =
44 00 00 4c
> 2023-01-13T04:31:10 [   16.219724] RSP: 0000:ffffb3f640027d18 EFLAGS: 000=
10286
> 2023-01-13T04:31:10 [   16.224943] RAX: 0000000000000a55 RBX: 04000000000=
00080 RCX: 0000000000000000
> 2023-01-13T04:31:10 [   16.232065] RDX: 0000000000000000 RSI: ffffffff8d3=
d2bd5 RDI: ffffffff8e271dfa
> 2023-01-13T04:31:10 [   16.239197] RBP: ffffb3f640027db0 R08: 8000000432e=
e9225 R09: ffff8ac3431e3100
> 2023-01-13T04:31:10 [   16.246324] R10: 0000000000000000 R11: 00007fe169f=
2f598 R12: ffffb3f640027de0
> 2023-01-13T04:31:10 [   16.253447] R13: ffff8ac3431e2000 R14: 00000000000=
00000 R15: 0400000000000000
> 2023-01-13T04:31:10 [   16.260571] FS:  00007fe16973e800(0000) GS:ffff8ac=
69fd80000(0000) knlGS:0000000000000000
> 2023-01-13T04:31:10 [   16.268646] CS:  0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
> 2023-01-13T04:31:10 [   16.274384] CR2: 0000000000000008 CR3: 00000001008=
d4002 CR4: 00000000003706e0
> 2023-01-13T04:31:10 [   16.281510] DR0: 0000000000000000 DR1: 00000000000=
00000 DR2: 0000000000000000
> 2023-01-13T04:31:10 [   16.288641] DR3: 0000000000000000 DR6: 00000000fff=
e0ff0 DR7: 0000000000000400
> 2023-01-13T04:31:10 Matched prompt #9: Kernel panic - not syncing
> 2023-01-13T04:31:10 Setting prompt string to ['end Kernel panic[^\\r]*\\r=
\\n', 'root@intel-corei7-64:', 'root@(.*):[/~]#', 'login:', 'Login incorrec=
t']
> 2023-01-13T04:31:10 [   16.295799] Kernel panic - not syncing: Attempted =
to kill init! exitcode=3D0x00000009
> 2023-01-13T04:31:10 [   16.303496] Kernel Offset: 0xc000000 from 0xffffff=
ff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 2023-01-13T04:31:10 [   16.314190] ---[ end Kernel panic - not syncing: A=
ttempted to kill init! exitcode=3D0x00000009 ]---
> 2023-01-13T04:31:10 Setting prompt string to ['-\\[ cut here \\]', 'Unhan=
dled fault', 'BUG: KCSAN:', 'BUG: KASAN:', 'BUG: KFENCE:', 'Oops(?: -|:)', =
'WARNING:', '(kernel BUG at|BUG:)', 'invalid opcode:', 'Kernel panic - not =
syncing', 'root@intel-corei7-64:', 'root@(.*):[/~]#', 'login:', 'Login inco=
rrect']
> 2023-01-13T04:31:10 login-action kernel 'panic'
> 2023-01-13T04:31:10 {'case': 'kernel-messages', 'definition': 'lava', 'du=
ration': '17.38', 'extra': {'extra': [{'kind': 'warning', 'message': '[    =
1.400214] RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable to=
 RETBleed attacks, data leaks possible!\r\n[    1.401214] RETBleed: Vulnera=
ble\r\n[    1.402214] Speculative Store Bypass: Vulnerable\r\n[    1.403220=
] MDS: Vulnerable: Clear CPU buffers attempted, no microcode\r\n[    1.4042=
14] TAA: Vulnerable: Clear CPU buffers attempted, no microcode\r\n[    1.40=
5214] MMIO Stale Data: Vulnerable: Clear CPU buffers attempted, no microcod=
e\r\n[    1.406214] SRBDS: Vulnerable: No microcode\r\n[    1.430344] Freei=
ng SMP alternatives memory: 52K\r\n[    1.432275] smpboot: CPU0: Intel(R) X=
eon(R) CPU E3-1220 v6 @ 3.00GHz (family: 0x6, model: 0x9e, stepping: 0x9)\r=
\n[    1.433327] cblist_init_generic: Setting adjustable number of callback=
 queues.\r\n[    1.434215] cblist_init_generic: Setting shift to 2 and lim =
to 1.\r\n[    1.435227] cblist_init_generic: Setting shift to 2 and lim to =
1.\r\n[    1.436227] Performance Events: PEBS fmt3+, Skylake events, 32-dee=
p LBR, full-width counters, Intel PMU driver.\r\n[    1.437215] ... version=
:                4\r\n[    1.438214] ... bit width:              48\r\n[   =
 1.439214] ... generic registers:      8\r\n[    1.440214] ... value mask: =
            0000ffffffffffff\r\n[    1.441214] ... max period:             =
00007fffffffffff\r\n[    1.442214] ... fixed-purpose events:   3\r\n[    1.=
443214] ... event mask:             00000007000000ff\r\n[    1.444338] Esti=
mated ratio of average max frequency by base frequency (times 1024): 1126\r=
\n[    1.445230] rcu: Hierarchical SRCU implementation.\r\n[    1.446214] r=
cu: \tMax phase no-delay instances is 400.\r\n[    1.447456] smp: Bringing =
up secondary CPUs ...\r\n[    1.448283] x86: Booting SMP configuration:\r\n=
[    1.449215] .... node  #0, CPUs:      #1 #2 #3\r\n[    1.450634] smp: Br=
ought up 1 node, 4 CPUs\r\n[    1.452214] smpboot: Max logical packages: 1\=
r\n[    1.453214] smpboot: Total of 4 processors activated (24000.00 BogoMI=
PS)\r\n[    1.455538] devtmpfs: initialized\r\n[    1.456363] ACPI: PM: Reg=
istering ACPI NVS region [mem 0x88767000-0x88767fff] (4096 bytes)\r\n[    1=
=2E457215] ACPI: PM: Registering ACPI NVS region [mem 0x8d11f000-0x8d891fff=
] (7811072 bytes)\r\n[    1.458325] clocksource: jiffies: mask: 0xffffffff =
max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns\r\n[    1.459216] =
futex hash table entries: 1024 (order: 4, 65536 bytes, linear)\r\n[    1.46=
0385] PM: RTC time: 04:30:54, date: 2023-01-13\r\n[    1.461276] NET: Regis=
tered PF_NETLINK/PF_ROUTE protocol family\r\n[    1.462290] audit: initiali=
zing netlink subsys (disabled)\r\n[    1.463232] audit: type=3D2000 audit(1=
673584252.085:1): state=3Dinitialized audit_enabled=3D0 res=3D1\r\n[    1.4=
63277] thermal_sys: Registered thermal governor \'step_wise\'\r\n[    1.464=
215] thermal_sys: Registered thermal governor \'user_space\'\r\n[    1.4652=
23] cpuidle: using governor menu\r\n[    1.475303] PCI: MMCONFIG for domain=
 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)\r\n[    =
1.484216] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as E820 ent=
ry\r\n[    1.491222] PCI: Using configuration type 1 for base access\r\n[  =
  1.497321] ENERGY_PERF_BIAS: Set to \'normal\', was \'performance\'\r\n[  =
  1.498243] kprobes: kprobe jump-optimization is enabled. All kprobes are o=
ptimized if possible.\r\n[    1.499240] HugeTLB: registered 2.00 MiB page s=
ize, pre-allocated 0 pages\r\n[    1.500215] HugeTLB: 28 KiB vmemmap can be=
 freed for a 2.00 MiB page\r\n[    1.501250] cryptd: max_cpu_qlen set to 10=
00\r\n[    1.502281] ACPI: Added _OSI(Module Device)\r\n[    1.503216] ACPI=
: Added _OSI(Processor Device)\r\n[    1.504214] ACPI: Added _OSI(3.0 _SCP =
Extensions)\r\n[    1.505214] ACPI: Added _OSI(Processor Aggregator Device)=
\r\n[    1.529435] ACPI: 7 ACPI AML tables successfully acquired and loaded=
\r\n[    1.533265] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored\r\n=
[    1.536216] ACPI: Dynamic OEM Table Load:\r\n[    1.539907] ACPI: Dynami=
c OEM Table Load:\r\n[    1.540219] ACPI: SSDT 0xFFFF8AC34098A800 000660 (v=
02 PmRef  Cpu0Ist  00003000 INTL 20120913)\r\n[    1.542694] ACPI: \\_PR_.C=
PU0: _OSC native thermal LVT Acked\r\n[    1.544381] ACPI: Dynamic OEM Tabl=
e Load:\r\n[    1.545217] ACPI: SSDT 0xFFFF8AC340354800 00037F (v02 PmRef  =
Cpu0Cst  00003001 INTL 20120913)\r\n[    1.548237] ACPI: Dynamic OEM Table =
Load:\r\n[    1.549223] ACPI: SSDT 0xFFFF8AC34098B800 0005AA (v02 PmRef  Ap=
Ist    00003000 INTL 20120913)\r\n[    1.551871] ACPI: Dynamic OEM Table Lo=
ad:\r\n[    1.552216] ACPI: SSDT 0xFFFF8AC34084B600 000119 (v02 PmRef  ApCs=
t    00003000 INTL 20120913)\r\n[    1.557169] ACPI: Interpreter enabled\r\=
n[    1.557241] ACPI: PM: (supports S0 S4 S5)\r\n[    1.558220] ACPI: Using=
 IOAPIC for interrupt routing\r\n[    1.559243] PCI: Using host bridge wind=
ows from ACPI; if necessary, use "pci=3Dnocrs" and report a bug\r\n[    1.5=
60214] PCI: Using E820 reservations for host bridge windows\r\n[    1.56197=
7] ACPI: Enabled 8 GPEs in block 00 to 7F\r\n[    1.564212] ACPI: \\_SB_.PC=
I0.PEG0.PG00: New power resource\r\n[    1.564689] ACPI: \\_SB_.PCI0.PEG1.P=
G01: New power resource\r\n[    1.565490] ACPI: \\_SB_.PCI0.PEG2.PG02: New =
power resource\r\n[    1.568791] ACPI: \\_SB_.PCI0.RP09.PXSX.WRST: New powe=
r resource\r\n[    1.569550] ACPI: \\_SB_.PCI0.RP10.PXSX.WRST: New power re=
source\r\n[    1.570467] ACPI: \\_SB_.PCI0.RP11.PXSX.WRST: New power resour=
ce\r\n[    1.571468] ACPI: \\_SB_.PCI0.RP12.PXSX.WRST: New power resource\r=
\n[    1.572466] ACPI: \\_SB_.PCI0.RP13.PXSX.WRST: New power resource\r\n[ =
   1.573465] ACPI: \\_SB_.PCI0.RP01.PXSX.WRST: New power resource\r\n[    1=
=2E574509] ACPI: \\_SB_.PCI0.RP02.PXSX.WRST: New power resource\r\n[    1.5=
75488] ACPI: \\_SB_.PCI0.RP03.PXSX.WRST: New power resource\r\n[    1.57648=
9] ACPI: \\_SB_.PCI0.RP04.PXSX.WRST: New power resource\r\n[    1.577488] A=
CPI: \\_SB_.PCI0.RP05.PXSX.WRST: New power resource\r\n[    1.578465] ACPI:=
 \\_SB_.PCI0.RP06.PXSX.WRST: New power resource\r\n[    1.579464] ACPI: \\_=
SB_.PCI0.RP07.PXSX.WRST: New power resource\r\n[    1.580510] ACPI: \\_SB_.=
PCI0.RP08.PXSX.WRST: New power resource\r\n[    1.581657] ACPI: \\_SB_.PCI0=
=2ERP17.PXSX.WRST: New power resource\r\n[    1.582549] ACPI: \\_SB_.PCI0.R=
P18.PXSX.WRST: New power resource\r\n[    1.583478] ACPI: \\_SB_.PCI0.RP19.=
PXSX.WRST: New power resource\r\n[    1.584480] ACPI: \\_SB_.PCI0.RP20.PXSX=
=2EWRST: New power resource\r\n[    1.585478] ACPI: \\_SB_.PCI0.RP14.PXSX.W=
RST: New power resource\r\n[    1.586469] ACPI: \\_SB_.PCI0.RP15.PXSX.WRST:=
 New power resource\r\n[    1.587465] ACPI: \\_SB_.PCI0.RP16.PXSX.WRST: New=
 power resource\r\n[    1.596917] ACPI: \\_TZ_.FN00: New power resource\r\n=
[    1.597287] ACPI: \\_TZ_.FN01: New power resource\r\n[    1.598285] ACPI=
: \\_TZ_.FN02: New power resource\r\n[    1.599285] ACPI: \\_TZ_.FN03: New =
power resource\r\n[    1.600283] ACPI: \\_TZ_.FN04: New power resource\r\n[=
    1.602474] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])\r\n[  =
  1.603218] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM=
 Segments MSI HPX-Type3]\r\n[    1.605253] acpi PNP0A08:00: _OSC: OS now co=
ntrols [PME PCIeCapability LTR]\r\n[    1.607085] PCI host bridge to bus 00=
00:00\r\n[    1.607215] pci_bus 0000:00: root bus resource [io  0x0000-0x0c=
f7 window]\r\n[    1.608214] pci_bus 0000:00: root bus resource [io  0x0d00=
-0xffff window]\r\n[    1.609214] pci_bus 0000:00: root bus resource [mem 0=
x000a0000-0x000bffff window]\r\n[    1.610214] pci_bus 0000:00: root bus re=
source [mem 0x90000000-0xdfffffff window]\r\n[    1.611214] pci_bus 0000:00=
: root bus resource [mem 0xfd000000-0xfe7fffff window]\r\n[    1.612214] pc=
i_bus 0000:00: root bus resource [bus 00-fe]\r\n[    1.613299] pci 0000:00:=
00.0: [8086:5918] type 00 class 0x060000\r\n[    1.614372] pci 0000:00:13.0=
: [8086:a135] type 00 class 0x000000\r\n[    1.615232] pci 0000:00:13.0: re=
g 0x10: [mem 0xdf322000-0xdf322fff 64bit]\r\n[    1.616477] pci 0000:00:14.=
0: [8086:a12f] type 00 class 0x0c0330\r\n[    1.617229] pci 0000:00:14.0: r=
eg 0x10: [mem 0xdf300000-0xdf30ffff 64bit]\r\n[    1.618277] pci 0000:00:14=
=2E0: PME# supported from D3hot D3cold\r\n[    1.619746] pci 0000:00:14.2: =
[8086:a131] type 00 class 0x118000\r\n[    1.620229] pci 0000:00:14.2: reg =
0x10: [mem 0xdf321000-0xdf321fff 64bit]\r\n[    1.621410] pci 0000:00:16.0:=
 [8086:a13a] type 00 class 0x078000\r\n[    1.622248] pci 0000:00:16.0: reg=
 0x10: [mem 0xdf320000-0xdf320fff 64bit]\r\n[    1.623344] pci 0000:00:16.0=
: PME# supported from D3hot\r\n[    1.624337] pci 0000:00:16.1: [8086:a13b]=
 type 00 class 0x078000\r\n[    1.625248] pci 0000:00:16.1: reg 0x10: [mem =
0xdf31f000-0xdf31ffff 64bit]\r\n[    1.626344] pci 0000:00:16.1: PME# suppo=
rted from D3hot\r\n[    1.627340] pci 0000:00:17.0: [8086:a102] type 00 cla=
ss 0x010601\r\n[    1.628224] pci 0000:00:17.0: reg 0x10: [mem 0xdf310000-0=
xdf311fff]\r\n[    1.629219] pci 0000:00:17.0: reg 0x14: [mem 0xdf31e000-0x=
df31e0ff]\r\n[    1.630219] pci 0000:00:17.0: reg 0x18: [io  0xf050-0xf057]=
\r\n[    1.631219] pci 0000:00:17.0: reg 0x1c: [io  0xf040-0xf043]\r\n[    =
1.632219] pci 0000:00:17.0: reg 0x20: [io  0xf020-0xf03f]\r\n[    1.633219]=
 pci 0000:00:17.0: reg 0x24: [mem 0xdf31d000-0xdf31d7ff]\r\n[    1.634252] =
pci 0000:00:17.0: PME# supported from D3hot\r\n[    1.635456] pci 0000:00:1=
c.0: [8086:a110] type 01 class 0x060400\r\n[    1.636293] pci 0000:00:1c.0:=
 PME# supported from D0 D3hot D3cold\r\n[    1.637628] pci 0000:00:1c.1: [8=
086:a111] type 01 class 0x060400\r\n[    1.638292] pci 0000:00:1c.1: PME# s=
upported from D0 D3hot D3cold\r\n[    1.639629] pci 0000:00:1c.6: [8086:a11=
6] type 01 class 0x060400\r\n[    1.640280] pci 0000:00:1c.6: PME# supporte=
d from D0 D3hot D3cold\r\n[    1.641619] pci 0000:00:1f.0: [8086:a149] type=
 00 class 0x060100\r\n[    1.642555] pci 0000:00:1f.2: [8086:a121] type 00 =
class 0x058000\r\n[    1.643227] pci 0000:00:1f.2: reg 0x10: [mem 0xdf31800=
0-0xdf31bfff]\r\n[    1.644483] pci 0000:00:1f.4: [8086:a123] type 00 class=
 0x0c0500\r\n[    1.645269] pci 0000:00:1f.4: reg 0x10: [mem 0xdf31c000-0xd=
f31c0ff 64bit]\r\n[    1.646282] pci 0000:00:1f.4: reg 0x20: [io  0xf000-0x=
f01f]\r\n[    1.647537] pci 0000:01:00.0: working around ROM BAR overlap de=
fect\r\n[    1.648215] pci 0000:01:00.0: [8086:1533] type 00 class 0x020000=
\r\n[    1.649245] pci 0000:01:00.0: reg 0x10: [mem 0xdf200000-0xdf27ffff]\=
r\n[    1.650246] pci 0000:01:00.0: reg 0x18: [io  0xe000-0xe01f]\r\n[    1=
=2E651234] pci 0000:01:00.0: reg 0x1c: [mem 0xdf280000-0xdf283fff]\r\n[    =
1.652371] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold\r\n[    1.6=
53497] pci 0000:00:1c.0: PCI bridge to [bus 01]\r\n[    1.654216] pci 0000:=
00:1c.0:   bridge window [io  0xe000-0xefff]\r\n[    1.655215] pci 0000:00:=
1c.0:   bridge window [mem 0xdf200000-0xdf2fffff]\r\n[    1.656297] pci 000=
0:02:00.0: working around ROM BAR overlap defect\r\n[    1.657214] pci 0000=
:02:00.0: [8086:1533] type 00 class 0x020000\r\n[    1.658244] pci 0000:02:=
00.0: reg 0x10: [mem 0xdf100000-0xdf17ffff]\r\n[    1.659246] pci 0000:02:0=
0.0: reg 0x18: [io  0xd000-0xd01f]\r\n[    1.660234] pci 0000:02:00.0: reg =
0x1c: [mem 0xdf180000-0xdf183fff]\r\n[    1.661370] pci 0000:02:00.0: PME# =
supported from D0 D3hot D3cold\r\n[    1.662495] pci 0000:00:1c.1: PCI brid=
ge to [bus 02]\r\n[    1.663216] pci 0000:00:1c.1:   bridge window [io  0xd=
000-0xdfff]\r\n[    1.664215] pci 0000:00:1c.1:   bridge window [mem 0xdf10=
0000-0xdf1fffff]\r\n[    1.665277] pci 0000:03:00.0: [1a03:1150] type 01 cl=
ass 0x060400\r\n[    1.666275] pci 0000:03:00.0: enabling Extended Tags\r\n=
[    1.667292] pci 0000:03:00.0: supports D1 D2\r\n[    1.668214] pci 0000:=
03:00.0: PME# supported from D0 D1 D2 D3hot D3cold\r\n[    1.669488] pci 00=
00:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with =
\'pcie_aspm=3Dforce\'\r\n[    1.670222] pci 0000:00:1c.6: PCI bridge to [bu=
s 03-04]\r\n[    1.671215] pci 0000:00:1c.6:   bridge window [io  0xc000-0x=
cfff]\r\n[    1.672215] pci 0000:00:1c.6:   bridge window [mem 0xde000000-0=
xdf0fffff]\r\n[    1.673258] pci_bus 0000:04: extended config space not acc=
essible\r\n[    1.674245] pci 0000:04:00.0: [1a03:2000] type 00 class 0x030=
000\r\n[    1.675234] pci 0000:04:00.0: reg 0x10: [mem 0xde000000-0xdefffff=
f]\r\n[    1.676225] pci 0000:04:00.0: reg 0x14: [mem 0xdf000000-0xdf01ffff=
]\r\n[    1.677225] pci 0000:04:00.0: reg 0x18: [io  0xc000-0xc07f]\r\n[   =
 1.678278] pci 0000:04:00.0: Video device with shadowed ROM at [mem 0x000c0=
000-0x000dffff]\r\n[    1.679254] pci 0000:04:00.0: supports D1 D2\r\n[    =
1.680216] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold\r\n[ =
   1.681320] pci 0000:03:00.0: PCI bridge to [bus 04]\r\n[    1.682220] pci=
 0000:03:00.0:   bridge window [io  0xc000-0xcfff]\r\n[    1.683217] pci 00=
00:03:00.0:   bridge window [mem 0xde000000-0xdf0fffff]\r\n[    1.686060] A=
CPI: PCI: Interrupt link LNKA configured for IRQ 11\r\n[    1.686277] ACPI:=
 PCI: Interrupt link LNKB configured for IRQ 10\r\n[    1.687274] ACPI: PCI=
: Interrupt link LNKC configured for IRQ 11\r\n[    1.688274] ACPI: PCI: In=
terrupt link LNKD configured for IRQ 11\r\n[    1.689275] ACPI: PCI: Interr=
upt link LNKE configured for IRQ 11\r\n[    1.690275] ACPI: PCI: Interrupt =
link LNKF configured for IRQ 11\r\n[    1.691270] ACPI: PCI: Interrupt link=
 LNKG configured for IRQ 11\r\n[    1.692273] ACPI: PCI: Interrupt link LNK=
H configured for IRQ 11\r\n[    1.698764] iommu: Default domain type: Trans=
lated \r\n[    1.699215] iommu: DMA domain TLB invalidation policy: lazy mo=
de \r\n[    1.700257] SCSI subsystem initialized\r\n[    1.701244] ACPI: bu=
s type USB registered\r\n[    1.702224] usbcore: registered new interface d=
river usbfs\r\n[    1.703218] usbcore: registered new interface driver hub\=
r\n[    1.704219] usbcore: registered new device driver usb\r\n[    1.70522=
4] mc: Linux media interface: v0.10\r\n[    1.706219] videodev: Linux video=
 capture interface: v2.00\r\n[    1.707217] pps_core: LinuxPPS API ver. 1 r=
egistered\r\n[    1.708214] pps_core: Software ver. 5.3.6 - Copyright 2005-=
2007 Rodolfo Giometti <giometti@linux.it>\r\n[    1.709215] PTP clock suppo=
rt registered\r\n[    1.710237] Advanced Linux Sound Architecture Driver In=
itialized.\r\n[    1.711378] NetLabel: Initializing\r\n[    1.712214] NetLa=
bel:  domain hash size =3D 128\r\n[    1.713214] NetLabel:  protocols =3D U=
NLABELED CIPSOv4 CALIPSO\r\n[    1.714227] NetLabel:  unlabeled traffic all=
owed by default\r\n[    1.715228] PCI: Using ACPI for IRQ routing\r\n[    1=
=2E744100] pci 0000:04:00.0: vgaarb: setting as boot VGA device\r\n[    1.7=
44213] pci 0000:04:00.0: vgaarb: bridge control possible\r\n[    1.744213] =
pci 0000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dio+mem,=
locks=3Dnone\r\n[    1.744215] vgaarb: loaded\r\n[    1.745255] hpet0: at M=
MIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0\r\n[    1.746214] hpet0: 8 comp=
arators, 64-bit 24.000000 MHz counter\r\n[    1.749241] clocksource: Switch=
ed to clocksource tsc-early\r\n[    1.754785] VFS: Disk quotas dquot_6.6.0\=
r\n[    1.758722] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 b=
ytes)\r\n[    1.765646] pnp: PnP ACPI init\r\n[    1.769016] system 00:00: =
[io  0x0a00-0x0a0f] has been reserved\r\n[    1.774949] system 00:00: [io  =
0x0a10-0x0a1f] has been reserved\r\n[    1.780866] system 00:00: [io  0x0a2=
0-0x0a2f] has been reserved\r\n[    1.786785] system 00:00: [io  0x0a30-0x0=
a3f] has been reserved\r\n[    1.792703] system 00:00: [io  0x0a40-0x0a4f] =
has been reserved\r\n[    1.799361] system 00:03: [io  0x0680-0x069f] has b=
een reserved\r\n[    1.805291] system 00:03: [io  0xffff] has been reserved=
\r\n[    1.810609] system 00:03: [io  0xffff] has been reserved\r\n[    1.8=
15920] system 00:03: [io  0xffff] has been reserved\r\n[    1.821225] syste=
m 00:03: [io  0x1800-0x18fe] has been reserved\r\n[    1.827144] system 00:=
03: [io  0x164e-0x164f] has been reserved\r\n[    1.833136] system 00:04: [=
io  0x0800-0x087f] has been reserved\r\n[    1.839116] system 00:06: [io  0=
x1854-0x1857] has been reserved\r\n[    1.845290] system 00:07: [mem 0xfed1=
0000-0xfed17fff] has been reserved\r\n[    1.851921] system 00:07: [mem 0xf=
ed18000-0xfed18fff] has been reserved\r\n[    1.858541] system 00:07: [mem =
0xfed19000-0xfed19fff] has been reserved\r\n[    1.865147] system 00:07: [m=
em 0xe0000000-0xefffffff] has been reserved\r\n[    1.871759] system 00:07:=
 [mem 0xfed20000-0xfed3ffff] has been reserved\r\n[    1.878371] system 00:=
07: [mem 0xfed90000-0xfed93fff] has been reserved\r\n[    1.884984] system =
00:07: [mem 0xfed45000-0xfed8ffff] has been reserved\r\n[    1.891595] syst=
em 00:07: [mem 0xff000000-0xffffffff] has been reserved\r\n[    1.898199] s=
ystem 00:07: [mem 0xfee00000-0xfeefffff] could not be reserved\r\n[    1.90=
5150] system 00:07: [mem 0xdffe0000-0xdfffffff] has been reserved\r\n[    1=
=2E911803] system 00:08: [mem 0xfd000000-0xfdabffff] has been reserved\r\n[=
    1.918418] system 00:08: [mem 0xfdad0000-0xfdadffff] has been reserved\r=
\n[    1.925031] system 00:08: [mem 0xfdb00000-0xfdffffff] has been reserve=
d\r\n[    1.931645] system 00:08: [mem 0xfe000000-0xfe01ffff] could not be =
reserved\r\n[    1.938605] system 00:08: [mem 0xfe036000-0xfe03bfff] has be=
en reserved\r\n[    1.945215] system 00:08: [mem 0xfe03d000-0xfe3fffff] has=
 been reserved\r\n[    1.951827] system 00:08: [mem 0xfe410000-0xfe7fffff] =
has been reserved\r\n[    1.958649] system 00:09: [io  0xff00-0xfffe] has b=
een reserved\r\n[    1.965425] system 00:0a: [mem 0xfdaf0000-0xfdafffff] ha=
s been reserved\r\n[    1.972048] system 00:0a: [mem 0xfdae0000-0xfdaeffff]=
 has been reserved\r\n[    1.978658] system 00:0a: [mem 0xfdac0000-0xfdacff=
ff] has been reserved\r\n[    1.985976] pnp: PnP ACPI: found 11 devices\r\n=
[    1.995942] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns\r\n[    2.004825] NET: Registered PF_INET protoco=
l family\r\n[    2.009834] IP idents hash table entries: 262144 (order: 9, =
2097152 bytes, linear)\r\n[    2.020017] tcp_listen_portaddr_hash hash tabl=
e entries: 8192 (order: 5, 131072 bytes, linear)\r\n[    2.028640] Table-pe=
rturb hash table entries: 65536 (order: 6, 262144 bytes, linear)\r\n[    2.=
036391] TCP established hash table entries: 131072 (order: 8, 1048576 bytes=
, linear)\r\n[    2.044577] TCP bind hash table entries: 65536 (order: 9, 2=
097152 bytes, linear)\r\n[    2.052212] TCP: Hash tables configured (establ=
ished 131072 bind 65536)\r\n[    2.058896] MPTCP token hash table entries: =
16384 (order: 6, 393216 bytes, linear)\r\n[    2.066503] UDP hash table ent=
ries: 8192 (order: 6, 262144 bytes, linear)\r\n[    2.073320] UDP-Lite hash=
 table entries: 8192 (order: 6, 262144 bytes, linear)\r\n[    2.080595] NET=
: Registered PF_UNIX/PF_LOCAL protocol family\r\n[    2.086324] RPC: Regist=
ered named UNIX socket transport module.\r\n[    2.092251] RPC: Registered =
udp transport module.\r\n[    2.096956] RPC: Registered tcp transport modul=
e.\r\n[    2.101659] RPC: Registered tcp NFSv4.1 backchannel transport modu=
le.\r\n[    2.108313] pci 0000:00:1c.0: PCI bridge to [bus 01]\r\n[    2.11=
3290] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]\r\n[    2.11938=
7] pci 0000:00:1c.0:   bridge window [mem 0xdf200000-0xdf2fffff]\r\n[    2.=
126175] pci 0000:00:1c.1: PCI bridge to [bus 02]\r\n[    2.131136] pci 0000=
:00:1c.1:   bridge window [io  0xd000-0xdfff]\r\n[    2.137231] pci 0000:00=
:1c.1:   bridge window [mem 0xdf100000-0xdf1fffff]\r\n[    2.144020] pci 00=
00:03:00.0: PCI bridge to [bus 04]\r\n[    2.148981] pci 0000:03:00.0:   br=
idge window [io  0xc000-0xcfff]\r\n[    2.155076] pci 0000:03:00.0:   bridg=
e window [mem 0xde000000-0xdf0fffff]\r\n[    2.161865] pci 0000:00:1c.6: PC=
I bridge to [bus 03-04]\r\n[    2.167083] pci 0000:00:1c.6:   bridge window=
 [io  0xc000-0xcfff]\r\n[    2.173176] pci 0000:00:1c.6:   bridge window [m=
em 0xde000000-0xdf0fffff]\r\n[    2.179967] pci_bus 0000:00: resource 4 [io=
  0x0000-0x0cf7 window]\r\n[    2.186142] pci_bus 0000:00: resource 5 [io  =
0x0d00-0xffff window]\r\n[    2.192320] pci_bus 0000:00: resource 6 [mem 0x=
000a0000-0x000bffff window]\r\n[    2.199194] pci_bus 0000:00: resource 7 [=
mem 0x90000000-0xdfffffff window]\r\n[    2.206064] pci_bus 0000:00: resour=
ce 8 [mem 0xfd000000-0xfe7fffff window]\r\n[    2.212929] pci_bus 0000:01: =
resource 0 [io  0xe000-0xefff]\r\n[    2.218500] pci_bus 0000:01: resource =
1 [mem 0xdf200000-0xdf2fffff]\r\n[    2.224760] pci_bus 0000:02: resource 0=
 [io  0xd000-0xdfff]\r\n[    2.230330] pci_bus 0000:02: resource 1 [mem 0xd=
f100000-0xdf1fffff]\r\n[    2.236589] pci_bus 0000:03: resource 0 [io  0xc0=
00-0xcfff]\r\n[    2.242160] pci_bus 0000:03: resource 1 [mem 0xde000000-0x=
df0fffff]\r\n[    2.248418] pci_bus 0000:04: resource 0 [io  0xc000-0xcfff]=
\r\n[    2.253989] pci_bus 0000:04: resource 1 [mem 0xde000000-0xdf0fffff]\=
r\n[    2.265143] PCI: CLS 0 bytes, default 64\r\n[    2.269081] DMAR: Host=
 address width 39\r\n[    2.272927] DMAR: DRHD base: 0x000000fed90000 flags=
: 0x1\r\n[    2.278244] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap d20=
08c40660462 ecap f050da\r\n[    2.286160] DMAR: RMRR base: 0x0000008ccae000=
 end: 0x0000008cccdfff\r\n[    2.292432] PCI-DMA: Using software bounce buf=
fering for IO (SWIOTLB)\r\n[    2.298873] software IO TLB: mapped [mem 0x00=
00000088ba1000-0x000000008cba1000] (64MB)\r\n[    2.306823] RAPL PMU: API u=
nit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer\r\n[    2.31474=
4] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules\r\n[    2.320487] RAPL=
 PMU: hw unit of domain package 2^-14 Joules\r\n[    2.326137] RAPL PMU: hw=
 unit of domain dram 2^-14 Joules\r\n[    2.335047] kvm: already loaded ven=
dor module \'kvm_intel\'\r\n[    2.341150] Initialise system trusted keyrin=
gs\r\n[    2.345632] workingset: timestamp_bits=3D40 max_order=3D22 bucket_=
order=3D0\r\n[    2.352182] NFS: Registering the id_resolver key type\r\n[ =
   2.357246] Key type id_resolver registered\r\n[    2.361438] Key type id_=
legacy registered\r\n[    2.365475] 9p: Installing v9fs 9p2000 file system =
support\r\n[    2.378638] NET: Registered PF_ALG protocol family\r\n[    2.=
383441] Key type asymmetric registered\r\n[    2.387538] Asymmetric key par=
ser \'x509\' registered\r\n[    2.392418] Block layer SCSI generic (bsg) dr=
iver version 0.4 loaded (major 250)\r\n[    2.399828] io scheduler mq-deadl=
ine registered\r\n[    2.404370] io scheduler kyber registered\r\n[    2.40=
8615] pcieport 0000:00:1c.0: PME: Signaling with IRQ 24\r\n[    2.414594] p=
cieport 0000:00:1c.1: PME: Signaling with IRQ 25\r\n[    2.420558] pcieport=
 0000:00:1c.6: PME: Signaling with IRQ 26\r\n[    2.426511] input: Sleep Bu=
tton as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0\r\n[    2.=
434891] ACPI: button: Sleep Button [SLPB]\r\n[    2.439288] input: Power Bu=
tton as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1\r\n[    2.=
447657] ACPI: button: Power Button [PWRB]\r\n[    2.452052] input: Power Bu=
tton as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2\r\n[    2.459481] ACP=
I: button: Power Button [PWRF]\r\n[    2.464189] ACPI: \\_PR_.CPU0: Found 3=
 idle states\r\n[    2.469065] ACPI: \\_PR_.CPU1: Found 3 idle states\r\n[ =
   2.473940] ACPI: \\_PR_.CPU2: Found 3 idle states\r\n[    2.478825] ACPI:=
 \\_PR_.CPU3: Found 3 idle states\r\n[    2.483994] thermal LNXTHERM:00: re=
gistered as thermal_zone0\r\n[    2.489667] ACPI: thermal: Thermal Zone [TZ=
00] (28 C)\r\n[    2.494838] thermal LNXTHERM:01: registered as thermal_zon=
e1\r\n[    2.500508] ACPI: thermal: Thermal Zone [TZ01] (30 C)\r\n[    2.50=
5653] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled\r\n[    2.511=
997] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550=
A\r\n[    2.519412] 00:02: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115=
200) is a 16550A\r\n[    2.527204] Non-volatile memory driver v1.3\r\n[    =
2.531406] Linux agpgart interface v0.103\r\n[    2.535629] ACPI: bus type d=
rm_connector registered\r\n[    2.541968] loop: module loaded\r\n[    2.555=
758] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SA=
TA mode\r\n[    2.563941] ahci 0000:00:17.0: flags: 64bit ncq sntf led clo =
only pio slum part ems deso sadm sds apst \r\n[    2.595156] scsi host0: ah=
ci\r\n[    2.598363] scsi host1: ahci\r\n[    2.601529] scsi host2: ahci\r\=
n[    2.604741] scsi host3: ahci\r\n[    2.607933] scsi host4: ahci\r\n[   =
 2.611111] scsi host5: ahci\r\n[    2.614226] scsi host6: ahci\r\n[    2.61=
7379] scsi host7: ahci\r\n[    2.620327] ata1: SATA max UDMA/133 abar m2048=
@0xdf31d000 port 0xdf31d100 irq 27\r\n[    2.627722] ata2: SATA max UDMA/13=
3 abar m2048@0xdf31d000 port 0xdf31d180 irq 27\r\n[    2.635114] ata3: SATA=
 max UDMA/133 abar m2048@0xdf31d000 port 0xdf31d200 irq 27\r\n[    2.642504=
] ata4: SATA max UDMA/133 abar m2048@0xdf31d000 port 0xdf31d280 irq 27\r\n[=
    2.649888] ata5: SATA max UDMA/133 abar m2048@0xdf31d000 port 0xdf31d300=
 irq 27\r\n[    2.657271] ata6: SATA max UDMA/133 abar m2048@0xdf31d000 por=
t 0xdf31d380 irq 27\r\n[    2.664656] ata7: SATA max UDMA/133 abar m2048@0x=
df31d000 port 0xdf31d400 irq 27\r\n[    2.672041] ata8: SATA max UDMA/133 a=
bar m2048@0xdf31d000 port 0xdf31d480 irq 27\r\n[    2.679742] e100: Intel(R=
) PRO/100 Network Driver\r\n[    2.684460] e100: Copyright(c) 1999-2006 Int=
el Corporation\r\n[    2.689959] e1000: Intel(R) PRO/1000 Network Driver\r\=
n[    2.694843] e1000: Copyright (c) 1999-2006 Intel Corporation.\r\n[    2=
=2E700595] e1000e: Intel(R) PRO/1000 Network Driver\r\n[    2.705571] e1000=
e: Copyright(c) 1999 - 2015 Intel Corporation.\r\n[    2.711498] igb: Intel=
(R) Gigabit Ethernet Network Driver\r\n[    2.716907] igb: Copyright (c) 20=
07-2014 Intel Corporation.\r\n[    2.750538] pps pps0: new PPS source ptp0\=
r\n[    2.754645] igb 0000:01:00.0: added PHC on eth0\r\n[    2.759193] igb=
 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection\r\n[    2.76606=
2] igb 0000:01:00.0: eth0: (PCIe:2.5Gb/s:Width x1) ac:1f:6b:1a:b3:4e\r\n[  =
  2.773242] igb 0000:01:00.0: eth0: PBA No: 012700-000\r\n[    2.778378] ig=
b 0000:01:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)\r\n[  =
  2.816488] pps pps1: new PPS source ptp1\r\n[    2.820594] igb 0000:02:00.=
0: added PHC on eth1\r\n[    2.825137] igb 0000:02:00.0: Intel(R) Gigabit E=
thernet Network Connection\r\n[    2.832013] igb 0000:02:00.0: eth1: (PCIe:=
2.5Gb/s:Width x1) ac:1f:6b:1a:b3:4f\r\n[    2.839205] igb 0000:02:00.0: eth=
1: PBA No: 012700-000\r\n[    2.844335] igb 0000:02:00.0: Using MSI-X inter=
rupts. 4 rx queue(s), 4 tx queue(s)\r\n[    2.851939] sky2: driver version =
1.30\r\n[    2.855629] QLogic FastLinQ 4xxxx Core Module qed\r\n[    2.8603=
45] qede init: QLogic FastLinQ 4xxxx Ethernet Driver qede\r\n[    2.866462]=
 usbcore: registered new interface driver asix\r\n[    2.871873] usbcore: r=
egistered new interface driver ax88179_178a\r\n[    2.877969] usbcore: regi=
stered new interface driver cdc_ether\r\n[    2.883810] usbcore: registered=
 new interface driver net1080\r\n[    2.889475] usbcore: registered new int=
erface driver cdc_subset\r\n[    2.895395] usbcore: registered new interfac=
e driver zaurus\r\n[    2.900967] usbcore: registered new interface driver =
cdc_ncm\r\n[    2.906630] usbcore: registered new interface driver r8153_ec=
m\r\n[    2.912606] usbcore: registered new interface driver usblp\r\n[    =
2.912777] xhci_hcd 0000:00:14.0: xHCI Host Controller\r\n[    2.918103] usb=
core: registered new interface driver usb-storage\r\n[    2.923418] xhci_hc=
d 0000:00:14.0: new USB bus registered, assigned bus number 1\r\n[    2.929=
361] i8042: PNP: No PS/2 controller found.\r\n[    2.937858] xhci_hcd 0000:=
00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810\=
r\n[    2.941747] rtc_cmos 00:05: RTC can wake from S4\r\n[    2.950994] xh=
ci_hcd 0000:00:14.0: xHCI Host Controller\r\n[    2.955966] rtc_cmos 00:05:=
 registered as rtc0\r\n[    2.960512] xhci_hcd 0000:00:14.0: new USB bus re=
gistered, assigned bus number 2\r\n[    2.964893] rtc_cmos 00:05: alarms up=
 to one month, y3k, 242 bytes nvram\r\n[    2.972254] xhci_hcd 0000:00:14.0=
: Host supports USB 3.0 SuperSpeed\r\n[    2.978966] fail to initialize ptp=
_kvm\r\n[    2.979147] i801_smbus 0000:00:1f.4: SPD Write Disable is set\r\=
n[    2.979201] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt\r\n[    =
2.979255] pci 0000:00:1f.1: [8086:a120] type 00 class 0x058000\r\n[    2.97=
9321] pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]\r\n[   =
 2.980530] i2c i2c-0: 2/4 memory slots populated (from DMI)\r\n[    2.98280=
2] ata2: SATA link down (SStatus 0 SControl 300)\r\n[    2.982902] ata4: SA=
TA link down (SStatus 0 SControl 300)\r\n[    2.983969] ata3: SATA link up =
6.0 Gbps (SStatus 133 SControl 300)\r\n[    2.985210] ata5: SATA link down =
(SStatus 0 SControl 300)\r\n[    2.985270] ata6: SATA link down (SStatus 0 =
SControl 300)\r\n[    2.985332] usb usb1: New USB device found, idVendor=3D=
1d6b, idProduct=3D0002, bcdDevice=3D 6.02\r\n[    2.985334] usb usb1: New U=
SB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1\r\n[    2.985335]=
 usb usb1: Product: xHCI Host Controller\r\n[    2.985337] usb usb1: Manufa=
cturer: Linux 6.2.0-rc3-next-20230113 xhci-hcd\r\n[    2.985338] usb usb1: =
SerialNumber: 0000:00:14.0\r\n[    2.985571] hub 1-0:1.0: USB hub found\r\n=
[    2.985604] hub 1-0:1.0: 16 ports detected\r\n[    2.987391] usb usb2: N=
ew USB device found, idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.02\r=
\n[    2.987394] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1\r\n[    2.987395] usb usb2: Product: xHCI Host Controller\r\=
n[    2.987396] usb usb2: Manufacturer: Linux 6.2.0-rc3-next-20230113 xhci-=
hcd\r\n[    2.987397] usb usb2: SerialNumber: 0000:00:14.0\r\n[    2.987478=
] hub 2-0:1.0: USB hub found\r\n[    2.987500] hub 2-0:1.0: 10 ports detect=
ed\r\n[    2.988211] usb: port power management may be unreliable\r\n[    2=
=2E995251] i2c i2c-0: Successfully instantiated SPD at 0x51\r\n[    3.00063=
3] ata7: SATA link down (SStatus 0 SControl 300)\r\n[    3.007167] i2c i2c-=
0: Successfully instantiated SPD at 0x53\r\n[    3.011328] kwatchdog (84) u=
sed greatest stack depth: 15624 bytes left\r\n[    3.013441] ata1: SATA lin=
k down (SStatus 0 SControl 300)\r\n[    3.013534] device-mapper: ioctl: 4.4=
7.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com\r\n[    3.013540] i=
ntel_pstate: Intel P-state driver initializing\r\n[    3.041506] intel_psta=
te: Disabling energy efficiency optimization\r\n[    3.046887] ata8: SATA l=
ink down (SStatus 0 SControl 300)\r\n[    3.055073] intel_pstate: HWP enabl=
ed\r\n[    3.055566] kworker/u8:1 (89) used greatest stack depth: 14392 byt=
es left\r\n[    3.062297] ata3.00: ATA-8: TOSHIBA MG03ACA100, FL1A, max UDM=
A/100\r\n[    3.067617] hid: raw HID events driver (C) Jiri Kosina\r\n[    =
3.074594] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA\r=
\n[    3.078752] usbcore: registered new interface driver usbhid\r\n[    3.=
083395] ata3.00: configured for UDMA/100\r\n[    3.086502] usbhid: USB HID =
core driver\r\n[    3.087089] Initializing XFRM netlink socket\r\n[    3.09=
4840] scsi 2:0:0:0: Direct-Access     ATA      TOSHIBA MG03ACA1 FL1A PQ: 0 =
ANSI: 5\r\n[    3.101993] NET: Registered PF_INET6 protocol family\r\n[    =
3.106975] scsi 2:0:0:0: Attached scsi generic sg0 type 0\r\n[    3.107064] =
sd 2:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)\r\n=
[    3.107129] sd 2:0:0:0: [sda] Write Protect is off\r\n[    3.107149] sd =
2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn\'t support =
DPO or FUA\r\n[    3.107171] sd 2:0:0:0: [sda] Preferred minimum I/O size 5=
12 bytes\r\n[    3.113947] Segment Routing with IPv6\r\n[    3.231252] usb =
1-6: new high-speed USB device number 2 using xhci_hcd\r\n[    3.232351] In=
-situ OAM (IOAM) with IPv6\r\n[    3.292643] sd 2:0:0:0: [sda] Attached SCS=
I disk\r\n[    3.292655] sit: IPv6, IPv4 and MPLS over IPv4 tunneling drive=
r\r\n[    3.303296] NET: Registered PF_PACKET protocol family\r\n[    3.308=
375] 9pnet: Installing 9P2000 support\r\n[    3.312702] Key type dns_resolv=
er registered\r\n[    3.317639] microcode: Microcode Update Driver: v2.2.\r=
\n[    3.317644] IPI shorthand broadcast: enabled\r\n[    3.327042] AVX2 ve=
rsion of gcm_enc/dec engaged.\r\n[    3.332261] AES CTR mode by8 optimizati=
on enabled\r\n[    3.339544] sched_clock: Marking stable (2035178977, 13040=
35566)->(4501291417, -1162076874)\r\n[    3.348097] registered taskstats ve=
rsion 1\r\n[    3.352222] Loading compiled-in X.509 certificates\r\n[    3.=
358696] PM:   Magic number: 7:843:514\r\n[    3.362776] platform ACPI000C:0=
0: hash matches\r\n[    3.367254] acpi ACPI000C:00: hash matches\r\n[    3.=
367898] usb 1-6: New USB device found, idVendor=3D0781, idProduct=3D5567, b=
cdDevice=3D 1.00\r\n[    3.371390] printk: console [netcon0] enabled\r\n[  =
  3.379541] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, SerialNu=
mber=3D3\r\n[    3.383898] netconsole: network logging started\r\n[    3.39=
1022] usb 1-6: Product: Cruzer Blade\r\n[    3.393286] tsc: Refined TSC clo=
cksource calibration: 2999.967 MHz\r\n[    3.393290] clocksource: tsc: mask=
: 0xffffffffffffffff max_cycles: 0x2b3e261bc34, max_idle_ns: 440795261167 n=
s\r\n[    3.415809] usb 1-6: Manufacturer: SanDisk\r\n[    3.419907] usb 1-=
6: SerialNumber: 20042103220284D0CB42\r\n[    3.425137] clocksource: Switch=
ed to clocksource tsc\r\n[    3.426141] usb-storage 1-6:1.0: USB Mass Stora=
ge device detected\r\n[    3.436521] scsi host8: usb-storage 1-6:1.0\r\n[  =
  3.554432] usb 1-14: new high-speed USB device number 3 using xhci_hcd\r\n=
[    3.687893] usb 1-14: New USB device found, idVendor=3D0557, idProduct=
=3D7000, bcdDevice=3D 0.00\r\n[    3.696194] usb 1-14: New USB device strin=
gs: Mfr=3D0, Product=3D0, SerialNumber=3D0\r\n[    3.705172] hub 1-14:1.0: =
USB hub found\r\n[    3.709202] hub 1-14:1.0: 4 ports detected\r\n[    4.00=
5425] usb 1-14.1: new low-speed USB device number 4 using xhci_hcd\r\n[    =
4.117348] usb 1-14.1: New USB device found, idVendor=3D0557, idProduct=3D24=
19, bcdDevice=3D 1.00\r\n[    4.125801] usb 1-14.1: New USB device strings:=
 Mfr=3D0, Product=3D0, SerialNumber=3D0\r\n[    4.140645] input: HID 0557:2=
419 as /devices/pci0000:00/0000:00:14.0/usb1/1-14/1-14.1/1-14.1:1.0/0003:05=
57:2419.0001/input/input3\r\n[    4.205048] hid-generic 0003:0557:2419.0001=
: input,hidraw0: USB HID v1.00 Keyboard [HID 0557:2419] on usb-0000:00:14.0=
-14.1/input0\r\n[    4.218431] input: HID 0557:2419 as /devices/pci0000:00/=
0000:00:14.0/usb1/1-14/1-14.1/1-14.1:1.1/0003:0557:2419.0002/input/input4\r=
\n[    4.230503] hid-generic 0003:0557:2419.0002: input,hidraw1: USB HID v1=
=2E00 Mouse [HID 0557:2419] on usb-0000:00:14.0-14.1/input1\r\n[    4.48204=
0] scsi 8:0:0:0: Direct-Access     SanDisk  Cruzer Blade     1.00 PQ: 0 ANS=
I: 6\r\n[    4.492945] sd 8:0:0:0: Attached scsi generic sg1 type 0\r\n[   =
 4.498775] sd 8:0:0:0: [sdb] 30595072 512-byte logical blocks: (15.7 GB/14.=
6 GiB)\r\n[    4.508178] sd 8:0:0:0: [sdb] Write Protect is off\r\n[    4.5=
13770] sd 8:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn\=
't support DPO or FUA\r\n[    4.527531]  sdb: sdb3 sdb4\r\n[    4.530518] s=
d 8:0:0:0: [sdb] Attached SCSI removable disk\r\n[    6.279091] igb 0000:01=
:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: R=
X\r\n[    6.288551] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready=
\r\n[    6.306446] Sending DHCP requests ..., OK\r\n[   15.462477] IP-Confi=
g: Got DHCP answer from 10.66.16.15, my address is 10.66.27.116\r\n[   15.4=
70168] IP-Config: Complete:\r\n[   15.473404]      device=3Deth0, hwaddr=3D=
ac:1f:6b:1a:b3:4e, ipaddr=3D10.66.27.116, mask=3D255.255.240.0, gw=3D10.66.=
16.1\r\n[   15.483421]      host=3D10.66.27.116, domain=3Dlkftlab, nis-doma=
in=3D(none)\r\n[   15.489876]      bootserver=3D0.0.0.0, rootserver=3D10.66=
=2E16.124, rootpath=3D\r\n[   15.489877]      nameserver0=3D10.66.16.10\r\n=
[   15.529269] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database\r\n[   15.537710] cfg80211: Loaded X.509 cert \'sforshee: 00b2=
8ddf47aef9cea7\'\r\n[   15.544300] platform regulatory.0: Direct firmware l=
oad for regulatory.db failed with error -2\r\n[   15.545394] ALSA device li=
st:\r\n[   15.552920] cfg80211: failed to load regulatory.db\r\n[   15.5607=
28]   No soundcards found.\r\n[   15.564380] md: Waiting for all devices to=
 be available before autodetect\r\n[   15.571186] md: If you don\'t use rai=
d, use raid=3Dnoautodetect\r\n[   15.576836] md: Autodetecting RAID arrays.=
\r\n[   15.580953] md: autorun ...\r\n[   15.583770] md: ... autorun DONE.\=
r\n[   15.665422] VFS: Mounted root (nfs filesystem) on device 0:17.\r\n[  =
 15.672273] devtmpfs: mounted\r\n[   15.676342] Freeing unused kernel image=
 (initmem) memory: 3624K\r\n[   15.684349] Write protecting the kernel read=
-only data: 30720k\r\n[   15.690412] Freeing unused kernel image (rodata/da=
ta gap) memory: 172K\r\n[   15.743593] x86/mm: Checked W+X mappings: passed=
, no W+X pages found.\r\n[   15.750037] x86/mm: Checking user space page ta=
bles\r\n[   15.799837] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.\r\n[   15.806286] Run /sbin/init as init process\r\n[   15.945626] BU=
G: kernel NULL pointer dereference, address: 0000000000000008\r\n[   15.952=
588] #PF: supervisor read access in kernel mode\r\n[   15.957720] #PF: erro=
r_code(0x0000) - not-present page\r\n[   15.962850] PGD 8000000103213067 P4=
D 8000000103213067 PUD 103212067 PMD 0 \r\n[   15.969724] Oops: 0000 [#1] P=
REEMPT SMP PTI\r\n[   15.973909] CPU: 3 PID: 1 Comm: init Not tainted 6.2.0=
-rc3-next-20230113 #1\r\n[   15.980869] Hardware name: Supermicro SYS-5019S=
-ML/X11SSH-F, BIOS 2.0b 07/27/2017\r\n[   15.988336] RIP: 0010:do_wp_page+0=
x236/0xef0\r\n[   15.992611] Code: 83 ea 01 49 89 d7 48 85 d2 0f 85 00 ff f=
f ff 49 8b 7c 24 60 e8 0b f2 e9 00 41 8b 44 24 28 4d 8b 74 24 50 4d 8b 2c 2=
4 89 45 88 <49> 8b 46 08 49 8b 5d 10 a8 01 0f 85 78 02 00 00 0f 1f 44 00 00=
 4c\r\n[   16.011356] RSP: 0000:ffffb3f640027d18 EFLAGS: 00010286\r\n[   16=
=2E016583] RAX: 0000000000000a55 RBX: 0400000000000080 RCX: 000000000000000=
0\r\n[   16.023715] RDX: 0000000000000000 RSI: ffffffff8d3d2bd5 RDI: ffffff=
ff8e271dfa\r\n[   16.030838] RBP: ffffb3f640027db0 R08: 8000000432ee9225 R0=
9: ffff8ac3431e3100\r\n[   16.037962] R10: 0000000000000000 R11: 00007fe169=
f2f598 R12: ffffb3f640027de0\r\n[   16.045087] R13: ffff8ac3431e2000 R14: 0=
000000000000000 R15: 0400000000000000\r\n[   16.052211] FS:  00007fe16973e8=
00(0000) GS:ffff8ac69fd80000(0000) knlGS:0000000000000000\r\n[   16.060319]=
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033\r\n[   16.066060] CR2: 0=
000000000000008 CR3: 00000001008d4002 CR4: 00000000003706e0\r\n[   16.07318=
3] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000\r\n[  =
 16.080322] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00\r\n[   16.087446] Call Trace:\r\n[   16.089893]  <TASK>\r\n[   16.091991=
]  ? trace_preempt_off+0x2d/0xd0\r\n[   16.096087]  ? __handle_mm_fault+0x7=
ee/0x12f0\r\n[   16.100439]  __handle_mm_fault+0xabf/0x12f0\r\n[   16.10461=
7]  handle_mm_fault+0xf8/0x320\r\n[   16.108457]  do_user_addr_fault+0x1d9/=
0x650\r\n[   16.112642]  exc_page_fault+0x6b/0x170\r\n[   16.116394]  asm_e=
xc_page_fault+0x2b/0x30\r\n[   16.120408] RIP: 0033:0x7fe169dbf31e\r\n[   1=
6.123986] Code: ba ff ff ff ff 0f 9f c0 0f b6 c0 0f 4c c2 c3 66 2e 0f 1f 84=
 00 00 00 00 00 0f 1f 00 41 54 31 c0 ba ff ff ff ff 53 48 83 ec 08 <f0> 0f =
b1 15 72 02 17 00 83 f8 ff 74 35 41 89 c4 85 c0 75 21 31 c0\r\n[   16.14272=
4] RSP: 002b:00007ffcd0edec80 EFLAGS: 00010202\r\n[   16.147948] RAX: 00000=
00000000000 RBX: 0000000000000000 RCX: 0000000000555bd8\r\n[   16.155074] R=
DX: 00000000ffffffff RSI: 00007ffcd0edefa8 RDI: 0000000000000001\r\n[   16.=
162198] RBP: 00007ffcd0edefa8 R08: 00007fe169bc5a10 R09: 00007fe169f37a10\r=
\n[   16.169319] R10: 00007fe169adf3ee R11: 0000000000000246 R12: 00007ffcd=
0edefa8\r\n[   16.176445] R13: 000000000041b9a0 R14: 0000000000555bd8 R15: =
00007fe169f69000\r\n[   16.183569]  </TASK>\r\n[   16.185752] Modules linke=
d in:\r\n[   16.188803] CR2: 0000000000000008\r\n[   16.192114] ---[ end tr=
ace 0000000000000000 ]---'}, {'kind': 'panic', 'message': '[   16.295799] K=
ernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000009\r\=
n[   16.303496] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)\r\n[   16.314190] ---[ end =
Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000009 ]=
---'}]}, 'level': '2.3.4.1', 'namespace': 'common', 'result': 'fail'}
> 2023-01-13T04:31:10 [   16.295799] Kernel panic - not syncing: Attempted =
to kill init! exitcode=3D0x00000009
> [   16.303496] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
> [   16.314190] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000009 ]---
> 2023-01-13T04:31:10 end: 2.3.4.1 login-action (duration 00:00:17) [common]
> 2023-01-13T04:31:10 {'case': 'login-action', 'definition': 'lava', 'durat=
ion': '17.39', 'extra': {'fail': '[   16.295799] Kernel panic - not syncing=
: Attempted to kill init! exitcode=3D0x00000009\r\n[   16.303496] Kernel Of=
fset: 0xc000000 from 0xffffffff81000000 (relocation range: 0xffffffff800000=
00-0xffffffffbfffffff)\r\n[   16.314190] ---[ end Kernel panic - not syncin=
g: Attempted to kill init! exitcode=3D0x00000009 ]---'}, 'level': '2.3.4.1'=
, 'namespace': 'common', 'result': 'fail'}
> 2023-01-13T04:31:10 auto-login-action failed: 1 of 1 attempts. '[   16.29=
5799] Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000=
0009
> [   16.303496] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
> [   16.314190] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000009 ]---'
> 2023-01-13T04:31:10 [   16.295799] Kernel panic - not syncing: Attempted =
to kill init! exitcode=3D0x00000009
> [   16.303496] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
> [   16.314190] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000009 ]---
> 2023-01-13T04:31:10 end: 2.3.4 auto-login-action (duration 00:00:18) [com=
mon]
> 2023-01-13T04:31:10 {'case': 'auto-login-action', 'definition': 'lava', '=
duration': '18.12', 'extra': {'fail': '[   16.295799] Kernel panic - not sy=
ncing: Attempted to kill init! exitcode=3D0x00000009\r\n[   16.303496] Kern=
el Offset: 0xc000000 from 0xffffffff81000000 (relocation range: 0xffffffff8=
0000000-0xffffffffbfffffff)\r\n[   16.314190] ---[ end Kernel panic - not s=
yncing: Attempted to kill init! exitcode=3D0x00000009 ]---'}, 'level': '2.3=
=2E4', 'namespace': 'common', 'result': 'fail'}
> 2023-01-13T04:31:10 bootloader-retry failed: 1 of 1 attempts. '[   16.295=
799] Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000=
009
> [   16.303496] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
> [   16.314190] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000009 ]---'
> 2023-01-13T04:31:10 [   16.295799] Kernel panic - not syncing: Attempted =
to kill init! exitcode=3D0x00000009
> [   16.303496] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
> [   16.314190] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000009 ]---
> 2023-01-13T04:31:10 end: 2.3 bootloader-retry (duration 00:01:37) [common]
> 2023-01-13T04:31:10 {'case': 'bootloader-retry', 'definition': 'lava', 'd=
uration': '97.03', 'extra': {'fail': '[   16.295799] Kernel panic - not syn=
cing: Attempted to kill init! exitcode=3D0x00000009\r\n[   16.303496] Kerne=
l Offset: 0xc000000 from 0xffffffff81000000 (relocation range: 0xffffffff80=
000000-0xffffffffbfffffff)\r\n[   16.314190] ---[ end Kernel panic - not sy=
ncing: Attempted to kill init! exitcode=3D0x00000009 ]---'}, 'level': '2.3'=
, 'namespace': 'common', 'result': 'fail'}
> 2023-01-13T04:31:10 [   16.295799] Kernel panic - not syncing: Attempted =
to kill init! exitcode=3D0x00000009
> [   16.303496] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
> [   16.314190] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000009 ]---
> 2023-01-13T04:31:10 end: 2 bootloader-action (duration 00:01:37) [common]
> 2023-01-13T04:31:10 {'case': 'bootloader-action', 'definition': 'lava', '=
duration': '97.04', 'extra': {'fail': '[   16.295799] Kernel panic - not sy=
ncing: Attempted to kill init! exitcode=3D0x00000009\r\n[   16.303496] Kern=
el Offset: 0xc000000 from 0xffffffff81000000 (relocation range: 0xffffffff8=
0000000-0xffffffffbfffffff)\r\n[   16.314190] ---[ end Kernel panic - not s=
yncing: Attempted to kill init! exitcode=3D0x00000009 ]---'}, 'level': '2',=
 'namespace': 'common', 'result': 'fail'}
> 2023-01-13T04:31:10 Cleaning after the job
> 2023-01-13T04:31:10 Cleaning up download directory: /var/lib/lava/dispatc=
her/tmp/6053089/tftp-deploy-qytnh1b1/kernel
> 2023-01-13T04:31:10 Cleaning up download directory: /var/lib/lava/dispatc=
her/tmp/6053089/tftp-deploy-qytnh1b1/nfsrootfs
> 2023-01-13T04:31:10 Cleaning up download directory: /var/lib/lava/dispatc=
her/tmp/6053089/tftp-deploy-qytnh1b1/modules
> 2023-01-13T04:31:10 start: 5.1 power-off (timeout 00:00:30) [common]
> 2023-01-13T04:31:10 Calling: 'nice' 'ipmitool' '-U' 'ADMIN' '-P' 'ADMIN' =
'-I' 'lanplus' '-H' '10.66.16.51' 'chassis' 'power' 'off'
> 2023-01-13T04:31:10 >> Chassis Power Control: Down/Off
> 2023-01-13T04:31:10 Returned 0 in 0 seconds
> 2023-01-13T04:31:10 end: 5.1 power-off (duration 00:00:00) [common]
> 2023-01-13T04:31:10 {'case': 'power-off', 'definition': 'lava', 'duration=
': '0.14', 'extra': {'status': 'success'}, 'level': '5.1', 'namespace': 'co=
mmon', 'result': 'pass'}
> 2023-01-13T04:31:10 start: 5.2 read-feedback (timeout 00:00:30) [common]
> 2023-01-13T04:31:11 Finalising connection for namespace 'common'
> 2023-01-13T04:31:11 Disconnecting from telnet: Finalise
> 2023-01-13T04:31:11 ]
> 2023-01-13T04:31:11 quit
> 2023-01-13T04:31:11 =1Dquit
> 2023-01-13T04:31:11 end: 5.2 read-feedback (duration 00:00:01) [common]
> 2023-01-13T04:31:11 Override tmp directory removed at /var/lib/lava/dispa=
tcher/tmp/6053089
> 2023-01-13T04:31:12 Root tmp directory removed at /var/lib/lava/dispatche=
r/tmp/6053089
> 2023-01-13T04:31:12 JobError: Your job cannot terminate cleanly.
> 2023-01-13T04:31:12 {'case': 'job', 'definition': 'lava', 'error_msg': '[=
   16.295799] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00000009\r\n[   16.303496] Kernel Offset: 0xc000000 from 0xffffffff810=
00000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)\r\n[   16.3=
14190] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcod=
e=3D0x00000009 ]---', 'error_type': 'Job', 'result': 'fail'}

