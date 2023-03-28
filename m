Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7676CCAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjC1Trb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC1Tr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED0C137;
        Tue, 28 Mar 2023 12:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D42D6162D;
        Tue, 28 Mar 2023 19:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EAAC433EF;
        Tue, 28 Mar 2023 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680032846;
        bh=BTkbTujUaAkGuowKQ5synqATSZ292CG9RGh0K8omwsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFshm0hYAX3X+wUqaw75pI+7Wzk5JBtS4wuG2+/VWfeAI2rXxSssKcMUcP7DTJkzo
         ahvUtZAiZOENFni64DDw0l5p5iSQohD+px6YqTW1wUrb28zV4W8PHOJvjp+VAkqT4k
         7CcvcFK5jrUJbYFdTKg26UGIBbGoe9pyzcIH2YmcZAn3YLEYWj/D0S/au3NCwIZj6x
         X5PpT8hMnpBPjiP+8EumbAlD8CjaCTBxqdEbdYLQZp5K97x0YqooxrzAhgq5jT2GLg
         l1Y8GiKAbTOiOq0vDNCnlx/cjGhKtsXQikkD1zRHKEnZkQ73V1ofN/OgLXJfXnhU/D
         4SsZaDVUQCshQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E07444052D; Tue, 28 Mar 2023 16:47:23 -0300 (-03)
Date:   Tue, 28 Mar 2023 16:47:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <ZCNES6N7AkskjD0o@kernel.org>
References: <20230317095025.49aa34f9@canb.auug.org.au>
 <20230322083956.5c051777@canb.auug.org.au>
 <CAP-5=fUHqrQWPjk7QJB=r2Gzj7z5X3nL4bRuBAKzy2HvdSAr-A@mail.gmail.com>
 <20230323095437.1ecccec1@canb.auug.org.au>
 <ZBxTyLqkIaoVhIXU@kernel.org>
 <20230328123332.0a3e2b6d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328123332.0a3e2b6d@canb.auug.org.au>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 28, 2023 at 12:33:32PM +1100, Stephen Rothwell escreveu:
> Hi Arnaldo,
> 
> Just a few datapoints:
> 
> My build machine (Debian Testing PowerpcLE, not quite the latest
> kernel):
 
> On Thu, 23 Mar 2023 10:27:36 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >  Which improves a bit the situation.
> > 
> > We could check if bpftool is available and if not, suggest installing
> > it.
> 
> $ ls -l /usr/sbin/bpftool
> -rwxr-xr-x 1 root root 790504 Mar  6 02:33 /usr/sbin/bpftool
> 
> > If it is available, we could check if /sys/kernel/bpf/ is available, if
> > not suggest using a kernel with CONFIG_DEBUG_INFO_BTF=y, as most distros
> > have by now.

The config files you used don't match the running kernels
 
> $ uname -a
> Linux zz1 6.0.0-5-powerpc64le #1 SMP Debian 6.0.10-2 (2022-12-01) ppc64le GNU/Linux
> $ ls -l /sys/kernel/bpf/
> ls: cannot access '/sys/kernel/bpf/': No such file or directory
> $ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.0.0-5-powerpc64le
> # CONFIG_DEBUG_INFO_BTF is not set
> 
> And in the latest powerpc64le kernel:
> 
> $ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.1.0-5-powerpc64le
> # CONFIG_DEBUG_INFO_BTF is not set
> 
> Debian Testing arm64, not quite the latest kernel:
> 
> $ uname -a
> Linux oak 6.1.0-5-arm64 #1 SMP Debian 6.1.12-1 (2023-02-15) aarch64 GNU/Linux
> $ ls -l /sys/kernel/bpf/
> ls: cannot access '/sys/kernel/bpf/': No such file or directory
> $ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.1.0-5-arm64
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_DEBUG_INFO_BTF_MODULES=y

The running kernel is 6.1.12-1, the .config is 6.1.0-5

> Debian Testing amd64, the latest kernel:
> 
> $ uname -a
> Linux pine 6.1.0-6-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.15-1 (2023-03-05) x86_64 GNU/Linux
> $ ls -l /sys/kernel/bpf/
> ls: cannot access '/sys/kernel/bpf/': No such file or directory
> $ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.1.0-6-amd64
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_DEBUG_INFO_BTF_MODULES=y


Ditto, 6.1.15-1 != 6.1.0-6

> 
> Debian Stable amd64, the latest kernel:
> 
> $ uname -a
> Linux gimli 5.10.0-21-cloud-amd64 #1 SMP Debian 5.10.162-1 (2023-01-21) x86_64 GNU/Linux
> $ ls -l /sys/kernel/bpf/
> ls: cannot access '/sys/kernel/bpf/': No such file or directory
> $ grep CONFIG_DEBUG_INFO_BTF /boot/config-5.10.0-21-cloud-amd64
> CONFIG_DEBUG_INFO_BTF=y

Ditto, 5.10.162-1  != 5.10.0-21-cloud

Here:

[acme@quaco pahole]$ grep CONFIG_DEBUG_INFO_BTF /boot/config-`uname -r`
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
[acme@quaco pahole]$ uname -r
6.1.18-100.fc36.x86_64
[acme@quaco pahole]$

[acme@quaco pahole]$ ls -la /sys/kernel/btf/vmlinux
-r--r--r--. 1 root root 5499812 Mar 20 17:45 /sys/kernel/btf/vmlinux
[acme@quaco pahole]$ ls -la /sys/kernel/btf/nfsv4
-r--r--r--. 1 root root 319948 Mar 28 16:46 /sys/kernel/btf/nfsv4
[acme@quaco pahole]$ lsmod | grep -w nfsv4
nfsv4                1085440  1
dns_resolver           16384  1 nfsv4
nfs                   532480  2 nfsv4
sunrpc                704512  26 nfsd,rpcrdma,nfsv4,auth_rpcgss,lockd,rpcsec_gss_krb5,nfs_acl,nfs
[acme@quaco pahole]$ ls -la /sys/kernel/btf/nfsd
-r--r--r--. 1 root root 596066 Mar 28 16:46 /sys/kernel/btf/nfsd
[acme@quaco pahole]$ ls -la /sys/kernel/btf/lockd
-r--r--r--. 1 root root 180234 Mar 28 16:46 /sys/kernel/btf/lockd
[acme@quaco pahole]$
 
> -- 
> Cheers,
> Stephen Rothwell
