Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1666D6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjAQHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbjAQHKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:10:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1119EC52
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673939441; x=1705475441;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kdmAa9I1wfueMo4BCAhQyMNkAVGFFeBOsreUwVbyDRQ=;
  b=eVrkWpTwviLxf1EVRYw+pRMRACSQrJMDnJYk4V9tMX4MLOY29cpibDkV
   nukR4hpHu1xPi+LVCcei60EJCuBIl58HpZWoXVeZYfuQrSxNTcvGda4Ee
   X8GzjotLVM0zr4xzGKnDoJI3mcjFg8BKbqLRKvJZBTPEmrkVUXNXewROq
   250Q+DqON1KXGsMIojMgksIWxWgNeafsMdS9Esw2fGuN/UsJF04j9rN1y
   /axmwahfYMpxOiYs/v4cEDTWEHXqCs8KKKnN5kQUuWFwOP59PqVjLmiE/
   V3wg69lA3p4UHCgVr/fVMU1WLobAxnzvxHrfm9EsxuMWR9NeisDTumNxx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="386977189"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="xz'341?scan'341,208,341";a="386977189"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 23:10:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="747950021"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="xz'341?scan'341,208,341";a="747950021"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2023 23:10:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 23:10:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 23:10:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 16 Jan 2023 23:10:32 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 16 Jan 2023 23:10:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di+RuqszGiq2dPSjmhxqoo6NNZ4bKH8032fb3VWNyq/iZh8dRXZcmRfX7rZysn0TUp+O9iZbhB3nmkzWgbGgUTMsFNrQOftf1rSDmK3qSoimvW08kmI153mNygm2J1votxJDJJRWFcGG0FLK8VVaKBuo9XUkcZBDUlqjebCsV/CE9CmJQoo/R9e6ghJLN4RnqfmC2N3x63o2ZrSOayXj5C1FFkJSPUpsCgjNLJbPW5bbBMVHeN5Yw7pXon7ypslPXVjjmD1kPzm9+5v06XNLK0Ls5WR+JMsWo2J6wcVrs9a1DWCQtHlPupcouN90+uM1XhZXcO5FgaJDrtLDdLK2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV3K+mzVPgp4imKE/vvsqvr81ntz+SFjNrMlVdgsqAk=;
 b=GtJ7cMdljIoRpjT3kObzXwmSXWzWLGpM0Z/gK/d1mCT+HhuNesRbUnKrSJy1Fq83TA7SI8WsAJTtPxFnqRW6OvsHA/y+njbA3HH8/xqwyE4srT0D40eEdo5421AHuDPpkmQBM67mVzvrx6o1FQUo4zO2smJQr14wyYrPyHsLWz7CODvKkSNSGHk6bv5nRN8nPYx3+0/upQrylIEmNxscRwA/H2H59OjUNTnh2uJRZjnD2c3LAoaVA/OwG3qvwHHCUh56sJk+MO7YTOlkBKWfUdd994fMPwWkgASguHKZWZhiZpUn3AxGVfrH3Ejdo/YfISlOJiFsioZSZDUSwbI/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB7324.namprd11.prod.outlook.com (2603:10b6:610:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 07:10:21 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd%5]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 07:10:21 +0000
Date:   Tue, 17 Jan 2023 15:10:05 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Matthew Wilcox" <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>
Subject: [linus:master] [hugetlb]  7118fc2906: kernel_BUG_at_lib/list_debug.c
Message-ID: <202301170941.49728982-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="SFb6pxBV9AuABc6g"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 0589ed2e-d0b5-441a-e7e7-08daf859e4f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJckFcLQ7fOvQLttY4S3uhmtamQGyRLuAKrfZcVnNgZzWiVK3r/M9Dt2gsmGgx7/Q1mdr/3okuFe3MLwvcPDdbI1vlE/beQ7Z/1Cr/cT/N38oYtm7crBzJRJP0QNyec5k6SykY+JeAl3A0hEfR5qnn/b62V+B49gnrlCCLPp+3kEIeaJI8clz0bLpaBF6krwBrG5AENYtsELj5VsHbKir+o1OXRYtO2d+UqyINS+xs1mZaqDHqwPnd2DGJ6vw51fE8Nd5g1jlCGdBHqT0P80nqH0+rM8ENNLjrm+GZSDNfRhJGjbZs+CvHdOzSJgd0qPPiteTZ+Q92BJQTOSFdJWCx1xfUuyTllsZKUcMqWflSJeeGwCHHl06tX7knNRGQ94Fb3hmJUos0CXCehEgN9+4YkvsuigLGhrpNxSw45jWXVSWVI2Vx62qlHHsmlDZxzN/yj1zKtdyksqe3XFPexSLFw0YNmPx73+34IYZfAuPtCuEGfDMCO9MriPfgfGKghkVxMEbxI+j6ehhF52ox62gOMO3fY44F2QwU2qUsGK9e6eLaKb4POAxfi2bHGTkXTBvi7Rlgz1ewiZecLHBAx/KfHUBczzmWXgnchkYMRt45j5qeSIGMklK7UpWN/CDu0vz8V+22eay0V7oceg462rGLO6iX/r/gw9QroCBEls6eNjMtbgTlV0d5Z2szAwrIv3M15ZKW5PtAWzWWbBGjBEyzk8PRydSBM0fMZ/4d4E9x/cMJWZKr9Tf2JBdUWjUcKDSWBUBGTSALhY1Hq9tLWHWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(235185007)(5660300002)(7416002)(41300700001)(8936002)(83380400001)(86362001)(38100700002)(36756003)(2906002)(82960400001)(966005)(26005)(478600001)(186003)(6512007)(6506007)(6916009)(6486002)(44144004)(4326008)(8676002)(66476007)(66556008)(66946007)(316002)(54906003)(1076003)(6666004)(2616005)(107886003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jiuzKw5cmOOxJ3XttONYjN0ECE8xVJYXZwzYpLEIAsb2FGvmDi/omeTrjHEV?=
 =?us-ascii?Q?NeavFBG8uqiItvdK7c1oG1T05IPYAAsDMI9Cvw3i+ie3+q9KCVeFgEsN7iN1?=
 =?us-ascii?Q?8uyPPXCaEkXoP9zMrT0xfeJAknJrkzNKhJL0ZsCe9zvvsRQnUcF+hInsssLp?=
 =?us-ascii?Q?G9KlSdxcRsABxMo1WnA4tyLcgTu8o9cMVMlNNW76bhzZU9MqCKvXdRu0Lh49?=
 =?us-ascii?Q?32gFSzYRnDUg8Y/oOfDuIBGZ60qSAK/CqpcR/lBvv0U2AuFvd2m0PwmEtBrS?=
 =?us-ascii?Q?GuJVxakfXX922Euh5yOQYsM44lgyYmI5Os00jwvvktjdVfkIYtC9fdiaS4gr?=
 =?us-ascii?Q?Y2q5G6bHzWTbT8yIwIkgebnINkAcOyKGHAuTk/F2peW+9pxwaes7eDwPxV/c?=
 =?us-ascii?Q?/nPdVe16mTtPKiHmeuEArVBi+LwlxnSN6x6jnOh8MUIV35ztwqgv98M//bGb?=
 =?us-ascii?Q?cupUgfp228sihzy7yRmq9QEqyJ+MB2QIk/4gGCzJniRD6uqrh/fn1v0sxqEN?=
 =?us-ascii?Q?2J2abz6o4reN6J84UdV80TFB7qnFoqJyPY2v7CirhpxCgZsHKlOJErGDvxqk?=
 =?us-ascii?Q?zWBAvYI9Fpi80jeG/viwmJU0vJHXZFM5CQS4Zk6rCpne8jTcq9JScEltS7tB?=
 =?us-ascii?Q?X+ukHZF/JwhhzB78qNnH1GGZcoP3gq46xaw/faJFKvdRSuWPgHJCZhJoq/ao?=
 =?us-ascii?Q?caXSsBipmXji+3IYsGJBeT6YHvqHXdtjSvajGGt2gMhieUad/n9kj1qYw1Ke?=
 =?us-ascii?Q?RwMsCfnbCk3qTguPNI9cgiD2pcEg08S6KbrXSvrxMf0bGSlrLQsWl5dd+drz?=
 =?us-ascii?Q?wQiQjFSg0o8DVW7xfg/vgxA7IXVPjAZKlwHhP5orEQ6KLHVXEdBUyFmjxevC?=
 =?us-ascii?Q?k6GpO4ZcI1/AKp6thspa1WZn9/LlLnZ7vw6XuOFkmsNAOg1quUFyYPiW0lUQ?=
 =?us-ascii?Q?6J9YxtHZ2GhgIXcQUica95Pz+lqdDLIFYobNHJ5911ammAwSTTRxRLxqNTzB?=
 =?us-ascii?Q?7pRwes5Wppr4e1xCVT+2t0XIFvxB0cjglbXpWb9CTLTh7HmaEBRweALBjdRa?=
 =?us-ascii?Q?XpoHSfXkVZe8CDkqOjn2WD5buRZEQ8VNZ0mHHZTZeYBGVg76Vh5he1YuLLQc?=
 =?us-ascii?Q?lclI/pseaLFo20qMUEpxpFCBHv0W1+1esZV42YN0WTq6OE7eIgNVlnx/hAVr?=
 =?us-ascii?Q?n72zNZgjBBcryR6iv7V5Q5PEbLhrZa4Nlwq5YPLw1i+F0dp4txFgZco30Cq4?=
 =?us-ascii?Q?WUVJovOHn/MDxjz/pnYYeKJeMqybVuB29EGswqNzmoDuOVxraeGitl4D69+c?=
 =?us-ascii?Q?+uQL7HCk2LopJhQb8VobviMufapNIi0y+o8p+PtIGc2fGqQxoq71HdSyvYGe?=
 =?us-ascii?Q?J6IQDTMHovcbBmYZHfCMu+NHmG5cRAOy9SvyR43NYbln+CvDTLuhFcNTtbu4?=
 =?us-ascii?Q?fyU2j0QGX4Gkisr/8LUHGEEhb3cg2ktsYPL96VZeWAPuDv2nnNHETh7a1AjS?=
 =?us-ascii?Q?Z9Z+n6tHS+UBFrbADyMYbzeRx67EJs8HSOy8fKh2w97VFBcPEAbbeb2/Xp2j?=
 =?us-ascii?Q?xVbqvhtJdyfNMPC2IfcB+RFyJD3+a0voR3fIgfLO3gnv67WRFFEqxls/r6KC?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0589ed2e-d0b5-441a-e7e7-08daf859e4f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 07:10:21.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HOYrBSwsanklRWGsD5TNwP+B87uru/54nrtx4d1BFMXVerFtvW7oVG02a2QxDMGiwangZkHK19MOOU8XZj6Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7324
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SFb6pxBV9AuABc6g
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


+Vlastimil Babka, Hyeonggon Yoo, Feng Tang and Fengwei Yin

Hi, Mike Kravetz,

we reported
"[linus:master] [mm, slub] 0af8489b02: kernel_BUG_at_include/linux/mm.h" [1]

Vlastimil, Hyeonggon, Feng and Fengwei gave us a lot of great guidances based on
it, and, perticularly, after enabling below config per Vlastimil's suggestion
  CONFIG_DEBUG_PAGEALLOC
  CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
  CONFIG_SLUB_DEBUG
  CONFIG_SLUB_DEBUG_ON
by more tests, we realized the "0af8489b02" is not the real culprit.

the new bisection was triggered and finally it pointed to this "7118fc2906".

though reporting for different issues
("kernel_BUG_at_include/linux/mm.h" for 0af8489b02 vs.
"kernel_BUG_at_lib/list_debug.c" for this commit),
Feng and Fengwei helped further to confirm they are similar.
They will supply more technical wise analysis later.

please be noted the issues are not always happening
(~10% on this commit or 0af8489b02)

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/debian-11.1-i386-20220923.cgz/1/vm-snb/boot

48b8d744ea841b8a 7118fc2906e2925d7edb5ed9c8a 0af8489b0216fa1dd83e264bef8
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :999         10%          97:999          9%          94:999   dmesg.invalid_opcode:#[##]
           :999          0%            :999          0%           4:999   dmesg.kernel_BUG_at_include/linux/mm.h
           :999          0%           2:999          1%           5:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
           :999          9%          90:999          9%          85:999   dmesg.kernel_BUG_at_lib/list_debug.c
           :999          0%           4:999          0%            :999   dmesg.kernel_BUG_at_mm/page_alloc.c
           :999          0%           1:999          0%            :999   dmesg.kernel_BUG_at_mm/slub.c

[1] https://lore.kernel.org/all/202212312021.bc1efe86-oliver.sang@intel.com/


below is the detail report.


Greeting,

FYI, we noticed kernel_BUG_at_lib/list_debug.c due to commit (built with gcc-11):

commit: 7118fc2906e2925d7edb5ed9c8a57f2a5f23b849 ("hugetlb: address ref count racing in prep_compound_gigantic_page")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master c12e2e5b76b2e739ccdf196bee960412b45d5f85]

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202301170941.49728982-oliver.sang@intel.com


[   31.031172][  T210] ------------[ cut here ]------------
[   31.032147][  T210] kernel BUG at lib/list_debug.c:54!
[   31.033124][  T210] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
[   31.034237][  T210] CPU: 1 PID: 210 Comm: systemd-udevd Tainted: G S                5.13.0-00219-g7118fc2906e2 #1
[ 31.036108][ T210] EIP: __list_del_entry_valid.cold (lib/list_debug.c:54 (discriminator 3)) 
[ 31.037237][ T210] Code: 01 89 54 24 08 c7 04 24 08 c7 04 24 83 15 ec 4b 83 15 ec 4b 61 80 f9 ff 61 80 f9 ff 9a c5 01 83 9a c5 01 83 c5 00 0f 0b c5 00 <0f> 0b 9a c5 01 83 9a c5 01 83 c5 00 83 05 c5 00 83 05 01 b8 44 f4
All code
========
   0:	01 89 54 24 08 c7    	add    %ecx,-0x38f7dbac(%rcx)
   6:	04 24                	add    $0x24,%al
   8:	08 c7                	or     %al,%bh
   a:	04 24                	add    $0x24,%al
   c:	83 15 ec 4b 83 15 ec 	adcl   $0xffffffec,0x15834bec(%rip)        # 0x15834bff
  13:	4b 61                	rex.WXB (bad) 
  15:	80 f9 ff             	cmp    $0xff,%cl
  18:	61                   	(bad)  
  19:	80 f9 ff             	cmp    $0xff,%cl
  1c:	9a                   	(bad)  
  1d:	c5 01 83             	(bad)  
  20:	9a                   	(bad)  
  21:	c5 01 83             	(bad)  
  24:	c5 00 0f             	(bad)  
  27:	0b c5                	or     %ebp,%eax
  29:*	00 0f                	add    %cl,(%rdi)		<-- trapping instruction
  2b:	0b 9a c5 01 83 9a    	or     -0x657cfe3b(%rdx),%ebx
  31:	c5 01 83             	(bad)  
  34:	c5 00 83             	(bad)  
  37:	05 c5 00 83 05       	add    $0x58300c5,%eax
  3c:	01                   	.byte 0x1
  3d:	b8                   	.byte 0xb8
  3e:	44 f4                	rex.R hlt 

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	9a                   	(bad)  
   3:	c5 01 83             	(bad)  
   6:	9a                   	(bad)  
   7:	c5 01 83             	(bad)  
   a:	c5 00 83             	(bad)  
   d:	05 c5 00 83 05       	add    $0x58300c5,%eax
  12:	01                   	.byte 0x1
  13:	b8                   	.byte 0xb8
  14:	44 f4                	rex.R hlt 
[   31.044796][  T210] EAX: 00000044 EBX: e6d0e564 ECX: 00000000 EDX: 00000001
[   31.046040][  T210] ESI: ee7f4360 EDI: ee7f4328 EBP: ca1b795c ESP: ca1b7950
[   31.047314][  T210] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
[   31.048702][  T210] CR0: 80050033 CR2: 005d5dbc CR3: 0a287000 CR4: 000406d0
[   31.049987][  T210] Call Trace:
[ 31.050583][ T210] __rmqueue_pcplist (include/linux/list.h:132 include/linux/list.h:146 mm/page_alloc.c:3644) 
[ 31.051469][ T210] rmqueue_pcplist+0x13c/0x3a0 
[ 31.052536][ T210] ? rmqueue_pcplist+0x4b/0x3a0 
[ 31.053479][ T210] rmqueue+0x323/0xd20 
[ 31.054230][ T210] get_page_from_freelist (mm/page_alloc.c:4162) 
[ 31.055219][ T210] __alloc_pages (mm/page_alloc.c:5374) 
[ 31.055998][ T210] allocate_slab (include/linux/gfp.h:558 include/linux/gfp.h:572 include/linux/gfp.h:585 mm/slub.c:1702 mm/slub.c:1842) 
[ 31.056834][ T210] new_slab (mm/slub.c:1907) 
[ 31.057538][ T210] new_slab_objects (mm/slub.c:2652) 
[ 31.058396][ T210] ___slab_alloc+0xf8/0x520 
[ 31.059340][ T210] ? lock_release (kernel/locking/lockdep.c:5534) 
[ 31.060073][ T210] ? __d_alloc (fs/dcache.c:1745) 
[ 31.060817][ T210] ? rcu_read_unlock (include/linux/rcupdate.h:272 (discriminator 7) include/linux/rcupdate.h:711 (discriminator 7)) 
[ 31.061621][ T210] ? get_obj_cgroup_from_current (mm/memcontrol.c:2931) 
[ 31.062657][ T210] __slab_alloc+0x9b/0x100 
[ 31.063622][ T210] ? __d_alloc (fs/dcache.c:1745) 
[ 31.064402][ T210] kmem_cache_alloc (mm/slub.c:2936 mm/slub.c:2978 mm/slub.c:2983) 
[ 31.065230][ T210] ? __d_alloc (fs/dcache.c:1745) 
[ 31.065990][ T210] __d_alloc (fs/dcache.c:1745) 
[ 31.066733][ T210] d_alloc (fs/dcache.c:1824) 
[ 31.067415][ T210] d_alloc_parallel (fs/dcache.c:2575) 
[ 31.068288][ T210] ? __init_waitqueue_head (kernel/sched/wait.c:13) 
[ 31.069218][ T210] __lookup_slow (fs/namei.c:1615) 
[ 31.070026][ T210] lookup_slow (fs/namei.c:1646) 
[ 31.070786][ T210] walk_component (fs/namei.c:1942) 
[ 31.071614][ T210] ? inode_permission (fs/namei.c:522) 
[ 31.072484][ T210] link_path_walk (fs/namei.c:2269) 
[ 31.073324][ T210] path_openat (fs/namei.c:3490 (discriminator 2)) 
[ 31.074100][ T210] ? __lock_acquired (kernel/locking/lockdep.c:5723) 
[ 31.074949][ T210] do_filp_open (fs/namei.c:3521) 
[ 31.075754][ T210] do_sys_openat2 (fs/open.c:1188) 
[ 31.076615][ T210] do_sys_open (fs/open.c:1203) 
[ 31.077356][ T210] __ia32_sys_openat (fs/open.c:1214) 
[ 31.078206][ T210] __do_fast_syscall_32 (arch/x86/entry/common.c:78 arch/x86/entry/common.c:143) 
[ 31.079126][ T210] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4109 kernel/locking/lockdep.c:4169) 
[ 31.080178][ T210] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:50 (discriminator 19)) 
[ 31.081085][ T210] ? __call_rcu (kernel/rcu/tree.c:3072 (discriminator 1)) 
[ 31.081899][ T210] ? __fput (fs/file_table.c:58 fs/file_table.c:298) 
[ 31.082630][ T210] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4109 kernel/locking/lockdep.c:4169) 
[ 31.083685][ T210] ? syscall_exit_to_user_mode (kernel/entry/common.c:132 kernel/entry/common.c:304) 
[ 31.084726][ T210] ? __do_fast_syscall_32 (arch/x86/entry/common.c:147) 
[ 31.085681][ T210] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4109 kernel/locking/lockdep.c:4169) 
[ 31.086738][ T210] ? irqentry_exit_to_user_mode (kernel/entry/common.c:132 kernel/entry/common.c:317) 
[ 31.087741][ T210] do_fast_syscall_32 (arch/x86/entry/common.c:168) 
[ 31.088627][ T210] do_SYSENTER_32 (arch/x86/entry/common.c:211) 
[ 31.089427][ T210] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:872) 
[   31.090288][  T210] EIP: 0xb7f04549
[ 31.090926][ T210] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter 
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq   
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	retq   
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76


To reproduce:

        # build kernel
	cd linux
	cp config-5.13.0-00219-g7118fc2906e2 .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--SFb6pxBV9AuABc6g
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-5.13.0-00219-g7118fc2906e2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.13.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_QUARK=y
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_NON_STANDARD=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_STA2X11=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
# CONFIG_CPU_SUP_UMC_32 is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_16BIT is not set
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# end of Processor type and features

CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
CONFIG_CXL_MEM=y
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
CONFIG_I82092=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y
CONFIG_FTL=y
# CONFIG_NFTL is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
CONFIG_MTD_ESB2ROM=y
CONFIG_MTD_CK804XROM=y
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=y
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
CONFIG_MTD_SPI_NAND=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_MTD_HYPERBUS=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=y
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=y
# CONFIG_VMWARE_VMCI is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
CONFIG_PVPANIC_PCI=y
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_HPSA=y
CONFIG_SCSI_3W_9XXX=y
CONFIG_SCSI_3W_SAS=y
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=y
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=y
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
CONFIG_SCSI_ESAS2R=y
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=y
CONFIG_MEGARAID_LEGACY=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
CONFIG_SCSI_SMARTPQI=y
# CONFIG_SCSI_UFSHCD is not set
CONFIG_SCSI_HPTIOP=y
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_MYRB=y
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=y
CONFIG_SCSI_SNIC=y
CONFIG_SCSI_SNIC_DEBUG_FS=y
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
CONFIG_SCSI_ISCI=y
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=y
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=y
# CONFIG_SCSI_IZIP_EPP16 is not set
CONFIG_SCSI_IZIP_SLOW_CTR=y
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_DC395x=y
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_NSP32=y
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_CEVA=y
# CONFIG_AHCI_QORIQ is not set
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set
# CONFIG_WWAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_AD7877=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_AD7879_SPI=y
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DA9052=y
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
# CONFIG_TOUCHSCREEN_MC13783 is not set
# CONFIG_TOUCHSCREEN_USB_EGALAX is not set
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
# CONFIG_TOUCHSCREEN_USB_ITM is not set
# CONFIG_TOUCHSCREEN_USB_ETURBO is not set
# CONFIG_TOUCHSCREEN_USB_GUNZE is not set
# CONFIG_TOUCHSCREEN_USB_DMC_TSC10 is not set
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
# CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
# CONFIG_TOUCHSCREEN_USB_GOTOP is not set
CONFIG_TOUCHSCREEN_USB_JASTEC=y
# CONFIG_TOUCHSCREEN_USB_ELO is not set
# CONFIG_TOUCHSCREEN_USB_E2I is not set
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=y
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_CS=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
CONFIG_SYNCLINK_GT=y
CONFIG_N_HDLC=y
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
# CONFIG_HW_RANDOM_GEODE is not set
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_CCTRNG is not set
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_APPLICOM=y
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_NVIDIA_GPU=y
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_CP2615=y
CONFIG_I2C_PARPORT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_ALTERA_DFL=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_FSI=y
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=y
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
CONFIG_SPI_TOPCLIFF_PCH=y
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
# CONFIG_PPS is not set

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AS3722 is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SINGLE is not set
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_PALMAS=y
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L92=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_STA2X11 is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_OLPC is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
# CONFIG_RN5T618_POWER is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_DA9055=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NZXT_KRAKEN2=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
# CONFIG_SENSORS_BPA_RS600 is not set
CONFIG_SENSORS_FSP_3Y=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR36021=y
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE122=y
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CPU_THERMAL=y
# CONFIG_CPU_FREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_MAX77620_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set
CONFIG_INTEL_QUARK_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_STA2X11=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD70528 is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STPMIC1=y
# CONFIG_MFD_STMFX is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_ATC260X=y
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STPMIC1=y
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_SANYO_DECODER=y
CONFIG_IR_SHARP_DECODER=y
# CONFIG_IR_MCE_KBD_DECODER is not set
CONFIG_IR_XMP_DECODER=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_RCMM_DECODER=y
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=y
# CONFIG_IR_ENE is not set
# CONFIG_IR_HIX5HD2 is not set
CONFIG_IR_IMON=y
CONFIG_IR_IMON_RAW=y
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SPI=y
CONFIG_IR_STREAMZAP=y
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=y
CONFIG_IR_TTUSBIR=y
CONFIG_RC_LOOPBACK=y
CONFIG_IR_GPIO_CIR=y
CONFIG_IR_GPIO_TX=y
# CONFIG_IR_PWM_TX is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_IR_TOY=y
CONFIG_CEC_CORE=y
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_USB_PULSE8_CEC=y
CONFIG_USB_RAINSHADOW_CEC=y
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_RCAR_DW_HDMI=y
# CONFIG_DRM_RCAR_LVDS is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
CONFIG_DRM_PANEL_DSI_CM=y
CONFIG_DRM_PANEL_LVDS=y
# CONFIG_DRM_PANEL_SIMPLE is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
CONFIG_DRM_PANEL_LG_LB035Q02=y
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
CONFIG_DRM_PANEL_NOVATEK_NT35510=y
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
CONFIG_DRM_PANEL_NOVATEK_NT39016=y
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=y
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_SONY_ACX424AKP is not set
# CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
CONFIG_DRM_PANEL_TDO_TL070WSH30=y
CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_CHIPONE_ICN6211=y
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_DISPLAY_CONNECTOR=y
CONFIG_DRM_LONTIUM_LT8912B=y
CONFIG_DRM_LONTIUM_LT9611=y
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
CONFIG_DRM_LVDS_CODEC=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=y
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=y
CONFIG_DRM_SIL_SII8620=y
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=y
CONFIG_DRM_SIMPLE_BRIDGE=y
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358762=y
# CONFIG_DRM_TOSHIBA_TC358764 is not set
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TOSHIBA_TC358775 is not set
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_DRM_CDNS_MHDP8546=y
CONFIG_DRM_DW_HDMI=y
# CONFIG_DRM_DW_HDMI_CEC is not set
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=y
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
CONFIG_TINYDRM_REPAPER=y
# CONFIG_TINYDRM_ST7586 is not set
CONFIG_TINYDRM_ST7735R=y
CONFIG_DRM_VBOXVIDEO=y
CONFIG_DRM_GUD=y
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_R128 is not set
CONFIG_DRM_MGA=y
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_LP8788 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_COUGAR=y
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CREATIVE_SB0540=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_FT260 is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LCD=y
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SEMITEK=y
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_U2FZERO=y
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_PCI is not set
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_SL811_CS=y
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_ULPI is not set
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC3_OF_SIMPLE is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PERIPHERAL=y
# CONFIG_USB_DWC2_DUAL_ROLE is not set
CONFIG_USB_DWC2_PCI=y
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=y
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=y
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
CONFIG_USB_SERIAL_CP210X=y
CONFIG_USB_SERIAL_CYPRESS_M8=y
CONFIG_USB_SERIAL_EMPEG=y
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
CONFIG_USB_SERIAL_IR=y
CONFIG_USB_SERIAL_EDGEPORT=y
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
CONFIG_USB_SERIAL_F81232=y
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=y
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=y
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=y
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
CONFIG_USB_SERIAL_QCAUX=y
# CONFIG_USB_SERIAL_QUALCOMM is not set
CONFIG_USB_SERIAL_SPCP8X5=y
CONFIG_USB_SERIAL_SAFE=y
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=y
# CONFIG_USB_SERIAL_OPTION is not set
CONFIG_USB_SERIAL_OMNINET=y
CONFIG_USB_SERIAL_OPTICON=y
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=y
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_MAX3420_UDC=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_MASS_STORAGE=y
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
# CONFIG_USB_CONFIGFS is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
CONFIG_USB_G_SERIAL=y
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_G_ACM_MS=y
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=y
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AN30259A=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
CONFIG_LEDS_CR0014114=y
CONFIG_LEDS_EL15203000=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77693=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_SPI_BYTE=y
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_TPS6105X=y
# CONFIG_LEDS_SGM3140 is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_RT4505=y
CONFIG_LEDS_RT8515=y

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=y
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=y
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
# CONFIG_UIO is not set
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_SSV_DNP=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=y
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=y
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=y
# CONFIG_COMEDI_DT2811 is not set
CONFIG_COMEDI_DT2814=y
# CONFIG_COMEDI_DT2815 is not set
# CONFIG_COMEDI_DT2817 is not set
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=y
# CONFIG_COMEDI_II_PCI20KC is not set
# CONFIG_COMEDI_C6XDIGIO is not set
# CONFIG_COMEDI_MPC624 is not set
# CONFIG_COMEDI_ADQ12B is not set
# CONFIG_COMEDI_NI_AT_A2150 is not set
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
# CONFIG_COMEDI_NI_ATMIO16D is not set
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_PCI_DRIVERS=y
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=y
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
# CONFIG_COMEDI_ADDI_APCI_2032 is not set
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
# CONFIG_COMEDI_ADDI_APCI_3501 is not set
CONFIG_COMEDI_ADDI_APCI_3XXX=y
CONFIG_COMEDI_ADL_PCI6208=y
# CONFIG_COMEDI_ADL_PCI7X3X is not set
CONFIG_COMEDI_ADL_PCI8164=y
CONFIG_COMEDI_ADL_PCI9111=y
CONFIG_COMEDI_ADL_PCI9118=y
CONFIG_COMEDI_ADV_PCI1710=y
# CONFIG_COMEDI_ADV_PCI1720 is not set
CONFIG_COMEDI_ADV_PCI1723=y
CONFIG_COMEDI_ADV_PCI1724=y
CONFIG_COMEDI_ADV_PCI1760=y
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
CONFIG_COMEDI_AMPLC_PC236_PCI=y
CONFIG_COMEDI_AMPLC_PC263_PCI=y
CONFIG_COMEDI_AMPLC_PCI224=y
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=y
CONFIG_COMEDI_DAS08_PCI=y
# CONFIG_COMEDI_DT3000 is not set
CONFIG_COMEDI_DYNA_PCI10XX=y
CONFIG_COMEDI_GSC_HPDI=y
# CONFIG_COMEDI_MF6X4 is not set
CONFIG_COMEDI_ICP_MULTI=y
CONFIG_COMEDI_DAQBOARD2000=y
# CONFIG_COMEDI_JR3_PCI is not set
CONFIG_COMEDI_KE_COUNTER=y
CONFIG_COMEDI_CB_PCIDAS64=y
CONFIG_COMEDI_CB_PCIDAS=y
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
CONFIG_COMEDI_CB_PCIMDDA=y
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=y
CONFIG_COMEDI_NI_6527=y
# CONFIG_COMEDI_NI_65XX is not set
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
# CONFIG_COMEDI_NI_LABPC_PCI is not set
CONFIG_COMEDI_NI_PCIDIO=y
CONFIG_COMEDI_NI_PCIMIO=y
CONFIG_COMEDI_RTD520=y
CONFIG_COMEDI_S626=y
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
CONFIG_COMEDI_PCMCIA_DRIVERS=y
CONFIG_COMEDI_CB_DAS16_CS=y
CONFIG_COMEDI_DAS08_CS=y
CONFIG_COMEDI_NI_DAQ_700_CS=y
CONFIG_COMEDI_NI_DAQ_DIO24_CS=y
CONFIG_COMEDI_NI_LABPC_CS=y
CONFIG_COMEDI_NI_MIO_CS=y
CONFIG_COMEDI_QUATECH_DAQP_CS=y
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
CONFIG_COMEDI_NI_USB6501=y
CONFIG_COMEDI_USBDUX=y
# CONFIG_COMEDI_USBDUXFAST is not set
# CONFIG_COMEDI_USBDUXSIGMA is not set
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_DCDBAS=y
CONFIG_DELL_RBU=y
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_SMO8800=m
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
CONFIG_IBM_RTL=y
CONFIG_SENSORS_HDAPS=y
# CONFIG_THINKPAD_ACPI is not set
CONFIG_INTEL_ATOMISP2_LED=y
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_XO15_EBOOK is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IMR=y
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_VC5=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
CONFIG_LITEX_SUBREG_SIZE=4
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=y
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_IDT=y
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_TWL is not set
# CONFIG_PWM_TWL_LED is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=y
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
# CONFIG_IDLE_INJECT is not set
CONFIG_DTPM=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
CONFIG_NVMEM_RMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_ICE40_SPI=y
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=y
# CONFIG_FPGA_DFL_FME is not set
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
CONFIG_FPGA_DFL_PCI=y
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
# CONFIG_FSI_MASTER_ASPEED is not set
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
# CONFIG_FSI_OCC is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_INTERRUPT_CNT=y
# CONFIG_FTM_QUADDEC is not set
CONFIG_MICROCHIP_TCB_CAPTURE=y
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
# CONFIG_UBIFS_FS_XATTR is not set
CONFIG_UBIFS_FS_AUTHENTICATION=y
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
CONFIG_ROMFS_BACKED_BY_MTD=y
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_MTD=y
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
# CONFIG_SECURITY_LOADPIN_ENFORCE is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=y

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_ZEROSIZE_PERCPU_SUPPORT=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_FRAME_POINTER=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_DEBUG_IMR_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--SFb6pxBV9AuABc6g
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys=
	export queue='int'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linus/master'
	export commit='7118fc2906e2925d7edb5ed9c8a57f2a5f23b849'
	export kconfig='i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON'
	export nr_vm=300
	export submit_id='63c4e00f0b9a935f0309c4cf'
	export job_file='/lkp/jobs/scheduled/vm-meta-67/boot-1-debian-11.1-i386-20220923.cgz-7118fc2906e2925d7edb5ed9c8a57f2a5f23b849-20230116-89859-jpsdaj-608.yaml'
	export id='0556c96c4e8b541a206a80fa7650f86c15787087'
	export queuer_version='/lkp/xsang/.src-20230115-214159'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='gcc-11'
	export enqueue_time='2023-01-16 13:26:39 +0800'
	export _id='63c4e01c0b9a935f0309c72f'
	export _rt='/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/gcc-11/7118fc2906e2925d7edb5ed9c8a57f2a5f23b849'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/gcc-11/7118fc2906e2925d7edb5ed9c8a57f2a5f23b849/474'
	export scheduler_version='/lkp/lkp/.src-20230111-092854'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/gcc-11/7118fc2906e2925d7edb5ed9c8a57f2a5f23b849/474
BOOT_IMAGE=/pkg/linux/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/gcc-11/7118fc2906e2925d7edb5ed9c8a57f2a5f23b849/vmlinuz-5.13.0-00219-g7118fc2906e2
branch=linus/master
job=/lkp/jobs/scheduled/vm-meta-67/boot-1-debian-11.1-i386-20220923.cgz-7118fc2906e2925d7edb5ed9c8a57f2a5f23b849-20230116-89859-jpsdaj-608.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON
commit=7118fc2906e2925d7edb5ed9c8a57f2a5f23b849
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
mem=4G
nmi_watchdog=0
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/gcc-11/7118fc2906e2925d7edb5ed9c8a57f2a5f23b849/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-67'
	export kernel='/pkg/linux/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT+CONFIG_SLUB_DEBUG_ON/gcc-11/7118fc2906e2925d7edb5ed9c8a57f2a5f23b849/vmlinuz-5.13.0-00219-g7118fc2906e2'
	export dequeue_time='2023-01-16 13:32:22 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-67/boot-1-debian-11.1-i386-20220923.cgz-7118fc2906e2925d7edb5ed9c8a57f2a5f23b849-20230116-89859-jpsdaj-608.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--SFb6pxBV9AuABc6g
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
Z/sCAAAAAARZWg==

--SFb6pxBV9AuABc6g--
