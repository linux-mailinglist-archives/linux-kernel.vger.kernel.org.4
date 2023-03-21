Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F726C3A42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCUTT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUTT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:19:27 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FEA509A0;
        Tue, 21 Mar 2023 12:18:56 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 2501DC80090;
        Tue, 21 Mar 2023 20:18:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id LjQtkenegxx8; Tue, 21 Mar 2023 20:18:11 +0100 (CET)
Received: from [192.168.178.25] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 10848C8008E;
        Tue, 21 Mar 2023 20:18:10 +0100 (CET)
Message-ID: <734f5548-a572-ff52-c7c1-312c4ad70058@tuxedocomputers.com>
Date:   Tue, 21 Mar 2023 20:18:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] Input: i8042 - add TUXEDO devices to i8042 quirk
 tables for partial fix
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, tiwai@suse.de,
        samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220708161005.1251929-1-wse@tuxedocomputers.com>
 <20220708161005.1251929-3-wse@tuxedocomputers.com>
 <37a7e536-252a-c8a9-1412-37d3f2052a6d@redhat.com>
 <c5a7fa10-7b6a-fa0d-622e-4392fda1ee93@tuxedocomputers.com>
 <e84a2cb3-ea2f-6ce4-aba8-4026b3e6bedd@redhat.com>
 <f50b3db3-785d-3efd-b45d-13e1e93f60cc@tuxedocomputers.com>
 <ZBn9HYw/NOvHFkrk@google.com>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZBn9HYw/NOvHFkrk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 21.03.23 um 19:53 schrieb Dmitry Torokhov:
> Hi Werner,
>
> On Tue, Mar 21, 2023 at 05:10:19PM +0100, Werner Sembach wrote:
>> Am 11.07.22 um 14:55 schrieb Hans de Goede:
>>> Hi,
>>>
>>> On 7/11/22 14:45, Werner Sembach wrote:
>>>> Hi,
>>>>
>>>> On 7/8/22 21:39, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 7/8/22 18:10, Werner Sembach wrote:
>>>>>> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
>>>>>> suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
>>>>>> have an external PS/2 port so this can safely be set for all of them.
>>>>>>
>>>>>> I'm not entirely sure if every device listed really needs all four quirks,
>>>>>> but after testing and production use. No negative effects could be
>>>>>> observed when setting all four.
>>>>>>
>>>>>> Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS on the Clevo N150CU
>>>>>> and the Clevo NHxxRZQ makes the keyboard very laggy for ~5 seconds after
>>>>>> boot and sometimes also after resume. However both are required for the
>>>>>> keyboard to not fail completely sometimes after boot or resume.
>>>>> Hmm, the very laggy bit does not sound good. Have you looked into other
>>>>> solutions, e.g. what happens if you use just nomux without any of the
>>>>> other 3 options ?
>>>> I tried a lot of combinations, but it was some time ago.
>>>>
>>>> iirc: at least nomux and reset are required and both individually cause the lagging.
>>>>
>>>> So the issue is not fixed by just using a different set of quirks.
>>> Hmm, ok. So given that this seems to be the best we can do
>>> the patch looks good to me:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Regards,
>>>
>>> Hans
>> Afaik this patch never got merged. Sadly I still have no better solution, so
>> I wanted to bring the patch up for discussion again as it still makes the
>> situation better in my opinion.
> Could you rebase on top of the latest kernel?
>
> Thanks.
>
ofc, sent as v3
