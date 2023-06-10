Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1A872AA5C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjFJIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 04:41:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A633A85;
        Sat, 10 Jun 2023 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686386500; x=1717922500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JwfiYm4gY9DUSeENknUfyvqVkuICsd3+2zCE2VYCmD4=;
  b=httIyYxN7VpgCX6N0TZAHxy3BMULTyKHxyfThBlTpzK/onPdSvh02nDh
   2Ab8QlIVI9zvhCBf1g8v9U9Jdp+OCOUGcqOgIsc6r1QJnY0hGb35Slrc4
   EAP0Gdf0UYncJWhHS26dIsL3gqnKQTUSh6IKAHBAfCBCL/vp5bx3p2M6q
   iypataDA7UpDjEN+jOVqeZ7QGQ85DndDAgJcELN0WiYvqjwPCpk8VmSBt
   8A9oXwCq3Wpf3saAew4ZfwotK04pmd0161IIFbBfHhVQx7SjVyXTEfCZd
   iropIgZg4K6oqFts2kTDVDcE+8vdP1TMFebLYJZGWeA+/V3zHfNcFBWXA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="386117428"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="386117428"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 01:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="704799341"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="704799341"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 10 Jun 2023 01:41:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 10 Jun 2023 01:41:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 10 Jun 2023 01:41:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 10 Jun 2023 01:41:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 10 Jun 2023 01:41:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKP327azr0PKocXZBu0tm15UNVg7fRt9dOQnrCyPgQlbAp82Se4LpscpyiAo42WtAMppyQTZ0hO5HWW3U0Gj/R/rbg6PPeKVQbLzApuyUsKDUGOhXPnoWSBECpFyg5nHjqWWd8clWgwIvpQE+Itst/nk/LqhpDBRDQwPy8tDHWJLdV0ejOlObfo/1CcGGkZNiuUt7jtTiU05TAPi/ZceM6Gu4o+qkutvnpbYZ99XydoHHjYMY/bi1gpF8TFsHFvpZbeieikmQDTZ13YbR4y2s0wP4Ad3BgO22OzhQlHLyjMPBVogCIY7MAQQZQGEUE0FKQLKPaPi7UfohDMxZaBDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz+iVUH+4YpqykrSkvCeyHKeg+C4TVoy96R8lQoVDhg=;
 b=V58yUhjb8fiqJdVEeppCh+OHclgtaQjOiS0nnIgFndGjCM46bUVKozJWDm/ML/Am8SoDqeEHbSi2jkLIsgobhgAe3di2zkTsVEc00SIHyi4St30nFIu5xCFKxvNRRNW8m4kO8rG87LSQwqUNb9ka29L2dGjxbXMKALSaYjciUvRBQEGSELYpV2JhMWW4Kmtj1yfHObMi3G2/QRBnfMDN6VBlgV6hPo7rH4MN3pH4w9P2ELNgYx8BOAm9e0WR/r6Hk6re9wrxAORLKpaUlRBZCZQ8u2jJ70tcKN2tvVjjhh4m5w6YZ3gSa5El5zw667qx/9e16t2loLUmNU+EumxQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by CH0PR11MB8192.namprd11.prod.outlook.com (2603:10b6:610:191::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sat, 10 Jun
 2023 08:41:38 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329%3]) with mapi id 15.20.6477.028; Sat, 10 Jun 2023
 08:41:38 +0000
Date:   Sat, 10 Jun 2023 09:41:28 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "meenakshi.aggarwal@nxp.com" <meenakshi.aggarwal@nxp.com>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "V.sethi@nxp.com" <V.sethi@nxp.com>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "gaurav.jain@nxp.com" <gaurav.jain@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iuliana.prodan@nxp.com" <iuliana.prodan@nxp.com>,
        <lucas.segarra.fernandez@intel.com>
Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Message-ID: <ZIQ3OKYyOcwRIOLR@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230523165503.GA864814@google.com>
 <ZHh0DF4meU2ze+g7@gondor.apana.org.au>
 <ZHh/zqNu7XzwJTl5@gcabiddu-mobl1.ger.corp.intel.com>
 <ZILvtASXQKLG43y9@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZILvtASXQKLG43y9@gondor.apana.org.au>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: LO2P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::25) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|CH0PR11MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: c31b9168-0127-4615-94da-08db698e8109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2N2VnjRhrjcgXDrhYkK/EpUP0jh9EGcvTz9bYUp1GiBcQKc+b7acgqO86TbXHUri4mvNHcIVT9MVJkhuhIH/qqjVi7Jk8FizT5pKl8RtuCrLFuR50sT4BGhECNiVpF+IF3LZrbJFDYJwC91f05OJhq/znlzI3cRjTSO0au3FeKH0xLY/SDnZqWNJ4syQHIViR3yxG59Rrso8VSUgDIg/7qomPhRnUUzq/xtDfESxKnJUFJnQTL4l5XkTit7XPLtNTUEiM1fl7/6Qpsal1q5o+dyBmQeVwCLBMQnI0bXfMxeP31+shVp093OnG7vfgybxkNZdu7K+ORplOAQxLF403Oo5/LqHPxl/RffQ+gNVUtOg/1WQ1b2hQwsQEfPmSBThT4hWfLhZUBW4Z63BkqB0GBMZvckDGLl2ito4aMJnGsqBp4s0jBAe3l7rebFKDggdwB0NKjHjbdfugJuvLYSqF8PpV6GA9hZPR+M+Cl34akhs4NadGOJxAOvrsB5hd8MdFo0Dh6Y/3tAisPLmgtmYAKbaOZRK73yREVC8ifqJrknPJEsjij/4EHtKhF/dclQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(4744005)(2906002)(86362001)(44832011)(7416002)(6666004)(36916002)(6486002)(186003)(83380400001)(6512007)(6506007)(26005)(107886003)(82960400001)(110136005)(54906003)(66946007)(66476007)(66556008)(4326008)(5660300002)(316002)(38100700002)(478600001)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y9CRjJj9ulbLFyZNF674i/UZyqFREiYrIadHY0Lw4bEXxz6DplQGvjAVtvfX?=
 =?us-ascii?Q?jc+8qzIFsDobuxvAFBCyLgaZq4yffUyVebY8bMYz4nSiJXlantIz1y20rGWw?=
 =?us-ascii?Q?cQCmhuvDbDZc5QfH9wU9Edf32O2GQwMzDYVoUpRJqXFQ8kNVe82cOfSslldM?=
 =?us-ascii?Q?N9ifS3NIxnlk7bYylOlZumlJRZuw3B3zGGF+f619ezdMpWo/fmvSmjcbF7rM?=
 =?us-ascii?Q?APUtKby3Z+iFiix0M80rCR8A9FMge9LMwh1rBLpF0Vjcm3fCVvjx/nsuZ/kD?=
 =?us-ascii?Q?grZdxDdpkirs73fx+NyPZDRaz1cpBz2kDRFvkkjDo6vaiFW5Idur6SimzbQG?=
 =?us-ascii?Q?eWMbNg3sdzv8tJVu8d1gzcFgo+AE4Jq6Uo3u3Wc6F9Ajen6cffjqbXxsBmxh?=
 =?us-ascii?Q?myrPzGli6+vLny7JMRhYzSUdw9f/36n3uplZ7yvFTyKRQYs9RaLR+KOA1xEl?=
 =?us-ascii?Q?Ix/E7jcWEIO+D9n19HV10XpJTy38YjBBE6a7hM/VVDUSXGGe53YiK6lf4twJ?=
 =?us-ascii?Q?vRmc+TmV811KapBJZbX+4847y9MQsziSkbLEEryiFb8Qikan977PATWb/28R?=
 =?us-ascii?Q?jbGR6IQWs0lpdW+uexie7CQsvvLyNPXr3bjnqt4C2wPwFTJTamdVSJweDLIy?=
 =?us-ascii?Q?mTWmTocuPI2KWNaqQcqnoDvwp9C3TXrymY4uQ0Mlf6LjJxG9Z2vSSGAcMund?=
 =?us-ascii?Q?uf7QJfkKuYHka/N90QsKuf534vKx1es6GFkvaJNlcsPbQDH5pVSZv/0zVcqP?=
 =?us-ascii?Q?mUdjTSn534mngqAqfod4WytchFyJhpkVhWX+lALHvhGbKqm3KEEeaHA6D+fE?=
 =?us-ascii?Q?ascC1GO5K52MU7If0XQQyGzb5z6EsQWDdarAyKW5g7dTGIk0VT8qd4Nb/ETj?=
 =?us-ascii?Q?hA2GXwunaabj6/kng3XhExZVyZR0YZ3v3LOUhZR47pzNUtN8Mwt46RAnTjxD?=
 =?us-ascii?Q?wLIL26NK+duORVC59O0ZXQ07IqyrJ22i4T8oDoKigzcy+TPBtjrDuxT8hwTS?=
 =?us-ascii?Q?MdEE6YKUEwSlG9kVe2jhzXNpSUXXBy1ZNsXcI03/I9zp5y7dZqAZs2N+rK6C?=
 =?us-ascii?Q?kLZTTk6VArTF6aPlpmoDjpBeJ1LJCofsprT8aCWgVlQPJg6/1RANCoUBkaLg?=
 =?us-ascii?Q?Ny3Oi+O20pYqu1Dmv0B/NnxPp+fABq+1exxjL4icxACuSKj2OYd0tb3zDY1O?=
 =?us-ascii?Q?5mc73JA3HnTAFr6Zd7WXO3/nGQq+bZd6fxC+w5G7G+nPgiwAaugYXnMUwBbH?=
 =?us-ascii?Q?YW9k+oQXKcIYaiiMcnjM246vEkIEgpxWk27TIP8GH7XmTp6GNahxiS2tD7WT?=
 =?us-ascii?Q?+u8rRGqgecjcmy8WJvd3dH9V6ibRDlQYSv12/UelYeD6DAH6lGrs5W1Bnuz3?=
 =?us-ascii?Q?Yb7p4bdkmR+W3DZTfxtD+xKjVe2NS7vOHmPjUvuqFszpJ73w5N9FttVWICVE?=
 =?us-ascii?Q?t8Gg8Xn0sCTEpucbbmpjnXL/TRZEFXvwa7AQGe1yLVCPdsEKiN4sOtO2evWf?=
 =?us-ascii?Q?fC2H2B8LjxlicoetZq03hkyFi7CMeFSwBIcVVSJJ/uH+qMnfx+OdhNhnDt7N?=
 =?us-ascii?Q?YvftpB/rtlMGyTaD4m9lDbNjcNNvR071pqVWKL1uPpiI5ALsTrhDZZNRjrno?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c31b9168-0127-4615-94da-08db698e8109
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 08:41:37.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qedw0mnaOsbmIBArczis3AoQR4D7ZLyFvfv7Bsy2KL2ldBQu740clQV7cQDNr9OVFEy+cisrGe5dJSdb2kUi0bIDuQqlyvJ+GGE9wTSeX+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8192
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 05:24:04PM +0800, Herbert Xu wrote:
> On Thu, Jun 01, 2023 at 12:23:58PM +0100, Giovanni Cabiddu wrote:
> > BTW, some time ago we did an assessment of the users of
> > !CRYPTO_ALG_ALLOCATES_MEMORY and we came to the conclusion that we
> > cannot just update the documentation.
> > dm-crypt uses scatterlists with at most 4 entries. dm-integrity,
> > instead, might allocate memory for scatterlists with an arbitrary number
> > of entries.
> 
> dm-integrity shouldn't be using ALLOCATES_MEMORY at all.  It's
> using GFP_KERNEL allocations right next to the crypto operations.
If you all agree, I can send a patch to remove CRYPTO_ALG_ALLOCATES_MEMORY
from dm-integrity and update the documentation in crypto.h.

> But those are some seriously big crypto operations, 16 thousand
> 4K pages in one hit?

Regards,

-- 
Giovanni
