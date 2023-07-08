Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0C74BBCA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 06:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGHE3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHE3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:29:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9951FE0;
        Fri,  7 Jul 2023 21:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVVQewuRNVuzUa/HX/vmaJzI5rZrasEAB1GVoCk+rgDpbkEeVEp8rRSbHyxwxg3w9D9LzZDZoUbT4xf2DLgYlXyty4o+xJuf5XigAGC+XIqHtHCgS94atmqDbU4BeWPj339XeRSTawioSKSvqSHMZ5b5ZnkaQUzp/5Iv4/AUJJI8q4sJ0418MI0+NigOCYA6nHq0IC+SSXQufw6ys1pZpfyYBIH8xgA/evbyypntoJOoBTEzVcSbS8lSvieWLBkSTbPeC/GEWFj4VX8SwmPA+uqJ74wUwBA3CeYukakKchnwavu4hlsyBuf7UvYV/vVCavEP6yCT3JE/3WSfRIeuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wpw5Olh+BVDg2IOJGfUIG6tNJXR9ELApphfImcogsUc=;
 b=RstMnWZhpuJ01Z7uxqYAhQjsLgMVzWLG8Cfv6vM33HCLrCyDdLbP7nb66+sRGM52u3W4Qv2sZajJCQfXTKDTPta/yYMtlKY+IHGel/mgiMx4Fd1abJTOp17a+yGDfozJy9ihrVbExyT5D8gTCY79C2LjclNM0DozJKT364b9YDtqHAWcSc3VadPmFhnEIL7Nq/a6831opgRrmHnvMgrkBIGw3PU05zcftMPbf2g89miFSarA5uM2RevgF7Y9s0jJ+Qeug4PfKtdUqy2p77de6w18z46lvlX0VZ3sFgB8681Iv8GmFZ7ZiaQS+pt8AC2eCm/GSD7uYaNGVsfRxd3bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wpw5Olh+BVDg2IOJGfUIG6tNJXR9ELApphfImcogsUc=;
 b=cY0Q6w2hLtyc8IHZUGwyPF1E5iMLSOnlYbkFF7VHuXXRCtKbQ0XiOgYqNEXGHjn9vRNwFnHngr1yhx5TksTHWsxt8n4W9L6nFSo+mupU8HvyFCZZeqEZh5y6q5XrBhEvfB6FX23hNagN2aBOa1l2Km/Dz8Aw9cdE2S2FmbT5c7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 04:28:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 04:28:58 +0000
Message-ID: <47378415-b5ac-77ae-3cf9-01030a0c24f0@amd.com>
Date:   Fri, 7 Jul 2023 23:28:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] nvme-pci: Add suspend quirk for HP mt645 thin client
To:     Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
        linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, eniac-xw.zhang@hp.com,
        stable@vger.kernel.org
References: <20230706180653.761247-1-alexandru.gagniuc@hp.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230706180653.761247-1-alexandru.gagniuc@hp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0163.namprd02.prod.outlook.com
 (2603:10b6:5:332::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0425ad-6129-455f-0a4c-08db7f6bd887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1E5LZmN3sb2vxrKWmAkGqcb1zOoBWx+WeXP7FCBv1yKmmiNlb2qJKgm0o8oPPxLcD6QOmHuchGOMO5QjSl5mjIDDffyA6Y/vm2TauwT8QtOABZ2BhQdXTwjVyBL8bSfqSJUU7KT5l223sCNmMQA1C4hqFsy961qDJ+NPQwoCDgJTrVs9xlsB5GwLlK9fATSKNpJqUVUiw6cX1xhrLjhvLdq/GKNiZZ4q8fu+Ux9MEjqMUBFARSMC6r8xC/t7OV2JynEesdF7sJ3c0IN/c1+kuMjKfJke92YLfxCHAMtV4Vdmo4Y32rKWY9PTIFqhC1zg64w3eh5A2CTHN7bj8E67hD+5iWvfAGBl5Mi7Xh5a2M5EuY4CIzNe1CBGzzGvErKVXL0aHSrPLEt1th/jpXmZCyYc0Xlf/FP9UadBolLO7daHjLqSPebyaaF4aau4WG48olK7kXxtlB2b0IDrmu9TUAAO0DQDZf1OwETrjF+eLaCnmJtgFLj09Ck9wvSpz4MoDVkzPLJt9Kx+yvw0YygGwpZnFB4xy5qsytc8kN/eNBj+YDpBww+iNqykt55HNDX8dY1vKNiN8AQDZzIsl2RZF/8BDVsyL8n+BBlWoAVF2khFb6lutiMHO8UZ6BVVUOO0ZMS5Vs1jF6HjzT54mM+yKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(6666004)(6486002)(38100700002)(26005)(83380400001)(2616005)(6506007)(186003)(36756003)(53546011)(6512007)(966005)(2906002)(316002)(4326008)(41300700001)(66556008)(66476007)(66946007)(31696002)(86362001)(15650500001)(5660300002)(31686004)(8936002)(8676002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rll3TjBMcnpFeDZGVmlGanptME1PRW16bFhjRTN0WWN4NmE5aGZPclRmc0Y2?=
 =?utf-8?B?TUN1WllwUHFsZ1NVWEpWcXRaMFFZRXdTcDVUZmd6a2x6TFIzaWJQc2VQWlFy?=
 =?utf-8?B?a0htazhCRDE1NUVUZEliSGVBWUhWYjNmN3FkVGVJZGdIMzNUUytHVkJqVlNj?=
 =?utf-8?B?MkxwVlZyMUNkTzRNeVBOUmVXcVZHYklqNUxSK3VpZ1pGYWl1Vkk3NjErb0ta?=
 =?utf-8?B?U2NBNVU5Q1YrSXpPbGs0TU9Oc1FSY3JDRkRkWThvVkxvQVhKMytKcVk4QmpB?=
 =?utf-8?B?ZjYzOUJQQ1pFOFcvZkJyUzNCK1VZT0ZpU2FaMXk3TUdRclpMSDVMTCtsdnc0?=
 =?utf-8?B?OVdJQnl1eXp0cS8vYlRPb0V5Zm1TeGVPbnlTMmw4bXBwTDlVUmhTSVdwYjla?=
 =?utf-8?B?a21xa3Y3UE9Wdzh5WW9haUdiL0JsUUlrdDFJaXh6SzBybEQxdjYvUUh4UmNn?=
 =?utf-8?B?RXdrN1NWUjBNMVloRzlmcEZxREVsY0ZHT3UvbjVxOUVWa2RhVnhueUthMEhQ?=
 =?utf-8?B?SGpRWVNIZit5L3I0WVpkSVF2Sm5MSlc0cjNRdFRkcU0rZHRTK2ZjaGxmV2Q0?=
 =?utf-8?B?QWFWbWdqV1FHd2ViLy9vbWJXQ2w5QVNyVkNXa2V4MnlHTDBrTHZZS3UvOUF1?=
 =?utf-8?B?REpyOUhUVVh0MmZEZnhPc3JCeGtyVFRpR0EyVGpVU1U5cnQ0TWNxK0tyZUth?=
 =?utf-8?B?MWU2aXk2RXhVYld6dWdxMTR5bGZKaUlNVFVkZXlwNzBVTERVM1pUVXRxYTMy?=
 =?utf-8?B?Z1lQclN2WFBxcnVUekdOaXdidXp1c25vUU1WcWo2OWhJcWJJSGhSOHVGMjNT?=
 =?utf-8?B?Ky9uS1RiUnRtam5tNksvNVhUOE5iYUU1U2U3UGcvc0p1cWN3dWIzYlVUZFZh?=
 =?utf-8?B?M1V1NW1KTmxHYlBGNmFKa0hLaHVhd1ZXc29sZklCK0RTTW52WGdzbjJwdDRG?=
 =?utf-8?B?Z2RDQjdUUmtkY2NDMVIyRUY0Nk5OVkpJSS9FRE4vQUtITjdFYzF3cENVb3hx?=
 =?utf-8?B?SmViTVN5WC9VVTlLVnZpRzVyWXl3K2Vhd2FzUGVSRzlBMmwwMyt6U0Y4SlZK?=
 =?utf-8?B?V1pEQjlnaGFML1NzUnNPL0twWVhWa01WakJQdHFxRm82dmpkb3l0MkVnaXdV?=
 =?utf-8?B?cTZucytlT0VJcFFXUi9iYlJzdk1nLy9lSHBDUjl0a3F0ZEk5WW8wajdqSXBQ?=
 =?utf-8?B?cEtNVUg0S2lmS0hBbUFRTHhJcGU5L1JraTRGNEl0a0tlYUlVVFZKTkpoMDkz?=
 =?utf-8?B?VUlnK3ljS2x4aWE1b3pCUmVsZjdva2dZQkRmSzNuSlpKK01pVnJGajZXNXd5?=
 =?utf-8?B?Qm1CWmpMeDU1N1pHSi8veTJNTVBxenEvV2RLaXc1UnFmMHJYNGQrS0xueUVV?=
 =?utf-8?B?akRxenI2ZWJWWUxGWHZPT28ra1VPRVF4dElzUVNBUEtaTlhUekNKbE13aFRI?=
 =?utf-8?B?bjM5a3Nuc3VIRFo5bUU4U2svck14UEdldFhXTzhTWWxqS2VhRDljWVlUekxQ?=
 =?utf-8?B?TkJycDVHZG9sTy9jUjU1NVhKY2NOUGJUQy9zRXh2RkE0R3ZzcU1nUnk2ZTdH?=
 =?utf-8?B?anhOQy8rOE11ejh1b2N4ZUlVdDc3UHFMaVpJem5Td1BPQTAvU01BOGhORGhx?=
 =?utf-8?B?MWl1MFQyeWxKcjJjR1phVkM3KzNhWjI2R1ZibGswbldJUXVBUkIraXplUEpH?=
 =?utf-8?B?VmgvclJ6MTF4YWVyQWZYREZzZHZ4Z2F4Q0UrT21PaUdGRHpPRmhiZXJvZExQ?=
 =?utf-8?B?WTdENm9taEJnSGZiSUZMN0xnaTEyYkQ2d2dpUjhZL0JVQnAyZmVRN1NOamVs?=
 =?utf-8?B?V1A1N3d3WXQ2Zzhyc3RDK0wwYTVrcTg3QVVQVVh3SlRsSFQvZTBPaDVjaTV2?=
 =?utf-8?B?L05XYnJneThjNFNVeVhXdmtnckRhUWlWcE1vZWZKNFNNK2RvYm8yWlVNTGZx?=
 =?utf-8?B?VUtzSlhyclMyVTR4LzA5T2t5b0VIVnNndVFBMFZ3Y0E0U09hZE1ZZG9IMDVl?=
 =?utf-8?B?RDhOdmYvRm5iekpONEh1RFlSL3lydUxiOUc0d3Vqb1lacVNZTXhxc3dkRFV0?=
 =?utf-8?B?MDVCTXltcDY1RjJ4cklzalBaNVlXa1cxUEEzYVJEMVdJbWJDRmhlMWdONWZH?=
 =?utf-8?Q?vyas59j6O6L0pkm7rVS2sFCw+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0425ad-6129-455f-0a4c-08db7f6bd887
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 04:28:57.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mama2yU1tbRFPq85aZhOgSqrPVNzODV4Dr94jA1g03kq3n3RLsP4SnWD2oUlZSMMxlJsOD1n8USDkEotGJ+jtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/2023 1:06 PM, Alexandru Gagniuc wrote:
> The HP Elite mt645 thin client exhibits resume times of over one
> minute when using the normal nvme resume path.

Is this the specific product you're referring to?

https://www.amd.com/system/files/documents/hp-elite-mt645-g7-mobile-thin-client.pdf

> BIOS has tried to work
> around this by setting the "StorageD3Enable" ACPI property, but only
> if it detected the "Linux-HPI-Hybrid-Graphics" _OSI() flag. This flag
> does not exist, so the BIOS workaround can't work.
>
> Instead, just set NVME_QUIRK_SIMPLE_SUSPEND when running on an mt645.
> The DMI_PRODUCT_NAME cannot be used because this string can be changed
> in the field. Match against DMI_BOARD_NAME, which should be immutable.
I'm quite confused why this is necessary.  If the product link
I sent above is correct, this is an AMD Barcelo APU.

Cezanne and Barcelo report as the exact same X86 model.

Cezanne will already always identify as simple
suspend due to bugs that were reported on some other machines.
It's been this way since kernel 6.3-rc1.

e2a56364485e ("ACPI: x86: utils: Add Cezanne to the list for forcing 
StorageD3Enable")

>
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
> ---
>   drivers/nvme/host/pci.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 492f319ebdf3..25b59f5ce874 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2897,6 +2897,15 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>   		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
>   		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
>   			return NVME_QUIRK_SIMPLE_SUSPEND;
> +	} else if (dmi_match(DMI_SYS_VENDOR, "HP") &&
> +		   (dmi_match(DMI_BOARD_NAME, "8B0F") ||
> +		    dmi_match(DMI_BOARD_NAME, "8B59"))) {
> +		/*
> +		 * Force simple suspend to work around long resume latencies
> +		 * (1 minute or longer).
> +		 */
> +		dev_info(&pdev->dev, "simple suspend quirk for HP mt645\n");
> +		return NVME_QUIRK_SIMPLE_SUSPEND;
>   	}
>   
>   	return 0;
