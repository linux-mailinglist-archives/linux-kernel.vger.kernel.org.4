Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBEE65C02D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbjACMs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbjACMs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:48:28 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF1F45;
        Tue,  3 Jan 2023 04:48:25 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5030960293A85;
        Tue,  3 Jan 2023 13:48:23 +0100 (CET)
Message-ID: <4d64e3f9-57a3-c6be-2709-36e9a1617bf9@molgen.mpg.de>
Date:   Tue, 3 Jan 2023 13:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
To:     Kun-Fa Lin <milkfafa@gmail.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com, kwliu@nuvoton.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kflin@nuvoton.com,
        linux-media@vger.kernel.org
References: <20221227095123.2447948-1-milkfafa@gmail.com>
 <20221227095123.2447948-8-milkfafa@gmail.com>
 <b8f173c0-6d40-d6aa-543e-fa8b06557f4f@molgen.mpg.de>
 <CADnNmFr1naRfam=z0p-4hEugSDJy_HCK8XZyQJ0eFirnmwuH4A@mail.gmail.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CADnNmFr1naRfam=z0p-4hEugSDJy_HCK8XZyQJ0eFirnmwuH4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kun-Fa,


Am 29.12.22 um 09:55 schrieb Kun-Fa Lin:

>>> Add driver for Video Capture/Differentiation Engine (VCD) and Encoding
>>> Compression Engine (ECE) present on Nuvoton NPCM SoCs. The VCD can
>>> capture and differentiate video data from digital or analog sources,
>>
>> “differentiate video data” sounds uncommon to me. Am I just ignorant or
>> is there a better term?
> 
> How about "The VCD can capture a frame from digital video input and
> compare two frames in memory, then the ECE will compress the frame
> data into HEXTITLE format", is it better?

Yes, I prefer your suggestion.

>> Wich VNC viewer and version?
> 
> I used RealVNC version 6.21.1109 to test.
> Do I have to add this information in the commit message?

I do not think there are rules, but I prefer to have the test 
environment and procedure information in the commit message in case 
there are problems, and you want to reproduce things.

>> Maybe also paste the new dev_ log messages you get from one boot.
> 
> Do you mean dev_info/dev_debug messages of the driver?
> If yes, I get these messages from one boot (only dev_info will be
> printed in default):
> 
> npcm-video f0810000.video: assigned reserved memory node framebuffer@0x33000000
> npcm-video f0810000.video: NPCM video driver probed

Yes, that is what I meant. Maybe even the debug messages.

>> It’d be great if you noted the datasheet name and revision.
> 
> I can note the datasheet name and revision in the commit message but
> can't provide the file link because it is not public.
> Is it ok with you?

Yes, that would be ok with me.

>>> +static unsigned int npcm_video_ece_get_ed_size(struct npcm_video *video,
>>> +                                            u32 offset, u8 *addr)
>>> +{
>>> +     struct regmap *ece = video->ece.regmap;
>>> +     u32 size, gap, val;
>>
>> Using a fixed size type for variables not needing is, is actually not an
>> optimization [1]. It’d be great, if you went over the whole change-set
>> to use the non-fixed types, where possible. (You can also check the
>> difference with `scripts/bloat-o-meter`.
> 
> So what I have to do is replace "u8/u16/u32" with "unsigned int" for
> generic local variables as much as possible.
> Is my understanding correct?

Yes, I would say so.

>>> +MODULE_AUTHOR("Joseph Liu<kwliu@nuvoton.com>");
>>> +MODULE_AUTHOR("Marvin Lin<kflin@nuvoton.com>");
>>
>> Please add a space before the <.
>>
>>> +MODULE_DESCRIPTION("Driver for Nuvoton NPCM Video Capture/Encode Engine");
>>> +MODULE_LICENSE("GPL");
>>
>> Not GPL v2?
> 
> I'll correct them in the next patch.

Awesome.


Kind regards,

Paul
