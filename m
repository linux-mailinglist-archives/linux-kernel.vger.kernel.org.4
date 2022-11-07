Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11F361F8A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiKGQNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiKGQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:13:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B22F39
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667837603; x=1699373603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+PECh/fCoihQ20Z0r8klEnMFmuFvvXqYBpyEjJ6Qt+g=;
  b=CFgfsvwNIQaPqVwGTWPY8zQQ4m8zDfRmx+YykaMwux8h3FmgLKberi6z
   nK0IT4kccXtrb5X5WoQwz/RZttqlUikrsYGTSep/mf9rzqEjWA6bgR7jY
   nUCK3jeoIyiY9MMqU8CjDIaWf76j7W6zlZjBXclCFSPTjSN3l8yX3xO9f
   AOqfmXAvKQApDyasQxAUue1XrXLQlmKyDcdb/HODkU2KQPLB9IBeO+Txb
   SWrxWa+VpSyO4iOffEi58b9VO13HxmR0EUzJNcqHNTJmIBaw0s8aZVR+Q
   rw+7vfaY2TEf7g9032eU6dW9ef69xtqe3wOZj2qwunx/6Re4vfe+zT5Ny
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312216705"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="312216705"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 08:13:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="613912399"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="613912399"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 08:13:22 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 08:13:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 08:13:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 08:13:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 08:13:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncB45FaYKt2t6HWAD3WjNdqHlC+n/YnMvwLx4UzFQx4EEsqS99EfZwEvFXs7qsSzF0ybpoHqX2cyhL5X+1HY3qTbGMrMoZUfbspdweiWMNPZSx7Tez4+xyK8N4uAdthjRAUImgDVuzN/W/xOC93CumLTXya3WoKSKs7pOJTrTpY1vIVvBmnokrY0/8Y1JVWtIdaWvvsjw8mwhPBMmDEsNN+3wALZ2SaOS4/NVfAgdr1onhzY2yaR81zN9uZOGbtKY5m0U22pJmLOk1KWOY2nUqEm4IjIc5CCzNkBGAPPbm+r4/IkwJ5wy+Jf8OZM0sF6HXZKdEvacbKynJiKEkEI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tro/aTmJRR3OkQrxS9ns8lRBY9D8BcbcC0PclQWpUnc=;
 b=i+nVTx2Hp4vOwjc9UilPgkBm1sqmU3szBRKZijCem0xd0DqeiEMAueqwMHrY2EtZHKfGzTkd2PcOat5e1/cCEDT4wAa2ZF8ZKN1t6iFZbKSUbOrzGPzMuCkTCEEiKRd/2iYXNGvNRcKw3UK8Wgh/VMDGdoAyDfJ7VSBKuHDU4wC9f7L7ww5Gbj+kY0zrNZVWb50Q1Cl0Z6AFoVnZg7/Af0u4aFnVK4ptXwMaTj0T8n8D4t7A7yqf89vDFSGa//QqfaTdZjEZNjPvbzFTs3DY0FF+KlTz89W4nWzXHIdffYtomCyhFDSpqD7iqgrHFjojjocC5DsrHTNJMUe86fwJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MN2PR11MB4727.namprd11.prod.outlook.com (2603:10b6:208:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:13:05 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 16:13:05 +0000
Date:   Mon, 7 Nov 2022 16:12:59 +0000
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
Message-ID: <Y2kuixb0RU9BxKls@araj-dh-work>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com>
 <Y2e4PgwAEXuFzoMd@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2e4PgwAEXuFzoMd@zn.tnic>
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MN2PR11MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: baeda6f7-304d-4a78-045d-08dac0daf3c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9TZa+6vM/46sERX2HkAm3LN5c5vuzcjxtUncoTqtiE7z1bFEArk7SCRXbR93QFodTsEK57mpoakuZdlYV7lAoG56Sz9Z8LloqK7VNcYDDNrkNKpfRyF9cniWpBJP3HZVHqjRsjOkKEjjBVQYyIOC92vpgZHpk1J8E9yy67AUR3j3wvkodyxJzHAbQln7hYi3J3mg3r5BHHkmRmfDXUAaV7itk8y9fxQQVthdTIihaB40xEOMBSCyy2HomixGa0hoK1glTXtcX5KR8c2hly/42GhWIXLKyxT7sPgFoW6Bxx6+kRteDPco/tw7Uve5M/sDdFZXIfCp2rySBokxg5pvoqRUh1CuOmGpWVXcVIZiQUZepUJMDAwDNf5mW964oXOoa3FPBaPJGbiADfQJ9pfg2F1aH0nfsI/VSLqViZYG0LPZ7BpobEEYr5gPo/fk32c5j3/BXDlMxhJXqdZlTFSfKfot3axzeyX9Aa3l0MsXW5eXAeUJ9343lmqwBcmuBSOPXTDi7GAXx1pDqF3PRZSKoOsQS7BN75dJQ429Net1fvrEkHZiDbdgh7DIFMJ7K8UsSx4oWfhdmOwAfYGeuzK2RGp203AqyfF3I9yc0OsV/zMfFbVUtxPQWGeXWt3nmrOkqAdg/fZ2hq9+ShUNKeDbdwtoOQG7ABlcNDU8E/WB5J5NbJp7nRyVa3pJqLxEjO1+v0cHrEqxEhKTLUh2USpSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(6512007)(9686003)(107886003)(26005)(6666004)(186003)(6506007)(83380400001)(44832011)(15650500001)(2906002)(33716001)(6916009)(54906003)(478600001)(6486002)(41300700001)(5660300002)(38100700002)(8936002)(4326008)(316002)(66946007)(66556008)(66476007)(8676002)(66899015)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hOzvh7Ec2077TqS1jhiYLpB2/aYAct8LahT55nMqnbXb6Gyfja1KlL9vq1cW?=
 =?us-ascii?Q?fHXNQUFzNbJtclxY6u8DacsnS/AM/TM64dWWd7iz6b/ZW4HkZAbiACE1hKlT?=
 =?us-ascii?Q?9Tva2adaNqmFpYnAzVnYerPNnjNam8QazZP5DWBuQI/Qow+MtMI37sJ6Tgo6?=
 =?us-ascii?Q?KAZg/zMCtl/685MzY9rRRqgw8Sa2huMldmcNgbbEmeRSOg7MBr6Uc+wr56oJ?=
 =?us-ascii?Q?DToClKnEiGq/Au3r8stirL1/UMfs5efA71nS0zPL4rWOKpUgr6V3wMK71kC9?=
 =?us-ascii?Q?e3hEyan/SSv/rez/6rHcaixN6ouhXVsi4EyDwYk5oALp0sY6g8O59OwcW68Z?=
 =?us-ascii?Q?Vok7UUeMsnSIcPuooyrZRdkTo1Z0PIB3VKy4v5Mi+nBs4zKoi4QMQ6gR+vdo?=
 =?us-ascii?Q?AWKphUfplpN7sl80yEYiuTWs4Zil6vx/3WrrVOkf55aEjjqD82Md8GV5QNDn?=
 =?us-ascii?Q?IuuXlL/fkQFPXo7A64hp7C+XXBDoPpxlO6yE2A9POR7h6AVm40I/RIZ2y0BN?=
 =?us-ascii?Q?e4i4XxIw6rw5URo5lkMRchYbZVJBhZBqTDnLUWcYKNPt+1tLLmRn5kSTG86j?=
 =?us-ascii?Q?surn94eYcyk0dmORORDR0+O59AzLPSNkqmGjrz16sueQLF+W3SVBvpUw+Z0f?=
 =?us-ascii?Q?TT0uF2ZAI9Oe3PNUk1HhYd3Y8xjCIvnMYiNBSx+0gM6ZWNqOWq+hOFtIytgt?=
 =?us-ascii?Q?x0Htwj5l9cI1PO8IRFO1/oi+Ey3mxHP1RlikShh/VaZnEaKv4A2pgI/MxQoQ?=
 =?us-ascii?Q?uapthxLFc+phked2oAjQIvZKkTVDOFPSk5UUdveY6u1suM6tAreV2ORPAHhs?=
 =?us-ascii?Q?OTJv2ORQCGunmP/mA6Q23ffzS7szjCKPXhw1ShcsZAIgiAv6ZFtp/NNJkOH9?=
 =?us-ascii?Q?O6u/c/3Mq8jnBjoo3dhhOP2xiGDQrCgRUPCJDFAmmDVYQD11RYxqAZLEm4BM?=
 =?us-ascii?Q?m0lN6Ti+vYzKq7kg4J9HnWTIEtEjxpo/g1vS2e1Il0Z7hNlgX4H2AYtHYc1M?=
 =?us-ascii?Q?NmVhJfH7PU0JZ6+qAQeFboK/TkApohgLJEdO9cb+qJU0ppttYtZ6RUyZwMfe?=
 =?us-ascii?Q?VUr9GuZSB8fzF9ZEOoLamIft+lHjhNQ6QT1yUcaaNlK3fzmlb48FvQrsqphF?=
 =?us-ascii?Q?VKTdAmRIGqmLAUKQLY2tds3LE6QtJHCJhPwsBT5Su9oiWELsAZcdNPkm0Aqb?=
 =?us-ascii?Q?r84s6WhqmM9wNvPQ61VZ3sM9I1ubakgqUzDmvVcyiAEY+ODJS+ilo0Zp5rhx?=
 =?us-ascii?Q?oYyVuAW4ChuRqbWwghr20hG9rTLODU8md/vr+z0XX9UBaup1te3WwF5JTgrX?=
 =?us-ascii?Q?fGF1m1S7U/kPGzASiegP+MlzFZOjWRgVpXecvK3nYxi0dlwXEygwAktFQK/k?=
 =?us-ascii?Q?PhhpCz5dGlDXcNSEVdBJd9kF2FjxAJjQeakh4XVqqjndzp9cdphLe/GULqAl?=
 =?us-ascii?Q?qFyxT0/dN07oz67WwA0bH3usjT9GKCqcx1HP+oeMNnRUDGf4Hfpe5XujIGb6?=
 =?us-ascii?Q?JcPsiT21BjP75IWRedJ9mw5p7vBnCHv7T8OgHgDRieTw8aDfOz5QzeMFO12+?=
 =?us-ascii?Q?aLrV5SCZcFI4wBvj25jXHvDLLYBrkFYY+3NxUewP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: baeda6f7-304d-4a78-045d-08dac0daf3c0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:13:05.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmdzEipIXgAUUBiwhU3KAN4ObLFiQEcwjHsFmla4Uw+CDXe0SM96z7oY8v7ntvwI6PQD42DSLdOjKbcsB31BAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4727
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

I removed that preparing for the next round. We already have late-loading
capture the previous rev already. So we don't need any new changes.

[  482.242727] microcode: Reload completed, microcode revision: 0x2b000070 -> 0x2b000081

Only missing is the ucode date, not a big deal missing it. 

