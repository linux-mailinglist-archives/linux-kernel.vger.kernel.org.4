Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E946F6312
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjEDDAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDDAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:00:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F090310DE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 19:59:56 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef34c49cb9so606471cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 19:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683169196; x=1685761196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQPqgE7GOTEpFpc+jCsFNRg2Gii/fzU5qqnbDqLit7s=;
        b=asHtJ5GFTsvA27+hssdvVhYHajz43FQi4OhY7JbvbmP/kqLOt+VI5d2I8nVcOsV3qj
         wLCkSDvvxS6A1yUiQc+4su3lyZmHBHJTWXnZ/681gxALanH4lt4pwPNxuA55eVUP8QW3
         KeacOF4VWBaHXmYKiifWTJ+qr3CDsrJMX5VPE0SVoCp9mDiTLfSJbWnQAtEGNfP4pxMe
         2gAiuXxofrcRC5MBmJImPGKNn3OEdkaT4cWD6Twrvz/QLzKq/6YEY5Tr8cRQHTxo9HHW
         +54wfLikbaDbtQrRs97kEWOAecZ1DOazDPMDdNRkmHSXx64b0xbSJs+50xpynjNAlwzx
         hLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683169196; x=1685761196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQPqgE7GOTEpFpc+jCsFNRg2Gii/fzU5qqnbDqLit7s=;
        b=gv1ayBKlb0oDXtrjaYkAXp1ji7zpLw6/XFXG6Wg8WuHpqmjRIrwmezGhEQOCO+JsfY
         B/2suv7XioOfi68OETYLDKyyANtPF/1XLe3TMK1FWaC0sy89Qg0LFKY4fPwBOe+UUaxB
         UwJkE23fuZQqMtsS0dfshIWFHHh/Ct8jgpCifLaPs5O0gyiSR5XD0ovef5O0varkuJS8
         yUK3IjgsFLpjWhCVeucnG1DebqZijbqRF9A6i8KnSONZ/10uRzPByQRtcVZgKB/7AWIt
         JIr76GBvDOlWhF27xaZIPQQdZPnj8SdUiw09UlgkZaEhg9Olx4mmiV2ckEny5LJmGVMg
         gi7g==
X-Gm-Message-State: AC+VfDzD5KxCu/NB346Z8qlIfBNfjFFnY0gsk3snmB+cAVICpEv5TQ9L
        DJjjPgB3JBw4AqZ9VTIrgWvmxwG6t6mO/RuTUWCO
X-Google-Smtp-Source: ACHHUZ7woJmUjHuTvDFHSsIDboqSL9vPwXM6fuEBFNiQJfPJrcPWoQ+yaew+tGNQddVmCGdHdN182d0GnRyBPYQuyrY=
X-Received: by 2002:ac8:5850:0:b0:3ef:19fe:230d with SMTP id
 h16-20020ac85850000000b003ef19fe230dmr86434qth.17.1683169195976; Wed, 03 May
 2023 19:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <fb8d80434b2148e78c0032c6c70a8b4d@huawei.com> <CANDhNCqfBdh8zUd+LseTTQKpmJ27Uid+ZV_+FNckZPNc2Oy3-w@mail.gmail.com>
 <f2b7fdba4ead429bb4dd38a9ccb3735a@huawei.com> <CANDhNCoaMPj-aa1VKJoVawBgZWOiZpvZ5cnvVJq4F_d-miTNcA@mail.gmail.com>
 <5a334292-3e2d-9926-57ec-d52f88e1e324@huawei.com>
In-Reply-To: <5a334292-3e2d-9926-57ec-d52f88e1e324@huawei.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 3 May 2023 19:59:44 -0700
Message-ID: <CANDhNCroULekKiCyUYMPuUe+=XVJriiJvJmC3wrhkC10Bxtt3Q@mail.gmail.com>
Subject: Re: [Question] softlockup in run_timer_softirq
To:     "liujian (CE)" <liujian56@huawei.com>
Cc:     Frank Woo <frankwoo@google.com>, Rhine Wu <Rhinewuwu@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 6:50=E2=80=AFPM liujian (CE) <liujian56@huawei.com> =
wrote:
> On 2023/5/2 11:06, John Stultz wrote:
> > So I wanted to revive this old thread, as Frank Woo mentioned his team
> > has seen a similar issue as well.
> >
> > Liujian: I'm curious if you've made any further progress with your
> > adapted patch ontop of PeterZ's softirq_needs_break patch series?
> >
> Hi John,
>    Only the commit ("softirq, timer: Use softirq_needs_break()") is
> added to the patchset of Peter, and no other modification is made.
> > Might it be worth re-submitting the whole series for consideration upst=
ream?
> >
> I agree very much and expect, because we often encounter similar
> problems when doing fuzzy tests (especially when the test machine is poor=
).

Ok. Will you submit the series + your patch to the list for review and
consideration then?

Please include Frank and Rhine on CC so they can validate and provide
Tested-by: tags if it works for them as well.

thanks
-john
