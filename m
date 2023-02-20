Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB3D69C468
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 04:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBTDO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 22:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBTDOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:14:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A80CBBB2;
        Sun, 19 Feb 2023 19:14:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwbiAl0jUdp74Z5332X7loNDZQQ7UGgME/Zz8mRCL1ThBgNnsur31YBOhGCecqKN2yT8ALHcE3CBOn7oBwISC7peSe9BgnlyyHPCRx4/WxrmRAUJ2teGYbXhveJscFqytZTJlfIf0oxMZLre+1ChuR7i49W9t8WA/dxITtbB9zuFmAEwak7VJIhpOashtAvpS0XG1wFAbek0qddiylFT/I7DN143W69zzLBPhHO9S7bDCzuo5K/2JS2Vj9DMcNfGjt4KYWZQGzEziBMeNrdQQSBq62qYZLZ3C4VQQ9SsfoLtYwMQxPbLbbBqOzFfS2cdlK/EIf9JlAjHe6KAsMhWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwD+JJFVkaETVkCrivMYDdCCWg0BK9d3VMrXuBVk4Rc=;
 b=DX9NHmNGT5PKQmWLIMMAX28aVHzrM0a+oMWL6PNdMUkZPIEm5VTB9BbM3zM313zH+PrepKQSheyqQqQB8ofF0wEKu6zW3jECHdn4bV/TTCEI6J8dxLpF69PXwnI/Meu5AJle/z69/LIy/R13sZMy8t2LmdyC5xzoSJxW2i2+gEBeQ983yMsVB15w9vxOWHOHAdyac6N5ypirO5DYKGfGsYcaXTmBVQhrLpRtSCUQndNgyBh5NOJB33qnWExg9LCKsOeq3n5mh7CL5bn/kBFTRLLypXUtQXzITSXeAUJXZcGH2ufBw8YqcOtg3EQuYBjfThh/xsinz4wKHO+AKAVQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwD+JJFVkaETVkCrivMYDdCCWg0BK9d3VMrXuBVk4Rc=;
 b=mkuwKPznphG7ckXjy1eHd/cClX1YqnfkUZ5bM2nMaP0rH4j88lLxcsl5PSR+vIXd34oVa5cVl9aDsIvQGNeMykq+wlHmNR27RJrerPN4kC6VHRi361idymy9UOtC8Q9XByA7Ty7rb1xXDTfugZi/4b6+Kzz1wCAAi8h7rZtJqVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 03:14:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 03:14:50 +0000
Message-ID: <141b6b13-00ca-c941-e315-6b2fe62e6515@amd.com>
Date:   Sun, 19 Feb 2023 21:14:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] usb: xhci: Workaround for runpm issue on AMD xHC
To:     AceLan Kao <acelan.kao@canonical.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "Tsao, Anson" <anson.tsao@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        "Oakes, Gregory" <Gregory.Oakes@amd.com>
References: <20230215075855.46204-1-acelan.kao@canonical.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230215075855.46204-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:5:334::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 4176d41d-48eb-4b2f-47ec-08db12f0a0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yNJpTN0JeR3o+jREomKouVjKszo6kkVguK7zfnO2arApEbrXgrvoKl03X2TW6nsI58uLik9YdenW9UqhKZ/YY7CcpQ5TmPg5+Y/aqhceCAOmuMwlz8R+fqPte1AVUedH0KEEkCJzyVATa4n+A/wVkhVR5ZiE7Xet6zfNPlYvcIxdk353ntH8LsZqX5+W2piulw6C6PPQSzkqGUuEROOu8Q8h5yiFLBOH2PcIBNp/8CozqNGJXvyQgUmTeTWRKujzafRSaXLmpvQFYQF27oh/92QU6FDVDXjSoxTiDkTp+LS8/m9YHeEetTc0oD8Vtas7Q09/GaI6BNkEXuEG7HQK0lUWEC1rdr6xwldh9uKAhY4ZtLMU0OEWQv5iMhJiiUEJA4z69IxrqFoqtxA9UR7hguO/8l+ZFVjafpvwOsqZ6jeEmjBcMqEy0OdYxmgXP1t7iUJDbIdNakoxI5/bcH+aW5XZrjXzaGcaeiZP3dfkdEG5iSFTkEz5fesK3MRsccjD0nrpmx+qpRyQIzQF742xO4Yb+uV6szesK4p0DbD6wgzfq5QWYRGVbAXnMYDZH1WY8NRAqsiF4Y0/xuNN679oDXby0b76+FdRysBxsgU/jIUUY00gGK47qXPCw3su6Rif7U+XrlDa5VDummYor5HEI5TmgljnssKUipax8Kz+WMJoJtGhjYFHHbVMt8xemUu29njIh8dDFUNRvAXvyJuiuVhN1e6uqBciiXmGwtpDzLI884IAQEf1C4stopkYP9A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199018)(86362001)(31696002)(36756003)(921005)(66946007)(66476007)(66556008)(8676002)(8936002)(41300700001)(5660300002)(44832011)(316002)(6486002)(6636002)(110136005)(2906002)(83380400001)(38100700002)(6512007)(6506007)(186003)(6666004)(53546011)(478600001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZnMW5IT1pzSGd3L2VtUk9Yd2ZIaVJOY0tFdGFHNlphc0pDVUpvK2Z6N2Vl?=
 =?utf-8?B?T3VEWWYzOVRSbkU1V2V1SnhlTEh0d1ZrbjV5aFdYSlE4RWFnOGhwbjkvM0M1?=
 =?utf-8?B?RGdDaTdTQmtqWG9RSkxlWGN0YXcyV3JvWVNacUhRQ3MvQkdRSUw1TUIzQmpE?=
 =?utf-8?B?S1VmSXA3bC9ZalhPdmI1RjNTdGEzOUpqZlh4dkg5YnRuZjY5WEM5SmJ3UnZN?=
 =?utf-8?B?ODRUWjBiR3hzOWZtWnkrNmdPNlZqV3hyWDhYNi96N3l3OEFUTXVHUVlCY2Qw?=
 =?utf-8?B?dTM3RG5YY0dMSXBKNEQwRWdYOU9LcVFaVURQR2xUTjRWdE1tR0RxTHc2N1dM?=
 =?utf-8?B?SEczZytIQzczVWd5c2VKcTFKTVlhZEU1MVVGbXFxK3NZMXcwbUhwbHFNMHlw?=
 =?utf-8?B?RE1SSmhJaUJtYW1iRmVqN0UvdVpuVVdCenF4V29ia2FuRU4yZFZSQXNKZmZE?=
 =?utf-8?B?OWw4WHA1MHNZdHB1dmxmZk4wckRTYVJSZ2c3MzhJOWJrQnRVOUc0ZzlCQito?=
 =?utf-8?B?T2FTT3o2eFVhK3E3RlRrbnRrdWkyb0liSWh4SStldjk0VGkxeWVJWFlMeFZE?=
 =?utf-8?B?V3l6UXNjdmVFODJSYzhhKzhHSlUySE4wRlFyZDFxa3M2V29iMEJPTEYrZHZr?=
 =?utf-8?B?c2JlWWJ4MnpPZjVWclhKejFjaXdobnVaM09qc29wamFrbENkcDAzbUxLeC9r?=
 =?utf-8?B?TFMrUW1oTmFLcXpHT29sOUs3SklsUWNrSVBzQmVMYVcweHpHa3pZUERtOFg4?=
 =?utf-8?B?eG5HNGE1MkxnUEZtbERIYk1ydE1qOWRmcnVhM3o2Y0psNWJGbDdFTk1BaGY0?=
 =?utf-8?B?emhIeG00ZzIvNzNDbDMvRmoyTk4yWlBsT0pLMEJvay9IZWV1L3FjM1V1bTdN?=
 =?utf-8?B?MVFTOEN4ZEkrRWZYQjZ3SFkxMkdZTEsvUjNqQ21jWW5TUmozZHdDOFZFTXhJ?=
 =?utf-8?B?ekczZTR2TEVnSUJOYjIzMUdpSWxEK3dEcHI5ZHp6ZzhOSHBlMGY0bGJ1bFNV?=
 =?utf-8?B?OEdOMmNpQzRWRytYYTdzcEJJRnY3N0ZFeG80UmFDYjZ4cXpjSFliWEhRWDJW?=
 =?utf-8?B?Yk1MZjBoQjJ1NU0rWUIwZHN6NXZqZ2FtNmJMOE9jT0IxcnVVOVR1VkRMai9a?=
 =?utf-8?B?dWoydWJ1b01Zd3hJNkEycnV3MXhqVll6WnFIQUhRNlJhcXAvZ3hWNDk5bUJT?=
 =?utf-8?B?anJ5SFVnbUZYT3J6bE9QS0NzQ1JwdC93T2Vybk8xM0tKVjRRNWF4aFVvRTI1?=
 =?utf-8?B?akpMOS9MYnV5VFUyTWQxaFB5bkZteXkrTXRXc3N2ZjVJZlIybGx1WlJCU2F3?=
 =?utf-8?B?U0pWUGZxakRtSXVzOFMyQjd5NWNMNUFla3dOTmJLOG42WkRlNUJIT0JJUkpt?=
 =?utf-8?B?NHd6MXQ5Qzk4YWNCaVMvNDZBWEgzR3RCUGNrY1IvSmRxRWN1bnZFVXZIS1hx?=
 =?utf-8?B?ZDdlRjNiSUVyeEV0U1pLd2MrNXVvL042Q2dFV2VHVlJpY3pDNXZCV3d0eXZw?=
 =?utf-8?B?ODJwWHlrN3ExTS9KUyt2SVlScGI4TW5DbW9Nckx5dHZyY2pjM3B5TldVRkN3?=
 =?utf-8?B?QVB5RU13RDczVjhFbUZVTWJ4Sm15R0Z4cFFrOXFTaXE4MEdtQ0wzV2hDL2lq?=
 =?utf-8?B?UnEybDBPOVBubWNwR2ZWZythd1BQK29KV3JwajFsRFdVUTJvdVN5WitVSTlv?=
 =?utf-8?B?Q3JoM09kK0kwc0xxb1JUV1REZlBWRW1KMXAwbUVqSEFocnBOWEttQXhpMzNy?=
 =?utf-8?B?WVZ3UDJ6Uy9BdXJHTlB4MlB0bmp6SXZKVEIxaEdvMnZoeURrSlpRQ0UrUHpN?=
 =?utf-8?B?TzdkTVNxdVZHUW42aXZBMU5Kd0JSZUtiQmIyOTBHK1FkUnVSL3RUenJ6UGxw?=
 =?utf-8?B?cDh0YXdZeXJ3alMrRnR1SDR2MXhwOFZnMkpLOVBTUHNXWTBMcDlsM0FHbklT?=
 =?utf-8?B?TTBia21DKzhtRnp4dm1pT0Q1K1ZySWtVMysyckNhSVZGS0wwaVhEMlV1bkE0?=
 =?utf-8?B?dlBXNU1idnF6NmhlYmFUbG5FcHpaQitSR3Blc0FacHZ0WUpkQncwcGIxdFJI?=
 =?utf-8?B?MmpCZm50MWo3d1FZSEhORkxSUlZaTEhrUmx3b3pkNFFscEViMkxPWmJMbmJ0?=
 =?utf-8?B?UU5Gb2pYbTJHTW9MMWY3UGUwZkxKZFkxcFdKR01MT2NIS2NDUGpBUUdIRGpF?=
 =?utf-8?Q?wI/rSzK7uJgwqGrhr7ws7AxT4dpXnGPsZt4sCqnHlaDJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4176d41d-48eb-4b2f-47ec-08db12f0a0a4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 03:14:50.1659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StYM0Gl0uty39WOSf2h5ib7dY/6UX2ACsZrK2+eIOz8ikxNjPHP3S9YCMILmv/9Axh7EojD7hV/ZJwgZkjxiKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ a bunch of AMD guys

Please don't submit quirks for AMD systems without talking to AMD about 
if they make sense.

On 2/15/23 01:58, AceLan Kao wrote:
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> When the xHC host is runtime suspended, the device connects to it will be
> disconnected while trying to use it.
> The quirk in commit 2a632815683d ("usb: xhci: Workaround for S3 issue on
> AMD SNPS 3.0 xHC") also works for this issue, so added its ID to the
> quirk, too.
> 
> 05:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:1505] (prog-if 30 [XHCI])
>          Subsystem: Dell Device [1028:0c3f]
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 64 bytes
>          Interrupt: pin A routed to IRQ 60
>          IOMMU group: 21
>          Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=1M]
>          Capabilities: <access denied>
>          Kernel driver in use: xhci_hcd
>          Kernel modules: xhci_pci
> 
> [   20.769275] xhci_hcd 0000:05:00.0: xHCI host not responding to stop endpoint command
> [   20.771429] xhci_hcd 0000:05:00.0: xHCI host controller not responding, assume dead
> [   20.771444] xhci_hcd 0000:05:00.0: HC died; cleaning up
> [   20.771733] usb 5-1: USB disconnect, device number 2
> 
> Cc: stable@vger.kernel.org #v4.19+
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Is this system that you're finding this bug already launched?  This 
looks like a BIOS bug.

If it's not launched we should fix it from BIOS, reach out to AMD off 
list to talk about it.

> ---
>   drivers/usb/host/xhci-pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index fb988e4ea924..b8f6843a8cd1 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -177,7 +177,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
>   		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
>   
> -	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5) {
> +	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
> +		(pdev->device == 0x15e5 ||
> +		 pdev->device == 0x1505)) {
>   		xhci->quirks |= XHCI_DISABLE_SPARSE;
>   		xhci->quirks |= XHCI_RESET_ON_RESUME;
>   	}

