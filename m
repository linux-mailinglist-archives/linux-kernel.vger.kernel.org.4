Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA56C1103
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCTLk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjCTLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:40:51 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131ED16AE0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5zSAsLDHm3w0825anSkXmX4GFIxNyiXIcpCAS1SolZ9G0bTb2BYN1/ppL6rpfA0XfSVwV6JIFIgzek4p0e/6Fl5Hk406QJImuHIPwZHLpOIfHMav1Xu2tZ+/o8p1ayDtyGIHv5tMnjmSw/UScUuVNKVKM+2fxSJALqw73zUkys/iP7WP6bt9SWSQeZfuJoCK5a1xO+zuItnlzF/5yIRatckXqLBuKM77FlNvsmwLl6IFm3pLtbgO6SsITah7sArnw27F7riIumamj6gPooVAI+dKR5s4Dwv3GfrFK0gn81ArL4qUMqL+jcJOTDVRzJacczVSdGkVN3V+NFIWe0OoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XZbiSFNzaPaT/tgutsHEmry+xC+8NcD5kl3IgGCKeI=;
 b=O+PzaZgrMWRDFjegGaLY4JcnYxxP+B7D7B0Qb/+Oxrce9y2J3fKYIMDJAIi7M5q2t4nKnQHJwk2UEwRxp+bFROPyMgp3TSV+z0sHMg3ak4Yu42ysGdwb70wN98MFUXwm2EUwQniZm9rAt46A38V3ICMqB+5slgp8uTVnvtirLq+qYoUwJ9cyahOPjuk1gGujSkJIH3ovKb2BDU3kUA2v3m1wr0Z3FfZcThxY75WRy/m+/e+SxBilo32ZiTv9BmZT13UkQG1DCZDIStALjCYON0JGHaUaunZlK0CsGdaD+LbG3zWRTJEa97Xa3gMRAiwbDWWcTSZcmKq6YrOjvk51Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XZbiSFNzaPaT/tgutsHEmry+xC+8NcD5kl3IgGCKeI=;
 b=c7eVM2LMHGu9AfdtuXNCu0KcklO5ntwRKvNEWmeOax9Pij/0YYUsoAGG3wD1tmeia1p13YsYH7WM+bS0p5Noa0ZgVUOB2Wim/KNeAsr/9C7p1LJyxiMRZQjLOKKHzvSkr1Od0J4osk8i9Hu4fLjF1t8MBgtCDcTGP23vGwd8LCS9nkRGmP+waYL049TkqPS615WPcbljjDGzGW8Fk8bb50yMeKbsr4a6V8Kahcz6q5QzkoU/R9ZWG3L6mokppp8XyNrvhzIT3e9p+llt4U+0NBl55u9HpEnnQOe+u2ICk0/VEL4eRQ0717rU8EnYzw7+D4igaQE7Lw44MBOq+5itmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB4981.apcprd06.prod.outlook.com (2603:1096:400:1af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 11:40:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 11:40:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jack@suse.cz
Cc:     frank.li@vivo.com, jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: check for register_sysctl() failure
Date:   Mon, 20 Mar 2023 19:40:28 +0800
Message-Id: <20230320114029.76809-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320111229.a2zi3m5rszuhffwx@quack3>
References: <20230320111229.a2zi3m5rszuhffwx@quack3>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf3afb0-0927-4dab-eb64-08db2937eccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9sqX08iO4UlzPHB5hK+ZEr3Gnmm3JlOwoTgKq5AAQRV/Baqbg8AfylFuCHeswTJ2gcPSVSrb2tVoLTXkJpkZ3Is15k0eLeYSiYcjjGgAjo9TJ7lV2kBbietMdzxN7Joc6SehoIk2B+ECmDqBv0Q8Q+MQUQ+aqOIwiO75AFFeRRQMO7d34rDp9rcepVrQmZwFMVJvdk6OLtOo98ZuVvdvTLTX2OiINemneE2p/e11EZSJhDEQoxbha1RYwO9pZOho6MneY9Pq6/OsXKW122xS/xhCl+Bp5qcC72D3j2Rf+UradCcs/wp0I1Mu/lRFOs66rhpkqVtaAwXo21UW0c5EbmrPwKacRwejXQXPYl6qhcipCB9jH+SL/LihxWp4o+DZ0Fm2x5aykVa90ODxekZ12iSuXA3BViYkXEcAw/g1XXJRBzVISJ9uPpDAEkgn3ieMqm5B+HxesEuGqPi+V/5F21t0PgM3BWDiDS6GZR+2FL3Pp+jzbX4mTt7iE5zkZRuJ+TM9wlOFY5Rt9rPOciiqlPDaJu2KRDvIJAix+5Xj0gPcZPjy2fvL43DIbhsmtTnmRw8lmpv0dRSc66bJ0wm+WF+UVKq1UawLLW0BOHHiixDgol0BkneXydB2bAFo82zP942D/XkVpK3AV9JMxkD8az1OclRdfU0O5c/Wrwsj7kk+EyOUOJNVU42V9alH4QR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199018)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(66556008)(6916009)(4326008)(8676002)(41300700001)(36756003)(2906002)(66946007)(15650500001)(66476007)(4744005)(8936002)(5660300002)(186003)(26005)(6486002)(316002)(6512007)(966005)(52116002)(6666004)(478600001)(1076003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9k7RQSU3+kcuBKHYRfh4t+O8EIpqFMv50oW44uWXgmP2kOXwL3o4un/jSxM?=
 =?us-ascii?Q?G2WkLBW5vYYWFNkutIL+VFDC9esvd17bc4zwtS3xHAooAMXkACCGC/DXhavg?=
 =?us-ascii?Q?hniCkUODjwfbL/dKCgmV5MrVnt0QVE6MJHQd+8A93RN7c35IG18Dq6x2MogY?=
 =?us-ascii?Q?rfE880bLQpyX7VutYLlS9XAxTeHcYkR9asOz9uNR2a3m/CzCBRlHjUdB8yi8?=
 =?us-ascii?Q?YEq3JpsPoXVkgedUax6V1cm27yp7JbRnwybgt8SsyPGfLoddtVCqaiwBGHfE?=
 =?us-ascii?Q?lyqCgIsoam3rc7cBnGdhe+L/0/RhTmzIp/6nkNdO8Jmi/K/8KMQYFrlL7/aa?=
 =?us-ascii?Q?gLVDySRL4gHvvZ/Yn++zQmuzrZAusGEXuGdv4OPsTjTu/3vSmC/71uAhMQd2?=
 =?us-ascii?Q?ajJR7GzzhgUtFbnH0j92JEw6KiR0Xgr23PfUQRy/7usP13ao3VhhspF9C8DR?=
 =?us-ascii?Q?+1SULP3skl2cPsv3nt1PukbLx4n5oVeQk6gJq34tBgI9bZBGzXa3iQxiyPVd?=
 =?us-ascii?Q?i2kOpYA/0V4CWd6G81IvZ2w9YBaD1kLhjKExsCnwTQ/doIgoC5YajYT+gW+m?=
 =?us-ascii?Q?RNXNYDjPRzO+coRXD6ZJ16dA0I8+Cj9oL2c2wFBxiOh8CXx0u01TOZFXXek/?=
 =?us-ascii?Q?3FNgnglO5ZB+2CAujagEgjUfJ4XRF7pD90fdiVoheo2viPCFHkRJ6IDGeVEK?=
 =?us-ascii?Q?iEzYcEDvWmN/d6bY+WW76tG5g9kMTxpPurDSfSLvFT7r4K0nvz2N4A00bolz?=
 =?us-ascii?Q?p3xCaURA4+Sg1ERj8yojxn7sZY4vLHSwMSPbxYTUkBCxSZGtMDiNbtigkazP?=
 =?us-ascii?Q?Q+WttZbMvQJTnbD9CWhiC/ldMs+1T3KFSlijOvVIg7Wk8J4kQPI5JU11MjyY?=
 =?us-ascii?Q?tYEd9V3vyso2O7FJ/R+mNIwQrQDcDNRfi/4OMKSEGlbWUoM7yXIPLJggob/i?=
 =?us-ascii?Q?p+v3KLh0ng9ozr+JVKxGhflpE6vyTITeQWePeL1Lq9w2QhwpnNd0MakbUAbG?=
 =?us-ascii?Q?Xurg2DapWUDpNKSHH3PyEghnyFiC8zr6La+yAMCBLH8JAmwk7BdQI2QdyvqK?=
 =?us-ascii?Q?ZpI14uUULX0g+ialxPcolFW5x0PcL/C7q4o55TEgmcygeofXyxtdRLM4qmts?=
 =?us-ascii?Q?AhQm0h+kwWVls+T5/H0D+C7qlLV9jkWi0xzMUYAkR9wBh/2yqkgglFdkDkGk?=
 =?us-ascii?Q?lzLHaN9IlH9HvlLBBKgDVeSA+mIumeB8fxAyyhKUkJyoX2SMvTk9wZgXA+9Z?=
 =?us-ascii?Q?rJfxlSYKRWGl/dXi48N+Zw09MEsbxMopKUNulZHOW3SHhrsqIXEMUEmwwrB/?=
 =?us-ascii?Q?fCpuYX6YDsUqymSWUf5oWxiZXo2zDAoG9yJ6mwaaBY34u2ErxjyzYCjW7ho8?=
 =?us-ascii?Q?fk+liwCWiTX7wFEHWoWEVZ25QAUbky+yBgXLth1tDSbMq6Q7MlYSRwrs6whu?=
 =?us-ascii?Q?5wkXMlOdSeGI31Nzm+Xpp5ADpooCOFGT7a4AXVzeJETETTKukCnsc6Liowj/?=
 =?us-ascii?Q?Zc3S864tnI4RZQplX96T3wqAnafYDL0I7e1ELEpNzqiUqvRTFo2MaNurKB5j?=
 =?us-ascii?Q?nHGJHHrEfgPBoYwDhGAElL9MLF84r5wXdrU6kKAL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf3afb0-0927-4dab-eb64-08db2937eccc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 11:40:37.8219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8gBBrAmBK3PYsgvTaoTEpr/GqDV2EX0naQdBAcXmgry+MZzHOcL+6gQaQSuYe46TMNxMT93n3i7RvPG4wIDMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, but this is going to make system unbootable with
> CONFIG_QUOTA && !CONFIG_SYSCTL.
> Quota functionality actually does not depend on sysctl being
> available so just continuing without sysctl is perfectly fine.

To be honest, I'm a little confused. Should we panic if quota
registration fails, or should it depend on the user's cmdline
parameters? Just like in the filesystem where we can choose
whether to panic in case of exceptions.

Or, should we panic if registration fails when
CONFIG_QUOTA && CONFIG_SYSCTL are enabled?

BTW, kindly ping for:
https://lore.kernel.org/lkml/20230228103515.sb6qpvnmbvenvq73@quack3/

Not sure if you have forgotten to pick these two commits.

Thx,
Yangtao
