Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494B7743CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjF3N1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjF3N1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:27:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0763583;
        Fri, 30 Jun 2023 06:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsyKScNp57lPAWFTQwnA65UYXmF++2+tYdMsiUL6tnCQGi/1i9cUTm4bdFzGWwhDDH1cH7oUDBJyXi96yowZrnBmeUKTcDSk+5KvaZX4gH9uuJUk1dZy5QGb2Ldo8tOUUI5Bb3iWVtigXlC3MtRHjLvA+cjs65Yq5A+wlX4VOunmM44195OQiGHawQeg/37ZYwLoebmmx9IizRJTO/bXexPcZ8ka4tw/xOCrY9auMlC47fjG3KCjAHY8P0G8bg/Fd5HmX8m7OTFFa1omctlIuFslG1eTtGL08iZe2X7WTngUauiPNMCR2IOgOBnT9ijDle/G3AwishjmqhNk1hzfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxYLm7D5Gmad0N1wT3zX/H18VCGNWT+3IG4gvA4dqoQ=;
 b=jg/W221xQoK1smxmHLZrGexL+RU6Iq8uT5KVbG3ss564jR9qaE28nkHhUeAvsOLIFeyAc5YuUQcTGlb+MKNsLrEyM0nWog5p4UBqP8wnja99EqxWF2dJdsHRkRtpLMbEJpmxVPSA+9RAAZV3l/EsPB8shoy7Jz7KaCVCdvcvEbPk+izyuoM0AhnUk2uMsBCdrb03kOdQMM3ySqWlaWvyxvjtkmZTrhsjLFT5GN3xeb2lC01RnkBsD0qgO2ahb5jN0O+rzvE5wBhtO4GOEa6/FNoYtFYZhVRJZQo1DLdOgxoVkWxorsMtY2Qix4aFMPgjcu1HFClUFULdBX3w0hJHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxYLm7D5Gmad0N1wT3zX/H18VCGNWT+3IG4gvA4dqoQ=;
 b=WV3mAYD7cGha/gOE2iNH2BHj1x1O+zzxvqzFbb1gJFRyN6tQGr33RTzZDiD8XtzaQCkf68+aQD02S16rzLo18aqZ4HtikGm3R4ktHOEtRkglSIL4wuA0c3zuNVVV+H6sX/J5axXbzikaToRID+ydzo4/9OBfkSzvNk5Zso1v46w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB4527.namprd13.prod.outlook.com (2603:10b6:5:1ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 13:27:37 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:27:37 +0000
Date:   Fri, 30 Jun 2023 15:27:32 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, sgoutham@marvell.com, lcherian@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, sbhatta@marvell.com
Subject: Re: [net Patch 3/4] octeontx2-af: Add validation before accessing
 cgx and lmac
Message-ID: <ZJ7YRP9Fb4HUL1eg@corigine.com>
References: <20230630062845.26606-1-hkelam@marvell.com>
 <20230630062845.26606-4-hkelam@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630062845.26606-4-hkelam@marvell.com>
X-ClientProxiedBy: AS4P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 69986158-fae0-4271-cde0-08db796dc5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDqQhM+OYPEc6mGVrlb8yVPDfKL3JVOoDrtSWGnn/cYZgQRevJsZiic4Zx9BQ+F+ADzr7UKb0xQAwj3Wn28r7/koCePvanDgjow2mNh92g2FOkYarquVj/tFv0GjG9+xTUhnfqJBsuHLW6V3uf1ykf4eU6tbdAlgDSXoqSeCcNqIy3/H73W4c5oMD17S8UsqdYaGGNSkJb8r3hhx+4VvVqvbeTxev3Kh098jWwUI2fuofW5/ZxhOCdyVc4WHpmN4dqtdtyS2uSOOaaLhcnCdozFmMc0Cw2ADH38Oj5g1e4wDBh5227SX7F1oW78vSRX/ImARw63/qL4nmnyTSsWQ33QFR052vvKNRMb4h409Bove9FT7W+7OOAOIJJfMKMqYPVc9LtY9ENvmlM+qg5QhYpmo4wPa0/WfTZnwsuviMyJYoZ681cYzUjMDgO080yE0V/fkPFd8ytmsmE0VbpmvAqUdGA72xMntcl/Yo2h0rVO4kmyitrEQYAyrZbJRFrJ7WHF+wDte9dDbSEJF7y08lvbWsgWXtv+esPqlaxeWAkTQzjZSXjJXrdgGe1vxY+ceVyz11rXK8104psD6rNvaZoKUFRP+TDOppK/vvswhsF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(366004)(346002)(376002)(396003)(451199021)(83380400001)(2616005)(2906002)(4744005)(38100700002)(36756003)(8936002)(8676002)(5660300002)(86362001)(6512007)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(6666004)(316002)(6486002)(478600001)(186003)(44832011)(6506007)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HHgrFByFQl8RZH/9aBwVRd2u3KSP0kvKYIC+hjZD4vO0AzyrcpYpCBqIUd57?=
 =?us-ascii?Q?IMQwk2OID4i6eobndBXQHHVcQkWiR1G6Vp+s7EktighFdDPCi2ITif1Ogt/x?=
 =?us-ascii?Q?uO2mp7hIYNIVpKAz1FI830PVfzaBKsfIgS7hkXV4DlZh4/5HUlxDownpRAxu?=
 =?us-ascii?Q?VaTfWp0AN3rspA2zUgHfUybnv57M3gKdtgxz+b2OOCxEYj/heL+2a0qaJzSY?=
 =?us-ascii?Q?2/vy5aGGga2gQYdqY/zN5F87Br/RmkBSSybnJm1m7qDghfSTRb7JYMb5jzR3?=
 =?us-ascii?Q?Q3+/VokfSXzxhNv68rOM98qCoNY1iaTaglD6WfoFrtShVuLPs6Ozx7IswrZZ?=
 =?us-ascii?Q?g9N9foxju6PXaVtVxuxg2MtYC6sa1SkSb5/VqnojOHEmH/B7+lAK3ardQA9n?=
 =?us-ascii?Q?i/3Jh3aMTWrmxVPG9l+bzG37mVWgAYmEh4Jg83Wp8/cCvS44rtbwMNK+cNOW?=
 =?us-ascii?Q?QNlni5uyll2gbjyuhrYrgV+BMHOVxI9+Hrvw2fiYq879tEmqhkrT+E9hFq5O?=
 =?us-ascii?Q?efWn1vDAk0bE6yKiAaxVKXFxwTMTIxOWEuGr9cG1Lqw0cEfWdplJBwsFyMts?=
 =?us-ascii?Q?EYdLHPZlqlM7Uwz6MTDzlPLcOtj773tMx2ZFC8mDym81eRamJHte3oXuzAiw?=
 =?us-ascii?Q?jd8SBjWR0hVbm5tlvs3iGQSpCXoqxqjkjc+KpNExvU8fF+0bwHzL0PB7LHdl?=
 =?us-ascii?Q?dYMG1TH47pBK2MRb9mYcmWRoPwOIXNi42K9D9mpHMh6aH9WjpgEaG5+rWNIx?=
 =?us-ascii?Q?iQHb9gVuCUFfJEbwF24tYE0lOJhPfXgPpp9elpF9xg4zCglMzZLu+yqDQNrP?=
 =?us-ascii?Q?bYlV4qiNLsS4AuKyn2tdQ6jh4Ubr75Uh8mZCysiO0vVUMf8GhCirBYbsQRYj?=
 =?us-ascii?Q?hqFzSWt+sEBVvAnWhzAx4UeS7/rcWVWwgX8WzCtHwlgzbz1R4RovkCM4OxXU?=
 =?us-ascii?Q?jepkJEXAppVq1kHq3UPMSN6n32M526vAHm+qr1rvr4VBRmq6jjEHvXufoir8?=
 =?us-ascii?Q?/OeEp/AukhOQnX7GzEt9PqP36QyHQv2KGaisKLq37TZssu6P+NWlpDOD2mLm?=
 =?us-ascii?Q?5tXuL2yikoUsvpKo/Uel0n3glQY4bQqyalB4N9jQnArxYJmEEEvAhoITjCnH?=
 =?us-ascii?Q?WSjhlW4kDA0XzbkdxSRx403b5BPq7I9UT8g36FCr3xMKUG2dwTuxydsBTZhh?=
 =?us-ascii?Q?XyJvrhXTfXCb2vzzUo8burqYzNSwAP2H6WF9C6KPzLNY8auUBOazJ5relNmB?=
 =?us-ascii?Q?XvFt3VjG7XBuIHKqQNitUXH0Y/A19R+N05J4PXm70V11kRQdphgZ7GpMSHgE?=
 =?us-ascii?Q?YzeLZDpUfzDximswmoc37u9eV9C95Kb7iHu+TaFzBndUJRIUJEzZKVOTNaw1?=
 =?us-ascii?Q?X8q2FR2t7V/AGAuDDQ0jntEgQsFaqLGlKF9g2/TFULHImhBZvYTZcW4sxNfb?=
 =?us-ascii?Q?R3mHUg46fRgFjY5ZOaXNiIoxG7kGk9XTPvt3/qxnkt5z4tocwZq3PV98HMMn?=
 =?us-ascii?Q?ods/4jY1LKOEa6tEItEEN9q+kD4mYOutVinelx6nzVvUDS9xh1rW6aeuFTba?=
 =?us-ascii?Q?LLHqX4s2OxnzLfpBKghRb2V7IikN0Q0msoXPb1IbNhWFmT22mBlB+Rd+AWQW?=
 =?us-ascii?Q?LmyEg48u1IUy7k6KIUS3pcFTCHrI7A5sqHrMMCacV1d08Z11hn6ghuvGrsAL?=
 =?us-ascii?Q?f9s3EA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69986158-fae0-4271-cde0-08db796dc5a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:27:37.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfLEwHtIq3zOhl8ZV91NLNoLLLwqCo3HH4c0y905hv/OddlKCmFTM0BffNjsW0ttuv62/pGUEYqmtny3LPU5CigZfBnknwNJZXnWU8Q8u6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4527
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:58:44AM +0530, Hariprasad Kelam wrote:
> with the addition of new MAC blocks like CN10K RPM and CN10KB
> RPM_USX, LMACs are noncontiguous and CGX blocks are also
> noncontiguous. But during RVU driver initialization, the driver
> is assuming they are contiguous and trying to access
> cgx or lmac with their id which is resulting in kernel panic.
> 
> This patch fixes the issue by adding proper checks.
> 
> [   23.219150] pc : cgx_lmac_read+0x38/0x70
> [   23.219154] lr : rvu_program_channels+0x3f0/0x498
> [   23.223852] sp : ffff000100d6fc80
> [   23.227158] x29: ffff000100d6fc80 x28: ffff00010009f880 x27:
> 000000000000005a
> [   23.234288] x26: ffff000102586768 x25: 0000000000002500 x24:
> fffffffffff0f000
> 
> Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

