Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FA6633368
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiKVChx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiKVChu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:37:50 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7AB10FD4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:37:48 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 4so12352113pli.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipvlEWLVcseEXRvRfHEM9M98T6Rtc0U4LfZnodoKNls=;
        b=fjf9nZI1QoWNWZNM9Whtved1l5bqjqOjppbQ0nMxgofDCcaUZZ7WRQPcbNWogA5ILH
         txglhsFMwIcOejgB660t2AKFoi5XrlnggJgl0I0bdt8LoTrzqIZkfL4I0LlTO5Yzj61J
         t0K7gfvcGeUL2ep+rrxgKTRGa5nQRRUm2iIvD7H7ps+hzUv6/YuSX+mjWFqweWhbeOoD
         u6hBANmxTsPYRBg13beoyFDFsnMYpnPAMtk3Hh6x5J65TvH6kQa17eWlY6X8CZ8ONhvm
         ZmGkBx4SzyLmCeYgi8E6q8OVfqzsowMVQOuITsEH/2fAb6VntFs4UE/nWp2nTDgRKpGE
         rLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipvlEWLVcseEXRvRfHEM9M98T6Rtc0U4LfZnodoKNls=;
        b=ptDDWjEJcOcJxlvlPPrIjhmDrcXnWWu//BeDxXz0BZRaJDTkCCiI2j/yCuFf1Ueiau
         as2/3yRWfCfR3lGvjWhxLtzgN2zmYbQDEeLDjwPXM6tAx+DlCyIXvmuAwx9v/q75obGH
         hU8WGHAz1pI8jL3HFRD7qDVWnoE3ALCkUgWJ+ZMKexu82xmWA7Lji7iZ9UhUAPQAp6wj
         dnlFdjzm7KDC0rCHcI9go3RzivfQETNG6JhJQmhe4zI3fU980gMbOX+zRwndBITX6gNG
         rPkCIwQwf/9G0njYO9EJjuFPEJMDJ4OJy56Rfz3VWa+3kLXjFP9el6vbhJQKQXTbn56+
         9rvQ==
X-Gm-Message-State: ANoB5plZqEKhsxQg9D58tCRffhZqgm2IxI1fBMKs8a5uuyF4fXWQy52x
        HljGOIvWYJAzGbQHjIhs0lqC7m/3jwzaVmF/HiJnkAy9s/k=
X-Google-Smtp-Source: AA0mqf5HRJRqIhLRwUJGkaxvbIJCI2q54J9m69G9hA7REKQagxd1/rl1I94IBC6DI2sSSJ+FruYqrbP/0ukEX5X8FAc=
X-Received: by 2002:a17:90a:7e87:b0:212:f810:a846 with SMTP id
 j7-20020a17090a7e8700b00212f810a846mr30299919pjl.71.1669084668261; Mon, 21
 Nov 2022 18:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20221026132039.2236233-1-suagrfillet@gmail.com>
 <CAAYs2=iOvP-TxLs+_QFMLQHG86xi2PYK_CN_rXUWHBx=kY+1aw@mail.gmail.com> <20221121213402.154adf09@rorschach.local.home>
In-Reply-To: <20221121213402.154adf09@rorschach.local.home>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 22 Nov 2022 02:37:37 +0000
Message-ID: <CAAYs2=jVXkA53P35D62=TqQx9tr_cQbqXUex6Pg0y710m=yExw@mail.gmail.com>
Subject: Re: [PATCH] ftrace: avoid replacing the list func with itself
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=BA=8C 02:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 22 Nov 2022 02:28:25 +0000
> Song Shuai <suagrfillet@gmail.com> wrote:
>
> > Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=B8=89 13:20=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > The list func (ftrace_ops_list_func) will be patched first
> > > before the transition between old and new calls are set,
> > > which fixed the race described in this commit `59338f75`.
> > >
> > > While ftrace_trace_function changes from the list func to a
> > > ftrace_ops func, like unregistering the klp_ops to leave the only
> > > global_ops in ftrace_ops_list, the ftrace_[regs]_call will be
> > > replaced with the list func although it already exists. So there
> > > should be a condition to avoid this.
> > >
> > > This patch backups saved_ftrace_func by saved_ftrace_func_old
> > > which will be compared with the list func before trying to patch it.
> > >
> > Ping...
>
> Thanks for the ping. I had thought I had replied to this, but I don't
> see it in my sent folder. I may have been distracted, and lost the
> message.
>
> I'll take a look at it tomorrow.
>
> -- Steve
No problem, thanks!

-- Song
