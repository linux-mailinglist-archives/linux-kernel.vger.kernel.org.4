Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA946C6FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCWRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:55:35 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94120A3C;
        Thu, 23 Mar 2023 10:55:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 22101740;
        Thu, 23 Mar 2023 17:55:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 22101740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679594133; bh=+8YuajcT7e8sCK8OzY/eAu/4yju8pgLJhcr/AZBck7E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bruB0Lheq9Qu47IgTPu1vgSSXR1okFeF55PLvqm3SF6/F+V7LU5zD1DMPqPBQbqXu
         S8LUkTE24jyn3/AK+MOSkMWlHLsvt+pLUunOYCnEj6OkQe0LkgXEvQXC+qA3O/CALE
         dvtMTmIGkgIyP6MWf5f0S6qI3XlrOTS6TR92QbOGs0DSacjM3v4dVAIWgoSNRrf6Pv
         aExqz2iiz1DX2/XUOdixXh4V1BM260ZoVvzcJR8aG0+UQpL0BETQsnHGh5mT51hq+h
         v0YXnJ5ofvYY5ZvWW3vniYBlCg54v//abB+uRhaTOg5FbRTfyrXhQCWzBHdm6jQTke
         1Dd5NxBLDtjvg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: add system-state document to admin-guide
In-Reply-To: <20230322152049.12723-1-skhan@linuxfoundation.org>
References: <20230322152049.12723-1-skhan@linuxfoundation.org>
Date:   Thu, 23 Mar 2023 11:55:32 -0600
Message-ID: <877cv7cpyj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> Add a new system state document to the admin-guide. This document is
> intended to be used as a guide on how to gather higher level information
> about a system and its run-time activity.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1:
> -- Addressed review comments
>
>  Documentation/admin-guide/index.rst        |   1 +
>  Documentation/admin-guide/system-state.rst | 350 +++++++++++++++++++++
>  2 files changed, 351 insertions(+)
>  create mode 100644 Documentation/admin-guide/system-state.rst
>
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-gu=
ide/index.rst
> index f475554382e2..541372672c55 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -66,6 +66,7 @@ subsystems expectations will be found here.
>     :maxdepth: 1
>=20=20
>     workload-tracing
> +   system-state
>=20=20
>  The rest of this manual consists of various unordered guides on how to
>  configure specific aspects of kernel behavior to your liking.
> diff --git a/Documentation/admin-guide/system-state.rst b/Documentation/a=
dmin-guide/system-state.rst
> new file mode 100644
> index 000000000000..2a6fdf85c35c
> --- /dev/null
> +++ b/Documentation/admin-guide/system-state.rst
> @@ -0,0 +1,350 @@
> +.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Discovering system calls and features supported on a system
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Shuah Khan <skhan@linuxfoundation.org>
> +:maintained-by: Shuah Khan <skhan@linuxfoundation.org>

Rather than adding lines like this, I think everybody would be better
served with a MAINTAINERS file entry.  get_maintainer.pl doesn't know
about these lines.

> +Key Points
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> + * System state includes system calls, features, static and dynamic
> +   modules enabled in the kernel configuration.
> + * Supported system calls and Kernel features are architecture dependent.
> + * auditd, checksyscalls.sh, and get_feat.pl tools can be used to discov=
er
> +   static system state.
> + * Understanding Linux kernel hardening configurations options and making
> +   sure they are enabled will make a system more secure.
> + * Employing run-time tracing can shed light on the dynamic system state.
> + * Workloads could change the system state by loading and unloading dyna=
mic
> +   modules and tuning system parameters.

So what I'm missing, before this even, is a paragraph saying what this
document is actually for.  Who is the intended audience, and why might
they want to read this document?

> +System State Visualization
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +The kernel system state can be viewed as a combination of static and
> +dynamic features and modules. Let=E2=80=99s first define what static and=
 dynamic
> +system states are and then explore how we can visualize the static and
> +dynamic system parts of the kernel.
> +
> +Static System View comprises system calls, features, static and dynamic
> +modules enabled in the kernel configuration. Supported system calls

So the "static system view" includes *dynamic* modules?  Fine if that's
what you intended, but it reads a bit strangely.

> +and Kernel features are architecture dependent. System call numbering is
> +different on different architectures. We can get the supported system ca=
ll
> +information using auditd utilities.
> +
> +ausyscall =E2=80=93dump prints out the supported system calls on a syste=
m and allows

Some clever software turned your "--" into an em-dash here.

> +mapping syscall names and numbers. You can install the auditd package on
> +Debian based systems::
> +
> +  sudo apt-get install auditd
> +
> +scripts/checksyscalls.sh can be used to check if current architecture is
> +missing any system calls compared to i386.
> +
> +scripts/get_feat.pl can be used to list the Kernel feature support matrix
> +for an architecture.
> +
> +Dynamic System View comprises system calls, ioctls invoked, and subsyste=
ms
> +used during the runtime. A workload could load and unload modules and al=
so
> +change the dynamic system configuration to suit its needs by tuning syst=
em
> +parameters.
> +
> +What is the methodology?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The first step is gathering the default system state such as the dynamic
> +and static modules loaded on the system. lsmod command prints out the

*The* lsmod command

> +dynamically loaded modules on a system. Statically configured modules can
> +be found in the kernel configuration file.
> +
> +The next step is discovering system activity during run-time. You can do=
 so
> +by enabling event tracing and then running your favorite application. Af=
ter
> +a period of time, gather the event logs, and kernel messages.

Might your intended readers need a hint on enabling tracing?  A cross
reference to the appropriate docs if nothing else.

[Later I see you get to this; adding an "as described below" would help
here.]

> +Once you have the necessary information, you can extract the system call
> +numbers from the event trace log and map them to the supported system ca=
lls.
> +
> +Finding supported system calls
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +As mentioned earlier, ausyscall prints out supported system calls
> +on a system and allows mapping syscalls names and numbers::
> +
> + ausyscall --dump
> +
> +You can look for specific system calls as shown in the below::
> +
> +  ausyscall open
> +    open               2
> +    mq_open            240
> +    openat             257
> +    perf_event_open    298
> +    open_by_handle_at  304
> +    open_tree          428
> +    fsopen             430
> +    pidfd_open         434
> +    openat2            437
> +
> +  ausyscall time
> +
> +    getitimer          36
> +    setitimer          38
> +    gettimeofday       96
> +    times              100
> +    rt_sigtimedwait    128
> +    utime              132
> +    adjtimex           159
> +    settimeofday       164
> +    time               201
> +    semtimedop         220
> +    timer_create       222
> +    timer_settime      223
> +    timer_gettime      224
> +    timer_getoverrun   225
> +    timer_delete       226
> +    clock_settime      227
> +    clock_gettime      228
> +    utimes             235
> +    mq_timedsend       242
> +    mq_timedreceive    243
> +    futimesat          261
> +    utimensat          280
> +    timerfd_create     283
> +    timerfd_settime    286
> +    timerfd_gettime    287
> +    clock_adjtime      305
> +
> +Finding unsupported system calls
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +As mentioned earlier, scripts/checksyscalls.sh checks missing system cal=
ls
> +on current architecture compared to i386. Example run::
> +
> +  checksyscalls.sh gcc
> +    warning: #warning syscall mmap2 not implemented [-Wcpp]
> +    warning: #warning syscall truncate64 not implemented [-Wcpp]
> +    warning: #warning syscall ftruncate64 not implemented [-Wcpp]
> +    warning: #warning syscall fcntl64 not implemented [-Wcpp]
> +    warning: #warning syscall sendfile64 not implemented [-Wcpp]
> +    warning: #warning syscall statfs64 not implemented [-Wcpp]
> +    warning: #warning syscall fstatfs64 not implemented [-Wcpp]
> +    warning: #warning syscall fadvise64_64 not implemented [-Wcpp]
> +
> +Let's check this against ausyscall now::
> +
> +  ausyscall map
> +    mmap               9
> +    munmap             11
> +    mremap             25
> +    remap_file_pages   216
> +
> +  ausyscall trunc
> +    truncate           76
> +    ftruncate          77
> +
> +As you can see, ausyscall shows mmap2, truncate64, and ftruncate64 aren't
> +implemented on this system. This matches what checksyscalls.sh shows.
> +
> +Finding supported features
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +scripts/get_feat.pl can be used to list the Kernel feature support matrix
> +for an architecture::
> +
> + get_feat.pl list
> + get_feat.pl list =E2=80=93arch=3Darm64 lists

Lost the "--" again here

> +This scripts parses Documentation/features to find the support status

script (singular)

> +information. It can be used to validate the contents of the files under
> +Documentation/features or simply list them::
> +
> +  --arch Outputs features for an specific architecture, optionally filte=
ring
> +         for a single specific feature.
> +  --feat or --feature Output features for a single specific feature.
> +
> +Here is how you can find if stackprotector and hread-info-in-task featur=
es

and *thread*-info-in-task

> +are supported::
> +
> +  scripts/get_feat.pl --arch=3Darm64 --feat=3Dstackprotector list
> +    #
> +    # Kernel feature support matrix of the 'arm64' architecture:
> +    #
> +    debug/ stackprotector       :  ok  |            HAVE_STACKPROTECTOR #
> +    arch supports compiler driven stack overflow protection
> +
> +  scripts/get_feat.pl --feat=3Dthread-info-in-task list
> +    #
> +    # Kernel feature support matrix of the 'x86' architecture:
> +    #
> +      core/ thread-info-in-task  :  ok  |           THREAD_INFO_IN_TASK #
> +      arch makes use of the core kernel facility to embed thread_info in
> +      task_struct
> +
> +Finding kernel module status
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +lsmod command shows the kernel modules that are currently loaded. This
> +program displays the contents of /proc/modules. Let's pick uvcvideo

*The* lsmod
*the* uvcvideo

> +module which is found on most laptops::
> +
> +  lsmod | grep uvc
> +  uvcvideo              126976  0
> +  videobuf2_vmalloc      20480  1 uvcvideo
> +  uvc                    16384  1 uvcvideo
> +  videobuf2_v4l2         36864  1 uvcvideo
> +  videodev              315392  2 videobuf2_v4l2,uvcvideo
> +  videobuf2_common       65536  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvi=
deo,videobuf2_memops
> +  mc                     77824  4 videodev,videobuf2_v4l2,uvcvideo,video=
buf2_common
> +
> +You can see that lsmod shows uvcvideo and the modules it depends on and =
how
> +many modules are using them. videobuf2_common is in use by 4 other modul=
es.
> +In other words, this is the reference count for this module and rmmod wi=
ll
> +refuse to unload it as long as the reference count is > 0.
> +
> +You can get the same information from /proc.modules::
> +
> +  less /proc/modules | grep uvc

why not just "grep uvc /proc/modules" ?

> +  uvcvideo 126976 0 - Live 0x0000000000000000
> +  videobuf2_vmalloc 20480 1 uvcvideo, Live 0x0000000000000000
> +  uvc 16384 1 uvcvideo, Live 0x0000000000000000
> +  videobuf2_v4l2 36864 1 uvcvideo, Live 0x0000000000000000
> +  videodev 315392 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
> +  videobuf2_common 65536 4 uvcvideo,videobuf2_vmalloc,videobuf2_memops,v=
ideobuf2_v4l2, Live 0x0000000000000000
> +  mc 77824 4 uvcvideo,videobuf2_v4l2,videodev,videobuf2_common, Live 0x0=
000000000000000
> +
> +The information is similar with a few more extra fields. The address is =
the
> +base address for the module in kernel virtual memory space. When run as a
> +normal user, the address is all zeros. The same command when run as root=
 will
> +be as follows::
> +
> +  sudo less /proc/modules | grep uvc
> +  uvcvideo 126976 0 - Live 0xffffffffc1c8b000
> +  videobuf2_vmalloc 20480 1 uvcvideo, Live 0xffffffffc167f000
> +  uvc 16384 1 uvcvideo, Live 0xffffffffc0ab0000
> +  videobuf2_v4l2 36864 1 uvcvideo, Live 0xffffffffc0a28000
> +  videodev 315392 2 uvcvideo,videobuf2_v4l2, Live 0xffffffffc16e9000
> +  videobuf2_common 65536 4 uvcvideo,videobuf2_vmalloc,videobuf2_memops,v=
ideobuf2_v4l2, Live 0xffffffffc094d000
> +  mc 77824 4 uvcvideo,videobuf2_v4l2,videodev,videobuf2_common, Live 0xf=
fffffffc15eb000
> +
> +Let's check what modinfo shows that is important for us::
> +
> +  /sbin/modinfo uvcvideo
> +  filename:       /lib/modules/6.3.0-rc2/kernel/drivers/media/usb/uvc/uv=
cvideo.ko
> +  license:        GPL
> +  description:    USB Video Class driver
> +  depends:        videobuf2-v4l2,videodev,mc,uvc,videobuf2-common,videob=
uf2-vmalloc
> +  retpoline:      Y
> +  intree:         Y
> +  name:           uvcvideo
> +  vermagic:       6.3.0-rc2 SMP preempt mod_unload modversions
> +  sig_id:         PKCS#7
> +  signer:         Build time autogenerated kernel key
> +
> +This tells us that this module is built intree and the signed with a bui=
ld
> +time autogenerated key.
> +
> +Let's do one last sanity check on the system to see if the following two
> +command outputs match::
> +
> +  ps ax | wc -l
> +  ls -d /proc/* | grep [0-9]|wc -l
> +
> +If they don't match, examine your system closely. kernel rootkits install
> +their own ps, find, etc. utilities to mask their activity. The outputs
> +match on my system. Do they on yours?

This would assume that there is no other activity on the system, of
course.  Worth saying to avoid unnecessary panic.

> +Is my system as secure as it could be?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Linux kernel supports several hardening options to make system secure.

*The* Linux kernel ... to make *the* system secure

the whole document could use a pass for article use

> +kconfig-hardened-check tool sanity checks kernel configuration for
> +security. You can clone the latest kconfig-hardened-check repository::
> +
> +  git clone https://github.com/a13xp0p0v/kconfig-hardened-check.git
> +  cd kconfig-hardened-check
> +  bin/kconfig-hardened-check --config <config file> --cmdline /proc/cmdl=
ine

Should you say what <config file> is?

> +This will generate detailed report of kernel security configuration and
> +command line options that are enabled (OK) and the ones that aren't (FAI=
L)
> +and a summary line at the end::
> +
> +  [+] Config check is finished: 'OK' - 100 / 'FAIL' - 100
> +
> +You will have to analyze the information to determine which options make
> +sense to enable on your system.
> +
> +Understanding system run-time activity
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Enabling event tracing gives insight into system run-time activity. This=
 is
> +a good way to identify which parts of the kernel are used at a higher le=
vel
> +while system is in and/or while a specific workload/process is running.
> +
> +Event tracing depends on the CONFIG_EVENT_TRACING option enabled. You can
> +enable event tracing before starting workload/process. Event tracing all=
ows
> +you to dynamically enable and disable tracing on supported/available eve=
nts.
> +You can find available events, tracers, and filter functions in the foll=
owing
> +files::
> +
> +  /sys/kernel/debug/tracing/available_events
> +  /sys/kernel/debug/tracing/available_filter_functions
> +  /sys/kernel/debug/tracing/available_tracers
> +
> +Now this is how you can enable tracing::
> +
> +  sudo echo 1 > /sys/kernel/debug/tracing/events/enable
> +
> +Once the workload/process stops or when you decide you have the status y=
ou
> +need, you can disable event tracing::
> +
> +  sudo echo 0 > /sys/kernel/debug/tracing/events/enable
> +
> +You can find the tracing information in the file::
> +
> +  /sys/kernel/debug/tracing
> +
> +Here is the information shown in this file::
> +
> +  cat trace
> +  # tracer: nop
> +  #
> +  # entries-in-buffer/entries-written: 0/0   #P:16
> +  #
> +  #                                _-----=3D> irqs-off/BH-disabled
> +  #                               / _----=3D> need-resched
> +  #                              | / _---=3D> hardirq/softirq
> +  #                              || / _--=3D> preempt-depth
> +  #                              ||| / _-=3D> migrate-disable
> +  #                              |||| /     delay
> +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> +  #              | |         |   |||||     |         |
> +

That looks like the header, certainly not "the information" found in the
file.  Including some actual output would make the following discussion
more comprehensible.

> +Analyzing traces
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +You will be able map the functions to system calls and other kernel feat=
ures
> +to get insight into the overall system activity while a workload/process=
 is
> +running.
> +
> +Map the NR (syscal) numbers from the trace to syscalls from the syscalls=
 dump.

(syscall)

> +Categorize system calls and map them to Linux subsystems.

Not sure what that sentence is trying to tell readers.  Again, who is
the audience; will a readership that needs to be told how to install
auditd be able to make sense of this and act on it?

> +Conclusion
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document is intended to be used as a guide on how to gather higher =
level
> +information about a system and its run-time activity. The approach descr=
ibed
> +in this document helps us get insight into supported system calls, featu=
res,
> +assess how secure a system is, and its run-time activity.
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> + * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/checksyscalls.sh
> + * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/get_feat.pl
> + * https://github.com/a13xp0p0v/kconfig-hardened-check
> + * https://docs.kernel.org/trace/index.html

Thanks,

jon
