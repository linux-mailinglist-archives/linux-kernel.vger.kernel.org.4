Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6763B6B8BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCNH1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNH1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:27:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2931A474F0;
        Tue, 14 Mar 2023 00:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqF0lnb/J82IpN0AA9R27sIzwfVJ7+IGHcAuK2UzT7IVHYVge1RzJtnbXb5FEEMmibB1dCE4DAzBp5Feu0tUUhNdH1l/bSZZZ1Wh1Zn6MWgjgtHjnKlEy4x6z6lsojoDjHuhCtpfw+GDMnAJE+/yzcVBtanVq7lZarzgixLpBaRnpWy+qu4xNnwsWl9QHcK7o0ttPv4kolz/v2y+4TjJKtLMDhyTz0UcghoU7wYpoM+T5MJgjOgK8S3MjpBhpqhqT+1gwcVqEzQ0MbL06ramFxepkhyjXyA446B+PamAqm7qk9qgJC4S2Sa3oniExKo6DHM9dFh9F6KyoeGt3VKPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fApdlMqU9I5ELFHMYBG3OKRnUNh8GdL5CljfvES98g=;
 b=oQZuBQN1FzXei/VyTvzDQtDC3dxR98BZE98p3YlFxQ01bhw47Y09k9AcW+dMh6it6F0TPLJduS3PkLmWTNBBWfgehXnan26L9Ss3ML3A9WHuzRUbb5NIjvBPlHryAyh6qf+v87/rAOQKTDcaD+IV27Pl/cZ/LDWBcOM+jReivYvo+wCePlnzGIrlR/NZjz01ZdKKL8y4FQJ4TKb+szm3IbD6gAiJJiPUjea8s7hvoM3ly2nOUtGdRWlxPLHUVYeyLFgK8uapJ+VF9m16ouMt0916fZOTnauHTUUf62RjMrEZcBp1wnIzGfj/dTIPgEGP8V1ik/zqirfiHv1bntzumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fApdlMqU9I5ELFHMYBG3OKRnUNh8GdL5CljfvES98g=;
 b=2dSwl4fTVtfHDAqtIEJBSfY9vgoLHYcK1bVkUqR9Oj4MFxhzjU+khBeu7xZmoY9Q1a09x2AEqe3OJkZKVJtacTxUqZv9Bg7mDwNN6ATFezYnIOGz0sRgrRItHkXxt4oxuwKQSc6d/zc1vk70+Cp2dcdARB4XK67t0OvY5BHQnUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 07:27:04 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:27:04 +0000
Message-ID: <bd1fbca3-cb57-eab8-9c0d-372c4db516c7@amd.com>
Date:   Tue, 14 Mar 2023 08:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/5] mailbox: zynqmp: fix counts of child nodes
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, jaswinder.singh@linaro.org,
        ben.levinsky@amd.com, shubhrajyoti.datta@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230311012407.1292118-1-tanmay.shah@amd.com>
 <20230311012407.1292118-2-tanmay.shah@amd.com>
 <20230313193844.GA2071975@p14s>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230313193844.GA2071975@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0108.eurprd09.prod.outlook.com
 (2603:10a6:803:78::31) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c5cc84-8125-4629-8426-08db245d826f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrU61+jQFEAc7iEPxQE5A7R1KDkP2RKTZsoa1CKk922CH0F35vBAuMyF1HFJ6qmLqezVXmQpFJSuwNOt4dO2QEU5WU/DtYWUwD1plUWqt6Iq0Iw+2fCP9LZCQoaYv/IlVELF+CK4+ntU7+p9Ie7uh7TCltyWy22Sia6ZsquKhDm/wPGoeegdNKNkDbVrr/2HixzoNOT2LTBn7/nlP5qBJFkwjD/A9nXC3B9qylm2JDA91wMmOpYieq1mp4yfqwM+n4nOdVgt4trU2jv/IcouFld5MBjHUWYnsQdq4RI/xQxB/nzm5UZSBsMCmVHOcYi7MsJHRbfPmm3mOrB2L8UlR7At4t8C8eJWHGbjsGd6R7aZojOr3DvfZA0wue24M6Zab2VoCOE8Xpf1JV1Hv+qVzo0mTkbXXXnAemMlJzYCBvwA3wwVb6gnac6AkgY3CnCBhjB0d/+oCA3DG1DK1A9GdcPfOIzi75i6FqacweKj/1WJ73g3leI0Fi+fKTYzNu2PiE35jlJMOAGFZGy6MPS/Katr7Tmj9o5uNKoDbDWgsoXY09Nu20e5vHEXah0emmPrYmO3FJ9VrY6Ihe4A5M+i7qV1yP7q6BtOWgYlBArpE5F7rCozpjrvvwHbHouCQ/NY8pc89mnpXi13GEbYw1sitNjVClcvYbdCBd1kq2TUVSpD/e5PJhTDnpMp71X83VaMH+TpBNYPnY5V0Arv6O0Mz/IIQ9apFR7m3DB4pTw9oE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199018)(6666004)(83380400001)(66556008)(38100700002)(316002)(36756003)(44832011)(110136005)(478600001)(6636002)(8936002)(6506007)(186003)(31696002)(4326008)(26005)(6512007)(5660300002)(53546011)(66946007)(66476007)(86362001)(2616005)(8676002)(41300700001)(31686004)(2906002)(15650500001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnFGUUJWbG9mZHArVm1ac1hqNHJpaUZ2T2dBVzlBOUxsYjVhT3J2SElLaHRp?=
 =?utf-8?B?Ykl5OXZJZXRkNENGaHRPcy8yUGF0TDRLNUlyUXN1TmNWVSsva3d5ZXNESEZp?=
 =?utf-8?B?bFpENjlraUxYcmgvd1VRQ0pOcnRvbEZ6S2pVeVBoT2V3bjhHYzVGeDBuT0pt?=
 =?utf-8?B?cS9KZXMrZXd1S3JsSmk4cHFjZkgvSXJrYTZKNzNVakFqQ0VtV0YwV1Y4eW80?=
 =?utf-8?B?bjhTT1N0K01ZOGlPK2srNGdiclZubWUyRXNoT1BBK2s1Y09ReHhyZEpLTDFO?=
 =?utf-8?B?L2h1elR3cUUrbk0zdk1yaHV6OVZCb1liQS9ONm5ON3NLbnJjWW04T05KNGly?=
 =?utf-8?B?dGxCNDA5dEN6VlNEZkd4cWYzZGU1cWhNeVdrVktRZis0OWpGRmRWNTRXUUhw?=
 =?utf-8?B?Ym9ERXRIK3gyT3hsdzFTbkZrcndONVZCVTFRcTNsN2M4bThLaUxaZmcwNU8v?=
 =?utf-8?B?S2ZQR0lvR1Z0b3gzcm9vVFhiMU5IL25sZHVkK1pRS0s0VGp6QVlBSmFmeTJC?=
 =?utf-8?B?WDRNb0ZnbFpGSUU3OXRXK1hyNGZFc2FnazZMSFpQNHM1QkxJMjRCSzA3NUQy?=
 =?utf-8?B?V0hyTVpsNlNPRTlzMUNsTUl5ZjR4UVhwSnFFN0pla3Vab2lRbklEdEJ5dk1X?=
 =?utf-8?B?N0s0UXhpaUhLVnVoeGpDMjBWaTFrYXdQdjIxTUFKVGhPaGw2alhPckFOb3V4?=
 =?utf-8?B?SFFyMlFnaXZQMlg3eCs3ZnFDWWZLYmxNcUFqU0NSQUpMN2ttU3ZqRkltZjNF?=
 =?utf-8?B?bVR3M1hVNE5ZZFp0NW1PWlMzU1VGZTdwU29KZlRBcGJ5SE1SS2x2MlkxOEh1?=
 =?utf-8?B?R3BYNkd0UXEwbEpYcXVQYUs3eVpvWExHbXY1ZWFaNGVLV2h1SUhQdk1hWjBJ?=
 =?utf-8?B?dno3dE1IUUxkRzVOcFYvUnVtV0lJeW1jcTJaUkRaZ3prUHgzTzBPdGkxQzRk?=
 =?utf-8?B?eUE5VEV3MWxDSXZYUVFVaWpsVWo4UURZN3NhWDBnZzdDZmZxSDlMOXJYNVdI?=
 =?utf-8?B?VU9XcCtycnRTalQzRWhRMHdLKzQ0TmlLd1JZc2x2ZitoYUU4eTd0WWJpZnpZ?=
 =?utf-8?B?OEFZa3hQNk1DVXpwSHhlN2VlTU1IZWtzVUdFdHlSNDF6UWpJYVJJNi92STdT?=
 =?utf-8?B?aVUzWndWelFKUnFsd3BGUUpPU1FNV3RUOGRYTGNvS0l0YmtuM2xuZ1dpbkpY?=
 =?utf-8?B?OWFVMXBsR2FMY1pTRDdCcXRLcGtSZTR0VzAzYmk5N3poT3RsRFlsTXlubWh4?=
 =?utf-8?B?bXRKTjllZmNXNW1mRzNjSnEyZzBmekNiakRWU2tZOVZTeC9zSnFvR3R0dHIw?=
 =?utf-8?B?alB5WWFDTEsvSktRWHVVTEFnRWZXWGJaSW10ZThnaHNONm9GT1l4S2NYYkky?=
 =?utf-8?B?QWxnYWdjV1JpdlE5VHhjUTBiZ1Ewcit4My93RytVdkcxOE1tMjRUcjJITEp3?=
 =?utf-8?B?MjY4R041bG1uQUlUdlJCamFkL3E0MjlMTDIwcUY5SEN4MkVhMVAvcGNPTXlO?=
 =?utf-8?B?YW9EVkVudk81NFBOOU1GUmpDeTRuT3I5QmFERHZxMlZQa0FwUkQ0eGZmZStO?=
 =?utf-8?B?L1VtUVNMeSt0SWRxOERwd3pFeU81dDltNTJucHcwS3BpTWM0c3J3RS9vZy94?=
 =?utf-8?B?bU9WU2krT2lZUnZZbkNUdTJwazJiZEVmVjhTQnJ6ZU9MTWs4MDl4RU1jdnRs?=
 =?utf-8?B?MlI5dUFaaE4yT2REMUN2TktZL21HWVFYMWJTSlE3Z2JLbWxmMnowYzlKRTdV?=
 =?utf-8?B?K3lNS3JXR3JkUXpORitMVGh4MUg3YjY3TFEzTytDSVYzdm81TEY3c2VHaUZa?=
 =?utf-8?B?bW1lYmRydmlhcUZGMGdPRUdOdzVlUFFJbmJ2Y2F2dzBDTEsxaDEzdHEwM2JJ?=
 =?utf-8?B?RXEydDFDKzZLdkJiejZPbk1aWWxXbm5tNGZrSFhLZ3l0T1g5SHFDb3V0ZGMy?=
 =?utf-8?B?SnlDejRPQWdYRVdXcEFGYVVoN3N1TnBnekdOQzE5eDF1dU5hT2FFdHBDVGlp?=
 =?utf-8?B?WnVlQmd4b3g4SDROMFNyNDk0cUU5T3FZUDRuR0x2SEVad3RQWmdTMG04bDBT?=
 =?utf-8?B?RThDU2ZDRmJvRTB4N2pCbXZjbHVyemhhQUZadWJRVStpUDNteGNKSDNDQUFG?=
 =?utf-8?Q?Pc9gE3nxDYlm+tgoF3LRIhsHK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c5cc84-8125-4629-8426-08db245d826f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:27:04.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld/7hC7BSoctPgIPFTe6yxTqqX9kBcU/uMXwhV2jvSHOmCQwn2mZBZSpg57QkjwK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/23 20:38, Mathieu Poirier wrote:
> On Fri, Mar 10, 2023 at 05:24:04PM -0800, Tanmay Shah wrote:
>> If child mailbox node status is disabled it causes
>> crash in interrupt handler. Fix this by assigning
>> only available child node during driver probe.
>>
>> Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>
>> Changes in v5:
>>    - mailbox node count should not be 0 for driver to probe
>>
>>   drivers/mailbox/zynqmp-ipi-mailbox.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> index a4c8d23c76e2..ae47fbac38d2 100644
>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> @@ -634,7 +634,12 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>>   	struct zynqmp_ipi_mbox *mbox;
>>   	int num_mboxes, ret = -EINVAL;
>>   
>> -	num_mboxes = of_get_child_count(np);
>> +	num_mboxes = of_get_available_child_count(np);
>> +	if (num_mboxes == 0) {
>> +		dev_err(dev, "mailbox nodes not available\n");
>> +		return -EINVAL;
>> +	}
>> +
> 
> This patchset looks good now.  I'll queue it once I get an ack from Michal.

Patches 1,2,3 are acked by me already. 4,5 are remoteproc one which I am not 
testing.
If 4,5 are fine please queue them.

Thanks,
Michal
