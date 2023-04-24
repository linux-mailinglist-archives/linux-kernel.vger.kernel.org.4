Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885626EC3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjDXDbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDXDbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:31:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E682136;
        Sun, 23 Apr 2023 20:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F08b1hMkc4QiCCtMHPdBr9G6WJ4QBtYWVhS753cxXTWpvf59b7Z5UJhqwFYdEZCLUatBCYdO3iEZlCgxwr/MDwmY7qAYxDGnCBCLjNJHy/w5cWODSabc2oXJKeJ+ar6UoB7J/83BJeK37vrBAJbJeXFKZPdJ3bOAKwu4XhQ/cuHFn8E4Jga7By9Yo9nKJ86fdKgMHYY+5GMxpkdZvIVw5RB1LI1HPB0FXI0C95+Zrnf9SLDHq/VI579bHJCdBg4R7c8wRwHkFYQFcbml77cnP2AMIN18w5mt2weTAyuoSYudYIG6KTahhgt24aXnBZAaDHULwsdymYWVixMF/1snwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqnvjNWbcaBIWl0AHxvj644VkUPrpjv6C1kY8HwFH3U=;
 b=DuaXhqoBE5iW72MVwk8Nk+bevH0IEDLnkCzlSRIgtA0t8y66OxVFAcUBT0Lx/+AvlIuYNfLZR3WIT6UAPQHQpQg/p+BHR3wSYjEVoxhjEHPIKwH+AXkv6HHPvhyrwl0pefUa5W5SrwAhwaTW9BNqgGMPNQSjERXgt096OOCG6FYBh6h2dPQIxdEaIWmSfKyI2jtPZQV064jRXUzOkB11mfJR9IOa9Rwh9N6/WWHRUIoRzombfVaI2XiUCkhjWg4Shtbt7snr/95yJGIgbkCtyxpV+O9pAfj2KORmBwSVB7DEgpQgxtRbZutQ3dt7bVdUbmoauXBcEJo0Q9AeyNL40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqnvjNWbcaBIWl0AHxvj644VkUPrpjv6C1kY8HwFH3U=;
 b=pMpAd/Q6NLEWOsd2z82yKCUSIrs7/ZueTKI25YuKGcm+aQIQ3l6YvM77AAyRTimR8Q1Gzoxf1YfXuXQmOUg09uxsy1BNTH3jA2cZwpe2Pcm4ZSK2T9ZGiHFnPcEd4pwuPUS+11J8PUGasY301H/km2cXiFX5SohsmaNxzTfRhO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BY3PR08MB7121.namprd08.prod.outlook.com
 (2603:10b6:a03:354::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 03:31:24 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6319.029; Mon, 24 Apr 2023
 03:31:24 +0000
Date:   Sun, 23 Apr 2023 22:31:16 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fei Shao <fshao@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: goodix: Add powered-in-suspend
 property
Message-ID: <ZEX4BEVMf6GtvaAP@nixie71>
References: <20230418124953.3170028-1-fshao@chromium.org>
 <20230418124953.3170028-2-fshao@chromium.org>
 <ZD8z57MBvcfExJx8@nixie71>
 <CAC=S1ngBt9DmBobMkQXWhqE1UUxFv2U6iFd42nT=1N7r8+pFUg@mail.gmail.com>
 <CAD=FV=U_i26a8uJYmqYf6PUgmTUgmEB5L2DkVga0zDX_iDcGQg@mail.gmail.com>
 <ZEAGTiGyvynGA9P1@nixie71>
 <CAD=FV=UB393Z1zhK54Apgr-iRcvgiK0t36jt6-t5-5zz3m8OZQ@mail.gmail.com>
 <CAC=S1nj8VTXOovvianPWDYnsrbek0APD76SBNquFObaw8Vg4BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC=S1nj8VTXOovvianPWDYnsrbek0APD76SBNquFObaw8Vg4BQ@mail.gmail.com>
X-ClientProxiedBy: DM5PR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:4:60::40) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BY3PR08MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b6ac3f-90a2-4307-8781-08db447460c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4EKpB0jKEn4oAFfZYlwB5rYL+Tsi3ZRgM3tkLZkwnj/NUDFsoibToc/MfdBn1nrSz6lBZZpuDDi8dV2Rbdz+4V6IX+0CY5mo1ly/qqKWYnrmkEyys3RskqVBMnE4AWYv3rgpvFvtlrYGMoR7SltAwULI7Ck1lFV3CzCmw8lGJ7Q9A6H5qHV8fKnHVa619h3ieTqQupqiQoZbEr7kYsaa6Yi23iwGK9WG4JWTJTtT0w8dp81LvC3surklidK2hqq6pzJjFdKcIUV50gOBND8UsNu+0D6Sj1X77ZNF5NMExLj0O2z8kuQFniU7HKl1uDp9dNad4TbUJGXi8LAyRBphDqvfbX18KYPlCstPCIe9LQ8cUmBnwj0IMBkcH7Yd4cXuCaQC4PGpo1s8OPMYOWinEKL5CRAfVhRbADfj2cgG1HRu9SYXfaiRw8EPj03k4eYsLfsABCH2lwQfHFLoysagLBWpLjTw13zfALC9/PWPZYvjvM4Y08XSvJ2eZkIqZdsFQuF8Eq4cxvkTmuufWLpkYyHDO57Tx3ItGYqva4F1S5cTYSDJBjgbQe1aehOvQVyf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(346002)(39830400003)(136003)(396003)(451199021)(478600001)(66899021)(54906003)(86362001)(186003)(53546011)(6486002)(26005)(9686003)(6506007)(6512007)(33716001)(6666004)(4326008)(6916009)(66476007)(66556008)(316002)(83380400001)(66946007)(2906002)(38100700002)(15650500001)(41300700001)(8676002)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T215ZVlZSkVFeDZUMExKclFOdVlQWVJWRlJQTzE4TFhZSW9JcDNTalFXZERQ?=
 =?utf-8?B?STVIM2ZrVTdsL25tN05PTUNwN0Yrendhc2lpWGFYSG9qWmIzTGpoVDN6RXIw?=
 =?utf-8?B?UkQ0R0NuN3cyWDJ1TVIxdFBsWEw0dUdYWjBOTFlrckxqeUNCc1hOZDEwZzFr?=
 =?utf-8?B?Yk9uRDhTYjkvYjlKRFJZN1dJWXdnU2htZ2k4SWxaQ0F0Z1BHTmlpOUxic1Bs?=
 =?utf-8?B?TXRXN3ZOcWNFT2ZvMHNhVUxYTzJibDZ2ZzJNTlpBVGcrRDMzMndpMzNzeVJS?=
 =?utf-8?B?c1QvWGxuL0E4Q1hiS0Q4SFNBdnQ3OFdxWGZqUW5LTXBBL1p2NTJDVUlEaDdG?=
 =?utf-8?B?UTdJSFlRQmZSQUY1RzM0SFFNeWsvU3hXNjdJNndFZGVleXQ0ZEVnRG5NZ095?=
 =?utf-8?B?NjFLSkpudWVDRCtxdVFIclVzd1JOanh6MjhsajBNZ0NHUGE1K256RVAzT0VZ?=
 =?utf-8?B?WTVRb3M2RDYvRktCYmJYZHNOY1Q5SlJjU3k5UjNkWDRBcFFWdjZ4ZWgvZHZh?=
 =?utf-8?B?eGhmYTljdkp0ZVU5ZHJOM2ljTjkvbjE3K0RXTDJ6RUFuamVTdkoyeWN3cmZE?=
 =?utf-8?B?S1REWU5aRDFTNGhrU2FBeW9neSs4YmMrdWptbU52NDFSams2dk85MFVFdzlK?=
 =?utf-8?B?N3E3T2xQZGxqK0F3MncvWENvQlg0c0tzVzlveFNTMlpkb0pXcVpLWndoL3Nk?=
 =?utf-8?B?TUV3bXNmSkE1dnlUNDJHeDc5Z1pNR2lwdk1lU0lxUnkxZ0Y5cmhxQmk5czFx?=
 =?utf-8?B?VGcwdzd6Z210cGRFSUl6OWdtcS9mQjI1Rmc4T0FST3k3VFdOZGFpUk9tNHd5?=
 =?utf-8?B?RENYYk91YW9Yb2MwQVNCQ0FONHlrbVdQZzMvaGtrS1dydmtkN0kwaVFxYWEv?=
 =?utf-8?B?Zi9RWG9PZjNBUmJVY1RIOVZwZHNRNUlIeUdRUFJpVC94Y1RFdU1Ec3orWEsz?=
 =?utf-8?B?Q3NTOWx4WlF4Umg3d2t5VjJycXpYUG5nbTVCUXJzQmtXc294dWtVU2x4SUFr?=
 =?utf-8?B?a3p2VzlmTWVBS3hKbHljRElkNVQ2YjJGZjFKZHFsMC9kbm0rbzFtcDdqTW5r?=
 =?utf-8?B?V0Q3UklER0JwZXJvQW0zN0QwTzF0eEFmdlFobnhiUkRQQmhuWjhIYU4xN1B5?=
 =?utf-8?B?M2gxRXpxclFLaDFjTDhWUWN6OWFQSFd2cmRJVmVxa0JsVHRodzU1dW9rUVo3?=
 =?utf-8?B?alVZWm9OVFpaNmFLK2ZFaVYzbERnVXJ6ZG9hWDl6NHRod2YxcGdwcnUyUkgz?=
 =?utf-8?B?NEo2VzA2c0krMEhNTEVnS0pvQ2VsamNNaFAvQlhJWGNnaStWVFJsVVpYN29W?=
 =?utf-8?B?aGd6S1BJbmUwSnMvQitRTnpGekxQSU5kT0xkMTNwZnk3VkVWN2RxVnlFSEYz?=
 =?utf-8?B?cnN2OXFkR1lMK01WYUxrRHNYWVlQcWkxQkdsRzFvY1RhY043czE5RWhST2w2?=
 =?utf-8?B?bVNuR1YzVnoxckxJek8vZU9oU0x6cWJJRWZyR0gwK3FLRnFLMHVQMWMweVhL?=
 =?utf-8?B?ZDZtU3lWUk43Ty9uTGZkdDRXc21zVzNvM0diak9ybVFHWU44RDYvSjhqaFZj?=
 =?utf-8?B?NE9Id3JRRUVrOEppZ2pnbFFtc2s1Mk9LeDBLQUdXWDUzbS9vWmZRNGFjTUFS?=
 =?utf-8?B?UnNmL21CaEMzb2RXbmZnSHhSYjVXNFU1OWJvbWtEcGlzV3kvVFdXekR2Mmd6?=
 =?utf-8?B?Q1BnU1JKT2JId1FwUklXZ3EzN2UxZTA5UGVXRlZIdnU1MlFYT2xkaE5nQU9D?=
 =?utf-8?B?N2kxYlJBZGZKZzhqQlBLLzl1QjhKQldGdlE4eU0rOW90L1BMdXJOSGYydVN1?=
 =?utf-8?B?YjRLYzcwVDlLRGhkWFMzc2ZXUWdwakJXQlBsYmJlYUc4dFVleVB5eG12OHVT?=
 =?utf-8?B?ZUtZUG5VcHozSzhTVzh1Mi9PSWJjTS8wTTZEdm5iY1BlTFc0bWtNNFBOUmVY?=
 =?utf-8?B?bTF4OTJhT3hUdGYxS2NNNVRBOEp0YndZNTRaY0d5ck5iY3pBVVoxSFMrSWVn?=
 =?utf-8?B?SHBHSVJLdWQwVDNYdy8weTNsTDRQNjR2WDZISVJNU3VpcXVTU1VjakZ3Skxk?=
 =?utf-8?B?L2lrbmd3S1JXcGMrUjUrQ25XSFoyOXJUemp6STNSS0NxSlMzV25hWlBxM1la?=
 =?utf-8?Q?23yOT9cybXobGnBELHC9sOqJ2?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b6ac3f-90a2-4307-8781-08db447460c4
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 03:31:23.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rocNyCziSdt/l5W20/ITchZ9bmItbU+TvNEg14Z05YKxinXTNIdm6Q4CCFMOAFmK7AkUlGBmPNBFXnLY5uMZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR08MB7121
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug and Fei,

Thank you for this additional information, and your continued patience
with my many questions :)

On Thu, Apr 20, 2023 at 04:13:37PM +0800, Fei Shao wrote:
> Hi,
> 
> On Wed, Apr 19, 2023 at 11:41 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Apr 19, 2023 at 8:18 AM Jeff LaBundy <jeff@labundy.com> wrote:
> > >
> > > Hi Doug and Fei,
> > >
> > > Thank you for the informative discussion; I can empathize with the pain
> > > these issues bring.
> > >
> > > On Wed, Apr 19, 2023 at 07:38:13AM -0700, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Wed, Apr 19, 2023 at 3:44 AM Fei Shao <fshao@chromium.org> wrote:
> > > > >
> > > > > Hi Jeff,
> > > > >
> > > > > On Wed, Apr 19, 2023 at 8:21 AM Jeff LaBundy <jeff@labundy.com> wrote:
> > > > > >
> > > > > > Hi Fei,
> > > > > >
> > > > > > On Tue, Apr 18, 2023 at 08:49:51PM +0800, Fei Shao wrote:
> > > > > > > We observed that on Chromebook device Steelix, if Goodix GT7375P
> > > > > > > touchscreen is powered in suspend (because, for example, it connects to
> > > > > > > an always-on regulator) and with the reset GPIO asserted, it will
> > > > > > > introduce about 14mW power leakage.
> > > > > > >
> > > > > > > This property is used to indicate that the touchscreen is powered in
> > > > > > > suspend. If it's set, the driver will stop asserting the reset GPIO in
> > > > > > > power-down, and it will do it in power-up instead to ensure that the
> > > > > > > state is always reset after resuming.
> > > > > > >
> > > > > > > Signed-off-by: Fei Shao <fshao@chromium.org>
> > > > > > > ---
> > > > > >
> > > > > > This is an interesting problem; were you able to root-cause why the silicon
> > > > > > exhibits this behavior? Simply asserting reset should not cause it to draw
> > > > > > additional power, let alone 14 mW. This almost sounds like a back-powering
> > > > > > problem during suspend.
> > > > > >
> > > > > There was a fix for this behavior before so I didn't dig into it on
> > > > > the silicon side.
> > > > > I can ask internally and see if we can have Goodix to confirm this is
> > > > > a known HW erratum.
> > > >
> > > > Certainly it doesn't hurt to check, but it's not really that shocking
> > > > to me that asserting reset could cause a power draw on some hardware.
> > > > Reset puts hardware into a default state and that's not necessarily
> > > > low power. I guess ideally hardware would act like it's "off" when
> > > > reset is asserted and then then init to the default state on the edge
> > > > as reset was deasserted, but I not all hardware is designed in an
> > > > ideal way.
> > >
> > > While that is true in theory, I have never, ever seen that to be the case
> > > when there is not some other underlying problem.
> > >
> > > What I have seen, however, is that asserting reset actually causes the GPIO
> > > to sink current from some other supply and through the IC. I loosely suspect
> > > that if you probe the IC's rails and digital I/O during the failure condition,
> > > you may find one of them resting at some mid-rail voltage or diode drop. It
> > > seems you have a similar suspicion.
> > >
> 
> I reached out to our EE with your thoughts.
> He said that he understands the concern, but this doesn't apply in our
> schematics because there's only one supply.
> Also he simulated a few scenarios that could explain the
> back-powering, but none of them is possible without having the
> problematic circuit/rsense layout from within the IC itself.
> 
> > > In that case, it may mean that some other supply in the system should actually
> > > be kept on, or that supplies are being brought down out of order. In which
> > > case, the solution should actually be a patch to the affected platform(s) dts
> > > and not the mainline driver.
> >
> > I agree that it's a bandaid, but I'm not hopeful that a better
> > solution will be found.
> >
> > Specifically, I'd expect a current leak in the system when you turn a
> > supply off and then assert a GPIO high. That's when the device can
> > start backpowering itself from a GPIO. In this case, it's the
> > opposite. We're keeping the supply on and asserting the (active low)
> > reset GPIO to cause the higher power draw. In another design it was
> > confirmed that the power draw went away when we were able to turn the
> > regulator off (but still keep the active low reset GPIO asserted).
> > We've also confirmed that power is good if we keep the supply on and
> > _don't_ assert the reset GPIO. Both of these two experiments provide
> > some evidence that the system is configured properly and we're not
> > backpowering something.

Back-powering can come in two forms:

1. The one you've described, which is by far the most common. As you mention,
it is not the case here since the issue happens only when we drive the GPIO
low and not high.

2. Through a forbidden power supply sequence, an input pin of an IC with
multiple power supplies becomes a weak power supply itself. Grounding the
GPIO then sinks current into the SoC.

This problem smelled like (2), especially since asserting the GPIO or powering
down the supply alleviates the symptom. Most Goodix controllers I've worked
with have two or more supplies, and the datasheet requires them to be enabled
or disabled in a specific order.

Based on Fei's feedback, however, this IC does not seem to be one of those
since there is reportedly only a single rail. I guess either vdd or vddio is
tied to a dummy regulator? If so, then perhaps we can scratch this theory.

> >
> > I guess I should revise the above, though. I could believe that there
> > is a current leak but on the touchscreen controller board itself,
> > which is a black box to us. I have certainly been involved in products
> > in the past where the default state of the system at reset caused a
> > minor current leak (I remember an EE telling me that as soon as
> > software started running I should quickly change the direction of a
> > GPIO) and it wouldn't shock me if the touchscreen controller board had
> > a problem like this. If there is a problem like this on the
> > touchscreen controller board there's not much we can do to workaround
> > it.
> >
> > Unfortunately, if the problem ends up needing a hardware change to fix
> > more correctly (which I suspect it does), our hands are tied a bit.
> > This is not prototype hardware but is final hardware.

Fair enough, I was simply sketpical that this was the _right_ workaround.
Were this an issue of only supply A left on yet the IC datasheet requires
supply B to remain on if supply A is on, I would rather see this solved by
updating a regulator dts node, trusted FW sequence, etc.

> >
> > I guess one further note is that, at least on the project I was
> > involved in that had a similar problem, folks in China did a bunch of
> > analysis on this and went as far as adding an extra regulator to the
> > main board schematic to "fix" it. Had the issue just been something
> > where we were misconfiguing GPIOs or leaving a regulator in the wrong
> > state then they (probably) would have identified it rather than
> > spinning the board.
> 
> Thank you Doug for providing the details and explanation, and sorry
> that I also missed your original reply...
> I only considered the ideal scenarios for the always_on usage but not
> the cases you brought up. The concerns make sense to me.
> 
> I'm still awaiting the response from Goodix, but +1 that if it turns
> out to be a GT7375P hw issue, we're not able to do much about that
> except relying on the driver workaround.
> One more note I want to add is that the first attempt of the fix was
> added ~2yrs ago, so it's not an one-off on a particular platform, plus
> `sc7180-trogdor-homestar` and `mt8186-corsola-steelix` are two
> different designs come from two different teams, but they ended up
> with the same symptom.
> With that said, I think we have more confidence to say it's a
> component misbehavior, and we just fell into the edge case that was
> not covered or considered by its design.

Thanks for your due diligence; if this really is a silicon issue, then
the driver should indeed accommodate it.

That being said, the name 'powered-in-suspend' seems a bit conflated. We
should not be duplicating regulator policy in this driver; the existing
naming also may cause confusion for other HW configurations that do leave
vdd and vddio on during suspend, but don't have this problem.

Here, we actually mean to control the behavior of the reset GPIO through
suspend and therefore something like 'goodix,no-reset-during-suspend' is
closer to what I understand us to intend to do. I will add more details
in patch [2/2].

> 
> Regards,
> Fei
> 
> >
> > -Doug

Kind regards,
Jeff LaBundy
