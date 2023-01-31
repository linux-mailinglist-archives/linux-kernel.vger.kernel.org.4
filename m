Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549C568395E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjAaWdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjAaWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:32:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E81976D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675204375; x=1706740375;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b4lVzonjR6zsCKyTIxbKsXaMfAs9+b1S6DKM2of6WQ8=;
  b=EIIplk57cyMW/POd6qv+PosvpunnNP+TEwcDAt0gWum7aVjs8sxQX1Sr
   H8gHGxJmI8jIWLtoxI8TmLy8MhgA7PlDeLs9R4lzomdqahYxf0BIbF/A1
   uoN3Nw3cZn0ONwGBjSBg7hF2gmra492Q9NJeZ9DqyBJvrOcmIIGjilrlY
   cIw7F89Ka+o+XanEa+i/WRtGHXPC6LhfYIVyJSuETwdcWr8gOw4q61e5f
   kq6p8Vp0OZKgU9tJQ8hV59Dt7Qo3GMBM34CRPGP+eyDaF5BSXqRen6E8x
   nGznNKNQTrYfPu/JI8rFlg3AmpHok3o63hRpncvIVKeiT5y1FFhx9pSbi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="325677751"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325677751"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="664655695"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="664655695"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2023 14:32:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 14:32:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 14:32:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 14:32:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 14:32:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlKwfex+/4sN2Y6tGGB4JppFJQ4sp/P0T0qCGPgNYeN2Qrx4A6wN2yGISJbyBd96vzt7B2PIIw3iJThUe9gmjKsxxUHhegEuGLHbFcLBtW1VU5+GUXAf8n9a825Lyl0t3iekweUVi/hq9dOfjmqItMOguq6OB/XNZmzQspKVVGqr+gGUR+SXwCby9ZTp422sh9Uk9T9eT1cwCXWwXEuUIH+LaEF1V8a0ULtDK42tv2RgEzWBnB2Enztq4HCpfuYERpzkgY8RhNrNtu2O+LI+5DOo6Xk6OHNdakI+HZZkbnvtFkF9Ry0WXQ29Dx7bgTArgUMmj5KQt+M3+Oouv/PGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNDr/lbWejpgbaeZyjt8D7TYmXMVResFBJiYnjO5Gn8=;
 b=j6RgoZPKXfNj9gNpsnssOgkvCqYKpu0YFvIiWoxj/o2Up5Dx8hzXZlClwmpUMyP0fekvgqScn3b7wyihDlOCiXjFHXRAmOQIx/ciuASebTvS6FKn4IiUZVnFkJpSWZP7uRs94YECXAEz2AfsA7n3HS9TIYEeX7QgpmU0Ca5wXyb4fclxAoloDlbC8bQtTKHBwVZ6hQoqP1ycbNL2BSAJL9Vc9dTRD8VSA8oD4qta0hNw4LSB/eFnt7cnkTvmp/2YDBZk1IrYjkbgJdrDq/4kjlZhLrQ4k7y3qcfu0cAirwijFmQh12qqbVAJ4Jgfh50k1LdVNCTHQinSsMiCSFTtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BN9PR11MB5308.namprd11.prod.outlook.com (2603:10b6:408:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 22:32:45 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 22:32:45 +0000
Date:   Tue, 31 Jan 2023 14:32:12 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
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
Message-ID: <Y9mW7EiL/BpYFLWn@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com>
 <Y9lGdh+0faIrIIiQ@zn.tnic>
 <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9l8yGVvVHBLKAoh@zn.tnic>
 <SJ1PR11MB60837E6E6AE7C82511DC039EFCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9mDYMASXCFaFkNU@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9mDYMASXCFaFkNU@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|BN9PR11MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: a5048ff7-f3d4-44d2-00d0-08db03db12aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/TyzsCVn8o8FkXYKZsrm90PovuaIV09JJ79veZ+Wh88p8DmMeFVltbuF/sUXLzyqYeF+9FRXs0Eub4Mp73lWeMgZN+EN3j95x6D50+O0NifKS6M7DSkCJtJootIgTy+ic5lqoAtBSkwQ8ize3JLTD+9zlvWBV4TVvU8EGyF+rcskCnLRnLjoLNWrteXVt1lH3UbMP281kLHI4Q1Q25Pnbw9AQToWTlWFNfhKHhcnu6DQsbFTytP0h5bJ2sqGzQrEfCzVAr1StrWTtWPeZhtMcJmmt2FjYfMcShphdpLlOiH+43Kkua1RBZYmTyP3JbKRGDp8AJPsMZ+0GqL1I6AvPLIlqEuEEl30OTjU+FwWn1Jxni3WhUMm3kN9nWOVIe6a05sKb0y27x/knQCO5teq7c220sNaG2WXiu0ky8F4REHvSLys71+fgm1ganqbPkMLD5zz91z0znKUraHghC3/Pv+XgBFgrMcMzmn9XsZsb3Lbc/e8QE/akxM0i278m1LlbK9/unDI9HuOk9MM0fpT4G/LJzKc4i5ttQY8lU2Hk/65p1DNX2je/u7tx2AAGwhMqV9oqLPq68426yDzwd4Yl+ffO8OCjOSXHgjkljwt49APCUVC/FyrNBzP/rp9Jm9LelYDOaObJXGp3dezgxHLPYCqBwi8kiOtvPAN7nWewwkyWDFxJSqpl8mDuX8deyZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199018)(6666004)(41300700001)(6916009)(66556008)(66946007)(54906003)(316002)(8676002)(4326008)(66476007)(8936002)(7416002)(5660300002)(38100700002)(86362001)(82960400001)(6506007)(107886003)(186003)(6512007)(26005)(966005)(2906002)(44832011)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OdMPL8yxp7jA0c1brhWKMkQa429CKW65Bd3J2yM3snCN8Yb66CU2EL2MY1Ci?=
 =?us-ascii?Q?DeJwEvLuDXM6V4wUkiehF4sSCwhlkscULu7QdCnN5bYY5YS7HMO0cY7DXUOp?=
 =?us-ascii?Q?IMBb5hs4dmawT28XdtgYMFz9oRW26+dXvfbaqoBLGwvdUVyfPx9pyg3lipzk?=
 =?us-ascii?Q?5wki4uESIi7PCVjpdqCSsRaYuwfWQ0KgHM3wnCrGijgFHAfd5sSZIC6VuP0r?=
 =?us-ascii?Q?wSL42xo+xBFJ1GB7hnPcRRwlGxWfgbc870TaS3S3hHyaW/5s9gARyfnOLvtr?=
 =?us-ascii?Q?ND2G3aB5rGmdQz9EVhcgd0BBBI0mQs34b9U8/eljWbpD+edUlrFMei7qadFR?=
 =?us-ascii?Q?Z4qco0A+rE10czqeoKJRx1Oq8/fGiRFmqT7/R9MwgPKMIM/62qDiEz7tzwim?=
 =?us-ascii?Q?2p7DknR5nYXroiIZRVyIE6S/49sMzmY/j0CZsh4ASG9ja5dFVg9a4ppP19Fc?=
 =?us-ascii?Q?ekwmSEaur32UdvyvoypOmBDe4lG/0FRCfoRMo0EYa03KQAVSADhBEFKE9C8X?=
 =?us-ascii?Q?/yeZvW9Mn1+F2Ldv9amacKpiINFEwjoBObYggM173O5ut9NIzSixCrmkoeFP?=
 =?us-ascii?Q?uriZMaxsyoZxwZW3d9kyEdON9zADnO2gs+UkW6Am8VXP1eJzVUVkpE8xk67C?=
 =?us-ascii?Q?bY7HML58G5/vNbdg2sFUwE0jCegUyoYSQzmoAsP3sBVTnKb5MGcKV269Gcu5?=
 =?us-ascii?Q?mWDZdgNZKrNqAwbi+l/Z6l/8aIY8gcNvELc9ps9qelUPybrGKUZr9jDc1LZE?=
 =?us-ascii?Q?mEpePRycuUpC6H9ml70nMpCj8MM8wfS9b3kWlbzaOnnfqUBprEvl+A+JfmVE?=
 =?us-ascii?Q?lpLuExL7DpGoxfDVIsxlLaTNCxrJwbuvRuZH7+GILmAwtvZ0LsbrtxMaoIlt?=
 =?us-ascii?Q?GeiIcZLNpapGVXt/NvxiZ2hZ58Fkq6AlqD0GZHEBqnCmrmjp9/d0QEL33KC8?=
 =?us-ascii?Q?n6QZ7TbxFkZqM2R4iphkbLLSyeuMZT0/A70p4J0RPvXLnmfZSi0AN6fDzs28?=
 =?us-ascii?Q?KMnbTyUORgZZoyFMJF3+ILb1+kJV8UV58PZF8b63jU+9Sf95BEe5C6F/MI2p?=
 =?us-ascii?Q?ReabQMulPhUlQqB9iCKOMsRSUjzoS1qm7af5H/AuvdoLjVgutdJ7dMcbbgqt?=
 =?us-ascii?Q?y9JcZ94Jpeom+DUOw95snP7DPLYyxTFegN1gU3tuxYaPSRd/NDjPgCNyp0ES?=
 =?us-ascii?Q?hVhQqzAQDlnuX6BLHYoK2GnmPqjxTXs7FSg75t8RlVvAJsyJ3BdxX1MiYpJH?=
 =?us-ascii?Q?vIyboBpjAYaqx1cybzLEWj2bxh1xqd27P1khQyei3fR/EADN8Sd4evJhSXVW?=
 =?us-ascii?Q?grDJGtZni9pwRrvAf/QPfkee3uTb9RvSG6fqslS8dKXF95jrJifTMkSOZ22w?=
 =?us-ascii?Q?SN/PRWVH89JTj+8ZH9rHN6a2SbIcV825vAvslHelE77VOyPetssYyuycDY9y?=
 =?us-ascii?Q?dX1/Zw2sH/fl3X3Wzmc+yeIfsZpsLie2OcKj/edj5CnJJ7CIDPIx7vi9ei0U?=
 =?us-ascii?Q?zF1AYGJtauxniUXq9ZTVI4bqdNvI9Gx8Tb1csxys6r02o7WWS8z8vGohfz6v?=
 =?us-ascii?Q?ta2D38UngA2FkYMuXdI7rOM7z6PItRhmCgylg7F3SJO4L+HrsmZZ07/KfHTB?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5048ff7-f3d4-44d2-00d0-08db03db12aa
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:32:45.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hn/8+hfGNscZNs9OlYG5iVW2ozY2d5OSRD48sFQzqpX1jGpZf6LWqwIVmeEsXbIDG+jmhdFAGz/ZjxEjHULQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5308
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:08:48PM +0100, Borislav Petkov wrote:
> On Tue, Jan 31, 2023 at 08:49:52PM +0000, Luck, Tony wrote:
> > What happens here if the update on the first hyperthread failed (sure, it shouldn't,
> > but stuff happens at large scale).  In this case the current rev is still older that the
> > the cache version ... so there is no "goto out", and this hyperthread will now write
> > the MSR to initiate microcode update here, while the first thread is off executing
> > arbitrary code (the situation that we want to avoid).
> 
> Lemme see if I can follow: we sync all threads in __reload_late() and
> once they all arrive, we send them down into ->apply_microcode.

I was interpreting Thomas's response here

https://lore.kernel.org/lkml/87y1pygiyf.ffs@tglx/

---------
#3

Not to talk about the completely broken error handling in the actual
microcode loading case in __reload_late()::wait_for_siblings code path.
---------

I thought sending sibling down the apply_microcode() just to update
revision might have bad interaction, so revise this to be more explicit and
update only the revision number and not have any other intended side
effect.

Patch3 was a prep-patch for patch4, to eliminate the call to
apply_microcode(). Maybe that wasn't the issue?

It's likely Thomas hinted at somthing else and I took the wrong hint.

> 
> T0 arrives, and fails the update. That is this piece:
> 
>         /* write microcode via MSR 0x79 */
>         wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
> 
>         rev = intel_get_microcode_revision();
> 
>         if (rev != mc->hdr.rev) {
>                 pr_err("CPU%d update to revision 0x%x failed\n",
>                        cpu, mc->hdr.rev);
>                 return UCODE_ERROR;
>         }
> 
> We return here without updating cpu_sig.rev, as we should.
> 
> T1 arrives, updates successfully and updates its cpu_sig.rev.
> 
> T0's patch level has been updated too with that because the microcode
> engine is shared between the threads. T0's cpu_sig.rev isn't, however,
> as that has happened "behind its back", so to speak.
> 
> Is that the scenario you're talking about?

The fix in patch4 was just attempting to not call apply_microcode(), since
at this time the other CPUs that arrived in wait_for_siblings: have left,
doing an update when the others are strictly not in renedzvous is the
condition we try to avoid.

Again, maybe this is me reading Thomas's request incorrectly.

Cheers,
Ashok
