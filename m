Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F636FB248
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjEHOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjEHOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:10:41 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BD336562
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:10:28 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QFNV81gNZz9sZZ;
        Mon,  8 May 2023 16:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1683555024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bsLGikCTizd2YRaD9J2ClJ+IZZ22ebzrO411xaRQwB4=;
        b=X8SoL0uTiYRw82KzKqnlJbS3cOyzjlyDYyZZchaAn9C3sauN4oltXMSnsW5subRjEplErC
        6sXjAecD4ilwIH/eC5JxvFBvibfSCC5vDwTEZjTcXGL5POvVWaYZ2XDOaJv1jAN65EUN96
        NScT46fNe9gF4S5xH02aoiuYQzZpBTZ5BhZqSGquAc1gzmT/M2VXtXfN08VZJfhU4mn8UF
        KHD2WMQGuIRfIEnfo7IC26YB1KYV68oaweovJzm5lQAOX76mupr0OXbixvWZ1C0VvFrwH4
        Ui1Vu8tCEDw705/lYZguM4nCOPm3UGxcHZnz2857XL1YG+vS77lsProt5f8VMQ==
References: <20230418074008.69752-1-me@crly.cz>
 <87cz3uzpx1.fsf@oltmanns.dev> <87mt2o9njh.fsf@oltmanns.dev>
 <CSCPKPC8OB80.1TTBCM3YDVJQ5@void.crly.cz> <87o7mvpayj.fsf@oltmanns.dev>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Roman Beranek <me@crly.cz>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 0/7] drm: sun4i: set proper TCON0 DCLK rate in DSI mode
Date:   Mon, 08 May 2023 16:08:32 +0200
In-reply-to: <87o7mvpayj.fsf@oltmanns.dev>
Message-ID: <87fs86q5h4.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4QFNV81gNZz9sZZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On 2023-05-08 at 08:54:28 +0200, Frank Oltmanns <frank@oltmanns.dev> wrote:
> Hello Roman,
>
> On 2023-05-03 at 16:22:32 +0200, "Roman Beranek" <me@crly.cz> wrote:
>> Hello everyone,
>>
>> I apologize for my absence from the discussion during past week, I got
>> hit with tonsillitis.
>
> I hope you feel better!
>
>> On Mon May 1, 2023 at 3:40 PM CEST, Frank Oltmanns wrote:
>>> Looking at ccu_nkm_determine_rate(), we've found our culprit because it
>>> does not try parent clock rates other than the current one. The same
>>> applies to all other ccu_nkm_* functions.
>>
>> Yes, that's why I dropped CLK_SET_RATE_PARENT from pll-mipi in v3.
>>
>>>  b. Add functionality to ccu_nkm_* to also update the parent clock rate.
>>>
>>> I'm actually interested in tackling b, but I can't make any promises as
>>> to if and when I'll be able to solve it. I'm not certain about any side
>>> effects this might have.
>>
>> It sounds like an interesting exercise. But what if HDMI is then added
>> to the mix?
>
> Thanks for interest in this discussion! I really appreciate it!
>
> First of all, let me admit that I'm no expert on this. But nobody else
> has replied so far, and I want to keep this conversation going, so let
> me share my view.
>
> My understanding is that pll-mipi being able to set pll-video0's rate
> should not have an impact on HDMI, neither positive nor negative. If I'm
> not mistaken those two things are orthogonal.
>
> The relevant part of the clk_summary with your v4 [1] patch on top of
> drm-next looks like this:
>
>                                  enable  protect              hardware
>    clock                          count    count        rate    enable
> ----------------------------------------------------------------------
>     pll-video0                        1        1   294000000         Y
>        hdmi                           0        0   294000000         N
>        tcon1                          0        0   294000000         N
>        pll-mipi                       1        1   431200000         Y
>           tcon0                       2        1   431200000         Y
>              tcon-data-clock          1        1   107800000         Y
>        pll-video0-2x                  0        0   588000000         Y
>
> Note, that pll-video0 is protected.
>
> I don't own any boards that support HDMI in mainline. For the pinephone
> this support is added e.g. in megi's kernel, where connecting an HDMI
> output results in pll-video0's rate being set to 297MHz, even though it
> is 294MHz after boot.
>
> So, for reference, this is the same part of the clk_summary with megi's
> 6.3.0 kernel, USB-C dock unplugged:
>
>                                  enable  protect              hardware
>    clock                          count    count        rate    enable
> ----------------------------------------------------------------------
>     pll-video0                        3        0   294000000         Y
>        hdmi-phy-clk                   1        0    73500000         Y
>        hdmi                           1        0   294000000         Y
>        tcon1                          0        0   294000000         N
>        pll-mipi                       1        0   431200000         Y
>           tcon0                       2        0   431200000         Y
>              tcon-pixel-clock         1        0   107800000         Y
>        pll-video0-2x                  0        0   588000000         Y
>
> pll-video0 is not protected. When plugging in the USB-C dock with an HDMI
> monitor connected, the situation looks like this:

Just for reference, the protection count is disabled by this commit [1]
in megi's kernel.

In the commit message Icenowy Zheng refers to "the ability to keep TCON0
clock stable when HDMI changes its parent's clock." She implemented this
in these two previous commits [2] [3]. None of this is in mainline.

Best regards,
  Frank

[1]: https://github.com/megous/linux/commit/039f7ee3f44adfbe4c6b7c2f1798b9a70c9fb9ee
[2]: https://github.com/megous/linux/commit/a927843932f16e5a7f5ff57fbfd2d5f11c712b67
[3]: https://github.com/megous/linux/commit/0e305371eaa49128856acce9830e6af079442ad6

>
>                                  enable  protect              hardware
>    clock                          count    count        rate    enable
> ----------------------------------------------------------------------
>     pll-video0                        4        1   297000000         Y
>        hdmi-phy-clk                   1        0   148500000         Y
>        hdmi                           1        0   148500000         Y
>        tcon1                          1        1   148500000         Y
>        pll-mipi                       1        0   424285714         Y
>           tcon0                       2        0   424285714         Y
>              tcon-pixel-clock         1        0   106071428         Y
>        pll-video0-2x                  0        0   594000000         Y
>
> As you can see, pll-video0 is updated to 297 MHz. My understanding is
> (again: not an expert here) this is only possible due to the missing
> protection.
>
> What I'm trying to say is that I don't see a connection between HDMI and
> having the functionality in ccu_nkm_* to update the parent clock rate.
>
> But I do think it would be preferable to have pll-video0 at 297 MHz
> after boot on the pinephone. We could achieve this with my two previous
> proposals:
>
>  a) Set pll-video0 to 297 MHz on boot
>  b) Add functionality to ccu_nkm_* to also update the parent clock rate.
>
> If solution b is viable, the goal for the pinephone (and any other
> boards supporting HDMI) would then be to select a pixel-data-clock so
> that the rate for pll-video0 is set to 297 MHz (by selecting an
> appropriate clock speed for the internal panel).
>
> Maybe I'm misunderstanding something. If so, I'd appreciate any
> corrections.
>
> Thanks,
>   Frank
>
> [1]: https://lore.kernel.org/all/20230505052110.67514-1-me@crly.cz/
>
>>
>> Best regards
>> Roman
