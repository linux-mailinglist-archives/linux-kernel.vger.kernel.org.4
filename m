Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC8672B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjARWFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjARWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:04:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3BC63E02
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:04:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so2358601wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YwIPzOL5zDtnm8fGUbKYZT0rLB8g0X1JeGG+nlkwy2g=;
        b=RbNnMw6tL2FY/7TumtFfRH/RzPMkiMlwqLjvQlOMqFpqcFg7xFzkZlKm7HshvD1uhc
         GYf4nvjvZ9Gaig4ljDuhSRZhNRf2TmFX1ShcfKldoTziIlHLhMWiWHnLb2O5akyusUy+
         uKI5CLnEXeGpmOZKzLfvHoPYqKSeKSoAZofTtN8t8sRNHNmgO77M7CNcVJ6dYGYMNt5C
         AI3sWSnG4ExajqbWdAapWiz+b6jIKMCv7gK7OhMmQF+BdfZOuoGjDKCCo1yhy2fVxuZS
         4VkTy0/WPobGmzU/LTAq7bSlN8q7d9wNfnNzIakOE8YFAo5RW5VBThYNBRo7MVdRtKR2
         viFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwIPzOL5zDtnm8fGUbKYZT0rLB8g0X1JeGG+nlkwy2g=;
        b=0rDdEBYvXwLy87w/a38PCQjKk/jpBexR9jrEKZVZX+3MHt0vLdwgou9A3Lm5amEU4w
         IOZUO8lXwvsRwVZ82tR6OHoNQz+SoiTbf3ntGOwrgvDB0MA4ESF7V6GjL0noUfP26s6o
         mhY5N1kCGMFRonHiGedik0IIUwdRx2+r5YKoeV5161KYYxWyKptAfrorUyBmi67Vz/QM
         WCZ35ymJKADOGBMY+rdFHHce2CUGgvWMAexwMknAG9n7mmL5673AvTSwdX1sq3gf5CaV
         YaiN5XCUl4xqq+GeXlf6vv1Pgxmnci6rLuCDeyY/lqSq4groXkUpgNwdpUFpn7Yfe8rk
         cm7Q==
X-Gm-Message-State: AFqh2kp7d8kFIREl48FDdWlbeJNYI0mcpadvk0b+76/daTTos6kzz+Ox
        lBX7SDKuGeURXxrObFVt953PyWlnrD9LmLqKvKBSXQ==
X-Google-Smtp-Source: AMrXdXs3YifbiXqcN/UM9iuN5qbxprLoFpLthaoKnHv5Q0dpt/Ixi+xaFLmP1X8b0KoaiNfnrWS05HuuetM0wGCrfJk=
X-Received: by 2002:a05:600c:a686:b0:3db:104:7821 with SMTP id
 ip6-20020a05600ca68600b003db01047821mr459041wmb.77.1674079485953; Wed, 18 Jan
 2023 14:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20230113210703.62107-1-nhuck@google.com> <Y8HI+42TxxlJxT6D@slm.duckdns.org>
 <CAJkfWY7vmvrU8sW3OWpSa9zygY=6e8BTTkktPe-VScdOcLL-sw@mail.gmail.com>
 <Y8gxu7l8BUWewuMg@slm.duckdns.org> <CAB=BE-Q9jtJnqPwGzSTQ6-soZ9STvqAebeONy=Eyo08H+eg-rQ@mail.gmail.com>
In-Reply-To: <CAB=BE-Q9jtJnqPwGzSTQ6-soZ9STvqAebeONy=Eyo08H+eg-rQ@mail.gmail.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Wed, 18 Jan 2023 14:04:34 -0800
Message-ID: <CAJkfWY5c=kT1CpQ+R34MpX6_Dyq_32zgkYDgrWU7Kuoz7d9TYg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Add WQ_SCHED_FIFO
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jan 18, 2023 at 10:22 AM Sandeep Dhavale <dhavale@google.com> wrote:
>
> On Wed, Jan 18, 2023 at 9:52 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Sat, Jan 14, 2023 at 01:00:00PM -0800, Nathan Huckleberry wrote:
> > > This sounds fine to me. How do you feel about a config flag to change
> > > the default WQ_HIGHPRI scheduler policy and a sysfs node to update the
> > > policy per workqueue?
> >
> > Yeah, sounds fine to me.
> >
> > Thanks.
> >
> Hi Tejun,
> If with the kernel config option, every WQ_HIGHPRI is elevated to
> sched_fifo_low, wouldn't that be kind of defeating the purpose? Having
> another class for even more urgent work is better in my opinion.

I agree, however most of the users of WQ_HIGHPRI that are relevant to
Android would probably have SCHED_FIFO enabled anyway.

I can write the patches such that WQ_HIGHPRI selects one of two
internal WQ flags. If using SCHED_FIFO for all workqueues is
problematic, Android can consider using the internal WQ flags directly
and carry those one-line patches in the Android tree.

Thanks,
Huck

>
> Thanks,
> Sandeep.
> > --
> > tejun
