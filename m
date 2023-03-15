Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC86BBCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjCOSsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjCOSr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:47:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1611E87
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678906066; x=1710442066;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7N6K1BE/aYDP6Wwng82X4zRCZD41QzI8avZSR8hCYEA=;
  b=Kp9goCs88VEJR/Axy/WqJLvW+uYzIIb7OnMFNtJRDs6bJkmDwkiTTLgs
   +XmYW0ZkI4XPzME7kTGHP1h1Z0UWXgR4hMKNTO7urylp+fhhjIkoMiaoQ
   pFAAswSLsZU/2yZ9yPUNT2ncDOId8Pav8+5+6q9xlCC8wL9Bi72Y1SRcZ
   IKrLk4jcc88Eba4/sHcpl56y/nrAjMwu+25UP04cvncxHqQoOCARJxsok
   SsH3N8eBT14yGkO384+hn56fq0/MIaDDbvVn89JWoJpDaC+W7ZHRjJVBx
   cOYLo2euguwKtkNvI5WgIfi+O5M9ik4PSIU1dv08rNeYdK7MnCwP2Wgbo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="326153906"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="326153906"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="822907401"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="822907401"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2023 11:47:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:47:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:47:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 11:47:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 11:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sv9EE7aG65btKLUv08uor2Qpia4LNCukWBFSheEoifh2GjNPDTKPV4pN3SZIEGwfAv/MOcd/DIqT9e/ZZVJAMgGWKFxI5HYbEQrIbEgQ54+qwhyYo06zYi0G1Wl0Exmo1QmYc8k2mvmDkdICOUeQdjO99T/fHi5rN/OqFmnn/dCbdWyWrigz8zl+Es5LirwyrQ4kt9RyDZsEDum2yzUhGtPXwxCzFTwpY7ZQHi/T2/Dbm+PhEZ3boGk8NkUcvhQk6vYlDY8QuVk7uwsIDSpLbCYfNT1lyMUn5inPpG6MAVhE8djKy3JwFrEJ1fcjPWUTuMFpmENWuhti5N3Ttg9THw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urXr/zAGoCUWX6/MMg5HBZmE2XlJ16qvQIooeD4JCV8=;
 b=FZk4aztQduwF2g4yx7kk980tQPUEuXnADGTehPhR2UOhJWFB58uqKpH0uh7iIoRhKniFY0G+Ruley4HK7Rl8AVT5HY+w8fS5cRsquzsscmTzgQJ01nvkRw1DAGwcHK6nXDLhwoexz8cwmI0H8M4D+3TKYUs7qfNkhLwCbXosn3fbeeDx+E9QfmwI+ESO4yINXcHvwv/MciMGY7aLsXHdRueoN6NAcY5YGmEua8WjOUzSVIDEfQ6KcGm18u5jjYcp17UbHhxEl2Wpsg9x2zCinbrqtOpI7liR1iVrWzBDIFLvLCwPqZj+CMpmyPMpVfIx0c/GzQpufxI46PWEoGXXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5511.namprd11.prod.outlook.com (2603:10b6:208:317::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 18:47:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 18:47:40 +0000
Date:   Wed, 15 Mar 2023 11:47:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        <gregkh@linuxfoundation.org>
CC:     <outreachy@lists.linux.dev>, <martyn@welchs.me.uk>,
        <manohar.vanga@gmail.com>, <zoo868e@gmail.com>,
        <jerrykang026@gmail.com>, <cuigaosheng1@huawei.com>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>, <eng.mennamahmoud.mm@gmail.com>
Subject: Re: [PATCH 1/2] staging: vme_user: add space around operators
Message-ID: <641212c8d481f_253a1e29437@iweiny-mobl.notmuch>
References: <b56c7b94e59a4051373af8b5d90a0685dfc9233a.1678882204.git.eng.mennamahmoud.mm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b56c7b94e59a4051373af8b5d90a0685dfc9233a.1678882204.git.eng.mennamahmoud.mm@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: f19267d6-cada-4075-d2b6-08db2585c0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HP8Jp9IVKYrHT3JlhT6AQi9DA7oT7Ntawd1OVchMRqnr8FJymGVVTOi1CrGCIRolbyyZpGOZ/9AigsdOB5y3v+uM+ksZVkOK2/OAJF9tiP1SvRX1jsw/2cYpw0wQ0Q2pekUNRQjJE1tTpdM28BFoE9ENfex5Prg/2MqhlOk7IRtGsrrm94DsIYS9z4TJe98Z4jIiJYyg6ke0S4V5dlxgRKX+PKMKzp48oxOiohunLnrGb8r/5J8XOKtg1a1JR/p3Iis9HQhdir4Zic/qzkKDKevnw7LDed8iyO4J+J20SDAxub+pDgjtMyH1xf6r3cQe3Tka6HSTpNtVw63VDjsNoTJJm5PSrwYLvLqyKkq4DGxh0eAPt2+mWyq09o+6NCFrNPuPILFgiGbNbBry8vfbZZ6WMOh7/fZVARj77ICHS9pZ6RPs2QRzUTD20N9dyQmlU/ua1h3CWLo+TNsk9GfNw8J3MFk4yNtlvgeq1yN5rlA6obNHOoyOXpNMk8xTCtXo9YqSB/dN42uZwNocjSvrJrEhCfuIRQRDgxPmngsdI4WpF74bl49XCVGmyuY+tt0nh8f56fPKuRgTwrqvlVEOAbTOce3cbq2OJ8flLxJnsiN4j6wcTvHpXJO8NEYY1nxG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199018)(86362001)(966005)(41300700001)(8676002)(66476007)(66556008)(6486002)(66946007)(8936002)(83380400001)(44832011)(5660300002)(9686003)(26005)(7416002)(186003)(6506007)(6512007)(6666004)(478600001)(316002)(4326008)(2906002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5udeOK1KMyNwrTLKmACtjRPyNUTTfAJc2Q5M3+a5aNW41ar9IQ0EF29jQOOm?=
 =?us-ascii?Q?hjc9w1iEAwsIqCxtjinkMGr9C5xPV5quAam3fuZwlOCag+LmFBDeFUDRINbM?=
 =?us-ascii?Q?F8u19k3fXUDkyHmEzdNX/j5Nr0wahsAT1pez60Rnlxn7YGVjoS3DhTfVYMN6?=
 =?us-ascii?Q?3re4Hn2eYauUNS0LidxW6ABJvz6WcUmbHZJOqw0HxeUZw2pvSmLL+4MT+JPB?=
 =?us-ascii?Q?UKxTXs+RDtWn5jJCQK0bXiYQYMMxqx/elIfWm/Ytln5lBJyqYNH1/mvNp4/G?=
 =?us-ascii?Q?94K56M7jVyMngRgTfzDrCDXDB9RHBtVwbAAzXbD9YswIHsQnPM0BXIfSuJmk?=
 =?us-ascii?Q?oyE1V45yS4FUqxhMLKONNueviNVryk1sR3TDMNnf2slfl7vbGoOzb1y9DCDV?=
 =?us-ascii?Q?XEPaj2oDyHSZP0wraJrW+M5oKHXtSjcfZYLje5OsTawpH9IJNMG4ecBm1asg?=
 =?us-ascii?Q?K7t0WsHA7V6hE6wcMNvM9Rd7a9uSs7T+oroWeN61y7aQbkiA3mgPu/29V7W+?=
 =?us-ascii?Q?qgX38dxJPe3JcQ3DKrCGMbJJyRoTHOrzuw1Ehipiio0M65NG3PcnK3c7jtD+?=
 =?us-ascii?Q?n/aLdPt9S//A+7xWD1Eqt0LKHtIOVGQgLeFTeW+1AmLH3m5umcteEOAPxHAU?=
 =?us-ascii?Q?l3d7w4YRkVHXhJemZKJ3TtrVD1LHv/BmKKxL91YRHbULMdx/6OiAzozwX0L3?=
 =?us-ascii?Q?LMKPhELo5/NXIyQuImNsPiJJtQbffLi6k6jzPOj6ePh3KZ1deoWb/X/A8ayt?=
 =?us-ascii?Q?HpZND0+HP76TGKNsqeE7ISShDaYLFnXUzg3WvU3/1ljeQoFEQANrf1QbbaPd?=
 =?us-ascii?Q?L6IN5UBdA9IlWeCdqLvzH25ie+Aw2A8ufN/JaoEm2BfQS11hJfhKcXZUXrbG?=
 =?us-ascii?Q?VS73MyhPVMtxfBmAqYPuJ/Rfz5wWR9KFM0hdK11v1+ubEDF8OvfEDbz1s5nn?=
 =?us-ascii?Q?3DsLZzljUfSKD8Ij9flVHjHEnWmpCn1GARKq7VNXfr1tezW+zg5kPBPVMgSg?=
 =?us-ascii?Q?0itDN2GF8imsDvymM4+T2KtqitVWs//ZxYpC2guukA4QcOvBZP9ZPSik49cX?=
 =?us-ascii?Q?2wVpq7VyEJepLwukxRWpSuU0GGw1Stc5kaBXYsNbzcAnD/+xoke5j62oqLLN?=
 =?us-ascii?Q?LbQ1M/H6WjLqiAZTEVEJUBKSUMxx5mWHDocLccKaCMJebbSdMdg7gQ33MEjk?=
 =?us-ascii?Q?zyhn26k/g3NZ8zzvkKlef/JnLmEMoGc/k8CDCYo/39bB8oS+N2lehWeJYaLj?=
 =?us-ascii?Q?wF29hBb76KiucMMqzKsHPzQiZ/JNDkTVI3pW+QmJYE6nu6Hnnn3iPwjpJ/dK?=
 =?us-ascii?Q?MglrocJEYsbq/FhMYWa4cuRsO1zIcZm8qIj/lVGOHli0FcMWZ/LGuQvO8Rfy?=
 =?us-ascii?Q?JaNBZSS/+cWqG+CtLZbdnP/VFOBvHBDK5F1p4vmL3mknCGgbVN7CbiFiLss8?=
 =?us-ascii?Q?IIaft7ow9xtHqiJe0dbBSa+weI/1v8SZ2TOJX5kYNMOhNnO5StzM0FdVweNw?=
 =?us-ascii?Q?eiTLi+5hUkcXgQlz9J2L5nQ3XKSyufLFXHv6i8+oLoE6BYdr0hDPcqCGd+tY?=
 =?us-ascii?Q?6aPMLOh32DGh6eXThEhp8a0dWT+H2AlY8z0suFeL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f19267d6-cada-4075-d2b6-08db2585c0b4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:47:39.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKX6z3lX9M4ccEEV9KHwUFo+M4rI52uTghEwvUOnl4ie+u7LwE4TPbGU8c2esR5yIrZCUGRlqLEtcfEIuHptCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Menna Mahmoud wrote:
> add a space before and after the operator, for readability.
> 
> Reported By checkpatch script:
> 
> CHECK: spaces preferred around that '+' (ctx:VxV)
> +		image->bus_resource.name = kmalloc(VMENAMSIZ+3, GFP_ATOMIC);
>  		                                            ^
> CHECK: spaces preferred around that '<<' (ctx:VxV)
> +	temp_ctl &= ~(3<<4);
>  	               ^
> CHECK: spaces preferred around that '>>' (ctx:VxV)
> +	cbar = (cbar & TSI148_CRCSR_CBAR_M)>>3;
>  	                                   ^
> CHECK: spaces preferred around that '<<' (ctx:VxV)
> +		iowrite32be(cbar<<3, bridge->base + TSI148_CBAR);

Similar comment to what Fabio made.

But I'll add some formatting comments.

It looks like you have submitted a 2 patch series which fixes all the
checkpatch errors in the vme_user driver?

Kudos for separating out the 2 patches for the 2 different types of
checkpatch errors!  And for submitting a series which fixes the entire
driver!

But you should also include a cover letter for your series.

How are you creating this series?  Are you using 'git format-patch'?
'b4'?  If not using 'b4' I strongly recommend it.[*]

Both of those tools can help with formatting a cover letter and b4 will
help keep track of multiple versions of the series as you fix things.

Ira

[*] https://git.kernel.org/pub/scm/utils/b4/b4.git
