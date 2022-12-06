Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762EB643B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiLFDA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 22:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiLFDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 22:00:21 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F425C4C;
        Mon,  5 Dec 2022 19:00:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuEo6quRC7xSwqa7JMMQ9JxhXh9bCtvRkXQcb4B7gbDv5VZkWr7nCU+K2pSymgoMSnK78OgtG2V/OeROpD+jmepPd4KylaR3/1B9GVe2KEWjuWCB+pxot/XtixlzzyDMu7SDU1rPs5NExD5afjL0yUF2Yvx81y0dLDs8gN8xuqz9/oHF1RGhSkgtSEZ+1tUrQsoSYhqw1+W5lebJjbFmQ+TIJHhzDohXoqpMDZs0defciewl+1lQZ0SMFKuycfTtQp6x8w86UAPrRQeKdi8Luy7VGsLJTbvoVR7ikfLIMaddhPdOsAnwJfDGcz3P/VQSdmkNG+Ywh4QSjQFKtbtKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juWqf7nEt/Q1I7riLid9xBLM4l/YfoSJNadP9QUktA8=;
 b=muXQcv5kGlZzjdNRSHzQOHYFUaeLfe99po1qHoAXMhK+x0G4b6fq0WdYXqAsQJSUrMyuH6fWww+4+r+TBHgX1/jotnA3jFjMCnm0/XhTHxwuFgaPb9mEAUdDE984qn2mH9el6ZmAaMl2qnUGkKdPe+UARq3shSdL4GvlvZQdUZboWW5TAyfGs5DhWWr1Yyxm7mY6uqUTLeNRTFfmw6mLI4FxAed6r7uwerQRk9rTovRlCN6CoK8CHK4cPhoTlHQN0tQLY2HWuZ6rQPpifbOEwDHETFGg0u7Z4BVyPUaMCFN91imHY4BeCvBH/DRTfQCnqpkI/kgnt0tYD24Y5TksZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juWqf7nEt/Q1I7riLid9xBLM4l/YfoSJNadP9QUktA8=;
 b=GjNcnPMuwqgFfjmReVkWQcd1E6CLNj8uZqDP/UwJGv/aaA1gUY3CBFV0hm0NKt1uCxp11/ZgA3pvflhF6wNh5HsUtO3GNfZdhxzx92k9D8F5m0cU1oBmRk5vM5zMgRtYflYyhcmASYygQ7qK7uwqNHHKqV1AJAS5Sm+BY0fCZ2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by MWHPR08MB3536.namprd08.prod.outlook.com
 (2603:10b6:301:66::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 03:00:14 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%4]) with mapi id 15.20.5880.013; Tue, 6 Dec 2022
 03:00:14 +0000
Date:   Mon, 5 Dec 2022 21:00:02 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH] Input: edt-ft5x06 - always do msleep(300) during
 initialization
Message-ID: <Y46wMrS7iN6yBsBf@nixie71>
References: <20221202105800.653982-1-linux@rasmusvillemoes.dk>
 <Y4pCtm4J3HWhYl8/@nixie71>
 <58ec9951-32d7-6967-3571-d18c667ae478@rasmusvillemoes.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ec9951-32d7-6967-3571-d18c667ae478@rasmusvillemoes.dk>
X-ClientProxiedBy: SA9PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:806:23::14) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|MWHPR08MB3536:EE_
X-MS-Office365-Filtering-Correlation-Id: 302c9a3a-7417-44d0-0906-08dad735ff70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pab3MGMlIMzwE+1C2ncjUYm2ONaDqcvdAOpqX7yfzL7TpYJNSN2gILqJ3s4bGzSZf6ITOpEwdTFi/RqiJqgudQ5fQbOCsQp20XKFllSAdqklEHZnD6nUeHwIOWwNL6xFyzaI8iGCJaCHwWlTnoo5Pj+TvmrGHC6MnFOtlV9v/5PCryJMgY0Aya88e0GVcIraHr9xbI+1/xUb7APZKbZrHO2ag4dlyx094BhJViLyRcQ4VcH2gQXepIXRjDNOy85hjOEMMYOmXaVh0Zlv35GcBQ3rb7RyoHs9msAyWmLq0aDfK9tHROkk3x5cy6PP7Qc/P51A7Le7CtaMHrOrLQPsUReZb6+UIjPFv9SAuX4MdW4vk8/mvimn4fteWhaX9Q35nMkGSZZHkYyKBCKmZvnLTOOtzNnOcnHWSP45aJrhYmHSN1uGanv+u25kGtxgJQ6HjjbW0PxueqLEO85hDqvdRr8+FLQuDm1eo3hqZTCSTi0Pc6goAnO9sVIKzdHVJ2g61H6lQfhmT9SFLM9l+/3ERMSvobfNVp4/10kZyx/z96ezpJkIFjmfIKIMPXnhEoIttzW7/LujzsQx6LUQcp+O3p28qshPvejtCGYh6SrOQQBP3P8ano02fnDriE0GY866nhE6PMYgc5X929uo2CxdFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(376002)(39830400003)(366004)(136003)(451199015)(2906002)(6486002)(186003)(6512007)(6666004)(26005)(9686003)(478600001)(6506007)(38100700002)(86362001)(33716001)(83380400001)(4326008)(8936002)(66899015)(66476007)(8676002)(66946007)(41300700001)(66556008)(5660300002)(6916009)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IcswwBbvv9qjDOG7QtYtS/Rp6n/V9hdc0QMKc3CiJfsrNQ8sH4PytfMW7jjy?=
 =?us-ascii?Q?NIiirvztf64yXZvtkWchmYeV9/jX3g3JrOA8t8ZzKoFcIKcFgd+C6hR1bRjb?=
 =?us-ascii?Q?UnevkvkbO4jjq12/Z4Vner8SefBeORn3L9DJMlmAvGvKpSzuo1s6eg4Kt2/x?=
 =?us-ascii?Q?45khYhlii3ddrlOQ/lN0ovkGd0/JIaznjJv3AEUv8Js9r7HSnRon4p4B624L?=
 =?us-ascii?Q?hLdVmOacTpswd8CztF0fezbVGBgcYtUyfuZLVpTLwwFrrI7Wn9+bfRh/xK2s?=
 =?us-ascii?Q?IRLlFMOquW5zndwQMiMwL5vFOW1aN2IryW6F6iWs7pa8/ovp7xH1KTa/maFx?=
 =?us-ascii?Q?PD2ljW+t0dzT1QzP0axa+RxNTZWfh5SR7v8VhTF52jcMNr04pi8F/fDHYAZu?=
 =?us-ascii?Q?yiIso+Fj9tC8THRo74ZVQJdjzXNm/MDU85jp/FmS1a+pxKFZaS0Abw5r4Gga?=
 =?us-ascii?Q?8HDJuNybIVkNqN23Oy8OSaeLzbf1kW+zd7iCeGOZHCB+IYd3xFu3wCTlBidR?=
 =?us-ascii?Q?MSnPbzapJDZm4dR+5E961J7Lnucml6qraDv17DzkpCt1bk5+vW5+loFk/Na9?=
 =?us-ascii?Q?y65bMAPNTbE/nR/L9v8N2VSZbNGr+aE/KnzP7qfIp2i4l3K7HMWa4IZ6xdnh?=
 =?us-ascii?Q?12Z3/JKYFCWz+q8LZJsItX2cts/tsjFgIXAdsLGDMZ7EZxhWY7/evkDitqB2?=
 =?us-ascii?Q?GR5IHhz7tGZ1r+zJ2ABZ1Vvvxt4yDcXmScl/h41/r7Qo7VEneq6ruaSuVjdQ?=
 =?us-ascii?Q?7ACLLiXgZb3WqF9/ffClLlLNiSuNJ2+70PYE2n+hCbfMVDG32aBAoyZL/Oxg?=
 =?us-ascii?Q?fnH7DJ7O4rJR5+sMGXBReEIYbolH5v3OaJ/r0MVwPHnsw2T4swvLVpfrHj9o?=
 =?us-ascii?Q?LxaTOmXu/r7b/cSEmgAtasWlk/910i9+8NivPDG6W3vJCACwBAl4hHv/hZsd?=
 =?us-ascii?Q?Yw4gFhHXadLN0qoU4Ib+d2cKTEsBb3SLjkKSzGvDA22W2aBzAB+nqAi0IHxI?=
 =?us-ascii?Q?j1U5Lm0raF8cf29VTE1aci0JgilvwiPwN4RxKwNON5d14uP52TjwkSxZZVjs?=
 =?us-ascii?Q?kUbmEBJ5o5Mtt0xSneHYqYLJND7zEsfTJKck7zp9lOdE3hDCU0fXj7n93BEg?=
 =?us-ascii?Q?8IpGp4ChhTwD/w+kn0o9MlQ4IgsrBT0xnVvfZML+up1n0xT5cMWH5XysjaIJ?=
 =?us-ascii?Q?W4y3Whwf43jA6u0VAC3VsZUJX7Ikzyq93qgMUh8n7U/OfdXtJ8S7C5cVJAhG?=
 =?us-ascii?Q?aYgYnILhM6abm2Vnw2pSr5tQFd+vtT+k6blqk6xh8JJhnXtPfrgzwVgPEaOg?=
 =?us-ascii?Q?5COTRAbX7ZUe/1KG1PZxmxgXWwtHCGPW/Yjv4O2N0d+BiDaEWefuHaoMUrZC?=
 =?us-ascii?Q?vwi5OJvFjjjEEeCmpyFlYFG+ZbapRrp4PrVMYRqTuK+Dex2KllCliLuuKglZ?=
 =?us-ascii?Q?3kHDHnC0RsCqW2M6+41TmKfbPsymXjmFelkT348bUwMIoLQIXO7T0aQYWv9E?=
 =?us-ascii?Q?xpy40KrVqqXZqdNPB+si4vhoUiHQHZtyNszLA5Q+9DFNwiIqxxaQyGVwvGOv?=
 =?us-ascii?Q?kqxlVfcpddcx/lvgRits0YftL64nEkEvk5efOCR4?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302c9a3a-7417-44d0-0906-08dad735ff70
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 03:00:14.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4hIMTOmobBXx5ZUAaXwtJ/Y4+eOabHvedLs7WT7cEqVpZAXpaySbTUrsTGK2A0yQVYcct8SwGNdS+TDKGg6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR08MB3536
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Mon, Dec 05, 2022 at 09:59:08AM +0100, Rasmus Villemoes wrote:
> On 02/12/2022 19.23, Jeff LaBundy wrote:
> > + Mark
> > 
> > Hi Rasmus,
> > 
> > On Fri, Dec 02, 2022 at 11:57:59AM +0100, Rasmus Villemoes wrote:
> >> We have a board with an FT5446, which is close enough to a
> >> FT5506 (i.e. it also supports up to 10 touch points and has similar
> >> register layout) for this driver to work. However, on our board the
> >> iovcc and vcc regulators are indeed controllable (so not always-on),
> >> but there is no reset or wakeup gpio hooked up.
> >>
> >> Without a large enough delay between the regulator_enable() calls and
> >> edt_ft5x06_ts_identify(), the first edt_ft5x06_ts_readwrite() call
> >> fails with -ENXIO and thus the device fails to probe. So
> >> unconditionally do an mdelay(300) instead of only when a reset-gpio is
> >> present.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > 
> > This is just my $.02, but it does not seem we are on the correct path
> > here. 300 ms sounds more like bulk capacitor charge time rather than
> > anything to do with this specific IC; is that a reasonable assumption?
> > 
> > Normally, we want to do the following:
> > 
> > 1. Enable regulator
> > 2. Wait for voltage rail to stabilize (RC time constant)
> > 3. Wait for any applicable POR delay (IC datasheet)
> > 4. Deassert reset
> > 5. Wait for any applicable reset delay (IC datasheet)
> > 6. Start communication
> > 
> > Here we are dealing with step (2), 
> 
> Nope, we are really essentially dealing with step 5, even if there's no
> reset gpio that we've flipped around. The data sheet says to wait 200 ms
> (and I don't know why the driver does 300, perhaps there's some other
> chip in the family with that value, or perhaps it was just a
> belt-and-suspenders choice) after releasing reset. It's just that
> "releasing reset" is, in my case, effectively happens at the same time
> as the regulators are enabled.
> 
> I also played around with some smaller values. As I wrote, with no
> delay, I would get -ENXIO, but with both 50 and 100, the chip would
> "respond", but the values were essentially garbage (and not reproducible
> from one boot to the next). So even if it's a rather long time, it most
> definitely is a hard requirement to wait that long - perhaps we could
> make it 200, but I'd rather not reduce that time when I don't know if
> other variants have that 300 as a requirement.
> 
> Even if we could interrogate the regulator and ask it if "are you
> actually always-on", I'd rather not make the delay conditional on that;
> we cannot know if it has been on for 300+ ms, and since the device does
> respond, but not correctly, we could end up with probing and
> initializing the device, but in a wrong state. That's a recipe for
> impossible debugging (add a single printk somewhere earlier and the
> timing changes so that suddenly it gets initialized correctly...).

Thank you for these additional details, especially with my having taken
us on a tangent :) Perhaps the controller requires so much time because
it is loading firmware internally. Based on this information, the patch
seems reasonable to me.

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

That being said, I like Dmitry's idea but realize it's out of scope for
this particular issue.

> 
> Rasmus
> 

Kind regards,
Jeff LaBundy
