Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A1715EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjE3MTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjE3MTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:19:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40104B0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:19:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685449161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50HvU9GOF0gSazEmOVYum7UqhAHwfqwiFsAZwlEcNIw=;
        b=JaTSrSl6YEG7WWybccb5cGYXDOV3kv50U1WoPXgyhRSfyDaam8yTv/zT9gADHuVOQsv5yp
        zB3JLN9vbpMjyz5dMlkT2Y8JbAqdOr7nTsmC5v1zRD+9MSy09mVJOUtgX7kw7+7FQKR2qr
        HeGYge9+08e5EqZNuxlTCSLhwZgVj3RQpyaIXtFynDSYv4HDgvRA0bGxsI//COf+nfjHI4
        Ihwx8gbH/rPOkG38reAIZ5KsQC+FZOOBs6mix5KUb9RAzWWdJvTmeuT2PBElkYIWXR8rsG
        CcuulNGO6BmkV/Lpe4f+tWGDJfznRG+kl5StIzOxvGvv5pTBRvwrjZM1XWAfmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685449161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50HvU9GOF0gSazEmOVYum7UqhAHwfqwiFsAZwlEcNIw=;
        b=E+Mp5jkQ5meIb55uz/ejGv2t6gQBuKRjd1BnhSVVEXsdMYJ/g25PN2SuWi4Bd6Iz5jA0cN
        ay3elWyVmTxFgHAQ==
To:     "Liao, Chang" <liaochang1@huawei.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>
Subject: Re: [PATCH v5 1/3] genirq: Use hlist for managing resend handlers
In-Reply-To: <56c6dc9a-a5a6-368a-abd4-cace43ceaec0@huawei.com>
References: <20230519134902.1495562-1-sdonthineni@nvidia.com>
 <20230519134902.1495562-2-sdonthineni@nvidia.com>
 <6dc6642a-1e7c-f111-1fa2-be54826ecef6@huawei.com> <871qiylsc9.ffs@tglx>
 <56c6dc9a-a5a6-368a-abd4-cace43ceaec0@huawei.com>
Date:   Tue, 30 May 2023 14:19:21 +0200
Message-ID: <87a5xmj9km.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2023 at 09:59, Chang Liao wrote:
> =E5=9C=A8 2023/5/30 5:51, Thomas Gleixner =E5=86=99=E9=81=93:
>>> What is the benefit of using hlist here? If you want to enjoy the
>>> low latency of querying elements by key, you must define a hlist table
>>> with a reasonable number of buckets. Otherwise, I don't think the time
>>> complexity of hlist is better than a regular double-linked list,
>>> right?
>>=20
>> What's complex about hlist in this case? Please explain.
>
> Honestly, it is not about the complexity. Perhaps I do not understand the
> usage of hlist very deeply. I have searched some codes in the kernel and
> found that hlist is always used to speed up arbitrary querying, such as
> searching a registered kprobe by address. Back to this patch, these resend
> IRQs are organized in a sequence list actually, and traveled one by one to
> handle. Further, by comparing the difference between hlist_empty, hlist_a=
dd_head,
> hlist_del_init, and their counterparts in list, it looks like a regular l=
inked
> list is also good enough.

Sure that works too.

The main difference between regular linked lists and hlist is that the
list head of hlist is half the size of a regular double linked list.

The only downside of hlist is that there is no back link in the list
head to the tail. Searching for the tail is O(N) while on a double
linked list it's O(1).

Nothing in this use case needs to access the tail. So what's your
problem?

Thanks,

        tglx
