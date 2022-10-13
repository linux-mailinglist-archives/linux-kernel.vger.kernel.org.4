Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DB85FD4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJMGkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJMGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:40:15 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150100.outbound.protection.outlook.com [40.107.15.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2149047BAC;
        Wed, 12 Oct 2022 23:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLFhoJ7hob/mSMwMHKVPtj8PIJLqqTQFQ1dWYLknrbNoRxbckkfcP8UVzZ00W3zOHl5HRVdR1+6Je22JskUcDwarh8BTD8LoBaRB3+Q7it67k0GN6Bs8tBcjFRQipKNqgDDEHv3Qtgg3A24dYhCPfNbECwF9npewTR6w74fVOtLtsWVqMEI9UbWXRidW+DS7GUfV4PGBoLJEOQIqETBTzYOJztiE/5P6nnNlwDNsXMAoN6E1VAVEFxHVYCAxlKE/GVuhE30h+bQtJToKkDy0BijjUifix82xR+PqntOu59CIRONxJ3J0pYmOPlDr02KgoLZXKXrol5h9hJ09kUBxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irguFIaDaA8Fhcf7eK+h98j3V+k//G0f+/mQwRfNAXw=;
 b=bKEtgiILq2/c9e5TIBrp8uYRKuOWbErpQ+uZM799y0aKxIZP+8bwdBO6mc/Oo7tZtozhJhmfVe5STI06ese57x+CXlPvofEElwK5ZISbsD7DuSbNoHi4V2cnd/tB5sErqlASQw+JTvZK5QbvZNjgq7wrb7ehv4RMcus/X++Fll8SlTSug7qZ141LEJdEeh5/Cm2j78ZfbqvDkpfjhmnxhZsoW5oCA/rPm4KENbU1Ob2/Y6saxMc/LXMaC/rV34A34dqhQ6CxuFXieRj1Q8ZPyP5R6G17HO+2K8U3s6RoR/F3/4qvWZVSnAKsdNhT25CwrT6FkR+tZDibPOEwGnyZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irguFIaDaA8Fhcf7eK+h98j3V+k//G0f+/mQwRfNAXw=;
 b=mr/uSKY1yH7tEGdbupEvJ1M7zGUpdbM7NV6mmQFvkAksbH6idLBE74wmvzd73xZq4YO/UpVJ4rWW8KL7qY34be9xj4USpaXrI5mWiHxR7haTRsiTyF+e2chPrImwvXGTTJkHe4cm6UGcmnJMdp8SN6Zijgin5kRfu0RQlG7oAf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DBAP190MB0887.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 06:40:05 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::96d:7759:a68d:c5d9]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::96d:7759:a68d:c5d9%7]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 06:40:04 +0000
Date:   Thu, 13 Oct 2022 09:40:00 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>
In-Reply-To: <3b88438d-1bb0-e980-b4db-1f8663dc6042@arm.com>
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
Content-Type: text/plain
X-ClientProxiedBy: CWLP265CA0423.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1d7::9) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB031779C030CAED8026D53D1895259@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DBAP190MB0887:EE_
X-MS-Office365-Filtering-Correlation-Id: f9658f76-1a9c-4875-488a-08daace5c299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJjxBMhW6EkBOCB6r+1MzfNF8f+Fspo9PC7ziQmaWOXmkGuzc3n633SBBKMF8PbDVgovV7LzWgs6f9vtOkrmCeZqeCB/0nnLqYib37R4eKJiiZ/2VGhDviK6JQeQxrUH3wYTne9vkW07dJEKoeYF+ZzgK2Zke48tvgRMiiiNd02XdxkGL1MUESAN3rMBh8gx6iBRCqtHDen8ZBGohbeJ9aM6H5wPjwi7NPimwQUg476r5qKGBCH7qQelikJiOdmRmgzMRjq2PDSKAuI9wvF/nAkLcjHDTYOUhP1c5TRnKwKhvKv20lj3nJTRLNroWLRdqi3Jy1OHRCsUa9o0KhP4BfUnEZjKvxP5Y/l3m1vFnxy1GZEvi9m2mU02YVJAJeXxivKYPeUcrqcggolToYQAVNtu1t7viE/5MNxRyThCgemSk7gyns/+xSM3YVFpxXYbOD2a98uoNKv8AZRoXLSDYv7fpBFBPrS9go0MeFhwRJ/EwCMLsNrF9eyUE/T7zcfJBxhbb3+5cV3RIwEzPEvDCO+M6bHD7iKkuZijRJWi7jov69lTPBBbJxLYXid7mZ6fRrPfZVWdDMMvbLpatfOXszhx8s121fzBssn1SuXCDKEgrg0dvGbfWldCY1su41f9v4AzNbPgyy/XLVUwXolHrqqYsl2CvWcVr3lh1OBExuDU0WYEkX2g+GmDMHKeVcsJU1crvApqv5hu0UD+LQclgS4ggD1kXjOyGA44K3E8P7gmQhevzAfjjvXbdTyXXIA4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39830400003)(376002)(451199015)(186003)(9686003)(26005)(52116002)(53546011)(55016003)(2906002)(86362001)(52536014)(316002)(33656002)(110136005)(8936002)(54906003)(41300700001)(66556008)(66476007)(66946007)(8676002)(4326008)(6666004)(38100700002)(38350700002)(7696005)(6506007)(478600001)(7416002)(5660300002)(44832011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2FB8CsdlukcVsX1zyNqU3+HmAM4mJThuYPjfSC71DRBBKn8yJVNRKJpLxlrP?=
 =?us-ascii?Q?E027pJuUNe93CI0T4np6irzAkBudiqrJveL3cPjHZiqi7uTs+dTcAFDXMjXb?=
 =?us-ascii?Q?ws4sNKz5Q0rs6JpdvapaNjcBaqy7wrOLo08W/UzxVh0Eu7BIUhrEKRR5L6BF?=
 =?us-ascii?Q?VYKioLkWvBlaoD/cMUezBekIAroo6SE5TqaooHFQY+yH024q10roKD6LnEDW?=
 =?us-ascii?Q?5KKye9QJV01iLBFz9zByPqH76nd49fOET5mAA/bkIVEeMv/CF0zS0otgv2n4?=
 =?us-ascii?Q?v/gPG8JaL8ra1gnE8x0VPJSdTF7O/OnfSjQ3z9zb+pGy/eKtIoG2SJHhSm9w?=
 =?us-ascii?Q?JhyCw0rZBktf+H27U7BXSRzw3Z6yLCIr4yZgTymBj/wODnj9o9cun4G+XgzE?=
 =?us-ascii?Q?xy3b/H5iHKwQsPS4vBwF1gl2tTfZaQB+HT6bLy316h+fFILk14Xs5SQzeaS2?=
 =?us-ascii?Q?NtqJZZtna4i6KZcujsHdyNtAPDX6jKf/+rvbN4BWtDhYbI4mKaYuVtSM8Zm9?=
 =?us-ascii?Q?/j6g7aqsgrl34aN/Fou7rRWcqvcKK7KB3Rk7mvvOZh4ZfPc8+HyC8besmj0I?=
 =?us-ascii?Q?ZqkxwaaxK61+vg5wzd6y6q4FAzd9gsNG7Bx7teq49vR55A62FIfNDr/p5Nxl?=
 =?us-ascii?Q?keI5qZAux8FGDI0jEQKYznyYEJxBI7LHS1MoDsRqJIkKYyGb3/04bUzRcpoN?=
 =?us-ascii?Q?2t/EodnOzpW0xufQ0KdtOmiQk8lu0pJj8T99lzHA6JF/AIZ5CpKq5OCiY5Vf?=
 =?us-ascii?Q?EknkJj0O3wGHVezBKkP6pbDjtOME7f6g8qVw1FFk2ap9cUpJ4KS2a/rEbqQI?=
 =?us-ascii?Q?vjwe9lKL2wK9PAFKA6blhfV11/sRtVR4SkHvCduzFFAfZsSYMKgCEroMeo05?=
 =?us-ascii?Q?9q1u2zyc0zbRnm4OYdWSD23FhGqqkZe8ZY95UIvVKRM8Rw0ax6CEevtQ4deY?=
 =?us-ascii?Q?diDLE0MtzuIIyMnC3AuR7lGRqzRYA+rN+I7eRGQS6drWpJVYVr5Q62ZgSh4f?=
 =?us-ascii?Q?RLLUpcYlN82UkpsMox2o/OKJPN/v5SicWUsJr6YwFyuunEEuA2QyLO5StBxR?=
 =?us-ascii?Q?w7Vc+GVpPhwclPgiPpC1qGWsS1esYeVCCdfHfO8jW/Db3ZI3ChED9N9wm2cc?=
 =?us-ascii?Q?Ti0soFr/PCZy1vpjwVPDjwVEoZotFSi98nF+MeDmV7Fa4EJ1aVVSEddffEBn?=
 =?us-ascii?Q?bMCnlmp5Yu3BTEyzmGhjLNpU/kVzDcLnxFKN/Ytwdd2JVB4qnO0eKPHTdaXZ?=
 =?us-ascii?Q?Fg70xtVmQsmBZJi4yqbcbLdSwxD2kSH0Og0hue00CWUuY/B4B/r8IgpUMGaE?=
 =?us-ascii?Q?93brp/3LCMg1YoZId+lPYRgvo+kVIjA5UgJQum4SF1h84khTMMj4CoSZrumy?=
 =?us-ascii?Q?heUnNoNtGUDWn4CyTd++nbNXi/p2gPXM5IwnQaSH38rcFlgM8TunIdjQo7SW?=
 =?us-ascii?Q?VG/9Kx3weUdIcDHv7DiZ7+RIfEarYiftuzw+mxUzGVipwYrizj+pJMIKdZdZ?=
 =?us-ascii?Q?BQr6hvJmiGiqRgxDDvX7J8ufpHK/la1EMco4mgjADtkCXRHyOSJ/8Er93Bl7?=
 =?us-ascii?Q?Jspw1RmHwNehlb5Z+aRsM+cQ+cQ5Rk2xFd34zjLRLi4glM7AdFyZEXWwtZOp?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f9658f76-1a9c-4875-488a-08daace5c299
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 06:40:04.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OR2CkkrtVX8pZ/AaAOLHAqmaMZQneHWBZTpy4yZMeW+jl5SHevwgPihDW6rQu3yXB3ublZyHW9LpMLbum7wEo3Ddb4rRUbpTl6F+lCmHo/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0887
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, 22 Aug 2022 11:06:43 +0100, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-08-21 07:17, Christoph Hellwig wrote:
> > On Thu, Aug 18, 2022 at 03:07:40PM +0300, Vadym Kochan wrote:
> >> It works with the following changes:
> >>
> >>      #1 dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> >>
> >>      #3 swiotlb="force"
> >>
> >> Is it OK to force the memory allocation from the start for the swiotlb ?
> > 
> > It should be ok, but isn't really optimal.
> > 
> > I wonder if we should just allow DT to specify the swiotlb buffer
> > location.  Basically have yet another RESERVEDMEM_OF_DECLARE variant
> > for it, which shouldn't be all that much work except for figuring
> > out the interaction with the various kernel command line options.
> 
> We already have all the information we need in the DT (and ACPI), the 
> arm64 init code just needs to do a better job of interpreting it 
> properly. I'll see what I can come up with once I've finished what I'm 
> currently tied up in.
> 
> Thanks,
> Robin.

Sorry to disturb you, I just 'd like to know if you have
some ideas to share or patches to test ?

Thank you!

