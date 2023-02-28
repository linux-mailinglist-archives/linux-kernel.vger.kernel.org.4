Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0F6A622A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjB1WLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjB1WLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:11:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A476722034
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:11:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x34so11384085pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oK0R6uzsJwHHotrDE5yxMN7yczxtEm7If2jkjBsqnnM=;
        b=d5RZQIeJVdrSg81wAnTaq6vURlWF1WSn4JCtD+C8xy6vbaCISN1Gz5GH0SUY1iApd/
         vfe8qezhYYhHKUhW5BLksbV9BufwDC59wjEuoYGXIoKYgYPK8xSx0+9NU+66nE2wn2ZC
         rPo4FUGcOQh6GePRKk1WUTKq5fyCqBMgyHaR5Ram0VhsOn0WMtrVG8K3xLoChkyHk1NH
         OGSCElgKxF4EWo1MAbK+gbLLLQQRelvw93nrKOYg53GJ8t4LGD435gWsuKH/7bsUIwCU
         Uozu8r/FMu0dwFVjBHAwr/x9oRFguOgqsF38ELXsWkZnFJqhO86YmtD7cmbP443ki+9R
         X2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK0R6uzsJwHHotrDE5yxMN7yczxtEm7If2jkjBsqnnM=;
        b=U8AwXmKkQKziCKZb64zBzTfJMZi9QQIKbfD7bmPG+i+OzCWA06TMrKsFTG3BRhY87F
         j9pzXjiNEPA9kMsvSwZVkYjSXtSIyQ9DgVGYXFPnZNL5B/RQoe4RIffEpBuoV19XnX7t
         BRNPrJQ2xZanHY2mhVYtV6/nE+8ahJevSCvBnNN6sXxk6DWHWyhPI1EBN0aYMdzV9Z6H
         v+Js4jrk3jpf03ExUtEJ6eJo8B2zkBCFCZyecyODzpcaeVAMCLCPqeSIQRz+iTAj5ZXD
         SXU+IV4dzR3owXc+8bXSRwEED5ZR1N4q4ChpV8wgXI6abdcD5xkwqGRB6EaQonXUfp/z
         WSAg==
X-Gm-Message-State: AO0yUKW+v1ENF2BZyWmeduN458lBb0AqKr+PhsLzHzWbG4U/ZraXdp2A
        WlWZ9U8Asj0WHA28f81dFCkqCg==
X-Google-Smtp-Source: AK7set8H/pEwYE4aQRt7YimFDMtG7LUYCz88QANCklRSJDow0akDQOujkLKZfD7p301pkJmWFjHdzg==
X-Received: by 2002:a17:90b:224f:b0:236:9eef:e280 with SMTP id hk15-20020a17090b224f00b002369eefe280mr4798820pjb.46.1677622271032;
        Tue, 28 Feb 2023 14:11:11 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902780500b001992521f23esm6976979pll.100.2023.02.28.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:11:10 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pX8Bf-003Hy6-FP; Wed, 01 Mar 2023 09:11:07 +1100
Date:   Wed, 1 Mar 2023 09:11:07 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Dave Chinner <dchinner@redhat.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [linus:master] [xfs] 304a68b9c6:
 WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release
Message-ID: <20230228221107.GD360264@dread.disaster.area>
References: <202302281653.51938721-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302281653.51938721-yujie.liu@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 04:40:01PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release due to commit (built with gcc-11):
> 
> commit: 304a68b9c63bbfc1f6e159d68e8892fc54a06067 ("xfs: use iomap_valid method to detect stale cached iomaps")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master 058f4df42121baadbb8a980c06011e912784dbd2]
> in testcase: xfstests
> version: xfstests-i386-5a5e419-1_20220926
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: generic-group-32

Which fstest was running at the time this warning was thrown?

> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> [   78.565703][   T59] ------------[ cut here ]------------
> [ 78.570983][ T59] WARNING: CPU: 4 PID: 59 at fs/iomap/buffered-io.c:984 iomap_write_delalloc_release (buffered-io.c:?) 

Well, that's useless without the function offset or line number to
tell us what warning in that function triggered.

> [   78.581265][   T59] Modules linked in: loop(E) dm_flakey(E) xfs(E) dm_mod(E) intel_rapl_msr(E) intel_rapl_common(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) zstd_compress(E) x86_pkg_temp_thermal(E) libcrc32c(E) intel_powerclamp(E) crc32c_generic(E) coretemp(E) sd_mod(E) t10_pi(E) ipmi_devintf(E) kvm_intel(E) ipmi_msghandler(E) i915(E) crc64_rocksoft_generic(E) kvm(E) irqbypass(E) crc64_rocksoft(E) crc64(E) drm_buddy(E) crc32_pclmul(E) crc32c_intel(E) aesni_intel(E) crypto_simd(E) drm_display_helper(E) cryptd(E) cec(E) mei_wdt(E) wmi_bmof(E) rapl(E) ahci(E) evdev(E) ttm(E) xhci_pci(E) intel_cstate(E) xhci_hcd(E) libahci(E) i2c_i801(E) mei_me(E) drm_kms_helper(E) syscopyarea(E) intel_uncore(E) usbcore(E) i2c_smbus(E) sysfillrect(E) libata(E) mei(E) sysimgblt(E) intel_pch_thermal(E) fb_sys_fops(E) usb_common(E) video(E) fan(E) thermal(E) wmi(E) acpi_pad(E) button(E) fuse(E) drm(E) configfs(E) autofs4(E)
> [   78.661092][   T59] CPU: 4 PID: 59 Comm: kworker/u16:2 Tainted: G            E      6.1.0-rc4-00008-g304a68b9c63b #1

This looks like a broken kernel install. Why are all the modules
tainted?

> [   78.671542][   T59] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
> [   78.679578][   T59] Workqueue: loop0 loop_rootcg_workfn [loop]
> [ 78.685393][ T59] EIP: iomap_write_delalloc_release (buffered-io.c:?) 
> [ 78.691449][ T59] Code: e8 cf 94 ed ff f0 ff 4b 1c 74 45 8b 45 e0 8b 40 20 83 c0 10 e8 ab 93 d8 ff 8d 65 f4 89 f0 5b 5e 5f 5d c3 0f 0b e9 f9 fd ff ff <0f> 0b e9 e0 fd ff ff 0f 0b 8b 45 cc 8b 4d f0 8b 55 d0 39 c8 89 d0
> All code
> ========
>    0:	e8 cf 94 ed ff       	callq  0xffffffffffed94d4
>    5:	f0 ff 4b 1c          	lock decl 0x1c(%rbx)
>    9:	74 45                	je     0x50
>    b:	8b 45 e0             	mov    -0x20(%rbp),%eax
>    e:	8b 40 20             	mov    0x20(%rax),%eax
>   11:	83 c0 10             	add    $0x10,%eax
>   14:	e8 ab 93 d8 ff       	callq  0xffffffffffd893c4
>   19:	8d 65 f4             	lea    -0xc(%rbp),%esp
>   1c:	89 f0                	mov    %esi,%eax
>   1e:	5b                   	pop    %rbx
>   1f:	5e                   	pop    %rsi
>   20:	5f                   	pop    %rdi
>   21:	5d                   	pop    %rbp
>   22:	c3                   	retq   
>   23:	0f 0b                	ud2    
>   25:	e9 f9 fd ff ff       	jmpq   0xfffffffffffffe23
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	e9 e0 fd ff ff       	jmpq   0xfffffffffffffe11
>   31:	0f 0b                	ud2    
>   33:	8b 45 cc             	mov    -0x34(%rbp),%eax
>   36:	8b 4d f0             	mov    -0x10(%rbp),%ecx
>   39:	8b 55 d0             	mov    -0x30(%rbp),%edx
>   3c:	39 c8                	cmp    %ecx,%eax
>   3e:	89 d0                	mov    %edx,%eax
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	e9 e0 fd ff ff       	jmpq   0xfffffffffffffde7
>    7:	0f 0b                	ud2    
>    9:	8b 45 cc             	mov    -0x34(%rbp),%eax
>    c:	8b 4d f0             	mov    -0x10(%rbp),%ecx
>    f:	8b 55 d0             	mov    -0x30(%rbp),%edx
>   12:	39 c8                	cmp    %ecx,%eax
>   14:	89 d0                	mov    %edx,%eax
> [   78.710792][   T59] EAX: 2335a000 EBX: 00000004 ECX: fffffffc EDX: 00000004
> [   78.717707][   T59] ESI: 2335b000 EDI: 00000000 EBP: c3187c24 ESP: c3187bf0
> [   78.724624][   T59] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010297
> [   78.732056][   T59] CR0: 80050033 CR2: b7da00b0 CR3: 02350000 CR4: 003506f0
> [   78.738971][   T59] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   78.745887][   T59] DR6: fffe0ff0 DR7: 00000400
> [   78.750389][   T59] Call Trace:
> [ 78.753508][ T59] iomap_file_buffered_write_punch_delalloc (??:?) 
> [ 78.760183][ T59] ? xfs_buffered_write_iomap_end (xfs_iomap.c:?) xfs
> [ 78.766541][ T59] xfs_buffered_write_iomap_end (xfs_iomap.c:?) xfs

What's with all the broken/missing function offsets and
file/line numbers in the stack trace?

Please fix your tooling - this report isn't useful with all the
offset/line number information being broken like this

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
