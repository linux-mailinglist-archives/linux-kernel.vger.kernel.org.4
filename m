Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1760261EA25
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 05:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiKGERU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 23:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKGERP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 23:17:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A22DF10
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 20:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667794634; x=1699330634;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6cG4z8vZ8T/2Jx9qMRLUUV3xn3fI8LtUSSHLRdk9w7M=;
  b=MyEr656Bk7bft7asDzRDDeXcNWdj5cbwFFxBosqL5Hb7sQAhJ9Fqn0Bi
   1Z8NegBuwXDoD/KDyrylAmJvJAUp5uF+MxDgjIog7dwSNW3+dkkxEMP5D
   Saqj2luWrj68CGRNmfaxPjKzTQd+yRKRt9DWHndcMpp37GvAEGaJTdStR
   adyvywXgDGNyUmx3q8eWrk1Cw5v9jgD+nibBNwfectVEyPfxkKEMG0LI5
   0F/vjI/pVKXniXyFYSHtvuh49AEti0/R/pZBqgYEryZQ6KKKFiAMa8fRa
   yBsf6beOf1hfKh//wcvshLCnzert3iaRWABr8BkMgYqsRln44oU8b2Fk5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="290710074"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="290710074"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 20:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="810700565"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="810700565"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2022 20:17:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 20:17:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 20:17:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 6 Nov 2022 20:17:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 6 Nov 2022 20:17:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxDAMm95o3EfVidoiOkKrlG5DLs7tL6hUSDzyBLq5lk8XKzTpIFKp3It+nf8iOe+uxFoQ2SQhhTU6XMOWcRyMwhs6XY5IuByvGzHEG8oglGI2+CFln7pv65dzQCSs6oo79N3A/eqKvOtJuDNaA/VPTZ/8lzLtaD54o9J2R3M4DQVTpLJ9LlYeGq5R/x93OS3spQCk6MWHasyEORHe1yuXNFzhja7/e4om0GfRHW9GNVMtrUDBIEvRfOBwNT2YwjaY95WVR2GkiK0PExw3fiZ731dYb5Rgjo80wPoOKSV6P1VUIFTJ9U/RlDPBUXU9fJAByDaIgn9UhfsT8OcFthhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVbKMgMz8w9uGx/aFBa93v1jgohsCC/IGYcMvFNAL1c=;
 b=mGlOS8NUVfnwss7fMm+jNwmEl3DWCMT7itHTRhKYksFeOqjM8uYBN5fAC9GJI8akjyIj4FnwN1mlG8N61QcNk6smOjkiJZnaArXYuK6rer5j0JZzwX1QbxGTo6HLAZHzB4/Mx03+KrpTp8m7HrXBlrRdS7l1CkxO1lsYh7FgcSN6NOTcwSiGyW6I5WmLAKdifebCcbLnO8ik11A0OZ884neR36epyORNis57fmNTQCVkXSg/tNSlpM7lUWz9uM8QMHFNHEaUSYhj9d9rdLSDqSuleDpmgNJ4s/K4uYb2Lk+e1DTSmbxVMrIVoflTincxyl5jlbiSar/akEYax/ryfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 04:17:10 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5791.022; Mon, 7 Nov 2022
 04:17:10 +0000
Date:   Sun, 6 Nov 2022 20:17:07 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Jacon Jun Pan" <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kai Huang" <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [v2 01/13] x86/microcode/intel: Prevent printing updated
 microcode rev multiple times
Message-ID: <Y2iGw8U8JGMJ+aKq@a4bf019067fa.jf.intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com>
 <Y2e4PgwAEXuFzoMd@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2e4PgwAEXuFzoMd@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CH0PR11MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c656c8-1510-4991-6e8f-08dac076f0c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5Bvgt8SsoHdyIpwsPxMfLHnBKogDMLksflevlK9J5CJijtQKfUkBizOjyX6roydZ9w+MMBMq4BGaULw+flxZts1DqK317BFEnZovZvePWmvBdTTIbPsvY0KavuZpW+Oj1qLTVw4M7UAza+ke/+ITIEHLjg/9gdgJsFktSrD/319P7B481QRZAGQUywrKO78aQV9428Acff/YIDy8U3cDFPeMbNub17j0zqtMYHzYKU9/l/1C9Cb+fRzlXZ5DGS8OwwxGYx4UpDlIQ4NOQUUrWSeFRziXfeRbVvLhbYFc66foZqt0/FR2uQqiCo6/R+aW/BFDf+v0rXPGYjFXUQXrsEmwSWSnhixoM1pTAUi9TGg3bcWnjAF8ydZC0qvMfd88axdgErG+j0Xf3CEjYonkkJZWzutaSEOLHOMSvNBpCIjNz/K9pe0Ll6TOdCiyXLlbkGeU9Q6aUqmGfzzpIg+Ei1hpk2cJP57qF8phQz6RuDz1ltb9SysqkNW4wWgHBHP6Ej0PRxOEhi8GHHx076nQOlD2xe46ZW9mIJ9TRR0fW1yrRgAjGlDamTc1vviIdmtgS1K9xh10F4qwHyHpUqMXQrTM4Zf5b6rHiOlZn2LBfvfGjrcUP8nkl0T2KBdncDpzRsk5wwqzAupWOSB2imnOT3vFENoN3xljE5VFkpD66nR8/0fYVtZI5VLz3rItvTSGCCVd+uysGCoYSo3KWNctbqZi74qTVNZDmQJSDtqzURKmf8hW2gX6oQoPxmPVKsTe7Lu7d41DreMTPFjRdmdjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199015)(8936002)(5660300002)(478600001)(44832011)(6486002)(66556008)(316002)(26005)(38100700002)(2906002)(6512007)(15650500001)(6506007)(82960400001)(107886003)(6666004)(66476007)(6916009)(41300700001)(54906003)(66946007)(86362001)(8676002)(186003)(4326008)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nijy5ySB38mnDTIHxSGWVEEe/TrwKfisj7Vz2IB/hHYZyR3WAhfD9WHnHcsj?=
 =?us-ascii?Q?hSXG+vnJkITSj2sz5sZNTSDb8LwkabLJIKeuJfnRO+k+lKJtZ8hF1TRyiEhL?=
 =?us-ascii?Q?peG1wMV61duykCvvV9t3uDK0iseVvr6Rc7iSN3CaXQdEHVFyh895IDjOeWcy?=
 =?us-ascii?Q?oh3gRuylgekULnxxunby9/Z7dKgcQ93wyIp0/b5JiJoiqpTblWSXHHE5vqKt?=
 =?us-ascii?Q?9dOaGgns7HBe/7L/C7GSKCTT7keB5QNuCu+z0w2b+U21yP51rNxnJDHXzK4v?=
 =?us-ascii?Q?fNujunnZY+BJjVnlr1EOZb2ykCdcrurSjeyBu8S/nKHpS2uF4MCjzryigdiE?=
 =?us-ascii?Q?3KCcLC1VmMvnzHf8YLvAHTt3gMwyN1ZcXLoGdly7+Ib/iFqwFV/JvRncWOay?=
 =?us-ascii?Q?25t4rZTi6r7PATY4u/MsPGjs5Rv1RwnRybdn6Bhy/2gCffHiEtE0KJIYxNIY?=
 =?us-ascii?Q?7o0S0z1aWlHKHefCxtxL/FBEQhyH7ZNtfRN1m8WoC2aJk5ExLcg5ENPPsOik?=
 =?us-ascii?Q?Xw6iyvaEGF1Zf0cmz/2qieyWxHywCHRGq8UKEga4OK7cjFkMwhybn3I5mjdK?=
 =?us-ascii?Q?aYlw/btlg5su1ktiu+YOIGwskcWno76GjLH5WUjvXTz1ZJtnuYmZ64LjxH0s?=
 =?us-ascii?Q?DKLWPC1NLT+E5xzcamP17y7fOjDYmSImnMI41r0Mvpj1c9PvE2c10DdU0doi?=
 =?us-ascii?Q?yD4TVb7qzByJF9qVfOYd6xkgu5xczGoOjjvvsssQDv1YnurHHwwoIQUnLnvT?=
 =?us-ascii?Q?lH/GAjq8IXkc5orL0PwJHfro+pxKcvsRTaQt3gWEEf4kv5QcA7dVp9lgjhKu?=
 =?us-ascii?Q?3SifuRa0EcgsqINBb3aBb+lLP13MAy7CV9IAXoRgA3qmIHejOC30hpH+Hrik?=
 =?us-ascii?Q?2hjNYJS9Tkyvd32308+GtirLmaGD/YgYjmWgxsGQWJ/2f+8CmmWds1/6/5EK?=
 =?us-ascii?Q?OrD7VeyqY6FwHOXekUXZfqjiw2diVb/zP7Lyx7yQXyBmpPuwJ7e4sGUIuGHb?=
 =?us-ascii?Q?rj85Xzy3idBOSiAswJBeSEbAn3WbrWC5KoBL41Rjzzx8rSuiNerDci4n9edx?=
 =?us-ascii?Q?TPHwSWWS1JnDUNK3DyJuWtaYkUZdKvvFwh6Nw7sha74rAa01581OdLXgSvlw?=
 =?us-ascii?Q?mpOuxyoq2hL2S2FutNdMgZ777FE6OHFvY4Qi0bp/5Uu1UxgVqz9pSXJ94Dzy?=
 =?us-ascii?Q?rM9FBFk5DrUdTTI+FYVqtQlbvCEW1LmsAIGIWWxtUIeMUBZSZng4kPDoaJah?=
 =?us-ascii?Q?7q6+qRLNqgP+0WDZlsGgEUXWGweKjcnRhwVloxTDO5AUcIBBDOrwB85CFBBT?=
 =?us-ascii?Q?cH3+6L8sz4A12kx91u8LXS2rA283v5j9ik1YFiYRTqTTXaWjO71WSnUq1gmT?=
 =?us-ascii?Q?PnWlU/0pURIol04jHDP57+esMXtoRCirkKAv8V5OQakvvXxHykHj7y+4Wmc2?=
 =?us-ascii?Q?WQ4SFc608ezB2CyUScGDvL71HHqpTkbmDdKXKojasT7FYvzC6YwD4WT6E6fs?=
 =?us-ascii?Q?9ZZ5YZ7Mg3GRdUTU5Jbenj6K8ctbg9jXxnQeEXMBhO7sFqWDAjsJCpHhjFdn?=
 =?us-ascii?Q?QLP8hbwbXdK9gZUF87szBR4it8gKF1cv1ZGXtFrwRk2N+sIbFmp8VEx1mmVa?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c656c8-1510-4991-6e8f-08dac076f0c3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 04:17:10.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nERRkVCR9zB82g5Pn+eHccgAnoui2X3B5Er+LeMi3F/4CpyhKXP0QBMIh1bn9OOx+EEobGYEl+9L/DB15c1xCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 02:35:58PM +0100, Borislav Petkov wrote:
> On Thu, Nov 03, 2022 at 05:58:49PM +0000, Ashok Raj wrote:
> > @@ -696,8 +697,7 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
> >  
> >  	csig->rev = c->microcode;
> >  
> > -	/* No extra locking on prev, races are harmless. */
> > -	if (csig->sig != prev.sig || csig->pf != prev.pf || csig->rev != prev.rev) {
> > +	if (bsp && csig->rev != prev.rev) {
> >  		pr_info("sig=0x%x, pf=0x%x, revision=0x%x\n",
> >  			csig->sig, csig->pf, csig->rev);
> 
> And now that we've established that we don't do mixed steppings anymore
> and the microcode revision is the same system-wide, you should simply
> drop this pr_info(), in your next patch you're adding
> 
> +static u32 early_old_rev;
> 
> That thing should simply be
> 
> /* Currently applied microcode revision */
> static u32 microcode_rev;
> 
> and you simply update that one each time you update microcode and print
> it as the previous and the new one and then write the new one into this
> var and that's it. Simple.
> 

I thought about it... Since microcode/core.c already provides this
information. Only missing part is the microcode date which the common
function doesn't seem to get this. Thought it might be useful. But I can
certainly drop it, if you think this isn't much value.
