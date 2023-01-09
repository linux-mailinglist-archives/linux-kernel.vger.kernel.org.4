Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27E6622B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjAIKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjAIKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:13:15 -0500
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C817400
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=message-id:references:in-reply-to:reply-to:subject:cc:to:from:date:
         content-transfer-encoding:content-type:mime-version:from;
        bh=DpADeRqnpOK1INfFn7yqaglpmahJbhY8EX582Bmd3SY=;
        b=I1ZQK8QX3QZlT2tEUahNaplPFpvXCyeS9V/mlZDOYwtUI7pmVX0sulujmgh+iZCm0yNHQ1CTJAwCO
         2UD84ZVaPxKibdiTFen6jJJA2ngMcKk/YHCQvNir+vGDtmvCc+hbDtExXjzCYs9bVKLFKyFV1eEJ5e
         H2GU3TJKh5rN41xWmbjpij5cdo5TqQRuuL92xrGuPFof4+3q3YAS+D54SAV1xmAjAY/OoBcZQ1gtVH
         KGf56rbaDfz4I/xH6cWK5TwxYW5NoBO4LWgqyeST3CQWbwwlCFWMjUa04Elb/KRVqS6BfSBrc4Vy70
         Ca3+4vIXUqVfvBYHz0i1DjTMhZyLfmQ==
X-MSG-ID: 0f6a649e-9006-11ed-8e79-0050569d2c73
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Jan 2023 11:12:02 +0100
From:   Robin van der Gracht <robin@protonic.nl>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Stephen Kitt <steve@sk2.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 12/15] auxdisplay: ht16k33: Introduce
 backlight_get_brightness()
Organization: Protonic Holland
Reply-To: robin@protonic.nl
Mail-Reply-To: robin@protonic.nl
In-Reply-To: <Y7qM+ZlG5gQiOW4K@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-12-1bd9bafb351f@ravnborg.org>
 <CANiq72mFMJuec+r=T6xYtLpuU+a1rOrAhrHiecy_1Jpj2m4J=g@mail.gmail.com>
 <Y7qM+ZlG5gQiOW4K@ravnborg.org>
Message-ID: <2857575f6ec206f79cc21d423fde7d17@protonic.nl>
X-Sender: robin@protonic.nl
User-Agent: Roundcube Webmail/1.3.1 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 2023-01-08 10:29, Sam Ravnborg wrote:
> Hi Robin.
> 
> On Sat, Jan 07, 2023 at 10:02:38PM +0100, Miguel Ojeda wrote:
>> On Sat, Jan 7, 2023 at 7:26 PM Sam Ravnborg via B4 Submission Endpoint
>> <devnull+sam.ravnborg.org@kernel.org> wrote:
>> >
>> > Introduce backlight_get_brightness() to simplify logic
>> > and avoid direct access to backlight properties.
>> 
>> Note: Stephen sent this one too a while ago (with some more details in
>> the commit message, which is always nice); and then he sent yesterday
>> v2 [1] (to mention the functional change with `BL_CORE_SUSPENDED`
>> [2]).
> Thanks for the pointers. I will try to move forward with Stephen's
> patches.
>> 
>> Anyway, if it goes via drm-misc, feel free to have my:
>> 
>>     Acked-by: Miguel Ojeda <ojeda@kernel.org>
>> 
>> Though it would be nice to have Robin test the change.
> 
> Robin - can I get your ack to apply Stephen's original v2 patch to
> drm-misc?

done! see: 
https://lore.kernel.org/lkml/0b16391f997e6ed005a326e4e48f2033@protonic.nl/

- Robin
