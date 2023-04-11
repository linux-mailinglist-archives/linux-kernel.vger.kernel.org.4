Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2756DCE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDKAcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDKAcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:32:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358DC26B6;
        Mon, 10 Apr 2023 17:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAWjgeHdumtlFCSY+4Bs0zlO/ChmlN5fuxt/Y9qUgZ0K7TkjH35ek9Fg+zzxcd8ru6E7TLYnk66fT6AjsXY979rRBUCJIa98uTBsvlfosSsR9EJHjjhZ96Ld4YstXfhrnGce1hiOM1Z9FAMEHEvM9HNY8004OhRwies/VbZz/G0VnsxqYt2GhkNDm0QzXdxftYTWu/i3Zunmg+gU/kj36E0NbPuHCXsshcsNOBc8z/o54eyInnLIUiAZMZe0InDFj3Pab6EewimwuAW17b66TsZkRV6HNw40BnH8brGLy/uxBmV+tGy/ud1CY3G5EAjYiwCAJ4bnTKhgQBNVWfIWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs/MoO8Pnj9epZiC6j6u/flTfARAPL4B05VKnN/W/wg=;
 b=YBTb6F44G3Cp9LZ4QxUfD6Js4GpbA5t+Za/woDON/sWC5jnfRsVe1WTAVQHNO5lkwGx1ewqRqCCyQHd0WqFthUtgEkaqbi20ugjZ+wLCfF2zU+8ibMLstlnRBCCOCa4CSD7uNuLU5w6HUsn1E7GpFTWp0BXoxFC6WkF3/0CjjASbB5boOU9zRfcoQzh9LwB2K7Iq/DCC8PCEhXLlv2hqQFODKXw/aZlRaVE6auwKVsIaPqgOaJQ3MPGN371mDwMSqG867Mn5cx6pHZkrHDHc6EfrT/mI9eUUOab2kGv1LP9IUYUq3lBgA3Ajog7bIiGmLK0lyqYaTNYKzTtqCZk07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs/MoO8Pnj9epZiC6j6u/flTfARAPL4B05VKnN/W/wg=;
 b=u7WoDJ3ML7yAJkJqmXu7uHS/SAkNsjvKgtiqEBy5nSL8cSYySggzUn+iaNl9dT9qdCvdgRe8VEfgBgsWCKXbcqedOltqMS3v3eq6RUIr0GLpJ5kHx61zojVuLo1x3DNuqa8hvKFP/64sTYVu0NG0A2eEl59DClIIAM0XrLLX1Ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB6704.namprd08.prod.outlook.com
 (2603:10b6:a03:2de::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 11 Apr
 2023 00:32:07 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::34bc:e51:9ef9:3ab1]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::34bc:e51:9ef9:3ab1%4]) with mapi id 15.20.6277.031; Tue, 11 Apr 2023
 00:32:07 +0000
Date:   Mon, 10 Apr 2023 19:31:56 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Fred Treven <fred.treven@cirrus.com>, dmitry.torokhov@gmail.com,
        ben.bright@cirrus.com, james.ogletree@cirrus.com, lee@kernel.org,
        jdelvare@suse.de, joel@jms.id.au, cy_huang@richtek.com,
        rdunlap@infradead.org, eajames@linux.ibm.com, ping.bai@nxp.com,
        msp@baylibre.com, arnd@arndb.de, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] Input: cs40l26: Support for CS40L26 Boosted Haptic
 Amplifier
Message-ID: <ZDSqfHemG8pKj1k7@nixie71>
References: <SupportforCS40L26BoostedHapticAmplifier>
 <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
 <ZDI0p5Rkp74SzJCv@nixie71>
 <20230410085634.GV68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410085634.GV68926@ediswmail.ad.cirrus.com>
X-ClientProxiedBy: DM6PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:5:60::18) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df28fa7-07ef-454c-0cad-08db3a242e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1sWBIo+mdDXdhY2RqwrMmTwrYQjqWL4UugZhVaTgWKBFBsUU4CNXsS8Tg5ddPN3F2sUo83a/EkrKWsskDwvcIDh8TfrlN9ivp+r9+OesSzXHNM31tscBTjPIaroREFalyuHpzFopXdvw5aKahuZhoDZjRb+4AOlHortUHILeSPJD19kdM3xwK8wbN3y66fnLUx6pJaFz41nh5SZYV+ArmEYw4cVJBwGwn3GHo/EFMEN3W7bghOXX4NY890MmgxibHdyykTHJXTSkNWWe21zollVzvzv38mn/yybZ46MZoy1zi84nAtl7cBYjbiVLPZw/uK7SzcXw5vQgD3F7iAzHt0e3Sw7prdFJ7gmtzWMV3GtIgyHXVLtM3HgcVlUOOesVkr1a8+i/GtHvSNMYEq42+fp0Ywd0otGJzqneXwqWa/tUavza6lBeUZ6QYFN96zDA/zyaJCz8aNHUhAbJrqXAKyLTZYH3DKkB/3WgtjtcCS+/zhh/tnobKp1aQIYy2k39hpq0jFXKgEDIXKeJmh0xaLYvonHBHH+uMFUwK/Rs0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(376002)(396003)(346002)(39830400003)(451199021)(86362001)(38100700002)(33716001)(66899021)(186003)(66476007)(4326008)(66556008)(316002)(2906002)(66946007)(478600001)(6916009)(8676002)(6486002)(6666004)(6506007)(9686003)(26005)(966005)(41300700001)(7416002)(8936002)(5660300002)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cbCjsT61HaBYaHYaYBpVOG6Vo+vs401LlSiNSljuM8pAL9mn+5XGLJ7QAAoE?=
 =?us-ascii?Q?IAmJrEDTCkgu7apue2EeXa/7iiJba05z9wE4blqHxqjNIEBKMTZMEeWDlBSk?=
 =?us-ascii?Q?A/lwv6LvPs0thhNir5HSBw+RJVpcqHWckb7n148mIgNthbXMpdegzOET+eDX?=
 =?us-ascii?Q?6LwWg8gf/9+JGfM1rt95ab1CzEqYIueqZAqVbW+uQwehdj5m11SsQ+rcPtnx?=
 =?us-ascii?Q?wKVOpNpTnnkQl8HE92BZ0MCUdTtP0w86KIifUh+b7OA3xZb0mCQr65Sdr9E/?=
 =?us-ascii?Q?bvto7kRObwunBL/f4cdeXtFkzG9XIHCsfsTVgyNLXimUqM6vU2ewh4cM1N0q?=
 =?us-ascii?Q?96al8siFheV1NL50pIofV1Hk4Z2s7eYgcjYjgyvjAPt14Pv81wqRKeOygEO7?=
 =?us-ascii?Q?wdTgfn52sBuKiE+U5UbJgfNlJXhTZquOxMeu1NWwrKa7trq5Inn/csNJsw12?=
 =?us-ascii?Q?FjtzQfMPgFrp82lqhSGXxZUf7FMN8IsW2UWblhE25AOSpOt5R15sKhrsrf+M?=
 =?us-ascii?Q?1qsVYyptYiqB7FZXRj9f0FlcAZSXCWj12TjBDVOl7micVX38U8O8iGHzGZcC?=
 =?us-ascii?Q?SCqI3lAr+QTIYaQpacgjGPnF+5v7sWCcftWibnCO3jxsRyzX04jwBoxR58QY?=
 =?us-ascii?Q?L+czVEHvHd3H+mrKsB3yjtShY17j47SSuzBndNkAesQ9yxIv1tgwJ8VjHIba?=
 =?us-ascii?Q?+3XzQ557PmvP6Ka8OGSOr/RmMvgBX4DVgSqULRpJDKQFdOmuElvZiz0PdMGO?=
 =?us-ascii?Q?9gBo5P+fINFR5nXxcP54FziapMcktujDFBk0JpaPJZGOz8RPiIGEa3ixZIiO?=
 =?us-ascii?Q?Wz1/JMRBqrPqia/aElDq2Flz8etStkg9I6NDMakKIPxn1kDjyHhfiOit3TII?=
 =?us-ascii?Q?oB1l+ZEyXinNhleCxJYTv39yRryR0ZrmOQayQtyl2ZAqnzWC8apneVNGQI9i?=
 =?us-ascii?Q?2TlrDS6iHvB+yMZZrm7GF0hP4jk21tArVUXcZmUn55O46A//C8NOuV3e7ziC?=
 =?us-ascii?Q?Qn8x1bGlnctrLh5WrVhnys05xv1zxaKKovyoVdEL2MnGfYdc4wPhCpYjb3Vt?=
 =?us-ascii?Q?wilKkqlWZ+SKYcLT5Ky+swoMROruQB8AWJO/mNLYkB7EJclVGl6uPZP8O13J?=
 =?us-ascii?Q?EshFgZ5VblF6LRxu2jaxC5vlYvZR+Lzg4AUxpqUOI8vIptWkaIAYFjM2kfD9?=
 =?us-ascii?Q?E8dc9OsAvtfuSXNxjN14l5G3erm1NM56CEt/18iMDSOuNnX/FkK8RFPuQJjF?=
 =?us-ascii?Q?1IlSHWy28Ug3iVW6BAHmg8JV1koijJ53M3RcgR3uJMb1kzm+QRxOTGVG6bZE?=
 =?us-ascii?Q?8r88OZD9LVufac+JdAGPFpz+NiNbHpcdkX3OvH9fCpVCw4k/2eYEtuc6AWuY?=
 =?us-ascii?Q?gL+8n77g1RJCWkCRLLTN4gaPpEILIWSlVWVvG4LpeC6umvm7M6LuIw5vt/NG?=
 =?us-ascii?Q?fzpIxnfiH6SchC/pQ9vnAzJbK3dLyTKLoRThj85gL1Lov5dZ0Q6wJptpCl2t?=
 =?us-ascii?Q?ul1nLP121sOovYSKN04Sln1G6jY2N8goP5NZEolFGySpHg7U2TTp6xXWoqoh?=
 =?us-ascii?Q?4bBtzGH2D5636HiVQsDvUzeLtgDM74yosmT4gLEJ?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df28fa7-07ef-454c-0cad-08db3a242e59
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 00:32:07.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QIOwZHUdqg8xlZ47gwnNoMdOyXcDK71DIZLKcjGfwRiD6JIPSFWdZKwwoSgw/XuZ6nAYpZf7PeyNAq90vd+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB6704
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

Thank you for the additional follow-up.

On Mon, Apr 10, 2023 at 08:56:34AM +0000, Charles Keepax wrote:
> On Sat, Apr 08, 2023 at 10:44:39PM -0500, Jeff LaBundy wrote:
> 
> Hi Jeff,
> 
> Thanks for the detailed review, very much appreciated. I agree
> with most of your comments, save a couple of exceptions below,
> well and one that I just felt the need to agree with you
> explictly:
> 
> > > +static bool cs40l26_readable_reg(struct device *dev, unsigned int reg)
> > > +{
> > > +	switch (reg) {
> > > +	case CS40L26_DEVID ... CS40L26_REVID:
> > > +	case CS40L26_TEST_KEY_CTRL:
> > > +	case CS40L26_GLOBAL_ENABLES:
> > > +	case CS40L26_ERROR_RELEASE:
> > > +	case CS40L26_PWRMGT_CTL ... CS40L26_PWRMGT_STS:
> > > +	case CS40L26_REFCLK_INPUT:
> > > +	case CS40L26_PLL_REFCLK_DETECT_0:
> > > +	case CS40L26_VBST_CTL_1 ... CS40L26_BST_IPK_CTL:
> > > +	case CS40L26_TEST_LBST:
> > > +	case CS40L26_NGATE1_INPUT:
> > > +	case CS40L26_DAC_MSM_CONFIG ... CS40L26_TST_DAC_MSM_CONFIG:
> > > +	case CS40L26_IRQ1_STATUS:
> > > +	case CS40L26_IRQ1_EINT_1 ... CS40L26_IRQ1_EINT_5:
> > > +	case CS40L26_IRQ1_STS_1 ... CS40L26_IRQ1_STS_5:
> > > +	case CS40L26_IRQ1_MASK_1 ... CS40L26_IRQ1_MASK_5:
> > > +	case CS40L26_MIXER_NGATE_CH1_CFG:
> > > +	case CS40L26_DSP_MBOX_1 ... CS40L26_DSP_VIRTUAL2_MBOX_8:
> > > +	case CS40L26_OTP_MEM0 ... CS40L26_OTP_MEM31:
> > > +	case CS40L26_DSP1_XMEM_PACKED_0 ... CS40L26_DSP1_XMEM_PACKED_6143:
> > > +	case CS40L26_DSP1_XROM_PACKED_0 ... CS40L26_DSP1_XROM_PACKED_4604:
> > > +	case CS40L26_DSP1_XMEM_UNPACKED32_0 ... CS40L26_DSP1_XROM_UNPACKED32_3070:
> > > +	case CS40L26_DSP1_SYS_INFO_ID:
> > > +	case CS40L26_DSP1_XMEM_UNPACKED24_0 ... CS40L26_DSP1_XMEM_UNPACKED24_8191:
> > > +	case CS40L26_DSP1_XROM_UNPACKED24_0 ... CS40L26_DSP1_XROM_UNPACKED24_6141:
> > > +	case CS40L26_DSP1_CCM_CORE_CONTROL:
> > > +	case CS40L26_DSP1_YMEM_PACKED_0 ... CS40L26_DSP1_YMEM_PACKED_1532:
> > > +	case CS40L26_DSP1_YMEM_UNPACKED32_0 ... CS40L26_DSP1_YMEM_UNPACKED32_1022:
> > > +	case CS40L26_DSP1_YMEM_UNPACKED24_0 ... CS40L26_DSP1_YMEM_UNPACKED24_2045:
> > > +	case CS40L26_DSP1_PMEM_0 ... CS40L26_DSP1_PMEM_5114:
> > > +	case CS40L26_DSP1_PROM_0 ... CS40L26_DSP1_PROM_30714:
> > > +		return true;
> > > +	default:
> > > +		return false;
> > > +	}
> > 
> > Is this function necessary? Are there cases throughout the driver that may
> > attempt to read an illegal register, and you depend on the regmap call to
> > fail? If not, I think you can just drop this function.
> > 
> 
> I would much rather we kept this one, at the very least such
> that the debugfs representation of the regmap shows the correct
> registers.

Ah, that's a good point; with that in mind, I agree.

> 
> > > +static inline void cs40l26_pm_runtime_setup(struct cs40l26_private *cs40l26)
> > > +{
> > > +	pm_runtime_mark_last_busy(cs40l26->dev);
> > > +	pm_runtime_use_autosuspend(cs40l26->dev);
> > > +	pm_runtime_set_autosuspend_delay(cs40l26->dev, CS40L26_AUTOSUSPEND_DELAY_MS);
> > > +	pm_runtime_enable(cs40l26->dev);
> > 
> > My first impression was that this driver is doing an uncommonly large
> > amount of PM-related housekeeping. In fact, not a single haptic driver
> > in mainline is calling any of these. What is unique about this device
> > that calls for this much overhead?
> > 
> > Can the device wake up from hibernation (AoH?) from both control port
> > and GPIO triggers? If so, why not to simply allow the device to hibernate
> > at its own discretion and avoid all PM-related housekeeping? Stated
> > another way, it seems some of the DSP's job is unnecessarily duplicated
> > in the kernel.
> > 
> > In case I have misunderstood, please let me know.
> > 
> 
> I would far rather not have every single attempt to communicate
> with the device wrapped in a retry if the communication failed
> incase the device is hibernating. It seems much cleaner, and less
> likely to risk odd behaviour, to know we have brought the device
> out of hibernation.

A common way to deal with this is that of [1], where the bus calls
are simply wrapped with all retry logic limited to two places (read
and write). These functions could also print the register address
in case of failure, solving the problem of having dozens of custom
error messages thorughout the driver.

In my mind that is simpler, reduces the number of instances that
keep track of the device's state from two (kernel and DSP FW) to
one (DSP FW), and removes the onslaught of PM-related housekeeping
that doesn't seem to be required by other input/misc devices.

Does the current implementation at least allow the device to hibernate
while the system is otherwise active, as opposed to _only_ during
runtime suspend? If so, that's still a marked improvement from L25
era where customers rightfully pointed out that the downstream driver
was not making efficient use of hibernation. ;)

I don't feel particularly strongly about it, so if the current
implementation will stay, perhaps consider a few comments in this
area to describe how the device's state is managed.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/touchscreen/iqs5xx.c#n158

> 
> > > +static int cs40l26_irq_update_mask(struct cs40l26_private *cs40l26, u32 reg, u32 val, u32 bit_mask)
> > > +{
> > > +	u32 eint_reg, cur_mask, new_mask;
> > > +	int ret;
> > > +
> > > +	if (reg == CS40L26_IRQ1_MASK_1) {
> > > +		eint_reg = CS40L26_IRQ1_EINT_1;
> > > +	} else if (reg == CS40L26_IRQ1_MASK_2) {
> > > +		eint_reg = CS40L26_IRQ1_EINT_2;
> > > +	} else {
> > > +		dev_err(cs40l26->dev, "Invalid IRQ mask reg: 0x%08X\n", reg);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ret = regmap_read(cs40l26->regmap, reg, &cur_mask);
> > > +	if (ret) {
> > > +		dev_err(cs40l26->dev, "Failed to get IRQ mask\n");
> > 
> > Having a custom error message for every possible failed register read
> > does not ultimately aid in debugging and unnecessarily grows the size
> > of the driver.
> > 
> > If a specific message is absolutely necessary, then add wrappers around
> > regmap_read/write and print the failed address. However, this does not
> > seem necessary either. Simply propagate the error code all the way up
> > to the caller, whether it is probe or a sysfs attribute.
> > 
> > Stated another way:
> > 
> > error = regmap_...(...);
> > if (error)
> > 	return error;
> > 
> 
> Not sure I feel super strongly on this one, but I do find when
> debugging issues on drivers that do this that I usually end up
> adding the printks back in.
> 
> > > +static int cs40l26_dsp_state_get(struct cs40l26_private *cs40l26, u8 *state)
> > > +{
> > > +	bool mutex_available = !mutex_is_locked(&cs40l26->dsp.pwr_lock);
> > 
> > This is dangerous and a sign that locks are not properly managed. What would
> > be a case where you do not know the state of the lock upon entering this function?
> > If you do not know whether the mutex is locked inside this function, it is not the
> > proper place to grab it.
> > 
> 
> Yes I whole heartedly agree here this should not be done this
> way.
> 
> > > +	cs40l26->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > > +	if (IS_ERR_OR_NULL(cs40l26->reset_gpio)) {
> > > +		dev_err(dev, "Failed to get reset GPIO: %d\n", (int) PTR_ERR(cs40l26->reset_gpio));
> > > +		ret = -ENOENT;
> > > +		goto err;
> > > +	}
> > > +
> > > +	usleep_range(CS40L26_MIN_RESET_PULSE_WIDTH_US, CS40L26_MIN_RESET_PULSE_WIDTH_US + 100);
> > > +
> > > +	gpiod_set_value_cansleep(cs40l26->reset_gpio, 1);
> > 
> > This is backwards, which means your dts must be backwards as well. gpiod is
> > a logical API, so you should actually declare the GPIO as GPIOD_OUT_HIGH, i.e.
> > asserted, and then call gpiod_set_value_cansleep() with 0, i.e. de-asserted.
> > The definition of "asserted" then comes from the polarity defined in dts.
> > 
> > By the way, did you test this driver without a reset GPIO defined in dts? It's
> > an optional GPIO, rightfully so, but you need to check whether reset_gpio is
> > NULL prior to acting upon it.
> > 
> 
> gpiod does the NULL check for you no need to duplicate it in the
> driver.

Great catch; you're right.

> 
> Thanks,
> Charles

Kind regards,
Jeff LaBundy
