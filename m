Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15A68B5C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBFGsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFGss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:48:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8AEC178
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:48:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJmg/3znLQJ4IqgFlUeg58s6oep2elfaqR6nwJ3zmeHuc+VqzgmRZRIbCDB7K7s6q+xfH3/9kpB0B2FjT1Yv6YfoLNmbQbXVnkm6xeNvlKBR8u2ptcu1TVZwqzn6sKt0gLDJcKxzY4m55UZHRhzo0rYQO+xpnS3VXYLOKd4TZlTAsyF5uu3VhE/O5bJIgd1JrK+hCRJwa+2tIyX/L8scNpSO10afTMhBYhoDTNuPS8vsUkqqRoTMS0WrEG6vCp57T+vHbgJx6Y8W3JgJtAsgrl03Z7oKEOJOeQLOfldR2gtLEsUblnkFO/hEGtnXyd8+SBTuDvDUY/+1qEKstceCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj1mEm7gL4EcQcHt5ERqYB1dUjuvIVJzLkIOxWI18PE=;
 b=iWfRzXvTRT7lpsN04w+X/YXjaCdfkKLXLlgb4dsfdVJNny87syC1HfIsTF+zl1wOzr//7qE+BelUC5rmD/eI72Ri3rii4Npqr69fbGXUlj/d6vsB4ZOo2F5w2Pq2ZwQXfliTCP0KcdD47eVgtZyTwg2oPnQvmjVtHgvAMusaSJ1X61C9uUZ49MewEfu/0gFpSidkE6hr3DW/Ua06Q9FCH/EPVkUXKUhEn1DoN/heqwzTmeLrYPpfSQzEV7HuUDEg/RJR4EcyqyBB2Hs7ezj4GgmBxHAnpdYMNld7EAoT5W6tA7LulIrZdVZmTgBognrN5HEzG1Jl6Z11IiuKevT8dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj1mEm7gL4EcQcHt5ERqYB1dUjuvIVJzLkIOxWI18PE=;
 b=qziK36Ac0BS00PeixVgolSRuOYJkoOu2zXON9NRzxSJlS2Xhj0yEBte48eEegBjftBWaFC16bKbvvkrISANHLj03ua+vdp109i3J9K9h3kx0kHBMBoUiwAzI3OaRF7xoxVEjmjNNvwb9+EhRE4XkYj1kKrUMkt8Ppsjj13UOPKAwq50fHJxJa3EWNC638aJJ8F8aDnmdWszFXb/CgFB07mfTtwSu2Dz2BWOLiKkpj0J5SBq2/IPoJSJs5loIPAsMK/VYgvkSgr6BYq8WAeFs4LHz/Xq7p3oREimHUOe/Uz9qsFM8F+JmeJYmcG5j26GMKrVdXYjHxqtzhpx0D8x5tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 06:48:43 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 06:48:43 +0000
Message-ID: <b4fb6dbd-a0d4-5ec5-8955-99153e9fdcd3@nvidia.com>
Date:   Mon, 6 Feb 2023 08:48:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/6] vdpa: conditionally read STATUS in config space
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-3-git-send-email-si-wei.liu@oracle.com>
 <0f158916-aaab-0afd-6cd0-382f54ef26d9@nvidia.com>
 <7b3af822-0075-889c-911c-b79860fd5ce2@oracle.com>
Content-Language: en-US
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <7b3af822-0075-889c-911c-b79860fd5ce2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0167.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::10) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 0360ff01-580f-4129-92c5-08db080e3018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOyGoXpiPLWCBqZf/yb0DWxteMBpR6x0uJ1fxB1wz6DCtJ9wBSCehR+QgolXkXk+pxyE6zcgn118TucJArkec973B8V+gpYc5MKjGp3sw5vcl+nO4Ib8AT301yDY3WJCz5L8UF1qWNoGhME1XG6aFZZtSHmZ9N0XpXlBnjzHKG3s2FVFimybiZVZBN+peV9Eq/36qg3QERBgTnK20bsqAubqE7WzR6Zj0v67Qjx7e1ae6ts8rVxtgfcDp2J+N/LpIS9cUgnRq3DKlq4gN7rT5Jh/61XSTeKoqOYAGKfVL/s0l56e2acW1+5mFjsZ0DRgM6WShXE5S52wZtOvV4dJl0ctWLJESofFbtL2dKrQ5iyO9PoA1t5jqQ9ojTMbuxs8wdzUwFJxGNfGKggc9Dn29ixOaj/Oon4ajhi+SFJFUu8c33RJTz82tdP4JUdQ6yUjhP6efNKgS7qoP9v2bRfZ2kvwcgXYS2VdF9rLF2OO4WglA5g5lubyt+HFtAIlEpQPwxs5++0W34y5jWToLPsdyXGFcQjPipczQ+M8Us3FwHbdVYHf24Qud7Av5hfoWSY4ttsNoj484IR1m4qhD4i+/oIHGbqeAMppkUs4ENj/OVc6ag97unyBd4HVRUTKamS+9bmIb1163qMMjK3BXpUWpDRgTAMsjzH8yCKA7At0ngOnqMiyPJ0lsjss4rVLfoDgUYMSNXGK3x0L13wmCL9wSTD8dxlZrGiOyg1FJBQOFmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199018)(38100700002)(83380400001)(5660300002)(8676002)(66476007)(41300700001)(4326008)(66556008)(2906002)(66946007)(6666004)(6486002)(6506007)(8936002)(53546011)(2616005)(478600001)(26005)(186003)(6512007)(86362001)(31696002)(316002)(6636002)(36756003)(66899018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFpEbG9URUtOQSsxdHpwc1hKSEV2NTRHRWlQY2l4R2RYWTVKdkcxa01PWi9j?=
 =?utf-8?B?YXlJcEE0SkhGMmc4SG1JN29tT1NXZ3VhUS9tK21Wd3BNQXhjM2lYQmtVaFhV?=
 =?utf-8?B?THkrZlJqWkRlb3FYdE8vZE5JR2pCa1FWS3lsN1oxU2F3YVhUYlhvQnVSMjQr?=
 =?utf-8?B?MjNqdnptd2tpM3QweWdPOTB0L1JnY1MxdVd5bUM1WXpWb0NVUm9vQVRCMUlr?=
 =?utf-8?B?clZpKzNVc2loTERnTkM5RkhoOEhUb0JqYTBrckllNXlBMlFmRmpQd0hEYWow?=
 =?utf-8?B?QW96RER3UWpGQ0RQYk5MQ3ZFSXZwcUNld3ZHaEVML0c5NEMwS2ZzNHJzcG5r?=
 =?utf-8?B?OHBhRmxlUWw3ZXpsb0VlbThoa3dkT0pPbk1zVUJtM2RQdWc4V29MSXc3Q1R5?=
 =?utf-8?B?Tml6S21VTjRRWGo2eVkrbjd3VWdzdVEreUcrelpoZmVDbUh4NDZGamkyS21y?=
 =?utf-8?B?cjBJVEgrSGdIWnY5QitGYkEvZko5d2tFTmMvWlV5NXhTaXg0L2s5STJOaTd3?=
 =?utf-8?B?OUpTazlYcXVtbUg2aFI1L0gxUVNnc0Jna3ZNRHJYWHNQL1ZiZDQzTXlBRWQw?=
 =?utf-8?B?RHVnTHczeWkvL1ZMQUVhWVNJMlRXSkUwNDA2MnAxZndDM0dKdmJkNjhsUm9N?=
 =?utf-8?B?REZMVWd0dUNVcXJlZTRuUDNkNXNsc1Q1dTRuTmRzV29XL2lESUd4TUFIcTRB?=
 =?utf-8?B?bTNuTGZGbTExWXZnT3g0WU1Ib1JqM0F3Nmk3UXc3M1BidzJNOW9vRmJ5UUor?=
 =?utf-8?B?MnFhNmo0dWtiS3pyTExTMWZicHJQK3hPczBSNVVTMXgvUGtQTERlYy9RNXFw?=
 =?utf-8?B?dmdBclVDQUtjT1Y4bWE5cmVXM2hhTFJON1RheCt3L0hEaXZMbEdUMTI3anV0?=
 =?utf-8?B?NXZxZ05tMjd5a3N2NXdRbzMwQlJyUVJ3WlBFSGhBS1BsRkFMRkVLbTB6eDR3?=
 =?utf-8?B?VzVWdW9pR1ZDUVpoK3FwY2VnUWJpV3MzUFRHdXc4V1dma0lxek5kOVZ4aTk5?=
 =?utf-8?B?akhjbFIrMlBKemt0cmI1Q29rUTk1a3ZpSWxCSk14Ni9ZN0VHWnJmZWZXd2Mr?=
 =?utf-8?B?Y3NON1MwNkwzOEZxdk53RnV4eVkxb25DVlJ3SGZkQ0lCTkV4UkJVV1A3ZmhI?=
 =?utf-8?B?WTNvK2RMS1ZYN1NMbWxML3RuaVdodEQ0VjNwcS9YSWJYYm5Nai96RFBTN0tF?=
 =?utf-8?B?RzFwc1V0SWNvS21xaXFzNnR1bVJ3UHhJSC8wY3hhYjZlalcwdnRucXRXUnhM?=
 =?utf-8?B?S1p4eDdZbDQ5anFRejZLUnB0bkFaZVhWalAzZVVlMGM4dThvbXdJTTNoREYr?=
 =?utf-8?B?Y1VleFpQblJpc09Cc3hNUUtGUjVSVjY0T1hSLzNOUm9LUFNVdmxlZk1VL2dv?=
 =?utf-8?B?VHpXTkg2OXdnNTN1Q2FKTjBIbFh2LzZuYlFjVjdRTnNOdWFUaTVpeGtvcGZV?=
 =?utf-8?B?bXhoUzZzLzExaU1INkcvUmpML1NCWHM0bGdRYWNtZnJ6VGdHanV5cVErN0o0?=
 =?utf-8?B?UU9HN0FHTUVsL2lNaE1aOXlaMlhCSElva1M4T3JzWmJRKzZvNWJ0a04zbzdz?=
 =?utf-8?B?TWVSTFRBNHdZSWI5VHFhNHpOSVJ4RTJ3dzh1czRJRFhDdytlaGpnWjdrbHZU?=
 =?utf-8?B?V2NHdFg5Ly8vMXpXbVBWdDMzWS9Gc2xzY1cxamR4Y0xxUnErazVHTjIxdVBn?=
 =?utf-8?B?Z2hPU25DSHhqM1F0MEsxTSt2TFFBT09CUDJKY2xhQ3hBejIvMTBCZkw4Skc3?=
 =?utf-8?B?eURJUER2RmR4bFcvam5PVW1LQTJENDJBWDVJRVJBbmdiU2VsQ3lCblg2SW5j?=
 =?utf-8?B?MXlVQXlGbVRjZk93aWZ6MmtRbkc3MEs4NWtYallqTW4wVENlekxCMnZQbWZP?=
 =?utf-8?B?QmUwMk5nVDZLNzd5d2NTVm53OXQyYW9pOXQzNUZWZHlSSkZSK3gvcUV1cysx?=
 =?utf-8?B?ZTV3SldBQjNFb2pjNndKUGdub1I1Q0dlb094dk83bnJmSkNmMmdjM2lMQXBC?=
 =?utf-8?B?aXRsWUlpWTRVUlRzcmR5OEJNT0k2NW1scStDK3pxUEJQOVZ6eTQwelBTUjRI?=
 =?utf-8?B?aHlEL3RzeHJ0K2c2S0NaZkxocWpIYW4vVEpZZGRqWEhOdEVWWTFyL2N5SFMz?=
 =?utf-8?Q?jcOUZ0DZw6uJKlrF8AAQn5Bta?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0360ff01-580f-4129-92c5-08db080e3018
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 06:48:43.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0xnbUvGzhCYFwajngsuLTdW0Txv9gMS+SyQhn9x8BHf55+unVXkSoNiryCmChnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/02/2023 6:53, Si-Wei Liu wrote:
>
>
> On 2/5/2023 12:26 AM, Eli Cohen wrote:
>>
>> On 03/02/2023 7:01, Si-Wei Liu wrote:
>>> The spec says:
>>>      status only exists if VIRTIO_NET_F_STATUS is set
>>>
>>> Similar to MAC and MTU, vdpa_dev_net_config_fill() should read
>>> STATUS conditionally depending on the feature bits.
>>>
>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> ---
>>>   drivers/vdpa/vdpa.c | 20 +++++++++++++++-----
>>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 3a82ca78..21c8aa3 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -843,18 +843,25 @@ static int vdpa_dev_net_mac_config_fill(struct 
>>> sk_buff *msg, u64 features,
>>>               sizeof(config->mac), config->mac);
>>>   }
>>>   +static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, 
>>> u64 features,
>>> +                       const struct virtio_net_config *config)
>>> +{
>>> +    u16 val_u16;
>>> +
>>> +    if ((features & BIT_ULL(VIRTIO_NET_F_STATUS)) == 0)
>>> +        return 0;
>> Instead of returning 0 here, it would be better to explicitly put 0 
>> in the message field for
>>
>> VDPA_ATTR_DEV_NET_STATUS
> In light of commit 41a2ad927aa2 ("vDPA: conditionally read MTU and MAC 
> in dev cfg space"), the userspace must now show the config space field 
> presented by the device *as-is*. If the feature bit is not offered by 
> device, the relevant field will not be displayed in 'vdpa dev config' 
> output. For instance, MAC address won't be shown if the MAC feature is 
> not supported/offered by the device (note this has nothing to do with 
> negotiated features), even though the vdpa parent may have a non-zero 
> MAC address of its own. I think STATUS should not be different from 
> MAC and MTU here.

OK, I see your point.

Reviewed-by: Eli Cohen <elic@nvidia.com>

>
> Regards,
> -Siwei
>
>>
>>> +
>>> +    val_u16 = __virtio16_to_cpu(true, config->status);
>>> +    return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>>> +}
>>> +
>>>   static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, 
>>> struct sk_buff *msg)
>>>   {
>>>       struct virtio_net_config config = {};
>>>       u64 features_device;
>>> -    u16 val_u16;
>>>         vdev->config->get_config(vdev, 0, &config, sizeof(config));
>>>   -    val_u16 = __virtio16_to_cpu(true, config.status);
>>> -    if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
>>> -        return -EMSGSIZE;
>>> -
>>>       features_device = vdev->config->get_device_features(vdev);
>>>         if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, 
>>> features_device,
>>> @@ -867,6 +874,9 @@ static int vdpa_dev_net_config_fill(struct 
>>> vdpa_device *vdev, struct sk_buff *ms
>>>       if (vdpa_dev_net_mac_config_fill(msg, features_device, &config))
>>>           return -EMSGSIZE;
>>>   +    if (vdpa_dev_net_status_config_fill(msg, features_device, 
>>> &config))
>>> +        return -EMSGSIZE;
>>> +
>>>       return vdpa_dev_net_mq_config_fill(msg, features_device, 
>>> &config);
>>>   }
>
