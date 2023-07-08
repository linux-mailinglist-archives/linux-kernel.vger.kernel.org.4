Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E106F74BE9C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGHRaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGHRaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 13:30:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FA6191
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 10:30:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2948941f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688837401; x=1691429401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KYD6jlXBis0p+PBTKlv8qzvLQ1gqj2dZYI23tZfDs+4=;
        b=QzeQwAceDJjVXJvGJM+3WucNS3YwkJuqcjbVwBANp9B0yMPX6R+mPsBtM7EmTqinwO
         JDbtzZwZMizOiOl7fV7piKWPbwokJSlqBFiq4V9vWh/dTGbk4ezsUKKlbbj/sW9ieE+g
         T8gQKKc3AlrB4ZvceyWg+gm3K6DJ5+evwa4Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688837401; x=1691429401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYD6jlXBis0p+PBTKlv8qzvLQ1gqj2dZYI23tZfDs+4=;
        b=NGNzuseruZF5ANmaGoiHFRlZ2yGjfd5aTffj/tBMeXiPtp4MBpo6s9HoKqEdFNhdBy
         6HzPi7Laz/HwSpWoAiWKO1/5Og0xIgq6F0cR301414fxt3hecAfb9SDErvRunK4YgZQj
         VMsnhGXopiRR9RJ2HxXXZylutGP+V2uAjIEc7h1O+/yvXykEsUcXEJFne06/dyTtYuEC
         Lh+/CZQr+2gh+TAhWlIkaFjiRpEypNPxqjCWUzV9XwpnmVvrnfbcqbwnOIoXT/cbqkoW
         36XEnffVXE+2ZyQmRnxj5pd+3jM/VQx9DrwD7mE7X1aoLaufOCIdT9UFv5LJkiFIT//p
         YRFg==
X-Gm-Message-State: ABy/qLa/NpRdoJ1yL/2OtJ4obAQG0VVeqgzb/LLa1QTDaVdbqIsPaqdv
        Fz3g7HKGUmIyzCc6kKSBtlwU6v+eJnAAD2+1Dh7wrjdb
X-Google-Smtp-Source: APBJJlHP5T4bwkT9ohgR3Mxmqn8kMUuojz8x9uA3eBEoPvntdAOfjFeW0OVIqH8AKJ9kmBe4VgvfuQ==
X-Received: by 2002:adf:f0d2:0:b0:313:f07b:801f with SMTP id x18-20020adff0d2000000b00313f07b801fmr6085359wro.44.1688837401654;
        Sat, 08 Jul 2023 10:30:01 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id e15-20020a056402148f00b0051e2cde9e3esm3498425edv.75.2023.07.08.10.29.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 10:29:59 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e292cf214so3869882a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 10:29:59 -0700 (PDT)
X-Received: by 2002:aa7:cc8d:0:b0:51b:e4b4:8bb0 with SMTP id
 p13-20020aa7cc8d000000b0051be4b48bb0mr5997528edt.2.1688837399295; Sat, 08 Jul
 2023 10:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info> <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
 <2023070359-evasive-regroup-f3b8@gregkh> <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
 <2023070453-plod-swipe-cfbf@gregkh> <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
 <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
 <2023070509-undertow-pulverize-5adc@gregkh> <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
 <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org> <df1d7d39-56f3-699c-0d0f-fcc8774f182e@leemhuis.info>
In-Reply-To: <df1d7d39-56f3-699c-0d0f-fcc8774f182e@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 10:29:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKd05V49AbZGF=inYmhU6H_yNvvw1grWyhQfQ=9+5-VQ@mail.gmail.com>
Message-ID: <CAHk-=whKd05V49AbZGF=inYmhU6H_yNvvw1grWyhQfQ=9+5-VQ@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 at 04:35, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> The plan since early this week is to mark CONFIG_PER_VMA_LOCK as broken;
> latest patch that does this is this one afaics:

Bah.

Both marking it as broken and the pending fix seems excessive.

Why isn't the trivial fix just to say "yes, fork() gets the mmap_lock
for writing for a reason, and that reason is that it acts kind of like
mprotect()".

And then just do what those functions do.

IOW, why isn't the fix just to do

  --- a/kernel/fork.c
  +++ b/kernel/fork.c
  @@ -686,6 +686,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
        for_each_vma(old_vmi, mpnt) {
                struct file *file;

  +             vma_start_write(mpnt);
                if (mpnt->vm_flags & VM_DONTCOPY) {
                        vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
                        continue;

and be done with this? Yes, we could move it down a bit more, ignoring
the VM_DONTCOPY vma's, but they are so uncommon as to not matter, so
who cares?

              Linus
