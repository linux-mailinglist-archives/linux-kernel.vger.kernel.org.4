Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776CE6B2EBD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCIUak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCIUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:30:30 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB99FEF3A;
        Thu,  9 Mar 2023 12:30:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg6+LOm4Pa1UN56q+0kPQ8Plz2Kk3LU3qyxbkmi3Lp+xyuABz++e4fzs71cl3ez/7QiNcJ3ZjPh+FbHdT1QSUdiUriBPJFWdBWku+Wj+cUGvC3rNYGzGIM/HizounP7u4Xy8G0Vrs41pPKvjdO0oHGOtwxHwycHT21vBpKBF+yqpjdD0j7ouwitKSAfqwPa5myWxYYWPb3091UTTIps8/WtAgxcZPVW3QvogB5KBbiwMd1NJw71zOuADFKjOawLPs8QVdJBNNO/DlL3XKMKgTkf8H9Mc0aN3B5ynzsKYu48XQvYm7TY8H2EpfCo3RjMUg8mNHpOFsFYDmQyKM74hFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qguKR1ZEBqR4dq5g8+1iFvyLbceFb+ivX0AZXGZQ0+U=;
 b=hzPCTEHSaBu0KieafkEa4gvnpO0MRmjUYl/MHdZEsJpRsDl32CisHSCChm92tmO1z3JmS6uG25QkXIZ/QfBEnNifSUryugqFtx3KHa19KmwIHhibjnHGoDMnkcoIIbWdskZ23R/XflIFqnfBg3p/LB6esBmZtGQiOuF7ZwFAIt4SPMC6BtVASzAhPIZEt/9SE5Az7ScwbOvlsz8EN2Pue03mX8111ywruNb2rGw5HWE4pJd5GLoBSB32mp565xyD4Phj/cj0bamiPWfJlHoNfinO/rA2j7H16cCp+KKI3lzdPQeGQe+W2Fx/jodsBbC+V9YJMovtrv27noj30f23mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qguKR1ZEBqR4dq5g8+1iFvyLbceFb+ivX0AZXGZQ0+U=;
 b=svrjeQRULPGCq0J/VM0CoMsDwtbYgOoCxRRQo5aMAu4vXLwixeTTsIpTHLoWbzf1dvUDvCRP1nTg9xOp+3dE/pY0mso8/Q5AWnSr25Ng4a1cxsAUbSHlSlDY/EFX2T2DKTjt0rJgcv0pdtbZ/r0C2sBLNGQ6dGdbvzMG1G0XR3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 20:30:18 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d214:f856:e057:f856]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d214:f856:e057:f856%2]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 20:30:18 +0000
Message-ID: <59919b84-d07a-4c62-3f34-febd85176375@amd.com>
Date:   Thu, 9 Mar 2023 12:30:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:110.0)
 Gecko/20100101 Thunderbird/110.0
Subject: Re: [PATCH v4 1/5] mailbox: zynqmp: fix counts of child nodes
To:     Michal Simek <michal.simek@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, jaswinder.singh@linaro.org,
        ben.levinsky@amd.com, shubhrajyoti.datta@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230228210216.447373-1-tanmay.shah@amd.com>
 <20230228210216.447373-2-tanmay.shah@amd.com>
 <d410d181-a94b-40e3-5c3c-50625fbb0196@amd.com>
Content-Language: en-US
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <d410d181-a94b-40e3-5c3c-50625fbb0196@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CO6PR12MB5444:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cd3e79-8dcf-454e-85cb-08db20dd18db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykiN4L1c2SkeHhk+LRFnsbUj658FlASAD+L3RHW7GQFCQg1P1LiWKHkoZ1Dx9xaHO+CFZj21hVFqZ5ccqeeDRLi07lSSTGYQh8sLFsorZvsInPPY280LUbe/MNkiDvoq+G7Bdyxc8+yA57qUYE99IY87Svm2xKPltU7lry2LGz/SO6I8UpMIR6k+qbSEQbnz+RIFpuWtFfUesyf37sM73oPeTd7e/GZUQQiAhD4wVE2GBZnD5Gs1LdBkLJwx2ZWA+V3iTlJnO3CiexLFx130zEQWy1DKDpZD+gqVLoGygBJhe3Fq/s2RUgK172CwENiF4KHqRu/WHskwDBqXMk8d70xl7U8buf5Ndd8a9BydwDnk13PP/nc64ADXxkG+UbK7gC+eAM3C8fPN72b/o9ZebVL4GpTwBMthagBpGpXvf73+cFSOsDnNo+myogqyKfhH+DYU0B9cfKXryQmx+F6poV4pltXLVMWyCA+IvwEs2bXDaAXwH9iopZzs82Erth9ZFEIIKevcdRi4QhEplyiF8PtqMtYCYV2KPVKvrtKIBzp3Dw6SK0WZ6kTE83KOCNkfPMwXLFYapKVC539EQCXW5SsCELst3u2tH50kdVIpamMSwxHxLNsPmzbXEIRR0RAh9EBLY6cpav7dsSzGXlmOMTYKz0j8v4jUv0S/Lsvf9Ygg6Vyq8YaBEl+v53/F4/XC1JCh03tfcsw68zZDliMG2xdkegmDZKj/pPa49xWt7SY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(2906002)(41300700001)(31686004)(15650500001)(44832011)(36756003)(83380400001)(5660300002)(66556008)(66476007)(66946007)(8936002)(478600001)(8676002)(4326008)(86362001)(38100700002)(316002)(31696002)(6636002)(6512007)(186003)(2616005)(26005)(6506007)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1DSXBIc0Y4VSthVitkT0VLbnFUMjBUalQ5ZjVqNFFDU1ZQWnpOeWV1YTA4?=
 =?utf-8?B?cVhmdHpFRFBGUk5TZDk3SHI2dG9FY2x0azFZTGpraFMzbmlXR2J4NmlacjdK?=
 =?utf-8?B?ejEvVGRxajNIZytWWDNadFZoandTVUplWWJ1UmlIc2tHY2NBa2VxYkhVUEdO?=
 =?utf-8?B?K0hod3h5OWJxaU5CSmtoMUVqL0FYQzArcDBYY1ZoU2U3dkRORk8ybitWQko5?=
 =?utf-8?B?Mmh1RHlpeVUzY29RaW1EeFpSempaRVJIUGpvVEZlcjg1enFRTUZYNlNJYlpp?=
 =?utf-8?B?WDRIaUxQNkRKMUczWlpEczlwc1RzbkF1Mnd2czkyWEpnQ3Z2V0VlbkQyWEVo?=
 =?utf-8?B?UVZwYzFvTVdJWkJwNE9rUTE1dm91SVlLMVNKU2JSMnJOY2FybnJNaGZLVVRj?=
 =?utf-8?B?SlZudHdDdzlQVk93TC9hMEpqa0VKRmZqUzRxNnBNSHBpdVJzZjRieDgrQWdk?=
 =?utf-8?B?N3dobEhBTzc1MGZ5d0o3VTdkcjd4bVprM0xTSDRKMmhpakJYVld5SlFSY2Ra?=
 =?utf-8?B?cUtlT3M4ZTRFVmg0eWpmU3NOYUtEUEw5cEt1UjB6M2s0Q3ZtWkJvdlV3ZE94?=
 =?utf-8?B?eWdYZWx2bnNFVmp2c1dRVXFQeXMzQi9jM0FtMFdQWjBvZHlHRmxkUUs2QjlQ?=
 =?utf-8?B?bm4zZmsrU3lBbHNBUlpoRnBEeTRxTVpvYUZzOG00b2tOWkFtWnZUL3pXOHZ0?=
 =?utf-8?B?K1Urc04zZmZtSC9iWlhGUVdteE1wWXg2VkErVkRNdXF5bU15b1R4ZGxNT29W?=
 =?utf-8?B?allJMlpxRXpHMGZCWEdMelBycGsydVczNDZvZ0tMUWZLdzlkR21ObGxDR2J2?=
 =?utf-8?B?bCszbTBNaGFSRG8wTUxBNldXUGhBaDRFc2JPQTM0ZnpadVA4NG80TDRIMy9S?=
 =?utf-8?B?OGVIeWhreEFUdWFPY2dUcVJncWxRdXZvcnhDY3IraXE2dzd1Z3Zqdzh3VVA3?=
 =?utf-8?B?QlpiQmpaaGd1QmVuWDNmK2lpZU95RWQ3ZWh5RHNBeTlqTnI0TURwV3Z6UklR?=
 =?utf-8?B?UnF3WE00VGE2ZEE4NUUyRURMc05qYjF2dmNYRVVJdTRCcnZaZjF5K0pOZ3Yy?=
 =?utf-8?B?dlEyZjdjUUxpZ0EvOEFhb29TYklwSVRISGpXODVpSTgwaVlNV2xFZER5LzZm?=
 =?utf-8?B?MTU2RVZsR3VmcDR3aTc4U0k1MkRpbEowcVFvenI4TXJ2M1E3c3dQa1ZTdXVI?=
 =?utf-8?B?eFplZGRoNlBoL0NpSmZUMVExM0tLTWRNNi9SOW9MUFA0NjREdUFCN1JNU3Fq?=
 =?utf-8?B?T0ZDdWxDOEF5RHFNeWpGYW85Ni9jYUs5ZWM4aHJYWWlSL092RGp2Q0RqR1ZB?=
 =?utf-8?B?WXZtbFg3T3BVSUdMQWVKYXZiMlBCcWcyNXdtUVNGZjZaQ0F6VXVDU25Tc0tl?=
 =?utf-8?B?eE9oNlpEa3pkVzMvTHJIczFyUFZmQ1lZcTdRbDI5dGlLQjVIUXZRTFFmN2tW?=
 =?utf-8?B?LzRSVDRvNmVsRmJSbENHRng3bFpHYTQyZmlaV1dXUDQ5OFZZTmRmdzB4eFZy?=
 =?utf-8?B?cDdPL1ZNTk1XN09RSEJFUkN6UC9TU3BhK0NHSFBIcEtNMlp1T3NOajVmN3M3?=
 =?utf-8?B?TkIyZ3BBc0dsbkJWMmwva1FKbHowR1owTkZQeXR4R2NPWjZsc3ZDTSs1WlFp?=
 =?utf-8?B?TzhYL2s0UGtsdXJPV1l2VG5zdzlSK2ZSVVdRK3BtOEI4eE5IZkM4cytkWTdj?=
 =?utf-8?B?UzQrMW0wVkZRSnpjNmg0ZldoYmJ3YkpsSjdpQlJWeGJGRk9MaStnaklWZ285?=
 =?utf-8?B?L3NmM21FSHVHbWJnenhrRTJHb1lIekQ5NXBkLzkrZmxlS3RYeEdEY2xwWGpE?=
 =?utf-8?B?Y3FPRUsrbFNXenMxdVFvS0Z3YVY3dGdnQnU2aXdxemcxR1lwcWIyNzNRVHcw?=
 =?utf-8?B?NHBUUDgyUlc1aHZOc2FsbVhHdU9FMm9ZVER3SFdXUGdTS3c2dU1YUTQxbklR?=
 =?utf-8?B?b0hxUnpTWEtjdm9YcXY5Yk0vRVdIRmdhMVZBdUV6Y1NYZmovYWJtSG9KZ1lt?=
 =?utf-8?B?dU5jZDRhOWxZQXNsbkY3ZmI3SUxrODdrcm1PV3hJL1hwTmJyelJUbGtIM3Iz?=
 =?utf-8?B?SndLR3ZBL2pRL2dHREhBQUlvT01sY0QrRTFLazA1enpXUmFvc1h6YWFybWNJ?=
 =?utf-8?Q?HoLJ6iY90O1c6e4yOVTmjiNbf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cd3e79-8dcf-454e-85cb-08db20dd18db
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 20:30:18.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+lx+WtLs5Hh7gOXe1RHOk1JNceGlYv9O57VRWwb4ugMx6vQN+tnN4brkm1EqToP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/23 5:53 AM, Michal Simek wrote:
>
>
> On 2/28/23 22:02, Tanmay Shah wrote:
>> If child mailbox node status is disabled it causes
>> crash in interrupt handler. Fix this by assigning
>> only available child node during driver probe.
>>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>   drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c 
>> b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> index 12e004ff1a14..e287ed7a92ce 100644
>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> @@ -634,7 +634,7 @@ static int zynqmp_ipi_probe(struct 
>> platform_device *pdev)
>>       struct zynqmp_ipi_mbox *mbox;
>>       int num_mboxes, ret = -EINVAL;
>>   -    num_mboxes = of_get_child_count(np);
>> +    num_mboxes = of_get_available_child_count(np);
>>       pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * 
>> sizeof(*mbox)),
>>                    GFP_KERNEL);
>>       if (!pdata)
>
> I think it will be good to also check that num_mboxes is != 0.

Ack, I will fix this in next revision.


>
> M
