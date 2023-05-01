Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC106F332B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjEAPtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjEAPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:49:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210DFA9;
        Mon,  1 May 2023 08:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV6XrvJnSVs+atfhq4PKhmK4aUXcHA/GXznPI7DPRvZpwSxLkDBVq6DE/ybhz7vVe26YiRPHdJ+z9rsvjI+guRmij91G/q7qnBva59JtpNv4W/ztHPjh0PfM+cWmCvqoyLLYyjU/95cSrsEVLH4p++5suom+dM63uUMI/2mLE2fb6Zp973TCAsfRTJIRH7F7Kn3eoXs+iPnyDW/qR1IR5o/H8GraRVya1rc4FSa9OOQNJ3TgepK+brC8+Hq5+6Xa/GUimIF5FeoOapSGqSV9fHHR/EN8hLxATqUHViuiA8paHn/kxak01DrnGHRxtcQPqCNx//BC1EWkCkNzdKLfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq6lcB56t/JpwuVCcAFgOofYPwtJqZDvjdH0hrc1LZU=;
 b=cjrJjGa+hqvWXnWD2LwtQidY4qaIecIqcqi3AOPA4MZ+rNysPXdKtkajj4fawXo0qAnygz7lwg7Yx/CNbiDdlYpstdRhrKWOHSRTl6DyRuAb3qb6GSIvFUJmdDrpLvdFWqVEA6i3j15q8jOY/ZCp+Yd5uFplyrqTnIiFQBmFkiTC9JXxUGBqdRQJ3In1b4EZWxf0gw64GW3/9+8QnAJzw/OcXFeGGmMR5fAkCe7PSqquO6Qu8GMcXSx7TrqBKNhjOe6En5WbvHarN3FwzDyKVxr3fZSYxzbU/x5rVw6qDpGH2exaqzkZzSELg40ALKRAVZ6HUA0Hkni2bGnKxRE/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq6lcB56t/JpwuVCcAFgOofYPwtJqZDvjdH0hrc1LZU=;
 b=fV6buyk1srElmmEin+TdEnpuCg8zmV727rryFZhvH+waw2r2z4tVx6A0S5qt/zFdowzi2boueC1w7VZZ4XJnnlJzPTW5VnQvlgDNo71bXMiqBAYBs5JAcd7jAdc23TTSDAIVJbXo92xsxgSnDToyFtaIGWtFmqXsYAtpvMq/hpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB7562.namprd08.prod.outlook.com
 (2603:10b6:303:161::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 15:49:26 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:49:26 +0000
Date:   Mon, 1 May 2023 10:49:21 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     8a790966-d985-c0fc-498e-c17e69a6622e@linaro.org,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        jiriv@axis.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
Subject: Re: Fwd: [PATCH 1/2] dt-bindings: input: microchip,cap11xx: add
 advanced sensitivity settings
Message-ID: <ZE/fgU/FYbFwkMpf@nixie71>
References: <d7f77779-5d28-b78a-da4e-cc237b2a04b9@axis.com>
 <1511d33b-dab3-cddb-cbf2-7db016678362@axis.com>
 <403412d0-18b8-8d2f-e044-0e27b06a2d12@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403412d0-18b8-8d2f-e044-0e27b06a2d12@linaro.org>
X-ClientProxiedBy: SN7PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:806:122::25) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: a3292d0a-bc28-4cad-2c9e-08db4a5ba40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULGNbfPluiUkhiH/jR22w7VUC0leLfBrGxtl/pBahIwyZxO1ru19V9ywb8GTjhpGqm6L/gf70pxU94escPC9YRbKDi6GRcu4x3ssVBusrMftKLU1PzBq+zZDy3QOt1i5SyvbVrluSiYXiNK/+7d8Sh0aGDD/tqt8IdFvQRkJ1gP8X0MH380uDp2f2FpAOJ9hc235Yjjej1Y4S0BE1JPw9qpHn4GC/6c+dV0YrsAgDkxZ26RktWhmXYyRfOXzQOWJO10dHo6OBZhR9TElA2d+mpnU8EpGk6xQCOAklF4w27hiQyJwqoBQgiaACcIwID1ASZsA+ylGSEsnXkic52nNW4jXiTqbR994npCAO1wWMGykHM2jjg24VbnXxguXTN1gqW/46UUgS+ZNjc6QqrcDKw/foHAeXHV9HTvL6SSw+oCNFdQ33GtJj4RnD5NtS7bchFiFvZP9RwwiZtaLrIYfN/jHABjh3HlrkKh+isVgrCMUEy2GQRoAvTmBQcO6Nw1aKvPxK5SqCGt3FcMRgpbt5eGHDKKQ2xMtzyf+2Xasa4/w1ri3ps7bknxMSSrZ0rY8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(39830400003)(396003)(136003)(376002)(451199021)(5660300002)(86362001)(9686003)(83380400001)(33716001)(6506007)(26005)(186003)(53546011)(6512007)(38100700002)(8676002)(8936002)(478600001)(6486002)(6666004)(316002)(41300700001)(6916009)(4326008)(66946007)(66556008)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDP85mJDftlgjWP5oK+8SBPK6HCQI51UChCRwPPejo5IHnvdO0GiGRL5QZA+?=
 =?us-ascii?Q?Plddh1L8IY8a7N3LBbsU0EUe5Mzl5YIaq+IL0Bbps9OxT8PdjC+dSVZJRF5Y?=
 =?us-ascii?Q?otW6G2FDDKk+/ZSpFKc1j+7R0CJBsLb/ASUPUdiygDfxU8K1PzkJ1M+4+xq3?=
 =?us-ascii?Q?/Gs7cGo8A8u9BSmNPVMKEt7RaRhXt7REExYaRjUwAR8WCQ2F49wK5zFFInSJ?=
 =?us-ascii?Q?kURLC/YjzVayETpuVgSVX59Wti/ZlgrBclUSNdy1dHJqU6JBW02ZRZyl8v2k?=
 =?us-ascii?Q?H+Ua8868JM7nx0chl6yXYmVx44XZT5pJ0StDyHj+S4pSZ6djukuOg7atO/YJ?=
 =?us-ascii?Q?/7AsAGlBsxnU9NaxnSbNeax00fQaWyFPpSuDGNhGr0bkayiiTyLjg2h0XLth?=
 =?us-ascii?Q?YGJN1n8+K94GSM6iAAJuDGUdJt4/DwGUdm+U6pHclSHODaBNQqpUuEFCMfcQ?=
 =?us-ascii?Q?qqGVvNz2LmPjsR032lGrz3KhxnjuYjfu+7xrz0gokkZZNgymPUYCRRNyKI4F?=
 =?us-ascii?Q?z8N+jNGY0ac0mo78jFdlKW7A+wcFxD7NthYBgcMIhfg2gweRgRRGsq8bAA5s?=
 =?us-ascii?Q?o3cwy4fNuajPnT/wa6bgKShtHBPvPfSgPCefdpzeKSTgA7a6Jp/HNDvkjuQO?=
 =?us-ascii?Q?kSvJGwY9kppJ3tswUZjgJpx8jGIX01LbjZDoPqxKJc00efhFC5/l0B5iOy/r?=
 =?us-ascii?Q?PGq7De24tuzxgg6Q4Fyx5eRc6eGW2oga4BbmH/feeVHe/XphYPPPqZcjD2cN?=
 =?us-ascii?Q?IbJtVdkGEiK8IvWUks9spZQeCKwxHxmrHMWlQqYgtw2pRP17EZ5HUrvCpE+7?=
 =?us-ascii?Q?pOF8vUFIk4Dk7BXONbGBsA1gEbC95OoMB6f/07sUsbggL/5Mc+lcsL9tBn+k?=
 =?us-ascii?Q?9H99R3R571IuaczcdweZVHm+RzO1hSuM8IT/PPhmaMnRUWGF/1626oRJqqhn?=
 =?us-ascii?Q?Qf4ZBp9X+HCHUHDX/NPdDfLgtJb8Mzhe4iGK+npnsmWPZTO6UKIXxu7+UUjA?=
 =?us-ascii?Q?eyKpA4iS7LO8gaIBPCn0yfDV0eAikYQXmkQETHRcvFQfZwdT2d3y5k2AU19a?=
 =?us-ascii?Q?Ae59XsHSGn/Dn5uS7YFBd4s4VB2Re/TQeUp3UQhAQSWdpawbv+n9+NhOsLY2?=
 =?us-ascii?Q?W2fPLLBeoM1338/uP88EBPB6aBd/phBpSEHw+Q6GK8kh0nDPN+1tTiVGqiDt?=
 =?us-ascii?Q?TORtNw76u3NnBFMvPkZyoDJf7mSb/dHx0zqp6PCxgC2n8HskzkwohLImY4N9?=
 =?us-ascii?Q?E1KMpHnYv7tkcCgemb+u/bESmhs818+fD7gdsre5dOejBtJLGehNlHbUPGeC?=
 =?us-ascii?Q?ORM07g49a+XZCZFRv+tb0D4UsZku0EHVg2LWDXF6Uas9Dpr40d0i6bqSTD2A?=
 =?us-ascii?Q?IeOVqpTNU85DKgTd6YJffx2zs3hvE+lQbdcwxqQqQWjGAMTs4B9HikuvmKq+?=
 =?us-ascii?Q?YmT8dacMLr4lQtXNkeUcQY89X8RZnmcdd5nL7N65C6TM3Y7FHpWg0xze3Jww?=
 =?us-ascii?Q?KEn+9JVGpoATvrZ8ZJhR00DIhM/xkHINUPoYt+q1Y8IQcJoFY7rDlU1zDkaW?=
 =?us-ascii?Q?JRjJQsf97kPHrKPAa4uexelw0lehwl39HgRdWYln?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3292d0a-bc28-4cad-2c9e-08db4a5ba40c
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:49:26.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLnTdwJtztvRf7Xnv4D9uMBX2VUuMqizkhyN6fKm6RKdLK8o41Pd9iTJuSn/+4QYYRWkkEyGCBNXbS4sFSu/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7562
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof and Jiri,

On Mon, May 01, 2023 at 08:37:49AM +0200, Krzysztof Kozlowski wrote:
> On 28/04/2023 19:09, Jiri Valek - 2N wrote:
> > Hi Krzysztof,
> > and thanks for the review
> > 
> > On 4/15/23 11:10, Krzysztof Kozlowski wrote:
> >> On 15/04/2023 01:38, Jiri Valek - 2N wrote:
> >>> Add support for advanced sensitivity settings and signal guard feature.
> >>>
> >>> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
> >>> ---

[...]

> >>> +  microchip,input-treshold:
> >>> +    minItems: 3
> >>> +    maxItems: 8
> >>> +    minimum: 0
> >>> +    maximum: 127
> >>> +    default: 64
> >>> +    description: |
> >>> +      Optional parameter. Specifies the delta threshold that is used to
> >>> +      determine if a touch has been detected.
> >>> +      The number of entries must correspond to the number of channels.
> >>> +
> >>> +  microchip,calib-sensitivity:
> >>> +    minItems: 3
> >>> +    maxItems: 8
> >>> +    enum: [1, 2, 4]
> >>> +    default: 1
> >>> +    description: |
> >>> +      Optional parameter supported only for CAP129x. Specifies an array of
> >>> +      numeric values that controls the gain used by the calibration routine to
> >>> +      enable sensor inputs to be more sensitive for proximity detection.
> >>> +      The number of entries must correspond to the number of channels.
> >>
> >> Most of these properties do not look like hardware properties. Policies
> >> and runtime configuration should not be put into DT. Explain please why
> >> these are board-specific thus suitable for DT.
> > 
> > All these parameters are intended to set HW properties of touch buttons. 
> 
> I know, but some HW properties are software policies. Consider the
> simplest example - audio volume of a speaker. It's a hardware property,
> but it is not for DT. Software should choose audio volume based on
> user's decisions.
> 
> > Each button can have different PCB layout and when you start without 
> > setting these parameters in DT, then touches won't be detected or you 
> > will get false positive readings.
> > E.g. 'signal-guard' change property of analog input from button to some 
> > type of shield.
> > I made all of them optional for backward compatibility.
> > Maybe 'sensitivity-base-shift' is really not necessary to have in DT.
> > I will remove it if you agree.
> 
> Keep only ones which are not policies but depend on physical/electrical
> characteristic of boards.

For capacitive sensing devices such as this, the threshold is specified
based on the size of the electrode and properties of the physical overlay.
Unlike speaker volume, it is a static property that is often times advised
by the module vendor.

Based on a quick scan of this patch, all of the properties proposed here
seem appropriate for DT and are in line with the properties exposed for
comparable devices (e.g. azoteq,thresh).

> 
> Best regards,
> Krzysztof
> 

Kind regards,
Jeff LaBundy
