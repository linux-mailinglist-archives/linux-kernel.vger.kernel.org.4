Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE66A723D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCARnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCARnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:43:18 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8A7460B7;
        Wed,  1 Mar 2023 09:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaE4ZvuAoah9xGT7VdvJG4Y9RiqE71SW9WF+BU8vw5TNroC9JanYHuJ6gDd6I9QTm179ZcAHY4NKYMiq6jfA6x4DL5OXRZQ4QWl6oXfaKD3BY2XyQrGw/BbhcVuz6+R/7MLBcivn3xawCO2se1YqnTqfXz4mLQ4ZYuS4Kl2UPS2nu/jdbXCGxBclVVqfdaB2w+D0IKVt+4wdvjNnNaIdZoCFZbZpGhziS7NTsRE6pD4Dk80++ET7VwnLSqYaA5Scb2zYadeMav5Z3ALSq61JMII54N1Tg6XaUiA3tp/dqybt4Ypl21q9a30xfxvnEO79JMOm/P3msgSm6eSGtqZuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK9H0zqPpAvrUsbNgS7irgzAFLt3cYeaH7XzIqjVWrY=;
 b=RRLcKiXnLkUGMtT3QyxH7oI9kMhAtfk0jhtnm2msFxfdefqp98ea2S7fgZsX7dym5mPaeV+Z86mCFspKEh1YxkhEt0or1wr6nPJI/XZxwEwRpoKVg1uIbY82xCBUDajyuWmSekKKr/xV32ld2IjNmSnnwUnyezCpQ0pH+oMzvQBCoGCWPYriD+R6x2yXjl6nx/ae9ATDst5jmvY3O+n4fWyAH7/aSohK1h8zSkfPBoM+pzWz8hiHkdkxnm5R4WNM862VrW7mwJ1fOnBpToGgACxOpgYO9jwSfMGkOz2HsDRc1JsCseNZAFoXt+6Rvr1IfBCYkX4QKRcWUiPxX81HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK9H0zqPpAvrUsbNgS7irgzAFLt3cYeaH7XzIqjVWrY=;
 b=iAjHQHnSRajoTWAHShhB9SnDFDa1O4XEisVLJnOT/d3tFtqdlhZrWdS9WxPH/Nr4q91gK6ftUmeccFLO6sNyfT1UxDOLTyqi7c7tjUz0IQ9ayqdwL6YvEeAN1reo5CGt8EIbWm7gKXmJdgTxoV5E/okb2NyjEUA+gXyrQetEZ5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB7143.eurprd04.prod.outlook.com (2603:10a6:20b:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 17:43:13 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8%4]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 17:43:13 +0000
Date:   Wed, 1 Mar 2023 19:43:09 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <20230301174309.5nqul7vg5uygwtpy@skbuf>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
 <20230227234411.jqmwshzkeyx6iqyo@skbuf>
 <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
 <20230301143625.7kdnzujlv4psbhla@skbuf>
 <Y/9qtT0vckSikOKJ@smile.fi.intel.com>
 <20230301152527.khyzifds4w3rkebt@skbuf>
 <Y/9wlDkuh39auAgF@smile.fi.intel.com>
 <20230301171845.oliqbso7v2vmyqr3@skbuf>
 <Y/+MaRO4vrCRFXE8@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/+MaRO4vrCRFXE8@smile.fi.intel.com>
X-ClientProxiedBy: BEXP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::20)
 To AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: f70e13ff-8030-4788-18c1-08db1a7c6e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnNADayjmI5zTlw/RKfHRCgUcEmQG2CJ6Rpu7Et3VHCvbSDLIjCwmIX1j33HYryL2PqSsJfYWCaQSxqmFb5B1vUKS8+uPSsm7Tt8EGk906jBsOKuAouQTQmOr/LIWcRBR6dkh0F3cphf23u0wtNtR2tgtjQPRMYa7fh+tLGSyg9/IZCiyvM2Bsse0HF2NeMwbWKIudeDKWrC4vRgZx4VoSK2va4aC8iGeeq7AVVwbkC875FzP55BnNNem5TZ03hlVUkXkULxyf3olzugEF3W34B+elKV4D2cmWjXpFhBP1zdGo8hRw4Q4EnlTlJLiNeakm9uIJ0cW4Y5z9ENL0ZRAvJmClIR3es0cSDSFvOSOz6c0TYMdR27h024fpuf7ZyMjoQE2FUVn/h4wBKJKd5SvLogZgsYVuNtC8ZTtOr+7Z3rlVySg6W//cB7DBnQ29yodPDAXW3+5XvJjWnbKvq2qCMU8YXMYDeTQOgqqhw78+WfA0zZmqlOUCuDxOXAqwyYai5kKPc5Ajkf+Hv/D1+14kql8Syp6m1ArR2QE4j192krG26SsopfXunQ7HKXa+5az7DpRIHMjP+t8GMaa0mI0hnzW3zbdYj/Ot7eP+GrCFqiKm4L8oqRHlGm0FmgaroZRZmbpTryKxyPxSsNhWWP4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(4326008)(33716001)(54906003)(316002)(478600001)(83380400001)(6512007)(6486002)(6666004)(6506007)(186003)(26005)(1076003)(66946007)(9686003)(5660300002)(8936002)(86362001)(2906002)(41300700001)(66556008)(44832011)(4744005)(8676002)(6916009)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RlFopo/q6OLlRE5zGCag4vrVsd3PymlV3BgSF2KR7Ewqca/ZYC5DlIF7RqaF?=
 =?us-ascii?Q?0xjRkabvA9w+bOUQaO2Hxd0CDkPQq2vUkfbxobGZ9b1D5NdeeTXMSB7GTPLj?=
 =?us-ascii?Q?ruaNoCxRZ0vYZAcNBsygvryHPFis+CP+cSP27qo6cunZUDwIBtYnTApJfxjm?=
 =?us-ascii?Q?ZGYRWJwUce2JR/XZKXkvHOrxZuAOPvGC63//9yPU0nw1AHf4anCNn4xuJONl?=
 =?us-ascii?Q?SnIIZwKtFfM3KcQoDDedLT4ONpZy5pNa20+WGRzP8yDMh5r9DM7+TLyNXqRB?=
 =?us-ascii?Q?hUOZ9r2Fwsg8gcuM9I7pYayx+Y6OH3sp4dGRVYf9pvXcFih+rsbeptzjjPQQ?=
 =?us-ascii?Q?Oltw9V1XPYP2sfU4hk+pUG5woJDNmopArnVxO+QyZyLMCntDJxMzKGFuwpnY?=
 =?us-ascii?Q?N3sKssi5SSqSGvN8RYoUgtk9OgSe00tWYPLC3ygb809/KNIVq6EEDPX6uQ6n?=
 =?us-ascii?Q?T0904S2ir5bHG5xRj/bc9nrc8a+BdWqH2qGs7LCVWMmH7nY/6QPqhARHR8Es?=
 =?us-ascii?Q?6sPVgdTryFpujcobPqz8uKWZj9R/laI51K/4IWo9IEKUSWyxzj2SLnK1zr5z?=
 =?us-ascii?Q?osB+3AtGhJQRRaiunjCnV7YH4QseaNgABXREf/vmY2VdqAwzZJHKVKmgKfGR?=
 =?us-ascii?Q?b3ploJeiTMekxc80n6wKCdzp3pK9m37dVgYcPY23GyF5jjBd0j1I8T836h3J?=
 =?us-ascii?Q?4J2kHRZNVulsz06Gl2OwPv5TVHPXRvxjXJzMEoznRene38NGOoNleuapeSR5?=
 =?us-ascii?Q?9550cXyX4pi3GXgKJh97PGhc0ni4vFnkssHbzGEnikXZHaJ6xmauwfeQw290?=
 =?us-ascii?Q?kmMaibBaW6k3nYsPM6yxWvAnbrnEOaobEdaIUD0scQAc+fPBZuLDo/9sekIx?=
 =?us-ascii?Q?7Ex6/PqP1CLDI/eVUsl9vZs5n0X3gYK/kJS3A51uKJvYI1mfualUuUiBU0uR?=
 =?us-ascii?Q?4Ow6kVx+u+/vYBhvPbojXj7AFZwTtrFJYqCBfqlO/An6FrRb3K0kFQ3jH9vZ?=
 =?us-ascii?Q?Xej0mJI4g3SO2NgeAQj76629R4OI5ZIoBM9Q3MgmgObNk4mW2Fpwmnc+zeKc?=
 =?us-ascii?Q?+mEoz5VNLfT6g+pPHr25lZz4lbh9+9XTB6zBjetCATuduWEXEzU3i6Ji4nJQ?=
 =?us-ascii?Q?0qGgjvT8lqN9g/plhWWhVffvIpv+zRUjsMCW31tVBnzV54+1ivE/I2vt9iXr?=
 =?us-ascii?Q?LfGEfgKB9ycWzYIjllt4X0x7mvWt+YMQ4d8S0pGhLb2BivY1MQ1m8VyMf4Ei?=
 =?us-ascii?Q?N54I6IGiFfRByd09yvMtn8ZuVgba3Ud3dS2EYiYYlEvnBZkLTqymPOqFedjk?=
 =?us-ascii?Q?l/WiTFCpkKCXBum6/ksOt9YMZMqVSzu3xTgyT7uB7l8VerF/Y0vRROz57ko4?=
 =?us-ascii?Q?w3UEdqHOI1GF7UDGhVTd3S62sivI3Nay0ILjeaBdVRnEQp6g1n/TYtCrjpAj?=
 =?us-ascii?Q?7QzHnsUH9sPzaLMftb+Re8En2os8/cVbCHwqGKSsEaHiuzCkiGJwHWVNxLA3?=
 =?us-ascii?Q?aVhsD1f4XtN9hBCyxWQVZ3XJ8igQIJw/4QeDqPxlobO/W1lztaHnUNzxjNw1?=
 =?us-ascii?Q?seqvJ1gW1QQPkoRnTHi8tDNPBfGSoG7oijJJ/2Lt2hc4DEYLjPl/0LuRErbY?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70e13ff-8030-4788-18c1-08db1a7c6e14
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:43:12.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y473j9wcLWtvypqLRNhBSRw7cSCjKcvsSxlFzChdq+qWtKGbVcBOe4w1/JrJvG3pL04yPze0/qkgj/PLwAn+0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 07:33:29PM +0200, Andy Shevchenko wrote:
> Yes, that's why I remember overlays approach and FPGA case.
> 
> I guess you have very similar requirements to get this done: your case is a
> particular one for FPGA, i.e. (re-)loading the same HW layout over and over.
> 
> I believe it should be discussed with them being involved. We don't want to
> have two approaches of similar things in the kernel.

I don't think comparisons with the denatured case are helpful.
Is "ax + b = 0" a quadratic equation? Well, yes, if you consider it to
be a particular case where the coefficient of x^2 is 0. Do you use
quadratic equation techniques to solve it? No.

I agree we don't want to have multiple approaches of doing the same thing,
but I debate whether I am really doing the same thing?

If software nodes are not designed to be a good fit for my kind of use
case, then what are they designed for?
