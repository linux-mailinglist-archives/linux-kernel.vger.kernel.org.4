Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7FA61EA99
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiKGFnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKGFnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:43:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F32DFC;
        Sun,  6 Nov 2022 21:43:12 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A75b56h020033;
        Mon, 7 Nov 2022 05:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nwt6wD2/dJAWmW5gjL11ffiveIB70LyyJlu7YrjKMVU=;
 b=pda/BM53zRF1hqYQFiomr7kD9IfeE87QaKmzUd143463zEmfl3leAxp4wJAemUgfX7km
 FjbfA5uPOsubm+rczrNQ5V1aCrEkmK7ZF3m9gMt0kOiJR1ts027bQXcH/0JTwY++ftyh
 dC75qoP+n0L4DY8L8tHji9SlJ2ppAq6KOXI2lpMGKQOb0/y7HNtGa5wwguDO/FjgL72o
 I9y9oG5HTQ/Odl4buGtvFG/jyABmTY8aM4JCRqA6ik74gDkC8qIzMHhW4UE2zBumHM/2
 QQlrYvm72mEzvJ9slt9B0XILvWRN/ICBvc5JvLR9kxp7IojJFZmpvATz1cbLHe0bPrAM vA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kphq2rn5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 05:42:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A75grwY027306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 05:42:53 GMT
Received: from [10.110.53.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 6 Nov 2022
 21:42:47 -0800
Message-ID: <a019d6e7-6796-c34f-f9b5-d7d4a4260b14@quicinc.com>
Date:   Mon, 7 Nov 2022 11:12:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V17 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Alex Elder <elder@ieee.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1665549527.git.quic_schowdhu@quicinc.com>
 <5fee939d0a238344c7db11cf322adcb6baa35724.1665549527.git.quic_schowdhu@quicinc.com>
 <6693993c-bd81-c974-a903-52a62bfec606@ieee.org>
 <7f61eba9-30d2-1540-1c2f-6af7a50a4b53@quicinc.com>
 <461b7484-b244-c66f-7a86-fadc5c7cabca@ieee.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <461b7484-b244-c66f-7a86-fadc5c7cabca@ieee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ygfgo6M5wmrlbvhOYcY-XSwHV1PSmH1o
X-Proofpoint-ORIG-GUID: ygfgo6M5wmrlbvhOYcY-XSwHV1PSmH1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-06_16,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211070047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2022 12:21 AM, Alex Elder wrote:
> On 10/21/22 2:14 AM, Souradeep Chowdhury wrote:
>>
>>
>> On 10/21/2022 5:37 AM, Alex Elder wrote:
>>> On 10/14/22 1:00 AM, Souradeep Chowdhury wrote:
>>>> The DCC is a DMA Engine designed to capture and store data
>>>> during system crash or software triggers. The DCC operates
>>>> based on user inputs via the debugfs interface. The user gives
>>>> addresses as inputs and these addresses are stored in the
>>>> dcc sram. In case of a system crash or a manual software
>>>> trigger by the user through the debugfs interface,
>>>> the dcc captures and stores the values at these addresses.
>>>> This patch contains the driver which has all the methods
>>>> pertaining to the debugfs interface, auxiliary functions to
>>>> support all the four fundamental operations of dcc namely
>>>> read, write, read/modify/write and loop. The probe method
>>>> here instantiates all the resources necessary for dcc to
>>>> operate mainly the dedicated dcc sram where it stores the
>>>> values. The DCC driver can be used for debugging purposes
>>>> without going for a reboot since it can perform software
>>>> triggers as well based on user inputs.
>>>>
>>>> Also added the documentation for debugfs entries and explained
>>>> the functionalities of each debugfs file that has been created
>>>> for dcc.
>>>>
>>>> The following is the justification of using debugfs interface
>>>> over the other alternatives like sysfs/ioctls
>>>>
>>>> i) As can be seen from the debugfs attribute descriptions,
>>>> some of the debugfs attribute files here contains multiple
>>>> arguments which needs to be accepted from the user. This goes
>>>> against the design style of sysfs.
>>>>
>>>> ii) The user input patterns have been made simple and convenient
>>>> in this case with the use of debugfs interface as user doesn't
>>>> need to shuffle between different files to execute one instruction
>>>> as was the case on using other alternatives.
>>>>
>>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>>
>>> I haven't followed any review feedback you have received
>>> since verion 8 (which I reviewed), so if I say something
>>> that conflicts with other feedback I apologize.  I know
>>> Bjorn had some comments too, so you're already going to
>>> send another version.
>>>
>>> Unfortunately I have some more input, including some things
>>> that are basically bugs (because buffers could be overrun).
>>> I will plan to review again once you've had a chance to
>>> address my comments.
>>>
>>>                      -Alex
>>
>> Thanks for the review. Will be sending out the next version 
>> implementing Bjorn's and your comments.
> 
> Sorry for my delayed response.  Your message didn't show up
> in my "normal" mail box so I'm catching up now.
> 
> . . .
> 
>>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>>> index d66604a..b1fe812 100644
>>>> --- a/drivers/soc/qcom/Makefile
>>>> +++ b/drivers/soc/qcom/Makefile
>>>> @@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=    qcom_aoss.o
>>>>   obj-$(CONFIG_QCOM_GENI_SE) +=    qcom-geni-se.o
>>>>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>>>>   obj-$(CONFIG_QCOM_CPR)        += cpr.o
>>>> +obj-$(CONFIG_QCOM_DCC) += dcc.o
>>>>   obj-$(CONFIG_QCOM_GSBI)    +=    qcom_gsbi.o
>>>>   obj-$(CONFIG_QCOM_MDT_LOADER)    += mdt_loader.o
>>>>   obj-$(CONFIG_QCOM_OCMEM)    += ocmem.o
>>>> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
>>>> new file mode 100644
>>>> index 0000000..efad225
>>>> --- /dev/null
>>>> +++ b/drivers/soc/qcom/dcc.c
> 
> . . .
> 
>>> Then you use DCC_ADDR_RANGE_MASK to truncate an address
>>> provided down to a multiple of 16 bytes.  Why is that?
>>> Is there a hardware limitation that makes 16 byte alignment
>>> necessary?  (A little more below, where they're used.)
>>
>> Yes,this is necessary as per dcc_sram hardware configuraton.
> 
> OK.  I assumed that, but it's worth mentioning that
> somewhere (perhaps you already did, and I just missed it).

Ack

> 
> . . .
> 
>>> I have some questions about the way memory regions
>>> are defined here.
>>>
>>> - You round down the address using DCC_ADDR_RANGE_MASK.
>>>    Is that because the address has an alignment requirement?
>>> - DCC_ADDR_RANGE_MASK is 0xfffffff0, meaning it's 16-byte
>>>    aligned.  Is that the required alignment?  (It is more
>>>    strict than the 32-bit word size.)
>>> - Is there any requirement on the size (in bytes)?  I.e.,
>>>    does it need to be 16-byte aligned?  (You multiply the
>>>    count by 4, which I presume is sizeof(u32), the word size.)
>>> - If the base address is affected by rounding down like
>>>    this, you aren't updating the length, which it seems
>>>    could omit a word at the end of the desired range.
>>> - You are checking to be sure the word count doesn't exceed
>>>    the RAM size.  But you're using DCC_ADDR_OFF_RANGE=8,
>>>    even though you said that a "word" is 32 bits.
>>
>> The check for the DCC_ADDR_OFF_RANGE=8 is to give an arbitrary
>> restriction in word length for the dcc configuration but ideally it
>> should be 4 as dcc sram word length is 4, will be changing this 
>> accordingly.
> 
> I think that will be clearer.  Using the word length avoids
> any need to explain why 8 was being used.

Ack

> 
>> Also the base address alignment requirement is consistent as per the
>> DCC hardware specification. The address range has to be 16 byte
>> aligned.
> 
> So you're saying the size in bytes also has this requirement?
> If so, then it's good you'll enforce it.

Ack

> 
>>>
>>>> +    if (!len || len > drvdata->ram_size / DCC_ADDR_OFF_RANGE) {
>>>> +        dev_err(drvdata->dev, "DCC: Invalid length\n");
>>>> +        ret = -EINVAL;
>>>> +        goto out_unlock;
>>>> +    }
>>>> +
>>>> +    base = addr & DCC_ADDR_RANGE_MASK;
>>> Maybe:
>>>      base = round_down(addr, DCC_WORD_SIZE);
>>>
>>> Then you don't even need DCC_ADDR_RANGE_MASK.
>>>
>>> And then:
>>>      len += base - addr;
>>> And if necessary:
>>>      len = round_up(addr, DCC_WORD_SIZE);
>>> And finally:
>>>      if (len > drvdata->ram_size / DCC_WORD_SIZE)
>>>          return -EINVAL;
>>
>> Ack
> 
> . . .
> 
>>>> +    if (ret)
>>>> +        return -EFAULT;
>>>> +    if (count > sizeof(buf) || count == 0)
>>>> +        return -EINVAL;
>>>> +
>>>> +    curr_list = dcc_filp_curr_list(filp);
>>>> +    if (curr_list < 0)
>>>> +        return curr_list;
>>>> +
>>>> +    if (buf[count - 1] == '\n')
>>>> +        buf[count - 1] = '\0';
>>>> +    else
>>>> +        return -EINVAL;
>>> Why is it important for the input buffer to end in newline?
>>
>> We are using the newline to convert the input buffer into a string
>>
>> for strsep operations.
> 
> But strsep() returns the entire string if it finds the '\0'
> before finding any of the delimiters.  So the effect should
> be the same.  It's possible I'm misunderstanding but I think
> there's no need for this check at all.

Ack

> 
>>>> +    /* EOF check */
>>>> +    if (*ppos >= drvdata->ram_size)
>>>> +        return 0;
>>>> +
>>>> +    if ((*ppos + len) > drvdata->ram_size)
>>>> +        len = (drvdata->ram_size - *ppos);
>>>> +
>>>> +    buf = kzalloc(len, GFP_KERNEL);
>>>
>>> Now that you are using memremap() rather than ioremap()
>>> for the ram_base memory, I don't think you have any need
>>> to allocate a buffer here anymore.
>>
>> Ack. As per Bjorn's comments this should be ioremaped.
> 
> OK, sorry, I didn't notice that.
> 
>> Can you please clarify whether this should be mapped to
>>
>> mem or ioremap?
> 
> The reason I suggested memremap() was that the region you
> are mapping is being treated as a block of RAM.  Bjorn
> might know something about this that I don't know...
> 
> Here's an early LWN article which (at the end) explains
> why/when one might want to use memremap().
>    https://lwn.net/Articles/653585/
> Where I have used it, I pass MEMREMAP_WC as the flag.

Thanks for sharing this. Will also wait for Bjorn's
take on this.

> 
>>>
>>>> +    if (!buf)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    memcpy(buf, drvdata->ram_base + *ppos, len);
>>>
>>> That is, you can simply copy_to_user() into the (user)
>>> data pointer, from drvdata->ram_base + *ppos.  Maybe
>>> something like:
>>>
>>>      void *src;
>>>      /* ... */
>>>
>>>      src = drvdata->ram_base + *ppos;
>>>      if (copy_to_user(data, src, len))
>>>          return -EFAULT;
>>>
>>
>> Ack
>>
>>>> +    if (copy_to_user(data, buf, len)) {
>>>> +        kfree(buf);
>>>> +        return -EFAULT;
>>>> +    }
>>>> +
>>>> +    *ppos += len;
>>>> +
>>>> +    kfree(buf);
>>>> +
>>>> +    return len;
>>>> +}
>>>> +
>>>> +static const struct file_operations dcc_sram_fops = {
>>>> +    .owner        = THIS_MODULE,
>>>> +    .read        = dcc_sram_read,
>>>> +    .llseek        = no_llseek,
>>>> +};
>>>> +
>>>> +static int dcc_sram_dev_init(struct dcc_drvdata *drvdata)
>>>> +{
>>>> +    drvdata->sram_dev.minor = MISC_DYNAMIC_MINOR;
>>>> +    drvdata->sram_dev.name = DCC_SRAM_NODE;
>>>> +    drvdata->sram_dev.fops = &dcc_sram_fops;
>>>> +
>>>> +    return misc_register(&drvdata->sram_dev);
>>>> +}
>>>> +
>>>> +static void dcc_sram_dev_exit(struct dcc_drvdata *drvdata)
>>>> +{
>>>> +    misc_deregister(&drvdata->sram_dev);
>>>> +}
>>>> +
>>>> +static int dcc_probe(struct platform_device *pdev)
>>>> +{
>>>> +    u32 val;
>>>> +    int ret = 0, i;
>>>> +    struct device *dev = &pdev->dev;
>>>> +    struct dcc_drvdata *dcc;
>>>
>>> Why do you use "dcc" here and "drvdata" elsewhere?
>>
>> This was renamed in probe as per prior review comment.
> 
> I don't know who suggested that (maybe me?), but I guess I
> prefer using the same (base) name for variables of a given
> type.  So if you call it "dcc" here, then maybe call it
> "dcc" everywhere.
> 
> I haven't looked closely at your patch just now, but it's
> possible the "struct dcc_drvdata" type could simply be
> "struct dcc".  That is, a "dcc" structure represents a
> single "dcc" instance, and you happen to store a copy of
> that "dcc" pointer as the device's drvdata.
> 
> Something for you to consider, but this isn't as important
> a suggestion as a few other comments I've made.

Ack

> 
>>>> +    struct resource *res;
>>>> +
>>>> +    dcc = devm_kzalloc(dev, sizeof(*dcc), GFP_KERNEL);
>>>> +    if (!dcc)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    dcc->dev = &pdev->dev;
>>>> +    platform_set_drvdata(pdev, dcc);
>>>> +
>>>> +    dcc->base = devm_platform_ioremap_resource(pdev, 0);
>>>> +    if (IS_ERR(dcc->base))
>>>> +        return PTR_ERR(dcc->base);
>>>> +
>>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>>> +    if (!res)
>>>> +        return -ENODEV;
>>>> +
>>>> +    dcc->ram_base = memremap(res->start, resource_size(res), 
>>>> MEMREMAP_WB);
>>>> +    if (!dcc->ram_base)
>>>> +        return -ENODEV;
> 
> . . .
> 
>>>> +    /* Either set the fixed loop offset or calculate it
>>>> +     * from ram_size. Max consecutive addresses the
>>>> +     * dcc can loop is equivalent to the ram size
>>>> +     */
>>>> +    if (val & DCC_LOOP_OFFSET_MASK)
>>>> +        dcc->loopoff = DCC_FIX_LOOP_OFFSET;
>>>> +    else
>>>> +        dcc->loopoff = get_bitmask_order((dcc->ram_size +
>>>> +                dcc->ram_offset) / 4 - 1);
>>>
>>> Here's what I said about the
  above last time:
>>>
>>>    This get_bitmask_order() call to determine the offset of a
>>>    register seems overly clever.  I think it warrants a little
>>>    explanation why it's determined by the size of SRAM.
>>>
>>> I think part of what confuses me is why you use the sum
>>> of ram_size and ram_offset.  I suppose 4 is DCC_WORD_SIZE
>>> but I just don't know.  The comment I was suggesting was
>>> something about what loopoff actually represents, and why
>>> it's calculated this way.
>>
>> As mentioned in the comment above, the loopoff stands for the max
>>
>> consecutive addresses that can be given to the loop instruction. We
>>
>> are restricting it as per the total words that can be accomodated in
>>
>> the dcc_sram.
> 
> So you're taking the ram_size + ram_offset, which is the
> the address just beyond the end of RAM.  (Right?)
> 
> Then you divide it by 4 (because 4 is the size of a "word"?).
> To the result would be the end of RAM expressed as "words".
> 
> Then you subtract 1, which means "last word within RAM".
> 
> I think there are two things I find confusing:
> - Why do you use ram_size + ram_offset?  The comment you
>    added even says "Max consecutive addresses the dcc can
>    loop is equivalent to the ram size", and that sounds
>    like the loop_offset calculation should be working
>    *only* with ram_size.
> - You call get_bitmask_order() on this value, and I just
>    don't see how that is related to a loop offset.
> 
> (Again, I'm not looking closely at the code right now, so
> maybe I'm just forgetting something about the way this memory
> is laid out.)

Yes, this is in conjunction with what is excepted for loop instructions.
We are setting the most significant bit based on the number of words 
that can be accomodated inside a dcc_sram(the last word), then using 
that to compare with the actual loop_cnt that is entered for the loop 
instructions. Will add further details to my comment for clarity.



> 
> Thanks.
> 
>                      -Alex
> 
