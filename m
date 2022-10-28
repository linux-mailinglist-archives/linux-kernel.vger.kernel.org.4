Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C5C611575
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJ1PFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiJ1PFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:05:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554FF5DF13;
        Fri, 28 Oct 2022 08:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAGb4QcTFIC/PHeJNiecftN7Zh2sCgtCZSUIaWf3jpRXsiOfYt7i9M30z3xqx/Irbq1d1LbT1nzV27//yhBebnLSnYVum7PxIthlqGWm5yZInNJUvH7O0u2jZKfNNCFhFfsMYWquMMkK19VvugCAOEU2JrvC0+L73ik6znpYHfRBJ4E3SnpQfVb9WaFgYrQdsuEBzTpok1+hx7jQhgt5asioD1T0EaFuC4BYoIa7tUCuKol+juDuyEzb3me5tmdbQ4yD1YvNOMYQhexBAqmDiqRoStJ0hxipqJnP9J4cSnZR32sJJ25ZPSTLY/76mRwkOLwLgfpbHij6KkYbtqBt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peUgVSeIu60LE35eGnTn6KqeTYgw7Q8J8eO99QIGNVk=;
 b=muuKAULGsFnLudniZq/N7GvCUyt9iDaLeXG3pXIC9df6Rq2tNDRUUPPqkA9SuGUf9ioc5lOSuHvV1ZDLd3v/uMVmWAiYsZqNUYkFm1/NsRwKiCznynM+x2uKv8WM+MDftb9S4k5VuS6ik353FXh/Y5oE8fMcsNg0R4FZClIpFwVNMHJbbtdjmnYez9exslTLKPDc2AO6pWN8AL4ry2FjsNxk2S9GVJWA+yr0tUJQD1/0qD0deNeoAk3ZkAq7XIEcmXM6cN4vrBRDAmFzHVHbw/UCbqHxhDWhrQCvn4c+tlGZdOmr5rImDryyva1zhXS5o/kUpPNT0aIS0kAO1qtmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peUgVSeIu60LE35eGnTn6KqeTYgw7Q8J8eO99QIGNVk=;
 b=jc4Twc8Nz0ayViFSjpzXvGAYg/UyBnPuCRI/a0hZLVbR6xbD353KfHJOoYn3XOJVscVZRbfG6FbOY9Tyr5DijOcnLc3uJAZZ8T5zQVPr41+FozeCqETqw4Sz2beUVA4kLf9obnzpgX4TyzmqMx4PPRIyq+2RpF2yJK1hI5pgzMFNfDol9ub2JhMPD3LU4ffA/7Voz9QtgPkl1Z9jrCXufq7kpv8QxYZLJ3kn/S1r8RPiE+Y0yNzRGDeR401XzVlyAqTbSJ8RdIffZiI6RnVp6fCFTrlF46MwaFlzVJF0ziPgArJ4Lk18wen1H7b5L+WIrZRtcyK9FpEB4rpaLyQ76Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by VI1PR04MB7167.eurprd04.prod.outlook.com (2603:10a6:800:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 15:05:10 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::543e:4af3:415e:4848]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::543e:4af3:415e:4848%4]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 15:05:10 +0000
Message-ID: <c90423a5-b89a-6c51-20f5-4945b85349b2@suse.com>
Date:   Fri, 28 Oct 2022 08:05:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Maier <maier@linux.ibm.com>, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221028020026.2870104-1-haowenchao@huawei.com>
 <e6f03525-aad5-c20d-bd8c-a5647898bcf1@suse.com>
 <79683c37-904e-562f-fc18-98ffda777d08@huawei.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <79683c37-904e-562f-fc18-98ffda777d08@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::15) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3089:EE_|VI1PR04MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4221ce-1b56-49cc-ef12-08dab8f5cec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpSr8/CJZkT/jP6NiKgqYK504z5w8MUCq6jwPU9lYMbTMF0Tec2yFprfKSNY8U8yUSOZ4zOojNVr3Mki5jjM5SWZVZFhrwju0VcxzZLgxfiDkp/BbUfSV5qFcrjmNsnlBbZSblkUz5//8oCKz5zbAHMILf2970xGc60XJX6EezJNhvNUCceQvWPQQwjCA7oNQePWTuaWUFby+n2kyXDCWMIAajZSN8s95nGcpds1I4qenqAemH8QRuxwoDFisEyZ9zmLEMfurJuqKOnhgM4bUn80fWtQMvrXOZJgkz9TX6aJ5BjMYW5KGs5mAJCQwD3U2U34sOWIVB03cP0EYOrXTzlXhxezR7jYTKVjJzMktxQTsPCayff1gU7CM0a1DFFClmkNROdP0A5O7YFlkgkzNE7u18c/BhzVQoQfNT5UBtQxpuPnN8QrzqOtkjrx4JoDP1jP8wxE7zEwjyZd6jLoEkkaIfmPMJARoPAurG+hcva15t0/qhFVzwo3FQMHf29qy+6mBP8NEGCaaAFgmDv3Z/JkMITyNY9S9tFZ7HO6OLTjAQcuqylpCOmihXlL3IPRqDZJV/jRC9a3OWZ/hSOEPTYa8NbS0g9MFF7LYwMwaERa5fql728YTj6MO1G7J/A7EEKw3X3kyuNuk0zKFRIy/5LXFSZTeTDaHcu265aoEG2u6R1r3j6gK9SsUEXwuttGN/5HgA/K6XhmaWFE5ZooahGv0O4Zu3R0XwfhnO0sKHmYAqj4cwqNAY4h/b4+xLP9hIfywa5QlGY7EGCS4AaTcgu9DRjOwRJlBO0qknzfhR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(38100700002)(7416002)(36756003)(5660300002)(316002)(110136005)(8676002)(2906002)(2616005)(86362001)(6506007)(53546011)(6512007)(26005)(6666004)(6486002)(4326008)(478600001)(83380400001)(41300700001)(66556008)(31686004)(31696002)(66946007)(186003)(8936002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZyNzIvT0ZGaXkvcFhicnhsRS9VRjJZcGRTdHVLVEZhM0xBQmVBNnlDOHpN?=
 =?utf-8?B?a1JLTGZxNDNkMmdwY2thbUhBYWF1eXE0YU9LcGdOR0k2RnlEUE5BZXVQa1lO?=
 =?utf-8?B?WjJZSzRvcGE0SWwralp5aEcrQlBIeEkzVmNEOXd6bVF5ZTVYZkF2TDZZeWlB?=
 =?utf-8?B?Ylo4b1RIc3lKemtDRk90UlJyRDhVQ3g0cnlhcGU1UHBSSGU2YkJJQklwRENC?=
 =?utf-8?B?SkFrWUVZUlFnTk5zQjFLT3A5RE5yQXZZcGNNN0l0K0QrN1pCbkxjNEw3elBi?=
 =?utf-8?B?blF6M2lFWWJvRmhSUnhpOUhSWm1Welg0VWIxa0syTS84UEhkQkQ2UE5nVG1P?=
 =?utf-8?B?UEFmUy9pcWFsaDQ0QkFyZUF4aGdLV1dLWFBWU1d3SFdXRW5lWHA5Vk1pdDNV?=
 =?utf-8?B?Ujd4K0YzZlhUWEhHMG9NN3pXNWl4VFhmZ2RFbGx6MEZBUTVGM0lOSUZJZlpj?=
 =?utf-8?B?Umo4aXlBTVpycWdNVnR3TmlEazhEcUpOcG1OL0J2c2hROGo1OHIyTEJOVTAz?=
 =?utf-8?B?Y3JCanErNE5DY2NGYUYrcllkalozWWNIZzFlbldlOERrVlNURVVlb2dGZmQ4?=
 =?utf-8?B?bFIzcTI5SzZwSi9VcWtlTEdWN1lHYXFaRzFIYjZidW5rQXJ5NjhVMWIrNGZj?=
 =?utf-8?B?MVg4UTIzU2ltdlZuUjdnbTgwVUlrSEVNdnNGRW1kZUF5bExYb010ckpVNy9L?=
 =?utf-8?B?c1UwNFlVMVFxRGVXcjByd3c2L3NmUHlvTFNlcmJRRnNCVjR5R21IaXpONXZW?=
 =?utf-8?B?WXZnK1g3VjVkbC8wVnJEODNaRngzVUJmRVlsa2cwZSthTGljeGJIWjlFbE1H?=
 =?utf-8?B?Z3ltQzhFd3dTTHhBQldxc0NYazQvU29VTkI4bFlIQzVyTUNiaVhMUWttZnlo?=
 =?utf-8?B?Y2NnWjRITVUwdFJLNUUrOWtMRExDR0lMcjBrUVJpSXhVT0N4U2p5VmlGS3BC?=
 =?utf-8?B?NFl0OVJUaE13WEN6ZFM2RVUrT3BtZThtbkdROWxidlpQeTlwN3daWkFYczN6?=
 =?utf-8?B?c1NOQVhKcWUwc1MxWGhQWDNTdFIzM25nYUxHKyt4SDg3MndmTTRwSk1HQVhi?=
 =?utf-8?B?bmRvMFU1ZmpYSDFIWGZjMVFnWjQrN3NFVlFDMEo2ZkJTRDZhV1NFM0V0ZUM5?=
 =?utf-8?B?QVpxU3JtNmZxY05qZlhhQlBRWW9seGM3MExub1NQVEpHbCtMeTN1eGZ2ZUJ3?=
 =?utf-8?B?S01HT3FJQXV1RytOWVVhSTNZUnlta2Jac1RsWHlWRWN3VTk0V1NzMTlxb3BB?=
 =?utf-8?B?emZycTlsT0FuQjBjTUQ3Z3lKay9pUGpNdW9iWEVsdnkzQUx0ZEhaRE9Iekwx?=
 =?utf-8?B?Ti9lZXh6R2ZEcWs0aDVyWFNnUlREYVBxVnZtdGJCRFd3dzNqTm93bnUwWUNK?=
 =?utf-8?B?cHlnTzVBVlZ4djd1VnM3a280YzNSdm1PMEgyUmhPcTIyYnNKL2VuaVR5MWlE?=
 =?utf-8?B?RkFmTlJLaEt4ZzBQZm5jZ1piR1hxa2tGZm81Y1FKNGQ0d2ptM1BKSU5salBa?=
 =?utf-8?B?bk1IK1A1MGlJTVlUbkdTZkhLUVVuMlZjR0IrVzJ6UWQxcFlDZkg4SEptQXJY?=
 =?utf-8?B?dE1UcmtzNWdqS25UdldSNFVCZ3gzZnhVRU92SkQ3bXhqeEVVMGk4aVEzRGw2?=
 =?utf-8?B?MnRxL2RwUzkyOTVyTGNvcFhIbnRITnlCN2ppZWpjVS9GOGJNcS9JS0NjYnVJ?=
 =?utf-8?B?TTFkemJsUmZQRmlKVk01dXhqWUF1V2xFNjJLWDdJTUxEWTVNZS9PV0xBdHhs?=
 =?utf-8?B?ZE5MWisvUTR6V3JRRW42ZnZJdFVLSis5WHdzZyt3M3kxMzdtbEViRUlhU2dZ?=
 =?utf-8?B?UklmNmFaVFRZemo2dDlXMnpKcTd2N1ZkaHE1bUNmTVEyVUFpQW50RC9ONWFN?=
 =?utf-8?B?bkl1WTZ1OHJhOFU0azBlclNxSUJicFZKVndiNTRHN1grOGo4SHBMZ2U5eDNQ?=
 =?utf-8?B?akt2TGRkUTFDNjQvTkVQMzE1VWZ1djZUbThkYUdOaENRb05YNEt3bjJzaHdz?=
 =?utf-8?B?dDZKKzZmYVBWUjZOTWpkVmtGOXBsamRXeVBva1dLQ2ZnWHN3QU16MmdiTS82?=
 =?utf-8?B?YXpBT2poYzlZOEx0UE1QQkFCSnduREpIVWlRVXdFOFZ5SjNlYWd5ai9zWlo1?=
 =?utf-8?Q?X4/wMWzRcamLwIQzQLGa/AD4v?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4221ce-1b56-49cc-ef12-08dab8f5cec0
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:05:10.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8uO/XRMYpWr4jXb0qaxJQG2NCyCDng/sTJbojcyGIUvP9pYg4pD0Aw7hkGJw7BNrZ5k1pfgvcU7etr1Qosimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 02:45, Wenchao Hao wrote:
> 
> On 2022/10/28 0:18, Lee Duncan wrote:
>> On 10/27/22 19:00, Wenchao Hao wrote:
>>> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
>>> index cd3db9684e52..2e0d1cd6d4ea 100644
>>> --- a/drivers/scsi/scsi_transport_iscsi.c
>>> +++ b/drivers/scsi/scsi_transport_iscsi.c
>>> @@ -1676,6 +1676,30 @@ static const char *iscsi_session_state_name(int state)
>>>        return name;
>>>    }
>>>    +static struct {
>>> +    int value;
>>> +    char *name;
>>> +} iscsi_session_target_state_names[] = {
>>> +    { ISCSI_SESSION_TARGET_UNBOUND,        "UNBOUND" },
>>> +    { ISCSI_SESSION_TARGET_ALLOCATED,    "ALLOCATED" },
>>> +    { ISCSI_SESSION_TARGET_BOUND,        "BOUND" },
>>> +    { ISCSI_SESSION_TARGET_UNBINDING,    "UNBINDING" },
>>> +};
>>> +
>>> +static const char *iscsi_session_target_state_name(int state)
>>> +{
>>> +    int i;
>>> +    char *name = NULL;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(iscsi_session_target_state_names); i++) {
>>> +        if (iscsi_session_target_state_names[i].value == state) {
>>> +            name = iscsi_session_target_state_names[i].name;
>>> +            break;
>>> +        }
>>> +    }
>>> +    return name;
>>> +}
>>
>> It seems like it might be more efficient to use the target state as the array index, so you don't have to loop to find the name, e.g. something like:
>>
>>> static char* iscsi_session_target_state_names[] = {
>>>       .ISCSI_SESSION_TARGET_UNBOUND = "UNBOUND",
>>>       .ISCSI_SESSION_TARGET_ALLOCATED = "ALLOCATED",
>>>       .ISCSI_SESSION_TARGET_BOUND = "BOUND",
>>>       .ISCSI_SESSION_TARGET_UNBINDING = "UNBINDING",
>>> };
>>
>> I know there are only 4 states, and it's only used for sysfs, so not sure it matters much.
>>
> 
> It's a better implement, I would update it.
> 
>>> @@ -1961,6 +1987,15 @@ static void __iscsi_unbind_session(struct work_struct *work)
>>>        unsigned long flags;
>>>        unsigned int target_id;
>>>    +    spin_lock_irqsave(&session->lock, flags);
>>> +    if (session->target_state != ISCSI_SESSION_TARGET_BOUND) {
>>> +        spin_unlock_irqrestore(&session->lock, flags);
>>> +        ISCSI_DBG_TRANS_SESSION(session, "Abort unbind sesison\n");
>>
>> It'd be nice if this said more, since debugging "Abort unbind sessions" would require finding the sources. How about "Abort unbind session: not bound", for example?
>>
> 
> Of course, I would updated.
> 
>>> @@ -264,6 +271,7 @@ struct iscsi_cls_session {
>>>         */
>>>        pid_t creator;
>>>        int state;
>>> +    int target_state;            /* session target bind state */
>>>        int sid;                /* session id */
>>>        void *dd_data;                /* LLD private data */
>>>        struct device dev;    /* sysfs transport/container device */
>>
>> Thank you for sticking with this. It is very much appreciated.
> 
> I should apologize for taking this issue off for a long time because of my slow response.
> 
> What's more, should I add an acked-by or reviewed-by in my next patch?

Please add my Reviewed-by tag after you make these changes.

And no problem taking a while. I appreciate your effort!
-- 
Lee Duncan
