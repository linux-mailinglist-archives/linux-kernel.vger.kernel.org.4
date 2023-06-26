Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515EB73E396
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjFZPka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFZPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:40:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932C10D9;
        Mon, 26 Jun 2023 08:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAddwFxdzVSD9qSeLPCfMOquEBzArrKcW7P8DoZRQKpSoYP5IVdBwEAvJD+Vh57N0qTK1FJF+JF6QfLN1fR3dY6IL6NiDt74jEPd4b7s+sz46ZVian8joCPjKONYfC0O/zSnbqZcFzUOTdU8gNeh7ebJUevM3rCYp6Xud/Wn7YzgbFIbwTc0Ne070JidRfiuVO/OZ/AgsFGWXdGqZbXE5o1F+Zr7/iT2KKYNVu1TsH+69wBzbFM8Ot3o5lWRTrtyPLHXnFLXs86RVL2gKzdxeHCzCQyShJGzIVBaz9WvoFCWXt/0CjjXH2iWjSrUf/q8KNNUaDKDHdbycqbVXroLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV1rDkwxV5MkbKlVUoEHnt4bioN45V9xSIYe8ApRGbg=;
 b=HhbyAtdN9wXKuWWkcVLmrOZNRj7N1HWuekGwD7BKTq2kOtel0nlRY4YrmPssAtmVmt+nSxfY/4rMrKb6WJ62x0uy01vk0qXnRuIlMn0/Rrh/0/2VOGiHLacezAWyO0THQPhahgHoXVeQoE7pkgGsqKcl5ga5/nJENu57UCYFLfR/x902GfIaf3f9tYYD0DlQuFp4KPQLHI0XjYlpC6gJ4Ril8qyUBBABjkCGz8+HFh1X3zTo0dP+yF+LrREcz7jHj8kkd2n+o/IZP+WecWaN1ODjtUHxCtKjDHqJ0F4CjTNFfR239Etmm/7p+Lafjmc5hAXGttKyKVoAcbLSYZ7Vcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV1rDkwxV5MkbKlVUoEHnt4bioN45V9xSIYe8ApRGbg=;
 b=fQTiz8BnteDHwmmDALrATYM0bPg9PgQEDE+/7tjz9QCcq0XlWCagnS1xPG3WBzhlBsD6w59NKT/Ty73BJyW3bSYfXFXux4YFopNr91kga0UZhiLpXmVfWy84B/+evAQ1vLwdWjPv63grx8yZHMCraqE9YJxfKiRAT7rAQmwUlOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 15:40:20 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:40:19 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] Fix PTP packet drops with ocelot-8021q DSA tag protocol
Date:   Mon, 26 Jun 2023 18:40:00 +0300
Message-Id: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0121.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::38) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: c49ccfe7-d7af-4032-a7db-08db765ba5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5gqKLQsUPIBzTH/YiDB0/Z6tJHxhlE2FoizTcn6Vw2UOgjZOahMlD9Q6fIpf9Vf1QTO1TovMe+ZxtGho97QFWXfVWgdHvEuBdTB0FafYCsecLay1EGtpLS9My0ACoc72WtvPPgV/CoJDWF1vvA/tUwiwkDAfvCZVa8yvk6s1ywSoW8LRmgyw7X0FnAWmoBgjAQK/kpvhQiwbP3b3Y3QPzNWk/75RIZl6CmYJzgSy4TgNp6vigPM4iDVkTlvVQ/A+wY2iF56vNuplF4HgRCkVkpRCmkQVIXOFh4WPUDlG4iaCZX2rea5+rQPWuNab/+vl0x6Qr5HwMzLea1iSmJiSFfGivfVWSwFUaJ7H3qSmLakFvHN9vFmw9+aR9XWyzdGZwqsvYIkH7FUz9U83mxy1MWuPsI6Xkn9XipeTGLNhjSpo80iNOvuRg2XEQ17U10tYfEWKJAlxeQdVEd27pD0oHi/V3LAowgVuAOw1zmOpJscKQIawUdqMCct6khjBox2sf8r4MmUfuLZ6Ry0hGD67rQ+hA0Tuj+39EH48e+P2TdbbkUowIjYckJ9u2oCK+BedCIsMTn1YX53D1buRxCgqbJzkrgQ2tDiIKBgAXqzLXchaUobx4Q7sfGQ7dDPIPKH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(8676002)(66946007)(41300700001)(66476007)(316002)(66556008)(8936002)(4326008)(26005)(1076003)(6506007)(6512007)(186003)(6916009)(2616005)(54906003)(478600001)(6486002)(6666004)(52116002)(2906002)(5660300002)(7416002)(44832011)(38100700002)(38350700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?heM4ee8N2Kb0SrqhOUN2eVU7TvZFKqMX3mwxDA7wqGita5lcwd0TL/2R70mp?=
 =?us-ascii?Q?mQb9aywS+o/zmeOjI7jp9pR/HtsDfotN8ASM5e1JqCa5Sa+CpwzzIou43Lq+?=
 =?us-ascii?Q?60WTa3Ofz+emWXE2ic9J5cpKRQpCel3bSiqstFfsZjIRWDJLTwOw4ftYsTqH?=
 =?us-ascii?Q?IhygPr7Sg/aiuaZDzWa+nhKYxMeXp0xbGEY0u8Acck02Bc49qbH7iflKRooT?=
 =?us-ascii?Q?GDTNNyY276pT5/MSdOkm2sNuuAU7qXRSu/w5zhWOOQNBRGAhk6nAbCJU342s?=
 =?us-ascii?Q?D/hTkcMgZMUCY4kaH0K/lDdDbhp+Frnw+XrthG6ylzQM9n7F/KDBbhVbxzl5?=
 =?us-ascii?Q?lX6nX3ftUW8+tagfq734gNhDHOadgpawcM+PAxyjY9avdbbM6YQcHcbdOq7g?=
 =?us-ascii?Q?xDh47CZJLZH6mlVlpJ0S5bPH8K1z94wZQEUAShzKo8QqRtmFIsmsrRA+w/kc?=
 =?us-ascii?Q?FOwDCT5dvrGALI8nmz0XSJowiplwVwfXH7kwMOBwkted19ht77do/AJfYR6A?=
 =?us-ascii?Q?wJvBNt2opG8S024GeJnFu25SJ/deaUWtizJNcEY8qMuGquA1AqBf62EnOui8?=
 =?us-ascii?Q?G4bZuhOPXNkurhdaoLawt+NYNcFQLrkedxUW4UkEH/SEetJiOC3k9hdc3XI6?=
 =?us-ascii?Q?rI8pyUj/1Gn8oTkIcmUY/Vt7qFfLiP78silUnqnOl8lTCC+B7kXNIL028HnR?=
 =?us-ascii?Q?DPH8IXGkQVVXT+Ge8SeTBmEhZhojFHaNiqzQbpzs3/K5u7wq0GiVi86DUdpa?=
 =?us-ascii?Q?ADkbwQvJaaJpxTDQGW9+j8PbERHAMxlpJlBUqglcpAPlOqGgwJ3BC1E069KT?=
 =?us-ascii?Q?Y5OxZ77JOi7BJOsydWMfHOypONBR7aE3hNCKM6Gp+lYTP7ykxrpPtolNmWQ8?=
 =?us-ascii?Q?FR7OIkRmvDJlrVp7pVAE80jSXkbCUrJ5qCLR8PkAX/bX/KkvW2EjfUwIKfYE?=
 =?us-ascii?Q?um4ni2kfsI9b0AU/u8qpKNrxbYWUXfw0VNeCVqZ08P0jG8WITC8SXvdroTDz?=
 =?us-ascii?Q?DNUlVPBLb2g3xQKdlJCQt+MSCvnvzGxz5fgorSw+QPAFoM227lJlAEwJetm1?=
 =?us-ascii?Q?Ex4WDW5jmKgUHlJywosRdPlsyTzr/RBx/s7O74ToqDN3Nzwtx79zCn2fuh+c?=
 =?us-ascii?Q?sYJO9hGxlJlSvdE1tpABd8L9cw/mBR+OKdjJPatpvgEH8d4rERNmUk2H5lqI?=
 =?us-ascii?Q?vyasyYworS/4pI9KnRQEf/iXSEwFFXhGSTsjaP7kcNMr/Q8m0rLEdn8wo7W2?=
 =?us-ascii?Q?jrncmiu8zmnkJu0PDpqKvv9xKV6vz8slYifVIDWSVDR9QNE0oam2rqgFjXQh?=
 =?us-ascii?Q?4fuHj7CvEcb4vv7/KgOpVyJycFRoFJuRb4ADxn3FCpXiahn7vgFltIpaVyl5?=
 =?us-ascii?Q?DVOXKEnIahnV2zBFtjDdxtu7HBSj7MsHVaoVgA7aTxbSs4MwmbL7pw2RkiLq?=
 =?us-ascii?Q?Lam0OzFdw6kzp8QeMrE5irMQWUYGkUgBHO8Z29O+0xpygE/Vx5FngNsWCq5X?=
 =?us-ascii?Q?MgMK6usIVKacXnsSDlVq+RDuxZiemZYEmDobOENAGr0DkJnf7jJJAhEo2OdU?=
 =?us-ascii?Q?zNBZFAbmCQn0kdHFPKR8eoemR6sqV7uTAlxarIYA+O3dOt9pEUFM14lxRGuh?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49ccfe7-d7af-4032-a7db-08db765ba5a2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:40:19.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZfDKvIkx8GtiN6AEjnqjsAdpn5R/qxwUwrHJkNlnOoGTQAVF/R55Qx4LaqbO77sqH3tQQ2lSUUOZ22ZPbX+yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 3/3 fixes an issue with the ocelot/felix driver, where it would
drop PTP traffic on RX unless hardware timestamping was enabled.

Fixing that requires the driver to know whether it had previously
configured the hardware to timestamp PTP packets on that port. But it
cannot correctly determine that today using the existing code structure,
so patches 1/3 and 2/3 fix the control path of the code such that
ocelot->ports[port]->ptp_rx_filter faithfully reflects whether that
configuration took place.

Vladimir Oltean (3):
  net: mscc: ocelot: don't report that RX timestamping is enabled by
    default
  net: mscc: ocelot: don't keep PTP configuration of all ports in single
    structure
  net: dsa: felix: don't drop PTP frames with tag_8021q when RX
    timestamping is disabled

 drivers/net/dsa/ocelot/felix.c         |  3 +++
 drivers/net/ethernet/mscc/ocelot.c     |  1 -
 drivers/net/ethernet/mscc/ocelot_ptp.c | 35 +++++++++++++++-----------
 include/soc/mscc/ocelot.h              |  5 ++--
 4 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.34.1

