Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494960BF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJYAdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJYAdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:33:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B71732053;
        Mon, 24 Oct 2022 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666652260; x=1698188260;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QG/H4vT6f/BBCHoPPV9+mRw3d6eVatVvZ+zJ5W62oAk=;
  b=ORxgEXezY29xJlTcYZCBzR0d0GE3m4khmNSUMRCMDpQO7r80JY7yJ23W
   +rhJHHRLhpJzsLgXNasjNdhCwcJcZ8asvG/lAeEZWSYaC6RssKX+JZJ55
   X14J+brVaG4Q1KObcTryp7OrZYtSl6MivHys/0sJrvjmsuNru//wA8TtA
   B2iqz9moo2bkcGd8S4K1XyMKVn3Dz3dKNSoTEgCumvSCtm1UM61ePu53L
   RNkdkAJBgaN62HWswuWT5pjtz8G7iUAVF1PioSUysEfl65t7t8Zaymrg8
   HBRFvj9wNVtbLOLw7BJDMexvaEvRvDQkwSjCdPNRvhULBJdufO+eJdK0T
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393855468"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="393855468"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 15:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="756732329"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="756732329"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2022 15:57:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 15:57:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 15:57:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 15:57:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 15:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhWUGn0xGWm8Qx/b1nzrv8oEkce4BGcpBEbzcYx2UHZrEpI0YYzIXR7YFjOpT35z27BQFKsrcQ8S3ThQBKMAzxIis0JQrZtaatd5tKbq5e7q218zI7chd95bYh4Ge4C+OodCwjRZmlEaZc3tjvMPT8+L3rMk04390whnEOSg0JDpCUQ9s0tXWSRCYUSypxaQruR7YtCnPJBVRXCNSsZxnwqB3nYjgDMx3kOn2hITvNjDNAeJYmCw1OWBIKDtm/2ak9oG1LkuIpfj3jcf67LCt12iRkPMyrGOW0TWVjM4+s9CXkaI/Cyzzp2Nm1Ilv/RjfGfbv0KwjFF/xsyqMZC6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9KxY31KsWILm7V6H70IFxuJmy4Nj42QKdXhIOk36z0=;
 b=b/6LTdCLtYS+P78y3fKqjTA8fStsgu+ohlbGvqLR0BeSrqopGxAmMTDwgNM63XrOgPJWFPK2FJvndW4Hq8KUnXXf3o/CGBTHLIVgBd30JzwqoiLWAnHqrz5xZPWPGtL9p7f9qsWvbAzoTK03GariaFmiR5xaDDAoSaW5W65nesNOA3v55lnjk5VuXjR9U2j5CwBTOKgn8Nm57ahu25e1fRYQ3sLnIMk5CbRsx/ByVoU1xZE86hiy6UGXZzA/aJxLGTz14WIsIKZVS/BPANukp9Z+9/Qo2KLswcNJvFv4dFLQa3Kvx6X1Uf5FT/zas6xlHVUrlLz1DDSSOyv1QrTCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA2PR11MB4875.namprd11.prod.outlook.com (2603:10b6:806:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 24 Oct
 2022 22:57:24 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5746.027; Mon, 24 Oct 2022
 22:57:24 +0000
Message-ID: <238b55b0-7fe6-4923-ef8c-fb1cc1cd1c66@intel.com>
Date:   Mon, 24 Oct 2022 15:57:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 03/14] platform/x86/intel/ifs: return a more appropriate
 Error code
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-4-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-4-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:a03:331::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA2PR11MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: 49cc6d18-5cd2-42a9-5f35-08dab6131d56
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfR6sikUoU3Pt6aIyExnfOg57lUn2PGzo8RX+g9NIrZfMlCaAsWSP+rISrsofAbjAQarwF7FpHOqoTDS365OpoZqST3r7ul+LImsvMRYOd3wNP3XpCW5PXyegW1mhUfois2dncdAuzomzmvYYlsZLa8emnqoMs2z+SGiXxZQBHwHdA2nPP5HIJ/xXt9k5XaaXqYzYkluWbBwdUK67z6JFvcASZWn8hH8vxrROK5xzTmhYpLnMoOGNGmZkl1u0HPKoH2i8CZnTx35w/K7mZOsvpQILPWQo8gj3uh2dHw/RUhg9Gygy6fET8OzdFEBtbi7nJrFpFE/lLePB5t5bTw0En8wYlGZ6lJsU4tQ3G9qUdV39yrm+ATFKj0mHUVl0zyl7ySEfWuUl8K+BJZTQTSDwyNHLAdxmnyC2+GyMjcJJHNfNYBKvq1KcJ99/Lw3solUSLjPw5oaGQI6ZSz86IGICNpKha46njlplXSBV2HcVcy115Xp4xLe8FuY4yXJCFvPPbQg6RAR3yOls6Nz7lI/YaUIs/L31fpHUm7cLLTQsubWYX/ZYTjGQlE5tXeW2KPbjpw9r9MMPiwqIA6x3UVfnz+3YuSimTFEuVD3arwEtgVf5GINkAzVPxMfQdnbrjg8y8oxle2CttIfHXqmOTUUUHgPVHe1fsRuL7hOttKy77llLtBmWbCGcIJJrc2incgmu1Wtx8yRrRYQOPtK4Os3RkShkpNM7wsGdO4o6/ttyPSeJreFm81Kd/tB7ZKAvvCRRaYf9KAmiTFZnfPVEKfB8qidIJQI6B9w2ZpUkOhZzPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(31686004)(36756003)(6486002)(82960400001)(5660300002)(4744005)(66476007)(66556008)(66946007)(7416002)(8936002)(38100700002)(6862004)(31696002)(86362001)(8676002)(6636002)(37006003)(2616005)(26005)(186003)(6512007)(316002)(478600001)(2906002)(41300700001)(44832011)(4326008)(6506007)(53546011)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxwVld6RHByRlhUcTFZVHdVbExteUxYVjBRbHRHaGdIU25OblRlQmN2RkVs?=
 =?utf-8?B?dG05M1NZTFRNKzFXR1dLQ25uYjhWcnZRNGFMMU9GOTVxLzFTVlBiNjRRdEFH?=
 =?utf-8?B?WFordGZDdjFRYy9yQjczeHRmMVZjMnVhUzNkTHBJUW5OR1M0ZDY3UjdQRXlS?=
 =?utf-8?B?ZHJaanV0ZGk0azZzYVhtdHdISWdtZVBHdjM3QzhwV04xVEIxdE9BQjBHdmdi?=
 =?utf-8?B?andndE9Kakp1T3ErTEQrRnRvdGpnRURHWHhTNStUblk1QnY4SUxFdXRKVVFv?=
 =?utf-8?B?SWFLRzBZUXNiUnpRQjEwM0g3b3FMUFl0RnhsN3pFM0drTmN2SWdUQ1dWQW9o?=
 =?utf-8?B?NnVySXNib0owZllablNFTDV2dTNBTjZoaDV0Y3NGTVdXL1N3ejVKRzczVmg5?=
 =?utf-8?B?OXhPcHRaY01wdE5aMVFSRWp3UUkrZFJhVVJvMnN5WjBoY0U0YnNwbkNyVmxL?=
 =?utf-8?B?RCtxYUdKR0VWR2s0Tk5DbDVXVERoSUlQMlNmK1VwWnFOb3NtQkh3N2hOMUtL?=
 =?utf-8?B?aVhOSVNvR2FTdnUrQVlKMXQ4M2lWWXpNTVIvdk1rSVAwL0xxWENBdzNQRkNa?=
 =?utf-8?B?ZzhaZjQxc0YxY1JoUlBkNkhEeE90UDBjdHB1TDcxTlZmaHhyTXBRMFBJTzB1?=
 =?utf-8?B?eDd6b2ZQbzAxV3FhK3VDMzBoWUNDMnVOS08vK0pVbXNmTWhGZFVzZzdxT3Ji?=
 =?utf-8?B?NUo1c0k0QnVYNXR6a05HaUovK0lnNUN3MzVBRUIzZHlnYlVYak5WZmM4cjlK?=
 =?utf-8?B?a0RKZm9RYW1ScGtRMFNKNTFNUjgvZ24xUmlwQjZCbStKS1BNOUNDRDUyRnJY?=
 =?utf-8?B?QWZjaFUxbzZrWTgyS0dqbEsrTHlMektGMDFFQXF3a1AvajR0SWlVQXZhYUdw?=
 =?utf-8?B?V2dHTDRNRkRVOExKeHNSQk9mSktKbk92bDJpUEFWbDJxOVBuWHVFcDFXUEJh?=
 =?utf-8?B?RTh4L252TEtLM1lqd3hNaTdMTnNqNWNvYUs2bng5Z084dHB0V1Ryam8yeUg5?=
 =?utf-8?B?cE1rYXl0YTlJVWFzR3hOalFVd2lDMzJQVEhtcUl5NmtSVXhCM25jRzJlL1NM?=
 =?utf-8?B?Q0FXR1doYWdWU01BNkc2K3ROVGF0TWpIYStPNElGTTFLL1BKOEJadzhLdXlM?=
 =?utf-8?B?SVFaVVFSOXhhaWJqdWxwdS8rUk5kQ254RHpRdk90eUUvVWc4aFE5RC9qb0I0?=
 =?utf-8?B?a1FZUWR0VHpsNC9ldHpKSGdkNDV2U3o3ay9WZGJYOCs3eElZd0c1S0FLdk44?=
 =?utf-8?B?RUo5MDFUV1Z2bVYySDYzK3RMdGthVUZyeDFobENxbXpOMnRrUVdwU3NRUWw4?=
 =?utf-8?B?VlVVV1EyMWJ1aG9rYTFONW94Y3hMMlI3amx4TzR2LzdETFIwOWMwclR5Wk5v?=
 =?utf-8?B?bTUrUFY0c0xmWDl6VExHZTRKdlJvUkpBallCd29adzFxRVRpUFNYaERlTjZG?=
 =?utf-8?B?M3llMzZDcTJ0VGFkNmFMOVFRdGRlWm55WVlTNW41aVZhT0kwbDNFRjErSzA4?=
 =?utf-8?B?ekFoalRsSWVEYkFrbDBKQmNWWmduVW9uYzJHNFVTWllaUWpONnNFeGpjVGMz?=
 =?utf-8?B?Rk1CWFpWMGRGZjhlT2xhQ1pBUDlyeGdJVndvZHdQaXdFMCtCU0pFZkF0TmRT?=
 =?utf-8?B?VjRXWTZPMkMvRWMrdlNsejdkdEtLcjB5ZVpINElNa3N2eG43MFp4WmlPZkNx?=
 =?utf-8?B?TVRpVStEd3dvTXNaVjNzSXJmaWVlM1RaemU5T3YyRDRGL3ltSFNLZG8zbG5a?=
 =?utf-8?B?UHRjbDN5S1JnL2lseXY3RTR4WXdvQllxWkorTUZkRVhZQ1BPT0tlNFdCR01h?=
 =?utf-8?B?TGtudlA3RkdjcHBUbDVmVUZwRWpDWHRBSFBXTiswYmhVZ3huYlRGRUlrSDJR?=
 =?utf-8?B?ejE3eVQ4am56MUFydXhYY3k1U2MvdjIzbkJweTI4R29oakJBVk5xVnpwV1VP?=
 =?utf-8?B?UjFqR0hJSWlnOUxFNlpLaDNaWWt4d2ZJY09STVJERmVQWFVyQ01vUVJoNGVt?=
 =?utf-8?B?OEoxMTlIUytVY3RKKzJGZldNdnBvTkd1K3lOT0hmN21rZ2hIcEM2WDFqWVN4?=
 =?utf-8?B?cEo4TzdQSHBjaHpDZWxUWml2ekRCREk0MUtQVlJlZFZTWVBFUVhrc2NvQUJx?=
 =?utf-8?Q?P12qRYjm4lMLRANXKagYmqzAp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cc6d18-5cd2-42a9-5f35-08dab6131d56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 22:57:24.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Md5Dz8yPWGnZReHiWHD9hicG9OpKcSct+J6vjXyy9+B1HF2eY4qxNU2poWhWJZsJSqQDzqOGvqjTc9DTdmMCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4875
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 1:34 PM, Jithu Joseph wrote:
> scan_chunks_sanity_check() was returning -ENOMEM if it encounters
> an error while copying IFS test image from memory to Secure Memory.
> 

Same as before:

s/was returning/returns

> Return -EIO in this scenario, as it is more appropriate.
> 

Do the first 3 patches need a 'Fixes' tag? Or is the idea here that the 
feature isn't truly enabled so everything before removing the BROKEN tag 
will be considered together?


