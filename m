Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47986474B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiLHQyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:54:02 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359147868D;
        Thu,  8 Dec 2022 08:54:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElFC1yp865VlOBwmLDJ75l5UX9oTSAcKL8+iehkxk4ze8pvrM04ZnvaPeGdAb2L8h8oz0V8mZOfdW9yAGi+/+8cg0fe8BENiwwRsGqS1JB2fonnCCflHPl/0UDmA3NR7EYo5kM0gca3qeV9nzK2+Nk4MtuGgqWrujXNkc5uARFhv9MCQ0NzjjOws6qLymFpM7/hlAZ5173lRabZEWItiZ6YrGm0qaMyVpfsIj0RqSuvWBZKYyFQQlSYBBH9EXfGXAna0xMTW0tCgRa34JVRY8iX3P41EBlL2pSzLudBLmKbIvEfEq68Q6pZRsQEEJXAo5On5ikNF+67cBcLheBA6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpPJcEAkHFRZlYIx4FyyggeOZiUlQ+dXNHAW/fc1TUw=;
 b=nbhze0dPCVVWJkbJ1Sgvj/WhHCUtldSadAdVeM1otif5bxVO8TknMeypiUaf6UdIbmhsTMaPY867LdYkQ5b6VUeZqQtBLnm00PR9xMMNRwblqlwUi9x9QKTAUlvEDvewv3nKKQvanpGzH9xsQUwFeWMTo8NCv130jyYOPmmWSl8SEZIlXMdNB8HnaBxqVADoHh02USJjOe5V8DqYxasCgvG+f23Andyx5X5vEDnD4jT+ocVKoQ5s/N2qZinEmgu+L/0DsYnSf/zlz+XS5CeQaq8XkyKWF9nh29sR27zcXXi+6RODY4XM0ftkojx5rbxzoaRXB8dSO1c7N9S55JXAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpPJcEAkHFRZlYIx4FyyggeOZiUlQ+dXNHAW/fc1TUw=;
 b=oFpGIN4YTyDz/57f+hsSb5P66qGrVndbghJb8bA8oGZvnP6Mj/Qoi/Yq5rOl37w98uNJA54C+Y1n+mwK0zKwXH7kLjwEPiuBJ3imQwfdIeR7LjoybLIFh8ycfa/uYN6Ppp54WAvFVP2VyyJLX7ZRvTyRWaM8j2Fo8SbHS8MLQnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 16:53:58 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 16:53:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gregkh@linuxfoundation.org, Rondreis <linhaoguo86@gmail.com>
Cc:     balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        imx@lists.linux.dev
Subject: Re: [PATCH] usb: gadget: Assign a unique name for each configfs
Date:   Thu,  8 Dec 2022 11:53:23 -0500
Message-Id: <20221208165323.3520326-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YxiHE9s4NDZOILpe@kroah.com>
References: <YxiHE9s4NDZOILpe@kroah.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|PAXPR04MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a372911-9d74-4eaa-47ba-08dad93ccb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuCUqVSWnfi3yqJiXouPEQRPpBAg0+Gbo8iQvx0hbLJu0tSbOUPbQS8s2iZGfYq/0eduqtkTguf3pGXoej/nDRTXB8XOE/wan1aH8XmrxcZZSaZNmBDKg70qNxWYt/zq5yqk6Bqr1JbnRtHsPZ53TRpWcZhwdt0etxvQz2ev9oeMd9IogrIQ2/JPfen3XjgC0bXFhUANhrzq/0mu2p6cwJ4VIKQP4lQsljP89QKvXzWoeIbro9kTDw2njihJWqP2vUQ4PZrjANhPi9RrNA+TmEorwrnkJi1N27QPwGH6m7aAiE0hIHTJHDCRUvWfOAjWh3pZa5mEhYZB/B6R2qg4/3Yyx4OYf0ySDo+OSTiLinVjKU/q8IGzyRLEmxxL9XY1xHH3cViplWCYX9HrteWRSuwGrOlLTwTZws1Z0mvr9wXKRHexDL1apMlnm8DY0fKpq+85rYLgyjIC6wnPqC/fdG+eUyC+dq143z8IFu8zel+OcTVq65zn9mKHTa2ni9wEYMA/ynM70H4G9aDv4Kj7NOvk31+kRJYapmXJ9wbDUFnVLidWe26dag+ZuXG5aDGGoBikgmlvA4aDBqJIF2MYK5THDm+MGDgXSWBCpVekFcjGgfNLH9EXx1puVKjTCbArwwjzJ/IjoDESDi7NfgqOItwrg1fi4+pU02Stal2mvsoqbmgN6rvIW/uojcSd6+YP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(6916009)(52116002)(41300700001)(5660300002)(4326008)(8936002)(8676002)(86362001)(316002)(66556008)(66476007)(66946007)(36756003)(38350700002)(38100700002)(2616005)(1076003)(6506007)(6512007)(83380400001)(186003)(26005)(6486002)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4nUL9minGzPDznPvhmnCZrCwrrXBUKUBYlaO9yXpZ2/XWBq9Gh5u7DLMDI+?=
 =?us-ascii?Q?pFg28zNPcu2WU/zOAeqDYub0tl5QB6zkY50zCbbSTjqPKC3n9eXBexkxgXHh?=
 =?us-ascii?Q?URfUnZocDFRwr1VKqqo1+HFTJZe2Qz+tZbR2rFakdC9W0IQ5UNw9EUySG9UP?=
 =?us-ascii?Q?z/F7cgzja2P58E9VMjTzHQvQ39I5UVtoqZA13CO6jO7GivNqZxq2gC8uB4hK?=
 =?us-ascii?Q?sLij/Zxg8/4MfGGqU/YBB6zqfTFbgMIfyF+M+U6YqRzpa4npp0W1Tds5NsCT?=
 =?us-ascii?Q?UXQ8tEckXDZohOwndRAbTW+XfeAoFBqme/nmxJHkPXzzE/IeCb60Z2AOp0Ho?=
 =?us-ascii?Q?OgQgPD8ypGwEvmuzogszIMG2WGJSyDUHvD4lx2eyVKtlt2iv0eK/zfxrIRn6?=
 =?us-ascii?Q?wXxc84xOFR/8ARzhBI4OtvuipcLwoYwg+wDQrl6HUH2C/Kj7kzu9uly5Z8Hf?=
 =?us-ascii?Q?oxtqlRvkvv+m9i2Pju6w7QCRiIkfr0MCRTv+mNKG7IwewqWe8/oKmD46snN7?=
 =?us-ascii?Q?XAeI3sBpgYAotB9kPzfcSYwor4IlzKzeYAdlCLxfpNGdOEYkSH2uLtVQv54p?=
 =?us-ascii?Q?CCA82spbQ2Uh0Qr1XhUMvvGzE3fIszbKBY1YVVLN8dB2n+34KIjZM1447H1i?=
 =?us-ascii?Q?3cij8H2ars1jRlxAscegpsb8ZOd4vuywpItOe4r9WzZ3mipRgm+XWAW5X/X2?=
 =?us-ascii?Q?DqET/IOBMdWOU/2sBzMq5Um7TcSb6LzYrY8AreI8TNYS/hIzyGZINwJ16nGY?=
 =?us-ascii?Q?TsZ2kr/trrgUPnyobGHjS+rYaCiPFUsoEy0TOOqXUH+KSuFNsDCawRL3ojCY?=
 =?us-ascii?Q?Lnj+7AkeVy+T54Dxlkwtg2OPaQ7CmX3mXyneyLUL6jvPMS7PJ0EeB1HtriPy?=
 =?us-ascii?Q?71dKMb6Ebc+plxppAv7NUuERisnlWpxjd2zcnXe4g8kSSQSYmhVFGt76gbcY?=
 =?us-ascii?Q?QdL11h4Q0ZHY1bUw72V/kgTHDuDY43lhQPnb8Bfhf15ly8Dm8XRmoUCqBHNi?=
 =?us-ascii?Q?LKZVQ1M5HK/Te7VppuajR6l5N6B1bRJ02EPCYDLA0D75iWjUCjSoWiOrW+J5?=
 =?us-ascii?Q?hZhrXZAeDXAbnPfOVV3/o7CcpTprOLs7pYEGxzQPrn+oxRX4VOTT6HZY98Jr?=
 =?us-ascii?Q?SU/9P5YTPyw1QiAnzXb/MDlVhMOgTfOeQoaJMXPJL+FMBWwpZgOGc/tIJjXO?=
 =?us-ascii?Q?pYv2sUS9hF/+h+2U/quXqV2LWdSs+/H/AVX7UnD4YeN9M1Q1FgX3g0ml0KaF?=
 =?us-ascii?Q?8Q7LZR3yGvo//vjhccljoYRaTqM6HrsUYaGGQTOdXvM31LLt7nsLtYSfuN+W?=
 =?us-ascii?Q?IwweWt/N9ykVNokHPsM8mr5J0jPUIWi+MZMf1ajmokRnIw1+ZHn5Qi+t+aS3?=
 =?us-ascii?Q?pZZEFl2qWFL17S07VHKD+97fi2SGcnJ/5lfgaR5i2JaCfJKaS6tbsA4dw+LW?=
 =?us-ascii?Q?Gek7mnMD9MZPSitva6mQBXyaonKbgim5/jZ8ZkybctZontEfeubHO9Fmhbe7?=
 =?us-ascii?Q?ai+ouIRS2ATNv10zI09AWBHrxBCKpfmMCqpiCmpY+na8kTqC8sv1AxszO7yY?=
 =?us-ascii?Q?x74RrR9Xx5u1mVKBFcZnOq3yQhDS+QAX1QW9jIDZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a372911-9d74-4eaa-47ba-08dad93ccb3d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 16:53:58.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzbZ1tqeg2oJU3qKMjGnnurfx2dWV0EMb2bXHl24Za+/NLAJEi8762XWPMqp2YDv9qO1APwURTkvFJQMg/Bd7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Li <Frank.li@nxp.com>

On Wed, Sep 07, 2022 at 01:57:07PM +0200, Greg KH wrote:
> On Wed, Sep 07, 2022 at 07:22:10PM +0800, Rondreis wrote:
> > When fuzzing the kernel, I couldn't use configfs to attach more than one
> > gadget. When attaching the second gadget with a different UDC it always
> > failed and the kernel message said:
> > 
> > Error: Driver 'configfs-gadget' is already registered, aborting...
> > UDC core: g1: driver registration failed: -16
> > 
> > The problem is that when creating multiple gadgets with configfs and
> > binding them to different UDCs, the UDC drivers have the same name
> > "configfs-gadget". Because of the addition of the "gadget" bus,
> > naming conflicts will occur when more than one UDC drivers
> > registered to the bus.
> > 
> > It's not an isolated case, this patch refers to the commit f2d8c2606825
> > ("usb: gadget: Fix non-unique driver names in raw-gadget driver").
> > Each configfs-gadget driver will be assigned a unique name
> > "configfs-gadget.N", with a different value of N for each driver instance.
> 
> Please wrap your changelog text at 72 columns like the documentation
> asks for.
> 
> > Reported-and-tested-by: Rondreis <linhaoguo86@gmail.com>
> > Signed-off-by: Rondreis <linhaoguo86@gmail.com>
> 

I met the same issue, do you plan continue this patch after fix greg's comments.
If you have not time, I can continue it. 

Frank Li
