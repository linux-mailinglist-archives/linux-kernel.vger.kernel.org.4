Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0859D5F7039
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiJFV12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiJFV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:27:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F161142F5;
        Thu,  6 Oct 2022 14:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665091610; x=1696627610;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I709zlXnfNe9ojzqw7YuCZFYf3SUaLrFxa3FcznFu3I=;
  b=P5aJInoBNZZclz2SY6jt3DmTMb/PQA2s3pEAx1vw3LSi1wohMyWqoe5L
   8vgOq0l1c/K2j0HrSvJCmSdK6MygqUQ9B082ZUvdiQQAsT3gq0AbfY9wr
   a1ftpA/r1BEZFzS1XNDbyYt3I4G1aCWbl+jVRiA558WJIAVF2cfsQjeyi
   5k1TlrLA88nCyNhbkg7E/cN3AVGhvF/i9TQTD3PZ9/OpP/ZU88S2kUt7M
   I5A+uFqHk39XXk3JjstypSopRFYEYLrGo9sXZ4jSNnnW3I10cQIOsScs1
   b7P4blCM114it5Oe7JekDS6n+q4PDhBOmTx1L+8wq65q/g1VtE+OpEjbp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="301172641"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="301172641"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 14:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="714008636"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="714008636"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2022 14:26:49 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 14:26:49 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 14:26:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 14:26:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 14:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPIsYjwV51/VKvx+5NuK/I29egF3MLaO5gV0ikDXad7QDg4YaP4DmLlKHNT5wpdlopB7UX8JvS6hCHUhch2UnLhPzksIylhpUu/O2UmzTkeY+ABFb3I2ZOuHFGIgdCi/L6A0zBbPeqAWRJdYNl0udWhPRfcnF7UqLv+0hGydew+RgJRLI9QTcMc89dOthBAJvIgay4a9tiaYPkD4HKqt/IoIcvy64DXExqn0ZCZQyT4NCoEhNZV3Yc3U00sxUXdc/ECUUrMOL1BpTDL8r4WvwuojfmejZrf8nh/7njWlZPdYB1N0cLcyYTTrdQUHT9YumRcqCiYB8lLDZW0dSbd+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VfPZDIL1OZfEdKqi/Xc5aFl0uQTxpTjvMgwGsyIGs0=;
 b=ew/19pu0vJVWveF2+/mUucsUUIm7eBGP0nxXO5l8mGsXDozQF0SrYwDIAEfilbmEbOGUmDkFpQoYKvJyv6ZPM/1i8suZcjG1ws/KYc4vP3eZB6XKyZ9z6qSx1KCojciF9b4T9C6h0B550ovNbpO7OKnG89Bk6zdmXUrUpFhtINwRkTki78VB1DOSyQ0wnuB88ZRXg2uTTZCIHIaHkSkFIFwqGipX3jpXmglgIeyMYieYF3X/COfW8t4yGgN1Sq2z7tTvkeRPvNP2V/eq6jYrOWFBzwyXLWZ7H7icxgNkdtYhSFsxQbaWKzWtUIkgQTyt6a2TMhAjpmtHcHXdLo/F/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Thu, 6 Oct
 2022 21:26:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%6]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 21:26:46 +0000
Date:   Thu, 6 Oct 2022 14:26:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Yz9IEX1uFNllLjAD@iweiny-desk3>
References: <20220929160647.362798-1-kristen@linux.intel.com>
 <3694452.kQq0lBPeGt@mypc>
 <d64e6e9f-27b9-9bbb-aaf8-fca1681eada5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d64e6e9f-27b9-9bbb-aaf8-fca1681eada5@intel.com>
X-ClientProxiedBy: SJ0PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fbd32a-1781-4d2a-edb0-08daa7e178fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufN471RmRW6AJ/NOPkoyMVPYZrAmnSeTw5QAJMRcXG0+fGccM18QMSswL81Fozdb/6X+/1KbPnh6qhcFxRs3XwMff6qkqtafRZvidmqHQs0MQv7d5/6hRlVQ65Z38dzwvJ6GSxaNZPMxid5vy/ampCtxXxNOUKZmc2Q9OTEbfEj8mOTtd46t1HUoaAV+iNaDBKiWwmd8WkOgRJo+mJVP0v+56IJ2d8aVKnAT0X0zCfDfapkaSgxv/3mJw4UBfCg2I7iW1XpRCEKd6xgXXjvXBcE5nopuywCDBhPGzNfhF5txuU8g/FTojhQoNjy2eS3vSqgRg+BrsoXymqSAUwgO0HGA+kd2QbyLE/UwqBac2zVjAOXFyaJdfa8AupnAiE10l4rteMAsRGefvXW+vekprbK4O/4FZVpKYhD7C4BaxNU2+4fYL0MnHMzqQyGGYdGtu+OfmgxJIfjtTLxxKtgwntWPDCEBcB4i5Wy8G7O8HxKgN4pxyZdJCNhtcxwO9TrMuG/UxG+36weiSCKNvcQ+9otIs8Nm7+117G9KRlE4aUFXF1fehgdtk4wcNfYnW7L1NMtEMDv14pwwCIfFH/8agkA9gsQwyFeb7kw1NiBKyY/xlQ+6bl+ixrap3oKUCGIoC4aWjniU+ylI503TFK3LLs+QCCHA1zKTkujjxqkbeK7Td8yFAmR5FANOn/INfEM4DJtLMuqI2A5hCGPT+4hrAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(66946007)(82960400001)(66556008)(4326008)(8676002)(6636002)(54906003)(7416002)(44832011)(66476007)(4744005)(316002)(9686003)(6512007)(6486002)(478600001)(6506007)(53546011)(6666004)(26005)(38100700002)(41300700001)(8936002)(6862004)(5660300002)(2906002)(83380400001)(186003)(33716001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQT06KsvOJovOpby4mMD+zWUU0168jYzJhWFy8K54qUYLkEoQsMKM4RCUs1y?=
 =?us-ascii?Q?WhGrgh+xGqIK+Ok+WqwhccmbV6bNWAvUy2QXgR9/HunPOQjtw4/nuQGqCm9R?=
 =?us-ascii?Q?Y3CKqOn0PSXKo70BJf1z3Wh50ZLZiRQi7tPrDm5dLdqhE7CpTRM/fzH8Orqf?=
 =?us-ascii?Q?eYWakT/EKmDmrkeV+KRaDGFsRZkbTS98MVGEIkJd8mzjMIWEQASNhnOElCCG?=
 =?us-ascii?Q?3kXAIymXokx1u76QDhiWVo7fBhpoEokyOfgVOhu61T07BEeJQscBR3sBnbiH?=
 =?us-ascii?Q?n+JjNSWjdWhQ3xhy5NXMSTrY7ndw+R4vWnkvDyhlcQc2rmoUsn7jjGXml+BZ?=
 =?us-ascii?Q?ZyhX5Kx2UQmQkql1PpnKinXT6Gy2D5WzmVRhOyPSV9u6MYgVbmaQvzo66rkT?=
 =?us-ascii?Q?KshP/uvaP0kva/awF1gxpOK7MNmdoXkxqQKRWu3I1e3cx5p1xUUO8wCslG+x?=
 =?us-ascii?Q?OpfcFoscOYQ8SYW5mFQ1T5XpoD2OeVT0Z5cfYCBKoEcHtG3Naub01uO3ZMzm?=
 =?us-ascii?Q?Tp1CYOaaZqGxBnbE5j4XosiIekZaseJtjkWahGvVMSjMOgjyPSF/Ps6ty7jN?=
 =?us-ascii?Q?PXk29wrMvIUbnp280spKxQmmFhpLHLTdzgrriWcgvAHDOMYu8YIPwyLvxQz7?=
 =?us-ascii?Q?gpQxX7eU7D/11bSdAIap3X8oRnwRJP5Y3XJQlijU+NEkPTTw7Wljn6/V2473?=
 =?us-ascii?Q?wV8qfW6Uaq5CnjWESdBYk+xuvStCPQX0m+bABHbnF59bt2+RjBxfe2FITL61?=
 =?us-ascii?Q?b79D+mJg6Q50/ifDcNUaxxNqU27Q95B5yRrWJs/vBEDndahXn67iiaSy+pLq?=
 =?us-ascii?Q?LBp4WoshfQhm/kQq76JFABxAG3hPMG9ErvhZeNmUR/slDjQAPrh4mE2YM2DV?=
 =?us-ascii?Q?NxseSU/yzQHR/BVjLkE6JHfppyaoa7Ci0cpm2xLRP7nCJw/kIwRZ4T49IUlb?=
 =?us-ascii?Q?9dG4DLldBS4cG3vcF2X3Vw4FBhEZzhwAecVSTfRjmea3RPxnAPFmesWGLpWb?=
 =?us-ascii?Q?bK9vsWs1HsJ7tkXgrIsAOlEGZ6M22OKoplrOl9lbuPKerhYub7hzJvXoT62m?=
 =?us-ascii?Q?p54f3S7ml+v8QSMZqWkzdlRMq28aQjPORws6MyLHxcMlEbjvWlY//ueFV2FG?=
 =?us-ascii?Q?HBOV3Y+5Jqi8/QfcpgMMHCjjOyF6qTXnuMUCN9Qhr1Krnfe4li1sZ6YlXFXW?=
 =?us-ascii?Q?Y86UbsO6Li7SyAIWU4B+nNNed2iwYC/GsUMQqturXMl+oONXUScrYDF9iUod?=
 =?us-ascii?Q?i98cMVRhm5BACXYrNqRoiYrgBWJPSl1aF61lQf4V9BoSXITWtR7F37tZ3CIQ?=
 =?us-ascii?Q?R7TyTXJCNBR+3egnW+2xJtjW+XuLwORDN72whZno5MPL6H7jQpxhpfWV9zaO?=
 =?us-ascii?Q?AKfiQEQy2VK2bJj4ADqzkWGVNZ6IW/xT0E8ixu2GLfqNfJ2cbVVw7dwlnge4?=
 =?us-ascii?Q?9m++fBvtGqi05mRXg6/D/y76NexPvRh0ADvlF59KxGVMMW8yZpoibIYL2GA6?=
 =?us-ascii?Q?HFn+tyYCq7hrAbcJq0XvLadlpPN6KlQZ36/grGDt1220q+YoLarqWOL5JhRW?=
 =?us-ascii?Q?TUdBdRPMtK36SqJ9QKkxiXz1wD/hg0bgVkkuJWNn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fbd32a-1781-4d2a-edb0-08daa7e178fd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:26:46.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E41geydn5x8C29n2nKCrBhUB6lyjjo0OoYUOJF9CQ2br1L/0X5W7TMeD/hPgPcKD5vWCI5/zci68nVS206t7ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 01:45:56PM -0700, Hansen, Dave wrote:
> On 10/6/22 13:37, Fabio M. De Francesco wrote:
> > kmap() were not suited in those cases because it might sleep. If the intents 
> > of the author are simply map a page while in atomic, so to avoid sleeping in 
> > atomic bugs, your conversions looks good. 
> > 
> > For the reasons above, can you please say something more about why this code 
> > needed a kmap_atomic() instead of calling kmap()?
> 
> This question is backwards.  kmap_atomic() is the default that folks
> use.  You use kmap_atomic() *always* unless you _need_ to sleep or one
> of the other kmap()-only things.
> 
> Folks don't and shouldn't have to explain why this was using kmap_atomic().

I've not looked at the code closely enough but there was some concern that
kmap_atomic() callers are depending on preemption being disabled vs the more
common case of them being used in an atomic context where kmap() can't work.

Ira
