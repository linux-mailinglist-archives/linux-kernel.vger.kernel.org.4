Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858BA670CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjAQXFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjAQXCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:02:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3012F31
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673991381; x=1705527381;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B+YPbz3A/yrB2UfugkKPBzdxqomqJ0NPeSqAcP8stAU=;
  b=jHFNuxR/5oWdcKp46Du56Ytl7u5CBAS+c8lyXtmWxQgsl1WKFT+GlPwv
   LiSasrDGaR35QXauV1SxMgVTZMZPxuIIWIJSg6dom9/U42WGA6iYz5TNa
   zZxZnvZ8LYlugMgcyS/Yo/ID6AF5ToVoFDYvvhVlAGazMAXVdVcoQALuL
   XcKu/pvozq1jbsI+pNwmj2OV0QWpiRb7Mr7pgLItBqDPvlKUtMUx1V6kL
   8vlUvuGoKsraLkM3dK+sjzQtM1ydWqom5k/mc+hlx90HZi+/ZhFa0LgVb
   mYiX+i9QZsNEseOu5fLY/cQSS1TKKq+9/tGHJJnoCnpMzR3Hn8gCIwbL2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411060058"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="411060058"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 13:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="652666268"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="652666268"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2023 13:35:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 13:35:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 13:35:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 13:35:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 13:35:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4W+JQNYl1x19mGLCyXAH8Y8k3wx4Sr1zQUty+d97a3Aw+UP+LhSTGP5z7m+azLT1AQihJtNcT9TxYlFnm9Pypp98gn1+jrg7f9klGo31nlsrXRa3M9A3xQrhdQu1yR60GZp2fMAhB0Gk/3Qo6SsfMP6e2cMtGmwaJ10hlRuH9sDtE+b8gG2P/7cm2QJL8fswLHulA7vnhEcTexfUdnfkWTJt5yFkZSSK/4xTOkzsm9THi1BVAfxzuMQ2zVedM/F2mbDO1OoCNM8f8HVOtJrHBW1NmaeANV1Bk5FbuAqxPg8zAFF+XfsYCWwaqeKl1e6/Iy4QzERFBJBAheebEbv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX78BHqePxjRlv3SceAvAfnVltppxJ0IHCfcbXK2Uxw=;
 b=RVAqCUZtrDZQi1AFBJhI/rw0HPAz2WbV4dXSmL+qgGJQqZzc0NrJTJ9eLT8puLo/e9mky7Hgv/ehNJKQEMxUtrZFNuem3gvIqIE5hjTakBN52IANoeu0ZWfG4LGJMvS4UOzKBoZFZEJrMLSblBHc78FR2zjszQOOHLun4wwqHEIjV/nlDWZNIe5OvqSbaUWKN8GAIWn9g67q88GmV7O9If6T2yKREicxa2CYQNUQxXSlR3gj4b/hhcJRhq9GKEA/iHWcgs56pPly0p2IikbgQVB/1HKS2Op2rreMb3xXeONODK6UfaA1S/JVqStMVWaNelyoolK5FN7rQ6ODhaJ3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) by
 PH0PR11MB4776.namprd11.prod.outlook.com (2603:10b6:510:30::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 21:34:58 +0000
Received: from DS7PR11MB6198.namprd11.prod.outlook.com
 ([fe80::c0ff:f667:f68c:2775]) by DS7PR11MB6198.namprd11.prod.outlook.com
 ([fe80::c0ff:f667:f68c:2775%9]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 21:34:58 +0000
Date:   Tue, 17 Jan 2023 13:34:53 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8cUfeqeCQLORhbr@a4bf019067fa.jf.intel.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
 <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
 <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
 <Y8brnyIltcgtUvPn@zn.tnic>
 <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
 <Y8cN1QcAq6bzK09J@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8cN1QcAq6bzK09J@zn.tnic>
X-ClientProxiedBy: BY5PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:a03:167::48) To DS7PR11MB6198.namprd11.prod.outlook.com
 (2603:10b6:8:9a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6198:EE_|PH0PR11MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: 041cb556-961b-4de2-1f15-08daf8d2ae41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNZzkrB8O8JFoMNkEmYn/iT2DWL2AcRSXy2wk3UAOfALhZCFBXvmqp4nVVF7qEgEkeAXmPwmySkdGWD4CuAAABYgR/4PEEL4ZvfApIHkFHcY0DfjdWSUHaB/obCKTE4KkNW0vI8T5tX+pXdbvKosVZzCYa38z3JZwqNSntGyjQv01lzKeCY+nZmxgCx+vWjjFguqHciTsfIWME/SIKpEBH1cL9J4LCJKWie+4xFY1/b6Mdp3Um8iSKsGs0UbsCxDs7IoOAsTrergjvbddcYwKUEKmIlAZ2UvWVM5iN9BWfX2dwKwB3Uu7scwqYjCB7Ll6/a/Cm9xwttqJC6IAZzUjAwRdKdxGYNgCN7XnGyfVNGSt0grCnL7h04XMwgY6t5CUZYE+DQiVVoZRYN60KManV1inAmtflIbmANWtzcWf5A4k0ytPxyemNLtzIlJ6IL+eJ0C2jdR36Dh6Mm5dA4e5yLEnPeiZJqyX1tqxaFdkqpcqY3rI/AkdJbnE8bDNBiI4RuViqCjatnNImZ082UWxqDbzSbHd8ajMaRY9+5MuWmfy/djl//zSXNbwCoXkGUqeWxb1urAhFo4ZIGouB+OEHJtL9bVyxdWw/ChC8Xq7Ve12TlKu09w46pOqvHu7InR40ZZe93pEpKD/2+4L4bNtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(66899015)(38100700002)(4744005)(8676002)(86362001)(44832011)(2906002)(66556008)(66476007)(4326008)(66946007)(5660300002)(6916009)(8936002)(82960400001)(83380400001)(478600001)(6486002)(316002)(54906003)(6666004)(41300700001)(6512007)(107886003)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/bedeg6YfdUD86pvzhFyV3+I2evPZQc9Nd8t6N+WTLZ0loegYqb3Y+9Em2/G?=
 =?us-ascii?Q?qr/pMahkSTBklx5I7Lh0IpRmWILvPRTS7aL8V2gON52i3NO/cgx6D56uEpM7?=
 =?us-ascii?Q?qLHIltdJmm7PyUZXQmX7c3lf/galPWR2/4rIL+RNSly5x4x4QAhGIrxvgiAj?=
 =?us-ascii?Q?ADuWRWCLtucxw817fG+JDDnVMZwsr6YGt7OV/8IPM2P5aFEOUuoMWcoOyHQU?=
 =?us-ascii?Q?gBu/nQrJmctiRaRp6rd8ucorxAnnaN1Gu65Qs7MKiM1SpL7cuK7AmI+h096+?=
 =?us-ascii?Q?2y8ojllnqZsSj1npQ16HQ2g8J2lhuR84Z5mca8rRjcW0BjB5VPk3Jj5hVXO7?=
 =?us-ascii?Q?sfnLdVsGEyBuZISSCYyut2UYvpWtKwi3LHUpa6jfTnvgsJV+iySluI3CTc0O?=
 =?us-ascii?Q?6t6781nEQOT4MdQ6HNkgA/bXPxhd/Bv2xSC2pqkDgbGsTEkYU05fuBLe1yQl?=
 =?us-ascii?Q?jwmnAsyYToloOEAwIFJeHyokfjJCoHErYakNz9J1g6DbV0ZqF1lW6QSIV0iF?=
 =?us-ascii?Q?V0+9iR5otuwMrOoBLTwxQCPmXxvrUlSu2xv1n3hsorE2S7FEkrH8j+Y3aRpp?=
 =?us-ascii?Q?s8f8X7QeKTbpn9uMTNbLYn9B45U0wVf1oTrQdeiPhX6yJHz+INztsRAdfaPq?=
 =?us-ascii?Q?G58SvHARTNhmMy9lmVy/2lOH7vL24YTbOQqoOlwxJrkIbnzNVQDettRglg9h?=
 =?us-ascii?Q?fG7oKuzucy9y5S7deIYSH4ue0snVfx+3+6ZaTGWpe8nbHROxYalu0lJUEQet?=
 =?us-ascii?Q?BN/GH/V+rLZ0aPMCv2r8ooamP0j5XbYdixzi4tLY3M7jAfG8IaXZ7cxGOtxK?=
 =?us-ascii?Q?gYxbbUzkN+xHr/4Fb4IUTSPoanFLl+uWnPEF4pDpLBxFFBHKaaBANO+1+H6O?=
 =?us-ascii?Q?TBEN1g/T1yZFDVKv/snmQZLQK1m2mBj/qYbbIORS9Gp+ndmHFl4AxIU0AumJ?=
 =?us-ascii?Q?5uLoFI6raXUnDcHgDlNLlYTz6rrL+3P1gaQmvT1pviFJyagvMKxF6yker7Gb?=
 =?us-ascii?Q?XfrIwz0nyqoVO3iCwG2VmVcbZi5r76MQYCmg4undCVKxu323V7pyOAeLMfzd?=
 =?us-ascii?Q?4TGTyoQ1VNvWQEef0BYB5FthQgdnkM2LVKCyF6gvREvYetLzovv0S2nx5ukh?=
 =?us-ascii?Q?Wm9KTgAvYBz9iAispGHbhInoRjZjdM+rrPMPD6u95MusQjtrDVv6Eaw1mhhO?=
 =?us-ascii?Q?sN7QC4Ap8dD4wTDu1lz1+wJvB4OClksbVJlrzCDAVS/MuIY8CKlaQ1uDQHnw?=
 =?us-ascii?Q?DK/WBlkhBpqw6u88+59d/UZBxZY639eZPNSiRA40Nt6EsSWflW/EWugiiDJL?=
 =?us-ascii?Q?fXqWBOXbGcCHG/VB62y/0V4E19yXO5GvGBVROHP9isimK/fyLYuv5m2MJXFo?=
 =?us-ascii?Q?yyRl40EvZCIY/qKzahqSTMHw51dcEEiHykAHXVlvhhH6vt2QJQPbyvWGTX3K?=
 =?us-ascii?Q?oQrYzfcLs0lrdtKAnapr8JFLo/AxhGsZE4CmdNBU0u0qiw/CiIUN49bZedGN?=
 =?us-ascii?Q?hxH2CwgHs4gK016vLwFCjrKxhLnsGkRkZHVi/HHJlPUvNdVOgJkW0A9Ji92Y?=
 =?us-ascii?Q?kHLjAQQU924w9v0cXmkX33nQlDlpEg+g2taoLIparGfmFs+vcEOVYUBF1lfL?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 041cb556-961b-4de2-1f15-08daf8d2ae41
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 21:34:57.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paBVB1sz6amtgq4qhwL0vb3JoyR1Sem5RuYIhVkmj7cUjp04Dgw3IElGG5yYMa0WC1y+L/pr/D2AS1ssBQ+bDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:06:29PM +0100, Borislav Petkov wrote:
> On Tue, Jan 17, 2023 at 12:40:30PM -0800, Ashok Raj wrote:
> > We just agreed to show both failed and success for late-load.
> 
> Did you read the part you snipped about getting false/misleading bug reports? I
> doubt it, as usual.
> 
> If you all Intel folks want to deal with people asking why is there a warning
> message about microcode not loading successfully, I don't mind forwarding you
> all those messages. I sure ain't going to deal with them.

TBH, there is nothing to hide from a microcode loading failure. If user
sees that a loading failed, it could be maybe due to corrupted files and
its best to know and update to proper file vs running without the latest
microcode file always.


