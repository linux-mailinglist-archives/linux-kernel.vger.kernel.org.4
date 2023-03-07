Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D396AE6C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCGQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCGQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:35:37 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54DD96F14;
        Tue,  7 Mar 2023 08:34:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3XCEezrANxBqeUBq5LJiQWzFC/OUblM/caVGgZ76ZuVx/uvknGFevxf9v6tRoH9iHhFZCfDlpEdtzT1KenkhRwo3uIhAm50YwibSEi6VuGyJyzPPDpcTDgzDGX4BC9LzxR65PN+f9Z+tg4uhgedd9SP4xpg0/2BRA1DOxX03GDRwIfJMZV90qP1LVNjS6tnP7Ki/5/f9DDJIxZOV9XaVbs0FPXh2yQ4xZFj9zl+QxSOqhAhqaeK431MwrRzUAd6tSdKm4M6Bvs8CVDvwOmOwkJ+Yd+cFgfRxptztidpxFpNEip3icRnYYB67kxiBD3vQnlQYabk5Mzqa2IeqQnhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUOLRx/vYHNCQdrN0KYPRE3NPC6+M8cwdKvaVvY+NU0=;
 b=HaprxGsxN+Kh6e7OVrz8UvrJG0RavUqrBVEAJw+TU508k3sFImfLhKZilOzDAIp0bBP4vC/Z7G7Dc8qYBifTsXDJi6o7GxV0hZB4lsRHAcbmla7S/3h/whcJHT3pCMVvt4Y9aKpgTOrPRZZOhUWq5xyqvIx9Sugd/NSYat6AvceAl8NpG9OJsiOosoroSurGVWQ6KEZGb0v2TH4zqjWcWzXczWKst5z2GXMg+N7pwEZrBA7c8gDIMDLpCRUses+Dy9gIPPV5D95XYAyGmuYP8Su00dOTfb+oEAml+WJTEDd+HguhWOYLhVNHmlCw1MA4S4+ijZDiiQHC4HmGaT+byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUOLRx/vYHNCQdrN0KYPRE3NPC6+M8cwdKvaVvY+NU0=;
 b=ILsqhS3Pys98ub4P0V5K+fJ4QMs5faxLZWPjpUGZs93AxxBtSNXGnF1d43/zYZfR7cUs4rH7V3nf4N3NC87iNq9UnhqXEoXKb5I34c94LF7/54AXgj6Gio5WMpUzK08UFFoJEWuLuynj95VoAyHvTWluN48tjfZ82y8qoeo1XVu86ltkTzV+vV0VAcG1e7Pd00XwRexaEVsIwcWn9eGnmjvDpRn7CEKtrevNSYxW+jEzk9tesGq9KUZqJf+Hy4xE8gsuzOqVY4Ag4ZYbv0//I5JzCd2iSN8QI9iwDp2fMmxzyb+kXCMlig7+5s2RqAzdzD300u02EOKdsJ9qWHcH5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by AM8PR04MB7985.eurprd04.prod.outlook.com (2603:10a6:20b:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 16:33:32 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::32a5:c2e6:91d9:1a68]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::32a5:c2e6:91d9:1a68%4]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 16:33:32 +0000
Message-ID: <f8c5619f-1e1a-f759-6ab6-ea84bba3d635@suse.com>
Date:   Tue, 7 Mar 2023 08:33:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <leeman.duncan@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
 <88927435-ae58-c24b-e7b7-b675985de433@leemhuis.info>
 <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com>
 <yq1zg8pl1nq.fsf@ca-mkp.ca.oracle.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <yq1zg8pl1nq.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3089:EE_|AM8PR04MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a6b526-c7af-4a79-6c95-08db1f29b0b5
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BP0CkNUiP+hJGOl5N47AQENKpq6/wPJiXpB04o4R8BoiB791m1aUkCKvZe6QciLclpa1n+iO1vPtOfMWN9dkdNIoo5xh6KnfiEg8l8QWKjXeMudxi2U/cT+Jccp/ih5eaSLzQ0uUSd7N696KAfzzqLRmkHRTeaemqxJLOcirvjqZFcirPKLnsOm+harHRwKacUrOJyb/0aOBUBjPAvqolm0EcZJaSDSbQB0ZT+1pGEKHvRLkn9SmElT/zTVKUUlhBhmBwZ/lg5p2li9ED1q0ZFe+Qy36uS/LTOqfskdd4zAC4VurXn1R2+Zm0V3bWOzF0e3nF+eY9RTdpyzub4swfg69ZzOudIiwWMtVJ8+xn8fRi+11pT8CtXNmrymM4J/NkguL5A+g0q7+BLuCwiMS7D+IO8QbFJ2jM16FA8aeUiWEZw+UESvegwx8OZlEEKO3NiAwS7OlDDb7h2r1RORasGJtHhkq5SUvt72Y4hcr8QAjIo9BTegvHzUto+WZJCWlN6rSDkWrtTGvaaNB3CRjlxwLf7+rUwGWTS4Y8WHdz3fzfklhOdnsg0s10KjZ9+ACGjYr5GPsAA593Xi9T71dEGyU0SBM410DOlZ5D+JUNQ0LfqEHQvNjrpRunzQAGpPNsp8gxs+Or0COAwcyqY/gsRGhHu/CBieVHW2DIR2BB7Ygbwqej14apYx5mqPDOtvhDnWFoUPNupac1jDaECiIwWOS9HfrRZLjwFodf2vC1Qs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199018)(31686004)(8676002)(36756003)(4326008)(41300700001)(8936002)(6512007)(5660300002)(6666004)(2906002)(38100700002)(31696002)(86362001)(66946007)(66556008)(66476007)(6506007)(6486002)(966005)(54906003)(110136005)(478600001)(316002)(83380400001)(2616005)(186003)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SExCQStuNFhLZXJLNm5xYmFCdlpYem9VNnlMQXF3WWU4emhQdkVEcEExYXZZ?=
 =?utf-8?B?Mk1QbFdldXR4Tmx2ams3RjQ3QXpoSjl6T3k4Znl3eWl2SmtTMk9abzJPNWlW?=
 =?utf-8?B?bEhCYmZRK2ZiYk1ibm80VUZ0QVRyZ3RsdVBySkNmc3JTdWZjNG9tR2RDMFFs?=
 =?utf-8?B?czZNbGZNOUtmR1pYVVkrQkRQN3JUWHZUMXowTyt2ZWN3V3ljL3RlNXZQRWpS?=
 =?utf-8?B?bzllSVRZRFp0RWU4ZFBySm04ajd2VjlONkxLYkpjelcvVVI3WDBMaWNZNTVv?=
 =?utf-8?B?bFV4M2ZSS0FEbFlSUGFSUXVpdTNaQUNiQW1QbnZlVFNNaWNLZlhOdXkzNUdB?=
 =?utf-8?B?OXZ4VXFaRkRUVkZRQStZa1FQL2Z2Mk5KbzNuS1JWZ2pPKzFRamIrMHZlQno5?=
 =?utf-8?B?bHBaVFYwSDBQRGxOa1pOL3VpQ1pzVDFRYWF3WkQrOThKcjJBL0tPRHZ2SGZ6?=
 =?utf-8?B?Y2xsYVNzVlg3SWNyazQ1Y3Rwdk9xYjdaQ0l2VVpsNHI3dUNlS0pUWFk3VHF6?=
 =?utf-8?B?bW5lRFlwcm5VbmhLVHBpTFZaeTRteHZJcmcraUswb1JCY2tlTzc4V1ZBYzJa?=
 =?utf-8?B?NWdDckZmTWFLRVViN2R3dWNKNHFVeFVyM2pxZFlJbFRnN1o0Y0h2TTEyNUFL?=
 =?utf-8?B?b01adm9iTThHT3J0bDY5a2xnY1pUMjRoRmVIRzdFaEZ0V0tXeVZKOEtxOUVa?=
 =?utf-8?B?RlNRMUJXQUExTjNJdGdwa05jckZMc1NSVWhISGJnSjJFdGxSVWlUdTZLUm1X?=
 =?utf-8?B?OUF6WldZYkkzTFhOUWhESVZRRFNXQW1IcThkdUNJMEl3YnkxREJ6NW1ub2s3?=
 =?utf-8?B?OE0yempVcTJYL3pYYVhKMUxJYy81dVhDbmVKaUU1aVpzOW9CSHdVRUJuSTJF?=
 =?utf-8?B?ZG5MamFWNEs2bzVFZ1RNYlZaTHVLdlVoWEpKZ3ZwZ0grQnZ6YnJaOG11WCtB?=
 =?utf-8?B?N2ZYYWI4aC8yM1RuU1c1WWlYaWtxRlkxaDVBZDRGWmFsN3gzMXhkV3VmT21t?=
 =?utf-8?B?NThSM3R6cGFObDNKRDVtc0FPUmFkcEd1c0FtUzRpVXQwSlBvc0hzbmNFZ2Q2?=
 =?utf-8?B?emR5aEo2a083Y3kzQ3NvTXFGbXpRK0ZETjhHOHJSbjNlWlVvSElmeWZxYzUv?=
 =?utf-8?B?SHlRejhiVDVOT3U1NHZBWEFPRDdod0trVTNJRWVaRlBrWjJJV2djSzYvc2pK?=
 =?utf-8?B?VEdyR2ZXWDdUTzhScDdmUkhxcnQwWVZGNkVIQkRwQnRnZE13bkhkekFXb1h1?=
 =?utf-8?B?WVZTemFNSktjajlLY0RIak0xRyszeGdyZUVRZXlFcmxYL1QwTjdna0FzTE5M?=
 =?utf-8?B?RUgrYnJRbUhKMzhhckVzWGRXNlhTaGFrVEE0R3B0MFFZY1RCQW9YVHhQRDND?=
 =?utf-8?B?N3hYQ2NlNmsyRVFZaU1vL0Q2NlR2Q3d4UFBqR1dOeGZKSGMwa01YYzN2ZVlh?=
 =?utf-8?B?TFo2YnVtaDVEU1RSQ1pKWDRodUVVZjhPd2FuZko3WC9BTE56WmNucHpPNUU3?=
 =?utf-8?B?K3F5VGYweXZ5NS9ycFZIbUcrS0pDZ3JMc1RHMnBaYjJSRVdxYjNGcCtzWmxz?=
 =?utf-8?B?TG42TG1vQ0dWektPQm91SmtGd2dMR3RJRjhzREhSM2ZFZlpMTnVCR2tMS0g1?=
 =?utf-8?B?SUJiMTNsRlNocmNLaisyYXY2Ky9MOTRMNDV2ZTZ4U2dVaDhETjFqS1RKSjd6?=
 =?utf-8?B?U2VJbWp5M3VrU1pSOUpPTHZ5WjVjL2lSMWgrN0Y2SmxEbTVrZDBQclV6Nytp?=
 =?utf-8?B?ZDZQbWZlSUpCZEtLRzdKd0Y1RE83QnlHa0x6SFgrZ1JpaVYrQnlWTE94WTQ5?=
 =?utf-8?B?R1Y4WTRCUnpWZ0g0U05udXhKa2xYSUhmSStWYzhGa2FQYkRqVEFEWDF3OUZR?=
 =?utf-8?B?SEU3MnpwM2d1bVduekJVVXRtM3A5dlpSemZBV0ZhOUtDSjhzbXcxeUhMSXoy?=
 =?utf-8?B?MVVuOVRnQW90cjc3aEdoYVhvTTJQUW85WW93QTlvdTdIcE9ZWnhVQlN6TkRR?=
 =?utf-8?B?K0ZVWGY1eUNpTFcvalJ0aVM3R2c4R0xEaU5WZHg2T28xL04xVFA2c0JuV2VV?=
 =?utf-8?B?UFNOMlQyV1RIVnRqeGxkWDhPZ3Qyc21qQUUxaC9lT3VkNjN6N1ZpNzZvemVS?=
 =?utf-8?Q?JFh7brqgmB6gtRzs0+ZYdZPeu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a6b526-c7af-4a79-6c95-08db1f29b0b5
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 16:33:32.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SgoVlFS19xAZR69AF18LYG/pUYwEprDGjaZ2r9wjbK5oWX3BZ8YheSPBlAq3Y07mL9I8s9feto3xSSZXfEPcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 18:54, Martin K. Petersen wrote:
> 
> Lee,
> 
>> I really prefer specifically listing “offending” hardware, rather than
>> automatically covering for it.
> 
> Would the following patch work?
> 
> Martin

Hi Martin:

It seems the main difference here is that you don't modify the arguments 
to scsi_get_vpd_size(), assuming 255 for the buffer length.

My worry is that this won't always work. Looking at the code, the buffer 
sizes used for VPD pages include 8, 32, 64, and 252 bytes. I'm not sure 
how reading 255 bytes into an 8-byte buffer would work.

As far as testing this, my customer is using my proposed patch in 
production and is unlikely to be willing to test this for me. But, 
looking at the code, I suspect strongly that it would in fact work for them.

So, bottom line, if you strongly prefer your approach, I'm ok with it, 
but with some reservations.

> 
> ---8<---
> 
> Subject: [PATCH] scsi: core: Add BLIST_NO_VPD_SIZE for some VDASD
> 
> Some storage, such as AIX VDASD (virtual storage) and IBM 2076 (front
> end) do not like commit c92a6b5d6335 ("scsi: core: Query VPD size
> before getting full page").
> 
> That commit changed getting SCSI VPD pages so that we now read just
> enough of the page to get the actual page size, then read the whole
> page in a second read. The problem is that the above mentioned
> hardware returns zero for the page size, because of a firmware
> error. In such cases, until the firmware is fixed, this new blacklist
> flag says to revert to the original method of reading the VPD pages,
> i.e. try to read as a whole buffer's worth on the first try.
> 
> [mkp: reworked somewhat]
> 
> Link: https://lore.kernel.org/r/20220928181350.9948-1-leeman.duncan@gmail.com
> Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
> Reported-by: Martin Wilck <mwilck@suse.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 9feb0323bc44..dff1d692e756 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -326,6 +326,9 @@ static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page)
>   	unsigned char vpd_header[SCSI_VPD_HEADER_SIZE] __aligned(4);
>   	int result;
>   
> +	if (sdev->no_vpd_size)
> +		return SCSI_DEFAULT_VPD_LEN;
> +
>   	/*
>   	 * Fetch the VPD page header to find out how big the page
>   	 * is. This is done to prevent problems on legacy devices
> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index c7080454aea9..bc9d280417f6 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -134,7 +134,7 @@ static struct {
>   	{"3PARdata", "VV", NULL, BLIST_REPORTLUN2},
>   	{"ADAPTEC", "AACRAID", NULL, BLIST_FORCELUN},
>   	{"ADAPTEC", "Adaptec 5400S", NULL, BLIST_FORCELUN},
> -	{"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES},
> +	{"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES | BLIST_NO_VPD_SIZE},
>   	{"AFT PRO", "-IX CF", "0.0>", BLIST_FORCELUN},
>   	{"BELKIN", "USB 2 HS-CF", "1.95",  BLIST_FORCELUN | BLIST_INQUIRY_36},
>   	{"BROWNIE", "1200U3P", NULL, BLIST_NOREPORTLUN},
> @@ -188,6 +188,7 @@ static struct {
>   	{"HPE", "OPEN-", "*", BLIST_REPORTLUN2 | BLIST_TRY_VPD_PAGES},
>   	{"IBM", "AuSaV1S2", NULL, BLIST_FORCELUN},
>   	{"IBM", "ProFibre 4000R", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
> +	{"IBM", "2076", NULL, BLIST_NO_VPD_SIZE},
>   	{"IBM", "2105", NULL, BLIST_RETRY_HWERROR},
>   	{"iomega", "jaz 1GB", "J.86", BLIST_NOTQ | BLIST_NOLUN},
>   	{"IOMEGA", "ZIP", NULL, BLIST_NOTQ | BLIST_NOLUN},
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index f9b18fdc7b3c..6042a5587bc3 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1055,6 +1055,9 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
>   	else if (*bflags & BLIST_SKIP_VPD_PAGES)
>   		sdev->skip_vpd_pages = 1;
>   
> +	if (*bflags & BLIST_NO_VPD_SIZE)
> +		sdev->no_vpd_size = 1;
> +
>   	transport_configure_device(&sdev->sdev_gendev);
>   
>   	if (sdev->host->hostt->slave_configure) {
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index 3642b8e3928b..15169d75c251 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -145,6 +145,7 @@ struct scsi_device {
>   	const char * model;		/* ... after scan; point to static string */
>   	const char * rev;		/* ... "nullnullnullnull" before scan */
>   
> +#define SCSI_DEFAULT_VPD_LEN	255	/* default SCSI VPD page size (max) */
>   	struct scsi_vpd __rcu *vpd_pg0;
>   	struct scsi_vpd __rcu *vpd_pg83;
>   	struct scsi_vpd __rcu *vpd_pg80;
> @@ -215,6 +216,7 @@ struct scsi_device {
>   					 * creation time */
>   	unsigned ignore_media_change:1; /* Ignore MEDIA CHANGE on resume */
>   	unsigned silence_suspend:1;	/* Do not print runtime PM related messages */
> +	unsigned no_vpd_size:1;		/* No VPD size reported in header */
>   
>   	unsigned int queue_stopped;	/* request queue is quiesced */
>   	bool offline_already;		/* Device offline message logged */
> diff --git a/include/scsi/scsi_devinfo.h b/include/scsi/scsi_devinfo.h
> index 5d14adae21c7..6b548dc2c496 100644
> --- a/include/scsi/scsi_devinfo.h
> +++ b/include/scsi/scsi_devinfo.h
> @@ -32,7 +32,8 @@
>   #define BLIST_IGN_MEDIA_CHANGE	((__force blist_flags_t)(1ULL << 11))
>   /* do not do automatic start on add */
>   #define BLIST_NOSTARTONADD	((__force blist_flags_t)(1ULL << 12))
> -#define __BLIST_UNUSED_13	((__force blist_flags_t)(1ULL << 13))
> +/* do not ask for VPD page size first on some broken targets */
> +#define BLIST_NO_VPD_SIZE	((__force blist_flags_t)(1ULL << 13))
>   #define __BLIST_UNUSED_14	((__force blist_flags_t)(1ULL << 14))
>   #define __BLIST_UNUSED_15	((__force blist_flags_t)(1ULL << 15))
>   #define __BLIST_UNUSED_16	((__force blist_flags_t)(1ULL << 16))
> @@ -74,8 +75,7 @@
>   #define __BLIST_HIGH_UNUSED (~(__BLIST_LAST_USED | \
>   			       (__force blist_flags_t) \
>   			       ((__force __u64)__BLIST_LAST_USED - 1ULL)))
> -#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_13 | \
> -			     __BLIST_UNUSED_14 | \
> +#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_14 | \
>   			     __BLIST_UNUSED_15 | \
>   			     __BLIST_UNUSED_16 | \
>   			     __BLIST_UNUSED_24 | \

