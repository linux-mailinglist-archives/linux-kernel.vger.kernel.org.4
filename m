Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862F5683413
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjAaRl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjAaRlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:41:23 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32668577DE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675186882; x=1706722882;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bmpVkBoPL1GhqCTa6t6BKd92lpk3w2F/2JzI6PN4SAE=;
  b=GmtuyqQKsSTNiUrVyZb4Uq2DunPAtEa3Q9MUKq7F3HrCAWXxp+48AGYs
   n6KjYQVqwkq5Xft/ENM04wsJmxVTqzzFRqwUxYM35BmrXhxkjO0tKt7SY
   xS7hMEB1xbwEhUdE84PGgYxsKSVN+hXXhQPBq/F1+0uxldjocI/awZ5yv
   Wy+CNUD1kCwdweJtgvsxJZD1yTLgmnCHFmNKaZf3w8RcDASztBOWTip2j
   uhFWKBbfN8XjYwLoWJYBEUtcMvBdBwGUFZNDgxmO+WI8xlkOMTVF6R8uZ
   3EWID0V2H9E5WbIdJXjHwpucuAYSTTsw5zX1LRrJQHTfw8WzhjfuB03Im
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="308248652"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308248652"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 09:41:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="909993428"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="909993428"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 09:41:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 09:41:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 09:41:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 09:41:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 09:41:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwyTpsXEov73xBs2WO+nrLNylkdZbZHEKa+dMPQsuBnQIXubZpE/vvTnwJgbJva9/vnd0MGtJVSmOPsnyt60EjzcQ5RGVqcre9wJB22ictBxBLbvcwCKSLK+lw5+MXX8GezhJzgxQcjpsnup/ZrHpZomkM5E3Qu9gahfRik0Vz8ldAGQdZeohNmxc0mG7yNNetbxIUdit7AWdPdN9gUKi6Ef5GAtZOmKJ6Cfd/yhiHrq/l8+GXe6jSWfUactpidgeU5ht9nK04amPFL2lKdm0LMyMNnrq6GADVmEmwhU8HVnbEr9q7Nyjhc+O4rbivprMZ83BbqniTg37Wx6Phiwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVQki0dhfGJH87hUMblbFsizPjW26OGNJ56kwhjUoQA=;
 b=N37cDely54JkwCGFtAqx6N2omGLYZwAaMUgR77Qnbjp0stlaYb1R00x/0YbcrorPVoAaIpTfKPjz/XdX/I9B19zkmmGpvSIeWykp2dHRofwyjmZnvO+9hBvo5jZtYt5kVP1XmjKx1sV87yy9UASdSEL8scjMcypjnNjV2vVWpurNhl3EcNgscGSWOtn4oCKdKE4M9i29W+bNAtKU64GuLpmIaUUXYy3llFRfRvp1C2De7a+7aIk43MuXh1AMBblWTMRMMzP/JeADO2LeW+guSN3xnpSncqxDA3ig0okZwVBsGAvli6sK9GQlaszC4qGE1/Zi4gOVgiYSzTWI5LvDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW5PR11MB5860.namprd11.prod.outlook.com (2603:10b6:303:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:41:13 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 17:41:13 +0000
Date:   Tue, 31 Jan 2023 09:41:09 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Stefan Talpalaru" <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Message-ID: <Y9lStQd1LNq8STa7@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com>
 <Y9lGdh+0faIrIIiQ@zn.tnic>
 <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MW5PR11MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cfbbc3-eb96-41f1-9006-08db03b258a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIk62Ve2grqhLZ3v/yMarJCnqzm5VpS6D9/+WMm2YNf9gPPQ5fl/KA5QXLceF/SMQ6N8YxCm1YVZ5noaO8GZrvG5s5BBXCA8m580/1SpigZcSn1KvvMoIw5i+WXu4GzvLs9gwaoXqrZZXThpaZdvQ970m754vDG7cOD3V7NMaQOLLvkOo1Y/025WPnpaXfYW8J2Mbl6R/Q3pszgUpPykjWB+5/osoGLzYTu06STI20Wb8LMOyKECrsoV30I+VOIRL234CrkNnJIsY2soKMQdCL658wxZsfcUhs1CPO+0cEh2UhKWmOhLQW4B0BnhiMdQNnq3tor/0bd4tTDEFI8oj8ajhNjU/JBTMgabeXOpRahIXrvHDuH97PxakekMP2RWUwI1oqUq3K8fOqwkCCz+W3aX+UZbibu/loOraPu0G7GDsBcEHpbGHmqJikLj2zoCLNMCejDERzO3lcsi7MDxVZHmC65df9qoUyOTFXWI7neBuUBfNh1Kb+Hja3xW+RfSLNvloNpOYvPmMu9AHitPsby1yc62kUI8RNqKr5erfYY4t7btU+2zuMsTo9gAupuj2ktpvm5aplosOZmau9QGu2BxjiJOysNHf7kuxQTSSilpA7o8O0CnPJ3hHCF/zPr/acRdEEM+Mf7EFlVuCfeHsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(54906003)(6636002)(41300700001)(316002)(8936002)(6862004)(4326008)(66556008)(66476007)(8676002)(66946007)(6666004)(107886003)(83380400001)(478600001)(186003)(6506007)(6512007)(6486002)(26005)(86362001)(82960400001)(5660300002)(44832011)(2906002)(7416002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GB/vnEXHJfYEjDZOoDF7UFNLIVE8HKwUd9WDIsBjNyLtSHv2GVg6jrOtt2Iu?=
 =?us-ascii?Q?uMtL9PmtQ1cGp0/T3LptVhkg8egItYrPOp4r0kz4byPPeQVw947FVDHY5LBT?=
 =?us-ascii?Q?dC33bnVqajyfMF3Svo1x6y2fN6gpOqEsZkKBjNtUCVd3Qp207hjIh/qGq6GQ?=
 =?us-ascii?Q?bngxPJa32DobXPgR1lRgf5Q56LuuVTQnnPWRLx0/0m6qKl3/88YibmUeiHzc?=
 =?us-ascii?Q?r89RHMF2WLhCh6Nd5NUCgmYfhnIXx9NmBNImAPXSkZUyk+XzTtLzz9LH21hg?=
 =?us-ascii?Q?5C6DScpxnVPAEzHi0hblEIaMYAr2+Tjajq5yxgU0kYsQ8XTNHJOMW+lvkKrH?=
 =?us-ascii?Q?bZ+3UOsHlkvWraPsxWIbPiyuCNnqfa4GOkyQXCp8MtBBWxxFjjuMwWn8C350?=
 =?us-ascii?Q?h4+VGMLwZ/2CcWnmK0Lzi1SBhGrRxGgeweguHb7i2vpobFXHqRtu8x28Tmqz?=
 =?us-ascii?Q?ACuy9wGfQkbcjlvqztk9cg4+rBN990jsQVKLrz9+hM8Mlj/EkXsb4hh+ZZhx?=
 =?us-ascii?Q?mkzqrDv8gLFLVab65alR/p+PRaeRt4O2QT3OkjkAUelK919EPfS8ntF0JxuT?=
 =?us-ascii?Q?OHCO/LJxbSQATaDpOKR8Q+0ZpDV9PfA3YQyJKadS6zJXxcbZqSOOlhLQLvcK?=
 =?us-ascii?Q?Ou9kPuINX2XuWxhsW8prN+oITPNr1BJZizekG9680m9bnXDLkU2LZQVlU9ba?=
 =?us-ascii?Q?hgPvWaOE5ilIX7iYYS2tgfSH6etMU4j6M91BDGdMdPk1+1ogi2CX0A1LEIp0?=
 =?us-ascii?Q?UYM+EMNIWmV2FaarOtIR6MoJ9E0rBy6Oeceoag8X6+KhHf58pV0jtruugfwy?=
 =?us-ascii?Q?KMFei+NVzYcm+SXWuJFnfDiGUmJ4j6J36IsJ9uRx87mLF9Z2k0GpzBtSUHGr?=
 =?us-ascii?Q?Yx1X7CE+0eT/lyGLn4r/NgzQsqtvzLEiemLMAkVhX6Y+pZNuUiI38EhemWs5?=
 =?us-ascii?Q?vlFU8vCHf8IQI7WFCzhKVrzcRZdtDpJ8D8EvT3GpQ96LVIhLob6BFt6sVzIp?=
 =?us-ascii?Q?OclAzTGt4WVooIH44WM0poU/W1GV107SZrNnqFfLaI+w3F5Ga/aNnVgrULQu?=
 =?us-ascii?Q?R6QC6Cb3LfBkKc/v2WHCa9e5od8iscbcTqViB3f7l5J5lYzOAee5hPa+7YBE?=
 =?us-ascii?Q?SmklJcAd9x5SDBEtOsFtA9DH4/RkmM4EMOcKPYcpuekHZ5fx1t171eCsltoh?=
 =?us-ascii?Q?SSwB3HUd/Nji98yJE5hL1qgQITzCZ0gUoh2WTKLJ11Le6J6kkpjZbE8xRv40?=
 =?us-ascii?Q?dqIJ4eNU9Uf6Mbe6DPF17CVYg/FGC/PLFwurwNzVn/bBgeV4TmvbnLM1DwiT?=
 =?us-ascii?Q?7CZqGG+bpDyF9J7sRyWScYomYAS/BXP/qklyLAQAiH6NetUrbFwsdt2S0iHL?=
 =?us-ascii?Q?IFblnEXQRrocpganEyPGHb7IQ40I9T/1OfHjszHRscPxb33v9bwe5sUPIaBA?=
 =?us-ascii?Q?138a8uTeAU8XaqyukxNn+e9udlWOMRV8xkO6mwqaA/nHcuSd40RMnbrVL8JI?=
 =?us-ascii?Q?DNrrXk4ivl4RaNHxlwcy08HrOmmr9DF9s+USC8WVaIXdZxWqB7LD8JI/wv6A?=
 =?us-ascii?Q?sZYBoZLln6xpKeLAEhSm1N1qlI9uNaLHiIV243HdEAdq37Vmn3/VWMblnsoD?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cfbbc3-eb96-41f1-9006-08db03b258a5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:41:13.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhiOwnBrlvIqsESBps3tGA/K4wYkOvPF3hipYWgiS5kdOQnzhkZQ4pwOcLRAITCu/N9RKBsv/EKylKmHqlxA0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5860
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:34:14AM -0800, Tony Luck wrote:
> >> Currently collect_cpu_info() is only returning what was cached earlier
> >> instead of reading the current revision from the proper MSR.
> >
> > Because this is how this is supposed to work: you collect what's
> > currently applied - which should be exactly the same as what's in the
> > MSR - and then see if there's a new patch in the cache and if so, update
> > it.
> 
> But those get out of step when applying ucode on one logical CPU does
> an update to other(s) (in this case the HT sibling for the same core).
> 
> Would you prefer that Ashok leave collect_cpu_info() as-is, and create
> a new function to read the MSR?
> 

Untested patch below. I think we could add a new function if needed as you
suggest.

Boris, do you have the same dependency to take the siblings through an
update to update some portions of the ucode? or they are only for early
loading?


diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index d144f918a896..0038690a5d4b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -673,8 +673,10 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	 * mc_bp_resume() can call apply_microcode()
 	 */
 	p = find_patch(cpu);
-	if (p && (p->patch_id == csig->rev))
+	if (p) {
+		csig->rev = c->microcode = ((struct microcode_amd *)p->data)->hdr.patch_id;
 		uci->mc = p->data;
+	}
 
 	pr_info("CPU%d: patch_level=0x%08x\n", cpu, csig->rev);
 
