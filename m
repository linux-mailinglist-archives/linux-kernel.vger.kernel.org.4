Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190D5708CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjESAkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESAko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:40:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93B115;
        Thu, 18 May 2023 17:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684456843; x=1715992843;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=raubtg/U3IJ+NxZgVyF3YnHjjVxcdVNDZLaTUBSqfGQ=;
  b=eZOwIJ1UU9uq2MbArgsl2l2lwMZrATWAIa8HomUl9Thkat1fCw2ECWFF
   rsjUrx4LRwU6QJ5O6X00QImGTl9fTQXZpQpE8mevfA7kPgzBA206c1ol6
   o+a+DCGQWFoiKCZY1lDBjZ5R/tQWRBzGbspiuYAzZmYR5TYCQkVxQck7Z
   hds2sVMyTWmAZinAnuc5MaIhZl7rLOROjdQWMWu6Aa6JX+R5n2d3Ae/IW
   AMCsHuQcm2+CSo1NJSnXfAuevTrmmnH0cXVlje4l1M45HJfqp2vbAqT2w
   ZUg5K1q4n7D8sFo7c2IZ2qnEobwjMEbKYUejql+NB9/DTtLt87WextiNg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="352252785"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="352252785"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876641086"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="876641086"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 18 May 2023 17:40:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 17:40:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 17:40:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 17:40:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 17:40:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6zeqpWW25o008a6Tm5fRF517YPSRCTPsFcYddkb4tOGVmL/cHjLT0hdvGbqdRfnANKb2QUyjSf5H+d1pstJLprr7r+Yu0O50+LKS+bNeIVhdI3nl7Cy4uLnbVEyxnLwr4vla/L6OXN5BxJehXTtXXdKKvgvgOX0iQ80xn8ax3pPLGGOkDe6hd6E4o/8GG8/qADdSSyW3/F/lHY1N5dEb1J4OQLsgg8JgK+Ruhe7quqgpA9vKwMag9abcKhTDKbndNkGGHT7IkLz/czIqtnSP46EVaTrzeYmzGxFFRDST+5T8pxjJaPzRgMaNbkMZXgYNA0xq3KngNa2NUGE7az2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgD+r8E5BmV+jdecjp11oRBwWru3a4zuI7vaCsRIXE4=;
 b=DrvvwWLIGFy2kL5yEo1lhsm2YZwX2hS8imtWlQlzujQhhkD1bZXsNycx0+MJcwo+qQBAoQSkDFbMry8+NaQgyjxJ01VJYXfNaHXxlHBXo8d4vuz4Q8SEYfAvlV1Jmptk1Ss+JMIr5a8jKbJnVTw3CmZg7OPhFIMamD/6W1PcJsPti17O5uFfguAO8CMg3m/nkhqLfk/N4d4mp2hX+H91oV/pnx9p/29pgBh7ht1+oesr22qRzk1ounz7zBVOd6PCqe3w6Mi+ptSWCvjfT+j9KrsJm6hexHqOG7d168G8ksCz52mUb76F9RrmIRwuGH08g9CaHmPJrGaBAM+JaW464w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8143.namprd11.prod.outlook.com (2603:10b6:610:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 00:40:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 00:40:34 +0000
Date:   Thu, 18 May 2023 17:40:31 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, <x86@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <6466c57f7c2ee_682c1294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684448934.git.alison.schofield@intel.com>
 <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
 <8dc725c8-613a-b51b-6cc1-80d2275ca130@intel.com>
 <ZGbCG4gRGow0VCmQ@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZGbCG4gRGow0VCmQ@aschofie-mobl2>
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc1e67c-8d99-47f4-0bad-08db5801a7fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWp2JLzPkeyqIE/1piZYO2YZljnGtmXH5DWq2z/hD/HPt+7vWZbMbAnisrNFhtzHBR4967IKn4hIqr4UfhaIBakNJoaUz+Lx38hk8/3JsjdYHnwCoeo3iiz+dcWN2AQQG7fGgBfKG2ZlNNAq+krhrz8EEmr1TBDzmd2VRBidwleO7LbpeNw6KqQvnITrISMg+1m7AIFP67spIxspDORqntrhgnZcwLZyhBAYdh+W6333TCHkc4eDeZ+6eVplSMeczpHOvLbYMisX2AVq+W+alT7FBPGZJvhU0XgVGDRHlVoj8sAn6GPns2kV/Fy5aFneAeMYD2JCiMRzmfJaG0VVDAZ1tsx0DJgxJ8iJ0GWI9tNK4keHfT++ic1snQuUVdEzNjnZjsrlltS8TpqxLgban9G/nDFvLw+P35eNOW6j72Z5uG9OEL7tW3Xlwykn1T9Uw1h0ywUlNP6C15W3+KWcUeCTq4xyeUlJ04Zc5m+zULWm3Bdob3PrikNFR1zuynx23SAXLTfhVs21IVHCdhAc91yhWMQXW1jzpKoMD1H3qEW6JSuZQvqpgaAJOj7b/zpk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(478600001)(66476007)(6636002)(66556008)(4326008)(66946007)(110136005)(54906003)(316002)(86362001)(9686003)(6512007)(53546011)(186003)(6506007)(26005)(41300700001)(8676002)(2906002)(5660300002)(6486002)(8936002)(6666004)(7416002)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7BE1gWuYdEmm4/VefZngEAstG9XkGJGDknscluq9k9LFPzdXI46LSXmyGxxe?=
 =?us-ascii?Q?tF5iNt8m1ZT4j/hE3+UygLcf7pDQHCf3E3Rpow4f9shhFXiIq4Az6HWgsOQt?=
 =?us-ascii?Q?oPPvM3/IB34bXnTz0IryDaa/pcnI0uES9jkRJ2ghwnZS5pRuAwL79P36gWDy?=
 =?us-ascii?Q?fhKTtTTxC8AbFzkRpC1XVybm3ViIvjZDVit0JY+WFuxz2YZ9L5UG1PNYOI/H?=
 =?us-ascii?Q?YxRsnUvyvTdLV6wIIQ+OqVdxSilZWMDshqWfttY99PzAdZGmMBqGTgqcC53m?=
 =?us-ascii?Q?KZhV6FUOj9B2Pr85wo0eVUUzfAbDEZFt9uSgM1/2j8zye0rIjcGF7C4op0vn?=
 =?us-ascii?Q?lBNHzujQzuLJBTq6Q4gqQc2wD5FQRIM0Y3QW/oLyPZMIun7jt5K4hp99i7sx?=
 =?us-ascii?Q?zZ+/Voa0a8TyhEoi4GWcWH8Sf1ORsmyJE0o1s5klDsfSbJePLuMinEostwb5?=
 =?us-ascii?Q?z2LJ2tXYFM3SkfxIL//FU+hsw0hjG1WKF+kKRKONoN0lB/bfcY8cutAHfU2r?=
 =?us-ascii?Q?VVdf5YXFZICv+HxsZD7S9nhbqFfT+9ejw1smild1/WOLAEqTOvsYk/8zSrGm?=
 =?us-ascii?Q?2EEBube+Xj1o0AW5j4N1fY6sSzWpHxnagY3p50l+TtkMHSBeXYRuTQFdMhnQ?=
 =?us-ascii?Q?5mhI9bRaQLhZHMGtFTY5rvP1JyD/L3JyqHn1JiMChoZlXLNhzyhmYDkMH1TU?=
 =?us-ascii?Q?oflnLolmUgbe/h6cxJZQCj/VDCB87YYcyyhIIwduqD0boyvTXdQWVmMkaBol?=
 =?us-ascii?Q?xkgF2psvWYPe43Uon8Y+zNRrzdSGmtYDVMmvdn05tZjOnig0J9Lv8e5epqGJ?=
 =?us-ascii?Q?lziAJndJnru4yveTzjUsG+8ni8BQVeW/wj4+eW67FsSaBo+fsZ8guwdKWyaL?=
 =?us-ascii?Q?9eS0m86TA1nKEBJv90IRzvgwwIlauexSdkgNR5q9swNuGpaTas/KHUwJq5mP?=
 =?us-ascii?Q?0AodANFdWpCLfhOMH8xqAXOr2VCU7k4KA7gJlnF8BwgPromT4gybbJD7jZXI?=
 =?us-ascii?Q?3nDgkk+RaB0Y3/m0q4NnZt9KNkL/EjPbJW+Td10XoSC7PZjpA3+DPR9kUcJC?=
 =?us-ascii?Q?3fGRMlIZ+BDkaYhfiWWHGBKkbfmhtIi8cGFqzjLHXQ4d7V7vYQH7Gz2sEWz5?=
 =?us-ascii?Q?LDWfnUFpnMADmmROZiwyTgMx9yaawgM/rvaNlLPeaXHqAZscbTssVjx89QmF?=
 =?us-ascii?Q?rA1Zb+AXSg98qfbDCT12ALnd54hTBIiGcYuj0uq9EdyD8WqHFPdK/0bFckTv?=
 =?us-ascii?Q?qmptkJDW3Q/B3OfWm+sQ8PJrYlX0tex5Oxr+pIXS55zjEassbWArETQr5nxn?=
 =?us-ascii?Q?1gQ6I9K6pqna/RfSFI7Drkh4UJ7JvIHc0tfp7rocIfrRHb1gyi5FchdUOFhP?=
 =?us-ascii?Q?p7Art1n99fRXwUHXEINJyX/afNnmHOmNpp6zyX9B41ZsZZvetC3kvRi6l/1b?=
 =?us-ascii?Q?/d3YTVHJ0NH/mf/EtE+ZGj3k+pA4rVILx6MSBCdXUCrXfT6QHQ/p3LhAWIdw?=
 =?us-ascii?Q?LXgCdteHjajstMU9WA4fkZKBubJX6zhphJ/0kCA2GloHJjIqEvAhwkFFCTgW?=
 =?us-ascii?Q?Y0iCbUCCZtcOjCt1lEpaYXizYZosACS/n5MzEL8+EI2r0qx8b81hEzqKp/3X?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc1e67c-8d99-47f4-0bad-08db5801a7fc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:40:34.2528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCKlUAvpfw2+64DdsZ3yW3zYdaIYuAVuqkkV0l9IbZvxQ7h+vKyyPM02YTdq1/VbBDf1cdFDtIvrNPxl0Zez5F0uG1CIjIXgIIB9wmFK4Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8143
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Thu, May 18, 2023 at 05:08:16PM -0700, Dave Hansen wrote:
> > On 5/18/23 17:04, alison.schofield@intel.com wrote:
> > > The initial use case is the ACPI driver that needs to extend
> > > SRAT defined proximity domains to an entire CXL CFMWS Window[1].
> > 
> > Dumb question time: Why didn't the SRAT just cover this sucker in the
> > first place?  Are we fixing up a BIOS bug or is there a legitimate
> > reason that the SRAT didn't cover it up front?
> > 
> >
> 
> There is no requirement that the BIOS describe (in the SRAT) all the
> HPA assigned to a CFMWS Window. The HPA range may not actually map to
> any memory at boot time. It can be persistent capacity or may be there
> to enable hot-plug. IIUC BIOS can pick and choose and define volatile
> regions wherever it pleases.
> 
> So, no we're not fixing up a BIOS bug, nor doing a BIOS sanity check.
> 

Another way to think about it is that CXL is dynamic and SRAT is static.
ACPI hotplug assumes you're just onlining an address range that was
declared offline in SRAT. CXL hotplug allows various capacities and
performance types to be added. So, how many potential proximity domains
performance targets could exist in a given CXL window? It depends, and
because it depends BIOS goes hands off and lets the OS define that
policy.

The Linux policy for now is just keep it simple. Add a proximity domain
for every unmapped (no SRAT intersections) CXL Window, and put the onus
on the platform owner to assign devices of similar performance to a
given CXL window to keep the proximity domain proliferation to a
minimum.
