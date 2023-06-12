Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714BB72B593
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjFLDCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjFLDBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:01:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFCAE47
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr5XQwB115w71XaMsujnuZtRztM7frPMNuh9ri9iEOGEO1rhkK/KcmI1xdU2Umg/h+DdrYeeddK8IoKJcjRkazXESb4/TxqDLSVKE3lVS81rleRqKTX6r0sEQFRj11V7a+xakF2JoDlvm5fXEoXqZXclTCXU9c6GhML4ZVmYL1r8AlUwBla+LyFwi4sXAkRnGS1FzRSWVuoYvPaoeOy6QeU55dEpVq+Ld4oS58KpFtnn1romddMODM/2u+3rEzgUanNEbPnvcWRD7kpCqVZa4rI1Y2bm2+b+JA60fHCXbwraoydmg/H58zUI75HpEo7BP7m+iFpf0E5eub+pB7twqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1v+pSg/oWcs687py8tAQybrfDN3VE3PjazJlaYFLtQ=;
 b=Ci9HqkVOtOZy3eGD8ZjWg/0QzC5KzHpY9ad/n04RHgGsqpR7fZYCoYdfWpsuwcWh53mD3aJWUuq9S3BhBlHcr0GyDkrnRVOKCtFnOCdfB32CDljWaEravmMSv7QX8eRtCwJasYj30AS/dQZP2OT3qaIJYiV0XkswVy5dn0iAgw8DvUx5abbq3EeErmTlAJStwil0s3rMaIZTy0/cUytbtcHxdhq7pTVsP5T0tGbL4ZJTrz1Wn1B37rqdL5IL72GLs1y/okWddkIR/j/KVhQrYb1ph68fIqkwrXWK8W0oqPDetjGFHH2GhqoYt2L1EHeDCZ2j0maSFRE79arJASVYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1v+pSg/oWcs687py8tAQybrfDN3VE3PjazJlaYFLtQ=;
 b=Qr07vN+St1CXRNDqCv1ijOppF0Cca8iLf5Kelv/wUrkLOLuOj9Dxkjp0qJ/akkbO2xu5MP0Xj1z9F67ZnNW7ujnGHE/rfmgGSIOnTzkZmrx+o5ZOAxGnyNPf//OpyHM/UE7RTCzu2aGluLKIlAawgoMLJIZjwJd3tV5WmtKU3/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 KL1PR02MB6259.apcprd02.prod.outlook.com (2603:1096:820:dc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.21; Mon, 12 Jun 2023 03:01:44 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471%6]) with mapi id 15.20.6500.020; Mon, 12 Jun 2023
 03:01:44 +0000
From:   Sheng Yong <shengyong@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        Sheng Yong <shengyong@oppo.com>
Subject: [PATCH v4 0/6] f2fs: add f2fs_ioc_[get|set]_extra_attr
Date:   Mon, 12 Jun 2023 11:01:15 +0800
Message-Id: <20230612030121.2393541-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|KL1PR02MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6697293b-f580-4cb5-3f85-08db6af15a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXQOlJhgHZg9QnxtBMsueE+i1ybSyXRQ/xo6pNCmI9/eJ4YqQFk3K4MGgfjhaxbWw1ohWKvrTYa5bmSa9i+ARuvunPgXVe3av2spPj0BMPrfjWF0VJYxKPD5oj9uCK22DZfXbH73dImpGX4KD9fgGS20VPH9JSR4X5wrRSmmjvIjZU2ZftD2nOqCPprcRBrAnQWD6qogVfC6D5s0zlB0HMbzIhSbj9PWygw1n1rrMnknxd6NO3Zx0VPhOylmymnXjthpC6NjS+3pxkDsU8n6S4bLVden7FgIeWJFSTgk3ht4Ewb1Uhp0rdQrkt2fyrTttydG5gUnGRIFtgAJubN1oCEimdsjgTkl/YKf+mvONnZLE16GFde2MO02C+N9m3y08g9ofRULm3rJ/wCaR03Np/f380V+FH9TObJtFOG5s0uGdeNffdHeyzxjZXcbsVXfVfkFyawZbkBcI3bhk/njcJVsmh6NMlewdsvrnxOHDoCfcqYhE16gJRXgBIOgTbDSSt/hKhzEq8SagLgb1hPy2aIPMrRlss2KR2SUlr3dMw3snrFZzBhu6q1mOkjiyr3+nwJpu4JJuS7piWWgegfNEmN7rMMoXRIfEM9QWcWvaCO0PSmhKToHPYl6kaK/L8V1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(66476007)(66556008)(8936002)(5660300002)(8676002)(36756003)(66946007)(4326008)(478600001)(6666004)(41300700001)(52116002)(6486002)(316002)(38100700002)(38350700002)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(107886003)(2616005)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K2CA3fMnp0BJvs4CIxLHOW5ANTtXk+UjC6e/bThqJzCJ/prDohPndzhjs8nK?=
 =?us-ascii?Q?XV+XJJyYCBU0XCNYH+IC2yiFg/KHbCPy2G2LRiqhv7LR26BvqPKWuH3ScTSJ?=
 =?us-ascii?Q?LxRg+vGOC5REmPv3ttn9H875E+O56T18CGVFwLQXbsDI3Fu7gsNoKzUzlaxt?=
 =?us-ascii?Q?6wVUWZVPJGlgkaRdYpbMZ5C33qUBqnRWt1G0WXaxctM9ORbSgwug50LLyOWD?=
 =?us-ascii?Q?B9fKqMN7WmjCbODz2ZoHN3jokJC1h2Gmg5SGgmCehLh5V6eFqQ+wrxKf2/lu?=
 =?us-ascii?Q?mvnNS4XXG5f5kHh/N5lQSy0PT3O3MXnrAuKO57VQfiIdFVLJ4Z2h1XFHDnHK?=
 =?us-ascii?Q?e2FecOgJ9GJhAGSttj3RjdsYqObJbiIT5oQ0LRVjVAToUZsSJbQ7dnH5ZsYs?=
 =?us-ascii?Q?5ntuDMP1ffz1dgmNUgns/mAiaJ/0Mj+tUl6L8zIRWBAidcD6ut5OjtskJFMs?=
 =?us-ascii?Q?wtihsZ0R0X1bVObyXgIB7u/69GLSLO4r9dLJm92GVM2ZvbyWfW/YwsFK8W6i?=
 =?us-ascii?Q?nvbFhdjRGZgo7QlOnX8ey/K2clP3f6ukmbIbWx/IDNY8elhRXM802+hie1EX?=
 =?us-ascii?Q?4TX/8bGS5niFKoy6D04oC7E3woPpORnuTiJ4b+TLPHJK8WZudOQFZpIj4LLe?=
 =?us-ascii?Q?zodLCiMqBTj1PX8gH+p9j1JE9ixfSnw+AMh+vk6GMGnTBGL2HjIRQFeUGZfT?=
 =?us-ascii?Q?v53a2g3rLZeuoFPGcrbIA4vK5XwmAYPmyvxYkS9noTk08vuglJJvC8W507Jf?=
 =?us-ascii?Q?qLQnb5UXafGwz0PLDrHGeNyIJxZNXo79NVCxA1kNDH/tk1gffigYQKT0Ka/h?=
 =?us-ascii?Q?r5Wl8hB09dXthHgqbWORYhaDYvpTVw356UOczeuEEq9XQkDI0PZxHynRn6tC?=
 =?us-ascii?Q?W0LT9ZbljTvaFjfvUEQQooI4oir8lUCFVyNnjrERM7eniYjl+EL7Hj08g6QM?=
 =?us-ascii?Q?DJIW2I8DQKU17+GkbkukteHkX4qRimulBtwuwC4BVx+nnXSv3JLgxJjL3nEf?=
 =?us-ascii?Q?lqWYGnk59b/PPJoW0Ha3MuB06moRunli57E3hVZDQFgIk+LCCYH8kyV/esRN?=
 =?us-ascii?Q?R4/RYnWjimJ5I7cLWs9avKs53tcvg9yjVyPD6qH1GtP8qeslDWTUxIRBQEIb?=
 =?us-ascii?Q?oxd+eGLPW3T3y/YV7EQAcj/NweZTP/Ell4CQcg1CrDxOxxBeuwvL3BB9DKcn?=
 =?us-ascii?Q?+Yz+rJJMZh4RLHU5u0UquyU76fnH7M7ZdgYo2PW0wG7pKZWdWBcMA9+ictia?=
 =?us-ascii?Q?MvvXmqAEXtGKnvKvBpWKCXwviTB/VUlfiIEVtJ5oQSq2SXC7pWGuJUhktu+X?=
 =?us-ascii?Q?45OoH4jOdsDLpeYtgh9+h6bqn8myGOA6j+KybQwdgJkv0s9lHSCWS3S7OTLy?=
 =?us-ascii?Q?nztkYAil478SYS/CjhE0BFiSaTu4PE51vvs/CXtEBBJx4674KlxHdCJEVHTM?=
 =?us-ascii?Q?hua21kM0aUVDFXJcIk3+63FS3qYeX6frYi3xZm1x5EtlQaurcj+ILrvr6E1x?=
 =?us-ascii?Q?wvdgBYhYG/igNnYqfqmI0/0rKgvTx9nJE6qNC11/dPCkKu5DVadE2rSlfQu6?=
 =?us-ascii?Q?lTHh++MKNx197Go2oGscMpFM8GRH6emmKdRb8hsg?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6697293b-f580-4cb5-3f85-08db6af15a45
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 03:01:44.0198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIC0P4AbuRE7r2p/CE9d65Q2C5mlEzB62cjSlcz7Ka0TvoGfT+qIYmcN7+xL2XuZ554ZzcOXn7GdQVu9jgi1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces two ioctls to get or modify values in
f2fs_inode's extra attribute area:
  * f2fs_ioc_get_extra_attr
  * f2fs_ioc_set_extra_attr

The argument of these two ioctls is `struct f2fs_extra_attr', which has
three members:
  * field: indicates which field in extra attribute area is handled
  * attr: value or userspace pointer
  * attr_size: size of `attr'

The `field' member could help extend functionality of these two ioctls
without modify or add new interfaces, if more fields are added into
extra attributes ares in the feture.

In order to reuse existed functions, several helpers are added to:
  * read inode chksum from inode page
  * get compress blocks
  * verify compression level
And, a compress_option v2 is added to access compress level and flags.

Thanks,
shengyong

v4:
  * split into small commits
v3:
  * setting lz4(hc) level correctly
v2:
  * fix compiling error if CONFIG_F2FS_FS_ZSTD is disabled by adding a
    helper f2fs_is_compress_level_valid()
  * fix compiling warning for casting unsinged long long to pointer

Sheng Yong (6):
  f2fs: add helper to check compression level
  f2fs: cleanup MIN_INLINE_XATTR_SIZE
  f2fs: add helper to get inode chksum from inode page
  f2fs: add f2fs_ioc_get_compress_blocks
  f2fs: add f2fs_ioc_[get|set]_extra_attr
  f2fs: access compression level and flags by extra attr ioctls

 fs/f2fs/compress.c        |  31 +++++
 fs/f2fs/f2fs.h            |   4 +
 fs/f2fs/file.c            | 280 ++++++++++++++++++++++++++++++++++++--
 fs/f2fs/inode.c           |  21 +++
 fs/f2fs/super.c           |   6 +-
 fs/f2fs/xattr.h           |   1 +
 include/uapi/linux/f2fs.h |  33 +++++
 7 files changed, 359 insertions(+), 17 deletions(-)

-- 
2.40.1

