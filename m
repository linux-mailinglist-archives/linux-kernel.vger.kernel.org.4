Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0897E634E95
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiKWEC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiKWECu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:02:50 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C01E0AB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 20:02:49 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id v82so187832oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 20:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySZEGeQLDNriKrOLo1dJs5uwir+Qbj3CsrcAGxN4mpk=;
        b=i/IUD3jrtZYypvMXyiJEb9qfZ9qf+AmDI3mig3rHxadg69IrmimZ2Cy8uR0ZsDpqs5
         DVomw1EtmQWdTyjzN5anDglKnK7nY+R0QlHt5Yn0qZOByl+tY6/Xs8SP+tS6zN88565I
         Kh2KIuOvo2uCmO0t1UHwRJQkiDL/Tlc2jXNVOrbzAuI/49eO1zsLQmDLMYFbw09K86Hu
         fMtSuwpwLPb36PeQpdmeHTf1tIhAoqsvzNQU8w6G242DJVFs9xJSCi1idm6oHp41ows5
         iKu/WoJsoNVYQFbV1BDQnmByv1kmTZxB0zwj8YAEnb+lJT8tY2nEpVv/lZBLKHn+Qxcz
         vFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySZEGeQLDNriKrOLo1dJs5uwir+Qbj3CsrcAGxN4mpk=;
        b=sctVE36s9KuzBpLIPIxRcT9xLQoqyNhuPrjOQKAJJYJc+AefNyly4NI94XC0B4WYaH
         J0T5Uttc5NQmmmp6MMVWls4WVndjuK8sACbjFy9BvX/v9pI68tceNvVm6AqBtyTP/n35
         DMLyfkfTgzmpAFmY/CndXN+hIVrsgMe+0mq5meHhV3Jso4ycckHm42mjlMuma/envphT
         vMdwegiFjbHC2pFm9RnrajlhDcrKofWql7kgXt2T8c4IYbBYALMeasOTAhIDo2Kj9qIz
         oa10PXm3BITfXbgNkcHkm6K3cHRitHqyCoEP6HK6Nqvc7Onj1gwXV9YKmlF5m3Ow+yhq
         D4lA==
X-Gm-Message-State: ANoB5pkw4J247Xrv2RVtAUi0XKeCRdJCqkL0rIgva383mCOJCFYJFndi
        Zxzee5U32GMLY6LYcuzIXVr09g==
X-Google-Smtp-Source: AA0mqf5FyMHYhOSMNEGk1zhvDm63vD+AXaPam8LV9ALZA/uO6GJ8utMwCpD19U5CmmrkhOnDz4Wgsw==
X-Received: by 2002:a54:4796:0:b0:355:7ae5:4fe with SMTP id o22-20020a544796000000b003557ae504femr6762744oic.54.1669176168322;
        Tue, 22 Nov 2022 20:02:48 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s7-20020aca4507000000b0035a81480ffcsm6119553oia.38.2022.11.22.20.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 20:02:47 -0800 (PST)
Date:   Tue, 22 Nov 2022 20:02:36 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     hev <r@hev.cc>, Matthew Wilcox <willy@infradead.org>
cc:     Guoqi <chenguoqic@163.com>, Huacai Chen <chenhuacai@loongson.cn>,
        Rui Wang <kernel@hev.cc>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/shmem: Fix undo range for failed fallocate
In-Reply-To: <CAHirt9h2CrLhYML3XW=Vj4=BD5eVDoRAbULVGgNbEdYnAzwCzA@mail.gmail.com>
Message-ID: <9984f58e-826-74c6-1cd4-65366cc01549@google.com>
References: <20221101032248.819360-1-kernel@hev.cc> <Y2KBovUHODJJ8ZnV@casper.infradead.org> <CAHirt9h2CrLhYML3XW=Vj4=BD5eVDoRAbULVGgNbEdYnAzwCzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 3 Nov 2022, hev wrote:
> On Wed, Nov 2, 2022 at 10:41 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, Nov 01, 2022 at 11:22:48AM +0800, Rui Wang wrote:
> > > This patch fixes data loss caused by the fallocate system
> > > call interrupted by a signal.
> > >
> > > Bug: https://lore.kernel.org/linux-mm/33b85d82.7764.1842e9ab207.Coremail.chenguoqic@163.com/
> > > Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> >
> > How does that commit introduce this bug?
> 
> In the test case[1], we created a file that contains non-zero data
> from offset 0 to A-1. and a process try to expand this file by
> fallocate(fd, 0, 0, B), B > A.
> Concurrently, another process try to interrupt this fallocate syscall
> by a signal. I think the expected results are:
> 
> 1. The file is not expanded and file size is A, and the data from
> offset 0 to A-1 is not changed.
> 2. The file is expanded and the data from offset 0 to A-1 is not
> changed, and from A to B-1 contains zeros.
> 
> Now, the unexpected result is that the file is not expanded and the
> data that from offset 0 to A-1 is changed by
> truncate_inode_partial_folio that called
> from shmem_undo_range with unfalloc = true.
> 
> This issue is only reproduced when file on tmpfs, and begin from this
> commit: b9a8a4195c7d ("truncate,shmem: Handle truncates that split
> large folios")

Like Matthew, I was sceptical at first.

But I currently think that you have discovered something important, and
that your patch is the correct fix to it; but I'm still rather confused,
and want to do some more thinking and testing: this mail is mainly to
signal to Matthew that I'm on it, so he doesn't have to rush to look
at it when he's back.

I was able to reproduce it with the test case, once I multiplied both
of the usleep intervals by 10 - before that, it was too difficult for
it to complete a fallocate: guess the timing is different on my x86 box.

Hugh
