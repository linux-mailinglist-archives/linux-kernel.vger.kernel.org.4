Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB36625D55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiKKOki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiKKOjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:39:51 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1169DC9;
        Fri, 11 Nov 2022 06:39:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA6nQJxrZ01Zz1XUkoZ6XW23Q/+BP5Dxi224w6E7vd/wuD0/67vF9YmIwGxBjsU3cTS+/tA2kwJL3W71uT2mo+tR3ELVKj9LgD4vZLB17Q5wJSDXBa8pRfUZlV5xIqYwH1z5+OO7/Y28TYQTKxISfZb1iMmdWQG94+v12X4QjoR9I9YhTb5wlUkUTgkptIEoKUlR+83uor93fUfjr0Ouwiu20nlTnPphW4o4p6hrWhtpY5KNnULOhzISKlAeJ8mDRhKFEerU4RNrl+aXIcgrfShDLsomMDezSFLJOxhPaOAM++MEM/dXdM5hLWdloNPKP3VJ25/uOKsNvnDeItxs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKaWpWpjStPB8aFHCJchFP/7URpcrQSc9wv7JC6hINI=;
 b=PruEBZqw2jTST7wtCUN4lJijh3/KK+GCQHhq00boGgeTM5WTmHJqx/5kTgeahK+7hSjgmzvMBZa/E9YcfUkHQpH3CM/JLwOiV0dY93DM3F+khz5KIH/6I/LmVCr2V74ZgQX6b3mWMzK6Z9gHZymPBfHgVzwX3yooBrmqUrna+KRXFK7OFOcayxe3IRNBcb510pbCXHoqkKJU7kT8jZ83QMOzfQ8HmSeuCgxuC7rzhyT1Hlo7OywPuy6c2rbhKzZGaqFecS7QSrHuXYC5WXgwfPHvUMGMAPCOotG6c2xhPtG5uUhgAUDUUT3AAlsxW0VhH7+SKR9Sm/9nQBApIj0l+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKaWpWpjStPB8aFHCJchFP/7URpcrQSc9wv7JC6hINI=;
 b=e8VuYiJ0SfLEFN5I+g2GQ1+f7jXolyAzb1oyOUWPe9a+J0fmNdW8DcPw3YdVg0bJNOi6U6cnArqgnxX877HDeqMSr5KSFXa97svsKqr0YAchMjnntIx1D0Bv4Q9GE02baA8MZrVdnWgcbRBk6aCkTDsDtoxX3bsdIo5el8fL3Uxxg9sGl51zRJ7KBUTz5Fi2iYav/LGjVS/WGMVlGl5hR8MP8PngxES3tcZtkJBboXi3JdxqXUDcwpibdHeLmJeQ0Q9biRrnU/Yr5QCjOYlcWlryYpKw+9OEXDgJElokqGlVCPLDWpkXtvYA0F8vErkQYA6P1Qaz5LuaKFelftRvOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 14:39:36 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960%4]) with mapi id 15.20.5791.030; Fri, 11 Nov 2022
 14:39:36 +0000
Message-ID: <ac1a91ff-7fda-f0ba-254c-cc389c519a5f@nvidia.com>
Date:   Fri, 11 Nov 2022 14:39:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7 2/3] xhci: hub: export symbol on xhci_hub_control
Content-Language: en-US
To:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        gregkh@linuxfoundation.org
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221111101813.32482-1-jilin@nvidia.com>
 <20221111101813.32482-3-jilin@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221111101813.32482-3-jilin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce6ebb1-2128-4508-caa1-08dac3f28e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cbQ5tj5fvY7AQ7BSaoA0SBvgrNOshExPm/gNEQes9/Itm5mRDgvArTmnGB5kQ+NyPSgk59Q6RTaDpDc8Ew0D7yWzH+YqNK7k4CU/jmp6uDjWzRhvooI2iZTnEKUSe6x0h/ZR/Qc3tYVYnoNJyQ4qdHvMI0cjobtt2s2cmhqKOrUFArM2fvP5NNaJTODVIab0tC5XKBct3xGCAtwgwbn+3MrU5eEfS2daJOYKox2OdljTIjfJRz03IHdJqP5cAp1h/MNjKl15foikixbpBJHgvAy1LgKCTVnnAJYrelLoISctebG8+vC5Lvef9YkkkbJO0cNZnAsFUAnUxD3vRjsGZYJV7yA9xHA4VLv7aAZ8yUaj2JpC59K4EQEqfL+wmUn5EJx/kQSTaRV/k5CFOanfaaTyAKh2xxRGAyj49W6qvl9DfpZZRAKBrZV4qlhItBCUhWaH1gYzrmMuDk0b/Ktce1HGLehOo5djWciglami2ULxbN1+R0E9OW5Pwqs8gGxTResdmGBngsbJoZJ6X0RSHZVBrUzTFJWyNzYcS17QLBdNfdB7ONUmVNKkEQdZppnriXz+XJ8/1LBzW+4SqLRP8dplwFQdxHt+YL7ls3zRQYDIRNAo8+noWZDNX47F4WLYt6CD6zXztKnfxjlSwZle7+wxCE71cqpX4ox3H6iGvtA/pGZ7WENquw58N+qx6aJX6YJzt1c1tBBvIgTtwCFMSQWDArhMzJ7oav7bVml5TsVnvebucPka2Q+jqu1UkzPh66SNaJbt8G5eSyWWKcftz8jit+BnRQUje8WzOuxZwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(31686004)(41300700001)(38100700002)(5660300002)(36756003)(8676002)(478600001)(66476007)(2906002)(8936002)(66946007)(6486002)(316002)(4326008)(86362001)(66556008)(83380400001)(186003)(53546011)(2616005)(31696002)(6506007)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUx0K1E3SVhOdXc5Z0NZRlJyemFVcjNmTXoxNGk4YzNsTG12ZmdLNlFqZEZr?=
 =?utf-8?B?RTNIK01NSlhFTEk1QWlSc0k2R0g0S2RXNGYwUDJleGpjcFhvcjVtWGw2OWpp?=
 =?utf-8?B?YlVZR3c4OGVKa2RhYnNQV01ETHdQZnhUUmFUTlZuVDUyN0tOQkdpWkgwQkFu?=
 =?utf-8?B?VlAyYWdrdDNGbi9IVXBjMUlrNytFL3VwZTkwN25iWEpydXh5SEJTcUFFa1BS?=
 =?utf-8?B?OElHb0NoYUhkOFZkdU82N3EvdldOUUJnNEJPWTlUUHV0bVo3Wnc4K3QzYmhW?=
 =?utf-8?B?VnF3WTZwVjJLVkxWcnBNbS96VGpwemlYcTc3MzU4bk1MckoxWGM4dlJOVHd3?=
 =?utf-8?B?dlhiTHAzQnpRTTBibXg5a1hQS3lGUTZZNzVmbmZwbHl1QXBkNnJmRFNFd3RZ?=
 =?utf-8?B?bi95NFd0RGRaRStNOEVKbTJlMW1MaHhCSzI3RzJxWkY2aEI4ZnVYSFV2MVlq?=
 =?utf-8?B?QmRrQ2Rab1lVTjBESlo5YkNIQk1ndWlBWTJZcUxVRTFRMGlJamxvMmZtemM4?=
 =?utf-8?B?Tko4aEVvRDdGeTFRVXZiYXM4SndjTTdQb0ZOUjhoalNVOG15ZXdCampsYjBr?=
 =?utf-8?B?Tnh5d081NFAwYmxEdzNoeGthZ1cyWVdEYndETjAybGJENXlLOXJHMkU1dzRX?=
 =?utf-8?B?SndpQ09EQWxzVHdma2VCVVhnQ2lNYmhmNEpWdHc4eU9tVEZ1SGZlVVhHVlps?=
 =?utf-8?B?Q2VFZ0NmaWZzYjJNQ0RTQTJRMDlvWDdJUTQ2bk9pMGIrNjN6d1JCeExJd1Bj?=
 =?utf-8?B?eVo2M1NOQ0tGL0djcHJxTHdKMjl1N3p1Z1orbGU3WjE5SWpmWDBic3lpYXRC?=
 =?utf-8?B?VkJ0SXhiS0RjZnQzaFF6ZWg0VlBBNEh5cmZFcDNtNkdka2dGaklRYXp2VmZT?=
 =?utf-8?B?VXMwRUVLRnYzNzlQd2o4VTNkdEZrQmVHbG5nVFBlWFA1c0VIVzU1b0Z6aUN1?=
 =?utf-8?B?NlhCYUpSVW9nRUNxeUFRZFVEN2ZTOURDM3l3MWtJRlVNN29KMjJXNjE2MTEr?=
 =?utf-8?B?QlR5UzIrQnlwL3h1d3BGRjdNRUZrcElIZXh5NGVGV2gzMzh6SzhCQWlqOUFV?=
 =?utf-8?B?VE4wenlkNkw5UW5EdUJGL3pWYmlaK0QyM0ZiOElzMU9LeFVlUk9NMmg3VlNr?=
 =?utf-8?B?R3ZONml2L2p1N2lUbVRJbzNWT09NcWRkQmtpYzhPQ05ZblMraXY2cHdEZDc2?=
 =?utf-8?B?OXh1UkhSOXBzU1htWmxTbUhWQVNXbDNVblVlSit5VStvSzhQVVpRc09Fbkp2?=
 =?utf-8?B?YTlWektWNDEyaVdLOG5PczRyUXdtSmFsVThnTzJ6MlVEMzNUcSsvTVJZeHh1?=
 =?utf-8?B?cnRGYzNhVjlQQXlIM0xNNzd6d3cxM0FVUkw0emFXWXNxbC8wQlJkOXdocDNW?=
 =?utf-8?B?ZG5mcUorcEJHRjNid01Sa3FyM1k0OFNqT1hSWVM2WExZNWtHV3dTMkNlL1J2?=
 =?utf-8?B?QXBGajVuT0RPNkIvdFVMKzhOTUtJZmNFandjWUxRRFNoeUhYOHZjeHVSSkNX?=
 =?utf-8?B?ZzhDQUswQURJMm0zeGhxWFUwbmRydG9lMTk1MDdKVEQ2QTROVG9HbldUQUlq?=
 =?utf-8?B?NXoxSDJuQVVWYTVRT3ZocnFpa1dycnF1SmtxM0szd2NyME1tV3NyVlVyNW83?=
 =?utf-8?B?akdQSFFmTWdGU2VzNEltN201MlgwZDNGRElndzBzWDBZWWZ5cEQzaytKRFl4?=
 =?utf-8?B?RTV2UTIrQzNJK3o4a2pLOEphTjhFemtQbXNGTnBkWEdMUkVjRmQ2SDFGWEZF?=
 =?utf-8?B?RFVNc3pWWlhHTXh1TTRNYmFjR3JJWGNQSWlWb1poTmVIQ1o4b1ZERU9KZmhL?=
 =?utf-8?B?WG1TejVrUUZNdkJPUFVFb2xiOWViWXYxYjI4RHBTblZtYVFyWFFVQXQ3SE1F?=
 =?utf-8?B?NVh3S1FlbnR2VC9ZWEVlL1RvVXNkMmZHZ2VHZ3ZWMmVuTnlQOFhXcXhubjJS?=
 =?utf-8?B?aHlKNjZDT0JXUDBnVE9MZ0J1OThseVl2M1FnL2lGV2p5WUpXQTg0dHRLZ25u?=
 =?utf-8?B?c3prSm5jTFdxZFp4ZWk3eWFNZXVCdjFqWHRZM2U0L2IySy80RzdMUE5PQ0w1?=
 =?utf-8?B?Z2tpUWxHSCtxRXd2MFFRVzB3VWVDMzEyOUZLNldQMnFPR0pEdmtBaVBZUzhJ?=
 =?utf-8?B?ekdTWm81SzU5d0xUZ1dHSXZhek9ERGhFc2NrQURHcUpVRE4yODhySFMvSTFJ?=
 =?utf-8?B?M2lXOExLMTVGRmlEUlZKKy9jZ1JHbXFINVloU1JOVXgxSXBQODBTWDNLSlJO?=
 =?utf-8?B?WCt1RDg3MU9pYWpxT1RxRkFKYkJBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce6ebb1-2128-4508-caa1-08dac3f28e27
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 14:39:36.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyFYB5bYnUmYPxRgBhz1H1Tvq/7EJBoFW2VcUwMwMZqI7zUHG1XbC+L+lDs4ln1tRBT0O/kL1uiQ+GZhLXz6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/2022 10:18, Jim Lin wrote:
> XHCI host drivers may override the default xhci_hub_control() with
> their own device specific function. To allow these host drivers to
> call the xhci_hub_control() function from within their own
> hub_control() callback and be built as a module, export the symbol
> for xhci_hub_control.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> 
> ---
> v5: new change
> v6: modify commit message
> v7: change commit message
> 
>   drivers/usb/host/xhci-hub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index af946c42b6f0..4f20cdae2a89 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1604,6 +1604,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>   	spin_unlock_irqrestore(&xhci->lock, flags);
>   	return retval;
>   }
> +EXPORT_SYMBOL_GPL(xhci_hub_control);
>   
>   /*
>    * Returns 0 if the status hasn't changed, or the number of bytes in buf.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
