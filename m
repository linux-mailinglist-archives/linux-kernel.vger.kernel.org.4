Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564CC71981D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjFAKCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjFAKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:00:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE1095;
        Thu,  1 Jun 2023 03:00:34 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADB636602242;
        Thu,  1 Jun 2023 11:00:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685613633;
        bh=eSsaO6sWjfBDKFigck79tmjPTj7Lur5sngRF5kbxj5w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ay8CzNgFIo+vIAC7ZpNACub8SYO8j7KjxcsPEoLm+bSvAv3OKpX6P70Bs5Nkb0mup
         NUzIc7M75QDxeYScSqr+7LBx7DAZV2s5BsS/FR1Ttquu/TZqTidX8Xlqo0VmhxUv34
         5hcCrhsjc9DJEbOTQWlnDyl1OXCTI1xMwK9lIozbANq+YQFWvXXNOL3/Wt08EovmB6
         NYEFuytqwYk11EmBfrslzICBwZe16uAVd0hOxU8RrWxzoS0GgE0c+1+7DQkr2mrCmu
         HubHVJf9ubMWG1iQ01A6qvGx2D2AJnQT6/XOiXvHNPIrK4UfKpFldZ6ds0Z3+xf6IJ
         UfxYLhJmuNSbQ==
Message-ID: <c26f8cab-9509-1e8a-600f-4f61f38c8b17@collabora.com>
Date:   Thu, 1 Jun 2023 12:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Content-Language: en-US
To:     =?UTF-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
References: <20230510015851.11830-1-wenbin.mei@mediatek.com>
 <0df3968e-da34-b36c-4cb4-92d66508a46a@collabora.com>
 <e682b8b66261a71601707a4e74af2829f86800dc.camel@mediatek.com>
 <7f5e14e5-a814-efd7-6082-c4eff697c536@collabora.com>
 <59568b9e6d50135787932cf8e92624914f29e27b.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <59568b9e6d50135787932cf8e92624914f29e27b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/06/23 05:16, Wenbin Mei (梅文彬) ha scritto:
> On Wed, 2023-05-31 at 10:18 +0200, AngeloGioacchino Del Regno wrote:
> External email : Please do not click links or open attachments until you have verified the sender or the content.
> 
> Il 31/05/23 09:32, Wenbin Mei (梅文彬) ha scritto:
> 
>> On Thu, 2023-05-18 at 11:13 +0200, AngeloGioacchino Del Regno wrote:
> 
>>> External email : Please do not click links or open attachments until
> 
>>> you have verified the sender or the content.
> 
>>>
> 
>>>
> 
>>> Il 10/05/23 03:58, Wenbin Mei ha scritto:
> 
>>>> CQHCI_SSC1 indicates to CQE the polling period to use when using
> 
>>>> periodic
> 
>>>> SEND_QUEUE_STATUS(CMD13) polling.
> 
>>>> The default value 0x1000 that corresponds to 150us, let's decrease
> 
>>>> it to
> 
>>>
> 
>>> The default value 0x1000 (4096) corresponds to 4096 * 52.08uS =
> 
>>> 231.33uS
> 
>>> ...so the default is not 150uS.
> 
>>>
> 
>>> If I'm wrong, this means that the CQCAP field is not 0, which would
> 
>>> mean
> 
>>> that the expected 3uS would be wrong.
> 
>>>
> 
>>> Also, since the calculation can be done dynamically, this is what we
> 
>>> should
> 
>>> actually do in the driver, as this gives information to the next
> 
>>> engineer
> 
>>> checking this piece of code.
> 
>>>
> 
>>> Apart from this, by just writing 0x40 to the CQHCI_SSC1 register, you
> 
>>> are
> 
>>> assuming that the CQCAP value requirement is fullfilled, but you
> 
>>> cannot
> 
>>> assume that the bootloader has set the CQCAP's ITCFVAL and ITCFMUL
> 
>>> fields
> 
>>> as you expect on all platforms: this means that implementing this
> 
>>> takes
> 
>>> a little more effort.
> 
>>>
> 
>>> You have two ways to implement this:
> 
>>>     *** First ***
> 
>>>     1. Read ITCFMUL and ITCFVAL, then:
> 
>>>        tclk_mul = itcfmul_to_mhz(ITCFMUL); /* pseudo function
> 
>>> interprets reg value*/
> 
>>>        tclk = ITCFVAL * tclk_mul;
> 
>>>
> 
>>>     2. Set SSC1 so that we get 3nS:
> 
>>>        #define CQHCI_SSC1_CIT GENMASK(15, 0)
> 
>>>        poll_time = cit_time_ns_to_regval(3);
> 
>>>        sscit = FIELD_PREP(CQHCI_SSC1_CIT, poll_time)
> 
>>>        cqhci_writel( ... )
> 
>>>
> 
>>>     *** Second **
> 
>>>
> 
>>>     1. Pre-set ITCFMUL and ITCFVAL to
> 
>>>        ITCFVAL = 192 (decimal)
> 
>>>        ITCFMUL = 2 (where 2 == 0.1MHz)
> 
>>>
> 
>>>     2. Set SSC1 so that we get 3nS:
> 
>>>        #define CQHCI_SSC1_CIT GENMASK(15, 0)
> 
>>>        poll_time = cit_time_ns_to_regval(3);
> 
>>>        sscit = FIELD_PREP(CQHCI_SSC1_CIT, poll_time)
> 
>>>        cqhci_writel( ... )
> 
>>>
> 
>>> I would implement the first way, as it paves the way to extend this
> 
>>> to different
> 
>>> tclk values if needed in the future.
> 
>>>
> 
>>> Regards,
> 
>>> Angelo
> 
>> Hi Angelo,
> 
>>
> 
>> Sorry for lately reply.
> 
>>
> 
>> For Mediatek mmc host IP, ITCFMUL is 0x2(0x1MHz), ITVFVAL reports 182,
> 
>> and these fields are the same and are readonly for all IC, but since
> 
>> Mediatek CQE uses msdc_hclk(273MHz), CMD13'interval calculation driver
> 
>> should use 273MHz to get the actual time, so the actual clock is
> 
>> 27.3MHz.
> 
>>
> 
> 
> You're right, I've misread the datasheet, just rechecked and it reports RO.
> 
> 
>> If CIT is 0x1000 by default, CMD idle time: 0x1000 * 1 / 27.3MHz =
> 
>> around 150us.
> 
>>
> 
>> In addition the bootloader will not set the CQCAP's ITCFVAL and ITCFMUL
> 
>> fields, because these fields of CQCAP register is RO(readonly), so we
> 
>> can ignore the change for the CQCAP's ITCFVAL and ITCFMUL fields.
> 
>>
> 
> 
> Yes, that's right, again - this means that you should go for the first
> 
> proposed implementation, as future MediaTek SoCs may (or may not) change
> 
> that: if you implement as proposed, this is going to be a one-time thing
> 
> and future SoCs won't need specific changes.
> 
> 
> That implementation also documents the flow about how we're getting to
> 
> the actual value, which is important for community people reading this
> 
> driver in the future for debugging purposes.
> 
> 
> Regards,
> 
> Angelo
> 
> 
> 
> Thanks for your proposal.
> 
> 
> I have discussed with our designer, and this fields of CQCAP's ITCFVAL and ITCFMUL will not change.
> If we add more code for it, these codes will also affect the execution efficiency, even if it has a very
> small effect.
> I think if it's just for reading convenience, we can add mode comments to make it easier to read the code.
> Do you think it's okay to add more comments?
> 

This isn't a performance path, but anyway, if you think that it will be at some
point, you can read the two registers at probe time as part of the MMC_CAP2_CQE
if branch, and then cache the invariable values to `struct msdc_host`: this
will make you able to never perform register reads for ITCFVAL/FMUL in
msdc_cqe_enable(), resolving the efficiency issue.

Even better, instead of caching ITCFVAL/FMUL to two variables, since the idle
timer value likely won't ever change during runtime, you can directly perform
the calculation for SSC1 at probe time and cache that value instead, so that
in msdc_cqe_enable() you will have something like...

	/* Set the send status command idle timer */
	cqhci_writel(cq_host, host->cq_ssc1_time, CQHCI_SSC1);

where cq_ssc1_time is
struct msdc_host {
	.......
	u32 cq_ssc1_time;
	....
}

and where your probe function is

static int msdc_drv_probe(struct platform_device *pdev)
{
	......

	if (mmc->caps2 & MMC_CAP2_CQE) {
		host->cq_host = ......
		........
		read itcfval;
		read itcfmul;
		host->cq_ssc1_time = calculated-value;
		........
	}

	.......
}

Regards,
Angelo


> Begards,
> Wenbin
> 
>> Thanks
> 
>> Wenbin
> 
>>>
> 
>>>> 0x40 that corresponds to 3us, which can improve the performance of
> 
>>>> some
> 
>>>> eMMC devices.
> 
>>>>
> 
>>>> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> 
>>>> ---
> 
>>>>     drivers/mmc/host/mtk-sd.c | 4 ++++
> 
>>>>     1 file changed, 4 insertions(+)
> 
>>>>
> 
>>>> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> 
>>>> index edade0e54a0c..ffeccddcd028 100644
> 
>>>> --- a/drivers/mmc/host/mtk-sd.c
> 
>>>> +++ b/drivers/mmc/host/mtk-sd.c
> 
>>>> @@ -2453,6 +2453,7 @@ static void msdc_hs400_enhanced_strobe(struct
> 
>>>> mmc_host *mmc,
> 
>>>>     static void msdc_cqe_enable(struct mmc_host *mmc)
> 
>>>>     {
> 
>>>>         struct msdc_host *host = mmc_priv(mmc);
> 
>>>> +     struct cqhci_host *cq_host = mmc->cqe_private;
> 
>>>>
> 
>>>>         /* enable cmdq irq */
> 
>>>>         writel(MSDC_INT_CMDQ, host->base + MSDC_INTEN);
> 
>>>> @@ -2462,6 +2463,9 @@ static void msdc_cqe_enable(struct mmc_host
> 
>>>> *mmc)
> 
>>>>         msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
> 
>>>>         /* default read data timeout 1s */
> 
>>>>         msdc_set_timeout(host, 1000000000ULL, 0);
> 
>>>> +
> 
>>>> +     /* decrease the send status command idle timer to 3us */
> 
>>>> +     cqhci_writel(cq_host, 0x40, CQHCI_SSC1);
> 
>>>>     }
> 
>>>>
> 
>>>>     static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
> 
>>>
> 
>>>
> 
> 
> 

