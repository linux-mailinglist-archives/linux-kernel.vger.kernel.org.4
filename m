Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B696A63E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjB1Xsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1Xsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:48:35 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9D18A8D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:48:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f31aqaa7sg0jYzmqDNPmMlopYdAp8jae7hgITzLJRw3VbFdhNnlBnt+WLFt74wHkVa+7sX9+J/SnUo1TH0ZQ+I47+iQf13AfijHLVbsh3oh0pVISDW2aI8ydpaBJryO/gDcY3hQgweoitVrpcFqu6AEOhk6iArCxah850Ei8QDUASE4KhISbQBoLupOzecx0BMVnEmdjP0K0OXoj0pZxdbdY10Lt8wVenbS1HN6uOXJP+i4cm5z72/GiWQltn/tIVzYj4Bg4fwc0Oip09wR0UlBOcdaY5dfnZyw+DeiZsPTnzCYZXwkcqz/62eucqAnvv2BGwCDU9O5fuLokWtcziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8AvULHE6d67bftCAUTM2BK7xA416zBHrHrg4lobXrc=;
 b=TonDxnERRE4rE/CGoXZ7OsmjejCnb1iCNlav/dlwlQRvc5e8Up9BWFbXYCv7k2jPBXYLkxvYRe4mQVF4iYrWYMZfAgMfUt54/S2IX34uts71LMhYCp99lWxW4G8lYXUk73q2UK2pFLHhI/IZmHk3Hk/22INQF89YNZWJnbmm++2Dbep4rDpcQ0aer3SEYe7VjQVYCI0CDhSBi2Y1JOZZhggQP3nV8ctt8MMXRjZzOPWAQaU/RzdasE11wVX35iaXJX1uzn97JUr6VRdy+E5nNhhGKG/DQGCpTUcIJ8/NopClSIk3ezmpFBMQWmLCnLvF6qldhxyEiLc3xNPgV26tgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8AvULHE6d67bftCAUTM2BK7xA416zBHrHrg4lobXrc=;
 b=1HzQr6L1HqDAXiUlfJy3R6ENcq7yt1XJoV3kyIwEASyvjUpb3EpTLomxiqveAkVcqvvXA14BKx4y58DPDWTKIpUPt2Zthpdb9JrFTkPwpv1KEnQriydYpCKqDHqncKm7TcS6KR+l41mWhvY/Fk4KUhi/gCXp/eDj4RiKPgkK3vE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Tue, 28 Feb
 2023 23:48:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 23:48:30 +0000
Message-ID: <576494fb-c3c0-1072-a461-8a822f079f1d@amd.com>
Date:   Tue, 28 Feb 2023 17:48:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] nvme: Add a module parameter for users to force simple
 suspend
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, elvis.angelaccio@kde.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230228221148.2672-1-mario.limonciello@amd.com>
 <Y/6BX58qVUUx/Ey2@kbusch-mbp.dhcp.thefacebook.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Y/6BX58qVUUx/Ey2@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c32910-2e68-4e95-dfcd-08db19e64ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isZAanvQ1dg44qZ1AbWdGK41ZSEtekJAtLXmOxzODCH61JAI/6IBTphcAwRGiwtPSMXwkniSG5D+BDzfdfb8ZHKpKfG081QS7Ft78IQ1G45FAbBfO8qsHyE134ogd/JNIiJP2Z9NcfVGJb9TmEAzhuofGvWMvOekbUujymCjH3VdZFnnUomioGSGNfAau1MOS805YytlTp9ZQjjOuU1p2MDQtxDSB6zq6NdcDI7q8z19R3FNcuQ06n9Cb4SXjJ0lCrMOUQ6/rY2VUubbmj1GkXHg+BJxbfRYpjMMrGR2nSrnuOFo2NSff2jVJQWZffYiP7HcUVdESyUlXeHAxbSeYP5uWdAsEDXz6q27+0pYBBsIpZVN+1Y3hcr2RgkS0AYfYXBVC7bPPVL1I8xaQUz+goj3e6p4hfgIzaXMwejfzpXwkYptmxE6UL1Xa6Bx1rdJGlL8o7oQWF+5cQnbeDKZSfhnOYuEM8IH9ryDaJW4/nAm7u5fGAP4zARnAtH4TYlCJbxdgZARKfUMwkRWEIVMBrEGW7FrIrJPEOokGUjIh4LL+TAV1K4/TeuOIr2s42SAv9AWHHM3Cdbc3D2V2vOnL7dVsy/eU2TeqI221FgABby7NAat80KRRZtKTjzXKqTLYCUy+7AcjLvlZxY5Xm5U1NhwzT/3F6/3RiWT8VpJurjRC34Vx07yw3DkuBHEUVl+iBJnwfgiry5OudQpD3PP9qsN17oUOsHb90YS7OSKWtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(186003)(478600001)(38100700002)(83380400001)(2906002)(8936002)(66946007)(8676002)(66556008)(4326008)(41300700001)(6916009)(6506007)(15650500001)(5660300002)(66476007)(44832011)(6512007)(53546011)(2616005)(6486002)(66899018)(36756003)(86362001)(54906003)(31696002)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdOMkNPY291RFNncUhMRXN5REtHekdBVmNXeXVZa29pZ3RlbkI2My9JeDFy?=
 =?utf-8?B?cFF0Rk9aQlJudE5ETmlDcVFoRFBlTGlCdXJvNmpZTEc3M0lUeDdhN01Tc2NV?=
 =?utf-8?B?Wmw2eFFUSWRsdmp2ai9pZ3NNenZ6ejVnYjBFWXp6N0hQOWtxZ3dHWk9tSitv?=
 =?utf-8?B?enEyTGNsbFk2elpMVVJ3OFMwSmkyS0NxcXkyc1hLQzluTkxJY3ZYemV5NkY0?=
 =?utf-8?B?elB6TXV0WThsNEJxSktZNW1Kd3JDOVk2MzNEZ2ZiNnZNSGVFR2E1VWtCMm5k?=
 =?utf-8?B?SjJTM3IwbmFLL0ZYVHNxUUdUanNsZlN0ekErVXF3cS8wTy9yb3IrTlJoZno1?=
 =?utf-8?B?UXlleHpWdnFiaUVZWWY4TlhHcDh0TWhiMWhRb3BBMDV3YTJyVlZaMXV4RXg5?=
 =?utf-8?B?RDdOTEh4bFZ4ck5weUV0eEVGKzFaLzVjYzFOMDhob21RcndzS0lNaWpjaUJQ?=
 =?utf-8?B?RnRxZzRyYzdzVTBmbHMvMFZ2Y1FHSmdTL3ZpYUJ1NmN0eE8zTHZXL01zOHdI?=
 =?utf-8?B?dXI2QmVRcGllZFZqOXFNOWgrUXM3bUZKelAxYmxpUjh5YTlSYVZaeitzRzdh?=
 =?utf-8?B?ajhGTHl3WnlZcXE4UjhGNlZsQ3dzb0hxNnVNaWNKQUJWWXhqT1hSNER5TUUw?=
 =?utf-8?B?VDl6bWdoa0JJdDROcDhvRkZidmIxUWpjY0RlbmxzS2pZSmo3cW1ZVHBIR1Vp?=
 =?utf-8?B?RVVHSkY2R0dDby92YVVoWVpWbndieTc5akFncTZaUHNtZno5MmR1YXpkSURj?=
 =?utf-8?B?NUFrWHcrSm1vUnNrbFdPR29qRlM4aHV2Z1Z0OTk5d3FOdUQ0cDhxeXllck5y?=
 =?utf-8?B?MlNCOGR4Wk5HZFhNL0NNczZSTlZxYWxaTEZLNHV5TVp6cGZZcys3OEJ5bVNu?=
 =?utf-8?B?aEM3WW45WGw5aGJtR3dzNzU5Mk8vU2NCTndBQm8vWGZFMjZrK3pkc21VSjYv?=
 =?utf-8?B?eStYaURvRThZb3kwend3TW5mbStmRDNQWDNKSDdBMERhbGwzWTQ1dFMxdUxQ?=
 =?utf-8?B?TkdqTHFnRDJxYjRVNzBLaTk2MTRxL05ld1UzSXlYbEJEamI0UTVBaGNSdHM5?=
 =?utf-8?B?Zi8vQW56OXNQU1VqbEU5aWVHeG0rd3h5eVRDbTgwdGt1OU01VlZKWDBFeU03?=
 =?utf-8?B?aEFJWFRKaEpXZTVOdWd5NFhHQVVmQnJzZDlHeTBwSGpNWG9zUXFMVVo5YjBP?=
 =?utf-8?B?ZHdkM3Vvc0JlYUprY1Q3bVFJd1pVT2NkS25nVExLNm1WTDVPK29vMEVleDZ5?=
 =?utf-8?B?SlFldVoyMkhHTVdxeDM2R0JLY1lxaHVyT0lzQ0hIbjFuR0pwV09Va3NsRy9U?=
 =?utf-8?B?a2NSK3VVNjd5a0p4ZzFrQ1ZFZm5yZWZPdTAyb3I2T1MxcEhna0VMclpMc3NT?=
 =?utf-8?B?ZVh0QWFpbnlnSDBpcTBRRVVkUzdaaVdXY3ZVNzdaRlBpUXNXMCthaEl5UzBO?=
 =?utf-8?B?YXZ5WGhQNWYvdkpGOXNidUtJM2RMZFJNSWljaVl1bHNkWHY4Uk41cm9wSllG?=
 =?utf-8?B?K2FVNE5tcXZGNmxIV3VIMmJoSDg0cEVnV1B5TVRMdVFFZjhEa0NVaVFFZW5L?=
 =?utf-8?B?aXY4N295N0lpcUFwczVCRE5neGdkSEJxVE9GMW91VnZFd0o3N0Z5dzVmRzZQ?=
 =?utf-8?B?ay9nUDcwZExmOWhsM3pSenRTNGhGRDVZZnVBS0E2Z0pZd3J6VUZiZXdvV3la?=
 =?utf-8?B?V25GSkc1R1BacjJvdHpKTGFjZytDRkNiK05pZWQ3UmZETzk0ME0xRnBWV1kx?=
 =?utf-8?B?SE55d0dYaXFmbUNtT1dCSWt1RWhGb3RwTTVDNVI5akkrK3oxVWdRdEFsK05N?=
 =?utf-8?B?RUdiNDJYS2JSQjR3T1U1RG1YbUZxNFovZllSSU5pSVpFQm1SN3JtSUZ0K1dV?=
 =?utf-8?B?clI3eWZwY3p1ZnVLMDJHMWtlZ1FJakxsNmZCQkdQY051MUVSZDIweEV5QlVz?=
 =?utf-8?B?dVNUbGppVTlyeVdObDh2QWNKNGl3YXluOTZReitCVmpkVkZGYUt4U0lmZTZH?=
 =?utf-8?B?Y0h1R0xLMVpLa1dyT0llVVl0M1RxdWZJclhHKzhySVNWTnlrcFc3bUlwV1Rv?=
 =?utf-8?B?Vm8yeGgvWitGQlp2a09wQlM1T1pBNmI2QmkzR29NWDA1ZmorcU96N3lENU4y?=
 =?utf-8?B?RG9QS0lHSnZtVVFqT2x0RHdLYlM3Z1lmWW1VeWJZbWdOdVlwRjdzR05CTCts?=
 =?utf-8?Q?t5RWoE6zDLwkTw/oWnuCf9qTC8mpfl0vitCavbj9I955?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c32910-2e68-4e95-dfcd-08db19e64ba2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 23:48:30.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISCay8vGQmlmnoRIY7Q3vXTVyYN02bCbomqC3pveMv9Edj17gIWmApQP8uvrcs7oPBrfys5TtJ/tB5eq63Oh0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 16:34, Keith Busch wrote:
> On Tue, Feb 28, 2023 at 04:11:48PM -0600, Mario Limonciello wrote:
>> +static bool nvme_use_simple_suspend(struct pci_dev *pdev)
>> +{
>> +	if (!simple_suspend)
>> +		return false;
>> +	if (simple_suspend == 1)
>> +		return true;
>> +	return !noacpi && acpi_storage_d3(&pdev->dev);
>> +}
>> +
>>   static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	int node, result = -ENOMEM;
>> @@ -3128,11 +3145,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   
>>   	quirks |= check_vendor_combination_bug(pdev);
>>   
>> -	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
>> -		/*
>> -		 * Some systems use a bios work around to ask for D3 on
>> -		 * platforms that support kernel managed suspend.
>> -		 */
>> +	if (nvme_use_simple_suspend(pdev)) {
>>   		dev_info(&pdev->dev,
>>   			 "platform quirk: setting simple suspend\n");
>>   		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
> 
> Do you want the user setting "never" to override the driver's default quirks?

That hadn't occurred to me, but if offering a 0/1/-1 it certainly makes 
sense.  I'll add something to explicitly clear it if present for a V2.

Another way I've hypothesized that this problem (at least as reported) 
can be approached is to examine if ANY disks in the system have simple 
suspend set to apply a "global" change to all NVME disks.

If that is preferable I'm fine to spin it that way too.
