Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2F667F502
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 06:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjA1Fkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 00:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjA1Fkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 00:40:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABAC78AE0;
        Fri, 27 Jan 2023 21:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SzBbaHfGLue0BLG0ZS28pNI9ec6feh3/lxH8oAhpLQM=; b=crfJxagdDslxsuVCg8Cc+0tQeD
        qFqHc/VQbUZJJsRmnmQGQbqjBXx+M+chsoVSQ0gkDF6k7pHpY5s8ioMRcJUGMfAk9m8EyvScX9/W9
        I/Wj7jMyFiijIgeaORojAuQLU4UFsLljdFJp0Hz1L7YID/VV+imN65Y7S/ttp/9WrRUHV5JpAL65a
        Mm2kPGyXWdhtgrV5vxE43DCQ7efKrEVKYBQ95XOf3Y6rDd6XRZv/nv0KyjRXP69VovUjcR27rufLk
        J4jTB3h+wrCjmNGLA9B18+6KAgwoDqRygqjiKCLFZyQt3E6PDmFg44BTuDxM+LRKKa/rQz8NbL33c
        3p/KHRTw==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLdxF-00HG2T-JN; Sat, 28 Jan 2023 05:40:45 +0000
Message-ID: <25089707-b037-4cce-367b-819ddd239b17@infradead.org>
Date:   Fri, 27 Jan 2023 21:40:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] docs: add workload-tracing document to admin-guide
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230127234616.55137-1-skhan@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230127234616.55137-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/27/23 15:46, Shuah Khan wrote:
> Add a new section to the admin-guide with information of interest to
> application developers and system integrators doing analysis of the
> Linux kernel for safety critical applications.
> 
> This section will contain documents supporting analysis of kernel
> interactions with applications, and key kernel subsystems expectations.
> 
> Add a new workload-tracing document to this new section.
> 
> Signed-off-by: Shefali Sharma <sshefali021@gmail.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1:
> - Addressed review comments on v1 on long lines, rst syntax, license
> 
>  Documentation/admin-guide/index.rst           |  11 +
>  .../admin-guide/workload-tracing.rst          | 591 ++++++++++++++++++
>  2 files changed, 602 insertions(+)
>  create mode 100644 Documentation/admin-guide/workload-tracing.rst
> 

> diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
> new file mode 100644
> index 000000000000..43753f3ea915
> --- /dev/null
> +++ b/Documentation/admin-guide/workload-tracing.rst
> @@ -0,0 +1,591 @@
> +.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
> +


> +What is perf and how do we use it?
> +====================================
> +
> +Perf is an analysis tool based on Linux 2.6+ systems, which abstracts the
> +CPU hardware difference in performance measurement in Linux, and provides
> +a simple command line interface. Perf is based on the perf_events interface
> +exported by the kernel. It is very useful for profiling the system and
> +finding performance bottlenecks in an application.
> +
> +If you haven't already checkout the Linux mainline repository, you can do

                          checked out

> +so and then build kernel and perf tool: ::
> +
> +  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux
> +  cd linux
> +  make -j3 all
> +  cd tools/perf
> +  make
> +
> +Note: The perf command can be built without building the kernel in the
> +repo and can be run on older kernels. However matching the kernel and

   preferably "repository"

> +perf revisions gives more accurate information on the subsystem usage.
> +
> +We used perf stat and perf bench options. For a detailed information on the
> +perf tool, run perf -h.
> +


Fix table line below:

> +Tracing paxtest kiddie workload
> +-------------------------------
> +
> +Run the following command to trace paxtest kiddie workload: ::
> +
> + strace -c paxtest kiddie
> +
> +**System Calls made by the workload:**
> +
> +The following table shows you the system calls, number of times the system
> +call was invoked, and the Linux subsystem they fall under.
> +
> ++-------------------+-----------+-----------------+----------------------+
> +| System Call       | # calls   | Linux Subsystem | System Call (API)    |
> ++===================+===========+=================+======================+
> +| read              | 3         | Filesystem      | sys_read()           |
> ++-------------------+-----------+-----------------+----------------------+
> +| write             | 11        | Filesystem      | sys_write()          |
> ++-------------------+-----------+-----------------+----------------------+
> +| close             | 41        | Filesystem      | sys_close()          |
> ++-------------------+-----------+-----------------+----------------------+
> +| stat              | 24        | Filesystem      | sys_stat()           |
> ++-------------------+-----------+-----------------+----------------------+
> +| fstat             | 2         | Filesystem      | sys_fstat()          |
> ++-------------------+-----------+-----------------+----------------------+
> +| pread64           | 6         | Filesystem      | sys_pread64()        |
> ++-------------------+-----------+-----------------+----------------------+
> +| access	    | 1         | Filesystem      | sys_access()         |
> ++-------------------+-----------+-----------------+----------------------+
> +| pipe              | 1         | Filesystem      | sys_pipe()           |
> ++-------------------+-----------+-----------------+----------------------+
> +| dup2              | 24        | Filesystem      | sys_dup2()           |
> ++-------------------+-----------+-----------------+----------------------+
> +| execve            | 1         | Filesystem      | sys_execve()         |
> ++-------------------+-----------+-----------------+----------------------+
> +| fcntl             | 26        | Filesystem      | sys_fcntl()          |
> ++-------------------+-----------+-----------------+----------------------+
> +| openat            | 14        | Filesystem      | sys_openat()         |
> ++-------------------+-----------+-----------------+----------------------+
> +| rt_sigaction      | 7         | Signal          | sys_rt_sigaction()   |
> ++-------------------+-----------+-----------------+----------------------+
> +| rt_sigreturn      | 38        | Signal          | sys_rt_sigreturn()   |
> ++-------------------+-----------+-----------------+----------------------+
> +| clone             | 38        | Process Mgmt.   | sys_clone()          |
> ++-------------------+-----------+-----------------+----------------------+
> +| wait4             | 44        | Time            | sys_wait4()          |
> ++-------------------+-----------+-----------------+----------------------+
> +| mmap              | 7         | Memory Mgmt.    | sys_mmap()           |
> ++-------------------+-----------+-----------------+----------------------+
> +| mprotect          | 3         | Memory Mgmt.    | sys_mprotect()       |
> ++-------------------+-----------+-----------------+----------------------+
> +| munmap            | 1         | Memory Mgmt.    | sys_munmap()         |
> ++-------------------+-----------+-----------------+----------------------+
> +| brk               | 3         | Memory Mgmt.    | sys_brk()            |
> ++-------------------+-----------+-----------------+----------------------+
> +| getpid            | 1         | Process Mgmt.   | sys_getpid()         |
> ++-------------------+-----------+-----------------+----------------------+
> +| getuid            | 1         | Process Mgmt.   | sys_getuid()         |
> ++-------------------+-----------+-----------------+----------------------+
> +| getgid            | 1         | Process Mgmt.   | sys_getgid()         |
> ++-------------------+-----------+-----------------+----------------------+
> +| geteuid           | 2         | Process Mgmt.   | sys_geteuid()        |
> ++-------------------+-----------+-----------------+----------------------+
> +| getegid           | 1         | Process Mgmt.   | sys_getegid()        |
> ++-------------------+-----------+-----------------+----------------------+
> +| getppid           | 1         | Process Mgmt.   | sys_getppid()        |
> ++-------------------+-----------+-----------------+----------------------+
> +| arch_prctl        | 2         | Process Mgmt.   | sys_arch_prctl()     |
> ++-------------------+-----------+-----------------+----------------------+
> +
> +Conclusion
> +==========
> +
> +This document is intended to be used as a guide on how to gather fine
> +grained information on the resources in use by workloads using strace.

fine-grained

Thanks.
-- 
~Randy
