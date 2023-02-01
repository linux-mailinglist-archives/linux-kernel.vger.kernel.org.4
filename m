Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC5686EFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjBATdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBATdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:33:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659642333D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675280000; x=1706816000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rK+r9NEI6YG2bf3ov89s8UfE+g4f+QTLdDwkjWLKUJc=;
  b=dT+0123crVtls62I0x9ivdu9Ujkxyq/fB8nIYPC1gEPKqDRJfPfnaJrC
   iiYGHA9MKn3QC7s2Pp6AD8HsmxxUO/iSmUMZ8FcF4ydtLkpzkL/jIQXhq
   gGMrzGoNyqBXW/gpIqgeVvX4SnPQDc4nrCZdHfoF2DPPo0+X2potD6aP1
   wRxvcZjAY0M8HTty7Ya/5X2MNsRpm0bGN7aLdArRLwxpApj7wsch5YBBL
   iyPNYLzPd8vBrRDJ1va6GmwiZza5ZCCOIQCFyrX8griT3LqnXXUDMHPHs
   CY4nXZDloL5A9zgqMoDtmlBDK7F6XtGjacUNBlelvyr953z2R8FEW9jsj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="392830627"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="392830627"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="697391000"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="697391000"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2023 11:33:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 11:33:19 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 11:33:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 11:33:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 11:33:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE83aMSF/5k46Sw5KecYgy6iNAlqPJSm3VfBjT/VaiT+/R3ETSfb/ad4Jv1T2I6NV/m4IYEXZlQMg9mkAyrYWukL0KXiAN17jKxvF9J4pFSfmwLa+QCcueSzCO9Ky0nCapgvLo87uFMBHx6qipVZ0nckTV1CDE1tlbj8bupNFJotVUdLZik1IhSQgF5wksU7NgG3n70CFTqpm70qbNsv1ato0uaxlSS4tKbr5CnOOpv7a9AP2IiRvPuitr+HHRq1TRI39eY+5cGIQgo3x/NBv07mbofjPd69h+jk77drWjzx74cRPzFECX8t54U1km2uH6wSc/Cz0bPQz7hsk6V5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5hFpsEkjEZ9Xx7aac4Bz8z5qvMPkcGd/SOCxBlTU5I=;
 b=CWZoK4Fw8mKW5XVTC4m7XKjG6rlhvGaQNFzf7YRwdhIZnElwD6nvlvgjyZxEcih5CoSPNGOSw37doa3d2JzacwO6bRyqaHtR/UO/BZknjdJ9gDT7Jek/fp+EFuDJp5MNNRJHGjsLtE4/5mlVEaLRL3RCfGUOtFKHh34rpxcxMnOS/5Kr5YKK20Nm9ZXldQHQDRGthsQ+iz1iaurGynZRyn4T+xiD1dp+Bu4wPRxHsJcGbAqTzx5Jwn9JRMreWw/BmYUBJ5ksqBr0SCZAQCp37QxgIA6YqXLo2Fk/RY9N/xmTIh8YJh6v7mb1bEcA0s0dn8Ytw2+KqfeB/hnOV0cnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 19:33:15 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 19:33:15 +0000
Date:   Wed, 1 Feb 2023 11:32:40 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Message-ID: <Y9q+WL+hnS5ZymDj@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com>
 <388d0260-042c-209f-a986-c9ca47061b3c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <388d0260-042c-209f-a986-c9ca47061b3c@intel.com>
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH8PR11MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: e20b4d5e-d32d-4063-1d68-08db048b29b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AGOnItabuIM29PvjBmy+isB2JK3SQ93jt/UYxKoT9gJJVq1yEvU/jTJli9sJ6blwtsTCKIIVgyqSWSNjVvOVdLReZcrYaLfxKpqgGsGaxJpLxgLfhCbl9qVRCfT5bxLu/MQvWFl1KcQjeT/VoL1TJUZCCUYwWJ/fLvZz2Z4tetWn2k/rt7IKAcotus84QANCF34m3sAg+sJKKvnf+7/Ojsf43uqXX+pJD2mmfPXhVzeYCy1t2bfgD4T47bjT/OO9A65mGtjLI/UAXyRxnBMh3VlC87VNtUCyjVwIm1IkNR8xRI9siA471AxcmzxukVAN/DhMTLrO3pgcP6AjNsYbrqtoEP9U0g97GGpMWWTgy/m1AflnydIAZnPY9chknveWDEcd4oavNWhIldfxGVwcJ3Shi3VVa2BjDkr8220H4BnszG+Tsr+tsHebDOkP/7zBCvp0y0HhzxqdsRAQBfM1fUS7hiHzFrgTECHGb9jdSX7//tuPgu5YXyP/FO7/t3Ewa+u5LP4xEgPhUT6GXTwlRn9nEOdd7i8GBDIVWgZsKqkhA8wd01PEKlB0owiTpW786urTYQKu5wJ18fY37FjT2fCCGgPEVLTd2KJps53j66bo3G4nlzutIiRB1a9i5FU0DxG9/8bL7O/MM9IDNP210c+1CfGqAv/8uf+lJZosiFVOWfiNKTt/OkZJEsrcdSmqjqJo9y5nfa7JBDd6Uj7ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199018)(6862004)(8936002)(54906003)(41300700001)(6512007)(86362001)(7416002)(83380400001)(82960400001)(44832011)(4326008)(6486002)(66476007)(6636002)(66556008)(66946007)(38100700002)(316002)(8676002)(186003)(966005)(5660300002)(53546011)(6666004)(26005)(478600001)(6506007)(107886003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tx3iBrUZKAaYH8lp3psWP8dqNsqwwpJaxRK9dz9i++o/gxHfuBa6g9OwPcG1?=
 =?us-ascii?Q?eZJUPS2V4BB6wBE+dnxvjWos2Xh03SGshTxA7zzlt3xYPP4TUS0k7N1KgQdM?=
 =?us-ascii?Q?eifLB65FtJhq+SIXFLDPEj3Y9B7gzh5ABvqE965HXnyMQhVTTq3R82ziRYq9?=
 =?us-ascii?Q?zO35sLKyrdT6hjyLdC5Qwx/5luEb8YOJoZv0q+5IPfHGSISqOlftDJiZRD35?=
 =?us-ascii?Q?83ZlnaMH8EtHLjDWiK/AlNkwEGo8gT+larYCXVo9OQ4xilc6SGnW9cC0wF07?=
 =?us-ascii?Q?UYfXtzX8DSHXzn2f2YW/AAhBzJvaosvsFmAADG8+tFcvprd3mi0wuQma90vQ?=
 =?us-ascii?Q?VPch0v5SR9nVtiyFqdL3G9EtLUqs/PirVxbOw9Xlj5y4fgIl47nPmNHWl0fs?=
 =?us-ascii?Q?yC4KdYMeHj2ayIz9MbCfZpuJPmfSlgB204JtDFRbNRkQnwKF14GijpwWELK5?=
 =?us-ascii?Q?qsjIQLpr/zE+41ni8EVlNigoAL0ZQOfL75wNLkVQkuILnnGcCYbVuSRIYw3E?=
 =?us-ascii?Q?3+3dZOzlIiOybe3+nYGeX/r4DqqM2KM7V+kNJ+IUIdWcSihZ55z1C053cN0Q?=
 =?us-ascii?Q?HoAycnJv3KiSPubgVfIKvxLJfme8uWkslImKz7SrySMjrUJdp14fvo3QdhiH?=
 =?us-ascii?Q?mf9ovty3CmUVjG2Yc3srIxIVnpaxfrbCRl2Hgw4qGcGSF+IoSLvTNAr7Izev?=
 =?us-ascii?Q?tZOLIS+ssk8iLzi8yyLsSNxvc2acRF40duzSrT3Tql0q6wkFPvPCp1cHf1aw?=
 =?us-ascii?Q?22HRe4jnpm72dnrNe0hejjXKULxBROo/as4Q0JWlfS6djctbjB8kFHRXlY/u?=
 =?us-ascii?Q?VShQrZt66cdRk5l+QKxVkKoewVFCyNzuhxpFgGrMmQm/4amaWcFMUCQlqAdL?=
 =?us-ascii?Q?kefTiTBQ6M0IjmkRypvMmSaGNWLrVn1GSUi4zaDlE1HizJsNI1fpjp2TLEgY?=
 =?us-ascii?Q?3F8lOQis69FhYGQnsq7VITWQF4Whjkmlp1S/gpdhP+LCAgYhqJ1Gl3OS3vKS?=
 =?us-ascii?Q?RCGTdJpfeaJNeOnFCbkEeN7D6Gxc2knA32V0XyziJ66Lz0R8D4Z/6kpN+OkT?=
 =?us-ascii?Q?j0eeC+CJ4uT6GzK7HJfXFu6qLoUHxvb1yrv3ahfyk4RAMS51sRZEYjMY+0yF?=
 =?us-ascii?Q?KWT2f6EEd1VfUlcN9hpg/IafyBck5CooS4I/ycASqv8ALqJigVdtundkZ39s?=
 =?us-ascii?Q?JCyT4rbBPwaikbV0knNrf1J60W7/gI0OvFK+EwTWRDVQEbKY5MsrHueDuZdC?=
 =?us-ascii?Q?YOaVf725SeQNgO3LKjieyCyk2uO9l+F0FvOn0Jvwh83t8TJ85I0L28xm0c4Q?=
 =?us-ascii?Q?M5wI42bsgtg4dhZjTkHjvfzk4s6ca7TDX6ZTNpOZ06yhKgGJss9VyDKnvC8d?=
 =?us-ascii?Q?g0h1JuFZQqKZcwpAGwjYoMtjKH9iUnvAlO2Wpg42k+EVLe4Z1gzKuGmTq8JI?=
 =?us-ascii?Q?UVPQNN6ej5XOx3dm1DmQU/4gwN8mGXnVEjTouANHPRUGbTtJOS7tz7CfGp56?=
 =?us-ascii?Q?0B23/qzHOtOadKzxWCpqYDPMehxoIx5Hwp9fS7InjwOr6UBjuE8CU7bBGeu1?=
 =?us-ascii?Q?Nh9Kue9ulHnCMb2rfLNOdjNJ/uZE+CSQbyzAS4ypDwVKOf4RDZnstpfuW6J0?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e20b4d5e-d32d-4063-1d68-08db048b29b0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 19:33:15.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YU9b2u4DrHyncIBvBtDZccQ8RSlQV20xO0jtbSqntf3/XWSHvRuj7rmH3zqv/sjWVg2W0kh/4ZXiUBfCl8Xctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:13:58AM -0800, Dave Hansen wrote:
> On 1/30/23 13:39, Ashok Raj wrote:
> > Currently collect_cpu_info() is only returning what was cached earlier
> > instead of reading the current revision from the proper MSR.
> > 
> > Collect the current revision and report that value instead of reflecting
> > what was cached in the past.
> > 
> > [TBD:
> >     Need to change microcode/amd.c. I didn't quite follow the logic since
> >     it reports the revision from the patch file, instead of reporting the
> >     real PATCH_LEVEL MSR.
> > 
> >     Untested on AMD.
> > ]
> 
> This thread is meandering a bit.  I think it's because this changelog
> doesn't have a problem statement.  It's hard to agree on a patch being a
> solution to anything if we haven't first agreed on the problem.
> 
> What is the problem?

I alluded here.. But yes, clearly missed in the commit log.

https://lore.kernel.org/lkml/Y9mW7EiL%2FBpYFLWn@a4bf019067fa.jf.intel.com/

Thomas alluded here https://lore.kernel.org/lkml/87y1pygiyf.ffs@tglx/
that error handling in __reload_late()::wait_for_siblings() code patch is
completely broken. 

This is one that I "assumed" he was referring to, since all we need is to
update the current revision, but we end up depending on the behavior of
apply_microcode() and that might accidentally have some side effects. 

Instead only call the collect_cpu_info() and allow that to update the
per-cpu revision instead. And there is no risk in performing that vs
accidentally letting it fall through with an apply_microcode() that might
have risks.

> 
> What does this "fix"?

The code performs this delicate late-load dance to prevent sibling threads
to be quiet while performing the update.

At wait_for_siblings() when all threads arrive, then the sibling does the
apply_microcode() which seems wrong. 


