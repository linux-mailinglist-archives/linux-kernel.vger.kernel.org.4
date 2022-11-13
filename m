Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD55626FC9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiKMNjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiKMNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:39:29 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0910560
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:39:28 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id z1so5965799qkl.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0z24Boz3eOlxJFo/pymZw/hsLoIwXXjZAKYQO15hylw=;
        b=2roEsWPdPZzq9JYQG6GUjIziF4lsiMjqKAlQRyI83eZWUeYXS1+BaNzO68Qd5op54U
         aGIJW8euapK+H3mlSX3cIowAdDJMpBiC/6B6agP0O10QJOB8to6UeeQ0A8BzsdhhzblH
         oL0Gony70MRKt9CLbhWGzec8BgxSc9Yk1ZkeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z24Boz3eOlxJFo/pymZw/hsLoIwXXjZAKYQO15hylw=;
        b=ZhkrEYO2lF9X+cZgXJW3Qd4ZPJGF0dtWVut/Nixvwz9xjz7OcB6i+QfPoKeIxtIulL
         GMzkHwOFd/6F9lcJdMjAbeQyzWHaWxRzexSGD2Pn8pMuVBdSb8G0/I58UqxYTuyZN78L
         acYsDapU754Bs1qIDfBxdOVbA7bJHcL11NzMwzKh7EhuxJnNR21+U6Bm/W3Q3qDgtxZO
         TAKoXZNCIfl47BgFRvZAhobv+ODZzskbAXHS7NS2V029SEYxkmTJakjbhWrwHvc6QQM1
         4VVdDxWe6B258QZxnLQyXTKi8YSJI5kpjAp0X99BZl4NJ8ZwOQ4Guh6OkgJs+RaapTbX
         ctxQ==
X-Gm-Message-State: ANoB5pkwO2o8dFYIAZOv2ZLSFuuPboVRKJ2zvKar0YEamf/CU5G7fPZg
        +RborppOZwv3ydFczywjXTqvc+YBj2dBp8/GhfdJMHSkoTiNpw==
X-Google-Smtp-Source: AA0mqf5erDExfMVXOaz5Bb4mDDGflC3k7wVmZPb/lz8hY+35SJIrxdyX5WmyomZwuZDEKsfPEjavD3RiXbaqQSD40yY=
X-Received: by 2002:a05:620a:1319:b0:6fa:9a5e:7ca8 with SMTP id
 o25-20020a05620a131900b006fa9a5e7ca8mr8018883qkj.70.1668346767288; Sun, 13
 Nov 2022 05:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20221111112657.1521307-1-mitja@lxnav.com> <20221111112657.1521307-3-mitja@lxnav.com>
 <20221112172806.6db090eb@jic23-huawei> <CACbQKWfEa64Fv4CmW8BDp2rXw504YyL_s2TWiA_SwH-zCKKvCA@mail.gmail.com>
 <20221113120610.6568f9e6@jic23-huawei>
In-Reply-To: <20221113120610.6568f9e6@jic23-huawei>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Sun, 13 Nov 2022 14:39:03 +0100
Message-ID: <CACbQKWfzbxS2SKzd3v=h8-3oQw3hRhZJr_fJMaiTKaFwLn-jJg@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: mcp3422: allow setting gain and sampling
 per channel
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 12:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sat, Nov 12, 2022 at 6:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > Was it possible for these scales to differ before this change?
> > Yes. The difference is that before this change you could only see and set
> > available scales that were available for specified sampling rate. Now you're
> > able to set gain and sampling rate via scale. So before the change you got
> > these (@240sps):
> >
> > 0.001000000 0.000500000 0.000250000 0.000125000
> >
> > Now you get the complete set:
> > /*                 gain x1     gain x2     gain x4     gain x8  */
> > /* 240 sps    */ 0.001000000 0.000500000 0.000250000 0.000125000
> > /*  60 sps    */ 0.000250000 0.000125000 0.000062500 0.000031250
> > /*  15 sps    */ 0.000062500 0.000031250 0.000015625 0.000007812
> > /*   3.75 sps */ 0.000015625 0.000007812 0.000003906 0.000001953
>
> Ok. That doesn't work as a standard interface because userspace code wants to pick say
> 0.00062500 which appears twice.
I don't know how I missed that. It's clear to me now that this patch is wrong.


> > > If not, then why was the previous patch a fix rather than simply a precursor
> > > to this change (where it now matters).
> > I wanted to separate a bug fix from improvements, if these were rejected for
> > for some reason.
>
> Is it a bug fix?  The way I read it is that, before this patch there is only
> one scale that is applied to all channels.  As such, the current value == the
> value set and the code works as expected.
> So the previous patch is only necessary once this one is applied.  Hence no
> bug, just a rework that is useful to enabling this feature.
I'll post the previous snippet here and write the comments inline:
----
@@ -164,8 +164,9 @@ static int mcp3422_read_raw(struct iio_dev *iio,
  struct mcp3422 *adc = iio_priv(iio);
  int err;

+ u8 req_channel = channel->channel;
  u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
- u8 pga = MCP3422_PGA(adc->config);  /* <- this uses the "current" config
      which changes depending on the last read channel */
+ u8 pga = adc->pga[req_channel];          /* this now returns the PGA for the
      selected channel */

  switch (mask) {
  case IIO_CHAN_INFO_RAW:
----
I hope this clarifies the bugfix.


Thanks for in depth look at this and sorry for wasting your time with this
flawed patch.

Kind regards,
Mitja
