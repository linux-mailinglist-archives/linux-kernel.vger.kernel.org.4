Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E8C701423
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 05:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbjEMDSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 23:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMDSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 23:18:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED74C24
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 20:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA0B661149
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50907C433A4
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683947930;
        bh=U5RdjGyzrpafdd6VMn6lthVyZhq0kyu8Vz9xNq4PSio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ieAjxlpXOZbqxSw2UvKROALnZalf3cLuKLfSzNsKWoL24oP4MZWDKXaecOqqYaxEx
         BqhYfZMggXPuBGuUn42VEjBjvj/LsuGXOZ/8FmtQnD2Rg3gDObHhR3cf1RfXMihB7y
         eYRPVwhbhVf1cKF5V4deqsLEEM3ehD7zljEQ9C3X2tO/4H5tSiVCprMlHcVaXfcNzz
         UfWrwgN31bnWY3Zpf8whM4q4a6vJDNd0t35nF00qPeNNIslszMj978wUKBVbQdQ965
         IALLpCsq3d6KAwJNdCskCMstdwuWd57UPTLhqjQxYlLWAUPVvkPoSTU3/woCggR0RC
         l0Eed73+/nB2g==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-96622bca286so1589579866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 20:18:50 -0700 (PDT)
X-Gm-Message-State: AC+VfDxMnK3m/ty1LfJemocuaEO8I1jMWj1zlOOZCcqfC+HNxDbWD/sM
        oynUROlkB1nsMC2p1HBsapY3rbM1YW+YJIPjYqM=
X-Google-Smtp-Source: ACHHUZ7N0BhHvhYAehkDtJRGoL+aCoaNYJosYN/PT3NLlWOusNKf1/LccnvypWJ8hxfwPST31nRlKeNnmPppeas8HHw=
X-Received: by 2002:a17:907:1c03:b0:94e:4489:f24d with SMTP id
 nc3-20020a1709071c0300b0094e4489f24dmr25934170ejc.61.1683947928452; Fri, 12
 May 2023 20:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230509104127.1997562-1-chenhuacai@loongson.cn> <87ild0w5qs.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ild0w5qs.fsf@email.froward.int.ebiederm.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 13 May 2023 11:18:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H79bUF396+dWaafanzcMq41VtcOsfa_3SYSUftyNDOyvw@mail.gmail.com>
Message-ID: <CAAhV-H79bUF396+dWaafanzcMq41VtcOsfa_3SYSUftyNDOyvw@mail.gmail.com>
Subject: Re: [PATCH RFC] kthread: Unify kernel_thread() and user_mode_thread()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric,

On Wed, May 10, 2023 at 11:45=E2=80=AFPM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Huacai Chen <chenhuacai@loongson.cn> writes:
>
> > Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for ini=
t
> > and umh") introduces a new function user_mode_thread() for init and umh=
.
> > But the name is a bit confusing because init and umh are indeed kernel
> > threads at creation time, the real difference is "they will become user
> > processes".
>
> No they are not "kernel threads" at creation time.  At creation time
> init and umh are threads running in the kernel.
>
> It is a very important distinction and you are loosing it.
>
> Because they don't have a kthread_struct such tasks in the kernel
> are not allowed to depend on anything that is ``kthread''.
Hmm, traditionally, we call a "task" without userland address space
(i.e., the task_struct has no mm, it shares kernel's address space) as
a kernel thread, so init and umh are kernel threads until they call
kernel_execve(). Of course in your patch a kernel thread should have a
"kthread" struct (I can't grep "kthread_struct" so I suppose you are
saying "kthread"), but I think the traditional definition is more
natural for most people?

Huacai

>
> Having this a separate function highlights the distinction.
> Highlighting should hopefully cause people to ask why there is a
> distinction, and what is going on.
>
> > So let's unify the kernel_thread() and user_mode_thread() to
> > kernel_thread() again, and add a new 'user' parameter for init and
> > umh
>
> Now that is confusing.
>
> Eric
