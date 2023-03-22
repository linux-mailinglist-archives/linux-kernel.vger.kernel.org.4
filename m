Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6786C5283
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCVRfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCVRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:35:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B431E43921;
        Wed, 22 Mar 2023 10:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmRelXte/OhLzkWwD10Ju4u7NNj0Z5Km+PG92qub/Sv10UplP0jfozkWV8fQdYx7foFyIvyiYSh42iTlXGaM/wkplBdWIesqNSedHArTirtkNmaz+pzDlX5Q7NQmLNBHKtqUbwq6ttjlOD33Xo/199yAjpUns5FSJinF+KspqsEHy8ziRZTQBEtR95IRt5CFgbi/7zq/v14S4rn3yH/dNqnNbBCLx2W0T6GqpA+VncNnGTWFmOA8Dwum45wNJGYdyEJckGrAEowQ3/KcxHnmWpc6LvOaBstOFvlzgVXqLjJ5ipgMvz6wu+xmQadrxX5x6+riN0tQvjOYVPT23Q0YXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMUvq/xx71EDDtxJkL+wdsQNJZl8vmfyJxiOsM6G+eg=;
 b=jXvXPR65PvaU0xSiL6vZ/Hooy6Fw6eXWqYa63+EVNkuCF8QG+Fq9fIgq58f9TVY3On/z0WQ3avbhCHJu5TW7m/m2cJG2JYq74E5qaz0VnYj4ViuC0alUOHyCyxL1Bd7OejiMfnbtjtMfKv58KYWBIKB1HqzNNvZgnqWZdKdphrvjoDGftgeph87up+AieOPbQntTp9qC9sVmiZCbCusY77jH3gRrebkHbeYk9+4yd6QwTh30NSras1Gz5H0i54u3+umNIbge7hFFaEdLzydA/Ejp2z2TVFg4oKCsZIhPnCs6tnKUeJbNXPch/nGoLA5s6sdwC2S675TFExlQhb+YcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMUvq/xx71EDDtxJkL+wdsQNJZl8vmfyJxiOsM6G+eg=;
 b=Y0MK+sn5bBRC2zVHZx5XZzFUNL7zD+oLnIBq+5xiMC6udGz9GmBxAieuosZmHUEX9c0p2OCdFO9mHuOTZrDGxBsgEz6+7GOL+izfTJe2R6o4bJd+/TNLWqVRV5oP775PmfYnViW4XA3OoI+Wx5jRdp5OxonaGWy3Jq/sjyxd9PI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 17:34:59 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d214:f856:e057:f856]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d214:f856:e057:f856%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 17:34:59 +0000
Message-ID: <830db03c-ec6e-b4aa-834a-e67622e5a41f@amd.com>
Date:   Wed, 22 Mar 2023 10:34:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:111.0)
 Gecko/20100101 Thunderbird/111.0
Subject: Re: [PATCH v2 2/2] remoteproc: enhance rproc_put() for clusters
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tarak Reddy <tarak.reddy@amd.com>
References: <20230322040933.924813-1-tanmay.shah@amd.com>
 <20230322040933.924813-3-tanmay.shah@amd.com> <20230322160537.GB2821487@p14s>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20230322160537.GB2821487@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::28) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 432d18c6-0370-4c77-47ff-08db2afbc28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vei9gaEEaL7RBnQA1AHkSxIz22Xg9LYmvCusnwgyLw28cjehFdPcvc2r5CSZWeYqIxqnkXqm5ttO0aMa/zTLJgfDFRlla2gDT8jU8cvPuFxgPQd4p4ORDZkgn/839ObtpeDxYd6N2WaIqwTAmc5nlpwLHodjsfMkfNeUn29Se2PA9AGPLb4JHuJL9DC8PE4XX5FN0bm8XKnZN3Dekwb7UiaOAv8KRCsnD7thTR3HRdKzd86IR41lAi2bQn7riIBGTuc6+I0pzhqGedh+fBWSHCWgvcJTu73WAJq6jmOQ5sNFHSVdqttPcHEDe3cWAcisb5RMm4ME6whPKcUlcD7dHvtcWGSnQ0XOsVXOTecSBs1MGtCHPXjPLftkCQZkCqz1nmuxD/WLh4h4+gsIRz6E/MAwSS6wT3T3YKhAK/Nm1Jv3rb+CpjjV1FoZEgcZMGDrV6vJRbZJ86t+mQFGtmA3dOJX+YlB1JcqWFEXa14Hid1F5uEOKlt0QpFygYu1L1kMnIE9sXhIRyQ7Yhal++i82jsLWzY3hH4pFgVjlVkGmSNKv0Exd3mCEaO+miKQZQatPWk7IsMHrtBfUWzHib72Au6TJmuqZy8HgDhY9WXGwM2XERU891O0unIprpC/KxVWG3tWlmnHZRqhpIWo/3TTaNeds5SHYoSpOwIcKnqySFv8BqpVYBtg1xkCY6XVK8SDOVgfIuKpritII9DN448w4qBuLLyjgkJGVloq3woYW10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(8936002)(44832011)(5660300002)(31696002)(86362001)(2906002)(38100700002)(36756003)(4326008)(478600001)(2616005)(41300700001)(6512007)(186003)(6486002)(26005)(6506007)(31686004)(53546011)(316002)(8676002)(66556008)(66476007)(66946007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skhuc1lsMGJWWWlraVhHS0hTYzlMSjZWWG4rRlpRdGhnS1cvT3Q0bjEzaWpI?=
 =?utf-8?B?ZlhFTCtlcXJxdmxDVnh0YTZGTUQwY0w3TWRhWnZ5VUdqbm9nYkV5cFg3akEy?=
 =?utf-8?B?am9yYXVhUVk3QmxhZW9naTRjbmF0ZTI1VmVCQzROell3eElEYTBqZU94VWhH?=
 =?utf-8?B?aURZT0tYcFc2N0JmZWt5dHp3b0pqdUFzSk9QSTN1Uy9SYXdTQ2VTZDhZbFdT?=
 =?utf-8?B?RWhJQjkyUHVPZzI3NzZrYS9aRjVqU1RGdXVjU2VuODhLUmgwZXA4cG1XRkxJ?=
 =?utf-8?B?eDVKampCbVZBVThtNUZrenFkcXcyMnQxcTJyZEhLckM0SVprVlZSZHVTeDE2?=
 =?utf-8?B?SnV1RG9KSVBBb2wrNFNEVyswWDRSMGZES3B3azVXb2F5REw3ampIY1k1Y25o?=
 =?utf-8?B?b3hHMkdnRHMrdzBmWUpmanFNQWQ2T0Y0cDRBWlZibnNBZldOa3dLRmFBdkEx?=
 =?utf-8?B?bGc2aTIyVEV2ekRDcjhLUTVaUC9XMGpTd3BhYmdudTRyNm5OMHR3dklDTlRq?=
 =?utf-8?B?a2tjM00rbzliRHhydGUxRklnSUdZTjFHZkJCWk9hMU5RTGF0OTlObnhGTGVV?=
 =?utf-8?B?bFhDNXlxTWhiZ2xhK05lRVE4dFkwb3JaMlNPbkZ6aW1iK2pMUHBGb0Q5UTll?=
 =?utf-8?B?LzZiSWZpSk8vR0FBL1h1MUw0ZE5lbkJjT1VodS9kOUlsMW9Qb3hUUUhleCti?=
 =?utf-8?B?KzRZSUdtaTNMZStQcStCemk3QlcwNWFRRUw0eWtqQnBkemswbHlpNW9JZzRj?=
 =?utf-8?B?WXkrUVljNHFTOTZvSG5Pam40SXhaWVhPTkREYUwxNzZtcE9ZV0hSeXBkbXZs?=
 =?utf-8?B?U0RNdWNRM21nL3hMZ2tPOFBlQmhRd1J6SWJPYXhVYzlaV0dsMmFzTmZ3NVNR?=
 =?utf-8?B?NUpvUk1nbWlkckRDSnA1VTRHb0J0d1Q2OHd4OWxVS2JiMldLL01BRHdlYUFu?=
 =?utf-8?B?UTY0YTdTZmhyWTdDT0hhNk8vWkRHaHZiaFVrVnU2NTAzZStteUl0YUtHVk16?=
 =?utf-8?B?ZjVDQ3NPM1VqSi9hekVVcHZ5QVNRZWRzUkx2VWd3QlowSnNWd0pvZVRUNWJj?=
 =?utf-8?B?Uk00RDJNUkRIR2UxaG03N3F6MU5HaXA3b3VybjhyWGtwaGNxTC9pN3FZa2xZ?=
 =?utf-8?B?UVFEOFJ5ZWJhRkovK1Y2cVMvOU53cnpjekdtNDlqL09vUXRWT0NpTnFFZURL?=
 =?utf-8?B?andKN0EyL0RIdDZKNlBVaW9lb0VHM2JTK3RSdjFlMG5LU1BOWVUxeVFHWisw?=
 =?utf-8?B?ZkE3YUZDTmg1L2RWaVdjSEpSdmNodGp6aC90bDdxcFBBdnlwZlV3dWhYK0p0?=
 =?utf-8?B?Q0wxVm5leEJtbi8vNjFBVzZrWGpBR0VhenFHUmFsbnNNYlQ0QWFUZWxQUzA1?=
 =?utf-8?B?WFQxbVlKVk1jeTh1ZmdXWnhHYWRFTjFFMzI1bEwwY21KUTBZcXR4WlUvc0Nu?=
 =?utf-8?B?empiWjhBSFNpVVdhSGxsU1NRRXA5RjlhOWFvL0RjYjYxTUt5cmtKSVBPdExL?=
 =?utf-8?B?N1FRMlUrOWo1T0g0SXRDQ3haTWdZMnJ1SU4wa25PWGtsS3lZTzVpYU1IeFRq?=
 =?utf-8?B?ckJsVWRLeHF3dUE0cUhvcWh6UXhQOVBNSGtGMlF6bGY5TDJDUzZrYXpBbVZR?=
 =?utf-8?B?cllRSGMyN0tId3BySGs1LzdzeFFFT1hKSVIvSktNNldjcHB3Nk1Sc0lsdlYw?=
 =?utf-8?B?N3ZYcktRR2x6MHpveHlqVW5YdURIQlJCL1FRNDhRK0pYaWhsNmUxamdTL2Ey?=
 =?utf-8?B?MzRCamdlUzh0WG9tclY4ei9FTERxa2hRQU5uOGU2V0Z3eDVvaGVOUGh5Uklm?=
 =?utf-8?B?a3ZCdml6QWZ1dlRIcTh1eEpZZ3RYWlJYRU93cGJMNFFBVEQxM0QxWDI3UVBL?=
 =?utf-8?B?aEo4L1gxNGlrM3ZHbXlFZGIvTkRHUGY4OUFvanV6T0ZRNkRjMVVERWVUN2pH?=
 =?utf-8?B?NE80SXE3WGM1eW5oNEZWNlBFdHBHTXVPbjVRaVBYY1FLam9UeURkcXkwbDdj?=
 =?utf-8?B?UzIyZmVjNHN0RUJ5Q1NjdjFjclZQR0JPN2pDYlhqMGR5S0NyTStUcWVMblNm?=
 =?utf-8?B?VWxzSWNkRGM4LzFKOUMwNW9ZWFlBSnowaWptNC9iSis5TGV2cC9Dc3Y4SDNZ?=
 =?utf-8?Q?cLSPv7lAmR8SNDMFQoznuO2NJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432d18c6-0370-4c77-47ff-08db2afbc28c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 17:34:59.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPWpFfHAq9Svz7pLpkc7dLLb0FriJz3svCXvIsJVgn/pxVp3BQLAe7qyKd/tXRYS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/23 9:05 AM, Mathieu Poirier wrote:
> Hi Tanmay,
>
> On Tue, Mar 21, 2023 at 09:09:36PM -0700, Tanmay Shah wrote:
>> This patch enhances rproc_put() to support remoteproc clusters
>> with multiple child nodes as in rproc_get_by_phandle().
>>
>> Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index a3e7c8798381..e7e451012615 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -2560,6 +2560,19 @@ EXPORT_SYMBOL(rproc_free);
>>   void rproc_put(struct rproc *rproc)
>>   {
>>   	module_put(rproc->dev.parent->driver->owner);
> There is something wrong here - this should have been removed.


Thanks Mathieu. Sure this needs to be fixed.

This is result of manually picking up patch from my side.

I will try to find better automated way to pick-up patches not available 
on mailing list.


>
>> +	struct platform_device *cluster_pdev;
>> +
>> +	if (rproc->dev.parent) {
> This condition is not needed, please remove.
Ack.
>
>> +		if (rproc->dev.parent->driver) {
>> +			module_put(rproc->dev.parent->driver->owner);
>> +		} else {
>> +			cluster_pdev = of_find_device_by_node(rproc->dev.parent->of_node->parent);
>> +			if (cluster_pdev) {
>> +				module_put(cluster_pdev->dev.driver->owner);
>> +				put_device(&cluster_pdev->dev);

I am not sure if cluster_pdev->dev should be dropped here.

Should we drop it in platform driver after rproc_free() ?

>> +			}
>> +		}
>> +	}
> Some in-lined documentation, the way I did in patch 1/2 would be appreciated.
> Otherwize I think the above enhancement make sense.
Ack I will document in next revision.
>
> Thanks,
> Mathieu
>
>>   	put_device(&rproc->dev);


Also, if we decide to drop cluster->dev here  then,

should we drop reference of rproc->dev before cluster->dev ?


>>   }
>>   EXPORT_SYMBOL(rproc_put);
>> -- 
>> 2.25.1
>>
