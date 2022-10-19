Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58073604BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiJSPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiJSPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:42:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B4DD0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666193920; x=1697729920;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nfUitZriNjIpuBH2mg/ariMUUNHy1bXY+WrWJoNmMHY=;
  b=faNpWKlq1dBGQSfkg8RjzIbnNlL8Su2qjC9kohfcboMAVocW/bKF4Evz
   7rsvUX1hF0NdXjCE5pg2xYHjz7xGjZB9pp7LPrGWvjAdyA/v8EJXGvhqf
   /uKgEPWwpXlPTXg1xZ/NAmHF6alu3xOdQ5hsadkeJH8dTw6hnezTMX35b
   7H4yaA+kIMGaUtcsi9akKtXswx993PK5COfLyYNsG88IZ40TtHinnq8Z6
   Ns79zzs4WioEzQjrgcI8SvxS+4TFZCZjFtMJ0FLWWQWGRURONuGP5dRWr
   i+gYMu4m+WPCiuBzucaTMk4PxqEOsGkV+A0qWAceYnUxefxWkgXHYmGAV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="305180760"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305180760"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 08:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="874487556"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="874487556"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2022 08:37:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 08:37:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 08:37:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 08:37:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 08:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcg/P1uGeurlPdr0+iZ26r1M/1Iar0tFezL088mZsqaoe5mr5Fr/fKldGO2pBz8ITvT7M/GY9wBtB4mgzPYV1qQ8fJk1WF03gqd4V/VFzRbbCXo0G4aYz6j/NTNsZqTwATWO0WWngZzxiuLQuaBjolZYpwqgR+nczLrORh7rE8efXdFJ9r0A/4pYdljRtB8EIxlJhDWAi+M1Qlgqnj1ock0aFVCZqLbrA9zMrbQl+6ux6rRJzQaNEQAljpsdtK3+RXtUISKZdeMCVkq8gUJPiktB6+x2G1ngdzhoq6mPYau3E6lZ/qM916QsfrOzdX/TMznZXeKdAPUnCoV21I4ffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCVYnpVp84Nua2Z6VU6/9AVmfGBtRYbT4WIIVSxXPt4=;
 b=lQy+zPAp3GFI+oP6W4cBoclhrV7O1PbEodxhNDM9RE6nRirktxzmA8rYKYXP2r9WwPOSyJ/3g+/+BXhfkKGO74Nae3QTIn7otZZufivgliBYnZ7Hj6Q26P+TIMyfzwsA5AcjITdLob2vm4W7zxBA0Zp+lMPP6hdXKhOT6+dUweMpB3xlYO4jauZ0KsVBJu60GIVCfkGJN7hQ2c7jeT76RVEv1Q+aKwQsMnzlqpMtNwJ97BP0MfVkP0AcdK3CqEJhMP8SKk8oganHJfaL7INeohSWyxtYwx11AM38RRc5T720fEgjRRF1aoJ0UQVO86JhO1K2IgsKz0FwWYyTBssqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CO1PR11MB4786.namprd11.prod.outlook.com (2603:10b6:303:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 15:37:05 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 15:37:05 +0000
Date:   Wed, 19 Oct 2022 08:36:33 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 04/13] x86/x2apic: Support x2apic self IPI with NMI_VECTOR
Message-ID: <Y1AZgWn5V/bTMAg7@a4bf019067fa.jf.intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
 <20221014200913.14644-5-ashok.raj@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221014200913.14644-5-ashok.raj@intel.com>
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CO1PR11MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: 50679aa7-4f69-4654-fddb-08dab1e7c65c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aUOKMMFpnSuiMCe/IbpvT0hP54GyOiLdyxVgP/vcZ9PToEvXIKDTPWe6ZO+xQP+59s4zL2lIvj07Zasxkjiye7FrxDDwE6pW/EG7q9Hhfh9Un3wwy3Ra5olQmnXbcXxVcGqxwyaTBalszB+iTSDXGPhz4P/nu+WflM8JDZsXsjtODe5QQMr9UWWSHsNnsJz6d/ooryiDmOTRFs82GD/xCMsrazn0yPEAZ+ep462R6EXubNTabS+1bQ8mhjp4KfzfU5mZzRvjTkgoXiCEJGCNTmJPznfQXV1FQWHciDwRa/chfvp6261GUZfIJ2iMr5NLHrvYG6tAA4uITZ0RRgAOWERdV/lxNZSUKmJUTfzu4kYMCQPBTIQgVA9W3BQdRFd8BPUyOCbW5wiDj5L9JRjVDYzw19X6oc3HJWDZAOH+vtD4+K9WeYFdrfWuFlNtBQJHQnqLOtheb5XuL1bk1LmdJG78Kmw3IcG86XcQkr/us+NEv6V26pZ1lD7/fT3aw68RlHcUIxFCJ6CldlGezrs0DEUPp29c1Ovl/5IJajxj1S9+wRC0qMH0dC6/5C8O4Ur1yvFTTWPGlMz/4dfW5Sfsvq1ZF6MBW+Zwco3kHaRVfkD3QfpW6X10Th0cN//81iBIOoP00sKTvJmh1FEcb9rokJhCIpb490rl9+J7JB2uAim5ElfW/ZaKR0VfSLnwDpsCrK38jPzRQdxMoX2k9JfWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(26005)(6512007)(6506007)(41300700001)(44832011)(86362001)(83380400001)(54906003)(110136005)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(5660300002)(6666004)(316002)(82960400001)(6486002)(38100700002)(2906002)(186003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+cmuhTiWWtD4fCS6f7Sc9aJq2fqnv/AgDcqwOowxG101m8YEcxkzqMEUEVj?=
 =?us-ascii?Q?AO5eNTYaNOjyt6CHp7mgoTwEhuQEaL3ORGd6SuZa7Q7PAQZqmBa8/Ke+2WRp?=
 =?us-ascii?Q?udgANAV9MSA8i1XScvEhBQgJ8r/hFhggPeg11L8IKWKQz46hfID2aZl5Aks8?=
 =?us-ascii?Q?3qHNpS3fNgeC31JKNfushFPnDTjbRRejhocYxAtgcTQPrAbulG0CTns5HC1d?=
 =?us-ascii?Q?/jX/tP1Sugs0Njf/PQg/XhXZ1PNyHeYEkfkJmrhhyeT3b/fJ9dDLB8i20LMs?=
 =?us-ascii?Q?voKmufepL3A7Y1zMGm6CAC4aFt4Ge3eD+nIBXxQQzSxD8QfXMVYO6YIvcGwL?=
 =?us-ascii?Q?HN429DdMJDBkbhuBBXeBT/TbCSXerW1isVu9eoSBxVlzI+LvgV+eYE+KKO8I?=
 =?us-ascii?Q?mnr903xE7/8XRmJ+tS0oOpNHrAvEUEM542vCAkG5/SChdeXw6NPoLIhebFuF?=
 =?us-ascii?Q?IfO0wh0gbWVosoqvW0k7xfMaBIQVYvb2YZQnfW5imp5G2FlsWrlgCzXvy+oU?=
 =?us-ascii?Q?yRi6d1x71lC/Q0vUYOmm9RJiqChCpvc/KTpkZblYkmwrVBmZH5Rc6mq2sJ+i?=
 =?us-ascii?Q?FjWOFa4r1wsz/sIgX9AbIs2iImqnRvfiBx6nc0N8aQ4+MZ68npXq6UCuGsoq?=
 =?us-ascii?Q?BQwYdPS/qD0dhaoW9Vl3IxnlGYJbrg5TyZiiLTFpkLbOlOvNVHhEIi7dpvos?=
 =?us-ascii?Q?YfVp177oW9Rmy/BXEGHpPaPJQE4Ohw+gGsm1ty00bmYHvyEtfpvY/L910e/m?=
 =?us-ascii?Q?g9Xt5u9pO+kwamUx2sqrnwD5YzSax47ppaSo5+Z0HKwY37B6KNiB3sIlEgZx?=
 =?us-ascii?Q?saXc8YZm6VidTzmRd99d53MfbNGjfBX5mQQCXPqOid6OJEj6qnMXphQSK7An?=
 =?us-ascii?Q?dgr5O134xWKbZ7/8HO0t6oAkrw+Z9GqStTo3V17beHVqY/RfkJbn+1fU0Twe?=
 =?us-ascii?Q?MIf0qFxVypaq1PPhjdN5KZXKyazANRtoXD4IY8VjdjCblz0FFjRZ5t7kWxCs?=
 =?us-ascii?Q?9norbtX5jo3scuKVopxDhEdG7nu/OcSWGYCSObPbDAYXjsIMWhfrOMlmxHKO?=
 =?us-ascii?Q?Jlelf2dygSnqJcPBImxu5JaSeZrtVG0DB/u5+tsDs9hd7hystLnrNfxFOX6q?=
 =?us-ascii?Q?zR3Wm5Qs6btwJtIYbx0QmjaUSE9ueP8k7pSom/DozCB4ObG2Y8tQpiGY2NEn?=
 =?us-ascii?Q?k+IBXgtWsjnXPQJRuZOwhhTWPc7onTGTgO1NonHIAs4bR+nIOQZxH0TnhM0n?=
 =?us-ascii?Q?/y33iT81o98AhyGhRzVKkFM8mVq4KAMoEii7tvWlKChIAQcF5dRIZKy4CEVy?=
 =?us-ascii?Q?xkvSCmoVTfnJvaQKHnoFAGM/jFkVC7ds5VoDRgw1dgC1i2OWtPZo7dVMbuyA?=
 =?us-ascii?Q?6Z6aFzbtR7EUyAyvP24u7Hdc5rSCaOW7CJsqlPnY3ad3eLgkVWjk9WSdCIa7?=
 =?us-ascii?Q?WbH4vqllPPvsPcO7SnimzSYJb+Vr79xSSxsKju49eNOp1FKKwIpPigYI0AhI?=
 =?us-ascii?Q?YdTSGdcjFXxNpkDH745SrT4OtxC4PWX1ugE/JW1mwcRbab5ktfnoNrfQ2QOY?=
 =?us-ascii?Q?SjcEq+mw1DdjATytzbOKEy1bDuow5/0PUDBhY+Cpp89dPXsX8wojN5X4kn7l?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50679aa7-4f69-4654-fddb-08dab1e7c65c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 15:37:05.1141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8OQj6SqOLH0ELexMVrMqPTojFDjXCQuPwqYpNafYUOXzn9C61WZzPaicmZPLJeVQV/GdpQ8hWWUBbUw/JHpmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4786
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 01:09:04PM -0700, Ashok Raj wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> X2APIC architecture introduced a dedicated register for sending self-IPI.
> Though highly optimized for performance, its semantics limit the delivery
> mode to fixed mode.  NMI vector is not supported, this created an
> inconsistent behavior between X2APIC and others.
> 
> This patch adds support for X2APIC NMI_VECTOR by fall back to the slower
> ICR method.
> 
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Forgot to add my sob here.. I;ll fix it in the resend.
> ---
>  arch/x86/kernel/apic/x2apic_phys.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
> index 6bde05a86b4e..5f533b76adf6 100644
> --- a/arch/x86/kernel/apic/x2apic_phys.c
> +++ b/arch/x86/kernel/apic/x2apic_phys.c
> @@ -149,7 +149,11 @@ int x2apic_phys_pkg_id(int initial_apicid, int index_msb)
>  
>  void x2apic_send_IPI_self(int vector)
>  {
> -	apic_write(APIC_SELF_IPI, vector);
> +	if (vector == NMI_VECTOR)
> +		apic->send_IPI_mask(cpumask_of(smp_processor_id()),
> +				    NMI_VECTOR);
> +	else
> +		apic_write(APIC_SELF_IPI, vector);
>  }

Wanted to send this early if people are planning to test

Similar helper is required for legacy xapic as well. The lack of it helped
test the timeout path's :-).. I'll integrated it when i send the next round
with feedback once i have enough. I'll also send this in the next update.

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 2a6509e8c840..e967c49609ef 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -239,7 +239,11 @@ void default_send_IPI_all(int vector)

 void default_send_IPI_self(int vector)
 {
-       __default_send_IPI_shortcut(APIC_DEST_SELF, vector);
+       if (unlikely(vector == NMI_VECTOR))
+               apic->send_IPI_mask(cpumask_of(smp_processor_id()),
+                                   NMI_VECTOR);
+       else
+               __default_send_IPI_shortcut(APIC_DEST_SELF, vector);
 }

 #ifdef CONFIG_X86_32



>  
>  static struct apic apic_x2apic_phys __ro_after_init = {
> -- 
> 2.34.1
> 
