Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD56A114D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBWUhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBWUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:37:22 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70F1EBCF;
        Thu, 23 Feb 2023 12:37:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUoUchVxkDonE6Xt8sErdWBArrKBmssFL57ew062nMv+nM/Gfu+qPCwZFZflL2o56EThFALb8QBoKjsyHEtDELYovx3gQSOd3MBFykQsRjzYRgVZQLZcA7AnrpZqoSy6yLxUDOotfcHeW10BtcpluVq/qNwn/OAt2JnQYJFfS1QY/7FkDmSnJmqMiNYpmpnbL1qpNmxCSd5fCTvIJ4V5Obs0hXJFPXq8Osq9v3NDogukeDsSeADfbmcBDLV95t1mVQBM27mYJipUht25d5eo7UFWwXHHw1n9KImHNPuSg2y9AOtHsZuB4pbhDcSnmjj7lJEjZZgcfT2qMcix1cBoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gnawgZ+XU9KK6LlOaRjxljs33HPDeuglV52CZZfAbw=;
 b=NWS+qmoP6bylsjC8caBMONGHZeD5WferDSlCK0tqHhMRV2LcKTklxynfD/Ln1yK8Ti6bejiuhROA2O8qFBMv6GRcQYhAt8ZGPBEuptaIvkmHpy4irhXqh4CEXYyDV06XEVZU8Ih8w2lC0silAv61pMaaN8JuB/zzTuFbx4gBHGAt9YfRnVr95QexL+juxDBdWWNY8EsQfu1laFe+SIjZM+RArs9lW0Po0/66L4NJOCez/jK4WDQqs5PH/PPJybD4FZ6hq2HZJ/GG85KRlqoN9hbb4GNaI1wmu0Osd3+Vza7Y/0+307mJSYRteysX35c+ZBghZgInwE4hqbHfX9IbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gnawgZ+XU9KK6LlOaRjxljs33HPDeuglV52CZZfAbw=;
 b=iQ++wabt3AZf/z2sETEFj5ShTnfnEwWbCf4UBBncF+0F5/dWQwWqtrQiGMllQnOd5yC2m+UNi3P+Er9q+fQxAL31d2sf5/NRnrmNBx2Ara5Zsy30O8W0Zby7KOsi9YahC+nSdx45iAepOX2hwuSN8dKkboATDPs2Ylv985vuz7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7486.eurprd04.prod.outlook.com (2603:10a6:800:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 20:37:18 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8%4]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 20:37:18 +0000
Date:   Thu, 23 Feb 2023 22:37:13 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Implementation of fwnode_operations :: device_get_match_data() for
 software nodes?
Message-ID: <20230223203713.hcse3mkbq3m6sogb@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 2823927a-c5dd-41e8-d53d-08db15ddc183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OlLm5qMjF+m6YTMzt7sPzkngL5TmZUewFmJDm4+A8z88ij3566jWf0EYEBJotNaEJ6ZBHCIdt4TmdtkcR0sm/3dWMjxM4RwQrU7Zh6SwwNU3ZV+be+UujZjAjLZjDtljJMVpnm0dyCPTdroeNYaQyaOxSDpEa1mOoPgVLpnzbm3OIAeSXzwk22Bycu+4GG8Tqj1DszBEZhY1dtmXG8pxxciUay79dJ66It4+IWEZH2dLBla7zhzFmMngA9VOUpIDPOQkFmgJdIxx9oBkIyDZoMm5SCt/Qgymclz61CvsCx8K3nUW3nuSoS2LldRU0xFvjhoI9+7756trzy4S8ZjCyxJcPDgQRncgxepE11U4whqC/ljwIKSJ4oGjfNSve079VPfnAwcj0XWX9fxkS0EXWJRPfx3XzA5BUj/Tqax/Qn3GciVM3fiUoymi56WmtMctIj+fbudVQb3VyazNGAN9NztfecG56jYBkVnZN1WIOazK4UZsSznAOtIAhBIOszkXk6/H4WczK8lIU+2Eh8HgSbeVrspUFBIA7KTm5eeROB5fTcY/8pvb2CUuQzY7jpSvVUYGKcXmwET37bZ79UVeu1lvqEQSn85ist6UC9vbBCbKnD9eHTO6ChIfl/MnDNiOg7KPA5oBZ0QptUALN0guQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199018)(6512007)(9686003)(186003)(6486002)(26005)(8676002)(8936002)(5660300002)(66946007)(66476007)(1076003)(66556008)(6666004)(6506007)(478600001)(316002)(110136005)(41300700001)(33716001)(86362001)(44832011)(4744005)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2N0zyjl4BYD0dZy3VrueldZYQEIIdMHMdUqsMS39g1dIvfomKzlsnNoFIEH7?=
 =?us-ascii?Q?SZckiDsQcyFaytN64mIZp1t/zv+uTzhewuolPXf7VACXgFsqFFOuFHAY4un7?=
 =?us-ascii?Q?PbGBTPRDyN/BJrDah8n1f24ah4Rh6jIJeKr7p4JK6w5jzJynHctreTgwDVXf?=
 =?us-ascii?Q?/ALSyXrRczbRfI/sJlRrF48aUzhlwL0iYgrQSs3ng8nmd4c4Z2zvrZiB9bRz?=
 =?us-ascii?Q?xva7NYY80aciww5icQ02uA9TuVLnzYGBUkflWYFl+jNfIoOOequRZ03Jvt/m?=
 =?us-ascii?Q?pJ6bSci1L0/q2Wqy5XE8rT34Ek6ykqHY8ZFl9SEcr6o8tClYplRUSU3Zh58z?=
 =?us-ascii?Q?eIpU8zLebNlmbcn/CpWe+bqPBjG2dAgKe9DcsGN2cY5lmER950YEKDrgu4Y7?=
 =?us-ascii?Q?CK5LVpcwYpmmsnql3mN4OyFUYrWjEkMX2qGmu12ze9x/QhOkS72NJiRyt+Mz?=
 =?us-ascii?Q?BUecphXEoKJbbHA6tDzzDRH7ff2Ij74Jo3/+s9HVF5D4dn0Fj+h2WKz2DezF?=
 =?us-ascii?Q?Nx15an96oWfs+Q27SH+lsINm7+bTOR92BeiTQm1mZ/247qY5JWdNybGD4HpT?=
 =?us-ascii?Q?CiNxTHnbOBxY1IPt0Xm6odrVDoYRMMgktTvwqPoJ1vbg2Ajs0xx2eMFqjKlZ?=
 =?us-ascii?Q?yhOJbFW2D/0JkSugR6arfpcdfnLYhj6/NC3hsOWoLV7LBZY3lXyPZ52aTxuA?=
 =?us-ascii?Q?X3a+km92uoHgCs8Dt/Kl7UB6IjVGP+pFuEa8QAEWGT6KNBqzSK0CjxiiXoKU?=
 =?us-ascii?Q?s+Wftp4EA4H8R+YbetxbkGCch8bbqlywq3UUsYE9mBoUgzbo/kd431tYM+l8?=
 =?us-ascii?Q?6sgrGltjTDTgdP3Caed2OJ/kLo21uvWLcvm0l460gA8ediK4zzeCG+PEQJgP?=
 =?us-ascii?Q?JrbE4nSIMjO3WgnFKlQNaZuubok2rM6Aq4yzRWIQqqvirc9JqNoauyLF/GXE?=
 =?us-ascii?Q?GB8pu1wbMoATggc1v6dcwDbIIcnwHwV5Dx6ALoCUcTtfd4Fw39eTHXO3jcNl?=
 =?us-ascii?Q?5MbY5EeE38K1kLhGGTOhI4tLqI+xntt8evu+PoZaXrYGfefXVqe7pffkyLT1?=
 =?us-ascii?Q?aJvss17x5bmJFWDz89dxyf62b0exXhQhwhc1+0yqalVM/31g4oGlUs3QgEhz?=
 =?us-ascii?Q?h3zC6fapWbZU3zVo0g3h6dBS0oLisj+dPk4coyN7tmjkH8e/0v5r2xO2fwpb?=
 =?us-ascii?Q?didmWs+qUIDn0keL+FN28Y0X4UwZdL2bNe0ZYO9H8tusSdXQ380PIbsZ407s?=
 =?us-ascii?Q?lkEuUrRFPeHDyO3ymKJk6z0+nluwhX5DxQ/Brw/eeyxFYmTZI6MqSmkMMkID?=
 =?us-ascii?Q?4gNE9mTJ+5YwY3a0C1gNwfNEJHzfBVTkxRJMOF4rC2B+tGdZDTcgxNzNMRfW?=
 =?us-ascii?Q?4jKkOKf84wrcqNID1vQgk4waAkPNc6wJo0HmBAOaK2Vr++k7lei/VTtNsa5W?=
 =?us-ascii?Q?Zc4Ykiq75oiRK9RPh/gAScUXET/D2papSkmQiKrD2ismBP6Yzyis0v+8MTUF?=
 =?us-ascii?Q?9R7i+3A04na9FLg0j/GjjALnsKRt7ZPRuNVRYcp3QCTa43BcjJu9r7DQWEno?=
 =?us-ascii?Q?yXOVHAo3VJ//gVcOD5GBfMSXWWBcI1S7eX4AvPlsRyERadR+PaelG/ZYTXjn?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2823927a-c5dd-41e8-d53d-08db15ddc183
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 20:37:18.3217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3vyRpGJUmRexOOcvBxo+KdsUEdSZIGoyyYlphNOr80MilRLE/HOQ4Lil6Gs4M1wkj4Y+9P9e/sf0N4KM6Sijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a need to instantiate a driver written for OF which calls
device_get_match_data(dev) to get various information based on the
compatible string.

I am creating a software node based on the following properties:

	struct property_entry props[2] = {
		PROPERTY_ENTRY_STRING("compatible", compatible),
		{},
	};

(I see I'm not the only one doing this, some drivers/platform/x86/x86-android-tablets.c
and drivers/platform/chrome/chromeos_laptop.c also do it)

and the driver in question does begin to probe, but its match_data is
NULL, because the operation from the title isn't implemented for
software nodes. So probing ultimately fails.

Is there some sort or reason why this doesn't exist, other than a lack
of need?

Can someone please help me with an implementation of this feature?

Thanks,
Vladimir
