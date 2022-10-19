Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E56047F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiJSNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiJSNqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:46:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D49172520
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666186330; x=1697722330;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z8bFrtl2JskPhbJrIB+I4eQjrpVcf2Tm+mON4TidhQ4=;
  b=OJaV0KCewyQRYHMpAS2zxqgBuNAk1x0fcZgJUAHY1xshCigcaGmI2FIC
   jG4vXVgTePF2JcLnb26Kpmv/mgQ7zYwxD4y5HcksFi1YARkwmc7fnwuxw
   3TOzuaeVsPeEJouTkhTNAk8CZ/OFO0IlbcoUuEp8s9E3Dj1yvcfsWfELC
   dDHH/yOVnqBXdyyG1a7JuowxtFyH/15Go9eiK584dUBX/Yg0ZF3n7ADKY
   gOqYPhPW6N8c0IeIoYe9wd4hAKhpdUDSmhRqDmdycsyYdRuAz26OnCmwx
   9yR19GlwnSLNUf1Ehe6ukGDXek0l5JpIIdnPHXnNCStJJMGcfjNwa8/ii
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="304025799"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="304025799"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 06:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="958339022"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="958339022"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 19 Oct 2022 06:31:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 06:31:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 06:31:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 06:31:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 06:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSdVCLuxROk2+UkUqhjgrDpGXG2D09eduCP3mDf3iYD0U/AbAKeXhD03DFaoag4sjDYCGeG/vOVNma4S/YYS3GulrjjKg81n46jYA55Xirt56cC4pBiTob3iury6HACk8WHMLHGZftz0sHpYkGGQIquWk2lHeNPA46kJnWTYlN1EVig+L0wKn9uAQ6AM035Zl1tesAbQ7+NewdT0+pvhrzJGOpIjMOSjLuSHUjWbjs6u2P2ItySDTPGoe9BIMGwgG725JWh9sfVnsCNT48aw7ngXkurqFwZkt0m7C+0T/Sj1zfgO7yhNIUR7y8M8e89NdG6ZCffPimBWDl4CP9mUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R//G/pjQ6nRcanhe9tc/ltR1HKBfLmvI/i4UZGq7ays=;
 b=RsjljfsvBnxHxNLMA7VZaARa+mWis/9Srw8duUJL3tFB0NIjdtLmn6MZcmZuwngIuLXaunUWC7vYpzmVlypYvYJSIIjLWVra1BAgUgga/DhtlU7UIVLTZcSBDhUghAmK6yW6BY01cvaCipRbhywVJB0Yz5LarYoFQVs9x6+UoXYfkjfu+tnxRyLTHezBHNPQrd/J5sVWW7gocXXfVUf53ql9aF3ZMF8mMx+HPmTgBKXAlDTBesLWUikxUKwvegFuxCdpvRnFDvyEtgIiwvKvjYFIhO6FS2NSM/0Q7b/u/yQkpyFfH1QDb2K6hvUDNV9mXsjJD/nqofRkrPUh+dYTxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SA0PR11MB4654.namprd11.prod.outlook.com (2603:10b6:806:98::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 13:31:21 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 13:31:21 +0000
Date:   Wed, 19 Oct 2022 06:30:49 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 01/13] x86/microcode/intel: Print old and new rev after
 early microcode update
Message-ID: <Y0/8CfGZPZ59OoGH@a4bf019067fa.jf.intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
 <20221014200913.14644-2-ashok.raj@intel.com>
 <Y0/NcChbFK5m8jl+@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y0/NcChbFK5m8jl+@zn.tnic>
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SA0PR11MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3977e14e-0114-42bc-a246-08dab1d635c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/sQLeUcbEpzEHXGh6klmoS7HC1bz+pbgObfvaOEJUTTS+BpfHxd7IXfl1VuYyQqrf70h5Xk7Ojm7F3QQDCwwmw3nZrAAXd2IRzpbNYzq440KZLeh3/lUkLg0lnbcIOo3FkXJTG8igkpYVFTLxLOShofPHxOtzb6Pikr58tIouPfNitYzXoZIKL+vcE07WJ2nN3EJwxpbUfduCeOh2XFNoFj/MgiV3a4wFl7S4ULau26hK08Bpuw+/ih0j7+pblyd9vAKeRfjFOxjukfk5dCqmIH71wnafsURTB0H+T+vBexMfoSJoOG5zWMyqhVCfLByVj14beb2tf93hgwR8MhDE3KCTB77IcsaU5AchULLFH/qQzv2IFbpDkSzWFqMaVSHpDQQESndfCK3VmUEJa9Tio3ycceyDNdshSPZEoUT7H8oGqtY6pphV38Q0jJlSt22C+TSkqiTY6dI7f3JCN7sEI5bb6+Np70zvn2zjYTPKSh997oxd3riMQJU7nnjwZkl8+L5t6tbsbQdp6Fg3oZmQk9RjnZL5RHDC3YSsacLQWUIRDWip2YFurhx3W8eHh2XMyByopunK8n5X4MkMOrZVs1lfUMKocDUbOpXURq11+qZiczaBITsxT1d2OiYOq8hm33t1f5wemNhgftDgGbwukk8sO7Bf4DBQoHiZR6YiLtHjuz0P9LpsoQpRCIP1ZnNSB+4R6MSmD7IK3WsB8anA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(396003)(39850400004)(451199015)(86362001)(44832011)(6916009)(54906003)(8676002)(4326008)(66946007)(66476007)(66556008)(26005)(83380400001)(41300700001)(6506007)(6512007)(5660300002)(316002)(8936002)(6666004)(107886003)(38100700002)(6486002)(82960400001)(186003)(15650500001)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVDw5i6xoPtckpYldwU4yFQwLn27xPEaKpAY5APAafjWmYRSFGjftdEWMbYs?=
 =?us-ascii?Q?r9S+ynE5887b/zynvnkoq8ZnOTgNO06p5sRVeTC0jlBAt1EH23CsawQ4IIo/?=
 =?us-ascii?Q?r7oMiOXeR5+fwbjhqQdGwfdRxAyvGW6aVzpN606R8HoWaRiAs9vpcHcGzyKh?=
 =?us-ascii?Q?5ugej4a0DjF6wv4kvF/yAsLMXKKb+QDHHiqAkMStRUbNJIS1VAgXKDqld6dy?=
 =?us-ascii?Q?IEF2Yt2dLC67XtDgiiZFGCe6eHomzT2iwM/ki+CEqc3eRmgT4SQOOlxm3MKn?=
 =?us-ascii?Q?nLboo2iQV+tKJHZ4iyAuTOdvMKYPekHbyZJ2SFDKedJC72URITLf0s+WfAaN?=
 =?us-ascii?Q?bx509UfWYFU2L3s6dnsbrkDHSd6nFkuH36xDxziVDyh8YZyoLdb0P0ReIyZI?=
 =?us-ascii?Q?dAfOUdhsLa+86FPdtSbsfJeo7VDUrxPQmwKjzTxCyBJEtnrL2hlwpS7IFA3e?=
 =?us-ascii?Q?AfnQkvU48uwr6Z68NsaqevV85XJtCDsDDrdmaBvVLF5lOkLs6ZL0OhdE/7DC?=
 =?us-ascii?Q?RtUXrhPfWKrt/YAjDe+oyfHZsDnka6bBDCASvH3P5uUdNA3YKH4QRbIQ7riY?=
 =?us-ascii?Q?JpJYy5K4i6oXJ549vZBpKeoNZdbp8Qwys965d76xg/hm1jmUSzPTnN1b17Nm?=
 =?us-ascii?Q?6KJ6Ach31T9wTXfpeMgy3cn2AtbWGVSIhcXCiHEqX4z6iIrB7liy72Bl+Jqy?=
 =?us-ascii?Q?ykGnhfnXEc09U0Ylw4wYpCzuWgBz24dFAjl6kplDUKT67dsTU9J1uSlW023H?=
 =?us-ascii?Q?Z4tkxEFexkDzfOOoAWdAl3D1EpVCVgx8sniUWwzPgDqeW8Q1iQ+Z/7x08zGj?=
 =?us-ascii?Q?OmCNhL4ctJAacrZNdCDi1+U3WPXRq5u9DrmMUex5n2cJjN/sK7eRB660ZxVw?=
 =?us-ascii?Q?ZBxcrnI3Xwtq7hyiHFsk7t/LjaYezQSzg9KbNFBUBUSsk1z6p8JJuXXoP7QU?=
 =?us-ascii?Q?gARiQqpFcJp4OGdoQ5Eqb//nmJ3tqqUnVZBvAvuk+siFXOcACZgrCbreGBmp?=
 =?us-ascii?Q?Fu0QXcZRJgRGLmRHB8gannhx3mgpNKUqf6WULnt1zIV/QTBM6fO15DAxWA8z?=
 =?us-ascii?Q?ftPvtf7jv32lXf6Op7GD4Y9o9t/oRhxnMOwqVjuEl7SMz1eA4pGhghE+5Jr6?=
 =?us-ascii?Q?B0WDjuFAMWKDrAqUwFjgd31BtNpuAlDi57aq730mbI6Y1S/1xdew8K+x4btp?=
 =?us-ascii?Q?bNX79iKzQlK2OXHUle1AuPVUi54QPqlzptGkFMWP6okJXNdiJAj82wStB0Cl?=
 =?us-ascii?Q?KBeXC9SlxEAvaMDkbjV8LXWMA6FcyfMaOowkvWlLm5mCvKkHkAlFR08vEIxG?=
 =?us-ascii?Q?kymTF4e+J3XUMLjYC57G2mJIX1wq/gbyKcH7S+Zp19VtWxH3HqLkvgCtHncJ?=
 =?us-ascii?Q?Gv4T7Tsgiv4BvlDnvufbRIq+EM2FBzrwis0uAyc+kHm1EcfG3exCmViOMlRa?=
 =?us-ascii?Q?M14n7y3+l/KDaW9im/xrapLejlLfIuy9q1AZgB/3cg9bcWd7Urv1GTDgcxO7?=
 =?us-ascii?Q?no1+B8LHdxu2AACOFOc6fZWpjsYSYeM8C06W2wuv2WX3pbBPVB3togLUh3Wb?=
 =?us-ascii?Q?Pv+s1Q3D4O8Z1xXaWuAh3CeGPTNRx8KXG1v4XB8xj085eJga01AuEUDAMUln?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3977e14e-0114-42bc-a246-08dab1d635c7
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:31:21.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xHJf4Z+zIskRIgb4ZMJnAoPmNfadEyUPMu37Y97NVNMPANW5Ur3wKZ5yjfft8DXnqnExWf3vnl1E4N88EPOnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4654
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:12:00PM +0200, Borislav Petkov wrote:
> On Fri, Oct 14, 2022 at 01:09:01PM -0700, Ashok Raj wrote:
> > @@ -435,10 +435,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
> >   * Print ucode update info.
> >   */
> >  static void
> > -print_ucode_info(struct ucode_cpu_info *uci, unsigned int date)
> > +print_ucode_info(u32 old_rev, struct ucode_cpu_info *uci, unsigned int date)
> >  {
> > -	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
> > -		     uci->cpu_sig.rev,
> > +	pr_info_once("microcode updated early from 0x%x to revision 0x%x, date = %04x-%02x-%02x\n",
> 
> That already has the "microcode: " prefix from pr_fmt so make that
> 
> 		     "early update: 0x%x -> 0x%x, date = %04x-%02x-%02x\n"
> 
> and fix the late update message too, pls, to look the same without the
> "early" in there.

Good point, Fixed this.

> 
> > @@ -479,13 +481,15 @@ static void print_ucode(struct ucode_cpu_info *uci)
> >  
> >  	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
> >  	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
> > +	old_rev_p = (u32 *)__pa_nodebug(&early_old_rev);
> 
> No, you should add a
> 
> 	u32 prev_rev;
> 
> to struct ucode_cpu_info, save it there and access it where needed.

This seems like some 32bit restriction that we can't use printk early? I
wasn't sure, so I just followed what was done prior.

Today it seems we are doing the print just for BSP, not for all CPUs. Just
like what we do after update. Do you want to save this for all CPUs in
ucode_cpu_info[] for the previous revision?

Also its weird that cpu/common.c calls show_ucode_info_early(), but only
defined in cpu/microcode/intel.c. There is none in the AMD side.

Do you think we could have a generic function in cpu/microcore/core.c, that
calls vendor specific calls like the other early functions?
> 
> Then I can do the same prev -> next revision dumping on the AMD side.
> 

Cheers,
Ashok
