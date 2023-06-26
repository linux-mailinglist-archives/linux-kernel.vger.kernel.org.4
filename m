Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE0273DFFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFZNBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFZNBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:01:36 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69210C;
        Mon, 26 Jun 2023 06:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpOVF+0gve0eaSz1OCvo+O7C+tIlCxskxdHQHVC32ti2h2XD+e3ejKnhVSs3pVIXBk9MFdy9XNl7foUj0o0+lv4eQJXZopTdL7+yhtyK15osYSwHZVqv67k1WysBorGPAhDzpnl7EgBeIxfJ5u02hWKkwW0vMOGnkp8jQHu1Oz2VV06cSBZXomsfJSvjkLiguaHftTQQ0mVzsFWO9KdygBy+/JtK588sWj3tth7wBMcwqCPGtG78dyogJMpc/6DkEb2f5kN4SOf9xbY68dPDD0xQr0XJPlcQOQQNpeDO7dYNGpJQyYMeNzmc+eYsYaFX55JV/+gGXpgREpjF+xJ7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rvv+Aje8S9KaBfZgkcTuxlqjLhOjQx2V9fpFkd41NkU=;
 b=eYh2j1WA04aTlXdUyChPh7JFj5fUwtIVOkTX/B7MZe8LObrNFfwdq95Cn1VHkjhj3JtFP3UC3QLNTjrpsBnZFD3vzSfWA7FWZA0BVE3Lc1sfk2ry+NAAtjt3jTESHq3B9ymd7TCUdA3O6rV0GB0E1YJfYy8IHZDItNB6t2praUXSt+P4bXg2FEO9XSHz5GZqdIGib4tw3Gc6hWWTDWwwuiv8AB2RC5d1iR0VcBMSLUsPwPetyKfcJRHwX7cf9c4TN41GC4X/0rfeeA83vcW+URsNBdJnbw0fmTCr9b1FQmfu5DiFZdOlKO/dsDOD7D9YnLIDH6h5zBbrBXY9zoeJJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvv+Aje8S9KaBfZgkcTuxlqjLhOjQx2V9fpFkd41NkU=;
 b=p/preC1WznjfcDRWz+YPYDVB3KkO+zMLBSsZNJwwk6SkcloqKN3toT8J5RhkLSq7mJXyukPE8fSvYUvrRS9ZT8k8T4IgKxXmxNMvKnuoeZu0t5JybSuEk+ZEDPiT2HdHqnzA50jSH3NAtu9KAlf3pxsjP4upPKJM3VajqGDmo9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB8446.namprd08.prod.outlook.com
 (2603:10b6:510:29c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 13:01:30 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 13:01:30 +0000
Date:   Mon, 26 Jun 2023 08:01:27 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] input: touchscreen: add SPI support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZJmMJxXxLrC9Xevi@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v3-4-f0577cead709@linaro.org>
 <ZJiXopmFr4dPbqll@nixie71>
 <e36a697f-a54d-7bdf-1e18-38f72ec2966c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36a697f-a54d-7bdf-1e18-38f72ec2966c@linaro.org>
X-ClientProxiedBy: SN6PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:805:ca::36) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 9776e50e-020d-4199-640e-08db764575a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxnSZEXCHnRQVHAHMhbFJvVvF/NmyGrjifrhqAkCETUaAIbrHbKrXgROk3wdsQCMlaSYk5DN0De50klAJ8sCafaOZdN8Y6cjNzwIgCP3CkqGbkUaXlXZ9iSl+uUwzHpaCkIPw0fPCDYzwwR2bMzSxV0XyT6bTSePSb/pDsWuTTzbxdeyyMCjk0MWN4yKM2QdAfc8DySj8uqwNVxFIHROWCsaeiEapireaAA8Q5rEoz3qfBE2Cqa1ffBVZS8hhpC9Sovq2b8z0xF2Qhp/Sj65AAWWWeYSHeKyuEBuP7N9mnHt20IKmVcH5VLvM/TOuzxobV0yGZZEAEX4gPkmjRCB3FU2IGjhP+Jtj8ZB17yaXDROW2cEn2Ah8JcmQEF6HWbdNfiTQBQ7heNYas8k1NGcCnUVqk6N6dNSFn5cPe3m7Owr5Jfoi0WGmB5YHJI9ElGGkwharVDGXKMfvG2xF2T3o7gN9KEtNdAfNTfBEt3tfRsyJul33Eu7D50moitpcMxuS1Qtiv16cesRxqgXDkVzSIkLSafmjv8GC24KWKAt3PLUrsH0S6rtd8ReDwUNebkL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39830400003)(366004)(376002)(396003)(136003)(451199021)(2906002)(33716001)(6486002)(6666004)(38100700002)(6512007)(6506007)(26005)(9686003)(186003)(41300700001)(54906003)(86362001)(478600001)(316002)(66556008)(4326008)(66946007)(6916009)(66476007)(7416002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3K1eXE+scBNEU0OV9uz0hk+XXeCzRyT4i6upxfL6a6lH0QwGZXBpVw6pU485?=
 =?us-ascii?Q?t/4RvEdGk4fKrUnS9KyDLJTj2OXLdkCqrLbjuNTJSxufRoth81Shg1Dyk5V3?=
 =?us-ascii?Q?HMD+39Vr2o3aj3pNbtcNyFkevVOKdA0ZTYTacUIj+sOdH12IexADw9Tbryu+?=
 =?us-ascii?Q?dVugOVT98vCfh4GeWyVsDmaGyvbGbIj1v2Zuw/VmPKSZ5WKJ7s1J24TJY/E7?=
 =?us-ascii?Q?+0sKCWimyu9gcPGmp+F9PYgQ0Ni8aejRGrtilPe9SvZaRKaKmXwi5vs8Fu1y?=
 =?us-ascii?Q?6oXLK3n5tX3QXBC463d/GLu0Kj6ggdlGGN4tjONLv/iXII6neYnXzYjzynLD?=
 =?us-ascii?Q?wnbAR0G2cygKOzFjcw3zSAV86CuNODO281aKKkZkyn1+lkCjYwFKqeNhBpFb?=
 =?us-ascii?Q?ejrRaCnoaTfOdO6I7E4Yj7vEh/eDVBIZwPDpJztn8ui6qm1CNjRpO3ypGkPx?=
 =?us-ascii?Q?y7D8PxYsdNvfcy37e9gLhX7U5EXSLZw6htjeV268UeFWyMdtg19Sv+1QuvgF?=
 =?us-ascii?Q?nXgaDOTgIhejUuFD/RfXNUOX0ZNh6ESFsawMqBbYQphblBIuVeUscy5l6e+S?=
 =?us-ascii?Q?kMWHDuLZdKs+PBoeZUq8bNiFpBkQzVdyEDzGll3ljifbMdznuZO3TT/712R2?=
 =?us-ascii?Q?FgewpBr3e6yI7ORMtT3XJ5n/Fe9IEYQejLNdEkbQO8G74vkD8p+e6bib/LyW?=
 =?us-ascii?Q?iB9tXPRd/XkMwKTO9+tuWHZrIwzjKw2ZWYYrwwGPCPDa/akb5xzUGp9FfivG?=
 =?us-ascii?Q?D54aAqNh24JH401kik6HVe+9UgAdnMXFLCt3n7f8QLYff3KjFJQiXusRaaZV?=
 =?us-ascii?Q?1YY7BIPrcSmDDaxD4Ck9j+Thsw7JVQQPJrL/2YeJH73eIhHsOoWJzux4nrSB?=
 =?us-ascii?Q?lfvfurS/YsAnzrhuRtVOgRR0hfrdxrHG+xSxopSwLTPJuuHFwHSoD5vtGz17?=
 =?us-ascii?Q?JKWepeYyW+gi9ZOchgHyG0OnBih++XHznmqN/1TeCJPYfXCJEr6soLPKk3d2?=
 =?us-ascii?Q?CVaQue+XBOTZxkGzZWak0na8Jo1KslqflbC+VzHjTYJDxXZjc7T2puxdu69R?=
 =?us-ascii?Q?N85GPfMVfJTmCupqiP7Z28OUZDiAED/IK6P83EwB1mH/8r2P3lHzykpRTXur?=
 =?us-ascii?Q?OZt3O0TJiOSjl7PM3q0qyAbWZdV0MV7Nftyz2Wh2jaZnZv9ds5wtVhK6doyZ?=
 =?us-ascii?Q?G89D+l7Z+WqDMTATd5deKdlXsDYlvLAar7TxZcYN4vzHaPfSsdUqr8IOODwA?=
 =?us-ascii?Q?MlzD4O2BrthmFvUCH6qRdS5KLbRrxL4pYm3BAtZYVQ+AwyQXsd2YHZvCbs/U?=
 =?us-ascii?Q?+XRtFCUZFDhGNkqNBpmdpXgYifPLt2m4FcF+U8Xv4xHt77IZHCSanozfWiWJ?=
 =?us-ascii?Q?oC3P6wIzKvVtKvDb62vAy3gEKM3bWLA1uRPtIXoX5UcfzWpJ4zaXCCfy5jvo?=
 =?us-ascii?Q?bZC37cThYwF52Gm2xuIbza7+jotAgeyTZe+ou3j4vJ0udOj+rPNuWkSWjp/g?=
 =?us-ascii?Q?EbpcSXBQSqil/GlmCuknrsmiyUzOMLjMfTDZlHc42cu4CAas+VCNN4aPrywN?=
 =?us-ascii?Q?4k/Fns/L74vAhD6AxDkz+yuf09F7s4NSPVPEOkg3?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9776e50e-020d-4199-640e-08db764575a5
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:01:30.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMo3J3K/5FTb9HJmSX+MXFePupUBF1UFyYyiMSutQAqSB5faB4XHyOjZ6SgrFJdIQSJWvch1Jh6bVxiCP/U0+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB8446
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Jun 26, 2023 at 09:02:16AM +0200, Neil Armstrong wrote:

[...]

> > > +static int goodix_berlin_spi_probe(struct spi_device *spi)
> > > +{
> > > +	struct regmap_config *regmap_config;
> > > +	struct regmap *regmap;
> > > +	size_t max_size;
> > > +	int error = 0;
> > > +
> > > +	regmap_config = devm_kmemdup(&spi->dev, &goodix_berlin_spi_regmap_conf,
> > > +				     sizeof(*regmap_config), GFP_KERNEL);
> > > +	if (!regmap_config)
> > > +		return -ENOMEM;
> > 
> > Is there any reason we cannot simply pass goodix_berlin_spi_regmap_conf to
> > devm_regmap_init() below? Why to duplicate and pass the copy?
> > 
> > For reference, BMP280 in IIO is a similar example of a device with regmap
> > sitting atop a bespoke SPI protocol; it does not seem to take this extra
> > step.
> 
> The goodix_berlin_spi_regmap_conf copy is modified after with the correct
> max raw read/write size, and I'm not a fan of modifying a global structure
> that could be use for multiple probes, I can make a copy in a stack variable
> if it feels simpler.

Ah, that makes sense; in that case, the existing implementation seems fine
to me. No changes necessary.

Correct me if I'm wrong, but the stack variable method wouldn't work since
that memory is gone after goodix_berlin_spi_probe() returns.

Kind regards,
Jeff LaBundy
