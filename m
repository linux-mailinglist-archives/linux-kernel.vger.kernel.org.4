Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED15F7A71
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJGPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:23:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB792BB0A;
        Fri,  7 Oct 2022 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665156190; x=1696692190;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PG8ldWcZ5qz3nB+hkof10iJJTsRvTp4htt74ybxCrFE=;
  b=iEhYm8hPRUwyy8wSojKzhYePeAOcG1zWQIuW7Pz1btJY4WfauY+EH0eL
   3liPGsOjyUscoDLLyfBScivcBouWgOAezN626UyNsT4zWWm2QJxMQmj7P
   cOj0eb8oqUeXCLp2IqrpbcpZmFrT3SguBja5ZS1+ko0RhgYFMBUmgVRP0
   EpgnnKmo+iT9lb37EODix4tuGIAt8aMMzFIq+YQlhv36ac3RqQyLl4Crc
   sZmhApCtZKfp+it1A4xjsn7bvjo+1gdPqxrcPV2B36AMHA0kO4Xq6Z9Bz
   hdksJj5MayrlZjiFW3wg2fAHQaSvT98YFL7pOplB4koNfsAZraQHE64uG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="304759262"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="304759262"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 08:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="620282930"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="620282930"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2022 08:23:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 08:23:10 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 08:23:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 08:23:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 08:23:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrXy+n32K/lvT9vYXrAtBUUruq7jyTSajwGY2XoUHffdw1nrl5FzZ8vZ/pHextBlqeu+JZ0ElWa+7aCacbRPC48zDUaeSA3NCPogWlmPuCz+7oPKBlY9txLYRHdQ1gs2Qb9TOFTrwmzSFXZ1uo7dJ07WlTODam/fJVKE6AEOuE0ipsTb06cUjO/ZVaB/gYQdQf305y+hcRbs0ONcg0loy6jP6ljar/LbLkTbNlAQeil0nQZZOzsRISevgg+YUu9pj9UOrnZxaJYefTWNjOAi02IRjQ0mkk8CJDVSU38N/9KeOM8v2OrELFVz62W6BpBZvax6/ItK6Bhwlgc6Ny2o+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXKE8H/A1ka4c2QcWQTNsYvz6tE5Kx3HCcpFfc9K4PM=;
 b=T11fpMO9VQZAwnhWr9jGKyHU9Ncwm/92MKFAs4J1Kh783j+Q5h6w/qzV3FnTxMB61LLytnDz89wGGGFr4hQvI5erVNCrb8gWijxd0mTl5i+N867mz1nLSZzjr3rKEphBuxgbnZB1ePodXt7iMucZ4BhOmsuzGExC2HC54+0kHOqku5OfjYZqAIFQfr7exmEIqNHyDeLiqn7LD88UOIcDrt3c3OCWm5sFfbs/UCRuuBCy9NApdWswL6mtAu1vr2O5ZBKD2X/5InvM7Q6QT1DGlY92R0QvdLKC+w1RN7Gm/XuTyJVpJWArIVgG29JdTJ7+C+lHt8/u9aAGzx1Sbyuprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5943.namprd11.prod.outlook.com (2603:10b6:510:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 15:23:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%6]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 15:23:07 +0000
Date:   Fri, 7 Oct 2022 08:23:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Y0BEV+Xgkrln8xoh@iweiny-desk3>
References: <20220929160647.362798-1-kristen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220929160647.362798-1-kristen@linux.intel.com>
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 39cdac21-6340-423f-42de-08daa877d614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mf4u4M+oLLyLe3yBP4SpbEC08rVJpqKjQq1yO5VDynjcCDMM0JCXi8vGJ9Bpsvpfes4rnD1scC1aO99QftUdj98zWlkKDfPJbu9B1POJ8IICaE/Tk3PtNXaTXE2M0jRemJlZdXCkYw74PHyoVG7bv5IUveSNdLdMwqjgHG/Pdk9Piu/DojcRDnT16BQ90JPjDQPeEXzEEgCFTrZHsB/v6uBRdYsFArssZ5aVfxWURQMaQ0SybHLUdHGVmSUBfy/jOzplzGScWq2tkvP2/7MxfPGVqa0WAXHFDqqFNUhHShP8mG2xxYTKhGYLLUveCO5kBQPPaO/MH8zjSoMO5KkZL2rNIeV/HGvGYJ2pCOtGYnFQ6ssU4QeSv9+rX5fKiCfja16RVL1DGG/fh0hFVwTPJ+H6tWxzbUW+K/xiM9BoRa+9UKi0CJNpGqZLkZ9HOb9vkqIT4fMYZiu1YUErOj3JSS0pWwr1ou1uIADRvDcZnEPIR07X0wR/q7Ygv1ZVea1HR5JcCCSvZckVsqPC6mON4J6MpGs5O7sES8d29+IV+gGEYq+zzrpfGfBhuLAOJ1R7ny0I0XvypwD/+p3onv8hgQbNK2E6kY0VzJUSgYRcxZC1Xb3tSnoC4RB0bIKX44VCSrl0Pskl/vCMumq4JJKaJAIv1MNIQgUJWcEjUn/O80+LUJOiEEd9DDFUbALo+iYRcDvvtUpJnP7sw4q18TkHZwV0JpYpv6wxIRCmHUxnfpZa6FpHfDLamV3TPYgjb+7C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(38100700002)(4326008)(54906003)(8676002)(316002)(6916009)(66556008)(478600001)(44832011)(41300700001)(8936002)(7416002)(66476007)(2906002)(186003)(82960400001)(5660300002)(83380400001)(6666004)(66946007)(86362001)(6486002)(33716001)(6506007)(6512007)(26005)(9686003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDB0IEpa+YaPbz4k1idxcNEtcPPd+ZVjsKJpGH1OpYqXJlxud2SRS4cAnZG9?=
 =?us-ascii?Q?wyZNvQEhrROxhyP1zsiBBiZKlxIzo9S9dbRvAi8/u4yb8MwNqIvP8Bi6IZjJ?=
 =?us-ascii?Q?uLHa98erj1nelYvhm+ti0hBFcbcx4KDqEBZsh16AlyFhOjGF3xCKvtrLNCuh?=
 =?us-ascii?Q?JgF2i+saQKLA1wdb8uh306TYMHtyBMgBpzs2XeTPJTj4HORo3UgYFDdd8zVE?=
 =?us-ascii?Q?EdySF6S/AdbVuI/ZHZh1kiaGC2FYTLmDukkosXh3T7hGwTOeMHkfru/5RspX?=
 =?us-ascii?Q?7/JnCqRHpTT4l8TpVMjtEUhHy5xkfpGILqgz/qNqEWmwe1//J5+0gDSn3Y9b?=
 =?us-ascii?Q?+2T0MDQbIhJnuvar8pIUmLKyx0ju7SAKZZUqyhR57T9ZM9yUWVfmWq8mRgYE?=
 =?us-ascii?Q?DPfQN2CTS/FpC8LGz6HZJFBNEHTWd1+tRf9zLlIcIB6ZWlgl2PbTvD5tWMPn?=
 =?us-ascii?Q?Wy8xVPHII6bm67ZfsCALhC9uJi7qPC2dUeF1+PTXufAnTkx2P9RXqOKenLiy?=
 =?us-ascii?Q?pg8V+39N1rartwP3MMDqcIhfSXPjK1e0/iDgn3aDs6yRVaZN1iDnABB5MwBU?=
 =?us-ascii?Q?0LtXa/svoTcOTqr/ZHZCHTqW3iwczaxxn9jQpa2WMT+xGSijlS/y/46cnJIA?=
 =?us-ascii?Q?BVMCyOYw8+u3oDgDlQdONxcoe8/0sKVuPhMSnh9w0N4YpnhpjrYLKdZTDhAR?=
 =?us-ascii?Q?MpnFI8AwmtjxGTCim/6OYPN4ETP0Ta5U4m5rF9VilC2t1bkI3LgOLPCr1x3a?=
 =?us-ascii?Q?+MvVsaWxuCGml+uIfOThsE57jDxZABmWhRLVazAccf7xpwqfda5PZBBlxvFa?=
 =?us-ascii?Q?N0XBS1v9XmLNYFp2HunugLoVLix0ktN0qsrAejqCXGzH+uL4mJMZoutPzsXO?=
 =?us-ascii?Q?KpkCrBePJE+5n+yaT3MSWKQUjgrCQpcEfb7MNBruXQDl32C2CymMXU/pHG4T?=
 =?us-ascii?Q?RqEhRWVb/N/hL0EbOGVoL5e+ifpGu7lL3X70SvCfFRsR9Q6C/Dwa15TSTuax?=
 =?us-ascii?Q?4jGLOjDHZXqmNUnBt7e7Eo0IXz8T5CbwMLpBjDS09Da033maQsNEdqhSKtHn?=
 =?us-ascii?Q?k3x92QSveemHPW65pbGkJf3aM3wifsBDT4eN2eVOkIRW0rNKhJ9fv1rbj4uh?=
 =?us-ascii?Q?zEOQwv7GEsQbVIJXKUqRjLVr7ZJx7jMlLsjbrfHaFWUOYaaxscKxm4PsGFyn?=
 =?us-ascii?Q?/Ti5WtACnuAL50VAC2JCTaqmrNN+h8XyEtTKcgz/+gB7Y88IjkX1VI7QBhZe?=
 =?us-ascii?Q?D9xsSy57W4vmgVgEtGYJpqprcwDA6ss55rBPnGqdQkX03M2ef1H0nsp/ae2h?=
 =?us-ascii?Q?i2lKfxsPUqeyCFPYxE+dJncLrSKXWOaTIPoLwmlf1I1ulKefTCKLJdTyfb1Q?=
 =?us-ascii?Q?CaqInTEGOR5NAp8nhogJOzYpmaFJRj/rrh2ekcjlct2QAJUJ68CZD+63wr6J?=
 =?us-ascii?Q?jcorBzoc2xfQSZlDtBzA+2K9MG3zRL0/AuLYGjxt+dPhxCi9LhOhoogQdnce?=
 =?us-ascii?Q?E9BxZneE8ApKMIj0OFOv85GorU+dLcTieO7L06/aCMgDiWhG7pojQv2uRcJN?=
 =?us-ascii?Q?15APlULzQvHEyv6Xr4igwdf37BOyQvtnVXACnlkX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cdac21-6340-423f-42de-08daa877d614
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:23:07.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycvN9qdLQSQNJXOT/cH+nQUqHpeJd25+rAYVynUgH0A4GdK9oZxDsyRCg+4RUlAyQvFO6+ysGjXo0DHyGiYcpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:06:46AM -0700, Kristen Carlson Accardi wrote:
> It is not necessary to disable page faults or preemption when
> using kmap calls, so replace kmap_atomic() and kunmap_atomic()
> calls with more the more appropriate kmap_local_page() and
> kunmap_local() calls.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

Minor comment below.

> ---
>  arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
>  arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
>  arch/x86/kernel/cpu/sgx/main.c  |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index f40d64206ded..63dd92bd3288 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -160,8 +160,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  		return ret;
>  
>  	pginfo.addr = encl_page->desc & PAGE_MASK;
> -	pginfo.contents = (unsigned long)kmap_atomic(b.contents);
> -	pcmd_page = kmap_atomic(b.pcmd);
> +	pginfo.contents = (unsigned long)kmap_local_page(b.contents);
> +	pcmd_page = kmap_local_page(b.pcmd);
>  	pginfo.metadata = (unsigned long)pcmd_page + b.pcmd_offset;
>  
>  	if (secs_page)
> @@ -187,8 +187,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  	 */
>  	pcmd_page_empty = !memchr_inv(pcmd_page, 0, PAGE_SIZE);
>  
> -	kunmap_atomic(pcmd_page);
> -	kunmap_atomic((void *)(unsigned long)pginfo.contents);
> +	kunmap_local(pcmd_page);
> +	kunmap_local((void *)(unsigned long)pginfo.contents);
>  
>  	get_page(b.pcmd);
>  	sgx_encl_put_backing(&b);
> @@ -197,10 +197,10 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  
>  	if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl, pcmd_first_page)) {
>  		sgx_encl_truncate_backing_page(encl, PFN_DOWN(page_pcmd_off));
> -		pcmd_page = kmap_atomic(b.pcmd);
> +		pcmd_page = kmap_local_page(b.pcmd);
>  		if (memchr_inv(pcmd_page, 0, PAGE_SIZE))
>  			pr_warn("PCMD page not empty after truncate.\n");
> -		kunmap_atomic(pcmd_page);
> +		kunmap_local(pcmd_page);
>  	}
>  
>  	put_page(b.pcmd);
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index ebe79d60619f..f2f918b8b9b1 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -221,11 +221,11 @@ static int __sgx_encl_add_page(struct sgx_encl *encl,
>  	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
>  	pginfo.addr = encl_page->desc & PAGE_MASK;
>  	pginfo.metadata = (unsigned long)secinfo;
> -	pginfo.contents = (unsigned long)kmap_atomic(src_page);
> +	pginfo.contents = (unsigned long)kmap_local_page(src_page);
>  
>  	ret = __eadd(&pginfo, sgx_get_epc_virt_addr(epc_page));
>  
> -	kunmap_atomic((void *)pginfo.contents);
> +	kunmap_local((void *)pginfo.contents);
>  	put_page(src_page);
>  
>  	return ret ? -EIO : 0;
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 515e2a5f25bb..4efda5e8cadf 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -159,17 +159,17 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
>  	pginfo.addr = 0;
>  	pginfo.secs = 0;
>  
> -	pginfo.contents = (unsigned long)kmap_atomic(backing->contents);
> -	pginfo.metadata = (unsigned long)kmap_atomic(backing->pcmd) +
> +	pginfo.contents = (unsigned long)kmap_local_page(backing->contents);
> +	pginfo.metadata = (unsigned long)kmap_local_page(backing->pcmd) +
>  			  backing->pcmd_offset;
>  
>  	ret = __ewb(&pginfo, sgx_get_epc_virt_addr(epc_page), va_slot);
>  	set_page_dirty(backing->pcmd);
>  	set_page_dirty(backing->contents);
>  
> -	kunmap_atomic((void *)(unsigned long)(pginfo.metadata -
> +	kunmap_local((void *)(unsigned long)(pginfo.metadata -
>  					      backing->pcmd_offset));

For kunmap_local() one can use any address in the page.  So this can be:

	kunmap_local((void *)(unsigned long)(pginfo.metadata));


Regardless:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> -	kunmap_atomic((void *)(unsigned long)pginfo.contents);
> +	kunmap_local((void *)(unsigned long)pginfo.contents);
>  
>  	return ret;
>  }
> -- 
> 2.37.3
> 
