Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA670ED38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbjEXFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbjEXFlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:41:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22EC189;
        Tue, 23 May 2023 22:41:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae74ab3089so4269215ad.0;
        Tue, 23 May 2023 22:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684906890; x=1687498890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DB+FrLXm23sZ6gr4EDrh7Ica+cTPF1YFJFo6DmMxVSo=;
        b=Mxj5EL2uhyedVvbrLxTkPsh+/bb4kU9FMVyGhIMjuj63YfrxJpTxn8UQgpsZdEFHQy
         spuh4pgh4pk5vIxXYUe+tjYRlvYud88Lq8BFyjiT4w+glFlwH+313DrlUFlOUk83SmRo
         X6hZKOqGBBP+El9cz50wbdRvZVjNnXeLSofCKEusJcHvyhVTk3qBkYL1aVhe0McQeFqz
         GUSpYiN85e8WX2nPTwZ0gh+3oix5gBnkcTnfUja7SDM9z9B6QMOGW8QxWLjBJIpDxYeA
         VAGIi9moNCtAbXh1p0TjwM43tyOZG76KyI7xEZg8HFgBChjsDlmWPM6m5Fk4Kn9oU7M5
         yPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684906890; x=1687498890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DB+FrLXm23sZ6gr4EDrh7Ica+cTPF1YFJFo6DmMxVSo=;
        b=edtcbIH3r1VAEQ6eM3SBguCc2YZvVdrosLgNL+S7c0mF6QTDSjkOngPkS1oFLwh+eb
         F5k9llw9AQaYEfr3Kx+eB/US87a1V4bKiFtSqKNleBv2WIxZA5QJ4sYDXQabf4kDRocY
         +aE6mxrBLNMqs058aLMolnEsRjRHlwuc+TC795aaOqqOXatbgGe7vgEtUAu9b80jVYAl
         v6IwPoXK91qWYFU5xbn/Kjec/IqG4expswpthAsciza+Cc5VhzHQhmBQCNKBGUiBzrqs
         vZlI46WXqqVmi14VGWSIIRbA1WtZY0Y5IZrIrc6fSLhbuvJ0fZVCAcHxj4KX925Q6IPo
         PUDg==
X-Gm-Message-State: AC+VfDyXFBF11U6aGXxBqv15PxIk27ja+60sybVg9PxehVZ/m7/wMYR8
        hKOYFJTOxRjcovsvUWooM+w=
X-Google-Smtp-Source: ACHHUZ7dNPiJ3xPKUMCOV5C9Stlxo2YIt4aDPcffxXvvoZuZxGkXWOiq0H6bYqoP/vfvTbSlhN5SQQ==
X-Received: by 2002:a17:902:ac86:b0:1af:a704:a65 with SMTP id h6-20020a170902ac8600b001afa7040a65mr9557991plr.10.1684906890162;
        Tue, 23 May 2023 22:41:30 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b0019f3cc463absm7762636plg.0.2023.05.23.22.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 22:41:29 -0700 (PDT)
Date:   Wed, 24 May 2023 13:41:23 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZG2jgwjK+CBmOk3G@sol>
References: <ZGzsD_HMbMGhGwcr@surfacebook>
 <72990baf-6964-01ad-d891-7090831d0310@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72990baf-6964-01ad-d891-7090831d0310@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 09:17:26PM +0000, Chris Packham wrote:
> 
> On 24/05/23 04:38, andy.shevchenko@gmail.com wrote:
> > Wed, May 17, 2023 at 09:30:51PM +0000, Chris Packham kirjoitti:
> >> On 17/05/23 20:54, Andy Shevchenko wrote:
> >>> On Wed, May 17, 2023 at 2:50 AM Chris Packham
> >>> <Chris.Packham@alliedtelesis.co.nz> wrote:
> >>>> On 17/05/23 10:47, Kent Gibson wrote:
> > ...
> >
> >> Again the problem boils down to the fact that we have a userspace switch
> >> driver (which uses a vendor supplied non-free SDK). So despite the
> >> kernel having quite good support for SFPs I can't use it without a
> >> netdev to attach it to.
> > That user space driver is using what from the kernel? GPIO sysfs?
> 
> Yes GPIO sysfs and exported links with known names, which allows things 
> to be done per-port but also wildcarded from shell scripts if necessary. 
> I think the key point here is that it doesn't care about the GPIO chips 
> just the individual GPIO lines. Anything involving libgpiod currently 
> has to start caring about GPIO chips (or I'm misreading the docs).
> 

As previously mentioned, the libgpiod tools now support identification of
lines by name.
As long as your line names are unique at system scope you should be
good.  Otherwise you have no option but to identify by (chip,offset).

Wrt the library itself, I was thinking about relocating the line name
resolution logic from the tools into the library itself, so it would be
more generally accessible, but haven't gotten there yet.

I'm also of the opinion that libgpiod is too low level for common
tasks.  That is necessary to access all the features of the uAPI, but
for basic tasks it would be nice to have a higher level abstraction to
reduce the barrier to entry.

e.g. in Rust I can do this:

    let led0 = gpiocdev::find_named_line("LED0").unwrap();
    let req = Request::builder()
        .with_found_line(&led0)
        .as_output(Value::Active)
        .request()?;

    // change value later
    req.set_value(led0.offset, Value::Inactive)

which is the equivalent of the sysfs

echo 1 > /some/sysfs/line
...
echo 0 > /some/sysfs/line

That is bad enough. It pains me to see how complex the equivalent is using
the libgpiod v2 API (or v1), and that is not putting any shade on Bart or
anyone else who worked on it - there are a lot of constraints on how it
is designed.  It just doesn't feel complete yet, particularly from a
casual user's perspective.

One of the things I would like to see added to libgpiod is a set of working
examples of simple use cases.  Formerly the tools took double duty to
fill that role, but they've now grown too complex.
Those examples would highlight where we could provide simplified
higher level APIs.
Then rinse and repeat until the simple use cases are simple.

> >>>> I'm sure both of these applications could be re-written around libgpiod
> >>>> but that would incur a significant amount of regression testing on
> >>>> existing platforms. And I still consider dealing with GPIO chips an
> >>>> extra headache that the applications don't need (particularly with the
> >>>> sheer number of them the SFP case).
> >>> It seems to me that having no in-kernel driver for your stuff is the
> >>> main point of all headache here. But I might be mistaken.
> >> It certainly doesn't help, but I do think that is all orthogonal to the
> >> fact that gpio_is_visible() changes things rather than just determining
> >> if an attribute should be exported or not.
> > Sorry for being unhelpful here. But without understanding the issue we can't
> > propose better solutions.
> No problem, this is probably the most engagement I've had out of a Linux 
> patch submission. Hopefully it's not too annoying for those on the Cc list.

Well, now you mention it....

Along the same lines as Andy, it is always useful to get feedback about
problems people are facing, and how the available solutions aren't
working for them.
If we don't know the problem exists then we can't fix it - except by
accident.

Cheers,
Kent.
