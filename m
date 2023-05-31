Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE6718890
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEaRiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEaRiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:38:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87252125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:38:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685554694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A857xLioc7wFyg93dl7T2qqOgf/640iThyj+3V7o+wA=;
        b=bvFVrgaWD4+lw487AUcr4NNPBWFN+SQJjQNqtODltmv97QeyUIk67FkUJGGOk24+n6Q/zF
        NhQMB8APQ/0+JasMdCyaodpkgf2s3Xul2tJmL03QNVUJaVkMKz6bb+eFkG5rVou9uRa+DE
        yzmsnxry0dApgIsqWus8jEl8tcMDcTgWxJkit23RmolnKmWjJfn3j9v6yhOJN3sq1sfPdn
        eo1BHnMooWny1Hwmae7nz/4xF/Y1kE8D5LUu4/LUCIjNxh4Jek2Flm5P8E+BmT50NAUlbU
        lNd4WlhYAhI7jNC6MsL99oZ9ccxqHhAkop4LyB4LXsRox7cR7eUXa3E0InIguw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685554694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A857xLioc7wFyg93dl7T2qqOgf/640iThyj+3V7o+wA=;
        b=55LVieDR2fyNm6QK61sGsHZAn42vVfPxhqeSlfUHOlSjH6vIAWPOVXZfJF7/irRu9mmb6Q
        vzJIvPRBWlsCAbDg==
To:     Andrey Vagin <avagin@openvz.org>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <areber@redhat.com>
Subject: Re: [RFD] posix-timers: CRIU woes
In-Reply-To: <CANaxB-xFs2ZYnFBTtQsZxAGAJ6o9cgWM=k=d_EBXuOK5djLgkA@mail.gmail.com>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
 <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
 <cc8aa6a4-a187-f3ad-fec9-05f037a3886d@virtuozzo.com> <87r0rnciqo.ffs@tglx>
 <CANaxB-xFs2ZYnFBTtQsZxAGAJ6o9cgWM=k=d_EBXuOK5djLgkA@mail.gmail.com>
Date:   Wed, 31 May 2023 19:38:14 +0200
Message-ID: <87edmwflkp.ffs@tglx>
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

Andrey!

On Thu, May 11 2023 at 18:21, Andrey Vagin wrote:
> On Thu, May 11, 2023 at 2:36=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> You know the UABI regression rules of the kernel...
>
> There is no rule without exceptions... With all pros and cons, we may
> consider this case as an exception. From our side, we will try to make
> everything to minimize the impact. Here are steps off the top of my
> head:
> * releasing the criu fix before the kernel release.
> * update packages in Linux distros (Debian, Ubuntu, Fedora, and
>   others that we will find).
> * send an announcement to the criu mailing list and to users that we know.
> * add the error to FAQ.
> * create a GitHub issue with a full description.

Thanks for this plan. After digging deeper I managed to resolve the
actual problem I was chasing without changing that ID generator at
all.

The main pain point of having to do that lookup from the signal delivery
path is gone, which made it trivial to do the fix for the SIG_IGN mess
w/o these global lookups too.

Addressing this global ID issues I pointed out becomes therefore an
orthogonal issue which we can handle completely independent of the
kernel internal problems I'm trying to address.

I still think we should do that for sanity sake, but we can stage that
properly without dependencies outside of this particular ABI
problem. That makes me way more comfortable as that's something which
can be in the worst case reverted without doing any other damage.

Thanks,

        tglx
