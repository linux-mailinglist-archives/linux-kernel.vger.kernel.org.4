Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31C966CF15
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjAPSpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjAPSpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:45:15 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF14ED2;
        Mon, 16 Jan 2023 10:43:06 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 188so31245064ybi.9;
        Mon, 16 Jan 2023 10:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlIydODY/LfpwItZTwtL4rzfyzEiXyrm/RMUswozIX8=;
        b=OUGKEjvhy/swyG5hBFXyFKBADXRYGg2Tnv2lo9xqvxIfswyC0uVTH4neehdoFiys6K
         DJttWBjlEft3Ka2XvzsnS6nE2sjau6TTQzhOt7S+AoDcsbqSHdW83chVFdqzwqxtJ3xp
         5GWtFffSzf6n6eghxZZ/r6n5Tilh49rb+2TgRijjALlKUXK/HaJS4y8mnWCrizJk7m23
         7Kn3rVt37SzXRMos70rE99Vnn46PJ/RmQJN3g/P7wShJ0ZWNxqUhWt3FmTP1dIH59ec2
         D/AkWwTkWNKl6w0z9JuQGVst42aOoLec/kyIH3TTDSd+FAWLOVwbsY6qTLz2cN3BlhhU
         18vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlIydODY/LfpwItZTwtL4rzfyzEiXyrm/RMUswozIX8=;
        b=ZRywAQ8nkvfGEf71XLnqrAfLq3xm0ujscOCQtdMzZ6Bwuhsf7UC3KSVx4zHZ1/HHQq
         wyNhMznZgfzyyVeK3lNnOB9qxUFQcFNz4ygu2ljeaJ1SiPU6lJuPl2+pFk5rlRN2CeuM
         uZJXoRdKFRSGUA62pF9Rj58xhZN+c7SmrR8QvvVeL3K2j2GYqE+U4peWJr16W/+Dym5u
         xfet7nI/laHDuw25CzWK01YKBWnTRpWkAtd3Q31E7zu2fgYhfZbmCvBfdVdldmZnhZoB
         Pq/8Mo7UZvgjmYb/dUuqobdypYl9VVRh8g78KyWLJlRJFGQsrxu9EaB/7sGOAKC/yAZW
         uwdQ==
X-Gm-Message-State: AFqh2kodMqn+wmHue2vzyFQl+OMbpARvJdsZhgYeOtYj6d3nLB3DGa5+
        +/8rKI6YpCXchwRlN5H+jNxXgVK0zkPLGwseNl0=
X-Google-Smtp-Source: AMrXdXv66G8WXqBNuBYzpHAknsAJtQxSzEtqqiHk7smapGoNCVADxDJchudqYt89nC5nxEOavqo3qPuHbu9lbraGcnY=
X-Received: by 2002:a25:d505:0:b0:7c0:10aa:961e with SMTP id
 r5-20020a25d505000000b007c010aa961emr70364ybe.346.1673894585852; Mon, 16 Jan
 2023 10:43:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6918:26c5:b0:10e:d15b:5860 with HTTP; Mon, 16 Jan 2023
 10:43:05 -0800 (PST)
In-Reply-To: <20230116101651.jjzz2rcdehs5wvsi@houat>
References: <20191215165924.28314-5-wens@kernel.org> <20230116100359.4479-1-olecom@gmail.com>
 <20230116101651.jjzz2rcdehs5wvsi@houat>
From:   Oleg Verych <olecom@gmail.com>
Date:   Mon, 16 Jan 2023 21:43:05 +0300
Message-ID: <CAHdV42W58Q_ciCmd5bmoX32KpKCKOh1iuGOE5f-=yc_WOJ=A+g@mail.gmail.com>
Subject: Re: [PATCH 04/14] media: sun4i-csi: Fix [HV]sync polarity handling
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        sakari.ailus@linux.intel.com, wens@csie.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 1/16/23, Maxime Ripard <maxime@cerno.tech> wrote:
> Hi,
>
> On Mon, Jan 16, 2023 at 01:03:59PM +0300, Oleg Verych wrote:
>> > -	hsync_pol = !!(bus->flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH);
>> > -	vsync_pol = !!(bus->flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH);
>> > +	/*
>> > +	 * This hardware uses [HV]REF instead of [HV]SYNC. Based on the
>> > +	 * provided timing diagrams in the manual, positive polarity
>> > +	 * equals active high [HV]REF.
>> > +	 *
>> > +	 * When the back porch is 0, [HV]REF is more or less equivalent
>> > +	 * to [HV]SYNC inverted.
>> > +	 */
>> > +	href_pol = !!(bus->flags & V4L2_MBUS_HSYNC_ACTIVE_LOW);
>> > +	vref_pol = !!(bus->flags & V4L2_MBUS_VSYNC_ACTIVE_LOW);
>>
>> After this change has been made there is a need of explicit explanation
>> of what "Active high" / "Active low" in dts really mean.
>
> Why?

It will be better understood by a person behind an oscilloscope who is
trying to figure out the logic behind dts, csi driver, csi controller,
wire voltage levels by just reading device tree definitions. Because
dts must be changed in order to connect source / sink devices.

>
> I'm sorry, it's not clear to me what is confusing in those excerpts?

I'm sorry too, maybe that is not clear. Confusion is here:

>> > +                        hsync-active = <1>; /* Active high */
>>
>> original CSI driver

i.e. <1> - active high

>> > +			hsync-active = <0>; /* Active high */
>>
>> this change patchset

i.e. <0> - active high

>> > +				hsync-active = <1>; /* Active high */
>>
>> this patcheset

i.e. <1> - active high


>> Currently physical high/low voltage levels are like that:
>> (I'm not sure about vsync-active)
>>
>> * hsync-active = <0>; /* HSYNC active 'low' => wire active is 'high' */
>
> Yes
>
>>   CSI register setting: href_pol: 1,
>
> Not really, no. It's what this patch commit log is saying: HREF is
> !HSYNC, so in order to get a hsync pulse active high, you need to set
> href_pol to 0.

I'm totally confused here. That `hsync-active = <0>` -> `href_pol: 1`
was found by `printk()`-like debugging.

(This can be not relevant or incorrect) What was found also is that
active high horizontal wire (whatever it is called in datasheet, PCB,
dts or driver) from e.g. FPGA corresponds to `href_pol: 1` to
correctly read image lines sent.

Thanks!
-- 
sed 'sh && sed && node.js + olecom = happiness and mirth'  <<  ''
-o--=O`C
 #oo'L O
<___=E M
