Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525AB6CB095
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjC0VWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjC0VWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:22:09 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F61737
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:22:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 3A32016C004C;
        Tue, 28 Mar 2023 00:22:05 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DRwPyVH3Lsy0; Tue, 28 Mar 2023 00:22:04 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679952124; bh=xdxFVQ23VXsicKqsyoUsdwDbDN0xUQmbpZ/k555xexs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IneOlJqPs2/eKISDZnyh0/gPXQGrU2LAlNtcU5e/iTffI90ZeQKbxOlklphIh+6F2
         73oQVoMea4cnfsksBQml7Qoo6GNp6UonEu/aylbTbek1O62y8ggcOi3UuXgueunI5h
         tX/V4F6GAPAf/v5gSMee5vPHfy/m5UxUZfx0y9KY=
To:     Mark Brown <broonie@kernel.org>
Cc:     =?utf-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
        yangxiaohua <yangxiaohua@everest-semi.com>,
        Zhu Ning <zhuning@everest-semi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
In-Reply-To: <ZBty1CdPaWm0IcRi@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
 <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one> <ZBr9rJn50ovG1w9W@sirena.org.uk>
 <87ttycjyw3.fsf@mutex.one> <ZBty1CdPaWm0IcRi@sirena.org.uk>
Date:   Tue, 28 Mar 2023 00:20:55 +0300
Message-ID: <87r0t9uc08.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

>> >> This is needed because if suspending the laptop with the headphones
>> >> inserted, when resuming, the sound is not working anymore. Sound stops
>> >> working on speakers and headphones. Reinsertion and removals of the
>> >> headphone doesn't solve the problem.
>
>> >> This seems to be caused by the fact
>> >> that the GPIO IRQ stops working in es8316_irq() after resume.
>
>> > That's a bug that should be fixed.
>
>> Agreed, but I don't know how easy it is to fix, and I would like to
>> first offer users of these laptops a working sound driver.
>> Afterwards this issue can be analyzed and properly fixed.
>
> Surely if nothing else a good first step would be to have the
> CODEC driver do whatever disabling the jack does on suspend
> without needing the machine driver to bodge things?

I would go for properly analyzing what is going on and try to correctly fix it,
but it's going to take some time for me to do it. During this time
people with these laptops will not have working sound. Wouldn't it make
more sense to first deliver a working solution(even though it's not
perfect) than to make them wait? Also this workaround is already present
in the kernel, so it's not that critical that another driver uses it.
