Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04B76D77C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjDEJIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDEJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:08:27 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED74746B4;
        Wed,  5 Apr 2023 02:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKR/vqdsZNWU15xXYqmhkea1bKiAs+hv6rZ2sJaX6gLJFrpo/jS3FuDc6VASnqmeURm8a2lmNjqk61L56a99Gau7iyEiLcUeNUi5kK/7e+a0zkg/Gwk5iUievhAZW2RwM389PP57iLDah8y/cAp9a5qQ7lERX6+l7W0Mm1uPM4ywX/hMJQxJnP+CqKw9ATSeqgDDUfHvQ551JfcIMnAgzgCu/mUWtUWVj05phjCHQiFQf5VkKhvgHdPizc+i8XpiNSYng97mbZ9gBYhxouIMJNSPYoVGIm2wBMUbG9vnVY2VAz+zjMuElXALBoQa7uVB++YMDQvU1oceXlh4dOy4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7yUjWgkB0NAQF3UETfqSD2xW+qLQSy5RTB4DQXmyE8=;
 b=UypYeAFGInVc68tfb5txS+j/HrBBJeRsaq6LQbYS1zAwJwf/uhlsYpqIboaQXw6J8xSC57OjaMNY4qA7klSFyJN60Mn7ISCjKefUeQ5dDPyai70YyHEQMKaXU6jO+oWXhTL9M5mwzKQCsTJZNDz33ZFSH3OWVhD4wk3owB1WiMG0gFMarF/5ay5ssGx8ubNx29M6Dvh0koVCtX1U4H91+doiv5wr668TrHnNI6YsEoWUr4y685LtZ2f+ZMBUWVrXFIBMI0zvt/mOrrzWt7vv7AYJyc1lVwSz0JAAHlMi7/TGvszFO8GXBXI7dLbOYwPjQvj9zbZ08VWMl+OIb1NXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7yUjWgkB0NAQF3UETfqSD2xW+qLQSy5RTB4DQXmyE8=;
 b=AI5wBOEqfQ0lAxiQu3UpbXs0BuqzGqX4nItZtdcuMyabZjdVNpEAJoemdbvBkzFekOs8Yz2wk5EwH0YVIkbjmthS8hTVy7QvZSnalMhjw3J1LHXY0g/MAgmI8rJNu97dgUXhcyiiuCcDAExMI+t7uuJvvv+Wz29kXrSbdlzh4yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS1PR04MB9285.eurprd04.prod.outlook.com (2603:10a6:20b:4df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 09:08:14 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5%8]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 09:08:14 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v3 0/2] No access to CAAM page 0 registers 
Date:   Wed,  5 Apr 2023 11:07:50 +0200
Message-Id: <20230405090752.1708455-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322061716.3195841-3-meenakshi.aggarwal@nxp.com>
References: <20230322061716.3195841-3-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0029.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::34) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS1PR04MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1c16de-24bb-43e4-c9bc-08db35b54933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhpcV0tojm8RAVXAUjJ5x9eWxtuuz6Ne7K//TzTN+pmCHFuQ0ZXmR1OLIcpfjj+Zkb3z7yuGUGdX6nSDR9oE/jwnCTGPxr0U5pc3m9mRH0RoTcuZyxg8jXTNJOHR7c9yX2U7hCPmrAfIfnRXFC++J/JGPg4KUI9UL2BmCY579nj2t6QMmosxo1qJXb3O8MufDf0DZPjBL2ctlsQsGMyvHZaMkGCa/1dsGbHp5WvVy900eHqZi3u9jHm9wFSds1zcR/VK4FV+F2OIjknaBKvocyvQB4pm7iljo4i2Icq5+dmg5+G54IYlUXptrGMMkOXm6QBCIw1Fil6oRNbCR11ce5y1IlIuDqR/r6K8ZxG9IG1Qyqf39ueRZJKJ/Sj1ccBh5hr7fKkcD+UBUbkiJqvsDYe8w+qaIaJjFQ0bj+BFeyMlCLxnfLQ8OZRBtBYIaoXDuxssjwg4v1RPbf2IJc2df8FnXmRP4v7kr2P4bXLCQ2mwodiJsYZEjGiNIHw0bSMipcyEf/WbxIr1uZxgFeKvQKhscZMNPFeI6hNhxolmI3OE+x8s0yIa1JZv0+VBfe8t5WGgwKdOhM4kTsDa54k6aSW9LaZrx5NVzsN/jXcQBMwVQptcBGvdmWteywMJO1qw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(6486002)(38350700002)(1076003)(2616005)(6512007)(9686003)(6666004)(4743002)(6506007)(186003)(38100700002)(8936002)(26005)(2906002)(5660300002)(83380400001)(478600001)(36756003)(66476007)(66946007)(66556008)(41300700001)(8676002)(86362001)(4326008)(316002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQeT3Ttbkc+aqGKCRwOETCdRfRBXIF62an5+4x9ZMZ7IcA80osqmT1Im3ikd?=
 =?us-ascii?Q?uyMAceQFntV7LE9tLy10bOnlyx4rxzxJja7h4BfnWHM+aV0EvmqKaeAO2XsO?=
 =?us-ascii?Q?d+6FZCDTFjfji0gtkllbU1xpvoKbVES6AYhiEEwjTXkh5zNBCxsWMWUKMKT9?=
 =?us-ascii?Q?RW09Kmh09rrBn8WTyn/oREJwbwKm6WZiwc3esXRx4F2cc+gH9EfDbGykCIDw?=
 =?us-ascii?Q?SCvfRqWfVbwr4purUlmr27gTdcDBioNFpg2JOkTmudQHKj0xWbCY1j4ONMSz?=
 =?us-ascii?Q?wFfg1eHs6oURM8bJ7utGUXgimcURl9GlxArLCLpNXH/9W/oZOMQyzmEluqO6?=
 =?us-ascii?Q?Vuxlz0Od20RfQXo4van7oFU+9EY+9NceyLdDFn0qLIaZVq1xGx/JPvyIDSXp?=
 =?us-ascii?Q?3NqxaDgkXgTnlCojAVpCzSsSc4/nMOprSOpZExk6NMZhazDyLPnxaysxcmrn?=
 =?us-ascii?Q?rFMFCZqzx/xJzTFcvz+mFv620HW/bdJ6ZBY9/Nhj7t0dYQghTQlQ5LsWOwdm?=
 =?us-ascii?Q?jXYirFSJJ1J63CFMQdvawQTx/OnP9PyxO7gElg6IVV8xI9XCSPKf2xFn1wwQ?=
 =?us-ascii?Q?YvU4aIaJoKHbhO/AKdAwYPlyScDtcx/kRfztWhBeQ3XKByWx8652UhEoyOae?=
 =?us-ascii?Q?eELkUE6gaS4QEBcC2NEGRsQTIuhH6xL5xvxa9KAr9zxWafSo2MXByCm90Ei8?=
 =?us-ascii?Q?GmRa9Y4XSIzDyxCF43hfLHgabQUD8NACUR4rwLgCG2enlyVB945ndIi899id?=
 =?us-ascii?Q?j8oaxKjtF2CpJm+JI8PwH3Ub3iCgHvPSMZcjEWJjXh5E/0cNKR4x4cgHnme/?=
 =?us-ascii?Q?RiFJPVl9VjfVIYOqUqh7Tb/ZiCmBYZNCXpL7LqCFgDftlMQ3ktL3pt/5bBoq?=
 =?us-ascii?Q?F0noHR0IhbNg/zyVMWyaB/7zh7H3yRNuqzTA5ca0Kp/SxkQQciYT2rohho4e?=
 =?us-ascii?Q?lb2aEsJYcsGxOxNHutdFxxpzVwsq7tgVgQF4KBqUIEhM31c2uZui00hqNBpq?=
 =?us-ascii?Q?xEmJ/whdT+vCB99EG0Vx7eEB8MyWJhKBoLaY/N0j+2WK7j/PP8Ak35HSzejl?=
 =?us-ascii?Q?x1rnp+1cGEj3Z1aMnX05sjf+WfPCVdm0ARM38I8xZJlaZHAycGFyu63mDlPI?=
 =?us-ascii?Q?G6T37dkYuptRIzqAV5K/tFKQFwDfcycrkWKBYyC9AD6YwWB/UA2b06lMjOKF?=
 =?us-ascii?Q?14WsZIZceTjQiD08I48mM30uyrx9UKneTAqzl3btt0EPjz7vQlx2alwxEMMH?=
 =?us-ascii?Q?9HYp1zs+fhW6E9CUyqQvgg8p6dvufrdEiAss1VwQNt7rPAD7pCk4SABMZs8L?=
 =?us-ascii?Q?3vckr7e3R3E031pCIHJLP3+XkClRjqgILrA1nun1+ZwzbVikYbK6sGp8Am49?=
 =?us-ascii?Q?+EzeQOAgDDN9oECfytL/G2lXlBny1Bi/m1CxtcLLeYwPl7I5kMXACTiqZewI?=
 =?us-ascii?Q?+9CFOYWNnYKLJOcP/lHgRX8YwyyO4VZu58mxCeWWDO5QfKLGSmovfiB1O1wx?=
 =?us-ascii?Q?UJDIn/fPhjzJa11ZY0Ou3fbhIHYN5bejfeGCKMdLVvp/u2cU0RLloW+l3RG+?=
 =?us-ascii?Q?MLLyhmsCk38mfA5uChGhqHSwvnZkXLaLBCPwXNbKVaDPqfYGwIeKr1vfmjHd?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1c16de-24bb-43e4-c9bc-08db35b54933
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 09:08:13.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ACw9vumuaZiihiizTeMRDega7alEMHbytrwgmMH9GbbvKMby8oIAJGMBA3jm2W6J9YoloFVgrp3o5s3XBwwQwGH7FZZQPtEEEWHGLDsq/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9285
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

This series includes patches to reduce access to page 0 registers of
CAAM from non-secure world.

In non-secure world, access to page 0 registers of CAAM is
forbidden, so we are using alias registers available in Job Ring's
register address space.

Allow CAAM's page 0 access to OPTEE, as OPTEE runs in secure world.

changes in v3:
	- Fixed compile time warnings reported by kernel test robot
	- incorporated review comments

changes in v2:
	- Fixed compile time warnings coming with compilation flag W=1

Horia GeantA (2):
  crypto: caam - reduce page 0 regs access to minimum
  crypto: caam - OP-TEE firmware support

 drivers/crypto/caam/caamalg.c  |  21 +++----
 drivers/crypto/caam/caamhash.c |  10 ++--
 drivers/crypto/caam/caampkc.c  |   6 +-
 drivers/crypto/caam/caamrng.c  |   6 +-
 drivers/crypto/caam/ctrl.c     | 106 +++++++++++++++++++++++----------
 drivers/crypto/caam/debugfs.c  |  12 ++--
 drivers/crypto/caam/debugfs.h  |   7 ++-
 drivers/crypto/caam/intern.h   |   1 +
 8 files changed, 110 insertions(+), 59 deletions(-)

-- 
2.25.1

