Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E94607661
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJULkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiJULkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:40:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E08FBCDD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666352413; x=1697888413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V2haRBVeA44Io7scjxFzFMySHPHpZ2jq2/ZoMLMuTjI=;
  b=cVy3WtTIM6Rg+tVtmW4vII8l0hFoArAXON7csqKMncEThT64TZ+CQuKv
   Sxu4uhIGGRxvPPaFxgBJg404qgNGsbKwJ040LbZe5sgppyGOGqdtlfbG5
   /qjkuKFxGiKvVmM82SwMnsRM3h1yeVZmXsNXX9gfscuJXv7AWmB85fHk9
   LC1D3SUaQw3q4Ktpt9YH3dw7p7DOxfDX8j9LGPgixKY5VI2Ij6AzWF8yY
   sRymrRbIDJFPTTVXCeZJGSZTxaZeg6ABLaSKXfxcLyRoheafiDfefZMy1
   qhsps0trqGb6f/Yw5DGQDPuRZXwjj5J1ZBmnWJ3EKilPWpPQjoF13XxLG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306973236"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="306973236"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 04:40:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="608333929"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="608333929"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2022 04:40:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 04:40:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 04:40:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 04:40:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 04:40:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWqCtzMQQ3M1bbHKs/m4ilmhIgMezRBDQYAirUZxTUJMWIvdbXPrW9v1uUDnSFvkFwmsPeOLJ3iegyWOGzABoxfOUx9hHF0RchY1xTJYTCjN6p3V7v4b0cC0GTcwNDQ833bZpLtxinOKFIQevTo87fmuOU0g8vSnN0kIAAIUFkVnZ+FdT36ChqZtuvMQz8Wq4Kzeux+goytl8fqCv1Uv+CT1lbJJ8XS0Oo1wEsC1iXinKZvTKqIS0X89FJM1R2cET/SXFSzFdAgeupwOfi57/3iwST3Ul+8kjVrGlmMR9EhK1bPIVqXhqyTu/SY/4z4dblOywyC6uKc/1IdYpwI4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp0LjZqBsUEDzqEPpjwgMuOqVQxRTSj6yW8h96deBrE=;
 b=heL36hnRpa+eoG7qo2uYddUI+qK8yb7KtMHRnV0OJZ3+qxqa2PaMKt6WdUbqKxchGC7qp29dZxscaiDFShvFJBOTUPr6F0UnCz/sehAFvZJ76iI5fyj250eiP3j2cNgAHztke75bK26dp8/vUMPzyUcPIdoWSsdSOLLBTJ7XAAyn5+DqwszV6KCZSImMuoj/BST0nT7tbJO6B9nx3puS0j+03p1aD4BKdN7gHkKQqH82i7YDoo11Cqd5qpUg3eUuURR09rkCkIwIM1SAXgkcSkvgs087m99I6sE0YyynQ9c1llmLjgkD5SGBRkMMNs3E54QeFunrjdpB63GYsk7czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 11:40:09 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 11:40:09 +0000
Date:   Fri, 21 Oct 2022 04:39:55 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/5] x86/microcode: Simplify init path even more
Message-ID: <Y1KFCwuf4LrSIBFY@a4bf019067fa.jf.intel.com>
References: <Y1A5YHzmzab8LrYD@zn.tnic>
 <20221019175426.31025-1-bp@alien8.de>
 <20221019175426.31025-2-bp@alien8.de>
 <Y1BOkbXsQxCZK3U7@a4bf019067fa.jf.intel.com>
 <Y1BSF8ck0RD9UpLd@zn.tnic>
 <Y1EEObR7keIDJtVJ@zn.tnic>
 <Y1FjlfVQupDc7q1r@a4bf019067fa.jf.intel.com>
 <Y1Jl0tojpBzY2y/8@zn.tnic>
 <Y1Jyj/MjhzJjU0rb@a4bf019067fa.jf.intel.com>
 <Y1J7HC9j0o4oQNu+@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1J7HC9j0o4oQNu+@zn.tnic>
X-ClientProxiedBy: SJ0PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::15) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SA0PR11MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d0d973-07a6-403e-f5ff-08dab359020a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MhgBKisuQk5SRq28QIaDVgCDkBt8VoSyTaCRpfWsNFVEBUx0Q02MA0H3cPFxajJ5unMC5T4fXhoRC5LOjLExdbR/UpJLJRLfWgrUiNXC/0jDQso4+LB7cs2zdN3HK9JOqtzFQhKPPDbEgtXcKYIV/eIcscX3w+QXGXcX8rFwrdqI0DjZNolnm2LQyNjfHyMxNEO+qixlgi4c4EEoY3SFnb99kBMEX0NDzhBhdtkjqEGSOTrVlaEbfIJcK4P/OEIsE/KD6ynafT5c/N5uf0A2XItBkm6H9RGyrPeGxJh23xzh7WtVIO0fz7hRAB7ZwnWG1oXkVCF8A6uDg2Vuqvo6ZuNmWf8EZxs8n9rtJTSfHyGUIOq7aF7n2ZcZ9skCJ2w+1qvGzpLyz4d3Z0DDI86SKltu+CUWICfRtMsC8AAwCRGh7iaEum+XrupNWTs7RVrtH/4ET4X2gl/G6D72JYyD8ZE/CDNAO0DrchMXZXbbWx9mx3y+P05ghf+mda/P3Te8dthlPNewMmU7ROKjuP1CEMKmyGY9d+oGzyiYNidUkwZ/PX1KxJic4RcHt2MRM/8V602+vZwGelMO3t1FeD3ohtvNs+VmkYgx4KqpCW97cNRoA5jXwiYKt5/tYSNCfXMTrAQWXHnJDw1j64r2cFU2n6hZmfBsrWENkHyOizc6jw79FLbWVNx5rr/kINND8QK4L3giFXf9UsU5XqNehvm+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(6666004)(26005)(186003)(83380400001)(6506007)(2906002)(6486002)(44832011)(107886003)(5660300002)(6512007)(66556008)(478600001)(6916009)(66476007)(66946007)(8676002)(4326008)(41300700001)(316002)(8936002)(54906003)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bpayYpuyDTuNDKlqC/BYakrYSjFiBkjqrGkDNQCabE9Td2xPpjCiCsAPL3jf?=
 =?us-ascii?Q?7UdfVEsFIHAGe8/A3JmnGbQl4V4mXMNid78M8tUfZcy8EUosv4KP1ukvLeYD?=
 =?us-ascii?Q?ly+ss4Kff4KoQqTCHrYyDUKXDu/PI7rk0ceF6EUUIYsRwC1X/0eykFSNWuhP?=
 =?us-ascii?Q?tydDOgsH6SeQVykCbBD+OdGNvf6ZS0LdzQGaRMEYXQKNInI/9MTGMWPAA3CQ?=
 =?us-ascii?Q?LMFBKUID4SLH3GJqg10fTBq/oQMzQv8MYprt8TUoFxb3fAc+jlw+UhGr5pYI?=
 =?us-ascii?Q?ImWuptDxVCClpwi3aJiqV0KCKwRIhvBzwi+VJ/72y9EPpBO1hH4AHMSE5QK5?=
 =?us-ascii?Q?2B0uKT41HTRxhLpiDEUSbU/Q/gmpfC5jkXEGEkLUte9SAjdpywM/e7GbOfXl?=
 =?us-ascii?Q?MjGIrM004EVSTYO9jE5ofh612LitOGbwms9IACS3MMlRwtltX7YtVPsB+Xex?=
 =?us-ascii?Q?Ad2hPQ2lA3crvzwDNZ0mP0e3cc19gRmoscUmhMwymvB2xRGSEnrsqdnzDYKV?=
 =?us-ascii?Q?fSYipOqB9g+xKwXFSTl8ECj+XhEfXV/9JcsfxJNB2wBDmu91Zenv3G9mdfm/?=
 =?us-ascii?Q?I8hiI2dmxpo5ZOZEDY/ENva+pJFeyjWwmrbHXUiSH6u4fxrkB2KS5vKLFloo?=
 =?us-ascii?Q?NIvyjS76weaOe8oao3CPLZD2uJc5EMza/7YONRtwNQBmTbskCPA6MuDupfzK?=
 =?us-ascii?Q?61FuGKc8n7vMdE4G1f3JVk2vjMul7wUztVB1E9fKzfp+H3Rl8L3xSBPmB7UL?=
 =?us-ascii?Q?FKr3G2WXl36TqoQXjusgaC2DsIkHbI9aqdGSfS4ZKEeNHNiiwKR5FqBcq9XP?=
 =?us-ascii?Q?AkrFTAndMcNpqgUI54W6sJVQiRntHlbYQ2y2na7YkH5hCSLLrxQA2a7JHVG3?=
 =?us-ascii?Q?QtXoNXdHCC1m61EWg0je1LSjibOfLfg3jvQWsMXPDDeYgoopsVSkwYvcxRDz?=
 =?us-ascii?Q?Cf/J9GuHPIpqDcOLchklB/z+ISHAvSLCudK1nMZbIZLTx6382xqkMc/sI9qU?=
 =?us-ascii?Q?hebtRgUdBD1QdHyjBqIRG/LADuM1gFxSvlGSQasjBpkOxq0HAQRQStFwGU6I?=
 =?us-ascii?Q?5rh+0pgcDzZqkVHyMYDf7Y6N7SwQ9XBHx3oI6pBooN3PelTgwYy/G1qZBlZu?=
 =?us-ascii?Q?ddPEC62V+QvAsXy6DCkya1vWFrrkuWjgrTBcFqMFB/z4nrZgslRRsWW28+Lv?=
 =?us-ascii?Q?53xft7fj6MpOC92AWTENTlzV2ciAhFFasdhi0+Nhi2e9IfbOrANOIn9VSUnv?=
 =?us-ascii?Q?CyfurVcpHsA/voZiz2YGIK/9oWTbqAGon3xnj7GWX0kURKe773JymSLlBL30?=
 =?us-ascii?Q?+PNlkuXJ5TI2amHmeJ3ixPPNpf+4hKZ44Xky1awRTX+mBOqGZAOj7FgeiZto?=
 =?us-ascii?Q?YH+Otr1qhW2gmH8/B5bQUKQAZo+ZypJIgVy3Sr/aDwS0UbIz3X125SG/RfWI?=
 =?us-ascii?Q?sUm/s7QZg8c/Of6tyOtjx09tcp49rFPd0M7Tf7aRk5g6r9yA9kPEQ7YnwkOm?=
 =?us-ascii?Q?UxTJbP/QmEbKLxfF4SZaDiw7I/2fYkuk3HKOWL6549cYUqItD9YsKnvFKX0/?=
 =?us-ascii?Q?qRPLbepq39jg+qnb/IEBjLnNC0pGlvKkQZdvJ4VJ3QoyBR/jYvVp8PghNI/J?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d0d973-07a6-403e-f5ff-08dab359020a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:40:09.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfHzexrtNXfZfza2KsCOc3abFgIvTfDvkAzQBWxXVHxHNChAgpMxYvtU/RnlBxf4xZzrohwE7YL/XkPuYs9vyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

On Fri, Oct 21, 2022 at 12:57:32PM +0200, Borislav Petkov wrote:
> On Fri, Oct 21, 2022 at 03:21:03AM -0700, Ashok Raj wrote:
> > After boot expect to see 0x81 as the revision. But its left with what
> > was loaded at initrd image.
> 
> Are you testing with all patches, including yours or just the 5 I sent
> you?

I tested just with only your patches

I use Ubuntu

Did a unmkinitrd and verified that 0x70 is in it. After extract.

araj@araj-ucode:/tmp/temp/early2/kernel/x86/microcode$ od -x GenuineIntel.bin | grep "0070 2b00"
12102000 0001 0000 0070 2b00 2022 0822 06f8 0008
-------------------^^^^ ^^^^

12102060 0000 0000 00e0 0000 0001 0003 0070 2b00

Patches in my work tree.. I use stgit mostly
araj@araj-ucode:~/work/linux.git.trees$ qyet
     1	+ v2-bp1
     2	+ bp2
     3	+ bp3
     4	+ bp4
     5	+ bp5

Now just copy the 0x81 ucode in /lib/firmware/intel-ucode/
araj@araj-ucode:~/work/ucode$ od -x /lib/firmware/intel-ucode/06-8f-05 | head
0000000 0001 0000 0081 2b00 2022 0906 06f8 0008
------------------^^^^ ^^^^

After reboot that file is unchanged.

dmesg shows:
[    0.000000] microcode: early update: 0x2b000041 -> 0x2b000070, date = 2022-08
-22

araj@araj-ucode:~$ cat /proc/cpuinfo | grep microcode | sort -u
microcode	: 0x2b000070

root@araj-ucode:/home/araj# echo 1 > /sys/devices/system/cpu/microcode/reload 
root@araj-ucode:/home/araj# cat /proc/cpuinfo | grep microcode | sort -u
microcode	: 0x2b000081

dmesg:
[  654.103784] microcode: Attempting late microcode loading - it is dangerous and taints the kernel.
[  654.113807] microcode: You should switch to early loading, if possible.
[  654.613154] microcode: update 0x2b000070 -> 0x2b000081, date = 2022-09-06


> 
> > The filesystem still had 0x81, and can successfuly load after boot is
> > completed.
> 
> By doing late load through sysfs or what does "can successfuly load"
> mean exactly?

I meant by echo 1 > reload

Cheers,
Ashok
