Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F14762ED82
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbiKRGNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbiKRGNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:13:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33854090D;
        Thu, 17 Nov 2022 22:13:05 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d192so4013316pfd.0;
        Thu, 17 Nov 2022 22:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M3A03m05S8IZ97deoS5nPwTUaWd11uEo476m146g90=;
        b=gZVKqk52cqlVmNssozrfFsRGdQxHge+EwHeEYgP8XcClOxZU4jIKLLwDisJkGfotJH
         peBvDOwbd/EYpw4Rs4L07neZGmHtGsgsrOytykJmUw62ZJCBF5+Ug8mUKxAgW/LF86xO
         QdEhp0KkldjkINeYDOFIS+Pg8fyRNyEIHeexhP4qtRizc2bPEtOa0JBMFjD5AaVJ1qm4
         lNtFwScYhTnGe+ruh3tk32eSTQPgn0OVLgLRQLycG3UvdfiDUh+u8o2DGNewg1P70OQx
         YCLVrc5ZYhAXj/Jz6W7lqlBVoRT4g5Eb4syv6VA+CxEO62C5wY9qfiyVj4vvDVuwOLB+
         Lcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M3A03m05S8IZ97deoS5nPwTUaWd11uEo476m146g90=;
        b=bKueDWtk9PuIScW8bJV7RepS7Q8yd7Eab3ZMI5CWv3JfbQv0oUxJ3R/P2niBLEHyNB
         9JrECWIyURAZzyq34+VttmUzjdM3zLa6aF3Jps808o63H3DkBWLRuSgcj/v8PK4l5Feg
         uKGQQk9thd9XiSsTlYYKj1RvDuyQ2NMeT2vjjKcMaxLl3GMQgMGxTxOHQ83eH57dmJF1
         vSsTOF8wecLJddhB7H3D2tIP0q33bkq/4S8qWGnNqVrhhBcr88VZ7jNmp9zLIpKZUoy0
         nKo69ncbTQn1SfQhgwCdaqk4z0Qh38wkle8EhuhWIshFHJrA5PuDd4pErAp62cn21xqZ
         sshw==
X-Gm-Message-State: ANoB5pnlsxR2XbxXfYwj20pqks6LcpErG1us6Ylec9fJiC1k+byL/qeD
        VZfpheGVcL30wftlW0W5Lo4=
X-Google-Smtp-Source: AA0mqf4mIaDEUDFAePEKlK9CsQxLKZ4SUarRpvoDuQYG2VaQyxduOrlDDKBFGqKlNrmtg3LiUhq+/A==
X-Received: by 2002:a63:e145:0:b0:46e:c9e2:f11b with SMTP id h5-20020a63e145000000b0046ec9e2f11bmr5534674pgk.151.1668751984514;
        Thu, 17 Nov 2022 22:13:04 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e4c5:c31d:4c68:97a0])
        by smtp.gmail.com with ESMTPSA id z2-20020a626502000000b0057255b7c8easm2260863pfb.33.2022.11.17.22.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:13:03 -0800 (PST)
Date:   Thu, 17 Nov 2022 22:13:00 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        Scott Liu <scott.liu@emc.com.tw>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elants_i2c: Properly handle the reset GPIO when
 power is off
Message-ID: <Y3cibCnWgyNCxXhP@google.com>
References: <20221117123805.1.I9959ac561dd6e1e8e1ce7085e4de6167b27c574f@changeid>
 <Y3ayEc8sFCLahOT3@google.com>
 <CAD=FV=UuLKgM+0UNfRZBij1EkEZs0nQHOkY3Xp9BE2bbJWcdqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UuLKgM+0UNfRZBij1EkEZs0nQHOkY3Xp9BE2bbJWcdqQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:48:17PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Nov 17, 2022 at 2:13 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Thu, Nov 17, 2022 at 12:38:23PM -0800, Douglas Anderson wrote:
> > > As can be seen in elants_i2c_power_off(), we want the reset GPIO
> > > asserted when power is off. The reset GPIO is active low so we need
> > > the reset line logic low when power is off to avoid leakage.
> > >
> > > We have a problem, though, at probe time. At probe time we haven't
> > > powered the regulators on yet but we have:
> > >   devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_LOW);
> > >
> > > While that _looks_ right, it turns out that it's not. The
> > > GPIOD_OUT_LOW doesn't mean to init the GPIO to low. It means init the
> > > GPIO to "not asserted". Since this is an active low GPIO that inits it
> > > to be high.
> > >
> > > Let's fix this to properly init the GPIO. Now after both probe and
> > > power off the state of the GPIO is consistent (it's "asserted" or
> > > level low).
> > >
> > > Once we fix this, we can see that at power on time we no longer to
> > > assert the reset GPIO as the first thing. The reset GPIO is _always_
> > > asserted before powering on. Let's fix powering on to account for
> > > this.
> >
> > I kind of like that elants_i2c_power_on() is self-contained and does the
> > full power sequence. Can we simply change devm_gpiod_get() to use
> > GPIOD_ASIS to avoid the momentary spike in reset line state (assuming
> > that the firmware initializes the reset line sanely because if it does
> > not we have much longer time where we are leaking into the controller)?
> 
> I'm not sure I see the benefit of elants_i2c_power_on() initting the
> reset GPIO. In general that function _has_ to make assumptions about
> the state of the world before it's called. Otherwise the function
> should start:
> 
> if (ts->did_I_inexplicably_turn_vcc33_on) {
>   regulator_disable(ts->vcc33);
>   ts->did_I_inexplicably_turn_vcc33_on = false;
> }
> 
> if (ts->did_I_inexplicably_turn_vccio_on) {
>   regulator_disable(ts->vccio);
>   ts->did_I_inexplicably_turn_vccio_on = false;
> }
> 
> Said another way: we already need to rely on the regulators being in a
> reasonable state when the function starts.  Why is that different from
> relying on the reset GPIO being in a reasonable state? The reset GPIO
> needs to be sequenced together with the regulators. It should always
> be "asserted" (driven low) when the regulators are off and only ever
> deasserted (driven high) when the regulators are on.
> 
> I'll also note that, as coded today (without my patch), the
> elants_i2c_power_on() is actively doing the _wrong_ thing in its error
> handling. Specifically if either of the regulators fail to turn on it
> will explicitly de-assert the reset again which, since it's active
> low, will set the GPIO to high and start leaking power / backdriving
> the touchscreen. We could remove this bit of error handling but then
> we're suddenly not undoing the things that the function did. ;-) It
> feels cleaner to me to just make it a requirement that the reset GPIO
> is always asserted (low) when the regulators are off.

OK, fair enough, applied.

Thanks.

-- 
Dmitry
