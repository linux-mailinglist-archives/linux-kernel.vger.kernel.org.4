Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F074002D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjF0P5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0P53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:57:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CF2D64;
        Tue, 27 Jun 2023 08:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGELibBe2C1Afsq4tuHmDgBlh6sJAKxMA416hO4wDji133WTRc8g4anWBPEnyFCArEqCsvBo29yLBy2+0kmkLRUL5Rc9turoLvDl1ZGPE3cE2Db3l/AVKY7QG6ZiLisYd0Y1nUtG5IK2dsytktoPYtNTgyiJ/pQ7AWD+6VBWWRwUArMFZYhbsFHS9W5iTnL64ZNLDHyQEiNVTCl5cDP7D3e8YcTIOISUqotLcLUogJqM+JEY4bBawZeR/f7xRX8YpDsXiNue9kVeayVURaxh7fNMiVsZp0d615ojI1PzgscqL5DTJJaZI+YCnY5NpX8hp9yXD2xJySVWiLI+arDbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NFGwbItwR92rj1qvrK4z7vY1kHx7zFrpj1ZowX4Lw8=;
 b=T6giaaHoQQX/7Wv4MuwKJl/ra/uif2ywgM9cE7ttqehf1R9NDGsw4pHhBzjaaoOvwgSqd4CJGLBV6NUC/mafAYtsgd6KwgUY2eoowc9Pf4WfTJtNcRzYBcFibwWM324eI0jxToE5nD/Lq8Vdi5LGVtrGj8/ZFof7Vin1Gu5CwG4z4QhD6NzpOchKHvkA3lsuSEl09/O7ztpB1xPOmXXIm+iMQbDA8vkSDrZhfFLL5Ttapct16MghRhxCFwzYlP0TBs1FAE/gtBLphZguUVEX8bhY2ZdPKF0FUyAxTxMNCGWHPDIRnudFti88p7V16U0FNCD70nPhoD6zPFWwVpv0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NFGwbItwR92rj1qvrK4z7vY1kHx7zFrpj1ZowX4Lw8=;
 b=Q/+snqmcjJ5yypO9kKZ4gTaRgj0wIjuF0iVSE5yVedyGl6g/Qw8xktsIfBfrteLyc73ikAahon9Z/oP1xSDoTtG0If5IhWDcCgfO7ZMCO8mBHWqJQnQXB3LD8lckKSdGfPBO4aVmbhZpUOGNIxFnaiyAqsN1ek7Cj7OvWGCM1S0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 15:57:26 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 15:57:25 +0000
Date:   Tue, 27 Jun 2023 18:57:21 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: dsa: felix: don't drop PTP frames with
 tag_8021q when RX timestamping is disabled
Message-ID: <20230627155721.6vb6cj6fu3fc5227@skbuf>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
 <20230626154003.3153076-4-vladimir.oltean@nxp.com>
 <20230627151222.bn3vboqjutkqzxjs@skbuf>
 <20230627084651.055a228c@kernel.org>
 <20230627155147.atvr32v3vldnybrc@skbuf>
 <20230627085333.0968615d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627085333.0968615d@kernel.org>
X-ClientProxiedBy: VI1P195CA0061.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cde405-5084-4c56-a5dd-08db77273391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcHHGK95EST5MV9fCLYWGposB1CI0OC7vCF7YP3i2SLi4WQCmW5C9pVwNKJnUCjbcRC4XdaYu++zYQk7yWAkOKK7JxzGvJFw/wPgKokBNqnE5zB6Q4ktGsW4bexUFZu0wyPKhfZXksSQvjA+JbFyUZU6peMHG0X0A4ZjZDy5liSk7ZoFWF369E4gutppSbcyRjP/tG1Eq4j5CUd8ShBwR0DPDCj7UrGsSLPMfXMYx0ZZdQbI0lYprT5+QbfTS8IsQZDt3o/mvpWwFYl474tP7vBSGUFuwFs1SbG/NQh2E3Pg9wJGQxYc1znY9gW/dgwygkcxC5NTojTaMfaODSAfC1XoCc5JuDtk8TfctDNLb9RAySEA2fPzUW15IJi2SOSAhUnttPoqhiK6dY7HF7/Vhu1+XmMTCZ1nCQfbjltr9akhEM9HLgVmyCjQeUE/+TF0ENy4qEy3E6WKCi5Zhj+aHSBRIwhtM/+0S+ZcNqas5uub42s2tDflMrlzoAX0ypHWEQdgyyiRWQxYu9kU0oIAclduQRNVHBrstfFWgKOI3vTDjdVdly17ggbW8GPsrbjk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(66899021)(26005)(186003)(4744005)(2906002)(5660300002)(66476007)(33716001)(6666004)(8676002)(7416002)(6916009)(316002)(54906003)(6486002)(86362001)(4326008)(478600001)(1076003)(38100700002)(9686003)(44832011)(66946007)(41300700001)(8936002)(66556008)(6512007)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ZP39rULI1c34yHOVRV/yhyERck+CH8TgbucVseamoOm60SGUWE85zsmT0Fx?=
 =?us-ascii?Q?52Tq0NIpwQfSRxNXnSJdnNko4YSj7MNbKoxWwKmEbUAbrCx0m6X+dFv+zKjt?=
 =?us-ascii?Q?2cm8mS3WkGmuyElGM0hCwTlpjEfALY6kp7suqioldowEQVUaM5FOGjw8uPZh?=
 =?us-ascii?Q?fLMlnm9RWEoLv34iQy6Lwov0e8iv9JcmI592A6toxw1RT+Fl6K3J76ThHPoD?=
 =?us-ascii?Q?Jog7EmbPSmoXS1sDis851nNUs/oFp4+mqZmI0tqxwQ+zNuMqDGPuPjiwo3Jv?=
 =?us-ascii?Q?KAyO5J+B2wFU33eY/f0+wQ4gtQbwOooyxpLB32lvb/SoWqRG/8wp7JWJ+JmR?=
 =?us-ascii?Q?XgpOIaOhs9e5+VECSbuf4v7tvWh1FEv78pQPUdd0M1tySFkZSSlvbY9L79a0?=
 =?us-ascii?Q?K9nDv1AZL7BZ9NARyRnzagPQvulumSc8K5TyJ3CPGADWCdURTwXXTprLHHyO?=
 =?us-ascii?Q?XsKzwS1qtfUwEIgJfFRfQZFGAqfQOICkYTKEaubvHDyYwmHYZvU+9LrhcWK3?=
 =?us-ascii?Q?MrXKnTAf0Zq+ux3YMHwidqJ8WAyTK1XTj3vav6hSvsP3Ad7KuPu9SUjZvPvQ?=
 =?us-ascii?Q?LQey4qYEliTPa8goUVgqwkI/0sSOb171xvknXdBb0JzrFYDTiX2AbSUWOFoY?=
 =?us-ascii?Q?9DInOuiv0rWQfmQBrsCKQP0KndowlEsRUcM9k6QmuC1r4MDQIpTHvBIpi0NC?=
 =?us-ascii?Q?b0Zab778sJ/1zrOjVKHWuSemA5jRTVX/suzeuQ7sUa980TWs0Wso586sKfMO?=
 =?us-ascii?Q?wv5EM0d595XDcjQVSaSe+x5jFNVOLM4SDSrx+JijWibqTdtAnxDBamuf7xO+?=
 =?us-ascii?Q?zEas/A3gi0BpYH9O01dq/GhaRmicee4Bt371BM2TAaQ35mOtfHWouPBoK3Lq?=
 =?us-ascii?Q?SK70xc4+oggdaSQrWVZDA2BC38J+LpBM9a1X+gLGUNTHIZOaqDGrF2/P97ye?=
 =?us-ascii?Q?Vtt90JT/0isUndhVgwM/SUmp73w14xXGMiw51FhIZeHfkZ2z2dPELpY6DUxP?=
 =?us-ascii?Q?u40MDkJrj9zZ0+qlnNoYY3VEY9/+TlecJRnLYw/BxONYbxQpgXGUNQIN/wJM?=
 =?us-ascii?Q?tICNSY+U1yFywCIcSLM59TORZIh7PyRmuxfcxWTtCwaJ8yF3PNXDPwTJQo+a?=
 =?us-ascii?Q?sDgPNQlznj27o7zkad0jCV7O4pl7XkPxEyDdszSNxK9kmPE0MrTcDAPyeZAN?=
 =?us-ascii?Q?ooFsB3r4z1Aw052lMit1FTdwxD6LmFeG1B5DBi3f8Ahvn+HZdBPNrc/HmALS?=
 =?us-ascii?Q?+fivOZFgi8Faui5AI/y+K09CBD5GYzgvZvBETcE7svFERI1YaDq6+ldb/dRz?=
 =?us-ascii?Q?5XqH47s6lRb8+jiOrFneFgppZI+8y68u5g1wiwW9gybjPlrF0BKJedi9IVsW?=
 =?us-ascii?Q?62vXApI2GDPM4RP0OD90UBXqe1n8HbCgv1DpXbMpefg47CicafO4vdDQAPin?=
 =?us-ascii?Q?1+Oo7JkcwCWeUyFdKRxDkuQmNPkpNSQbIbmqdxnDvcy2UvDujsz8yaA3i7Rs?=
 =?us-ascii?Q?HZA+L9epnRPR+jT3X+6dG1gmAGsWZ92j8+6w0WcOdLvhEJOhEmYgfKSd6Bgk?=
 =?us-ascii?Q?PsMk9ONNtWOb9pMDajdRY6t2J1NrXF/P+vrRYBRFvTE0OZjuTlFzj/O7Dti2?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cde405-5084-4c56-a5dd-08db77273391
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 15:57:25.7469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/Uvr2TZRzC+52RPQ9+dnrM1/JbsnZvkY0t7J/f501WIi6Kcuq5HIuzzBepDaRd0iabtyiZ1Y59PLGA5KfPJag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 08:53:33AM -0700, Jakub Kicinski wrote:
> On Tue, 27 Jun 2023 18:51:47 +0300 Vladimir Oltean wrote:
> > > pw-bot: changes-requested
> > > 
> > >  a) your email address is different and the bot doesn't understand
> > >     aliases
> > >  b) commands are hard to remember
> > >  c) don't care about patchwork
> > >  d) laziness
> > >  e) other  
> > 
> > hmm, I'll tick e) unslept...
> 
> Ah, good, I was worried it was the aliases and I don't have a great
> plan yet for how to deal with that :)

No, I can easily switch to the work email, I just wasn't paying enough
attention to which screen I was looking at.
