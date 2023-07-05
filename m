Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D712748266
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjGEKoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGEKoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:44:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3428910C3;
        Wed,  5 Jul 2023 03:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6VpiMxXgNMuTkkoyNwosER6cwI2V044fR8Wo2eceF8HdT3utFoDxwVAH6Syfma5tI73/NUvFgs35rKdVcBU/X/yhG406uozh9JlABbWQJnKDlcM7ax7TJ5m9ChhUcsnfMU/hEaiO1cuMVwNlfFz8UKhYW8hOIYs0tvAGXeEm9MruszLWk99Neu8xI2EQSVnHHBmyaysG3qDKhwI/HtUBl0GVMBWNlcu/gPsVt4A8GeEWMYOYNb9JqQ2mjFw61I4uqaIxyB549gNsPWjOCaVFeVcdbZsB07G7CAYRZoG336EQe9R8w+867weEa9cmqYzgSdT5DvvDEsEa1qhMLuyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmItFoMUTHwO10GnXlJtinMW3ezK+57U+637P4ipzLU=;
 b=jUtUT6mBDZXtu4REJrCdjyu9ZmaU3i7sTJcDqdSjLjtEV8vV2QcxU5Aj+AE0wu1hElM3HPAkZstvR2cwWt3RIiDxJDktG4XaEiyKHkUqBYnOnf8JNc2lkQh1988SzczgJE98A1lhZ2R3V+kxLoACISO4di1nFIw6yS4Fo2gUeVgkk5HIEVu6HntWfXEtOCd5RauMpQto/7vX2gC492xml3g/QQCBwEfWgyFVIWLHhkyX1xzNv8f+y7yeP45UNT3zqZnEfCKH1AKpzP0ZMapf6nwksC3NLeV3boUBIXddG4/Qgw3zMCZDVUxDFsrVNFhL7Zsp1c5ieESToMb/9fl9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmItFoMUTHwO10GnXlJtinMW3ezK+57U+637P4ipzLU=;
 b=pQmWXmeBzgZgPr9EB/H95/QjdtnrIxoTUK23fk3bopIAurwx2/55JWGfj9mWtrfDFRB61YPSwwgOv5OKysaZ7pVz48YLOol9V6tKcCHgWX1XeI3rgubvQx0T2hZit9X17+2WaCba/wW/8cr7rXSvUeTVRgp7iMn16tSJAVp8DY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7658.eurprd04.prod.outlook.com (2603:10a6:10:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 10:44:40 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 10:44:40 +0000
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
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] Fix dropping of oversize preemptible frames with felix DSA driver
Date:   Wed,  5 Jul 2023 13:44:19 +0300
Message-Id: <20230705104422.49025-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0066.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 305621a9-3f59-45bb-d7e9-08db7d44d5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCxJo/8u3pt89GiE+INSauD7q8Wd6fGA0m7waN0QXK68UkfTtpcMO3+BC5WAyPmlDiEwApXKPA8UvVyMHywPe1BU/GE71jli3CjH6479Trcrg7fy7llPus8S75S71yBGD03FSWo9gRWQQ9l/xdmc+rHYkIj3dIiP8DhVhgqJ4GrwgD5fy6WfqoZZ1cfCDBP9ILouZz7sxfvslDt5J6Sk5C1MqCpFmDvgiDypGCrTt6yyWRdSJ0JYEmNNz77PPJYAbtDyPhHJgRSxtjeFH2uBRXcPui00q1fauUVshCiSQYQ/CfWHEOREtSPgvaJX1la/fgxL0mz7tfL96Z+9CCjBkYmQhpXsuhlIujvb2HeAZnxitwBGkcy7raRNtw4zTcOLT/XRoSmOpPnwdp87b3P2hPwfOsEb8IU5yVjza3kXj+Et+HHNmgcSSwFSIv9FOHo4AwA/fzDtpxN7Jt0vZ7AOzKnh6JciEo3/g96ragfL6n99nPfvTSVPQFn3hkKoWGlxIK5pG2/XGPHo1GS6KYbL6wMitiFKLtk5JS819OG0RpolWs/oTNFGhjaFkXbipS15U9X7yss8lQbZLG55j2xKvbhz3kN4SMSsteY4NV8wCH+iaKq3K1ExPrS1JSaLBrl6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(41300700001)(478600001)(6512007)(54906003)(86362001)(52116002)(38350700002)(38100700002)(6666004)(6486002)(4326008)(36756003)(316002)(83380400001)(6916009)(66946007)(66556008)(66476007)(2906002)(8936002)(8676002)(2616005)(5660300002)(186003)(7416002)(44832011)(6506007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TSaKmzpdnBln2/bS+hoBvCFlI/cseRgwQ9YrKSX+vcaOkCa/xt6dWo0+5cqG?=
 =?us-ascii?Q?MzQdTAEEfvxACoQNy9+Jjx6wiEgv1m20ng5NPBxmzoi3MxuRomJ1K/UZtQBW?=
 =?us-ascii?Q?fWi3zvIG5jk9FEbCkdHoqpzBs6qo27UCp+uoPybZJiMPkevJ8LjBfZ96wAG7?=
 =?us-ascii?Q?yMH8cl8su39LfM8jCH0xvfX7mb3b0XawQ4xbGTa4hbTkzTtEl75tYzN8gVW3?=
 =?us-ascii?Q?CZDB8qzDi+ZJ8R2Z/Ud305ofPmciTWQ93meDfvi1UZQq3b53KOeEsbkxtdFR?=
 =?us-ascii?Q?iatY8SmuE9DjBjeTqy4PMRwsng4F5y+bHuCmKsFNPybktCGCHydySULvesfa?=
 =?us-ascii?Q?UX1TAuriFvcebH/2oz9fNEy2wIakgYDg1wwGczfT5ST/iB6rkMN5mMJ9Ox60?=
 =?us-ascii?Q?rzMGBQ6TyZu5tOlw3OEMt67/48DSnrSbampYSfw4VCQSgDY2WTGyvGhs7Sc4?=
 =?us-ascii?Q?IcXTPN1fcqrZDDUn29e+p0FjNiLb1mYiLnwFEWUcV9R1Ltr5RSGUZkhCrn/H?=
 =?us-ascii?Q?ZqnXnOWt3MXhuz+XDr7D5nG/4YWLsVqjZCbs077rJCwvWDldN6vnuYEs3Jjk?=
 =?us-ascii?Q?RhkMqvVf5pEiV7nn3FCBVKh0lj0zgnkK8Wu53QIcrxbRaPzqWKzMVMaB4rZ6?=
 =?us-ascii?Q?LPMN3hwEIlkFO7C75Y0zqcztysBpsVPoQXtTFzkf1c4q0HrRxYgMhUzB4Ym6?=
 =?us-ascii?Q?sU8qejBCVz4t28WJdqo7jda9FRtmeENFC/JoZ/JcWMV+XqkhwtcRlh/ZY9ht?=
 =?us-ascii?Q?n3xjHLd+W40+QL/mIDJUn9wnr5lt1TDOWsJWvjCCX3MT9+AjnqvfAAt/52kJ?=
 =?us-ascii?Q?ri3ESEpPKJ34EKDwAVU87Lcn1qINBo1jnSZmCN6ShJI1qceNffpBviwVNQ9z?=
 =?us-ascii?Q?wDN1nUpj55YCocO8AXixF5BYdKJsCSOH5z0BKJXq2klE1q5JZvR2Kr9pulnI?=
 =?us-ascii?Q?I5KgB8eNS91gXijYi9DV/4R+wRJR52ud9PH1Ti/6iIVDst3gzYnFPkrrZ9NT?=
 =?us-ascii?Q?0623HnPFoi2/gnp1q6tTLWAuWxA5o3oKwAAUqUG+AbemCQiUfVIaD1/OzarK?=
 =?us-ascii?Q?RCRixa9z686Rnba8o/7kLpA+LqB4WfdQPTW2nnKnwqZlJstkHrfK7BCy/RPc?=
 =?us-ascii?Q?mahFj4nGAfM/7kO2e5/sUqShqEhZlsu0ajDKzeIESJLw0G1s/HW2L+3l9xDG?=
 =?us-ascii?Q?CXe9gHQYjpb6M+dIUitiA2ERTcli82EqABnz8rsAdt0cDiZw9R26UcQ3s3w6?=
 =?us-ascii?Q?KYMsfX/DaBc5jNXQGoKr0tPZsq1CtpkxQzKrH7MuswxN4CYJ0IjRFvcOMltt?=
 =?us-ascii?Q?mX+vaA/VrgpVITj83+RvIHD7KmWzEjtRwVAOTDe7iiA4erf0R3nx+tuaE+YG?=
 =?us-ascii?Q?gXEUCA1yQdKEo/REhUCZBe9rwaLHuLW4PPcK4zTcaodS293aY890Oc/VKOpl?=
 =?us-ascii?Q?JSYLj7ZGBPjNkcT7g7is4ULvtyoWLUU31STopWGY5J2zeHCgzxTB1R/PiGVp?=
 =?us-ascii?Q?QHJg1g3eSP58c86tWG5DAkbfp9helEW9AKcArf8soIwryvddsgsaxaB+6uiR?=
 =?us-ascii?Q?ayH8cY/t1MegYTRcdijXRixrBEtUjtAHsbYwloeD4fHOQJFFzKsxCB/i43mt?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305621a9-3f59-45bb-d7e9-08db7d44d5ab
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 10:44:40.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fe4m5W55Llev9fXYn/3yTjwvjUDpSwi1A1/x5EtchtQNM8Zw3pjRssJTOOamH3TioxGxlcXtu9gSzaHDja9bmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been reported that preemptible traffic doesn't completely behave
as expected. Namely, large packets should be able to be squeezed
(through fragmentation) through taprio time slots smaller than the
transmission time of the full frame. That does not happen due to logic
in the driver (for oversize frame dropping with taprio) that was not
updated in order for this use case to work.

I am not sure whether it qualifies as "net" material, because some
structural changes are involved, and it is a "never worked" scenario.
OTOH, this is a complaint coming from users for a v6.4 kernel.
It's up to maintainers to decide whether this series can be considered;
I've submitted it as non-RFC in the optimistic case that it will be :)

Demo script illustrating the issue below.

#!/bin/bash

add_taprio()
{
	local ifname=$1

	echo "Creating root taprio"
	tc qdisc replace dev $ifname handle 8001: parent root stab overhead 24 taprio \
		num_tc 8 \
		map 0 1 2 3 4 5 6 7 \
		queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
		base-time 0 \
		sched-entry S 01 1216 \
		sched-entry S fe 12368 \
		fp P E E E E E E E \
		flags 0x2
}

remove_taprio()
{
	local ifname=$1

	echo "Removing taprio"
	tc qdisc del dev $ifname root
}

ip netns add ns0
ip link set eno0 netns ns0 && ip -n ns0 link set eno0 up && ip -n ns0 addr add 192.168.100.1/24 dev eno0
ip addr add 192.168.100.2/24 dev swp0 && ip link set swp0 up
ip netns exec ns0 ethtool --set-mm eno0 pmac-enabled on verify-enabled off tx-enabled on
ethtool --set-mm swp0 pmac-enabled on verify-enabled off tx-enabled on
add_taprio swp0

ping 192.168.100.1 -s 1000 -c 5 # sent through TC0
ethtool -I --show-mm swp0 | grep MACMergeFragCountTx # should increase

ip addr flush swp0 && ip link set swp0 down
remove_taprio swp0
ethtool --set-mm swp0 pmac-enabled off verify-enabled off tx-enabled off
ip netns exec ns0 ethtool --set-mm eno0 pmac-enabled off verify-enabled off tx-enabled off
ip netns del ns0

Vladimir Oltean (3):
  net: mscc: ocelot: extend ocelot->fwd_domain_lock to cover
    ocelot->tas_lock
  net: dsa: felix: make vsc9959_tas_guard_bands_update() visible to
    ocelot->ops
  net: mscc: ocelot: fix oversize frame dropping for preemptible TCs

 drivers/net/dsa/ocelot/felix.c         |  9 ++--
 drivers/net/dsa/ocelot/felix.h         |  1 -
 drivers/net/dsa/ocelot/felix_vsc9959.c | 59 +++++++++++++++++---------
 drivers/net/ethernet/mscc/ocelot.c     |  1 -
 drivers/net/ethernet/mscc/ocelot_mm.c  | 14 +++---
 include/soc/mscc/ocelot.h              |  9 ++--
 6 files changed, 56 insertions(+), 37 deletions(-)

-- 
2.34.1

