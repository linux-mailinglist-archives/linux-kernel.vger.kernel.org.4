Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C826F93F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjEFUab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 16:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEFUa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 16:30:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6616C234A1;
        Sat,  6 May 2023 13:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciVJeWLSVhgpC9ZHBEyfc0wgsWI0JxNIGRUGgXQpXJ0Ir3m77ciAYnPr6Aru1u295ecE+O14fV07GFLuD9Qjl54DggwCvUF3I/zURu3UXMCQq57SXxbvF0B4LiRtkcUcPE90VF0GOtBh8VoBrnwSs++wu9i4AgBZZowAvwLfWF259W/71TjtVfk3nZBwFtvJzOxaUmqg4UNmUkjMFFz8Hjbhfd84MyyLSnUoD1r/GSV3dyGwCz5UUWkzlc/mgfQJLOo3AJJIz5NAVCzD4MTPD77V/aDBuRg84BC/7coaMZ111Wrx+aprYyjVVpkaEJ9DnFsPoC8yiRhAJxuH5BUxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWlAatqe/a/aH/zF42uoAZgcfb/xkDtIjd65XJaF7nQ=;
 b=bLjSZSOPfXDXr84ZRJ2zHSZjzvi62M3KZyvCU9pVibn240ygru+ZXhLnb63VChTq3zFNW2Ek1vTfSr65CiHHFD5p7kUe5DSX6+1he7pq2IaOETV4PV8Y0M/KKqEIorz7X+nrOtwckbpWwWZD245fcYf4X85YVgCr2KN0koQqwhD4zlPcOMUpz290ACHZXwoMQuMwcmnQUQ1Ff+y5foe3ePdSA/hzvZ8raaV4HT129dEm4m6mcatfLWX0hGj+YoqCBqRL5fayfW+heSDoJfxf2gO2/BHUqI+RMF7MI1TVAIrDdwIQ6oI2v17+8psPCkPHQJtGTRavLvzhMylm0sk+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWlAatqe/a/aH/zF42uoAZgcfb/xkDtIjd65XJaF7nQ=;
 b=AF9aE88sD3Po26PeWxAsCSWPNF4H4MHM+Hrke85dA0bX9XKe3YDomJh2rXZh7PatI5yjhU5Ju6Nn2Xgd2OM+iv3lrPF27rkvS5dC1BsW6qdsu4xA2QrrFKgGIq/xyoPRBN3+cothSl8Vy8ioMyW6x+Kq9Q3qDBvsUw1wOigmUNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BN0PR08MB7454.namprd08.prod.outlook.com
 (2603:10b6:408:155::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.30; Sat, 6 May
 2023 20:30:23 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 20:30:23 +0000
Date:   Sat, 6 May 2023 15:30:17 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fred Treven <Fred.Treven@cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
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
Message-ID: <ZFa42bBbX+SDuoXg@nixie71>
References: <SupportforCS40L26BoostedHapticAmplifier>
 <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
 <ZDI0p5Rkp74SzJCv@nixie71>
 <20230410085634.GV68926@ediswmail.ad.cirrus.com>
 <ZDSqfHemG8pKj1k7@nixie71>
 <20230411092708.GX68926@ediswmail.ad.cirrus.com>
 <ZDYakQMOPsPTbGe0@nixie71>
 <6ABC85BA-AF2D-4D2E-8CA8-32E372570DA0@cirrus.com>
 <ZDsPGYJjCNmtizKk@nixie71>
 <7E101F4B-782A-4B8B-B6AB-3E7E282C9A9C@cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7E101F4B-782A-4B8B-B6AB-3E7E282C9A9C@cirrus.com>
X-ClientProxiedBy: SN7PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:806:127::24) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BN0PR08MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: d51dfc56-2624-4011-7688-08db4e70b7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8jxJ3ooc+TJXOASUhQkYV5eiPRg9TTFzW7jqutTUwkfw3sfsQgSZC3HivS/jj4x+zBJiisxFq//+osCyOuvMipHEx98f6YzLCqjFiJQ15REPTK4W26drM+pmaOHMhYDehfGuVOvHosdYKJ3Az4R6ZDjyjh6Nt2xw2eFhvTdS9jOpoS7iSjxj822eICMXhfMxIfdBDo/iqFAZlG22W4VyaVN9YLDcwhCmBBUczcjXCi4okppMgl3jGkZNY1gGMqPGhWa9pdcYSp63OrDUtQifTshNLiXsoKwTJlEOZPrgmXvg4Jb++Jzahx4TcEpeM8lsQcJYgI+fpQ5VHlKZSTFJKvKhN8GecjV6WLxTPH7YQTLv8jGtDlycW8egmP1bHKcLWpLD8gdsdeg/rhO897mtUAofk+Kf/0/7yHSvaIlUaqEEbzN4nz/U6kgcKyarJ7PIOMPKl/scNkeaXEENbZSJPE+h2reY505i4H5uUtI4LbehOb1oCk3TqsGbFOCHnH2FUuHqeKhVqq1b/iIUmzNk7se6he/klYIE1TBITXMwSmArvWoSPGX+qI8/MrxZXqiXDq2rWQ98EmKQ8EuNWwW981gU39ulLVsAdA/uz8wUPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39830400003)(136003)(366004)(396003)(451199021)(33716001)(38100700002)(86362001)(66899021)(6486002)(8936002)(8676002)(7416002)(5660300002)(478600001)(26005)(186003)(9686003)(83380400001)(2906002)(6512007)(41300700001)(6666004)(316002)(6916009)(66946007)(66556008)(66476007)(54906003)(6506007)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXZvQ3JzZHpISmVvY3BjREIzbGR2M2kwT3RUQmFSRXF1TnEvSzl6ZVhKRTZx?=
 =?utf-8?B?Ym1kc1NqK1llbTVaUUVwNitaMkhmM0Nzb0svUDNDN01PS3BZcEdheG0yK0o4?=
 =?utf-8?B?b0ZMcjU2ODBSZEQ5c1ZyazlCQXFnRjdwT0VGQWZBcWwxM0NQT3kvNkhxNXJ5?=
 =?utf-8?B?Y0ZydkFBcndEYnJ0UEFrR29Ta0l6TklXUEJtRm9xcktQSE9nMGZIYzZZWXdl?=
 =?utf-8?B?dDZSbTNuM3QzcmkrTWk0UXprbjhMRTh1bTA3TjR3K0J0T1YvN0c3bGl3bGwx?=
 =?utf-8?B?WlZlL2hUS2RxRHIvSnZ1Z3d0SjBMSUs4K3lubEVLelVQS3RMUWFBcnZqcUlm?=
 =?utf-8?B?dnI3SzhERjArRmJZai8xa3h0ZHNZK1RNRDdNc0ZidFVJTy8vdFB4d2d0ZVdy?=
 =?utf-8?B?ZC9JQkltR014ZEdLT3ZRYU9qVHNwVXg4NytpRzE5Zkw3V3ZaZUV3dmt6NEp6?=
 =?utf-8?B?Q3pkM3BybXFjQzJxalhSeVVKeHl1TnkvdUZjb1JzSnpjdEJHRVkrcHVWWEdB?=
 =?utf-8?B?WXU2Vzlrbm9jdHFPYjJYNHJPMWVOWDVTQ2ZvVTlSa3RkNDlSRkQ0UW5JYlNv?=
 =?utf-8?B?VUxLZXhTQjdvV055TXFYa0tTSnQ3a0wxWDhGWm4wQlk2b3N4ZEdaMEpoaHQ0?=
 =?utf-8?B?QzU4anY5L1lCdHBXakEyWUtTWmZ6T1BSMGcxZ0x4VFA2ZTdjaU9VTi9nM2hW?=
 =?utf-8?B?eTczOTl1TFhrenJjdzR4cUZGbytFS3dUZUFvbERSWDlOZDVweVhGbTFVQ0E1?=
 =?utf-8?B?UlFxQ2p0cU1uTHU1UnZnYlJnV004bVBNNnQ4RlprcHZoRWlIT0lSQ3B6d3dq?=
 =?utf-8?B?U1Jhc2JJS3pTSXUrY3FlWG9Lbk1yOTNIM1JtQVpxNUZqWlg5UjZBM2FOaTg1?=
 =?utf-8?B?bThTaXZFamF1by9sdWtyNU9rc1hPWFRhYlFkYWRqa1ZndUJWYWgrUEc4aUZj?=
 =?utf-8?B?UkgrTDVWZ3dyZUtvTnZFcmhuaHh0ZHltWkpEZzFMYXdUR3Q5NTczMnVFL2V3?=
 =?utf-8?B?elhralI0dWQ5bXkrVjd0WDFObkpMcitFOTkzVnBvRHYzM2xyeUNZUHBOYlFG?=
 =?utf-8?B?dUFZWTJveEplVHlZYXlhWVFTSUlDSVVDdzYwT3ZOZUlobVhhQzA1VTExc2NO?=
 =?utf-8?B?TFZINENJWFQ0b3hTejlOMVY3a050ODJlMlpKUEwzeVlYK0ZRa3FWQjRFVmV1?=
 =?utf-8?B?Ui95cnI2T1lUdXNadmRrcmZFdEIvaUx0eGlMcWV6ejZSaG5FRE11S2lYUUJs?=
 =?utf-8?B?VXZJaGpRZHhZWHZnK29ONFdhc3JCSllUTzZzeDRlbTdjK0Ywc3lrYmxJQ2Jv?=
 =?utf-8?B?KzNhQlVxcW5BbldveUFJa1RqR0RuajI4YVpkdkV4Z3V2M3dmRHVkQ1R0djB6?=
 =?utf-8?B?MUo2QTFqS1hPYUxBaERrZTd1OElTbWl0QUdOKzY4ak9HYS8vbkhQOElHSjJ0?=
 =?utf-8?B?VENHajRzcTltUTdxZUM4QTM3Ry80bEs2N0V2a3VmcTdoWjRmR1pENE1QV3py?=
 =?utf-8?B?T2tkNnF0SmFTbHU1dStxam9YV3NZVThtOS9lYkdVTnNBTC84Q2JuU21LNmNX?=
 =?utf-8?B?aUg0RFFxb2dldi9sSmYzNDltaldYcU50OWxjQmdSMGtRWGZtc0I0N2JETHRN?=
 =?utf-8?B?UzhacHZWWE0wdGJMWWFmUHdoMHZHd2hWSWN4LzFjSVFKRWx3TFNYbE44UUVB?=
 =?utf-8?B?cTVpcVE4cWJsb0RXWVVxbkhsTzNwS3RyVlNoSXZtNERnaVEyUzh0cWdTZWt6?=
 =?utf-8?B?SmRWRitUU3RqVHlGM2FsL3dlRXpSa0FmYU00azNjRlY4aHB4bVF0YWlZUXlW?=
 =?utf-8?B?cis0YWswcGZPMFJHUjdESkJBaHRjNkQrelk1b2o2VjJtNkNISUhYVE1ETmhC?=
 =?utf-8?B?ZmpaT000OHRJQllHVDh6eXZaUE5CUlNOWTlxNDM3R2FkOWdabkNQcjNLdHBK?=
 =?utf-8?B?ZUFpWDY1K0htK3ZVbHpnelFodkgyVDFGTkw0cmtmTlhxRUIvV2d6cFhFaDFq?=
 =?utf-8?B?YTJlWGNzZys5Ly9PbHRsT1Z6WUhpUVZBSCs5T0pMMXl4alJqTG8vZWtuTlFi?=
 =?utf-8?B?TlptQmY0Ry9lbHlFL3dRSUorcFN1Qm1hdVk2WDRoVjJuZ0tsYzZKeUpsbkF3?=
 =?utf-8?Q?Iat0hMAQ7fRiWhXP6WBev2cey?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51dfc56-2624-4011-7688-08db4e70b7c8
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 20:30:23.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIt/jOD6Q4fDwqspaX5L2xDmnk5rfiPqasQwTzuIvtTwEezNYC+oVDtdtoZRV5e56TB6LT870xYiUA0qLFFgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR08MB7454
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fred,

On Thu, May 04, 2023 at 09:51:37PM +0000, Fred Treven wrote:
> Hi Jeff,
> 
> I had one last question for you before I send the next version of this submission.
> 
> >> +
> >> + return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(cs40l26_remove);
> >> +
> >> +static int cs40l26_suspend(struct device *dev)
> >> +{
> >> + struct cs40l26_private *cs40l26 = dev_get_drvdata(dev);
> >> + int ret;
> >> +
> >> + mutex_lock(&cs40l26->lock);
> >> + dev_dbg(dev, "%s: Enabling hibernation\n", __func__);
> >> +
> >> + ret = cs40l26_allow_hiber(cs40l26);
> >> +
> >> + mutex_unlock(&cs40l26->lock);
> >> +
> >> + return ret;
> >> +}
> >> +
> >> +static int cs40l26_sys_suspend(struct device *dev)
> >> +{
> >> + struct i2c_client *i2c_client = to_i2c_client(dev);
> >> +
> >> + dev_dbg(dev, "System suspend, disabling IRQ\n");
> >> +
> >> + disable_irq(i2c_client->irq);
> >> +
> >> + return 0;
> >> +}
> >> +
> >> +static int cs40l26_sys_suspend_noirq(struct device *dev)
> >> +{
> >> + struct i2c_client *i2c_client = to_i2c_client(dev);
> >> +
> >> + dev_dbg(dev, "Late system suspend, re-enabling IRQ\n");
> >> + enable_irq(i2c_client->irq);
> >> +
> >> + return 0;
> >> +}
> >> +
> >> +static int cs40l26_resume(struct device *dev)
> >> +{
> >> + dev_dbg(dev, "%s: Disabling hibernation\n", __func__);
> >> +
> >> + return cs40l26_prevent_hiber(dev_get_drvdata(dev));
> >> +}
> >> +
> >> +static int cs40l26_sys_resume(struct device *dev)
> >> +{
> >> + struct i2c_client *i2c_client = to_i2c_client(dev);
> >> +
> >> + dev_dbg(dev, "System resume, re-enabling IRQ\n");
> >> +
> >> + enable_irq(i2c_client->irq);
> >> +
> >> + return 0;
> >> +}
> >> +
> >> +static int cs40l26_sys_resume_noirq(struct device *dev)
> >> +{
> >> + struct i2c_client *i2c_client = to_i2c_client(dev);
> >> +
> >> + dev_dbg(dev, "Early system resume, disabling IRQ\n");
> >> +
> >> + disable_irq(i2c_client->irq);
> >> +
> >> + return 0;
> >> +}
> >> +
> >> +const struct dev_pm_ops cs40l26_pm_ops = {
> >> + SET_RUNTIME_PM_OPS(cs40l26_suspend, cs40l26_resume, NULL)
> >> + SET_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend, cs40l26_sys_resume)
> >> + SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend_noirq, cs40l26_sys_resume_noirq)
> >> +};
> >> +EXPORT_SYMBOL_GPL(cs40l26_pm_ops);
> > 
> > Please use latest macros (e.g. DEFINE_SIMPLE_DEV_PM_OPS).
> 
> When looking at these *_PM_OPS* macros that replace the deprecated versions, it is unclear to me how to maintain support for *_sys_* and
> *_sys_*_noirq* functions. Would these all need to be separately defined via DEFINE_SIMPLE_DEV_PM_OPS?
> Would the *_sys_* definitions still be defined through a struct i.e.
> const struct dev_pm_ops cs40l26_sys_pm_ops which is then exported as it is in my initial submission? 
> I’m unsure how to handle these cases with the latest macros.

I don't happen to see macros for suspend_noirq and resume_noirq, so maybe you
cannot use macros here after all and will instead have to fall back to tacking
on __maybe_unused to these callbacks to accommodate the !CONFIG_PM case.

That being said, what are you ultimately trying to accomplish here with these
noirq variants? For example the print statement says "early resume" when in
fact a different callback exists for that (resume_early).

On that note, why to disable interrupts during system suspend? I can imagine a
use-case where a customer ties the output of a force sensor to a CS40L26 GPIO
for low-latency haptic trigger, and then the CS40L26 interrupt output to the
SoC as a wake-up trigger. Does the part not support this use-case? I vaguely
seem to remember an issue with this on L25.

Also, why is the logic inverted for the noirq variants? These are simply meant
to accommodate additional tasks that need a guarantee the device's interrupt
handler is not running (for example, clear or acknowledge a pending interrupt).
In case I have misunderstood the intent, please let me know.

One last gripe, then I promise to stop bringing it up :) But the mental gymnastics
required to explain the no-fewer-than-six PM callbacks used here, as well as how
to support the !CONFIG_PM case, are in some ways additional nudges toward getting
rid of this massive amount of PM overhead and relying on the device's internal
power management as so many modern input devices now do. As a rule of thumb, if
you're having to jump through a lot of hoops to do simple things that others seem
to be doing with less work, something is wrong.

In your defense, however, you are unlikely to come across many devices that do
not enable CONFIG_PM given this device's target application. That being said, it
is not unheard of for OEMs building wall-powered devices to enable CONFIG_PM but
inhibit system suspend using a wake_lock because of some HW bug.

Therefore, it seems a bit unfortunate that those use-cases wouldn't get to enjoy
the power savings this devices offers. That's just my $.02; I also understand
the reasons behind the current implementation and won't push you to change it.

> 
> Appreciate any guidance you can provide.
> 
> Best regards,
> Fred

Kind regards,
Jeff LaBundy
