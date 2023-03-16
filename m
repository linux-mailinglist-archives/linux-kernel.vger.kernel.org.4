Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3666BD36A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjCPPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCPPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:25:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC310D7;
        Thu, 16 Mar 2023 08:25:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d10so1128629pgt.12;
        Thu, 16 Mar 2023 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678980353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0idJoJp2w2wIfFTVWZdFY6UxngZNa7XXOBWQnR6Nfc=;
        b=ALcZNjLSW6SKO4Rn4OiKb3x1iJbhy0pBsSvLP4ueXcqR+kSAmdYu9Hbnn7mx65CcVD
         dk2UwrPAe7z6TqzzltYxW6X0etOuzQwlXoGBMp+Oqrj8Fqx3b/jyJAm0WVdf+oQsAvrm
         aSOwtK5SmQga07Q3rROsYzQJ3TqDXvVkypsJPGoXpDuGaDsUFzMmkjWR0CJL5Y+HwIif
         /1ewCCYjBAXKhaf7HKUY/DfIj8LCAEyQ2xEQODNjVR2dX1PjGRLOquZHiQ3M6Dcp9AFg
         jwvRcS0QFlkibo59ZEoZS/RDoki/hpclXQOX+y4nhAtixMJxBmsFyl961Lwoxk0QO4Kr
         JfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678980353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0idJoJp2w2wIfFTVWZdFY6UxngZNa7XXOBWQnR6Nfc=;
        b=HpXhBIXClQp4wG5RKcBOW2+dfwg1qINp5pzzu6Lca/Ll+hVvdMM167ikngxUhHrZqS
         TGcWhy8I+pVL4ByuT9jl1rmnD5QkLgcZUpZK07tCxTDbFLck3jvkl5Wzk3bhGaOTcH/Q
         upUgA5EO6f18A0iOnGzpaMsFmavKW7DTY2gvkIvCX4oB9BL+aHzUdYeI8WH71PB1VzSX
         0o5eWu2OrzPPZWCWCBYUN0a5ifrLq+vnx9wklhNiS4RBrscp70Bvy3Jf9si3Nj+O71m/
         E9f3u9nFaOonMdZMhpsi8VAqUdwQqWcLEb2eODhZRw0oTftQYIRUGRDbIfHhUdZKd16p
         6Q4g==
X-Gm-Message-State: AO0yUKV1DDhhDOzTJXUEJZX1YVFiWpQju6byr7RXuurgFGP1rd6sZdmy
        valTUQy7FQXGYZ2rpiRWKuZMK48sKl3nuvJ9Sy4=
X-Google-Smtp-Source: AK7set+waXn+onvuWowCzAPU6KKu/o8UV7RfT+/eZlRBRBZw9yyGPaCFGM3qrZCq7RKIs2MYTJzvA6+D2xRNf+ka730=
X-Received: by 2002:a05:6a00:1506:b0:625:ce0d:e69b with SMTP id
 q6-20020a056a00150600b00625ce0de69bmr1743171pfu.5.1678980352661; Thu, 16 Mar
 2023 08:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <aa9567fd-38e1-7b9c-b3e1-dc2fdc055da5@molgen.mpg.de>
 <55e30408-ac63-965f-769f-18be5fd5885c@molgen.mpg.de> <d95aa962-9750-c27c-639a-2362bdb32f41@cloud.ionos.com>
 <30576384-682c-c021-ff16-bebed8251365@molgen.mpg.de> <cdc0b03c-db53-35bc-2f75-93bbca0363b5@molgen.mpg.de>
 <bc342de0-98d2-1733-39cd-cc1999777ff3@molgen.mpg.de> <c3390ab0-d038-f1c3-5544-67ae9c8408b1@cloud.ionos.com>
 <a27c5a64-62bf-592c-e547-1e8e904e3c97@molgen.mpg.de> <6c7008df-942e-13b1-2e70-a058e96ab0e9@cloud.ionos.com>
 <12f09162-c92f-8fbb-8382-cba6188bfb29@molgen.mpg.de> <6757d55d-ada8-9b7e-b7fd-2071fe905466@cloud.ionos.com>
 <93d8d623-8aec-ad91-490c-a414c4926fb2@molgen.mpg.de> <0bb7c8d8-6b96-ce70-c5ee-ba414de10561@cloud.ionos.com>
 <e271e183-20e9-8ca2-83eb-225d4d7ab5db@molgen.mpg.de> <1cdfceb6-f39b-70e1-3018-ea14dbe257d9@cloud.ionos.com>
 <7733de01-d1b0-e56f-db6a-137a752f7236@molgen.mpg.de> <d92922af-f411-fc53-219f-154de855cd13@cloud.ionos.com>
 <CAH6h+hf7Y-kurBJG+pnH6WCQiaEK+Jq3KG5JOGnHJ4Uw6AbUjg@mail.gmail.com>
 <2af18cf7-05eb-f1d1-616a-2c5894d1ac43@linux.dev> <CAH6h+hc8VdpaS2q4ya_ZfqVxWFRsKVCjN-sv73SfeyGomXvjRQ@mail.gmail.com>
In-Reply-To: <CAH6h+hc8VdpaS2q4ya_ZfqVxWFRsKVCjN-sv73SfeyGomXvjRQ@mail.gmail.com>
From:   Marc Smith <msmith626@gmail.com>
Date:   Thu, 16 Mar 2023 11:25:41 -0400
Message-ID: <CAH6h+hcWfXNpC1Mro3zfzQc8tK142vuaOMELLJL7mg_G+o0fXw@mail.gmail.com>
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle" transition
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Donald Buczek <buczek@molgen.mpg.de>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+raid@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:45=E2=80=AFAM Marc Smith <msmith626@gmail.com> w=
rote:
>
> On Tue, Mar 14, 2023 at 9:55=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linu=
x.dev> wrote:
> >
> >
> >
> > On 3/14/23 21:25, Marc Smith wrote:
> > > On Mon, Feb 8, 2021 at 7:49=E2=80=AFPM Guoqing Jiang
> > > <guoqing.jiang@cloud.ionos.com> wrote:
> > >> Hi Donald,
> > >>
> > >> On 2/8/21 19:41, Donald Buczek wrote:
> > >>> Dear Guoqing,
> > >>>
> > >>> On 08.02.21 15:53, Guoqing Jiang wrote:
> > >>>>
> > >>>> On 2/8/21 12:38, Donald Buczek wrote:
> > >>>>>> 5. maybe don't hold reconfig_mutex when try to unregister
> > >>>>>> sync_thread, like this.
> > >>>>>>
> > >>>>>>           /* resync has finished, collect result */
> > >>>>>>           mddev_unlock(mddev);
> > >>>>>>           md_unregister_thread(&mddev->sync_thread);
> > >>>>>>           mddev_lock(mddev);
> > >>>>> As above: While we wait for the sync thread to terminate, wouldn'=
t it
> > >>>>> be a problem, if another user space operation takes the mutex?
> > >>>> I don't think other places can be blocked while hold mutex, otherw=
ise
> > >>>> these places can cause potential deadlock. Please try above two li=
nes
> > >>>> change. And perhaps others have better idea.
> > >>> Yes, this works. No deadlock after >11000 seconds,
> > >>>
> > >>> (Time till deadlock from previous runs/seconds: 1723, 37, 434, 1265=
,
> > >>> 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
> > >> Great. I will send a formal patch with your reported-by and tested-b=
y.
> > >>
> > >> Thanks,
> > >> Guoqing
> > > I'm still hitting this issue with Linux 5.4.229 -- it looks like 1/2
> > > of the patches that supposedly resolve this were applied to the stabl=
e
> > > kernels, however, one was omitted due to a regression:
> > > md: don't unregister sync_thread with reconfig_mutex held (upstream
> > > commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)
> > >
> > > I don't see any follow-up on the thread from June 8th 2022 asking for
> > > this patch to be dropped from all stable kernels since it caused a
> > > regression.
> > >
> > > The patch doesn't appear to be present in the current mainline kernel
> > > (6.3-rc2) either. So I assume this issue is still present there, or i=
t
> > > was resolved differently and I just can't find the commit/patch.
> >
> > It should be fixed by commit 9dfbdafda3b3"md: unlock mddev before reap
> > sync_thread in action_store".
>
> Okay, let me try applying that patch... it does not appear to be
> present in my 5.4.229 kernel source. Thanks.

Yes, applying this '9dfbdafda3b3 "md: unlock mddev before reap
sync_thread in action_store"' patch on top of vanilla 5.4.229 source
appears to fix the problem for me -- I can't reproduce the issue with
the script, and it's been running for >24 hours now. (Previously I was
able to induce the issue within a matter of minutes.)


>
> --Marc
>
>
> >
> > Thanks,
> > Guoqing
