Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2367BAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjAYTju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjAYTjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:39:48 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AEB4F355
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:39:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id c66so3526314iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frG7daRlPkHUCZSTj7yl9cmfDSyJwEcRRiTwTJz40tw=;
        b=Lx5Wvh6qnib0iPwmeeSYv6L/G+RC0TX6OqyaWCP0p+fVgPt2KKio3PJbtuD2BTQ8hW
         4TDafm0OB26/Yz6alnsxJZe7/W2UDGsC+RHmeUqrw/f2U14SWfAWkI9G1kAxihQLUyLv
         YlOO+eVHTfNYNRnLDcCbuQJ/MaJQZQITMFsVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frG7daRlPkHUCZSTj7yl9cmfDSyJwEcRRiTwTJz40tw=;
        b=vp8bNdrN6ROfM50/ackOYK2JkA7+Lmmimv0W3iRI7SvLFEEM6Haxpe46g8BmVZttQ5
         1qxGTJBpx6wE96+EuYPLQy+a5ZktWT89WDsGI0hyyyIonDFBvn78Gp5BxsmC5PDvqZgl
         wNkcpfoxK2qYg7KT4YmboEmzEbvB/9SC8x4GZiL93aYy5NHSeh4GaUUOXowde6cLepp4
         cY77NZerc5uMFtYs35re9gm63C36XU0ssf3mbVSljYCsRAqmRUWDeR+cDKMqRtLFH16m
         NgLrNdVRqaRNAd7nuqfGW5S79OutnrFlyVgvAbEnpKUpkR4y40diLn95kNSJ40OB5eeW
         4I7g==
X-Gm-Message-State: AFqh2kpyoeJB7/StD1KyJpiiZdDhf3k+Bg2JyBRyzzhypz89p0mm9GOg
        37cXZGc4P6gYFm8CKJ9lN8en9A==
X-Google-Smtp-Source: AMrXdXtLGnVeTtvdhGDiJLdxGeOW45WmielkenQ/UYhHzWxKlNj1/F43o6KPvqRRBN7oLBjipRef3g==
X-Received: by 2002:a05:6602:1244:b0:707:9415:c334 with SMTP id o4-20020a056602124400b007079415c334mr14824200iou.16.1674675587083;
        Wed, 25 Jan 2023 11:39:47 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id c11-20020a056638028b00b0039e8c12414asm1901433jaq.164.2023.01.25.11.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 11:39:46 -0800 (PST)
Date:   Wed, 25 Jan 2023 19:39:46 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <Y9GFgseSx9A+rBY6@google.com>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230122172441.4f8d75f5@jic23-huawei>
 <22fa80f5-0cf0-85bd-03a4-e1eb80272420@linaro.org>
 <CAD=FV=WVEfi2u-uHcZAoMd4HXPcZrwb95HQzTE8V6YmAW9mhPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WVEfi2u-uHcZAoMd4HXPcZrwb95HQzTE8V6YmAW9mhPA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:12:06PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jan 23, 2023 at 8:35 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> > On 22.01.2023 18:24, Jonathan Cameron wrote:
> > > On Wed, 18 Jan 2023 12:06:23 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > >> The node name can contain an address part which is unused
> > >> by the driver. Moreover, this string is propagated into
> > >> the userspace label, sysfs filenames *and breaking ABI*.
> > >>
> > >> Cut the address part out before assigning the channel name.
> > >>
> > >> Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> > >> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> > >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > LGTM, but given it will have ABI impact, I'd like to hear from
> > > Andy, Bjorn or Konrad as maintainers and /or Dmitry as someone
> > > who has touched this driver fairly recently.
> > + Doug
> >
> > Unless the Chromium folks relied on the old names (they're the
> > only ones I can think of that actually could have tapped into
> > this), I say green light!
> 
> Thanks for the CC. I _think_ the only place we use these ADCs is for
> certain thermistors and I think that those are all just hooked up in
> the device tree, so the channel name doesn't matter. I'll also note
> that no Qualcomm Chromebooks are shipping with anything newer than
> kernel 5.15 right now, and (I checked) the ChromeOS 5.15 tree doesn't
> have commit 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device
> properties"). Thus, even if I'm wrong and the name is used someplace
> hidden then the "old" name would be better for us. I haven't tested
> the patch myself, but it sounds as if ${SUBJECT} patch is actually
> moving us back to the old name.
> 
> +Matthias to keep me honest since he's spent more time with the ADCs.

Agreed that the channel name doesn't matter, Chrome OS currently only
uses the ADCs for thermal zones controlled by the kernel.

> > > Mostly I want to be sure they know this exists before it causes surprise.
> > >
> > > Jonathan
> > >
> > >> ---
> > >> v2: rephrased commit message (Marijn), fixed compilation issue (Marijin)
> > >>  drivers/iio/adc/qcom-spmi-adc5.c | 10 +++++++++-
> > >>  1 file changed, 9 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> > >> index e90c299c913a..c2d5e06f137a 100644
> > >> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> > >> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> > >> @@ -628,12 +628,20 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
> > >>                                  struct fwnode_handle *fwnode,
> > >>                                  const struct adc5_data *data)
> > >>  {
> > >> -    const char *name = fwnode_get_name(fwnode), *channel_name;
> > >> +    const char *channel_name;
> > >> +    char *name;
> > >>      u32 chan, value, varr[2];
> > >>      u32 sid = 0;
> > >>      int ret;
> > >>      struct device *dev = adc->dev;
> > >>
> > >> +    name = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", fwnode);
> > >> +    if (!name)
> > >> +            return -ENOMEM;
> > >> +
> > >> +    /* Cut the address part */
> > >> +    name[strchrnul(name, '@') - name] = '\0';
> > >> +
> > >>      ret = fwnode_property_read_u32(fwnode, "reg", &chan);
> > >>      if (ret) {
> > >>              dev_err(dev, "invalid channel number %s\n", name);
> > >
