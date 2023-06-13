Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63A272E56E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242378AbjFMOOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbjFMOOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:14:34 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DC541BD3;
        Tue, 13 Jun 2023 07:14:04 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 8F0D6DC81;
        Tue, 13 Jun 2023 16:13:51 +0200 (CEST)
Message-ID: <219c6e63-f036-9491-9f4a-c11c824c0b5f@gpxsee.org>
Date:   Tue, 13 Jun 2023 16:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND PATCH v6 1/1] Added Digiteq Automotive MGB4 driver
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=c5=afma?= <martin.tuma@digiteqautomotive.com>
References: <20230524112126.2242-1-tumic@gpxsee.org>
 <20230524112126.2242-2-tumic@gpxsee.org>
 <3a7da3cd-8d03-a2c4-0534-a75565aefc13@xs4all.nl>
 <c544814a-7d99-add9-0397-d56776f911dd@gpxsee.org>
 <0cec2b34-01bb-ec0e-f215-9e6ed3f44e73@xs4all.nl>
 <5021c762-3435-719b-18a3-def7888fb5f6@gpxsee.org>
 <313827c0-3b7a-e70a-b281-cbb5f68e6fd2@xs4all.nl>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <313827c0-3b7a-e70a-b281-cbb5f68e6fd2@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 06. 23 14:26, Hans Verkuil wrote:
> On 12/06/2023 16:36, Martin Tůma wrote:
>> On 12. 06. 23 10:42, Hans Verkuil wrote:
>>> On 08/06/2023 13:16, Martin Tůma wrote:
>>>> Hi,
>>>> This is the "technical" part of my response, comments bellow:
>>>>
>>>> On 07. 06. 23 10:41, Hans Verkuil wrote:
>>>>> Hi Martin,
>>>>>
>>>>> Some comments below:
>>>>>
>>>>> On 24/05/2023 13:21, tumic@gpxsee.org wrote:
>>>>>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>>>
>>>>>> diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
>>>>>> new file mode 100644
>>>>>> index 000000000000..77db2fa64ab4
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/admin-guide/media/mgb4.rst
>>>>>> @@ -0,0 +1,352 @@
>>>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>>>> +
>>>>>
>>>>> Perhaps it is a good idea to start with a high level overview of the
>>>>> hardware blocks. That might help understand how the various parts are
>>>>> connected.
>>>>>
>>>>
>>>> This is the "admin-guide" documentation and I'm not sure if the admins (= the card users) are interested in some hardware blocks description. I can for sure ad some basic info like that the card (with
>>>> the given module) has two inputs and two outputs, but if you hold the card in your hands while installing it into the PCIe slot you definitely notice that ;-)
>>>
>>> True, but I don't have that module :-).
>>>
>>> I assume the inputs (and also outputs) are mutually exclusive? I.e., only one at a time can be active?
>>>
>>> But it is also possible to switch between the inputs/outputs dynamically if you want?
>>>
>>> Right now it is hard coded through this property, but I assume there is a reason these
>>> modules have two inputs and two outputs, so it is odd that it is not possible use
>>> VIDIOC_S_INPUT/S_OUTPUT to toggle between them.
>>>
>>
>> With the current modules, you can not even theoretically (after changing the FPGA bitstream) change the outputs to inputs or vice versa as the the serializers/deserializers are hardcoded on the modules.
> 
> I think you misunderstand me.
> 
> Let's keep it simple: a source is connected to input 0 and you capture from it with V4L2.
> 
> Can I dynamically switch to input 1 and capture from that? I.e., each input has a
> different source connected to it, so userspace can select from which input to capture.
> 
> Right now it appears that V4L2 just advertises a single input. And the input_id
> property is read-only. So that means that input 1 is effectively unusable with
> the current driver, or am I missing something?
> 

You can not mix the inputs. Input 0 is always wired to video0 (or 
whatever the naming of the video devices may be) and input 1 to video1 
- there are two v4l2 devices, for every HW input one. The input_id 
property is just a "hint" which device corresponds to the given HW 
input. For the GMSL module, the situation is a little bit more 
complicated, as a single "wire" may contain multiple streams which are 
extracted by the GMSL deserializer (see the "gmsl_stream_id" property) 
so one "wire" may be the source of both video0 and video1, but the video 
streams are different.

For the outputs, you can do more with the video_source property. You can 
for example "duplicate" the input stream to both HW outputs in the 
loopback mode or duplicate a v4l2 output stream to both HW outputs. In 
both cases, the duplication happens inside the PCIe card.

>>
>> I can post here some photo of the card, if it is ok to send image attachement to the mailing list so you have some image of what we are talking about. Or I can even show you the card live when you are
>> in Prague in few days.
> 
> Actually, I'd like that! We'll meet there anyway, so that's a good opportunity to
> see the real deal :-)
> 

I have no problem with taking the PCIe card (and the modules) to the 
conference, but I will definitely not bring the whole setup to see it 
running there as all together (the PC, monitor, infotainment system, car 
display and 12V power supply) it takes a whole desk at my office ;-)
But if you would desperately like to see it "live", you can visit our 
offices and see it there, if you like.

M.

> Regards,
> 
> 	Hans

