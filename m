Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734DA67A590
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjAXWTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjAXWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:19:15 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03073E0B3;
        Tue, 24 Jan 2023 14:19:13 -0800 (PST)
Message-ID: <3d448210-e9d2-b0ee-e009-535bb0bb760d@ansari.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674598751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+v7CuIhOoILRppgHxxh5e1k2L4tbU2G1qFmuWYmc0o=;
        b=CQ8g72/Wf+xIuT5nOyeQfhWCNcSF/isB0ieb/e5+Q/+bR1GXUaj5KYvoVTqC5yZqAP8wEt
        cFD2I+uiPnRE7yqxGmG7kYtZ7PFY646XRm2ePLhEoOUFxxDSqiYFM1iINlIC4bQ62AVKGK
        mTAkqoNStMMUcaVFHbv2+2gBy7un5iY=
Date:   Tue, 24 Jan 2023 22:19:09 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230121153544.467126-1-rayyan@ansari.sh>
 <20230121153544.467126-3-rayyan@ansari.sh>
 <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
 <cdf32cb0-4529-6bbd-fdda-ae641d141ee5@ansari.sh>
 <20230123175339.GA2019900-robh@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rayyan Ansari <rayyan@ansari.sh>
In-Reply-To: <20230123175339.GA2019900-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 17:53, Rob Herring wrote:
> On Sun, Jan 22, 2023 at 05:25:38PM +0000, Rayyan Ansari wrote:
>> On 22/01/2023 15:36, Rob Herring wrote:
>>> On Sat, Jan 21, 2023 at 9:36 AM Rayyan Ansari <rayyan@ansari.sh> wrote:
>>>>
>>>
>>> Why do you need this change?
>>>
>>> The 'simple-framebuffer' contains data on how the bootloader
>>> configured the display. The bootloader doesn't configure the display
>>> size, so this information doesn't belong here. The information should
>>> already be in the panel node, so also no point in duplicating it here.
>>>
>>>> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
>>>> ---
>>>>    .../devicetree/bindings/display/simple-framebuffer.yaml   | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>
>> Hi Rob,
>>
>> There is the usecase that Hans has mentioned, but I have also mentioned
>> another usecase previously.
>>
>> Adding the width-mm and height-mm properties allows user interfaces such as
>> Phosh (https://puri.sm/posts/phosh-overview/) to scale correctly to the
>> screen. In my case, a panel node is not available and the aforementioned
>> interface is in fact running on the SimpleDRM driver (which binds to the
>> simple-framebuffer device).
> 
> Why is the panel node not available? Why not add it? Presumably it is
> not there because you aren't (yet) using the simple-panel driver (and
> others that would need). But presumably you will eventually as I'd
> imagine turning the screen off and back on might be a desired feature.

It requires more than using the simple-panel driver: first the SoC side 
display hardware needs to be brought up, then a panel driver that 
implements the proper DCS initialisation sequence needs to be written 
(which is currently not fully known).

> 
> So why add a temporary DT property that's tied to your *current* kernel? > The DT should not be tightly coupled to the kernel.

I'm not sure what you mean by it being "tightly coupled" to the kernel.

> 
> Rob

-- 
Rayyan Ansari
https://ansari.sh

