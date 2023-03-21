Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1716C6C3845
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCUReK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCUReF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:34:05 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A2051CAA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:33:45 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id C75EA16C0007;
        Tue, 21 Mar 2023 19:12:13 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BQI5JdkOs9dG; Tue, 21 Mar 2023 19:12:12 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679418732; bh=GZ2jUeTUCoLsgOPhL0fTGLaijRLvdapi4CTxCCln2DY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lDwXhBhf0yBAEAq5F0/8uf8/P1ckYfa0vxFaifa6SoqP0X3uYbZ5Kn35wla/k42xJ
         ktVwSR/gmIMjs01JlZTGbFvD1y/ChlEBI9jkbgCp09aaeCbBAlhQMHVAWrtbYN0O7m
         jm9BAmHK5ddJpUc+qqyL28kET69Vwki2hWUddWc8=
To:     Mark Brown <broonie@kernel.org>, zhuning@everest-semi.com,
        yangxiaohua@everest-semi.com
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/4] ASoC: es8316: Enable support for S32 LE format and
 MCLK div by 2
In-Reply-To: <6825a54e-f2c0-41c4-981c-fafcd10454fd@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-2-posteuca@mutex.one>
 <6825a54e-f2c0-41c4-981c-fafcd10454fd@sirena.org.uk>
Date:   Tue, 21 Mar 2023 19:09:43 +0200
Message-ID: <87o7omvxns.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for taking the time to review this series of patches.

Mark Brown <broonie@kernel.org> writes:

> On Mon, Mar 20, 2023 at 10:35:16PM +0200, Marian Postevca wrote:
>
>> To properly support a line of Huawei laptops with AMD CPU and a
>> ES8336 codec connected to the ACP3X module we need to enable
>> the S32 LE format and the codec option to divide the MCLK by 2.
>
> The 32 bit support and MCLK division are two separate changes so should
> be two separate patches.
>

Ok, no problem, I just thought that a separate commit for one line was overkill.

>> -	lrck_divider = es8316->sysclk / params_rate(params);
>> +
>> +	mclk_div_option = device_property_read_bool(component->dev,
>> +						    "everest,mclk-div-by-2");
>> +	if (mclk_div_option) {
>
> This introduces a DT property but there's no documentation for it, but I
> don't see why we'd want this in the bindings - the driver should be able
> to tell from the input clock rate and required output/internal clocks if
> it needs to divide MCLK.

The problem here is that I have no knowledge what is the maximum MCLK
that the codec accepts. According to the datasheet the maximum supported
frequency of MCLK is 51.2 Mhz. But this doesn't seem to be the case in
practice since a MCLK of 48Mhz causes noises in the sound output.
The idea to divide the MCLK by 2 was proposed by a Everest Semiconductor
engineer.
So I don't know how to make this generic enough to be activated from the
codec driver.

I cced the Everest Semiconductor engineers, maybe they have a proposal
on how to activate this.


