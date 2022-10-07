Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375385F725D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiJGAr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJGArz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:47:55 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73486BCB86
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:47:54 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id d67so1492536ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 17:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+IcUxG/8bdfwhbp6VP9RN21xHZcHPUGPwHgSYZ2tDc=;
        b=IvPDLUYVYcv7i6xEYqj2pK/ic9i0+t9wXkTDZ40VIQ8yZM5bxmlNFQ1MQPTJ0+6iRa
         JRjldH6NhNtHwSOnETQiEOf+KOfhYkd4x+xjq5CIu9/PXJuoZjc1erErakZasuALUlep
         ZS6JG7dCdxKDLtws6lLrJERMwlqKWmCinX5aRevWgRESoS/2ZPV2WJ3hLa+bt6KfMdYP
         2e8N9grppoDD5bJ0HHCCLrIs5lUeBHU1kRDiW3qxOSOTcJ/mqey5tvFdML5N3L7yW029
         2+g9Sg730IZQOmi+2cIGThTikDQ26j8NQgks3rgH9DpZ9iblo+F6fr8BcKJyroTPvYO5
         R4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+IcUxG/8bdfwhbp6VP9RN21xHZcHPUGPwHgSYZ2tDc=;
        b=Rt5al7gJOdyompGoRS4upkxtU/FuBqROXE97O9KZ1irwplXhsxCQRkdbUdhFSs66sp
         X/AYyjopFa23ahVt55uT0zzeianByz0LrN7dLcmvAySxNEWuV2WriS/3ERorZltffL1r
         mn/c0cJ/Pm3jUhEsX7snO7mpqMU7h7waYoS1ySwUd+ednOCecYBaWg+fELfN3f+Jdrtw
         gZSE0CeGiYNkQIYLRvtsYRkYVwaVPm2XR/lfImEEPrLvwnjJdsrmkBqmHKjieMEifJu4
         yZ4f6vwSWOPwR0mqaHFEAjYyVvBALnhsz1EhxoBQ8OMthQSbwdCLWIRRY8MVtyGDmU7v
         YvDA==
X-Gm-Message-State: ACrzQf1riy1MShDvWRbN7OrtnQglO6+P/q4Hv7pd88P7z+pXoOwjONZq
        pQfzMNfTqR1/bzcL1ebuXXCQ299sgX49KUUgu58H+2aFkzZ2og==
X-Google-Smtp-Source: AMsMyM7slrDWoJGHsan+6S5It1PTLpfTN5q1pL+3r1aMElMlYee8QZmqBbua3VWq6he2/l/9IuqhwOkAMwzrKM/DBtk=
X-Received: by 2002:a25:d292:0:b0:6bf:87:21e9 with SMTP id j140-20020a25d292000000b006bf008721e9mr1670311ybg.242.1665103673555;
 Thu, 06 Oct 2022 17:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <202210052318.5ad10912-oliver.sang@intel.com>
In-Reply-To: <202210052318.5ad10912-oliver.sang@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 6 Oct 2022 18:47:17 -0600
Message-ID: <CAOUHufaUFd9umLvR2P11m7o=RsWWAOsKoCPOk=YZ0TggTpiB4g@mail.gmail.com>
Subject: Re: [mm] 763ecb0350: kernel_BUG_at_mm/mmap.c
To:     "Liam R. Howlett" <liam.howlett@oracle.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 9:30 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: 763ecb035029f500d7e6dc99acd1ad299b7726a1 ("mm: remove the vma linked list")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: trinity
> version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
> with following parameters:
>
>         runtime: 300s
>         group: group-03
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/r/202210052318.5ad10912-oliver.sang@intel.com
>
>
> [   63.390267][ T5018] ------------[ cut here ]------------
> [   63.391875][ T5018] kernel BUG at mm/mmap.c:3167!
> [   63.393264][ T5018] invalid opcode: 0000 [#1] SMP PTI
> [   63.394501][ T5018] CPU: 1 PID: 5018 Comm: trinity-c1 Not tainted 6.0.0-rc3-00284-g763ecb035029 #1
> [   63.396050][ T5018] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [ 63.397726][ T5018] RIP: 0010:exit_mmap (mm/mmap.c:3167 (discriminator 1))

Thanks, Oliver.

The attached dmesg doesn't say much. My guess is the oom reaper jumped
in between

        mmap_read_unlock(mm);

        /*
         * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
         * because the memory has been already freed.
         */
        set_bit(MMF_OOM_SKIP, &mm->flags);
        mmap_write_lock(mm);

It seems to me we need to hold the lock for write all the time. But
there is probably a reason we didn't do it in the first place.
