Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCC163CC48
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiK3AJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiK3AJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:09:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F432064
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:09:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669766977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qa43tGVXeW4GLXmAGfy/HHjNnSkveZ5ZKH3FAxBBm8E=;
        b=Nga4lBM31wLAIA5sJLJ1qTEdziW2/Qg1qY2gI3s0E0XXvJjV6zxxGnDuMhbn7pjKWU/+aq
        wtnZO6bhQj3JtB/mkqmiAFGsFf/wT7Xr0/b6OKn0MExu8jg1rMcJfP8gh6gctCHF1DPB33
        +UxwxLWKmPtKwuSiQYFBnC9Fc0RFFYmUFNggAB0dDsblGT//lwVy7Qtdy+77uuaERg5EhA
        pSpG7f0cwQYlzmHZYzPBL6VQPoLlTfag22KkiJmlBw9PeNrfpPwsmn0671uFtF88tPm1vV
        +2fg4Sk3H+djMrlDNCl7ElRjZeog1FzRxDzbSvd+Q1OePtCU9h7KfCa1/oQkwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669766977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qa43tGVXeW4GLXmAGfy/HHjNnSkveZ5ZKH3FAxBBm8E=;
        b=MkhFriB+SPO4Mqc0wOIjQW6HAf1fj4v1WFFKElkJVvhPsf60rL/hFanovCWzY2ry4fd+D2
        11vKFy1vlZL9gECQ==
To:     Jann Horn <jannh@google.com>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] time/namespace: Forbid timens page faults under
 kthread_use_mm()
In-Reply-To: <CAG48ez2AqgQJKXYdLXh-WaoMuKBgCUuVge_8RAghKBDhfkeJJw@mail.gmail.com>
References: <20221129191839.2471308-1-jannh@google.com>
 <20221129191839.2471308-2-jannh@google.com> <87fse1v4rf.ffs@tglx>
 <CAG48ez3UBb3Aq7+AFSmRj5a9czmew5b0PEdhWQ9qvQdeejnJZg@mail.gmail.com>
 <CAG48ez2AqgQJKXYdLXh-WaoMuKBgCUuVge_8RAghKBDhfkeJJw@mail.gmail.com>
Date:   Wed, 30 Nov 2022 01:09:36 +0100
Message-ID: <87tu2hti9r.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2022 at 23:34, Jann Horn wrote:
> On Tue, Nov 29, 2022 at 11:28 PM Jann Horn <jannh@google.com> wrote:
>> That said, I haven't actually tried it. But I don't think there's
>> anything in the page fault handling path that distinguishes between
>> copy_from_user() faults in kthread context and other userspace faults
>> in a relevant way?
>
> Ah, but I guess even if this can happen, it's not actually as bad as I
> thought, since kthreads are in init_time_ns, and init_time_ns doesn't
> have a ->vvar_page, so this isn't going to lead to anything terrible
> like page UAF, and it's just a garbage-in-garbage-out scenario.

True, but catching the kthread -> fault (vvar/vdso page) scenario
definitely has a value.

Thanks,

        tglx
