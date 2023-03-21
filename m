Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7C6C386D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCURjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCURjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:39:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1837F55524;
        Tue, 21 Mar 2023 10:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E60C0B818D2;
        Tue, 21 Mar 2023 17:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E580CC433EF;
        Tue, 21 Mar 2023 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679420291;
        bh=h6PaXJFdNf2jrbSib5gtfbzWZDlURlMX1ekxTl2pyT8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=LxHBE/UOj7jZzGE6nQmnjE2zuhJVVKMaWI7bt8qm7ARn7QWGhhbPZIFY5zL1PEVh2
         NG6LcXCL7oSQjC3azOUVfK+ekBlwqMOGc1dQ/E4tO6yGBmteXm+CVjoZEHOkfMtQKJ
         7KcDXdmdzvHlRXvDt4VJTPFgRYu5uExNvEth/Gb/h0oueeyoIL8rl3ayf5PRYsX3sR
         UFiNDID6byANLG9dfjQmFfKkUvw3kCAAox4FuU6tyZsTXGavQEb7tL+N8bnzrooTbF
         7C6eZLiMjwhmjVjBxSE+rx0gxgK4nsaIgI9opSpCsmejMgozdsejYSbylnVpFk7LPE
         0LTCzsAEVu6ew==
Message-ID: <a9819d66-43fc-e964-b523-27161466a70a@kernel.org>
Date:   Tue, 21 Mar 2023 19:38:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
From:   Georgi Djakov <djakov@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
 <68a5d81a-5de8-798a-c150-d74c8ad38cb7@linaro.org>
 <f848061a-763e-fbf2-860c-758373e953df@linaro.org>
 <CAA8EJpqh+A_YKbhSQB5sWj4EP9eQtNHeohDira9o-jrx3pPRNg@mail.gmail.com>
 <51c41e49-5183-551e-c796-5b3d792b422f@linaro.org>
 <74f154b1-a440-fa83-1a46-a5b9223f5760@linaro.org>
 <0af8ba67-f33c-4861-bea5-e662d19638bf@kernel.org>
 <5459d8d3-4829-01ab-7000-2c1f58ad69e8@linaro.org>
 <f32cffc4-c327-5019-3598-21516056b4e1@kernel.org>
In-Reply-To: <f32cffc4-c327-5019-3598-21516056b4e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.23 16:38, Georgi Djakov wrote:
> On 21.03.23 16:11, Konrad Dybcio wrote:
>>
>>
>> On 21.03.2023 14:58, Georgi Djakov wrote:
>>> Hi,
>>>
>>> On 11.03.23 17:26, Dmitry Baryshkov wrote:
>>>> On 11/03/2023 16:38, Bryan O'Donoghue wrote:
>>>>> On 11/03/2023 14:35, Dmitry Baryshkov wrote:
>>>>>>> Its probably worthwhile experimenting to see if the*ufs*_clk can/should
>>>>>>> be added to the UFS device list of clocks.
>>>>>> While we were doing this for some of the clocks (PCIe and USB, if I'm
>>>>>> not mistaken), I think that generally this is not fully correct. In my
>>>>>> opinion it should be in the interconnect driver, who turns
>>>>>> corresponding clocks on and off. These clocks correspond to the SoC
>>>>>> topology, rather than the end-device.
>>>>>>
>>>>>
>>>>> True enough, they are interconnect clocks.
>>>>>
>>>>> The question is how to only turn them on when the device that depends on them wants them.
>>>>
>>>> I think we can turn them on an off from qcom_icc_set(). Each node can list required clocks.
>>>>
>>>
>>> Yes, this is a bit weird, but looks like these are the interface clocks
>>> required for programming the qos box of the respective peripheral and
>>> nothing else. Maybe we can even configure QoS just once (eg. on the first
>>> bandwidth request) and not every time we call qcom_icc_set().
>> Would that persist a full bus reset - if we e.g. shut down MMNoC
>> after the display stack is turned off in preparation for a power
>> collapse, would we have to reprogram it?
>>
>> Another thing is, do we know "how persistent" the QoS settings are?
>> What could reset them? Would a bandwidth request for a node that
>> belongs to the same path do so?
> 
> That's a good question. From what i recall, i expect them to persist until
> you reset the board. Probably we can verify it with an experiment by reading
> them back, but let me check if i can find some info.
> 

This seems to be hardware specific and there is no general answer. It depends
on where the reset line for the NIU comes from. It could be from the primary
chip reset in most cases, but it could be also within the power domain of the
associated core.

Thanks,
Georgi

