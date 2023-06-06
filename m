Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10316723DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjFFJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbjFFJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:39:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB1E49;
        Tue,  6 Jun 2023 02:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5MhZ4B3e/fbrbJdrzhGGI45U94GvMvWwR6zQ6HltUJMp+R69iCr+pa6+Hdp/nol9OxMA8chudkDxV8ZnjGDo8vsrj4ndaSplA3l5SD8n87yFdJMDzzGRDycSjgqNfkk35341djkORt2dLgHTHsfC3iUfcrPCLYNFX0DiOGHL1Gyxf21X6rSqLsOx6gRq0ghh2td16esU4WF7a6hzpYHwVZVU0/oWHENtApPaW9FFIl7AcQPxRHNDKwxdQvXR91SYTilbqjsggy4BgCkF18HZbYE9QEEusKSlbGroukkNAa1bYo4woN+rFsLMMcQ5GBePphJqIF6UoZ4KzF8D9GxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/bxZpM7zFWWrKXgDTo7+dwgK+IMBpTZrDBj0brG2k8=;
 b=O8GsA0tCCjYc4mXAbKJyGEenFSge1ZNM3EKAqxhpveQbYWdv9FNUiEqCDlFcLfvnkYxSgTtFZoq1BPIbl14blXFfY+UT/7785jcLNni5JCBGIXadsAIUdktl6mh1XmF5yMQb5OUdaY1diZizjRo6DuXuxV84AvLx+rK32SH7wDOUG/rbU0TugJGevCz/n100KdaLuGybL1NlwjqgsHLO+8f3KiRFG44USpotGzo+3oPBA/pcE9OYa81Q+ckh9MNAr+5WOv4pOcuMp2APZKWFISn6Y5ncYcZ6jiEWOc/q02pc+KLyOc+Hx08zaFbsEtX2a6grTQP/dh0ey13oZUzSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/bxZpM7zFWWrKXgDTo7+dwgK+IMBpTZrDBj0brG2k8=;
 b=RZ4tUgPudFzZfttshvtDT+ExBz1WCw+Y5+d/Qb76Sw0AcII2kNmdPRz2nwBYMXeWC9nxvO466PF0pMBligG4rAPo/s0UGcSKASDoHE1EuiRHfg4anji4u3Qf7vgiKa/r2JjHW3Iq7wboYaYrYfF8lQz6DgzY3QcuOqFVEo3HN7jWASsghrkgZ6dCrbWkXfjn8w7w04iBqGNSAR5OdpmiCjHCCgDj4Lq6zbvW6gNSaCPMYtWxH6IMD8gI0GiuIi/3gmQi2fGphq56Bxc2zn7qZJQe0ZDJ+fe4l7rWpLdXxnWzqM45yYFLi+6bJsRVZ5fHZ2AkSxzyDp2KNIXAMspTCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 09:39:20 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:39:20 +0000
Message-ID: <e7ae22f4-52c1-62a1-e5c2-71732bcb04b2@nvidia.com>
Date:   Tue, 6 Jun 2023 10:39:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] phy: tegra: xusb: Fix use-after-free issue
Content-Language: en-US
To:     Haotien Hsu <haotienh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wayne Chang <waynec@nvidia.com>, EJ Hsu <ejh@nvidia.com>
References: <20230508100320.345673-1-haotienh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230508100320.345673-1-haotienh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::32) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e97e48d-5016-4541-74a9-08db6671e788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6jtDeKL2WuZP8Exg52gLVu14LoSDbGj5F4l8fuI5Y+59KcZMp26Sz8hqwEeWVoFRzJIS68a3Nlbz2njKSsodQbaSsDAreH1XV/0UNk7lkbGO7vcj6ab4RvBYQCd/Vl9f/ICQ3HytciwhoLcgJwBzpvuu5LeTFXlg2DQqw30lE/BhJ7Szm+MkGxJJOuDfWyXYBWDlj7vPV20qE8Bl9O+EMSTW96hd2lGks+caMCYqOl8a3b6i91TkCWHA8IcoYRS7dNQGpe+YK1BdIVrOS7hDG2vXmIQsIFbWM/t7uZoRLVXMV7zMrYPcCnTMrhsVYtW4yrAohfPuYnWwwBvMfBkJPEbwrYk4zS8CG2a2rTWC4wi8TvXdovMTO0Qolp/SpSp6Sxf0b1G2f3uxUjjmy9jpR6FAcAt4Ja3EeAKqrxijc+ckPJ3Y8XbGlw324hbMGBPuIBPDTOb/RsHOzu7FNiVvikA/OfNCilZ08uxNNXCrBAOG3bu9MH019rtgUe/70GDBkmAUbWZLIAGQV4cmdrzjCmX+trHmsHD6ppf4ojRLJQ3EutStpK95TvuBZpT46nNAGgCFAedPVVqvRpwdDoWgzzvO+4NM6xjEFLyG9ZQor+MnNZrkYQvUP65XS0CSg6oQF89NjXG6M5L+PxS5EWVMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(6486002)(6666004)(53546011)(55236004)(107886003)(26005)(6512007)(6506007)(36756003)(186003)(2616005)(31696002)(86362001)(38100700002)(110136005)(54906003)(5660300002)(316002)(41300700001)(66556008)(8936002)(66476007)(4326008)(66946007)(31686004)(478600001)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzVqd1pOaWdyTG83d1IxbVpBVEh1YXVoNmtIRFBxeGdJSDYxKy9UTlg4TjFW?=
 =?utf-8?B?dXNGbm1KRTNwUVJQVUN4NjBpeGFqT2VQTjZxNS9tYjlTUE9rcHE0Vk9NMzl3?=
 =?utf-8?B?Y2k1TENZVTlRNjArck5WcmdOcGtTMDQwMzA0ZWNDT3RrSGhsbnR0Y2lBbjls?=
 =?utf-8?B?THFJa250a05xaTlCeHh3ZUh4ZllhUCtBQzRodkJvcFVUUFJIYlI5TTBzTGVN?=
 =?utf-8?B?NGx0ZzlRcy9UbU9rOWd2bjlmYjRuZXpycW5LQytqb1JuNnI0ViswVTBSSWF2?=
 =?utf-8?B?VFZrd3Z2bHdXTW5VeGhZWW0xWW1SY0drcm5wRzQyc3BjRDdDU0RzUU5pdmpH?=
 =?utf-8?B?cVpKeDhHeTJGMVQ5QnpHaDMwWjlZa1g2RjRkOVFlaDhyTE1BNDdhZEdmUGxs?=
 =?utf-8?B?enJsNGtZbUI5Rk54aVExTmF0TUhHYjZaM3Y0NVpYcVpYQ045YnhHRjEzejNl?=
 =?utf-8?B?N3FJRDNFdk8raURKQ3Z6cHJyV3c5cTdBM1Z1bmY0bmRpQm5vQklPZmZJUWIx?=
 =?utf-8?B?YStJbnNCckhtdm51SEhjL3NuVis5U3FSaHJnMkhrRDFTQlpqdFpqVUI3eGlC?=
 =?utf-8?B?K0EwRTUrOGw0elVqN0pFdjFaSU5HNnZQMyt4ZmFxZndsb0puS1lEWDkrUGJn?=
 =?utf-8?B?djJZQktkNktQRVZ6MW1mNjczRzJYTUxFb1dXODZidnl5cWFCUEVLa2FnYlJi?=
 =?utf-8?B?OWVOWmpqdVVwMGprTnBjaWYyemZEWHF1N2Q1cjB1UHZ4S2JXY2RVbkFucDZS?=
 =?utf-8?B?MmN4Y1RzQWsxVTdHa2NnYmRIRGpMcFZMRUtVb0hhMjJzZzRvbk1Vdk8wT1pQ?=
 =?utf-8?B?K2hYdTZueEZIWGhzSW9INEdVK3dNd1FBaGJNWDNPdm5lalRNQVFLQVUzQTM1?=
 =?utf-8?B?RHhTbEFrRk0rUWhsWnFocmluSDBBK3hFN0ZsdE45OWxaWmJVQVpKUmI2Z0Zj?=
 =?utf-8?B?dnNLUkZDdGJrRmRGdXdtQ1VtV29lVkRBYWE1MTVEaXBXVFpMb2FOQ052NFdq?=
 =?utf-8?B?VThNWFZERlpzNjQ0Ni9XWW5HZ2hQWEYraTRDc1F0WjNXSHBiSVlqcWtYTkc1?=
 =?utf-8?B?ZGc4Y2NubWMzcnYyNGI0c1NGa3lWeHFCYVJEUnBWUGQ4OS9Gd2x3WUgvK0V2?=
 =?utf-8?B?azRsNVd4SG9MeC9nRTNOSXJXSDdoU0pJaHFPaFJZKzA4eVhmVGxuY3E3WS8x?=
 =?utf-8?B?QkJzVkovNjQxL2h4N1QrSzBNeEhVY0pUUndOR2dMYWIySCtucjJOYjhJRFh0?=
 =?utf-8?B?dnVXUytrSm0rb2lNcHo4aUx3SkdZbEwwejAvUWlJNGs3NlNGczlFb1ltSWEy?=
 =?utf-8?B?RlY4SC9hQkFEdXg5ak5CRlhiNDBPSkYyc3FZc0o4cm4vUWU2OXZCT0lTMFJY?=
 =?utf-8?B?V2ZmRmYvaWliUFVxZGZWVlZDWmVRYnNxR3RlMWNmQXIySXZtUFM2ejhTRHhW?=
 =?utf-8?B?djRvTm1tbWMyakhFblJjMTgrckpmUWFNbC9FSXNXcDhlaW50Mzd2NVVITjVr?=
 =?utf-8?B?MVNXdnF1TGNlbmtzZHVxQytWK3FrUTlRREN4QnU2bHZwY0wxeHArbmpVWFgr?=
 =?utf-8?B?QjZGcWpYbVNyNlo5ZTFoY0RTVUg2bGduM1FTa3YxWWZ3ZHhoVjRsSFFEWnQx?=
 =?utf-8?B?eU1EbTBYcmc3dFhTQnNGL2N5OFJSd2UxQmgxaUZDNEFHRHRmWkl3RS9ZUzNB?=
 =?utf-8?B?ZWFHbFJRSkxJRHZCSTBlemxlK0F3eFQvTS9LOHZsdzFqc0w2SXlLckRsWkh3?=
 =?utf-8?B?cFdaWnVXcWJyQWdrc01Xak9pcE01WHpaVER5WFBQd0hmSU5ZbnVIWjNrUk14?=
 =?utf-8?B?SEk4d3k3Njk2dVlRQ1dXNzZObStmemo0TVVQZ1Vta2xneFRuYWtNRDFYWlhy?=
 =?utf-8?B?UWpvaUVPNTZob3JSNEVUOFVtcHI1L0w3UUJqeW1FeVd4QjM5QlJlNkNzZEg2?=
 =?utf-8?B?Nyt6R3l2Mm9QQTJFMDUwM0lwMklWclNYSWZLS2REWHZlaHB6blBGbEtnbHRx?=
 =?utf-8?B?MTg2bmpzZHBudU1yZ0t1V3NFMUNKd0FuNkVBeisvZyttb0dYcStJWHdqSHI1?=
 =?utf-8?B?TitYMG14UmtjbVd4S0EwcnJLbFBTbXZUakFwcnYvUENCdlhFaWExdzRCMkcw?=
 =?utf-8?B?eTVVTUJITFA3emJ6QXNqaW5pVWl0cGJZMGgzUVZQckpNZk91NDVoUnZIZTFB?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e97e48d-5016-4541-74a9-08db6671e788
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:39:20.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qK3ycNPp0F6b8YToyz6n5sn8NPvOZ8ooHETTYBpLkD1VAI23B3bEcYXojceSO0/PfaZjvLLghB9wXoFmryN2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 08/05/2023 11:03, Haotien Hsu wrote:
> From: EJ Hsu <ejh@nvidia.com>
> 
> For the dual-role port, it will assign the phy dev to usb-phy dev and
> use the port dev driver as the dev driver of usb-phy.
> 
> When we try to destroy the port dev, it will destroy its dev driver
> as well. But we did not remove the reference from usb-phy dev. This
> might cause the use-after-free issue in KASAN.
> 
> Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: EJ Hsu <ejh@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> ---
> V1 -> V2: Remove extra movements to clarify the change
> ---
>   drivers/phy/tegra/xusb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 78045bd6c214..26b66a668f3b 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -568,6 +568,7 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
>   		usb_role_switch_unregister(port->usb_role_sw);
>   		cancel_work_sync(&port->usb_phy_work);
>   		usb_remove_phy(&port->usb_phy);
> +		port->usb_phy.dev->driver = NULL;
>   	}
>   
>   	if (port->ops->remove)


Are you OK to pick this up now?

FWIW ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

I believe Thierry already ACK'ed V1.

Jon

-- 
nvpublic
