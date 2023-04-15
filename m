Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546CF6E33AA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 22:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDOUzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 16:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjDOUzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 16:55:02 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0192123;
        Sat, 15 Apr 2023 13:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfAxH6q/8pEHzBwxh0O3iyvBioQ8DTmMYa42uQJ0nUhwGpjTDaKkIbrXWYcm95ZxQv3L34dBmWgRC/DjijEQ+kwIZRxbudIji7210rQuvqknY2ueJ4zpe65lTVE8YxUHyLrciXBC7eQWVu4ekx4/7cg8F1X9Gp5lz3tXpSmszULJdRYaUnQmdRcVdLFtlVSyj/yoIPOrmtkpOVTzGEHOOxJgnaRzdwcsuX7TQNxiSLPtwJj78PMJKZ237Pfr79PLQ9zxM1dMNICFx2n3gs0WFWB/NUYIcyX9VqHiPlR82JpIr4/YvY3VSo2mi/8QRlAu2ks1+Hn8ZVHxRTqQjovmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llmzJ2BmT017XheSXNI75vPAl89Tpt5TpM/WaUdxvuk=;
 b=WLisXHOGPGUO8kh9kOfsrMH4kb3MxyK8q0csy4G4Otc/4QdoVBzgXo9Gw3UBf0OUo/T5zzzL6NffaRwcsEEQkNdtWY5ALtnNqdtsujTvAcKn9KErmK2ENMgLlKlYon0ynoNfVM5YL0qjK6LFXVyv87zlfgB/qMXjGn0VR1nI2FiHSJoef3H9FdTrBd93j4fNdxFIrGs0mvYK9dk1cmRMQsTK9MvMa+bPFZH7wAC2eXB13LxK2Oj2g2wmgeTfZqTnuYGDPcF12Kh2fg/LNQCcgQQY9uzFg+e1KifnlY8QVb8MPOU9gG3XcQ+aYwbZpPR++8qhMNwiFrMBYkPAwTRs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llmzJ2BmT017XheSXNI75vPAl89Tpt5TpM/WaUdxvuk=;
 b=F5DESydl3PbupDf6424hFtqxUHN9Wv367edi2u1aeyclUFjwviJPIXasR914PCPBSjxPx2YFQNc2A5l0+5cFQ9d1XVjj1JFh8BerEydju4S06IdLSbs33yFo6dgUFBFoWKxvuZ4sFhOfAGNQqVKKt4mqlOoIlqQWOREVH/uIFOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB7591.namprd08.prod.outlook.com
 (2603:10b6:510:104::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 20:54:56 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%6]) with mapi id 15.20.6298.030; Sat, 15 Apr 2023
 20:54:56 +0000
Date:   Sat, 15 Apr 2023 15:54:49 -0500
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
Message-ID: <ZDsPGYJjCNmtizKk@nixie71>
References: <SupportforCS40L26BoostedHapticAmplifier>
 <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
 <ZDI0p5Rkp74SzJCv@nixie71>
 <20230410085634.GV68926@ediswmail.ad.cirrus.com>
 <ZDSqfHemG8pKj1k7@nixie71>
 <20230411092708.GX68926@ediswmail.ad.cirrus.com>
 <ZDYakQMOPsPTbGe0@nixie71>
 <6ABC85BA-AF2D-4D2E-8CA8-32E372570DA0@cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ABC85BA-AF2D-4D2E-8CA8-32E372570DA0@cirrus.com>
X-ClientProxiedBy: DM6PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:5:334::22) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 475a3fb3-9741-4a30-c48e-08db3df3aade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHUwwtGo39KaebPS4SZgua/l4h01qxP/LEYpC3+hryRYSEvF4wRSebClDMkHqvEhomIEdw8dtNMSn6nAHGXXkPxLTnZ51iZDQ8Yy4gwE17gHnLuN9mTWnPWCWlkK5APgummPxJtPewD2/VWA18ykvKPhiuVq3AQOiifRJQhPUW0fQtyNy82OnON/qjFiYxzJob2VjTgeWM8bbrgKI/u35zDPuJ2vxPdrNBoGofV9njkjGV71cgo/wH/ax0YUTM/vk4GONqFIuXcECIH6nSDZa0QH8L62lnOgDgJFOSHwOeAVQWtCB6rQsvY5IKiinGlAle6xMkzKS8XaYjwoAwIpF0XJ+HqkG3YEnQrLpb2XP52BhC4Vgf8zJmE8y9JDvP93/dCrthLuPnJTs3lNfiaIKWqrYCaGm+x3Bjk3ggxkfATDydWOOVWUPkLYY289OSIyNzciifuGFf8OXd9nxk3WeLBkCF1QqKF7OKu5OxomWi5DOdqOIHPVvFzBKaQacCsmWoiif65Z0A3f/4jXu5h9ztkhM+vdBoiX5QU4sdeDZKfGAw+YiYLZOnH3om9LS5AD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(136003)(396003)(376002)(346002)(366004)(451199021)(6506007)(83380400001)(4326008)(6486002)(54906003)(26005)(478600001)(6666004)(186003)(6512007)(33716001)(9686003)(38100700002)(30864003)(316002)(2906002)(5660300002)(66946007)(66476007)(6916009)(66556008)(41300700001)(8936002)(86362001)(8676002)(7416002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akJQT2lQM2FNTmhEOUluaS9jMllGSXhjc1BDTFV0a3pyVFVIQWFScEJFNWE0?=
 =?utf-8?B?cWswVmlrTjhYWUszMDIycFg3TGpJOUtibHlNZWhyVEFibytxbmpjckxtL1NQ?=
 =?utf-8?B?L0FBcGlPdlhZeUt0eXdMRHlVeTlCM2Q2b3JYQUNrdVVUV3FUZnpOWktUK2U0?=
 =?utf-8?B?NUR6b2l0a1kxR08vM0pYSTRzUlZWQXpFYlRKZ1JhMjhuaWtlV1M4UWI1K3Z3?=
 =?utf-8?B?MUs5OGI4U1VZSlJleWthSE9ZcU1BZnFHM3NNSnhCT0tpemNJVmQ2Y1pTNGpK?=
 =?utf-8?B?ZW4zbFIwbE1wQzJZZVdscHRCT1BiVlNlUGhVaTNBcEtHY3p2eTFtcFNMWWVZ?=
 =?utf-8?B?cSsxcUM0RDhPSjlxd3JrVW1BZEhjVlF1WXcwNUIvZ2hOUm9CNHYyUVpXcVRX?=
 =?utf-8?B?TmNlN0g3TlpOMUV5ejk1Mko1RWduc3NGLzJjbWRVbm9vQjg3SzdlS3FQSlcy?=
 =?utf-8?B?TUhXdUt6RzRvYmRsR3ozL0FISTVETGMvM3dXYjBHNVFESncvRWx6cnllZ0pz?=
 =?utf-8?B?aC9JYXBHRlBXajAvZVVpdFVMb3NYcTNpNE1zRmkvMTNnOFUybk42RTFpY1p1?=
 =?utf-8?B?SEhkWmF1amNoYXJ3MlcwSnJIRXZGZHcyVVYwYVpUeUZ3SGNmMTBOcnJtVWVS?=
 =?utf-8?B?WXV3bmFOaGZEcjhKZi92ZnBuWTVyZFpRUjdTcEJSMXNuT2ZsTCthZmc3SW9I?=
 =?utf-8?B?UVVEVVQ3MFlaTDdhN0NtdkVHNXErVzRmcW52V0NEMkJzT3hGWUYzMWY0ZlV1?=
 =?utf-8?B?VlJYTm9VR2p5RkorME1WbU01RERlRmJQUnNrbDVQekxWV01vRHUwMVlTYk9W?=
 =?utf-8?B?TXR5WGpBU3FhQ2lZMW5KeVhWU01XZzhKQ1ExbWlnL21xRzRGL0FhRHcydC9i?=
 =?utf-8?B?QkRlQ01NMlVQL25LQWZ4WUxqZWhSYVZmVjdUWnBnVEY1QWVLazV1cTNxS1dW?=
 =?utf-8?B?Vys4b3dqWkNLLzczL2pHUTIrdFBoTlV1U2R1QXpCbC9vRVFhTmRjMjBxVjBV?=
 =?utf-8?B?MG5MUGxYemlab29mNTU1ZFg4K0lyM29KS01vOUZWaXFiQmFBNE1Zd21hcDM2?=
 =?utf-8?B?OVlveTBYTWZqVlRGSmtiUkVRRkJDcEtybkNpTmFHV3NveHphRDJRWnBONGph?=
 =?utf-8?B?MTZvcnBGaWhhZXhacEZTR1ZwUmlwS3MydWFwd21iZ0l3Q1pxWGFWQUZPcjg5?=
 =?utf-8?B?SDhiczNvKzB1UWRLSVc5bnB5SkY2bDNMNUxUVFpZbW8yazI1U0FEbElMTW1i?=
 =?utf-8?B?M2JON2hNY2JRc3dpd05aVVErMzRMZmw3K29IV1VrMzVFY3dxVzdTbUMySWhB?=
 =?utf-8?B?NWpqNy9vcitsY0dvbmh1WUVUL3h1WU4zWDdtREhZTkFOL3pqSVU2bjgxRDZS?=
 =?utf-8?B?czhhK1pNbE92ZGQyUWN0RXBNdXY5ZkZPTVVWL2JoQ2tBZkZyN0YzcHA1dGx0?=
 =?utf-8?B?Q3dzZUREUUo4ZnNhT2M1M0dpYURvNGpWbVNZNTYrRWFoRUVlZVRsVFVSN0J6?=
 =?utf-8?B?emwxYVZJQVRsVDA3ZlZtbnUyVWk2OWNXN1BING1jcG1pbyttbWFMZXd4Z3ox?=
 =?utf-8?B?a1ZxODlvWjJMRFU5NGJUcHYzRXFTdTl4a0t3ZlBZQUlmK1IvUHdqQVRLb2dp?=
 =?utf-8?B?ZG9tZTdNL1E1NFJGa0Y3eWkxSDlsSjQzY3p4R0RLVDRWNk9Sd1dPNzdGd1Iy?=
 =?utf-8?B?aElmRWE0bmU4QmJiRklRTWhnS0JPNlpCenRSRGVEczllR0pwMFNFQUl4WFJQ?=
 =?utf-8?B?SFZzdG03dUIxZkEwZ2h6WjFleGtWSmRlUjMrTktUMExiVUtweWpQNExSdHo2?=
 =?utf-8?B?endwZ09VcU1vWFdBSFFrQjhLUHB3UEdZV21UY2dweitJTG1uOEhNKzUzNFQv?=
 =?utf-8?B?TmNVYyt3OVVId1VKTWFESFkwMzJPUUxhNCswNUhnckZwLy96UXB2bi9ybXRW?=
 =?utf-8?B?c2toeDR5OTI1TVpzcHVJd0tIUjBlTFlId01rSktKbVNSQ0xzbzZRNGFndm9y?=
 =?utf-8?B?a3E3WE96Qi9hajZHTWFoS3V6OXExRjZSSHovVDlwOWY5K2w3ckt5eEF2OFFp?=
 =?utf-8?B?QzNNeDZUMi9BVU00WWloWFRGNmw5MVVOS3cvSzgyMGsyaU5ZNzRUL2lmMTdy?=
 =?utf-8?Q?5Xt3Xt9x6OKD0Fk+iSFHhCPRV?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475a3fb3-9741-4a30-c48e-08db3df3aade
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 20:54:55.9659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+M9opUPoqK2pbn786i2WgEsKDLlbgafiydBZJqn6mlkatMO49oS8Hlz6Cl5SK77ynWjGeSRyQD1ne5GBw0hZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7591
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fred,

On Fri, Apr 14, 2023 at 08:51:48PM +0000, Fred Treven wrote:
> 
> >> +
> >> + return cs40l26_probe(cs40l26, pdata);
> >> +}
> >> +
> >> +static void cs40l26_i2c_remove(struct i2c_client *client)
> >> +{
> >> + struct cs40l26_private *cs40l26 = i2c_get_clientdata(client);
> >> +
> >> + cs40l26_remove(cs40l26);
> >> +}
> >> +
> >> +static struct i2c_driver cs40l26_i2c_driver = {
> >> + .driver = {
> >> + .name = "cs40l26",
> >> + .of_match_table = cs40l26_of_match,
> >> + .pm = &cs40l26_pm_ops,
> > 
> > Please guard this with the new pm_sleep_ptr(), as not all platforms would
> > define CONFIG_PM. More comments in the core driver.
> 
> Understood, and I certainly agree with this change. One thing I’m unsure of is what the effect would be on the driver if CONFIG_PM is not set in the .config. Surely, this driver would not work as expected right? Should I add a dependency in the kconfig to avoid building the driver without CONFIG_PM?

The PM core stubs out dummy functions for most, if not all of the API used here
for the #if !CONFIG_PM case. Please test to be sure, but it's likely the driver
still compiles without CONFIG_PM set.

However, you should evaluate the driver's functionality during this case. At a
minimum, the device should still be useable but simply not hibernate.

> > 
> >> +{
> >> + size_t len_words = len_bytes / sizeof(__be32);
> >> + struct cs_dsp_coeff_ctl *ctl;
> >> + __be32 *val;
> >> + int i, ret;
> >> +
> >> + ctl = cs_dsp_get_ctl(dsp, name, WMFW_ADSP2_XM, algo_id);
> >> + if (IS_ERR_OR_NULL(ctl)) {
> >> + dev_err(dsp->dev, "Failed to find fw ctl %s\n", name);
> >> + return -ENOENT;
> >> + }
> >> +
> >> + val = kzalloc(len_bytes, GFP_KERNEL);
> >> + if (!val)
> >> + return -ENOMEM;
> >> +
> >> + for (i = 0; i < len_words; i++)
> >> + val[i] = cpu_to_be32(buf[i]);
> >> +
> >> + ret = cs_dsp_coeff_write_ctrl(ctl, off_words, val, len_bytes);
> >> + if (ret)
> >> + dev_err(dsp->dev, "Failed to write fw ctl %s: %d\n", name, ret);
> >> +
> >> + kfree(val);
> >> +
> >> + return ret;
> >> +}
> >> +
> >> +static inline int cs40l26_fw_ctl_write(struct cs_dsp *dsp, const char * const name,
> >> + unsigned int algo_id, u32 val)
> >> +{
> >> + return cs40l26_fw_ctl_write_raw(dsp, name, algo_id, 0, sizeof(u32), &val);
> >> +}
> >> +
> >> +static int cs40l26_fw_ctl_read_raw(struct cs_dsp *dsp, const char * const name,
> >> + unsigned int algo_id, unsigned int off_words, size_t len_bytes, u32 *buf)
> >> +{
> >> + size_t len_words = len_bytes / sizeof(u32);
> >> + struct cs_dsp_coeff_ctl *ctl;
> >> + int i, ret;
> >> +
> >> + ctl = cs_dsp_get_ctl(dsp, name, WMFW_ADSP2_XM, algo_id);
> >> + if (IS_ERR_OR_NULL(ctl)) {
> >> + dev_err(dsp->dev, "Failed to find fw ctl %s\n", name);
> >> + return -ENOENT;
> >> + }
> >> +
> >> + ret = cs_dsp_coeff_read_ctrl(ctl, off_words, buf, len_bytes);
> >> + if (ret) {
> >> + dev_err(dsp->dev, "Failed to read fw ctl %s: %d\n", name, ret);
> >> + return ret;
> >> + }
> >> +
> >> + for (i = 0; i < len_words; i++)
> >> + buf[i] = be32_to_cpu(buf[i]);
> >> +
> >> + return 0;
> >> +}
> >> +
> >> +static inline int cs40l26_fw_ctl_read(struct cs_dsp *dsp, const char * const name,
> >> + unsigned int algo_id, u32 *buf)
> >> +{
> >> + return cs40l26_fw_ctl_read_raw(dsp, name, algo_id, 0, sizeof(u32), buf);
> >> +}
> > 
> > None of these four functions seem particularly specific to L26; is there any
> > reason they don't belong in cs_dsp or wm_adsp? In fact, some of the functions
> > throughout those drivers seem to be doing similar work.
> > 
> > Maybe out of scope for this particular submission, but is there not any room
> > for re-use here?
> > 
> I wanted to avoid making too many changes to the firmware drivers in this initial submission, and I think I’d like to keep it as-is for now, but I think moving this combination to cs_dsp is the right move. Let me know if you feel that it would be better to make the change now rather than later.

I think it's fine to clear this submission first, then look for ways to
optimize later.

> 
> > On Tue, Apr 11, 2023 at 09:27:08AM +0000, Charles Keepax wrote:
> >> On Mon, Apr 10, 2023 at 07:31:56PM -0500, Jeff LaBundy wrote:
> >>> On Mon, Apr 10, 2023 at 08:56:34AM +0000, Charles Keepax wrote:
> >>>> On Sat, Apr 08, 2023 at 10:44:39PM -0500, Jeff LaBundy wrote:
> >>>> I would far rather not have every single attempt to communicate
> >>>> with the device wrapped in a retry if the communication failed
> >>>> incase the device is hibernating. It seems much cleaner, and less
> >>>> likely to risk odd behaviour, to know we have brought the device
> >>>> out of hibernation.
> >> 
> >>> A common way to deal with this is that of [1], where the bus calls
> >>> are simply wrapped with all retry logic limited to two places (read
> >>> and write). These functions could also print the register address
> >>> in case of failure, solving the problem of having dozens of custom
> >>> error messages thorughout the driver.
> >> 
> >> I suspect this really comes down to a matter of taste, but my
> >> thoughts would be that the code is shorter that way, but not
> >> necessarily simpler. This feels far more error prone and likely
> >> to encounter issues where the device hibernates at a time someone
> >> hadn't properly thought through. I am far more comfortable with
> >> the device is blocked from hibernating whilst the driver is
> >> actively engaged with it and it keeps any special handling for
> >> exiting hibernate in one place.
> > 
> > Fair enough. I do concede that having this control in the driver as
> > opposed to DSP FW is more nimble and makes it easier to respond to
> > customer issues; I'm sure your battle scars will agree :)
> 
> I concur with Charles here, and it seems like you’re also ok with this so I will leave it as-is.

I'm OK with it; it's simply not my first choice. I'm in the "less code is
the best code" camp, so I'm biased toward giving the silicon the benefit
of the doubt and letting it autosuspend on its own. This is how bare-metal
platforms are likely to use the device, and probably how it was envisioned
to be used. And if there truly is an issue with hibernation mode, it seems
you would eventually stumble upon it whether the kernel or the DSP FW is
managing the device's state. That's just my $.02.

That being said, there is nothing functionally incorrect about the current
implementation and since you are the one who is ultimately responsible for
supporting the driver, I think you should stick with what makes you most
comfortable and agile. As I mention, it can be to your advantage to have
complete explicit control over the device from the kernel.

Please do add some comments to describe how the device's state is managed
however, particularly with respect to GPIO triggers. I was also confused
as to why the kernel autosuspend timeout (2000 ms) is greater than the
device's standby-to-hibernation timeout (100 ms) because I naively assumed
the opposite would be true.

> 
> 
> >>> +static int cs40l26_irq_update_mask(struct cs40l26_private *cs40l26, u32 reg, u32 val, u32 bit_mask)
> >>> +{
> >>> + u32 eint_reg, cur_mask, new_mask;
> >>> + int ret;
> >>> +
> >>> + if (reg == CS40L26_IRQ1_MASK_1) {
> >>> + eint_reg = CS40L26_IRQ1_EINT_1;
> >>> + } else if (reg == CS40L26_IRQ1_MASK_2) {
> >>> + eint_reg = CS40L26_IRQ1_EINT_2;
> >>> + } else {
> >>> + dev_err(cs40l26->dev, "Invalid IRQ mask reg: 0x%08X\n", reg);
> >>> + return -EINVAL;
> >>> + }
> >>> +
> >>> + ret = regmap_read(cs40l26->regmap, reg, &cur_mask);
> >>> + if (ret) {
> >>> + dev_err(cs40l26->dev, "Failed to get IRQ mask\n");
> >> 
> >> Having a custom error message for every possible failed register read
> >> does not ultimately aid in debugging and unnecessarily grows the size
> >> of the driver.
> >> 
> >> If a specific message is absolutely necessary, then add wrappers around
> >> regmap_read/write and print the failed address. However, this does not
> >> seem necessary either. Simply propagate the error code all the way up
> >> to the caller, whether it is probe or a sysfs attribute.
> >> 
> >> Stated another way:
> >> 
> >> error = regmap_...(...);
> >> if (error)
> >> return error;
> >> 
> > 
> > Not sure I feel super strongly on this one, but I do find when
> > debugging issues on drivers that do this that I usually end up
> > adding the printks back in.
> 
> I went ahead and implemented the change Jeff suggested here; it does streamline the driver to a good degree, and I think it’s worth making the adjustment.
> 
> >>> +static int cs40l26_dsp_state_get(struct cs40l26_private *cs40l26, u8 *state)
> >>> +{
> >>> + bool mutex_available = !mutex_is_locked(&cs40l26->dsp.pwr_lock);
> >> 
> >> This is dangerous and a sign that locks are not properly managed. What would
> >> be a case where you do not know the state of the lock upon entering this function?
> >> If you do not know whether the mutex is locked inside this function, it is not the
> >> proper place to grab it.
> >> 
> > 
> > Yes I whole heartedly agree here this should not be done this
> > way.
> 
> I certainly understand the concern here, but I wanted to provide some context. Since cs40l26_dsp_state_get() is called both in the cs_dsp_pre_run() callback as well as outside of this, there are instances where pwr_lock needs to be grabbed and times when it is already taken (in the instance of the callback invocation). Because of this, attempting to take the lock during pre_run causes a deadlock. I felt that it was quite clear when the lock would be available and when it wouldn’t be and to avoid the deadlock, I checked whether or not the lock was available. What do y’all feel is the best way to handle this? Some separate variable to determine if we are in the pre_run sequence or not? A separate function for dsp_state_get() for when it is not invoked from the callback?

This is essentially my point. As a rule of thumb, if it takes this much
explanation to convey the design intent, it's probably unsafe and ripe
for bugs as others innocently contribute to this driver.

A second rule of thumb is that for proper encapsulation, the state of
the outside world should be the same regardless of how this function is
entered. Your last idea is the proper solution, for example:

static int __cs40l26_dsp_state_get(...)
{
	/* Mutex is assumed to be locked here. */

	[...]

	return error;
}

static int cs40l26_dsp_state_get(...)
{
	mutex_lock(...);

	error = __cs40l26_dsp_state_get(...);

	mutex_unlock(...);

	return error;
}

If you need to get the DSP state in some other function where the lock is
held, just call __cs40l26_dsp_state_get(). Another advantage to using a
"helper" function is that the mutex is easily unlocked in both passing or
failing cases without complex conditional blocks or goto statements.

> 
> > 
> >> +
> >> + cs40l26_pm_runtime_teardown(cs40l26);
> >> +
> >> + if (cs40l26->dsp.running)
> >> + cs_dsp_stop(&cs40l26->dsp);
> >> + if (cs40l26->dsp.booted)
> >> + cs_dsp_power_down(&cs40l26->dsp);
> >> + if (&cs40l26->dsp)
> >> + cs_dsp_remove(&cs40l26->dsp);
> >> +
> >> + if (cs40l26->vibe_workqueue) {
> >> + cancel_work_sync(&cs40l26->erase_work);
> >> + cancel_work_sync(&cs40l26->set_gain_work);
> >> + cancel_work_sync(&cs40l26->upload_work);
> >> + cancel_work_sync(&cs40l26->vibe_start_work);
> >> + cancel_work_sync(&cs40l26->vibe_stop_work);
> >> + destroy_workqueue(cs40l26->vibe_workqueue);
> >> + }
> >> +
> >> + mutex_destroy(&cs40l26->lock);
> > 
> > This ultimately does nothing.
> 
> Could you please clarify a bit what you mean here? Does the mutex not need to be destroyed explicitly? What about the work queue? Is it canceled/destroyed automatically when the module is removed? Are the cs_dsp functions not necessary to gracefully stop the DSP etc.?

Sorry, I meant that mutex_destroy() is unnecessary; it's an empty function
unless mutex debugging is enabled. There is no need to take any action on
the mutex as the driver is torn down.

You do need to cancel any pending work to prevent use-after-free conditions;
the core does not do this for you. You don't necessarily need to destroy the
work queue, however, because it seems all of the means to queue work will be
gone by the time the device-managed cs40l26 pointer is freed.

> 
> In v2 of this patch, I plan to implement all of the suggestions in your comments that I didn’t question or disagree with here. Thanks for your in-depth analysis.
> 
> Best regards,
> Fred
> 
> 

Kind regards,
Jeff LaBundy
