Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32756FD704
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbjEJGau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjEJGar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:30:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2121.outbound.protection.outlook.com [40.107.237.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0295212D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 23:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK/r3EVKqpii5XjqIN+Ef4QYfUo/0lTz6KQ2JEtF7JQCwCRQ7Scopby3vxTAdHp2/Stb4I+SvSe7GmCpQep7qawnBsUDjVS4ktAe79pBPFy6k+glBSPdJMvN4UJnLWlxCGRfRQT/Hg4QBnz702SQUQOPoDQvnynya5lPxR9HMhV8CVL1Qamesi/yZlle7LR3dERTAKdHtohxLcR4/1fMJv3ytz1x7ft/57y40lxPAShVsfO5inAcRlnQbhwY38kq1RsA4EFGpG7h/BNc2cMR8/HRGu5rl3Ae1qcbFa1e6kMOvxIgafUxet0pUtIEN0pNxqDwBhPotCb7um3RG9CXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2A4XxN06K4pky6vlCPPIS678Av6lyaZ80Lbv76Ys1c=;
 b=NAjayLRUPWdVDBrrynOqwJQMjKDt9/3lukePGll3w+cqk4FrGWr1gLhdSBNS3h+vq874pGf9J/nfHWKOfGwBYakbMK287Kk0xUIpr+Wb5rRJsXTa+xD9vDITmZm25SWtcBFdBcvda4GlT8wdmHqvAgDihHvQwViDtQK2Lo/4Ur4fgsiajUYlo70En/uPQqFaqT0uFs89P2k5hKPuCeShyIS+tQlhpyJB30+XR8eHPVgbGjBXeBMXEK8DoLRcPn52ekHypOXOllf3vI+FXwyX6d2hR/ltDwbHKLfL6+jOFsDjvE5XKqwg87egwWwI+zrthD17tey3mvbbK1rKTlalmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2A4XxN06K4pky6vlCPPIS678Av6lyaZ80Lbv76Ys1c=;
 b=g5acMhtI0lBkNf02waLZNDS0KQ7xiba1UXCbkan0HbYz4sy630oRk0MoEMn/x0Eg4Yff1mMudpKSW2eyQQapc0r9IINqJ4UGGgUeDCG+ut2jKUJnapFeSfVqDs1gH+V9zPNplfvrY/SMVMU/Be6fuSqzk10s1NJgJ4OROqsYAeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BLAPR10MB4964.namprd10.prod.outlook.com
 (2603:10b6:208:30c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Wed, 10 May
 2023 06:30:43 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::8374:2506:121a:5612]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::8374:2506:121a:5612%5]) with mapi id 15.20.6363.030; Wed, 10 May 2023
 06:30:43 +0000
Date:   Tue, 9 May 2023 23:30:36 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Kernel 6.4-rc1 ARM boot fails
Message-ID: <ZFs6DNgzBHNarr6D@euler>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BY5PR17CA0067.namprd17.prod.outlook.com
 (2603:10b6:a03:167::44) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|BLAPR10MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 637310f2-eb5a-4403-96dd-08db5120131b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80daDtSP7oY1geBME91//c+xdQqgQCT8ieWbcSeqcO+p06tktSqyH5Hh27+onllJfZAscs9P9o77mD9Fv7jhjXbs6L5AXu5HTS6as7w/kZ9xdzx6i68IJxUeu5Hn49uieZv7LvHYoWTYS7LvZbx39PzEzi0ajtEGIeSGJ6g6nTHdUhBrE3FtrjhUI9vttHY+JjRKk++ywdn0Wx8wA9BeudtxKHObNWEX5puK9nXOyTvnEvPL0etLI0fOCH3kX/j8yBHD/U9qLm163YKREB/qCyoMolOM3hyE2WqFld1vZhgHymYdMdASnpfvrh2r37S6VkMPvGwL2SzlNWI9nVhLdBi679Qk1ZkJzDynRLMgOQ2xinufx10//addBMLMs1WJHdx6NhB0pW64hep5BhA7ztpgFVKdazjxLryln3EwIBCKe6yprXbXM5AC3TqIllX4uSe6XnRQl8VMMR3AYJtHwO5SukQqr+Gc+5zT5qE2YgYdsj4EBWlt3lRAwqphmV221WGCFQZmLI7//g0u3S1uMoWxQuHVKaGVehG7LDXqTUbIH7A9fPgPdQlidPnKyIE/IC7ikEz2gGsHl8q747IUbrEOwnsJwJqgdSqFgZqVZrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(396003)(39830400003)(366004)(136003)(451199021)(6916009)(4326008)(66946007)(66556008)(8936002)(8676002)(41300700001)(66476007)(44832011)(5660300002)(26005)(6506007)(9686003)(6512007)(6666004)(54906003)(316002)(478600001)(6486002)(2906002)(4744005)(83380400001)(186003)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/3eHAJ3d0BSE+pRWRMinWJmwiMJHwAtie9yCc2y8LARCV/mjHsbvjNKWyRh8?=
 =?us-ascii?Q?baYN9ir6MAI0GqSpQnAIIWX8d4WKfXegrjOg59OK1zenrksoVV73aOfYQbLL?=
 =?us-ascii?Q?C7MRKL4D+Xb4Pb4WY0uW3jlB5NUmdBVbdfIUMESxts/wmzVfKkw04jWN8i9K?=
 =?us-ascii?Q?5vrQzLByzv07wjqbJfa2LXX9Nc/kV5afbBc73kh/kn8Lk+B0ru34c9lN5F/t?=
 =?us-ascii?Q?+ngRfWd0VSwF8va9XSyNnnE+h5fQelXDic2PF+jwmh5L/eU9tGDIMkkkvJJY?=
 =?us-ascii?Q?bJo3H2YzRWIQKzjXhwzUGwaoZ4N+gk4dnPYG7jyyvgXdUkEX9koIea8bPlj4?=
 =?us-ascii?Q?EWnjyIZV9yXyEBg1qZJgJ4v65iYGP+A2/x1F9jZ4/G6Ucl3duDeBgrWUOlN0?=
 =?us-ascii?Q?Hu6jWcn8P4gQYAYDIL5G9+/9PEY8ZbJcxhcqZ2wf1g3RW4Yxl4/9AeAwIdMc?=
 =?us-ascii?Q?ku0dRt8j8mmPxVNyevswP3+MQ/u1SkNlSCHiTwsVxJoKONetQHFUQBl9JcEX?=
 =?us-ascii?Q?mmca5n67JetpuVquzntvQlfWfXMvcbSey0wxqCkYmJyW40LRe+gOiCYCNaed?=
 =?us-ascii?Q?q3C4PRYhyspNF7xcI/LcpaxNjO0FRcqOFKiseF9BnYA6HpRBRFjD3vrhGbcy?=
 =?us-ascii?Q?Ljf4LVvMJJFzMB31O9E2cBHstGUMnjXw81aROndClAWKDA0huoMJwy3Q4sE2?=
 =?us-ascii?Q?X/LfUcq94UBFdqJeYE4P4yxvrTEEBHwXsWcC5W7Yz8E69bhMLDW06byvkiNM?=
 =?us-ascii?Q?vRxfxM9zVR/zJHQTRmSnkkMFZBiGh1sA2NnvUaXVPOme+A0DCOO0291xGiDM?=
 =?us-ascii?Q?1OvITO5/lc/6VFQBk4/MKIxYwzaXbCya5QLpYRwYivm/gCjg1U6f8i+pSnmE?=
 =?us-ascii?Q?leTx29m5vGltTcyI6viSETCEkdKJQKwTIYRZ9rCzwgb6MZzNgB0vV64w3vLX?=
 =?us-ascii?Q?Ki68m8F5g+UiIKxvQ6pQ2Y7czVd6zY0TttO3YDaCUymSZJl41BYNIFSas9lQ?=
 =?us-ascii?Q?hwRTEAoC01sCVrhOGt5iDIT3vn0KaySiD6m/6fgFSS+uavNMDh3lMAMobrj+?=
 =?us-ascii?Q?zxQHRo9QBk/XuqADYkOGvK43EQ8yHe9leETJd9l3CZHLurTw0WJkUB2OwMx+?=
 =?us-ascii?Q?cmEUWCt1u3k6b1nsWFMYEwuU6gtF5EBGZe8j1Re6Ihu6mR+5FradXcqJ6y14?=
 =?us-ascii?Q?f6JLRKHoED3XWgqkZLEdKA+j0PZqHnLf2rVzPiLd6rex3dPAex6gRjC63bPj?=
 =?us-ascii?Q?qOOiIqhJsWPAxFkclBsz5yP/FoQuwAf2k3LVqh2E3S3iwAHm/HY+tH8hwsHj?=
 =?us-ascii?Q?m51jWMszZYqpP36EN/n97POEQq+doVLnShVvv2chW63cPUjFgQHvZPUOkfHY?=
 =?us-ascii?Q?e19ZeS2KT3YScXi8mCMupVEoM097IG/sv4Wmt+YYfNuMMgYqWDREgee6AG0L?=
 =?us-ascii?Q?++K4sW+ofDIJKxc4kDSjal1sj9xdOojHJRdRvX8c/j34d7W8DlUYpXqMcAe9?=
 =?us-ascii?Q?BCiCOTwKsbuCms+sw9D9nciNOnUGU+khL3PpCAzqDOq/2i9Ug4JAwkHk5d5Z?=
 =?us-ascii?Q?feQ/YkaAumERFzIwtHE/9R9MA2TKvVqZma9XgrTo0jUDBTX3uppeT/kVK7qC?=
 =?us-ascii?Q?tue3Ey8EfEkhp39UG/s1h9o=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637310f2-eb5a-4403-96dd-08db5120131b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 06:30:43.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycZLez9tKD4mONX359TffzwsoTlRQzwxl1OT0QIUiKMhl0GHu4lRVVw613fm6XlaKQSG1hKMuWeKvSyr8MVn63/ixtv6VUEP/NctnD5rdko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4964
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

I just wanted to give a heads up. I tested 6.4-rc1 on a Beaglebone Black
and kept getting boot hangs. A bisect led me to commit c76c6c4ecbec ("ARM:
9294/2: vfp: Fix broken softirq handling with instrumentation enabled").

The dying message is "Run /sbin/init as init process"

I'm not sure if this has already been reported. I was able to revert this
patch and confirm things work again.


My current kernel version with the revert is below. I can share my kconfig
if that's needed.

```
# uname -a
Linux buildroot 6.4.0-rc1-00022-g6ceb2f82fe40 #1313 SMP PREEMPT Tue May  9 23:02:58 PDT 2023 armv7l GNU/Linux
```


Thanks, and let me know if you need any more information from me.


Colin Foster

