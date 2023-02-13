Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720D66952EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBMVTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBMVTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:19:05 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E611E5E8;
        Mon, 13 Feb 2023 13:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj1NchIZZXFfXJ1Wg4myIxqQTOYej+URG/oQUBHViN9zBG1uXIFQURj0OpQ+XgOKp7uYfkRBfD+G+fceeB/4AMzz9W2aBhsILbACz1xRqy846i1cKOjU4sSeVgNEu9oQYqFatJZ4KNq5nNEfEiTPLjGiONh9CdstOEz1OUip9kzQZCjowWlj1wepa0xJhyCQXW0C3XDpq9ci16XUGJY1diKiKCu2hS9DWIdnIkLg3C7CK2F1SEvgZ2FKXJGv6+SLcshqtcODmg/OoBEkFq/ZcWoGlkF6oGpJSa/KHFQxDnfHn+1EI72BxYpRGAenjJnSAQu9gz/+U8l/Qba7qYPMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzVqsACACceB0bfQYI6UVzACOpBFcbaX5HLQsB8vQ+w=;
 b=e8+mAupV/164P5cG8zu9Y9jiUzqXoo+iCP+CtsIo4BaqtnRRQ8Hk36T+3ZT5Ji+h1LNcjAei3Rdk8zBos0BT4AGxDMccptoJI+ON3Kr9cc1htuofY20pOGQf+YrdxeVK5uMt+zWCC36JVhAYUhvkGXleU2qZmIXhGQ9+/Sll41nxLf0BYp2QJdYDB4mq8tsvAam/nAoE+xNJdVTn/gCosyIH9og6ewBa7FHbTFFYsvAgUZAmckoAGBlUryFVahhlDYjIm8byJjY9ccfTl2lC/AL/yKWlHtdzU24khXw/YJ5sbKy2zt+IcQYHiQWwqAFL6WaVlJM98dnH/7cDJRalYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzVqsACACceB0bfQYI6UVzACOpBFcbaX5HLQsB8vQ+w=;
 b=epLxbbQBzOrPEX7tFrWNi3LQs/t8qmIw1mXRTBsiZiwT1XtKaUb0nENb/hyxT2oAqjMsLq8Q7K+edBO9o9fTZBNdi4VEs5VyMkIhguH9dnHobll7RcLWg9QApbwfcz/DVwof63+WEkdKrQoYrAO8SwG+pYjFLTTrETNu6HDYamg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xsightlabs.com;
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
 by DBAP193MB0985.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 21:18:57 +0000
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::f2b9:702:df44:c545]) by AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::f2b9:702:df44:c545%9]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 21:18:57 +0000
Message-ID: <e96474e8-6427-9a80-0e97-de97684b8e40@xsightlabs.com>
Date:   Mon, 13 Feb 2023 16:18:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC-V3 1/2] mailbox: pcc: Add processing platform notification
 for slave subspaces
To:     "lihuisong (C)" <lihuisong@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rafael.j.wysocki@intel.com,
        wanghuiqiang@huawei.com, zhangzekun11@huawei.com,
        wangxiongfeng2@huawei.com, tanxiaofei@huawei.com,
        guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221203095150.45422-1-lihuisong@huawei.com>
 <20221203095150.45422-2-lihuisong@huawei.com>
 <20230206153940.gcddy3b3znk72yqd@bogus>
 <926bf147-5e93-0104-1bf4-171efcd15c5c@huawei.com>
Content-Language: en-US
From:   Robbie King <robbiek@xsightlabs.com>
In-Reply-To: <926bf147-5e93-0104-1bf4-171efcd15c5c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::23) To AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:446::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2335:EE_|DBAP193MB0985:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ca16f8-0572-4744-7514-08db0e07eabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PirV+qkup92woMmPcL/O5pi945Esu2gSypiij0Qj9pp0FcfmwIYpR6pSYILnHm0HG2o5214fcqCo1Jdlnuf7tcGWGAlp2VD6YIBEJ+7ipGA4jHhK2WqKYMnT3rIQs00YX+v/nr3dw3rTIyPULMY1UWC1sDmvksdsTMGUro5DEpZwLvrc6GsAxBrq+3mlbgpFjKSN9Xs2HnQAdjDB9kUdgixdf/zzjyWFNcQIMY6BOBQAw0xvQEouVTPl5dYJFYfkchGRW9ko+VmuGNM2qzn/39rU+NIEuX8xwBK50MJmsXt3JNY6Iv/Hmllg63LWez4yPe4RFUuq3wzZx2O2QuCdj4Oer35vs/WjihV7WL3lCA9xp7EDNu+jiViZ9a3GbdRkmgq8WDrCPqzGikjGTUpHpVwxp3o7p/HDhNlrDlBbCr5kyHwpYTAcliDxFatoNjbKlNDRHxnRPDGt1y2AdF6fXxXb9hQbJbh/Z8lvEnHBuvkauuU5eKW02i5ug5N6UVVrM+E6C2VXPn6QpATuo/865gI9XnwUgw4yJV3qx7js4hs0CSB4VdK9Ny70BUkB9HsRygCMTtQl1hKNNfWK46Wb6jd/L79slv0d9gH1EPNKCd2irvx7woifh9sq/SX2eahenBHOgi5IAIvn2h7AqewHZkTlb0pGwmZERRglaWlHpK+2GYb3bmBYA+8aRwVkaO0D4d1a+S+ApCNJTPY3aP2Ow4uvIFgB7VvtgunTGhipwOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2335.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(39840400004)(376002)(451199018)(66946007)(4326008)(66556008)(66476007)(8936002)(31696002)(41300700001)(86362001)(316002)(110136005)(6506007)(5660300002)(7416002)(2906002)(83380400001)(15650500001)(478600001)(6486002)(31686004)(38100700002)(8676002)(53546011)(26005)(6512007)(2616005)(36756003)(186003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0c2TDc2czJqbGl4eFZJODF6WEdscjBFOTVKQlovbGVMUzJqZWVMc0J1NnR3?=
 =?utf-8?B?SWRJSFh4enV5SjJOeDg4ckVDWDBHSklhanR1cy9laVc0SVlTOSsvZFZxMDIz?=
 =?utf-8?B?Q0U1d3dnbVZNczlVWHlINlBRbUs2U1NSb0ZRWllaTktUYUROQ0NVNEwyMjZy?=
 =?utf-8?B?NDNYdFdTYyszckhRZzNaZWVlVGFvK2U2YzlPWWtjTFFpaHRhQWQvbUVjOTFG?=
 =?utf-8?B?Y1kzU1NpNDVORkZ5N214MEJuQmhKeTR4MC9SWEg3dXJYMXZNazljOEV2bDBF?=
 =?utf-8?B?ZFhpU0FCYlFLY1hodTNYOEowaDJmbUZ4Y0VVZTkvM1EyOHhzZFdOSmVsK21Q?=
 =?utf-8?B?TktxdG9vdVVzZS9wcUJrNFpaMHVFUEEwZVNDNUF2WEFnQ3V6Mmg3MEtMdUxs?=
 =?utf-8?B?Tnprb1EwaFdKemxYNXBpT0YxN0FtN2pvV1h5K0tJUnpEeHJFMjRlVy9ZR3I4?=
 =?utf-8?B?SThyUkJudjVYL2VaWUd2SndZUzRXbEJDaDhhWGR1Sk0xd08rMVpOSGNSa3hX?=
 =?utf-8?B?VVd0UzdMSGt1VUNhK1VBWDZjenpZYkhybHdUTjhEcDFVZXlMUGU0NWZnOElv?=
 =?utf-8?B?MDdMSTFDbWU3SFEvbjhia005c1lScjVIbjllU3N6WWpxTDNsRDZxNWVzV2xv?=
 =?utf-8?B?d0dwK1ZkWllXaE1jbUJ0MFd6K1hXVGVwZ3ZrSk1wRmNxbVQ0SWRwS20xRWky?=
 =?utf-8?B?RnZITUFqK0J1QXplVllQc0pUVmp6S3JxZldhaTNPdnRDMVM0OExvNyt0bWdy?=
 =?utf-8?B?MlczTmpyZDMvQ1ZVRGE4L0lRY2VialEvVHJyTXMxMDlBR3M5WUdnVGZQNTdv?=
 =?utf-8?B?WEpaWHV5TzYyYWhERlBEeUIrUzNhVmdrUEtRZDJ4bG9IN3lWYmRjdVhYbjVR?=
 =?utf-8?B?aWFyOGdJVnVSQ0t6VklrWFhMOUYvNlhSMGdmaXFVb2FTR1B1enc0MThqVitJ?=
 =?utf-8?B?SzExSm5JYlBvSmtwU2U4U1F1WVVYajYwVnMxaG40aGIvRDV1WHhLTi90b2l4?=
 =?utf-8?B?c3d4WFFQc3JVTG1qUkp5WXNUT0w1azdaVTFCOEU2RmI3Ny9jaERNaHRMZnp1?=
 =?utf-8?B?Z1c1K1FtTTNOcTJiL0JEOWhYVWNHN2FRUHptNHpOVHYwODY3S3Q1a0dzZ3Iz?=
 =?utf-8?B?NkN5em43QVB2R2tjK084Q2c3bk96Mkk0aTVpN1V6UzNVOTF4eVlQR1FSR2FP?=
 =?utf-8?B?MWM4bTNNb2Z3eGJoT09zY0JZTG0reGxpTlppYzRJeXB1Y1EveUZJSE1vRks3?=
 =?utf-8?B?MDVpS3BaWXNvbEdseWVjQlhNN05DNVNvazRCejhyZVA5dlNMMTZhRzh2L1dF?=
 =?utf-8?B?NEllRWFNV096Q2RHT1ExMWVablNBd0tkd0dYVlp5U3oreFAxVkVzTU9FOFBy?=
 =?utf-8?B?Z1J2NFRlK3dFclIrMXlWVjdtNTc2QlV3NjJQNTR3YWhNS2ZxT3dGMUVRNlpu?=
 =?utf-8?B?NTBPT1d3T0JNL1lScGo0Z2hkeXI0bW1QR0FHOEFrK1pVY2s5aVNXK0NDYnNj?=
 =?utf-8?B?UXgvMDZLbEkyOHpjM1lHR1FFTkY2L1pEZFVqTmpHcE1uN08zMFY4ZWlGdUUw?=
 =?utf-8?B?d011V3VWZjNXMDVqOTNBaDhWMFY4VVd3N1hydmFsSHgyUStSMWdGYjRBUXJh?=
 =?utf-8?B?RjRRclVRbE8yTEcrTGk0TFQ5R2VtMS9ycExmdm5NTVdPdTViQkUwV1l4Z1hD?=
 =?utf-8?B?TFRCNmN2UVczUEw1V1V1SThRRU5DRnR1S01hTHU2RGxNRFREUjhmMjZWUCtB?=
 =?utf-8?B?Ly9FQjl2SlNYQkJLYVVVaEtYUU5VSUlTYkljbU51Skd0eGVydDF6dEo0QUNB?=
 =?utf-8?B?cC91VWw0MjQ4WjFOZ2l5SllkRXVQUFZJQ2xVa1VuTGcyNXhwanQyWS9GUkF1?=
 =?utf-8?B?NDl4bjgyVlMyWWtwVGhyQ1k3cFladDN2bFV0SW12RDZPaDBLNnlKa2prOCtP?=
 =?utf-8?B?YjJiY2RoYzFKdlZ3WWx0TDFWNlkwZEhYd3NFRmJSSk1FaUZPTE4zMFFxa08z?=
 =?utf-8?B?RmFKWWNHZm9DTm5TS2xIQy9OZnZVaXVma3dkSXBUamM4TDJTWFJOWVNBZXht?=
 =?utf-8?B?eWFzSTFWMjduc2l4VmhlditaVlJ2VjhDUjlQNkpFWjQyV29wVzQwZ3F5RXMx?=
 =?utf-8?B?TW1RbXVjaDNqdWpseTJiR3NGNTFvczBMWXVINFBSZktCY013OXowSTlkTExK?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ca16f8-0572-4744-7514-08db0e07eabb
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:18:57.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YroSRRYaer+Ou9hQDjCxGA6iW3/blEASygg6n/dKPpq+/8OIsliwQzoBmFLr4GmffVrYpnhOY6sET1zJP6cPDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB0985
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/2023 9:27 PM, lihuisong (C) wrote:
> 
> 在 2023/2/6 23:39, Sudeep Holla 写道:
>> Hi Huisong,
>>
>> Apologies for such a long delay.
>>
>> Also I would like to hear from Robbie King who I know is playing around
>> with this these days 😄. At minimum if this logic works for him as well.
> 
> @Robbie King,
> Do you use this patchset to test your requirements?
> Any other problems? Can you tell us your result?
> 

Sorry for the delay.  I have verified the two patches continue to pass the
limited stress testing I have done with earlier change sets.

>>
>> On Sat, Dec 03, 2022 at 05:51:49PM +0800, Huisong Li wrote:
>>> Currently, PCC driver doesn't support the processing of platform
>>> notification for slave PCC subspaces because of the incomplete
>>> communication flow.
>>>
>>> According to ACPI specification, if platform sends a notification
>>> to OSPM, it must clear the command complete bit and trigger platform
>>> interrupt. OSPM needs to check whether the command complete bit is
>>> cleared, clear platform interrupt, process command, and then set the
>>> command complete and ring doorbell to Platform. But the current judgment
>>> on the command complete is not applicable to type4 in pcc_mbox_irq().
>>>
>>> This patch introduces a communication flow direction field to detect
>>> whether the interrupt belongs to the master or slave subspace channel.
>>> And PCC driver needs to add the phase of setting the command complete
>>> and ring doorbell in pcc_mbox_irq() to complete type4 communication
>>> flow after processing command from Platform.
>>>
>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>> ---
>>>   drivers/mailbox/pcc.c | 77 +++++++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 71 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>> index 105d46c9801b..ad6d0b7d50fc 100644
>>> --- a/drivers/mailbox/pcc.c
>>> +++ b/drivers/mailbox/pcc.c
>>> @@ -80,6 +80,13 @@ struct pcc_chan_reg {
>>>       u64 status_mask;
>>>   };
>>>   +enum pcc_chan_comm_flow_dir_type {
>>> +    PCC_ONLY_OSPM_TO_PLATFORM,
>>> +    PCC_ONLY_PLATFORM_TO_OSPM,
>>> +    PCC_BIDIRECTIONAL,
>>> +    PCC_DIR_UNKNOWN,
>>> +};
>>> +
>>>   /**
>>>    * struct pcc_chan_info - PCC channel specific information
>>>    *
>>> @@ -91,6 +98,7 @@ struct pcc_chan_reg {
>>>    * @cmd_update: PCC register bundle for the command complete update register
>>>    * @error: PCC register bundle for the error status register
>>>    * @plat_irq: platform interrupt
>>> + * @comm_flow_dir: direction of communication flow supported by the channel
>>>    */
>>>   struct pcc_chan_info {
>>>       struct pcc_mbox_chan chan;
>>> @@ -100,12 +108,15 @@ struct pcc_chan_info {
>>>       struct pcc_chan_reg cmd_update;
>>>       struct pcc_chan_reg error;
>>>       int plat_irq;
>>> +    u8 comm_flow_dir;
>> I would rather just save the 'type' as read from the PCCT. We don't know
>> what future types might be and just identifying them by the direction of
>> flow of the data, it restricts the usage of this.
> Ack.
>>
>>>   };
>>>     #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>>>   static struct pcc_chan_info *chan_info;
>>>   static int pcc_chan_count;
>>>   +static int pcc_send_data(struct mbox_chan *chan, void *data);
>>> +
>>>   /*
>>>    * PCC can be used with perf critical drivers such as CPPC
>>>    * So it makes sense to locally cache the virtual address and
>>> @@ -221,6 +232,43 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>>>       return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>>>   }
>>>   +static bool pcc_chan_need_rsp_irq(struct pcc_chan_info *pchan,
>>> +                  u64 cmd_complete_reg_val)
>> Probably rename this as pcc_chan_command_complete or something similar.
> Ack
>>
>>> +{
>>> +    bool need_rsp;
>>> +
>>> +    if (!pchan->cmd_complete.gas)
>>> +        return true;
>>> +
>>> +    cmd_complete_reg_val &= pchan->cmd_complete.status_mask;
>>> +
>>> +    switch (pchan->comm_flow_dir) {
>> Use the channel type instead here.
> Ack
