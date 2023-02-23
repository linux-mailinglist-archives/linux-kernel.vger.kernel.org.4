Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804216A04CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjBWJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjBWJ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:29:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E4D532
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677144504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCJtNf7Z4oWc5zRL0fOuzjqSoRk0efn63fAKZeMXiGw=;
        b=Zu2oJ8P+B2st252X2KilfLjnFkP0807qp9Q3gq9FJYqgoN8Icxp0tW9vuWjbttDv0DV7HI
        fWUdkasVwaa3hqvXAtmyIj2+rynKNJm16h5cCnUgv4gulrr/J+MushB36ZDIYWfMiZF3Vw
        CZF723GkrPMOTJMXIfD+ALWesrM36Po=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-345-bUoDGXo3McSs9EK3gkzWag-1; Thu, 23 Feb 2023 04:28:23 -0500
X-MC-Unique: bUoDGXo3McSs9EK3gkzWag-1
Received: by mail-qk1-f200.google.com with SMTP id c19-20020a05620a165300b007389d2f57f3so4963447qko.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCJtNf7Z4oWc5zRL0fOuzjqSoRk0efn63fAKZeMXiGw=;
        b=VpkkDUbHxmU49TAYH4eRpWKcTV+sTr6lykyuc/lIYKt+PwUkXmVqVUakD5SnspPjsT
         niys+OJdH5Dw6WEgg3xTfKuRot5hQOGgduYQcOJ//g31OwMgAjZwYChRvbnoNAOFPgu3
         5TUvPw6BMwdEeGMG/DotRsbPgIlRmVwrSVRUpkStty0CgA82/Q6dgTiZtRKAZjRPR1ks
         KUZn6n34bfrUyspihiTdnolXT8fAxCm7rq1U8fabar5alH+tf4p7UadiKwEEBTSWAADE
         82l6S7GW1gUp/rQ1TyPHKBd7+n/sQBE50vmR1OLE4yrzj7HKq0ahZ/nDGSnxxCeKNi5T
         NxhA==
X-Gm-Message-State: AO0yUKWoKuvQ521ZNALXmqCQ3m0PmXsAOD4Nn3HSaZUtpuAShLAThiJx
        /Ko6+o2eQHLrM+OENLM+QCFiT8Dma644f10Ney4LxZoCVzueKYpdGW0cU4NPFDV3UtL4mirhsG+
        v6Gh1AzeQmheqMIqyKPlM2t6iaBuk0BWHYxvAf6fK
X-Received: by 2002:ad4:4b71:0:b0:56f:36e:fbf with SMTP id m17-20020ad44b71000000b0056f036e0fbfmr1621522qvx.4.1677144502584;
        Thu, 23 Feb 2023 01:28:22 -0800 (PST)
X-Google-Smtp-Source: AK7set9bJj2NzQ74c/SykceBBf61RL9kr5UrChIXOMrKf6f3L9AqUN41zHQg0YfmLiygrspF5ymT7Go6xlJOtYLdCtM=
X-Received: by 2002:ad4:4b71:0:b0:56f:36e:fbf with SMTP id m17-20020ad44b71000000b0056f036e0fbfmr1621511qvx.4.1677144502344;
 Thu, 23 Feb 2023 01:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20230222101600.y2npwk4hw3ss3j73@mail.corp.redhat.com> <CAHk-=wiMd3HJ9m_GFHa4qY_baRGGjcUv3gEQiMpL1_VQBFZSfA@mail.gmail.com>
In-Reply-To: <CAHk-=wiMd3HJ9m_GFHa4qY_baRGGjcUv3gEQiMpL1_VQBFZSfA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 23 Feb 2023 10:28:11 +0100
Message-ID: <CAO-hwJKr4dc-Kh23Q7W4k7wHOnLsHbAY8uK+QcDJUMk96-B8fA@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 6.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 8:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Feb 22, 2023 at 2:16 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > - HID-BPF infrastructure: this allows to start using HID-BPF.
>
> I really don't think this should default to being enabled when there
> doesn't seem to be any actual useful use-cases for it.
>
> So why does it have that
>
>         default HID_SUPPORT
>
> that turns it on if HID is on, and
>
>         If unsure, say Y.
>
> in the help message?
>
> I check for these things, because developers always think that THEIR
> code is so magically important and everybody should care. And that's
> simply not true. If we have been able to do without HID_BPF before,
> then it certainly didn't magically become important for everybody just
> by virtue of existing.
>
> The *only* things that should be "default y" are basically new gating
> questions (like the new gating question of "do you want HID at all",
> when we didn't use to even ask), or things that cure cancer or solve
> world hunger.

I was about to send an apology email with a patch to remove that line
but then I realized that you already got rid of the default Y.

So apologies for that. I mainly wanted this to be enabled in general
distribution where users encounter issues with HID devices, but it's
clear that it wasn't a good choice as servers will probably never have
a need for it.

And thanks for fixing it while applying the series.

Cheers,
Benjamin

>
>                 Linus
>

