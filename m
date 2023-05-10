Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910686FDF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbjEJN4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbjEJN4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:56:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FF2DC54;
        Wed, 10 May 2023 06:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QluIfmWbwXkxmrH3Fld3ztxWATQdSIQsiF+DKFTGJ+H6ovIQKcPoFkFqOb0/6sNIjWglh7ydmPSCplWQiFB/F+WBFOfUOAcViAldWOu5oi4bETSM+tGHq+/h8GgFekqo7rIgojaXYVY731OJQ2JhjJYpZpnkHFChTR5RSPxAkGql4J2Hm8AGUjNgaQUi2Cni1gWHZcBzvhBeFgoaONAQj5L15XVGD2GgcV6KCOwy5nZ+l/ocuEVpelUHcfButddcYhuUQuOhbF4mepNc7YmjHr30ttKzTcqFRSP/mx29Rhiga/RTFt7gBJ+N/u1MQcNZZA/kO9cTrM34NzBgM73JKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9i6Jq/Fa6MsRVT8VN/Ihc0U5PcjzZiOXCJJKMsazZiY=;
 b=aGX8ip3c2/SB8Q2I9g+sGUgsUhgFQLocZRGZHoR1sPGeiyPespnOi924TwrIXlCv/hzezRI1fzOHGd7zoYH3NIH09vCLojIfwNPiPA0t1r+CsyBrzTf5aWtQ+dJd71RrMxh/+KwcjD8ErIbWk8ccnddp3ugmkkfObcgtxEEx8BLu5bvTv89XcuL5r3J+ubRXH2+w1SsPgrzmrG/pm2WcCmsbUljM/GF4JjJTe8VFaKiIIxX3myM22qqvGge/MRFP0JSJrL5lO3dRWt3EyJSfw0yQq3WSuKqupzivXDuYPxcgNXVFPAR9vCha3a/kInpDobCrnqT81RL352K3Rk6Chw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9i6Jq/Fa6MsRVT8VN/Ihc0U5PcjzZiOXCJJKMsazZiY=;
 b=spa8zYtmXAlNjNg3ZXOJbmmv6WIM3Og9uzPaiL5lY1E02v+onZzU/zG7BA1d0XudvDGEDtwkGlVyQhD+lGuGaUdzVj1JchhHiXF/nYedTYZ5WBdyT3HQEFm6K5zA3essqLpe8NBVjFMcTAcNnHe2eyjOiGACAvKopsUEwrLMDik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA1PR08MB7150.namprd08.prod.outlook.com
 (2603:10b6:806:1a5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34; Wed, 10 May
 2023 13:55:31 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 13:55:30 +0000
Date:   Wed, 10 May 2023 08:55:21 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Fred Treven <Fred.Treven@cirrus.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        James Ogletree <James.Ogletree@cirrus.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] Input: cs40l26: Support for CS40L26 Boosted Haptic
 Amplifier
Message-ID: <ZFuiSQ7XyFJB8PwE@nixie71>
References: <ZDI0p5Rkp74SzJCv@nixie71>
 <20230410085634.GV68926@ediswmail.ad.cirrus.com>
 <ZDSqfHemG8pKj1k7@nixie71>
 <20230411092708.GX68926@ediswmail.ad.cirrus.com>
 <ZDYakQMOPsPTbGe0@nixie71>
 <6ABC85BA-AF2D-4D2E-8CA8-32E372570DA0@cirrus.com>
 <ZDsPGYJjCNmtizKk@nixie71>
 <7E101F4B-782A-4B8B-B6AB-3E7E282C9A9C@cirrus.com>
 <ZFa42bBbX+SDuoXg@nixie71>
 <20230509102257.GG68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230509102257.GG68926@ediswmail.ad.cirrus.com>
X-ClientProxiedBy: DM6PR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:5:174::13) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA1PR08MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 2975f6df-4722-4352-e9d6-08db515e37b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRTU8xqjQ4kxLZ2E5bVJ66KLpxW/N5LBrSc78pCtl7NQgcb+eCsi28NYRb/fxCOt06ndHDiFUP3w2M9DZXlddmyIoizL/g0SpGzoGKmgGujgtUq+HhFeTbLRufizVQTz2IlIrlhrzBhiA3CMs8jag7AquM+SdZID7ct0ZA+mapqrD6gvRVwwKyuUmpqKkvMHMvTMl5RrSsRdT2vK0S4ZPPG0hTsDqfLtVZ/uJY1AMcf0YRcriY1hdw/Z7HaLxaCIMd4p8iEC+SPEEv+DfbHQF+ZChasjBl8H5mMewmLty7wax05iLl+YR2LBrLTEUKp5LEcDCbZ5jw/TqfhciQUG+oBw+Pv1I+TftOJxwnS5TLep6mRczB5lhUe47R+F54wNA0oNEh3RUPbIHCPFrOQYE8Rnm7fQI7vDnsF8HdiMnNCvu+zDJu+WSVX1o5eC6NeB+c1llStTSg3Xnu8UsDKMxNxLwSh91Esgv1fs5EXQGHU1/jG6xjOaIwFDpk78LgWdyjt6ReJhGl1ylELzuKS0sE/VKLnhos4UAAB4UanMYHqCUI2GHXlDf9JFwVrjNrug
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(376002)(396003)(346002)(136003)(366004)(451199021)(186003)(8936002)(8676002)(66899021)(38100700002)(6486002)(33716001)(6666004)(26005)(9686003)(6512007)(6506007)(2906002)(5660300002)(7416002)(316002)(478600001)(66476007)(6916009)(66556008)(83380400001)(66946007)(4326008)(54906003)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU55bmR3N1R0enkxVW5Kek53VDd1bnFoQ2NBRVIvVUlTUVJibzZaQWhIelpY?=
 =?utf-8?B?aVN4TUd2T1hmZVBzTHdBZ1hTNjVUTEgzSkNjOWdWSDg4SlRYTytmRHVsZTg3?=
 =?utf-8?B?N096OEpVYjdSNHJzMzBGVDd1OW1pTEtFK1R6STY0Qlp6cHVkSlpCWForTFpa?=
 =?utf-8?B?czQremt5Uk1RTFhQZCtoOE5vVmJjTTZuV2gzT2RvSlExSG9oWWpRaEl2MUx3?=
 =?utf-8?B?YUVMbzIxZFF6ekdEYm54RVQ2Q2poRFBiQ2RnWDN0ZS81ZlFOaG9aTVZjTW9u?=
 =?utf-8?B?Y0hJRUlFTEZrYlQ5ZzNmVXlnZm9NdU1wVFhBOWRBUERQN1Q1K2pkMDdpTUV1?=
 =?utf-8?B?ZVBCZzhudHpJcmtnUERDZERNeEJaUHVUdFVLZHJmcVBsamY5dVJBNkgyYlF4?=
 =?utf-8?B?VWRFUU5HcmJCdDVOTUw3a0xOWmVHdXljNERjUTQ4eXBJczNkaWx6M2U4UVkx?=
 =?utf-8?B?eUFtY2RKejlabzB3RDc5WWZWOUtXUmpiL3A2UDVWaUlhQlFiNitVdmJBT3RR?=
 =?utf-8?B?RjYwRU1YUnRsWWJ1bi9zdUdzYmp1WG16b2h5YXVUaTh3cVV4ZXcxR0NtQW5z?=
 =?utf-8?B?aG84WlNuRllGczVWaE5TaCtBbHNOSGxHQjlhT1l6TkZ4UDljMXpXWlROYVpX?=
 =?utf-8?B?TUdiZ1RCVXUrMmRrQlRKTFVsNVpDRGNPSGU0ajhFRkliREhBMmk3WFhVdllj?=
 =?utf-8?B?RDhidUZrRmNKblg0ZS8waWlsdG1ZV3lhN1V5S21KZ24vMkxoeHdvdHREYXdk?=
 =?utf-8?B?cVNwby9HM1lWb3JzRkpFalBvcnNlL08zRW9jbzE2NGhUcXVDRUh5NFlYbWRm?=
 =?utf-8?B?elZXNTl5azNjc3VpcEVBaElHY3hzZi8yQUd6MjROckhCdUhVaVJiU3E4L05D?=
 =?utf-8?B?c1JnUjVDM242OFQ5bTNtS2xiS0Vsai9qSDI5T2VEUnkxbThoeU9sa1RKRW5W?=
 =?utf-8?B?Y2xZdkM2b3dCOFZqcnZmWnpUUmJ6TWF4bHJtdjcweWpmOWQrVEJLd21iYVFU?=
 =?utf-8?B?aGpmTGNXWFV0OHIvS0Ixc05mV0N3Tjd2SGtFMC9kTnB3TldCb2Z5SHo2dk1r?=
 =?utf-8?B?M0JUQ1NKWEZQMTZUci9IZ1ZuQ1RtTURoUE56VXdianYzd0VRMVEyaVpJbkp4?=
 =?utf-8?B?SXpUdnZIQllQWW9vQ3psaW5MV2NpSTlLYVpoUkI1TmZwOTlCdXIxU3hVdGlK?=
 =?utf-8?B?SU1pMUFVMFppRXFCWkxjOEVqT0p2eHI5S1cxMExiSVpXYitUelo1R1Vka0la?=
 =?utf-8?B?VWJtZUhTZDhmSCsyZlZnOVhLMEJCWTd1LzViMmhIWEFXKzExcjkzVUM3ck5S?=
 =?utf-8?B?dkFpMjV6blNqdmtOQWpkU1haczU4TGpZMXpUdEtucXZrek5SRTdVdUZJKzNr?=
 =?utf-8?B?SDdRemQrZ0h3M2J0S1dNTkIxdzEwUStWcmpyN0ZuZHNrQkF6ODJZUnZWMndF?=
 =?utf-8?B?TG1aWkIrY0FuMStwN2hQa2dFYUc4OE4xSitXc3VmRTBuVDF3c0gwOUFLeEty?=
 =?utf-8?B?eFc2QnZTOHhycEttdi9GWDdrcnB2VDdKOERKTWRSZ25ReE4yR0lrY3h4MDh6?=
 =?utf-8?B?WUdtQ1g4SWJRTklzWisrZ1MwNldmbVZUK1pNODNDa2lpYlk3cXI0WFR0bHds?=
 =?utf-8?B?RFY5RTR2bWtHUjJmZDlZRUM3MVJoeTV6dVBhaE04M04yY1RoRWx5ZVhVUzlG?=
 =?utf-8?B?bUhpbHNQTkVHbkpjQmNrTXVreGV1SGNFMUNhc1lwcUZGWnVaclZieWlJOFpu?=
 =?utf-8?B?d0NnR01Fck1vdytFUVE5R1FYbHlPM0VSS1VMcXdibXFhb2JPQnJYZWxER3lo?=
 =?utf-8?B?UUFwZFUvWXk3emhDeWNsL0FnMDRIZWxRdHZnVkhTOEVKUWR4a2Z2cVIxR3Zi?=
 =?utf-8?B?anFoZXh1cmxCZGhYbEFMMWI2c3JhMmkyVytzTngrb3BsK2Q0U1MxVnVuN0hW?=
 =?utf-8?B?WTFrSEZUVEdSNmgxMGVhNGR4WWY1WHFXeU1GK0MvcWo1ajk2bGN2eStFZ2VW?=
 =?utf-8?B?dDRZbEdJQzh0NTFFZTRpUDZIS242UmhwYWFzQnNMbmt0QW1HenI4MldWNDV0?=
 =?utf-8?B?TG9lQTRVTzNDTXNSSXZhMmtMem5HdUV3TTR5RStWMm5rLzRKLzZITnlTd1BG?=
 =?utf-8?Q?/MXCE+vMugJKro2nZBFtounVM?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2975f6df-4722-4352-e9d6-08db515e37b8
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:55:30.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMoUW/N0xpDS/hmfRxh1n6hUkGXWz19FxzN26m0Q3zmWwMauHecHaFFGxHrhZqtRdmUmgceLQ6Efl16/CpErEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7150
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Tue, May 09, 2023 at 10:22:57AM +0000, Charles Keepax wrote:
> On Sat, May 06, 2023 at 03:30:17PM -0500, Jeff LaBundy wrote:
> > On Thu, May 04, 2023 at 09:51:37PM +0000, Fred Treven wrote:
> > > >> +const struct dev_pm_ops cs40l26_pm_ops = {
> > > >> + SET_RUNTIME_PM_OPS(cs40l26_suspend, cs40l26_resume, NULL)
> > > >> + SET_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend, cs40l26_sys_resume)
> > > >> + SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend_noirq, cs40l26_sys_resume_noirq)
> > > >> +};
> > > >> +EXPORT_SYMBOL_GPL(cs40l26_pm_ops);
> > > > 
> > > > Please use latest macros (e.g. DEFINE_SIMPLE_DEV_PM_OPS).
> > > 
> > > When looking at these *_PM_OPS* macros that replace the deprecated versions,
> > > it is unclear to me how to maintain support for *_sys_* and
> > > *_sys_*_noirq* functions. Would these all need to be separately defined
> > > via DEFINE_SIMPLE_DEV_PM_OPS?
> > > Would the *_sys_* definitions still be defined through a struct i.e.
> > > const struct dev_pm_ops cs40l26_sys_pm_ops which is then exported as it
> > > is in my initial submission? 
> > > I’m unsure how to handle these cases with the latest macros.
> > 
> > I don't happen to see macros for suspend_noirq and resume_noirq, so maybe you
> > cannot use macros here after all and will instead have to fall back to tacking
> > on __maybe_unused to these callbacks to accommodate the !CONFIG_PM case.
> > 
> 
> Correct this device can not presently use the simple macros.
> 
> > That being said, what are you ultimately trying to accomplish here with these
> > noirq variants? For example the print statement says "early resume" when in
> > fact a different callback exists for that (resume_early).
> > 
> > On that note, why to disable interrupts during system suspend? I can imagine a
> > use-case where a customer ties the output of a force sensor to a CS40L26 GPIO
> > for low-latency haptic trigger, and then the CS40L26 interrupt output to the
> > SoC as a wake-up trigger. Does the part not support this use-case? I vaguely
> > seem to remember an issue with this on L25.
> > 
> > Also, why is the logic inverted for the noirq variants? These are simply meant
> > to accommodate additional tasks that need a guarantee the device's interrupt
> > handler is not running (for example, clear or acknowledge a pending interrupt).
> > In case I have misunderstood the intent, please let me know.
> > 
> 
> This is a generic issue with devices that use PM runtime, but
> also have IRQs. The system suspend process re-enables IRQs before it
> re-enables the PM runtime. This means if your IRQ handler uses PM
> runtime and you get an IRQ in that window things don't work. The
> simplest solution is to disable IRQs across the window. Ideally
> one day this would probably get fixed in the PM core, but that is
> likely a massively non-trivial amount of work.
> 
> To be clear the code allows IRQs whilst in system suspend (aka wakes)
> and whilst resumed. As the IRQ output of the chip is level based, the
> temporary disable only causes a slight delay in handling the IRQ.

ACK, thanks for the clarification. A couple suggestions for you Fred:

1. Update the print statements in the noirq variants; currently they say
late/early when in fact these are separate callbacks that occur directly
before/after the noirq callbacks (unless you meant to use late/early)?

2. Consider some comments here to highlight that this driver relies upon
PM callbacks from its interrupt handler and hence disables them briefly
throughout suspend/resume to accommodate the order of operations mentioned
above.

> 
> > One last gripe, then I promise to stop bringing it up :) But the mental gymnastics
> > required to explain the no-fewer-than-six PM callbacks used here, as well as how
> > to support the !CONFIG_PM case, are in some ways additional nudges toward getting
> > rid of this massive amount of PM overhead and relying on the device's internal
> > power management as so many modern input devices now do. As a rule of thumb, if
> > you're having to jump through a lot of hoops to do simple things that others seem
> > to be doing with less work, something is wrong.
> > 
> 
> I am not sure there are significant issues supporting the
> !CONFIG_PM case, you need a couple __maybe_unused's. What issues
> are you expecting here? Yeah ok you get worse power consumption
> in that case, but you did turn off power management, presumably
> you were not that concerned about power consumption.

No concerns really, all I am saying is that in the decision whether to simplify
the driver and allow the DSP FW to naturally manage the device's power state, or
duplicate the logic in the driver and gain explicit control, the option for the
device to behave the same and save a few extra mW regardless of platform config
is one argument for the former (DSP FW).

> 
> > In your defense, however, you are unlikely to come across many devices that do
> > not enable CONFIG_PM given this device's target application. That being said, it
> > is not unheard of for OEMs building wall-powered devices to enable CONFIG_PM but
> > inhibit system suspend using a wake_lock because of some HW bug.
> > 
> 
> Again remember the system vs runtime suspend here. Holding a
> system wake lock will have no effect on the runtime PM.

Good call.

> 
> > Therefore, it seems a bit unfortunate that those use-cases wouldn't get to enjoy
> > the power savings this devices offers. That's just my $.02; I also understand
> > the reasons behind the current implementation and won't push you to change it.
> 
> The power savings from not blocking suspend are tiny, at least
> outwith the !CONFIG_PM case. The driver is only blocking hibernate
> when it is actively talking to the device, during which time the
> device will very likely not be hibernating anyway.
> 
> I think really it is up to Fred and Ben who are supporting the
> driver. If they feel the device will work reliably that way,
> I certainly won't stand in the way. But I would be keen to avoid
> a situation where all the downstream implementations (ie. most
> of the testing) use PM runtime and the upstream code is full of
> corner cases that haven't been ironed out, so I would like to
> know they are going to be moving our customers over to this new
> mode of operation if they decide to switch to it. Certainly you
> are not wrong that it would save a fair amount of code from the
> driver and make it look a lot cleaner.

Agreed; I would maintain parity with the battle-tested implementation that is out
in the wild.

> 
> Thanks,
> Charles

Kind regards,
Jeff LaBundy
