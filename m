Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A488D71889B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjEaRkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjEaRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:39:51 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B911D;
        Wed, 31 May 2023 10:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFbdid2FevqjWg1iGIZDLpKQH6q0zaegtoziB4R6nopIckbEco+kzUixjZ9HN8sdx9DL6wryVKSEhpGzUcfihW7KAvneY87veWTDJGNhuZUb3CALCSH4ww+EebMDoqfig+G/AQUhwaZyEacwp7nAQ14fSCOtSNiax34JsrDUAcTS0NuRE7uXoN0sUvPzO7Z5nIQPYZWpiTw3zRdFjqqs5YdEh57t6CrgLj/GzyLPMwZ2/Idxyc7cCArwmlpilMzNttXPwsS1uHKna7+h6eihHP+iWmSsMZi7p7a/SVxwpd3MToO2lWzzYNrownLOwAEo65ly445dL993Un2zgXs8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQwv0RHs8WcK+V0GOKTuDDxR8K4T44q6HYya0ArJjUw=;
 b=HJgN/d91wSo83xFqs6t6NeDcB1zyIRD25lrW5IrSu7tszJbHdPrrm2HbGciBYno7PuxoCfrptHT1AwD5UUxa8ma7wvKv4CpxXfB8HymPaqh/3wv+DHubAbOVK385vu+PuZCLF/jX1vfPbHnn/IgKEFrnWBegWjxJ7jeInVx50bCm+mcpSitpywDaQ03B+b7VwQ5M8TvZGZ7WC+TG+binhIVs0IiRHZKkuIvg80AysLOsblB+Z8e4UR+JPGrgVEJoHCYt2lF21uiWzjpLzy63UbJiiBTmfCB4PDhYXz0llRQB0zcuvdK5eIZMoR9d/ARYAWJFIR/7AJyT8pgvd2uQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQwv0RHs8WcK+V0GOKTuDDxR8K4T44q6HYya0ArJjUw=;
 b=L/IN5L4KqBc0vWJpHkM58WDKYcH08D+1s6ufgSuncuAzvSpmSwzEb+CHW3CVNLsR63ap1X2dgPksNvIzKbQMkaOPREeL9x/jH2Qi/0lCZD3m/KKk3c6U/3zzqMlHJVN0Z5njjEXFbYjV6EK+oWYQ84iJQPNWzwl2KsZoh3rZViU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 17:39:43 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::47e4:eb1:e83c:fa4a]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::47e4:eb1:e83c:fa4a%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 17:39:42 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/5] Improve the taprio qdisc's relationship with its children
Date:   Wed, 31 May 2023 20:39:23 +0300
Message-Id: <20230531173928.1942027-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0104.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::30) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 94758cc7-832b-41af-e158-08db61fe040a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJLtl+qF6/MrHrWceP7Cken1lrMdBzpYOFXk490SoIKdjnFRZFZnzxtLK1Psf0Pq6pRMkgoe2KVBBYDwxmMBCO3HqT12cRXCfs3jeSqx1tQhDxA2MnekfvawaCJfMKQ9qGynTfRHBqq8NAto+6ktJv72D7d9udGuv4oWUL3YvChz3Qri+ZGVpHfmn7Gg/hgW2zCdsLjFyozHBzytEk1ylEjU0tW7OM3aouVMpFTqCJoQNzEFniz6bteBKk40K/lmi5LW1wF4Wxtd/e35KVSS8MEerJDWWdkR7kAKm5HeczwWMJRWH39nZGO9BaON9HIV9vtpOgDDc7Yr8vaq8FHS6vWN9HlZvJL+4sjUjXtabmipi+WVk0X9147fKLW7dJNUnxHn5WCjRiqNfapyKKY5OSY162Ur5fnzg7lNqkNX1KoGA/Nq1NrN6mr4DCezWPoG/REeHL3Sre2BCYmYfIxCXLXZ/qOjSszHAcTXmoXoHVChIvWPg0jGiFPVXbzSjW1MkPcRyhQcNPObg8FtXVblZpj6rZm9HGEz1cWxmDUElUiBkLK1jmOPnprUw73ASnDmUUizzztnzv2JossVawcWlMsHLjYvHE/TFnwbWEYg2+T88ukqBoMZDXczCVVP46oM7XcgW9NKb3nsN9nxhRMTAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(4326008)(86362001)(38350700002)(38100700002)(478600001)(2616005)(66946007)(66476007)(83380400001)(66556008)(54906003)(6916009)(2906002)(6666004)(1076003)(186003)(26005)(6486002)(6512007)(316002)(52116002)(6506007)(36756003)(41300700001)(7416002)(44832011)(5660300002)(966005)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?06qBbsmIFqNJaD4nTTV11RXcvJKORTbmOsf8bAMRYhiW4VwqLMIaOBBU4tbx?=
 =?us-ascii?Q?jlvpzRJO7fkCMXvjDssRacSa4MBeKb/WckZNv0WDtlxFlIRZ1sXQAdi8moFq?=
 =?us-ascii?Q?q0Lt4bXGDLwABGFO8lAeCuAm/K2gWY8wtxc+F9APOwFlumHjcd5RqZwYDTx4?=
 =?us-ascii?Q?enn4xUho55QZW8zsXJrLyuvG4Yv0CPv23BZvFTtMrMawulXGgPo3etiTnx7H?=
 =?us-ascii?Q?9/2iwRiUkYXQJnRlF1RUSeQ6usBNIh45iP/2MUiBuvAJqIg1w4r1DL0G2qh2?=
 =?us-ascii?Q?opdIxLIv6vTzGVKm4NnXEC/qGNJLi/b6kjVSVX13pfxDm4KMPCi7B4JmU795?=
 =?us-ascii?Q?qXCdC/M1ohLA4Gpvyfh9hcwfFYo/XQ36S6J9urhvblraSvfgeY59k3M/MY2Z?=
 =?us-ascii?Q?F/ymS/EDzXJVzpAS+aXV0wbALDjUQ/2OdRXS7Ry+eg4imp0EyrEqe3T7d7Gi?=
 =?us-ascii?Q?IMztuJeLt03OPrQc6ZyXw3D3Sdmz7hbvnTzhj9UeYb/b/g/c9WgJX3OkkNYJ?=
 =?us-ascii?Q?RdflqXJWHr4+jWM2O21nxegZHOFI6Pnm8pFuipukabDgRA8NCpdTH+6ITyYR?=
 =?us-ascii?Q?8r1zhploLvSumw6oww0M3JVtr+W1pU5/A0W9ua0x3rzsMLukvD06nPI6eD0B?=
 =?us-ascii?Q?5EkppMTuPurfklvNYMYCmrvfTGY4smu7obkdWNGQBjw2zgzxKxNDS5bjGbkp?=
 =?us-ascii?Q?BRep/wlKcSe44+aViugosV/MkylBr0IgeizCSenkNtyMNSYuwGkIncCSNm8u?=
 =?us-ascii?Q?WNETwHQheJ9ggbLm3vEqmHZr4WS5Qjz8KQkZ2mS+QjfgCM9D5MTOAvBCiEDM?=
 =?us-ascii?Q?Ij/4gXVstlT43FJxK7AO82Sw5ciG2Qg+WVkYFyani7y2fLCwGWEa1AET3Zg8?=
 =?us-ascii?Q?06SjWzKPa2/bnIe2NhD8aLM74/P4zfdqrd/RrWnSowGtdoubvwLJb16R/1Q5?=
 =?us-ascii?Q?nSHov5n5zzD+vYmc+OnkHVPSPwtH9szspQmK6SEy/8DGtA3xx+W6b/JyBjEv?=
 =?us-ascii?Q?1iOfrElS7u1ZwaS6k4Hlrd3spDl+ZUtqRBg+heF2fk2bDINcBOUyM+HDX4OP?=
 =?us-ascii?Q?iuHKmPP+7eUDMbbyAz2jsATMlehdwq9Kjm3d1o4P00gNyMNzjkwG129LOTP0?=
 =?us-ascii?Q?PFpk42klsGk2Km1uGBaXNuIreEA3JCtcBeknvawjSRye7GM6emxgfJlmtquM?=
 =?us-ascii?Q?Ib9Ec3YIRedaSQAEGMfzqdtNeRKKDhQ7CPtHqeO/L1K+PnIIKIZO9tQXA+xy?=
 =?us-ascii?Q?BR0lmF/8QFR+3+atlRl9cZn48LaZ0QUNKIRfxKvOoQ5vp9vqmRVqDTbLLF8D?=
 =?us-ascii?Q?3jWsWOA83fMQXulL+iACtG88+VXj7jAg1f+fbXltpqxywOVNUiJNSVK28Cf0?=
 =?us-ascii?Q?97zHvRscbJRJJvsIgKzbvuUJxCc7DdD9xttwkMX2Gs6V1Bxs8A9n7suDnJMj?=
 =?us-ascii?Q?l6bJV3bXP9bnfOiyxnCX8oh/W8U7mB+MHlflQP6p4Xmg359NKSkJ17kb7r2/?=
 =?us-ascii?Q?3xFavplD+TMwMoqjOiPX10jnU32Vt7la0hmw1NdSYzTIwfy1I2+LxbDZQzu7?=
 =?us-ascii?Q?YaIHYz/0AAg7ipRwIVaptb4HNPBpJynsxtAp82fw3RTyqrHgAk2oXFDmac8Q?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94758cc7-832b-41af-e158-08db61fe040a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 17:39:42.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rOJIfOgI7rEOUU2rQYGiUdEiMGNs5JGGdz4RJkvea3IjGYl7i96BaCLeo+8nl/xV4M25JA8zoYLxvie7QYhuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prompted by Vinicius' request to consolidate some child Qdisc
dereferences in taprio:
https://lore.kernel.org/netdev/87edmxv7x2.fsf@intel.com/

I remembered that I had left some unfinished work in this Qdisc, namely
commit af7b29b1deaa ("Revert "net/sched: taprio: make qdisc_leaf() see
the per-netdev-queue pfifo child qdiscs"").

This patch set represents another stab at, essentially, what's in the
title. Not only does taprio not properly detect when it's grafted as a
non-root qdisc, but it also returns incorrect per-class stats.
Eventually, Vinicius' request is addressed too, although in a different
form than the one he requested (which was purely cosmetic).

Review from people more experienced with Qdiscs than me would be
appreciated. I tried my best to explain what I consider to be problems.
I am deliberately targeting net-next because the changes are too
invasive for net - they were reverted from stable once already.

Vladimir Oltean (5):
  net/sched: taprio: don't access q->qdiscs[] in unoffloaded mode during
    attach()
  net/sched: taprio: keep child Qdisc refcount elevated at 2 in offload
    mode
  net/sched: taprio: try again to report q->qdiscs[] to qdisc_leaf()
  net/sched: taprio: delete misleading comment about preallocating child
    qdiscs
  net/sched: taprio: dump class stats for the actual q->qdiscs[]

 net/sched/sch_taprio.c | 60 ++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

-- 
2.34.1

