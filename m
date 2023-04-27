Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF3A6F08F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbjD0QBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjD0QBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:01:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AE82D72;
        Thu, 27 Apr 2023 09:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm/g/ngIRPYOaDVnf/wRMkXDTvyKL5vOEHRxo8rn2yUwuzJF4c7RkEMREbACe1h1K1h6cMdC1x5dGTXYpWr3KQDxzwW8PZeJEx/1CcoO7aQh496Da015k4T8bX7mQdhsPjQS0vdYXvDQCV3lKcRG743LtKeuEM912N2TYPVyXJX8yd1uFrDZCeXD0WP85GcxtO9YzqFhzI9tvuqGoAtZeWlRV4EfqhJIlztUUYvPyA7Fi1mPUgfxBGoRPLrW9nGBa7JwmCF+U7Gl308V8Y/RoVkRAnRSnSpUaijwA5qcQbzXwqUBFL3z2H2RkmU6mmTUsy8dCudZrZb0g3VncNsVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcGXvQ4r6kMMFWNGnOkgRF1P77lzVKBEEfj4TR/6kdY=;
 b=oTcHU1JbnJfVqlyIHdri7V+UvLnW95WSqlylGyxxcrKMDXLF8r08atB9DMip92opAF67I0oS4blC86KOqcP3q4hxuooeb3tLcsgujOgtbX0q98dafqPGQX49BDUdtOQh+JHtOrtUxoAo7yKYdY+/aJ8T8HcnvbF7dKYHHbKMdoyfBAh/5V1Ey0J9+F8yOlSlzkeuGmZglFYJcFxHRw7J/Ys+oe/I+X0QoBF3dyhgjIDrT4HpotyjIfbRdOMZmlQOP/86EcdjUj2YSSxsFMHNOyNZPXiTmBoxj+lAmQdJll1qey28gVTFMsO7AiEDmGzcGjrCGUbewHg2p9xGzyooIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcGXvQ4r6kMMFWNGnOkgRF1P77lzVKBEEfj4TR/6kdY=;
 b=fsTbR1ZVrDz8ghMU6D1aPcatx51yRyIhsgRw5i9rK3fQQH/XVKwmiMio1yHWpJW9hk6BQsBGYmGvI+BeUb/X9M40f7udh2VBMI4BtPNmQ0451Wb6rbzEaiNQePT6+9gh7pQb/zuirvahA2j3IkirDp2sGxJFTJGWtZo7ba626XGmam/FzB93sw8Zv+VB0VEnno6H7FuWA2gMkpvRNGTY24Wx7VSm/06icTzl3KcNmKHkLsoF4uPwDk+OlDx6U22jsLZEyC66us66JaESQcP4RABHnLxyHCpymvRM9c2UKvwY/mVOJmX1xevdL6cewVjHtRo1WDyjilVPlmHcxdGE+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PAXPR10MB5733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Thu, 27 Apr
 2023 16:01:02 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9cd:f02a:9a74:b797]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9cd:f02a:9a74:b797%4]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 16:01:02 +0000
Date:   Thu, 27 Apr 2023 18:00:53 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Simon Guinot <simon.guinot@sequanux.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>
Subject: Re: [PATCH 1/1] gpio-f7188x: fix pin count on nct6116d bank 7
Message-ID: <20230427180053.512864e2@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230427112106.697dd352@md1za8fc.ad001.siemens.net>
References: <20230425153911.32135-1-henning.schild@siemens.com>
        <20230425153911.32135-2-henning.schild@siemens.com>
        <ZEoydXMDRONgbhY8@76cbfcf04d45>
        <20230427112106.697dd352@md1za8fc.ad001.siemens.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PAXPR10MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed17cf9-59f2-40fc-0681-08db47389932
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFjRIW2p+7WNjH6HIkoJHL1dXgUr4oG+dcwl5xOIYqlS3wkcR5tpBjev20mQnPfM8jWQUTtLk8qY564A4JmfBrWWrYHQB/cu6abs4I83HBAFSyFYaFzwbrSsiMwBJU2MoXdNzHRBkqCe6QmpALRmwtXiOaaOydBnwj3pFmyfAwyK8RXA9sPzwCVfNbg4/QZElXS1Kuoskf2XzwfAt8jAp6H1RZbuXHpnpcSZ1sp55jrgHn9nELyhi6fUzoFSVZKJ4C+NxHy2YBXnJC1qp/URnbfIruOAlGtPbUS9RrNWo/9ypli/7m2eWOhC+6zC4fOV7b4ePjF/PqfifeZEI8vQohf2MfvSC13PYeSEE9T5TmXUERUr0hbPfPmolUZ6uKjWiY/AyEYZnyW/t6frVYW3XrSawDOn3X6lnoBXHK4o6jiFyRanK5OXbrVV41aoq48YpYFHfrWWy3zSOPKfYQ7uvBxn0wQkSoqeAyZtXW3PzWScWG4vNjaRTfUCw41DcPijw+DiCQMOyxhdmqnz6ffsCE/oc5lC9L2QIoCs+RtUQ9CM2EcXGw8B2JLD1w1XzkZS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(86362001)(186003)(6506007)(9686003)(26005)(6512007)(5660300002)(38100700002)(1076003)(15650500001)(6486002)(107886003)(6666004)(83380400001)(478600001)(66899021)(54906003)(44832011)(41300700001)(2906002)(8676002)(8936002)(82960400001)(316002)(66556008)(66476007)(6916009)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VsTTqwiT1UkkadTttZck34Rfu7VLhnR+AwsUkxKbawlrxLuMTDfGhJLAZEPv?=
 =?us-ascii?Q?Fs9+BrlMgWxHu3qQoYRkFuAyGT8nQ6LjM3JDM70d/OBYjagAWtgeqUyXTIlD?=
 =?us-ascii?Q?AIu1Uw/0VC+c9zt38YaP0+X0CspKdTEqIoAXbPX0a5mwtHwxePYVlgJDdsLp?=
 =?us-ascii?Q?tz4B58J79qY0Is0v2uQVq4E5eFf1g0hgc7ehI5G72MZriHdC0aFUWy3KFFgm?=
 =?us-ascii?Q?ZAbJ1oJUTekH7DDW5c3E7JkYHnHbbrVD1FTDEGczrRafhljj/aBD9oCyxGuO?=
 =?us-ascii?Q?R005idXJkykliuDpjLCeietH1BPs+PdZ2N2Z+UVY4g+DxVcteEt6OiKEQ68j?=
 =?us-ascii?Q?sKOdIS6jr1j7HEaKWbBLoFX+0umpvuwUBIxj0ngIoi9OP/FJIQETm933AsQB?=
 =?us-ascii?Q?0RBhznxlGLidyHEtGBZSbo7CGdqvW/UYh+FWfiY/MPRirEOsjaeMzkJmKFNq?=
 =?us-ascii?Q?nYH3Rxn0eXx8UWPPOy8OlwuVD/ahAVBVtyEWQC94q17NGFPx86/9UDiuYmSj?=
 =?us-ascii?Q?VqYHIp/luuqN/xYlr7seZ/uFIlEBrahZlftkr5PLWXfGAm6qAHDNWs8APUwi?=
 =?us-ascii?Q?Rt4p34M9lIZmEutLY5mlpnlcfj9ojpoG/Cs5n2nYPGLygkcjZ92PCObeIbN4?=
 =?us-ascii?Q?VoHuiuCvRJ790PSyzk5JobmPT46Lg4K17oJM8lNSUhJVL+wJ1wmEdRfYJe0J?=
 =?us-ascii?Q?6rTax714fp7Ie5N1wBwp3kCOtqB6HLDtwAKJ9v/3aqcjPPcWx3kQGAG6wzGY?=
 =?us-ascii?Q?43r3/kOm5H53dtx3K2Qe6XyqJcW5/jzELQwMJeFPkKmNYi2NE3WwXS8tZL3y?=
 =?us-ascii?Q?D7I4gEqM9pTQCmlBscfbzkE//FO8fhhPMVZ6/VJytBolVu16UgxVZrfVQlqK?=
 =?us-ascii?Q?fX4tkRxFM6WjlLhy5Nbrrga9sWYPOx460GQ86ZsK4jAYCXxzV90xgIyPpaOK?=
 =?us-ascii?Q?GhdjdQp7cPLRw7C4Yg+F5khf2vwS67VldiXsnen+Elaa/LxhRXZYJPuejFMm?=
 =?us-ascii?Q?qW9Xe09yWG6lSuCSYWVbG5+hBY+ZbRvLNqmxWC+lzqsL1qfJ6+5fKEpI1TWp?=
 =?us-ascii?Q?iccMkA9l6fOio3kHAuQlMKdjOfFzInT3x5zN76bVPodiE6cwz16CF9EoFcHT?=
 =?us-ascii?Q?TSerIBuOFZxt65NZZAidZirk1of4lAUNiBbtgQazyz166elqclKW83Qx763j?=
 =?us-ascii?Q?9co8OjaoDEgHyTWa34vdo/natToUc28/7SIfQExnV1zX7VqyfEq6fNhlgLAO?=
 =?us-ascii?Q?36adkR9L+orZVoDX9eCkGPVjGndLJCJi+kvCSx7wBb8wGuYmNyAqy62wBq57?=
 =?us-ascii?Q?Ujb7fKXb+P30jVjt3HnVO8DsoIMSUJc1JSHykpMWukiSH2AlitVJbhzXV74T?=
 =?us-ascii?Q?J/BTq586yx8pOSE2gZcv60cLY4Ozyptv5pY9v6ngKgFyQTYzNeOBDBIMIVuT?=
 =?us-ascii?Q?sMdibYld9/jtbxHEBtZquxSApirSHuL9i6KmQAmc+sdZ6CDCeISOthqrElOg?=
 =?us-ascii?Q?KUAqVrFm0D3eD5GwTLAPzyNu+RVEy++RB0Bfnz2zE2FC5U3blv4VUbvPihVL?=
 =?us-ascii?Q?+00St19oGJuiTOljH9n02x4ouGIPpgiF6Abf2KsIhX6e7aP0q4ZVuHOafOfb?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed17cf9-59f2-40fc-0681-08db47389932
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 16:01:02.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pezoLWS1Vz5smMZjJZL66BeW1WKkt3a6iUb6G6t/8uoZoZRwgJLlBIIpnc062JveVlotuhVrEojhsGPXTbUQ+eNU+ja/2v38qsgBG5VcM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 27 Apr 2023 11:21:06 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Thu, 27 Apr 2023 10:29:41 +0200
> schrieb Simon Guinot <simon.guinot@sequanux.org>:
> 
> > On Tue, Apr 25, 2023 at 05:39:11PM +0200, Henning Schild wrote:  
> > > The count was wrong because i looked at the wrong spec for the
> > > chip in question. I now got access to the spec for that very chip
> > > and group7 has all 8 pins, just like the other groups.    
> > 
> > Did you use the NCT6102D / NCT6106D datasheet in a first place ?  
> 
> I do not remember which one, but one of the few one could find online.
> Now i have datasheets for two chips directly from the vendor, both
> files not publicly available and i am afraid i can not share.
> 
> > If the only difference with NCT6116D is the number of pins on port
> > GPIO-7, then maybe we should handle it and claim support for this
> > models as well ?  
> 
> Please hold this patch back until i confirm again. It might be that i
> got the model name wrong as well and might have to fix some strings. I
> basically started my journey with a preliminary driver i got from
> Nuvoton, which maybe made me think i was looking at a NCT6116D while i
> was not.

I just sent a v2. I indeed have a 6126D on all of the three boards, and
never had a 6116D. So that v2 does change that name and the pin count
on the last bank.

Henning

> 
> At least that is what the chip IDs from the specs seem to strongly
> suggest.
> 
> I am sorry for the confusion and will try to clean that up.
> 
> Now having access to some of those specs, i can offer to add more
> variants without testing. Such support would be in patches on top, not
> subject to fixing what we have in stable already. But i would only do
> this on demand and have a weird feeling about it, the code might be
> trivial but i have no means of testing.
> 
> Henning
> 
> > Simon
> >    
> > > 
> > > Fixes: d0918a84aff0 ("gpio-f7188x: Add GPIO support for Nuvoton
> > > NCT6116") Reported-by: Xing Tong Wu <xingtong.wu@siemens.com>
> > > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > > ---
> > >  drivers/gpio/gpio-f7188x.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpio/gpio-f7188x.c
> > > b/drivers/gpio/gpio-f7188x.c index 9effa7769bef..05c0edc4778f
> > > 100644 --- a/drivers/gpio/gpio-f7188x.c
> > > +++ b/drivers/gpio/gpio-f7188x.c
> > > @@ -282,7 +282,7 @@ static struct f7188x_gpio_bank
> > > nct6116d_gpio_bank[] = { F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME
> > > "-4"), F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
> > >  	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
> > > -	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
> > > +	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
> > >  };
> > >  
> > >  static int f7188x_gpio_get_direction(struct gpio_chip *chip,
> > > unsigned offset) -- 
> > > 2.39.2    
> 

