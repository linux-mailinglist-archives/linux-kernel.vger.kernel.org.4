Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FF6C3475
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjCUOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCUOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:39:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6E84ECED;
        Tue, 21 Mar 2023 07:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C16661C99;
        Tue, 21 Mar 2023 14:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0455C433D2;
        Tue, 21 Mar 2023 14:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679409543;
        bh=QJ9XbeVgP7ug2n2l5ULV94tPN3odQBVBNeJl6HL2eRk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M85+3K6tn6R0n4/goHCpdSHVzDkvejGuFb1l6LJzJhQD6z5LPcN0Z3pqTG8NmHlhI
         Kcet/afF7utz3/uCz1zp8oVN43BqXphJ4J63GOT1kHpyMedJnZrtloQ/EyoMVrxCbx
         BQCdCTbpM3TdMuk+m6VsNniR050XJBAMzteVXcKA5g8SSWsbnZrMsTiuXw3vzuUUmT
         GcYKvcqSS0vWNsvy4HIaceC9xNvpcPDkQpJiI9frFdlKa5cPB7Dxzoa6e5uuz1cq3i
         nnbHpCWfEj3lA8uVfMpa412tWbKZMWrdtjj8Qt6AEavfuPh+nq/JBkiomzyq3ZzkK5
         D0MmToSfoOUUQ==
Message-ID: <f32cffc4-c327-5019-3598-21516056b4e1@kernel.org>
Date:   Tue, 21 Mar 2023 16:38:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
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
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <5459d8d3-4829-01ab-7000-2c1f58ad69e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.23 16:11, Konrad Dybcio wrote:
> 
> 
> On 21.03.2023 14:58, Georgi Djakov wrote:
>> Hi,
>>
>> On 11.03.23 17:26, Dmitry Baryshkov wrote:
>>> On 11/03/2023 16:38, Bryan O'Donoghue wrote:
>>>> On 11/03/2023 14:35, Dmitry Baryshkov wrote:
>>>>>> Its probably worthwhile experimenting to see if the*ufs*_clk can/should
>>>>>> be added to the UFS device list of clocks.
>>>>> While we were doing this for some of the clocks (PCIe and USB, if I'm
>>>>> not mistaken), I think that generally this is not fully correct. In my
>>>>> opinion it should be in the interconnect driver, who turns
>>>>> corresponding clocks on and off. These clocks correspond to the SoC
>>>>> topology, rather than the end-device.
>>>>>
>>>>
>>>> True enough, they are interconnect clocks.
>>>>
>>>> The question is how to only turn them on when the device that depends on them wants them.
>>>
>>> I think we can turn them on an off from qcom_icc_set(). Each node can list required clocks.
>>>
>>
>> Yes, this is a bit weird, but looks like these are the interface clocks
>> required for programming the qos box of the respective peripheral and
>> nothing else. Maybe we can even configure QoS just once (eg. on the first
>> bandwidth request) and not every time we call qcom_icc_set().
> Would that persist a full bus reset - if we e.g. shut down MMNoC
> after the display stack is turned off in preparation for a power
> collapse, would we have to reprogram it?
> 
> Another thing is, do we know "how persistent" the QoS settings are?
> What could reset them? Would a bandwidth request for a node that
> belongs to the same path do so?

That's a good question. From what i recall, i expect them to persist until
you reset the board. Probably we can verify it with an experiment by reading
them back, but let me check if i can find some info.

Thanks,
Georgi
