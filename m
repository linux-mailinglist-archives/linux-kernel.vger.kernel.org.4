Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E80604653
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiJSNGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJSNGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:06:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E51DB271
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666183827; x=1697719827;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eH3d/N7zfM5KDXKhosWLkolU1bGfT6zBanvw+Wwr7Zg=;
  b=bWCI4bVLlmug+hJjnD2w4MJYkBK+EUuvtbljxnIKipA+Pal8lDOf5gXL
   oks+noag3lrqe14RN2uqpficzoXI9VUBW/q6cSu/qX7wWmaFL3QZnBNE1
   6MDd+uf7b+AZPpWcjQY2fYUIUIG+Og6CCABYtNdwZDoA7yt0mWinSp8ol
   lyMaNNL+HqYSmqXUgEiPkSDw+WUdiL1/zjUcXs7gXlYnSfs9uIgypfCjg
   dggQPiL3O2bqnYrQDmfMVf9EG/r0z/QJUApVGw4JC70x5zlAsHWyTSPnG
   jKS+CE/6fqeW3FUUMVhN1Wuhc/KYOCFKlyBhwH+4UGbFz1VFpIvxhCwny
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332957016"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="332957016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 05:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="629240540"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="629240540"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 19 Oct 2022 05:49:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 05:49:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 05:49:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 05:49:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 05:49:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT94avRqD+PDmi0oYqxOqr5SmOQoNxMF+jkRGLaHT8a443Z5w/In4iPRkIwhvto/VVtsedFKdLetioVPD4T3Y9QdYYx00DfQLE/sDl4J7S6so8r4tT1uBcXY23ggLNo3SLhDLuVXvmlg01axZ7TXAVgqP6C/Psn1IhRilh674MNbS5nQeny/VRlNiYkJVg7zTDcYEdGlImEGr9yMinBkRT1Sf4In5o39N5Bkjks2N8PZrIu8oeJJjQmaMjTdtMGBYt7hnl8981jsGJvT8+QmOp0g/puqtuivlDIpeGMdYR2fKRmidjhLS26SCY8+LBnZs1ufhZlutk/YH78hoBsxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP0+tEDPFa/s91XlljeFM7Jn9RqxpO3IC7jJJPBM+tc=;
 b=NuEeqeYWh+biyCE0J4roVtEA9uIIby2xe/3i+XN8P5rQ2tM4q61LUG0MLk+LNSjuO2bF/3zxm3wbTPbL2v8cusMmmfhUj3P0u0s6ki+o4lo/63d0KlyslCk6N+ukXb3XA86yhU3vVRXTVUcrIl/ueeEGruNSbzWCt4nG7yFaeX6ytBNL2j90i61mDC36CvoQ2w6IZgcgOC8U0zaNEdo2inzc8no9t/NUKNAPiYg4d4oRlzC/0xh9ElDlBiab5e+AhQQ5X1toISuYsTe1TePKT8C5aVZHZ7LGL2IB67MIrQ8hdiOvEV9l5bLLNLgV4GPR2+JCYvTRxB1Yz1RNkOE4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 12:49:30 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 12:49:30 +0000
Date:   Wed, 19 Oct 2022 05:48:59 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 09/13] x86/microcode: Add a generic mechanism to declare
 support for minrev
Message-ID: <Y0/yOwXZGQ9q255E@a4bf019067fa.jf.intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
 <20221014200913.14644-10-ashok.raj@intel.com>
 <06e6c0b1e2624096038925bce787e7e8f0bb356d.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06e6c0b1e2624096038925bce787e7e8f0bb356d.camel@intel.com>
X-ClientProxiedBy: BYAPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:a03:100::35) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ1PR11MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e284edb-343f-4eb2-09d2-08dab1d05d50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBqyu3SvNzsD3/dgBWVDZ89iMlVz+QeHyxOfgmNGJGaGjWOy93kwlYOYXZglwqAUYMQvVoNoleIQbZ8XiXtLfS0Nw1OlpUfEUMDw+5HM3GsSs1jysz1No4a/zMNXrgbB/FO1tlG0J3LZxDSGPIerKCbiFBTRXXTGJ9MfSGYXZ4PZqeL0IuDvrTTHy6LpywEXnl6ONd5G0TMrnBuE7ITrs9ucBSV0C89mHipgPacSzjFxB0eZ9q8WOXH3+SDIDDFl/4zCIYfdopyqXN3f387cjFdPhYxityfhvKns4pFEPbzwWaa2fFXvO4ducVmp5yysIMMmgyMG1DSpCWdiuNaU3zfXhPHegQfl/tnE+YyLaAUbBkp5CjYWjKdmlt7uHwJDFwMOAYXHH6+kCm6SCSBL4qHay1c57nci8yytwg3sbXOMHQLEHW1xmrwjZt+3vH0oBCfi80W0fcNO3T1IofQKR2GaeX3mOCWJ85QGoLX8F/lYanzeOk1G0tvaD4EymF5wfjIHgEhbwv6zJRZcHCIEjpw80ln0nncqKNmAn2f6OM/+pag2ERguj3JrmkwfiFWkBZPLyuRewMKJKxLOessvT7qgnvs61CRT7lW27PoC5wAeUjX/E7URZT37Eg7C9lfEmI9SF/7RYQy5m0gh+vx4j014BRf4V8o9m9M4PJQPYw2pYv5w8SIqZZmQaqA0twOUNn55s6vCXkk8TKyX0EW1U0ir05E2TcvW0miU9hN1pWC2Fw824uZ6UHWrLIIDg/fq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(186003)(316002)(6636002)(54906003)(44832011)(4326008)(6506007)(4001150100001)(5660300002)(26005)(86362001)(6862004)(8936002)(2906002)(6512007)(41300700001)(66476007)(8676002)(66946007)(82960400001)(107886003)(66556008)(6666004)(6486002)(478600001)(38100700002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/vqdAPSzbp2bs6OtoBNer/hLglu5tWzVPzzAdpm9nazR+5Pyol3mpWiaXc?=
 =?iso-8859-1?Q?brcUmWu2lxt1pYJHjhknrWzlVO7mq8HQn/yhFA8vufI0ZZfTaog2u8sjvL?=
 =?iso-8859-1?Q?x/orryilur8hfqRO53tlUcfQyi+JiWZA5uDgLb1JeXg47SjQ7e5f5/KvI5?=
 =?iso-8859-1?Q?rXvM9pAy+dp3F4GU6yvqQehXTeRa5JdAYrSYjMsrZaIyegg95XjtxVTMfh?=
 =?iso-8859-1?Q?QvZZW7mXh872m/NOX0PIZ+06rCPTDUqGXn2FxfCbA7fabWUdPdgnCSW1C+?=
 =?iso-8859-1?Q?LoKxe3E1HLrPldf5HQNu8w6qFsjRsJxzliUjx2JrOnlBu7bOKWojO5BgC7?=
 =?iso-8859-1?Q?CrDT0z5/EwG6SCn+sOr3OSU+/dpi57+i5DjeZn5tul/oEY6+7kihli8L6B?=
 =?iso-8859-1?Q?GPytzOXOCxGShpAWe4YEnzy7kiawYDccMLH0qz5KbJBaoojd96CWDwcq3z?=
 =?iso-8859-1?Q?uaqupdSX8E438Ami19KeWSXmV5B9YqMkdDivx/aq722gRGaPDjaoeuo1kd?=
 =?iso-8859-1?Q?92wa1eH6GDtqHzFT0qCkq6R5vrZxhnNvS4FQzkl/dbl0w8eV4TdI5a/ma4?=
 =?iso-8859-1?Q?LiAXcy9Vujtr62V2bt4fhfGWkSK8I4jR8yLmcUliY/xWFW5SWlZ/RQxn8K?=
 =?iso-8859-1?Q?pf+tTMai+FApc44VvDWyYJjRQmyMkiugf20dJXTX7B8HkzbmhMLXwZr14p?=
 =?iso-8859-1?Q?D5/pE0sz+dy13ojN1Vsfa9v81Q+PsH3Oeqmv+uDgJoRFUIH0lcqIgMc+s2?=
 =?iso-8859-1?Q?RmgkS5hZphHCKKIDkrPBlfIjPIeeaZpiHhSRhTQ72wRBzPD7wcT2M9CUiO?=
 =?iso-8859-1?Q?xd9MNHwmQfd6Mvs+OUQRqk8Nmi9Z0uCVK5EdQMxtVsNnaERz8XIW3Icl+/?=
 =?iso-8859-1?Q?53v6IsE/TUGoGQQ+6/gCjAV/sfZu5Slu+nEoPvMJeD8lq8v/M2wJQOyoIJ?=
 =?iso-8859-1?Q?6Mo60E94SIyKNI4GJpSlnxRSc1JHL+oQ6IWoUWN6zdyRgdpOvXhXxmG18f?=
 =?iso-8859-1?Q?gFVzaHOVRkk3SxAdH/1di5L0l0eR0+FtyC2vU8nHb2hShCWFWfDNRREDKt?=
 =?iso-8859-1?Q?VOVeZuAS22L2jW8athEcykrWdpRImGavgxi7woQMnC+7Op7Cyo5tyUCvM9?=
 =?iso-8859-1?Q?+5M2ZgtVIofAk/HlgwlQxf8nD5wXPAzFdDWzW13Ag1DTNuzf9/Ail5RTxf?=
 =?iso-8859-1?Q?cXFKUWwb1cMVNLnKhFvi6RDP/lWiObaAfJhPAVvjfSs2qUSZzGPaI2sYTX?=
 =?iso-8859-1?Q?DEJMbjQdhp8J5mdVkiU+HcTMg8M4Zc6wjrwbt3meKUOuaobeI0Pr4HwTTm?=
 =?iso-8859-1?Q?vdSCQqZPKc3eR60+Ng64ufA8qK0XachDxIO66VkGmzWI6T+PezxNUEn7kk?=
 =?iso-8859-1?Q?OPA8dI4EhsyMHIDjj2eCT2wshW2zACDC69xEb6aF63iwRzUlP3JWPWxw4P?=
 =?iso-8859-1?Q?ZSN78zDvlgxO8M0jCJoA3mOpevCdKPCiSNljtlZ6b1iZD6A5oI/EAxO7Ge?=
 =?iso-8859-1?Q?2Ah8U/HwnJlG89p4yyvLzTNIgLzLL3Qay01nFOAo3NJtONRTpX3UL/Fk3J?=
 =?iso-8859-1?Q?V8Y2Ep/KYHSsgLubAstMiLrgq7esAeqEoQKo1BGinikwiqotCAznDy+zpQ?=
 =?iso-8859-1?Q?xZS5b1VOfgPsWY8XnuXiMHuPwiO6Yg283W4dx1ubG919FqmSj4XT8nBA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e284edb-343f-4eb2-09d2-08dab1d05d50
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:49:30.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMGNABRvQqngG4Q3atwuTHTjvYjXMWPGlqXMUFtFLYtF0d8S9DcYDh/WpklO7/qNrM385+M4vbA16wLNs40XgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:03:03PM -0700, Huang, Kai wrote:
> On Fri, 2022-10-14 at 13:09 -0700, Ashok Raj wrote:
> > @@ -606,6 +606,7 @@ static ssize_t reload_store(struct device *dev,
> >  	enum ucode_state tmp_ret = UCODE_OK;
> >  	int bsp = boot_cpu_data.cpu_index;
> >  	unsigned long val;
> > +	int minrev;
> >  	ssize_t ret = 0;
> >  
> >  	ret = kstrtoul(buf, 0, &val);
> > @@ -621,8 +622,14 @@ static ssize_t reload_store(struct device *dev,
> >  	if (ret)
> >  		goto put;
> >  
> > -	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
> > -	pr_err("You should switch to early loading, if possible.\n");
> > +	if (microcode_ops->check_minrev())
> > +		minrev = microcode_ops->check_minrev();
> > +
> > +	if (!minrev) {
> > +		pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
> > +		pr_err("You should switch to early loading, if possible.\n");
> > +	}
> > +
> 
> Hi Ashok,
> 
> IIUC a variable in stack isn't initialized to 0 automatically.  So looks if
> check_minrev() callback is NULL, you will get an uninitialized 'minrev' in the
> above if() statement check.
> 

Thanks for the review Kai. 

Correct, that's a miss. I originally had a weak function bound for AMD.
But later i removed and forgot to initialize the local variable.

I've already queued this for next post. Just waiting for a few more review
comments to come on.

Cheers,
Ashok
