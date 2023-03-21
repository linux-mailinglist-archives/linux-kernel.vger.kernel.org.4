Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABAD6C33F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjCUOV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCUOVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:21:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E421974;
        Tue, 21 Mar 2023 07:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3540B816ED;
        Tue, 21 Mar 2023 14:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD594C433EF;
        Tue, 21 Mar 2023 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679408467;
        bh=3xT7x0pBcWaKYFo4t2LsM4NDEaF9mrj6optAqDsUUfI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Do3KnLCv/NfjHYqjDAN5uTwu6A+DlEa+P/AubBV0oUU+CoWR5CBI6SHknFw7RqVdz
         k/3YY49JUe4COz7v+/E+PjZj8AxIsXfDfMDTuDTnNaLcFeaIMTgRungIqtIvo4lEOa
         i0UPLntBQU6T2hV22IQqqOlXV8dCwLHcAh6v7lEJxirMBo7Y22hCi05q4VKrjZuOsu
         0EdCCfJBO1GUCaL0L7LQz7MvadtVjnZyKZjmoNa53Ndxy8mnmOqCfz9LjsqYySbFUz
         ECkyFe25VHJ3uWTYmv9ccyNooRPyRBSEwhD5pTaW0zJBRRT3CmF0qMYpLW7dRC03bT
         59szPWCgBsbfw==
Message-ID: <f8baed88-6a3b-17c5-4134-ce3917ee8632@kernel.org>
Date:   Tue, 21 Mar 2023 16:21:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/9] interconnect: qcom: rpm: Add support for
 specifying channel num
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-2-815606092fff@linaro.org>
 <2f54ae85-f7b9-4666-cc05-6aa034028789@kernel.org>
 <38fe0736-b566-9e1b-d7f3-71e3fcd01d90@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <38fe0736-b566-9e1b-d7f3-71e3fcd01d90@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.23 16:09, Konrad Dybcio wrote:
> 
> On 21.03.2023 15:06, Georgi Djakov wrote:
>> Hi Konrad,
>>
>> Thanks for the patch!
>>
>> On 8.03.23 23:40, Konrad Dybcio wrote:
>>> Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
>>> one channel. This should be taken into account in bandwidth calcualtion,
>>> as we're supposed to feed msmbus with the per-channel bandwidth. Add
>>> support for specifying that and use it during bandwidth aggregation.
>>>
>>
>> This looks good, but do you have any follow-up patch to use this and set
>> the channels in some driver?
> Yes, I have a couple of OOT drivers that are gonna make use of it.
> TBF it should have been sent separately from the QoS mess, but I
> don't think it's much of an issue to take it as-is.
> 
> The aforementioned OOT drivers for MSM8998 and SM6375 will be
> submitted after we reach a consensus on how we want to ensure
> that each node is guaranteed to have its clocks enabled before
> access, among some other minor things.

Yes, these QoS clocks are confusing. Maybe you can even submit them
without configuring any QoS stuff in first place? Does enabling QoS
actually show any benefits on these devices?

Thanks,
Georgi

> Konrad
>>
>> BR,
>> Georgi
>>
>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
>>>    drivers/interconnect/qcom/icc-rpm.h | 2 ++
>>>    2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>>> index 35fd75ae70e3..27c4c6497994 100644
>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>> @@ -317,6 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>>    {
>>>        struct icc_node *node;
>>>        struct qcom_icc_node *qn;
>>> +    u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>>        int i;
>>>          /* Initialise aggregate values */
>>> @@ -334,7 +335,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>>        list_for_each_entry(node, &provider->nodes, node_list) {
>>>            qn = node->data;
>>>            for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>>> -            agg_avg[i] += qn->sum_avg[i];
>>> +            if (qn->channels)
>>> +                sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
>>> +            else
>>> +                sum_avg[i] = qn->sum_avg[i];
>>> +            agg_avg[i] += sum_avg[i];
>>>                agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
>>>            }
>>>        }
>>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>>> index 8ba1918d7997..8aed5400afda 100644
>>> --- a/drivers/interconnect/qcom/icc-rpm.h
>>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>>> @@ -66,6 +66,7 @@ struct qcom_icc_qos {
>>>     * @id: a unique node identifier
>>>     * @links: an array of nodes where we can go next while traversing
>>>     * @num_links: the total number of @links
>>> + * @channels: number of channels at this node (e.g. DDR channels)
>>>     * @buswidth: width of the interconnect between a node and the bus (bytes)
>>>     * @sum_avg: current sum aggregate value of all avg bw requests
>>>     * @max_peak: current max aggregate value of all peak bw requests
>>> @@ -78,6 +79,7 @@ struct qcom_icc_node {
>>>        u16 id;
>>>        const u16 *links;
>>>        u16 num_links;
>>> +    u16 channels;
>>>        u16 buswidth;
>>>        u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>>        u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>>>
>>

