Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8F67EC36
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjA0RN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjA0RNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:13:52 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B40A26A9;
        Fri, 27 Jan 2023 09:13:46 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5E8412D3;
        Fri, 27 Jan 2023 17:13:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5E8412D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674839625; bh=S3dil/jJhCjqHHB5iBm3wiRiGo1U/GbKwYcoUCM075w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DYlgWhGQLcMyDRc/eD0FUj3janxYh2qU1eQJ/+K22NrHu4AHeYxVaXHM3Zatp3AbL
         FYTg6MZrc9pOmqv05fiDVAIxMSkhuWCJfDM2gmi3HP2wVWGTbr+WJh8OWA0wtHurvh
         JbhGE/o8jdkBEddlFO/j50vFhC3CYMdnMhXN3orF/4k/QL589embhsUuwhDIp6BZRu
         m674jlcQAdAQq67gCfQmz4kZWNHJo+Xj8QMQ4Zl9Zga0MVMXI1CfPLgPKzFi3vPA2s
         2epGlsDxdgIwiT9VbvmBQ9X+fbKQkPU1sWI4/JQZbTMZFPFtUQt6t4BX5N7XHKFJP9
         rn2FBJdfm49ow==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, sshefali021@gmail.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: add workload-tracing document to admin-guide
In-Reply-To: <20230127165440.19158-1-skhan@linuxfoundation.org>
References: <20230127165440.19158-1-skhan@linuxfoundation.org>
Date:   Fri, 27 Jan 2023 10:13:44 -0700
Message-ID: <87bkmj99yv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

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
>  Documentation/admin-guide/index.rst           |  11 +
>  .../admin-guide/workload-tracing.rst          | 486 ++++++++++++++++++
>  2 files changed, 497 insertions(+)
>  create mode 100644 Documentation/admin-guide/workload-tracing.rst

This seems like generally good stuff, thanks.  I have a few nits...

> +Key Points
> +==========
> +
> + * Understanding system resources necessary to build and run a workload
> +   is important.
> + * Linux tracing and strace can be used to discover the system resources
> +   in use by a workload. The completeness of the system usage information
> +   depends on the completeness of coverage of a workload.
> + * Performance and security of the operating system can be analyzed with
> +   the help of tools such as `perf <https://man7.org/linux/man-pages/man1/perf.1.html>`_, `stress-ng <https://www.mankier.com/1/stress-ng>`_, `paxtest <https://github.com/opntr/paxtest-freebsd/blob/hardenedbsd/0.9.14-hbsd/README>`_.
> + * Once we discover and understand the workload needs, we can focus on them
> +   to avoid regressions and use it to evaluate safety considerations.
> +
> +Methodology
> +===========
> +
> +`strace <https://man7.org/linux/man-pages/man1/strace.1.html>`_ is a diagnostic, instructional, and debugging tool and can be used to discover the system resources in use by a workload. Once we discover and understand the workload needs, we can focus on them to avoid regressions and use it to evaluate safety considerations. We chose strace tool to trace workloads.

I know that the 80-column limit is controversial to some; I happen to
believe that text should certainly adhere to it for basic readability
reasons.  But can we all agree that nearly 400 columns is too many? :)
Please line-break the whole document properly.

> +Install tools to build Linux kernel and tools in kernel repository. scripts/ver_linux is a good way to check if your system already has the necessary tools.
> +::
> +
> +  sudo apt-get build-essentials flex bison yacc
> +  sudo apt install libelf-dev systemtap-sdt-dev libaudit-dev libslang2-dev libperl-dev libdw-dev
> +
> +Browsing kernel sources
> +::
> +
> +  sudo apt-get install cscope
> +
> +Install stress-ng and paxtest
> +::
> +
> +  apt-get install stress-ng
> +  apt-get install paxtest

For literal blocks, the "::" can go at the end of the previous line,
which makes the document a bit more readable.

[...]

> +SPDX-License-Identifier: CC-BY-4.0
> +==================================
> +This document is released under the Creative Commons Attribution 4.0 International License, available at https://creativecommons.org/licenses/by/4.0/legalcode. Pursuant to Section 5 of the license, please note that the following disclaimers apply (capitalized terms have the meanings set forth in the license). To the extent possible, the Licensor offers the Licensed Material as-is and as-available, and makes no representations or warranties of any kind concerning the Licensed Material, whether express, implied, statutory, or other. This includes, without limitation, warranties of title, merchantability, fitness for a particular purpose, non-infringement, absence of latent or other defects, accuracy, or the presence or absence of errors, whether or not known or discoverable. Where disclaimers of warranties are not allowed in full or in part, this disclaimer may not apply to You.
> +
> +To the extent possible, in no event will the Licensor be liable to You on any legal theory (including, without limitation, negligence) or otherwise for any direct, special, indirect, incidental, consequential, punitive, exemplary, or other losses, costs, expenses, or damages arising out of this Public License or use of the Licensed Material, even if the Licensor has been advised of the possibility of such losses, costs, expenses, or damages. Where a limitation of liability is not allowed in full or in part, this limitation may not apply to You.
> +
> +The disclaimer of warranties and limitation of liability provided above shall be interpreted in a manner that, to the extent possible, most closely approximates an absolute disclaimer and waiver of all liability.
> +
> +Note: Only the content of this RST file as found in the Linux kernel sources
> +is available under CC-BY-4.0, as versions of this text that were processed
> +(for example by the kernel's build system) might contain content taken from
> +files which use a more restrictive license.

This is just the kind of license boilerplate that we have been trying
hard to get rid of.  *Dual*-licensing with CC4 is OK, and the SPDX line
at the top properly reflects that; this additional text shouldn't be here.

> +..
> +   end-of-content

...and that seems a bit redundant somehow...:)

Thanks,

jon
