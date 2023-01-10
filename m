Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F930664C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjAJTZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbjAJTZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:25:52 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B1EE6C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:25:49 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id b81so6111816vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy23pgZjHKapLKv15Vx83fv6lGT5u7B9IA06lp5hFmg=;
        b=ERn/higlX2dFg4WpDH2b15Lk7RSWvuEqplnHDYtm5CrkvjlOxvANu5FTN2IdUuSBt9
         zx5Sqx1SEL/1rNzaGr7wRafi7HDAAKKTpUJbt8InQwT/ryQY6zlVwt2Uur2rCH4F6RT5
         A3fNlzRu1wj5JmcGieozvw5cxx13veOk+6qXoyW5KBmBvshr41IlIKlcyv71FE1TkVp0
         /Z7xMd7r4oCXngTmrBNAAP6VsUyHf9Yc8G4ogaNVhsBCMrxcZY4KHSSp/6yB9vx+XKIp
         aQ5YjRr9b6P4Ee+DNq0zW2NmANWCuB/B7K8tQLilzW4ZnVR280LCl5pASpQb4o6Bt045
         +5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dy23pgZjHKapLKv15Vx83fv6lGT5u7B9IA06lp5hFmg=;
        b=nnW8e3CvLPHhgPN05rlkyMZOFOCeuUbPW/bfdsSigtJ9TiaYf7SKdE4sp7wEpQ9wAy
         ugziZc8wOEAwY+Yg7r8dWD3XP3wFTQ7qLkbo4/SgWsQC32i1eYREmIdV+UhmmzIQrKUK
         GW9w+rZsv5S3Sf6B/mES0+uKEE5l2avCc9cPX8HkgJy9eU9wEZhJg71IXX6mLG6f0Wgm
         VHDg9Kt4VCvXZxUm3sOkDQjYi2LIeT4sWBs/+du1UGN4pNFtROmR4QAa71S0i4CXsQMh
         qIFNcY65hHPxDpkHJyr6nEdZTDntrvvguiKYVBICYL/P07BO5ERszr+f3zep73WRP/j2
         onfA==
X-Gm-Message-State: AFqh2krVGiXmQhhAgvRoLZaN6jZd/qLxrBH88OdAEagg7gNCHNDo26OA
        iTh+Bs02Fgak99OlBjAtuCbw+8wircU8cACLn53bXQ==
X-Google-Smtp-Source: AMrXdXte9jOvSL/EmGgpt5bvEu45qNmWyvfBgbOi2jH/VrK7IIzJmGabkCa+icpgLmCWLKqjFFs/PD9ToGZF8n0dPK4=
X-Received: by 2002:a1f:2d08:0:b0:3d8:d753:56bb with SMTP id
 t8-20020a1f2d08000000b003d8d75356bbmr3260420vkt.39.1673378748741; Tue, 10 Jan
 2023 11:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com> <20230109233534.1932370-4-jcormier@criticallink.com>
 <d49d4b4c-e7ee-e0a1-56e6-7f193e0d1340@roeck-us.net> <CADL8D3YEkZaOjUY3mRLGT0M+b7MwN5zQZrbsw5W8Mn=PJ7PtcA@mail.gmail.com>
 <dd80ee77-3b71-ee47-2744-36b09e0ec372@roeck-us.net>
In-Reply-To: <dd80ee77-3b71-ee47-2744-36b09e0ec372@roeck-us.net>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Tue, 10 Jan 2023 14:25:37 -0500
Message-ID: <CADL8D3YksXnRkEgXkY86KZXM4nouJBemno=db5KgbCi3xmSa8Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] hwmon: ltc2945: Handle error case in ltc2945_value_store
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Dan Vincelette <dvincelette@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 1:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 1/10/23 10:19, Jon Cormier wrote:
> > On Mon, Jan 9, 2023 at 7:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 1/9/23 15:35, Jonathan Cormier wrote:
> >>> ltc2945_val_to_reg errors were not being handled
> >>> which would have resulted in register being set to
> >>> 0 (clamped) instead of being left alone.
> >>>
> >>> Change reg_to_val and val_to_reg to return values
> >>> via parameters to make it more obvious when an
> >>> error case isn't handled. Also to allow
> >>> the regval type to be the correct sign in prep for
> >>> next commits.
> >>>
> >>
> >> Sorry, I don't see that as reason or argument for such invasive changes.
> >> As far as I can see, a two-liner to check the return value of val_to_reg()
> >> should have been sufficient. Most of the rest, such as splitting
> >> the return value into two elements, is POV and just adds additional code
> >> and complexity for zero gain.
> > I can do that. However, you had also mentioned changing the return
> > type to match what the calling function was expecting, an unsigned
> > long. But I can't do that since error codes are negative so it would
> > be a signed long which would lose precision and seemingly defeat the
> > point of matching the variable type the caller wants.  I could make it
> > a signed long long but that still doesn't match.  So it seemed saner
> > to just return the error and the value separately, that way the
> > function declaration was explicit about the types it wanted/returned,
> > and less room for error.  Would love to know your preferred solution.
> >
>
> That is only true if the upper bit is actually ever set in that signed long.
> Which means I'll have to verify if "would lose precision" is actually
> a correct statement.
I'd like to argue that is another reason to go with this change
instead of working out the math of just how many bits are needed in
the worst case and having to document it. And potentially getting that
calculation wrong.  But I can if you'd like me to.
>
> Guenter
>
> >>
> >> Guenter
> >>
> >>> Fixes: 6700ce035f83 ("hwmon: Driver for Linear Technologies LTC2945")
> >>>
> >>> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> >>> ---
> >>>    drivers/hwmon/ltc2945.c | 30 ++++++++++++++++++------------
> >>>    1 file changed, 18 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> >>> index 9af3e3821152..c66acf8d2124 100644
> >>> --- a/drivers/hwmon/ltc2945.c
> >>> +++ b/drivers/hwmon/ltc2945.c
> >>> @@ -70,12 +70,12 @@ static inline bool is_power_reg(u8 reg)
> >>>    }
> >>>
> >>>    /* Return the value from the given register in uW, mV, or mA */
> >>> -static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >>> +static int ltc2945_reg_to_val(struct device *dev, u8 reg, u64 *regval)
> >>>    {
> >>>        struct regmap *regmap = dev_get_drvdata(dev);
> >>>        unsigned int control;
> >>>        u8 buf[3];
> >>> -     long long val;
> >>> +     u64 val;
> >>>        int ret;
> >>>
> >>>        ret = regmap_bulk_read(regmap, reg, buf,
> >>> @@ -148,11 +148,12 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >>>        default:
> >>>                return -EINVAL;
> >>>        }
> >>> -     return val;
> >>> +     *regval = val;
> >>> +     return 0;
> >>>    }
> >>>
> >>>    static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >>> -                           unsigned long val)
> >>> +                           unsigned long val, unsigned long *regval)
> >>>    {
> >>>        struct regmap *regmap = dev_get_drvdata(dev);
> >>>        unsigned int control;
> >>> @@ -220,19 +221,21 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >>>        default:
> >>>                return -EINVAL;
> >>>        }
> >>> -     return val;
> >>> +     *regval = val;
> >>> +     return 0;
> >>>    }
> >>>
> >>>    static ssize_t ltc2945_value_show(struct device *dev,
> >>>                                  struct device_attribute *da, char *buf)
> >>>    {
> >>>        struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> >>> -     long long value;
> >>> +     int ret;
> >>> +     u64 value;
> >>>
> >>> -     value = ltc2945_reg_to_val(dev, attr->index);
> >>> -     if (value < 0)
> >>> -             return value;
> >>> -     return sysfs_emit(buf, "%lld\n", value);
> >>> +     ret = ltc2945_reg_to_val(dev, attr->index, &value);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>> +     return sysfs_emit(buf, "%llu\n", value);
> >>>    }
> >>>
> >>>    static ssize_t ltc2945_value_store(struct device *dev,
> >>> @@ -245,7 +248,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
> >>>        unsigned long val;
> >>>        u8 regbuf[3];
> >>>        int num_regs;
> >>> -     int regval;
> >>> +     unsigned long regval;
> >>>        int ret;
> >>>
> >>>        ret = kstrtoul(buf, 10, &val);
> >>> @@ -253,7 +256,10 @@ static ssize_t ltc2945_value_store(struct device *dev,
> >>>                return ret;
> >>>
> >>>        /* convert to register value, then clamp and write result */
> >>> -     regval = ltc2945_val_to_reg(dev, reg, val);
> >>> +     ret = ltc2945_val_to_reg(dev, reg, val, &regval);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>> +
> >>>        if (is_power_reg(reg)) {
> >>>                regval = clamp_val(regval, 0, 0xffffff);
> >>>                regbuf[0] = regval >> 16;
> >>
> >
> >
> > --
> > Jonathan Cormier
> > Software Engineer
> >
> > Voice:  315.425.4045 x222
> >
> >
> >
> > http://www.CriticalLink.com
> > 6712 Brooklawn Parkway, Syracuse, NY 13211
>


-- 
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
