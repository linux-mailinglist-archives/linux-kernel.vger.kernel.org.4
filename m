Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A496F2647
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjD2URp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjD2URm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 16:17:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC25E57
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:17:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so716845a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682799460; x=1685391460;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFiB6ytrVKj/f6xCbTDWl4yWJ/Q1XjEK8T+2S6imf1E=;
        b=ckhI7YSalDo0gVPkZX3y0qPl1uNA7CqFa8/4xrOteEHCuf72A+45+dISdfdHAgH8c9
         Cbq3t/XsjCWSqvq+BtsjcNK4uftpXQuhhKN0dPy3ZX9fF3YEeX3iWRzpD0npnJBfk5bz
         PsjLBnDcDY8E6q+14CLo0YpidmB++p2/IXze6+aao6dOYy6KeVn8b9u2fEu6lriZNest
         PKcREt/kS+uzBkXRPehfASAD7lDgkT//MnOdn2lHVXy6D8QFm57lSMFLFsCk4/hmR3qP
         g9nJb7ydjGYhip6eoC+pWvOy4tJm/p76YJY0OsmLe0DGpfWutGkk75eUfK479JUFE1Ej
         hBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799460; x=1685391460;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFiB6ytrVKj/f6xCbTDWl4yWJ/Q1XjEK8T+2S6imf1E=;
        b=MqPbfEuzhJKKxBfUCf0W5Arnt3grTj007Di6lqgUEZU5Nv5h+sUyti1NvsfzpOlw8Q
         HT79U2vELHxJsO7XLonprxxIOctMiVpuTLoq8VCRmBAw0YcNxqr6Tey3g4KOLPqvvS1B
         h5KLtwzSGlqpjiEJh8P0gnhoe/E3XrIhNGILPE/02qB3ED8THMy4IdDf0omjocCe7kGy
         LZTh6uc2TNOTzvOdOXB/AP3fodcyPGwrSo23xBLWPbjQbZ0b8BE6W56+/pD7BPT7eL7m
         P7rtYFSh7Yq5LMeDZio4uuiqRZ43k2KWe3kEZlVU2oQdCCTGjsjeAZd+Yf6WxDWcz6ST
         TeTQ==
X-Gm-Message-State: AC+VfDzGIgi/9pSkBzCyPhLXiuzRYNXrwnkJpLAQs/14zXrw1JE4RXxy
        uF/roXuKjoq1JTPqFAhbDRv9Rg==
X-Google-Smtp-Source: ACHHUZ49aJWNY1E5qUu3lujxh4rbVwp8/wmyvBrQN0Vd47cPc3ONhq23W7fKGmFhRbb61OlkDqx+zQ==
X-Received: by 2002:a17:902:ea07:b0:1a9:baa4:8681 with SMTP id s7-20020a170902ea0700b001a9baa48681mr9261344plg.24.1682799460249;
        Sat, 29 Apr 2023 13:17:40 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c14900b001a9a36c5216sm6303823plj.80.2023.04.29.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:17:39 -0700 (PDT)
Date:   Sat, 29 Apr 2023 13:17:39 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 13:17:16 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: fixup in-flight collision with ARCH_WANT_OPTIMIZE_VMEMMAP rename
In-Reply-To: <20230429-neurology-sudoku-8d53b23d01b8@spud>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-b5a20207-95a2-4607-9e6c-52396d569d91@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023 02:32:33 PDT (-0700), Conor Dooley wrote:
> On Sat, Apr 29, 2023 at 10:27:33AM +0100, Conor Dooley wrote:
>> From: Conor Dooley <conor.dooley@microchip.com>
>> 
>> Lukas warned that ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP had been
>> renamed in the mm tree & that RISC-V would need a fixup as part of the
>> merge. The warning was missed however, and RISC-V is selecting the
>> orphaned Kconfig option.
>> 
>> Fixes: 89d77f71f493 ("Merge tag 'riscv-for-linus-6.4-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux")
>> Reported-by: Lukas Bulwhan <lukas.bulwhan@gmail.com>
>
> That should have been Lukas Bulwahn <lukas.bulwahn@gmail.com>.
> This is what I get for hand-typing an email address that I could have
> copied from lore I suppose.
>
>> Link: https://lore.kernel.org/linux-riscv/CAKXUXMyVeg2kQK_edKHtMD3eADrDK_PKhCSVkMrLDdYgTQQ5rg@mail.gmail.com/
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>> I guess you picking this up for your second PR makes the most sense
>> Palmer?

Yep, except it crashes b4

$ b4 shazam -lts https://lore.kernel.org/all/20230429-trilogy-jolly-12bf5c53d62d@spud/
Grabbing thread from lore.kernel.org/all/20230429-trilogy-jolly-12bf5c53d62d%40spud/t.mbox.gz
Analyzing 2 messages in the thread
Checking attestation on all messages, may take a moment...
Traceback (most recent call last):
  File "/home/palmer/.local/src/b4/b4/command.py", line 383, in <module>
    cmd()
  File "/home/palmer/.local/src/b4/b4/command.py", line 366, in cmd
    cmdargs.func(cmdargs)
  File "/home/palmer/.local/src/b4/b4/command.py", line 100, in cmd_shazam
    b4.mbox.main(cmdargs)
  File "/home/palmer/.local/src/b4/b4/mbox.py", line 713, in main
    make_am(msgs, cmdargs, msgid)
  File "/home/palmer/.local/src/b4/b4/mbox.py", line 101, in make_am
    am_msgs = lser.get_am_ready(noaddtrailers=cmdargs.noaddtrailers,
  File "/home/palmer/.local/src/b4/b4/__init__.py", line 552, in get_am_ready
    checkmark, trailers, attcrit = lmsg.get_attestation_trailers(attpolicy, maxdays)
  File "/home/palmer/.local/src/b4/b4/__init__.py", line 1319, in get_attestation_trailers
    for attestor in self.attestors:
  File "/home/palmer/.local/src/b4/b4/__init__.py", line 1158, in attestors
    self._load_patatt_attestors()
  File "/home/palmer/.local/src/b4/b4/__init__.py", line 1261, in _load_patatt_attestors
    patatt_config = patatt.get_config_from_git(r'patatt\..*', multivals=['keyringsrc'])
AttributeError: module 'patatt' has no attribute 'get_config_from_git'

So I probably need to just go update my setup, I've got a bunch of wacky stuff.
I'll try and remember to do so, but I'm going to scrub through other bits
first...

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

>> 
>> CC: Palmer Dabbelt <palmer@dabbelt.com>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> CC: Lukas Bulwhan <lukas.bulwhan@gmail.com>
>> CC: linux-riscv@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> ---
>>  arch/riscv/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 5c88ac4b52be..e1bdb3fb16cc 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -46,9 +46,9 @@ config RISCV
>>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>>  	select ARCH_WANT_FRAME_POINTERS
>>  	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
>> -	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>>  	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
>> +	select ARCH_WANT_OPTIMIZE_VMEMMAP
>>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>>  	select BUILDTIME_TABLE_SORT if MMU
>> -- 
>> 2.39.2
>> 
