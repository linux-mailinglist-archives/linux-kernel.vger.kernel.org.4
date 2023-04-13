Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A008E6E101C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDMOiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDMOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:37:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8227D9C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681396677; x=1712932677;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PY5LBNSM8lGAxSY/bZ3rY1rCUrjUlw4iG15RB8TJQc8=;
  b=Ccp7IF6Zbu2XiTH4nd27bfEqw3obNM6roYd4Ehdd/GH8PDL3g7+X5mia
   RQaKXp703l9AbfinpN6H1xZoFy+b6sc81Mxxd3cwBWCVvG9MgEhk27X/5
   RB5h7TgoDwYAa8WXYfpvoeaVr+wirJDPuDjLA25Ibodm7LO6P1QC3PRoC
   b2CBr2ZNXuKoLxgPeC+aa91AQb/CXIX9RPYFJQftSM+HSqkCFEDXR8ahY
   OeBziSa1lqqpW0bih1TV3MdOiHckYNYV5+mBDmGmAFWviokv1wgr08uWg
   m1TDGwZktfT1DpQig+d78vBVycfd1it9FPrjE0HcFYlhzF5sv3np8ZFjR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="341694071"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="341694071"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 07:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="813462944"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="813462944"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2023 07:37:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 07:37:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 07:37:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 07:37:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 07:37:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt9XrXdVMwuLjy2beT0Cr11oLovFFwqkKEJtl2fJTlJkVSbcVNWRtF9fqfHhIO9kNeiPQD+7PQU3hl7yFAUQNHFcjvdqF9Rczkg7Q3gw7roIEgJqS9qCb6B8ZdvMOIdZw9q5AQw5lO14Is65DjR8J8nAknY/ietm0iF6h/7F+/nQ8IOeuMT39sxQYDgcbljrSo8gMhDrycqwik0YH5TtKh8zaekSO4IwT7b3Ia2MR+yqZhrvYFT1BptyeNA7qm8QangvtmoAB6hjO9ctlZq6oVOuoIp8hYgA0EgpV/b1AIf2k/3Dmh12osHNERkeKkclkLEDdwp4idvouyjetnDFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt7lU9AW7w4Z9h5c/rlVr1Az7QTgbSKKSI7HweV0m2g=;
 b=K3CtO6wcOU1qaf4uQq02O5+XfFTGAo+zh5HNxcaTQfNHQaXFGqaISRmCr7RulEne7mdBlkmfdgjmuIxajAy8yn1c4+4wDhO+MRX1lfLsurjr6As9g8uNxl4PAjDWMJWV0w5lU7R6JScSeZ/XwysOyUZpBWsuxU6QhQB652lXm9l5DVQt/jtZjA5Br0Q/xc8Wm6ef5hJAB+7blbsWJ+uzyxhwcGgZiP76p0QXzM3/3vWxBFVTpUFk1mtRQHB/3FSWqHLnbmOWXDgKcvvJ5P4t/A+b3dh0/ATsbvDYreIgJXMCLeDtUAhwukDQRqCo83/amZY97OIz41r4LmSMhuBzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH7PR11MB6355.namprd11.prod.outlook.com (2603:10b6:510:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 14:37:55 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 14:37:55 +0000
Date:   Thu, 13 Apr 2023 22:37:44 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v5] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230413143744.GA221757@ziqianlu-desk2>
References: <20230413140248.230479-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230413140248.230479-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH7PR11MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf22aef-faa5-433e-38fc-08db3c2caab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9WAh8mU0TK2ZPe82kh20rYjr6BD+qyaFiht6QDKserg44k5d0eud5Em+AihXpBsWOVo0fqpVPLo+A7OCrhsnbQMmCMwCv8oQdnNgNuq47O7aNAdJa2xsRJhQ1nHcchoObvweGTBnpxKGppKGrRwzf21MAD2MCxtHqIMWLf+rM4wRCV3TsrFlz3U44CTlMrDejrWgSgQBrH9kMYex1En9jREwAEHON2cLwbArsVsqZeD1NSr/3dXRnvOwMCkRAh34yf5RATBAzISSa+M0rGr48YRKblf+zokmqMrDTnUxSu03FAxdAgTqjrTRtUTkbk1arEVHmxDeNvP003FbgSCo05+yMNVG/7yKWx8xNZsy7c5sHxiwrcJ4c7CGpfW3eK9gL6bATZBeXdCP8UQ0wZ/N+VJ9qrzp9Tp9E8YtsuduIYoEjqtyX0xdW097tlg0LrCxqRlIoNd84p+fPxQzQslZKxiatTJIqwbF+tlF2o3heMM+hFdreNCtfbyoibOcWdbiTfmY6EV6IVGCS7D3UZKG86zQuyW9s1kBZC1vSCQ43ysUZZcI4bFnPep1JejwP7a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(6666004)(6486002)(6916009)(66476007)(66556008)(66946007)(4326008)(4744005)(2906002)(44832011)(33716001)(86362001)(41300700001)(82960400001)(33656002)(5660300002)(8676002)(8936002)(316002)(38100700002)(478600001)(54906003)(9686003)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bjnMpmLVJArWi9QeiQ/xzfOfysiSXeEOyUhxt6SXzqLUc/XPs0jFZzvPzQD2?=
 =?us-ascii?Q?RSbCtEjNqdDLX5pq8+zMOptgIeG7hwYRQQfdQkHhSnoT0aOdBxLsSxOcTEyB?=
 =?us-ascii?Q?l07G/zL2mxvEVb+xzB6JjfChhWwmitxGtwUOBw5ps7h12kbpWTDGxwFIvYyJ?=
 =?us-ascii?Q?Cbehf0PFlUGxGBZPJHnbqkj0FsUHx6nAacgTPq9aR7Kmv99AXu5Bso1O8jhj?=
 =?us-ascii?Q?cqg2MFOt2pGu0ONOYCAWGU5s2L//Urd//zCcsA1oh0vbEnFrHU+edin4IB7A?=
 =?us-ascii?Q?L7qaT78T9N2RcnR6LZxQQJkPwdG1xD6HfF7GpCDxa9lYJuQAsX2Gg1hkWzY6?=
 =?us-ascii?Q?uoo1+KYhZ2GJ/OL/bmqt6tGR2tn/HaTZ77+ObY924KEKBSW7PNT06COUxn0A?=
 =?us-ascii?Q?kNSHpbgtPXNkDdTjLeRTvkOONhl/Bq0xruJdyxgvEPqF/N6Rkx3nErhjuFcZ?=
 =?us-ascii?Q?AitFz8t4A1wSHhVjRCzJ3AmyibklKfqKSo1UtU9ZuSwDLRRApbLo4OkwVmAJ?=
 =?us-ascii?Q?eg5ihBlulJEBkvLCgFgTb2IOvhXfAJj7Ef7IQJxbZcwoyz8XHkuvj0nOyPXg?=
 =?us-ascii?Q?MmC/5BscEw/DOc0d6dax3/7C+/9J4QcibtXeu6fTb1i5FQW5Gf9W4z71jG2R?=
 =?us-ascii?Q?nP/wUCEIG9aJmlrIzNi1dMsG6XUf++c3GDhR1pcyjolDS+4+5thRWdp67jg2?=
 =?us-ascii?Q?bqOQd+sfR2Kfx5SAtmpqWL4WK2X6ju5KtjMY4s5XOdkZtnh6BB6OwfJ6xMmP?=
 =?us-ascii?Q?qQbaeEq9t48C1pIxCLCQj//hHsIuAilCSndDDuNhvLyCydQfWGVlFJtEUQS8?=
 =?us-ascii?Q?VTZDlo2YyFN0IHTU7x/DGqIf7aMtIaiVyD2e9WygiG2z8Or0iXuJVvwzapb5?=
 =?us-ascii?Q?R6/oOUseNEOx4lGnx8Nk79mOIq1HzdNb8LPVLKsgCCDvWywKY52bZgAbwFqY?=
 =?us-ascii?Q?7gMtB7O7JafNluiIl8kQSN7JLs68KGyVjiZMf4Y3YwXVAWRgOIAflRlXpaFo?=
 =?us-ascii?Q?jJAruoDK6G0Z88zwlNDG4QFVlX2N++VDM4RfkCGWHA+j9pC8UszFBi+qOFBc?=
 =?us-ascii?Q?FukRlwjXz4I40uIKb1seKGvjfLoZ1pEjFGhMr3PYm8nF4moZ+ppTAmaZGMK/?=
 =?us-ascii?Q?r3uIkxWpIa9AfTQNm2Rpl9aXTlMhWOhRm8HkaCgbCyS73ylaO1gWzmcdBK1M?=
 =?us-ascii?Q?caEvuoxBPVxzqTjJzn8RiTfq/j0/TTpC3gVm8VdektY+mpMQMfSkK4uRdCNk?=
 =?us-ascii?Q?/2IQs1cg7ULV6Msj2295Qi7pkda51OAcYMn3UdnT54ajBSX7gjJu7+DQ9y40?=
 =?us-ascii?Q?AED9s6aYGwESeuw1NhiTjUbMSyQ4x5vi7HxWXuvkUuWOxnrO6ecRjy1c8ji9?=
 =?us-ascii?Q?nHwq1rv1Fsz6iGwvPYwZF+M93Kxrj0+nsMesi0msipaDNTOZE6oCfzIRwFIT?=
 =?us-ascii?Q?mvHQcTAvUdcqhQQzAgeUz2zdd2ntbhE1oodSwhgqfhQbr45VEJKICdUQulTc?=
 =?us-ascii?Q?0Qo77qs5gryZgFzEWGo8YLeBccgujfFowi8hdUTUocmlhygQT3V/BCe2NVsz?=
 =?us-ascii?Q?T6fZott3GR/WKMRzaYsGvdsyFvuqOdNkIpdlaBPc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf22aef-faa5-433e-38fc-08db3c2caab3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 14:37:54.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGA6QG4N5Ex7CH1gEBTMuR0WHl0t9ilcmRPQ9aZm63MZBqvxKKCZr7rKHKi8bjm5hyn11T13DfTwpn7y7YVr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6355
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:02:48AM -0400, Mathieu Desnoyers wrote:
> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> sysbench regression reported by Aaron Lu.
 
Initial test using postgres_sysbench showed the lock contention is gone :-)
Will check how it affects hackbench tomorrow.
