Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE956225A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKIIkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKIIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:40:12 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2131.outbound.protection.outlook.com [40.107.21.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C7C17426;
        Wed,  9 Nov 2022 00:40:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn18bVaa//AB8FfMcKhXWSFwT8n+NLPVR0NhOCX0FseJnd2GBNdRfbOFJjh4HJQNgdoI+Z9WKCHm6xjGbgXcn7nAOu+x55MWSKdJbV95rPrGEsg/Q7rKmhdjxZIsTB15G0ukVHNna0+VbjHxPF7wIiK7wvYumksBo3XMueEuvuRDIF2snny3dfW9CmppOzZvLDHj1BTcsrfwbdvm6m9RCjzA+gbCfc5XB5kkoaT9nmVsdawP7xcu7nWHeBlKBNW9UxowhTAr1TuMzf21jkVvIrorPY/+BmZDg2jR1vGluAtV7mgpHUlJ0xCb0Ry0rrumFw+3TwZvnFryegNw/VOUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Iq7Yqw3ZHF2vOMThGmPY8N1DYcg+bLcMhx5tQ/uAy8=;
 b=NoNIWTpVuQfChym+qFU4IMz1jPv3Er/7Po94BudkzOhmYRopl9bn5yf2vkLMmJ2CQWlse+a1b/jpCWAlVQHiTzod2zhi+xc32i7JrEfOBeM76sClABGvMeHlybyexDtCTFjwDWM6mH+ankhiMJW0HD5uK+k53koH5wDObL7659UxxAQUW2RxHjq5eBMrG1mNj8UcmHbUXc+fv5DMTKbVJzKqKZdWnrzguMX1Tr16e85Orw98+RtRxXL5l/Z4IsnBTmOduYnj1Zr9u0PRSkT7tljc/Z1hU2VXezeuByn23S0NyIFbLL8QLYns09T8gFDQDNsEDHZMFWvu394Xo/PsiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Iq7Yqw3ZHF2vOMThGmPY8N1DYcg+bLcMhx5tQ/uAy8=;
 b=ilpmCDkA3NvwUfk2xRhAJupI3y1TTMUvKtCvxTwHGr+GokQ2Lqk0oTrSzWfBduVJlzKtUf2/Wx3qRQW9hYrui9+Gv2es/Qy/MUvMEpNFTNawJEwJupqJIlSzgbxWKLdSGCp9HsWouxrm4PegtvtAVT7ON3w7gOokGsQdWJmhqKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by VE1P190MB0814.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 08:40:09 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5791.024; Wed, 9 Nov 2022
 08:40:08 +0000
Date:   Wed, 09 Nov 2022 10:40:07 +0200
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>,
        Christoph Hellwig <hch@infradead.org>
In-Reply-To: <a9605f47-2f11-0ed3-d513-717c1935b83d@intel.com>
References: <20220808095237.GA15939@plvision.eu>
        <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
        <20220808122652.GA6599@plvision.eu>
        <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
        <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
        <20220816205129.GA6438@plvision.eu>
        <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
        <20220817160730.GA17202@plvision.eu>
        <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
        <20220818120740.GA21548@plvision.eu> <YwHOCHmKaf7yfgOD@infradead.org>
        <3b88438d-1bb0-e980-b4db-1f8663dc6042@arm.com>
        <VI1P190MB031779C030CAED8026D53D1895259@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <VI1P190MB0317DC34760DFDE69F69A700953F9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <a9605f47-2f11-0ed3-d513-717c1935b83d@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: AS9PR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::11) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB03177BC73BCF70EF1AD0A349953E9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|VE1P190MB0814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4e5d57-a7ff-4288-5701-08dac22e021c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R51GN0yT+dD9pCwN9625L/3k0mERjXOvmaaLIxyfe8nsqC8K1ORX2aT9DnsLuKUhEHLyzyDZOPUt2Y9Rw6HgdymqQ1mBqhfe60QKZeAxwysA1TyVjMXxy13TdfKK5Op0XmzhMHQqEof42rYbzeKZvbY8q6xkM3MOUHwOfyWg4qE7npRYATzYruht4mamFQAxpYncAZIRJDrQG+ynnPEiyHoZP/jQff3UwbbBszsdWWq3gpf95mlHBJUkv6IoL5sCYAfAeIgI1Xp4YyEjtnYGyQRJ2+WAB/OgAhDgn4Mh3fw5f3/krs6oHbqr8KgQCe0YU6TvmdVbwjArv2pNqThgPcyx5nqCM41SuqsySOQZ6fHL67UNAM6oRu3NoI+Q3uLQ+vKnfNyOMP+iUejk74x9vzYq/g+aQ1Fxz86NIOF6lSiBNhyAsR+6ticxMWFuCurklxFLrl7L3jS6KH/kJOM9Gsdt8Kyymprx5Num8xmjTAKw1k1+E0aMkXWp+f58/aFBPh1fAYzIJGR3Ll5iDq48FjbR4Z8l0l4ZoxlmG5FSvxGMbu8uaD/YZTMewQP9FpihHvD7aWVylPXovemarjbFLVv8gT9/kMDtkVCndtyj7DWOTkPr1l3CGaHCEQ8Zly7+3V2AYROuvXGZ/a5I2rzw8fjrdMntGMFxoo661CajQTH7Rc6hrtlGmkqVaw6q8wFRDXpNGa5yPoKg5NP+3U2mcm1tgn1Akds2Q5JY0FHwpKWouLEf7cfIpKPwCW/mZ9BYsBX1akSmqxSteANiyoOFoP8Y4SbyHGJUsYR9rMare/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(34036004)(366004)(39830400003)(136003)(346002)(451199015)(9686003)(7696005)(83380400001)(26005)(6506007)(53546011)(52116002)(41320700001)(186003)(38100700002)(6916009)(7416002)(38350700002)(5660300002)(44832011)(2906002)(54906003)(55016003)(508600001)(41300700001)(8676002)(66946007)(316002)(66476007)(52536014)(66556008)(8936002)(86362001)(33656002)(4326008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sblpBBr5pmT6yGtMJEl9FRvSjkeSNNwNZ7kAzFACnPNA0RiB1asDOgIAW8fC?=
 =?us-ascii?Q?AfhcDZ3dsiIkSXqR4KWuSkFAJuvgqJa55zFCrqzSUuUPtsI1s4gfhiB5WaQh?=
 =?us-ascii?Q?4vJ5+Z4AvpeJixFN1WccjhKUhO+/NIGg5EpqJk8cn737ruqdSrqEJvvGQYTx?=
 =?us-ascii?Q?qq71gjGadK5I8AsgYiKgw8rBlFsIHqq3S9U6pewne7Y1ShMdkSnRTx+5T8nd?=
 =?us-ascii?Q?7oXGg3GO0HXLjFXvbS69SscdMIUeZeFHJ5sKdnQTWw6xH9FHOsvh/ONj9e9f?=
 =?us-ascii?Q?Cw2uDJ9CEvmsq/YkCmQrWT63YYl+NYPfXMHZ5PCd9fnXWdyNBFpSofKsNAzX?=
 =?us-ascii?Q?XLyyTi1Pa2wnnT42JTgrlq354tQAjjJ7B4/NDV6/MBqNddu3eo1ItyhZPSkn?=
 =?us-ascii?Q?lEHkxTRfEu8Ieb67W3JExqS2wzyqfSOsoV+6EuOvUZSnHeFgChS5PylEe+u1?=
 =?us-ascii?Q?2HAz7vP86taVuNVI6k7psbbEJiZV0tQTAMFBQQomiSRixSC5qufmTCmhV9Jz?=
 =?us-ascii?Q?/Hdn1LN7949AmNE3rpmJV3XZxd0kr05/tfjjigCKc0v7suiKb+AOooNBwVif?=
 =?us-ascii?Q?uDT/i/b6bQAfZspHolH1zv+0Oyz1SzB2s8MBY7HvDzPICOXxOuCJWJVihdMn?=
 =?us-ascii?Q?RR6eyyBVBjlYroYLp+LtAdPd/V26bu9qEpb55tVbhj44H7OCSnnOEs9chz/g?=
 =?us-ascii?Q?iV4K/65SX0CMrhnJvOZr/2rxPZzDBs6W8OzJl7q+2mIURiIJX043d3vnJYtI?=
 =?us-ascii?Q?frnpK2Bp/R1U9phyhKQk1ak6ZHknvHn7bAO+zJu4hPkxabqei0LjhnkRW8Dw?=
 =?us-ascii?Q?xNoIdnMAHSYnQhfBhxqouefSmxpe7GX31TqK9GBpZdf+8mkkuzt9Ux68cqAC?=
 =?us-ascii?Q?fSASVU6jHdmzwc54xSvyTNbQujxImHoVseM/H+h/r1fZ93hOUaItZuvwllq0?=
 =?us-ascii?Q?XD/duBp3AxAt+rQk6GGZbGgN3YSIguAgzWvP5okI0oPbyk9WHwYltKxOTfNN?=
 =?us-ascii?Q?JlUgCL0g0gaaHYHchDmmKayfjeAiOBZseMxACyDREjRWgFb7J/uZmGt8Rma6?=
 =?us-ascii?Q?4M1jMmgYwAG0DHz/B4YYtIeuLulTrQe76jB+6pEZvYERX0ZJRhkcWodJjzPF?=
 =?us-ascii?Q?ofzV4fBhihcOIqlHAaZtY0OwCn57XLGRFTLJy0Q4QSIWYkjvL/G64FND2gHi?=
 =?us-ascii?Q?6gY1zcW7gRCbNBH8439uhyraVPwayv0+1foodOfwLE7fjJn2CMKwvhc0/HTY?=
 =?us-ascii?Q?3m7W5z+/Y9XyUYqx90xeaZO6lgS75u6eCy9VCGzWaVj6n9nmpfkFTyqjnak4?=
 =?us-ascii?Q?NY47OCCe/eFC1O2oHSzcGh06+JIY+6vcZCYUlhmT5dnDPOVFebCk3HYh27cY?=
 =?us-ascii?Q?9QNzzB4hzhvACDD625Asx5rQvqxqdZ4YH1j1DE5vqXQ2F9kWKOWvhNCbM8xk?=
 =?us-ascii?Q?WDuuvvpTsjUKxWigtudKxBqyB+H+L5gkwJBxMOthJvJCsH9Y0UHU55QR0rHr?=
 =?us-ascii?Q?jO7VTczyKiuJglNE28DX/YCv9WuAIDZpvB9nylLff+eR3uRlbnXJB1ormXz/?=
 =?us-ascii?Q?ra2H+nJnKUntTFzSb0QwK4lb9pjVjQaVxVY9CfTKckSMuTLGUiGmEKOzmhQ4?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4e5d57-a7ff-4288-5701-08dac22e021c
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 08:40:08.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv4ka3cUf1WH+VLwZpB5AjnW3G4jZCWaThNLXUdKtd5o/vh5DRgED8eNQSHmQIogUWv3SScP8UTD1Noe+qTwfooJ7DO7OkCVs+FVhUairo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0814
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, 9 Nov 2022 09:50:06 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 8/11/22 21:05, Vadym Kochan wrote:
> > Hi Adrian,
> > 
> > On Thu, 13 Oct 2022 09:40:00 +0300, Vadym Kochan <vadym.kochan@plvision.eu> wrote:
> >> Hi Robin,
> >>
> >> On Mon, 22 Aug 2022 11:06:43 +0100, Robin Murphy <robin.murphy@arm.com> wrote:
> >>> On 2022-08-21 07:17, Christoph Hellwig wrote:
> >>>> On Thu, Aug 18, 2022 at 03:07:40PM +0300, Vadym Kochan wrote:
> >>>>> It works with the following changes:
> >>>>>
> >>>>>      #1 dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> >>>>>
> >>>>>      #3 swiotlb="force"
> >>>>>
> >>>>> Is it OK to force the memory allocation from the start for the swiotlb ?
> >>>>
> >>>> It should be ok, but isn't really optimal.
> >>>>
> >>>> I wonder if we should just allow DT to specify the swiotlb buffer
> >>>> location.  Basically have yet another RESERVEDMEM_OF_DECLARE variant
> >>>> for it, which shouldn't be all that much work except for figuring
> >>>> out the interaction with the various kernel command line options.
> >>>
> >>> We already have all the information we need in the DT (and ACPI), the 
> >>> arm64 init code just needs to do a better job of interpreting it 
> >>> properly. I'll see what I can come up with once I've finished what I'm 
> >>> currently tied up in.
> >>>
> >>> Thanks,
> >>> Robin.
> >>
> >> Sorry to disturb you, I just 'd like to know if you have
> >> some ideas to share or patches to test ?
> >>
> >> Thank you!
> >>
> > 
> > Since AC5X eMMC controller can fail to work on boards with >2GB memory,
> > and considering that the best fix may not be easy (as it requires arm64 infra changes),
> > so would it be OK to use PIO mode as temporary solution ?
> > 
> > I understand that arm64 changes might not be trivial and it might take significant
> > amount of time to implement considering this unusual case, I just think that better
> > to make eMMC working even if it will be slow.
> 
> You can disable DMA if you wish:
> 	SDHCI_QUIRK_BROKEN_DMA | SDHCI_QUIRK_BROKEN_ADMA
> however did you consider SDMA:
> 	SDHCI_QUIRK_BROKEN_ADMA
> which uses a bounce buffer allocated by SDHCI?
> 
> In any case, you need to add comments to the code
> and commit message explaining the swiotlb issue.
> 

There is a snip from my earlier reply:

[snip]

> I could use DMA only in 2 ways:
> 
> #1 Use sdhci bounce buffer with SDMA mode
> 
>     But there was the issue that SDMA requires that SDHCI v4 mode should
>     be enabled, and when I enable it via sdhci_enable_v4_mode(host)
>     then I got error that EXT_CSD can't be recognized.
> 
>     But if I comment this line in sdhci.c:
>     
>     int sdhci_setup_host(struct sdhci_host *host)
>     {
>         ...
> 
> 	/* SDMA does not support 64-bit DMA if v4 mode not set */
> 	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode) {
> 		pr_info("XXX SDMA does not support 64-bit DMA if v4 mode not set\n");
> 		host->flags &= ~SDHCI_USE_SDMA;
> 	}
> 
>        ...
>     }
> 
>     then everything is OK.
> 
> #2 Use restricted-dma-pool in device-tree
> 
>    But I am not sure if it is good solution compared to #1.
> 
> Setting only DMA mask did not help because after some time I got
> "DMA overflow address" error stack-traces.

[snip]

Regards,
Vadym
