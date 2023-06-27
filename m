Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54C7404E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjF0UVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjF0UVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:21:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7466EC;
        Tue, 27 Jun 2023 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687897252; x=1719433252;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qy/dcw9CRvXdaPKPkr81GE4x66hQbtQ6LxTxfwouhdM=;
  b=kL/rQHhXwwjCrPG+u4l4FZp1PYZznWcWQsZ2e/q9NInpAYhxQuC+Wa91
   Y8piGBPN7+EiLpPpe/K17ip83gBqr6qP7rl9ghIdGs7FwzpwPVjRRU1ex
   NUj1PtCzdOeziGNIui4q45pNk9dQtdee6HSmFUWWG07EX9KaXwAnFQupR
   WlFl979EHwtiJ3UTXcf40UgUqOz4+zQmwU7b9DfuljSy9SAXz59vLoVxF
   zquYLAHS0wtMAYX7OqGqPcmg8Eqj3hngsqQNAteomCy+qBxyK0X260bDk
   zAcydoZwQ6pPkn3YPrNLqJ0yiSQUjZe11LoGstZrjbRpPpooGSQyvGfAH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361715354"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="361715354"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 13:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="710779497"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="710779497"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 27 Jun 2023 13:20:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 13:20:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 13:20:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 13:20:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 13:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPVlGnJ4GLf7j+UEF/r00mEKzvKD1PGGs9vRlePuIbH+DfsbvYdDNRQK2DDxkzOadzGKN8C16ILk4qPcCw9tlBcO8XN03BgGNqB10Of51QMvlud+GxjTVpWJ0IflMEY2wBNloEBA/rlCLWPPG3iA9G49t9ZaOJuMr6DCFOAO9sOXUWFBwK5DQAVNdSZPufUcDybqmtS7jrjS50YsI0HFT24vCJwQHFU5kAo4YKM9eXs1R7t5Xkm7lShUONvVWWZCCQ2MmB+2ABPgVhA/i5s2DPJakRSZWy2UaunQzJuDBOSp4Z9KNjWriud8GpNRD0hadX2C1N0YWLq5W5jjOXl/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3l8pjmHm97BHX9WHQ6qsW+/dICWSO2DrDj1YOD4CF0=;
 b=cMk5+p9LXnB2SojCXOEUtWKfducW+VdIcTH0afwIWTsSHnIoISJmX2pLZTrjdyW1G4iiFUzwwQK0WXi+yUKLkUvhwD8mpcSs0EuW0jorLnAZ+SOm0KKwgLpz2ooDQelG2qqUl+QjJy37RQ4BDBbuRCQGveR66yU2WcVbGfCWDbM+zk9/Sb2NuJtVA4Q7GMP/AZeDw8hki6mGsge48luX6puCzByvDuVQoDPATU7niKeAbLCNwVSUUFH15NkHksvMHdq09p8UtLERA7NwSu4yM243VXNav3JVRw9jyI2lj1SphqHVbm0CZcjIHKBw1AomkQZ2v+kxGxuOYT0Gu1HpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 20:20:46 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 20:20:46 +0000
Message-ID: <10269e86-ed8a-0b09-a39a-a5239a1ba744@intel.com>
Date:   Tue, 27 Jun 2023 13:20:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] i40e: fix the wrong PTP frequency calculation
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>
CC:     <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230627022658.1876747-1-yajun.deng@linux.dev>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230627022658.1876747-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:907:1::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: bf084d3c-c365-4028-abc4-08db774bfd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U489sEb1TwVf1jNoLzrFgw0hG70D9AzzuTAbM5gECGAGGTyf8zLlmNr3dTDbnoaPmwahqCAEFAKT92xF6sN1ONra2UXc8rrEbHVRHmqYoTD5qhDYVD9VMrOYHvcLVfK0GrA5hCEdmR/dFkc4M9kT2gC0cSeYd6GCF9DKh+yiAXnOlvXa7VHPEZ8T7ZymaPE7RY0E1RSzmyitt/Bb91mkCIzeda0BG7e42Zk3ipKbCTE+MFqe/UjNHLMVCi+gtxVz6XKTXrob5YdVBUceypLc1Z0hWyjJReNgWji+d3jXLrUhZss18A1XxKJ4snijhkJweW66QlKtSPdWN1jdcWgpeRhnaeAhaDXkJV5LcVq468JkDxErEfsCbeDOHiuIjU/DkuC1CFQ0nuhJ6s3UKD3nVCDnRoiJ6vn/gbOyQSeeWTCd9QdCjDusxV8k5wy9mAxPQHCebyvpY4n0UyABCw7Reuf2fPOSt2iahWGtnEwMH4t+Z9XicyqIk+pBoKPa/6c7T+gU0Uzv3vGZ+bN/+jiRGU0zAHWu12BLwhIj/owvZFPEjczxh6IQZSkdLlHSAfIFdf+U7lMPhzVLaPMnL+vOB7s2BykusMQTbuWciXQkBCeClwDho/dVDjB4g7eucjyRIFyjORW9FHOPvysjxvBBIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(2906002)(86362001)(6486002)(53546011)(38100700002)(83380400001)(2616005)(82960400001)(6512007)(26005)(186003)(41300700001)(31696002)(36756003)(478600001)(4326008)(66476007)(66946007)(66556008)(316002)(31686004)(6506007)(7416002)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFxc0ZIVzN0MWJwNkI2TXJQQk9FS3JXTzU4NHBVdngyaE9IaTRaMU5DRzkx?=
 =?utf-8?B?Y05FdU00RjFXcDR3TzRPTGRFb3pSMytaZHc2K3NQNkFBMTdySFp3VmU2ay9q?=
 =?utf-8?B?NDB6NjJVRFQ4YjJYM0pFa0xTVUk0b01JcEZXOTVuNjQ1K1JKbmxWR2prUm5k?=
 =?utf-8?B?U3dHZUFocTMySnM0dzE5UXhOd0NhQnlRNWk2aW00UjVQRFpmSmxGR0ZnN0lO?=
 =?utf-8?B?ZXNaLzZMbjBxQlpJNFpYOEtHV2c4WjRnY3llQlk2d0k2aGhaZlNxTmtGN2tR?=
 =?utf-8?B?dlNZUHRCRGpva0d1cEZieFpHdUVVR3JZakRrMzJOWUNPTitqZ2VnbXhpcXJl?=
 =?utf-8?B?akdENXUyR0ozRlNFV1Iwemt0cDJucTVwaXMweThLaUc5WkNQNFZRMXQzZGU0?=
 =?utf-8?B?TnRZMWZ4dXRVM3V0MHBMQWZTaWtCUEtZS1JiaSs1VUlTTWNhQUFrUEZxRmFO?=
 =?utf-8?B?b1p0VC9qOURzcGUwWXFjWVFyam40YVgzZnM5TUNJcldJQVo3NEl1MmxOWUdH?=
 =?utf-8?B?RkFCNHdJSmhjaDBLY085eDBOa0dBeFBQSzN1N3QwODVlUXhEemkzSEwzK2xL?=
 =?utf-8?B?ZUxqMXdLaWdvUkZvU1dBUklhUTQ0c2JHM2ptTFd1RUF4dEVLa3F3QkxnNnFm?=
 =?utf-8?B?elNvNDdGa25IMHNoVlNCKzJ6cmV6S0ViYkVGekcvZ0NMbGxpZmp1TlpVRTlq?=
 =?utf-8?B?aG5BRGIzTmJLV1h4WjVJY0VxNm5ZNEw1dW9objFCN1VFWDJ5UjRFOHB4NU1k?=
 =?utf-8?B?UXJGNTRpUU9PS1B6R1FsZWxYYkJWMFhaVzZHMG9YcXVGTFBoeUZZQWZvWEFj?=
 =?utf-8?B?MWdjUm1EbVd5NjN0QnhCcE5Pc0JLckZYRDI5ak5WMTUxcXdaTUZUS0c4dkRN?=
 =?utf-8?B?TWladWI2RWxvSS9YUHZPSTN2QnptRkRUUDdxUFZycXFORFhRRjUxQTRqQyt3?=
 =?utf-8?B?MHFPOHphK2dpLzMyeEYvanhzbzBTbjJ3aUIydTBsNTh3TWxCb05ZS3NzR1lM?=
 =?utf-8?B?eHQxUmVGOEUyOW52eVpkTFJ0NDF6NE1hVk5hQytvVTEyeVJ0cE4zbGJxY2hj?=
 =?utf-8?B?bXNDYVJOU3lXRTlndk1nOEVyM1dIS0N2NDFORlkyWXQwS2tvelR0T3dIOVBq?=
 =?utf-8?B?VjhNcDJOajFGR3IzcjJlZHdaRWllZFJRQitTOUc0SzFLUERMTDRBNVB4S1JF?=
 =?utf-8?B?bEZSZmsrUWQ4RXNlWW0xMWt1bldUL3NycnZWQi81ckFxb3ZuTmU4cGJEUFkr?=
 =?utf-8?B?WENNS3JOaExLQm1KWWRCaFBzTDZlSUt4QjdDbzFYdnM5V1pFZUJJbDQ4WFlV?=
 =?utf-8?B?cGZ3dWdxMjdhME9DK2FmaGNEWjdORldYT2x5anNTVjdyckY3eG5PZzJ1ODhX?=
 =?utf-8?B?VWZBYWdwdmdYd0czcTNHK2RGYWJQdGZoUW9yMGFPQzNBL1hYWFBCaFVCY1Ir?=
 =?utf-8?B?eUNhcGFhMXBkb1dUSWd4QWV6M3llSlFkZTVQRWVuR3pBeTZZN3pETDE5emRQ?=
 =?utf-8?B?S0VLdGNzVXV4NjNsUStwUkF1bHMwZDNmUkFrcjhZSkNia29kQldKRXYzbTNX?=
 =?utf-8?B?WCtDN2dvWlluUEI1ZnZ0SWxtWTFqOUdISkNJcnB3MHRZdGZqVUpsclMvZ2p0?=
 =?utf-8?B?Sk5DNHl4UDQxSEFWVDZzSW5iN2FzQ0sveURCaGVKK3RSNkFsTkpFZi9nMFlD?=
 =?utf-8?B?eGE3WWhLaG1RRVJHc0FsWnpmZmpIV0hqQ1VIUTJiWk92aTVFMkNPRSttVE9P?=
 =?utf-8?B?S2N4NXVaTTdJQUlmYnZYdDJTcEdZc2NFSkREY1JtUitjQXp6eS9QUklJQ3Yr?=
 =?utf-8?B?QVBCT2I0U1didVUwNDNtTnhWTDBiK25vNlk5UTZGZ3FaR1pNajU3Z1ZTcldt?=
 =?utf-8?B?VGloNGNtaXk3Uy9uSThBLytIVGhJcWx5RTJVdkl1blVUM0gxZVJsa2F1YWJH?=
 =?utf-8?B?MjBOK01MY3o0RkJJbWVjam82Z1lqS0k3T3VrbjBjVlZOL2s2aHNMUVFpajll?=
 =?utf-8?B?RkVMWDhNbGxlcHYvNjB0U0RYdFp0a3RoZmUwOUJJVWhGSUNUNDFOL2JQWkw2?=
 =?utf-8?B?T1lXRm1XK0VqNXh2SHA5MkU5YmIrYit3YXdTUHk4NGM4OWdZTFpnMWRjTGxz?=
 =?utf-8?B?OFh2OUhkWVhGODdDUm1EZWNBWHo5WURObjh1eXgwMG05eWtnK2hibGppOHAv?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf084d3c-c365-4028-abc4-08db774bfd57
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 20:20:46.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fn0RIXSv1kVVWiD1W1+MxA4jxKWl7c9MNy1D7LS02QJmBjcZtEiPZrJXDY+Q837gGY/VIzviU2D8kikCVmOdvTa+CKjRp6UWywYJLvfpHMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/2023 7:26 PM, Yajun Deng wrote:
> The new adjustment should be based on the base frequency, not the
> I40E_PTP_40GB_INCVAL in i40e_ptp_adjfine().
> 
> This issue was introduced in commit 3626a690b717 ("i40e: use
> mul_u64_u64_div_u64 for PTP frequency calculation"), and was fixed in
> commit 1060707e3809 ("ptp: introduce helpers to adjust by scaled
> parts per million"). However the latter is a new feature and hasn't been
> backported to the stable releases.
> 
> This issue affects both v6.0 and v6.1 versions, and the v6.1 version is
> an LTS version.
> 
> Fixes: 3626a690b717 ("i40e: use mul_u64_u64_div_u64 for PTP frequency calculation")
> Cc: <stable@vger.kernel.org> # 6.1
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index ffea0c9c82f1..97a9efe7b713 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -361,9 +361,9 @@ static int i40e_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>  				   1000000ULL << 16);
>  
>  	if (neg_adj)
> -		adj = I40E_PTP_40GB_INCVAL - diff;
> +		adj = freq - diff;
>  	else
> -		adj = I40E_PTP_40GB_INCVAL + diff;
> +		adj = freq + diff;
>  
>  	wr32(hw, I40E_PRTTSYN_INC_L, adj & 0xFFFFFFFF);
>  	wr32(hw, I40E_PRTTSYN_INC_H, adj >> 32);

This straight forward fix makes sense. However, it wasn't obvious to me
without context why the 3626a690b717 ("i40e: use mul_u64_u64_div_u64 for
PTP frequency calculation") was where the fault got introduced. Thus,
here is that context for anyone else who failed to spot it just looking
at shrunk patch diffs.

--> code before that commit <---
> /**
>  * i40e_ptp_adjfreq - Adjust the PHC frequency
>  * @ptp: The PTP clock structure
>  * @ppb: Parts per billion adjustment from the base
>  *
>  * Adjust the frequency of the PHC by the indicated parts per billion from the
>  * base frequency.
>  **/
> static int i40e_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
> {
>         struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
>         struct i40e_hw *hw = &pf->hw;
>         u64 adj, freq, diff;
>         int neg_adj = 0;
> 
>         if (ppb < 0) {
>                 neg_adj = 1;
>                 ppb = -ppb;
>         }
> 
>         freq = I40E_PTP_40GB_INCVAL;

frequency is left just as base I40E_PTP_40GB_INCVAL.

>         freq *= ppb;
>         diff = div_u64(freq, 1000000000ULL);
> 
>         if (neg_adj)
>                 adj = I40E_PTP_40GB_INCVAL - diff;
>         else
>                 adj = I40E_PTP_40GB_INCVAL + diff;
> 

So the base here can't be freq since we modify freq above using *=, but
using I40E_PTP_40GB_INCVAL is consistent.

>         /* At some link speeds, the base incval is so large that directly
>          * multiplying by ppb would result in arithmetic overflow even when
>          * using a u64. Avoid this by instead calculating the new incval
>          * always in terms of the 40GbE clock rate and then multiplying by the
>          * link speed factor afterwards. This does result in slightly lower
>          * precision at lower link speeds, but it is fairly minor.
>          */
>         smp_mb(); /* Force any pending update before accessing. */
>         adj *= READ_ONCE(pf->ptp_adj_mult);
> 

Finally, the multiply is applied last. This affects the combined base +
difference, and is done in order to avoid overflowing the *= used in the
original implementation.

>         wr32(hw, I40E_PRTTSYN_INC_L, adj & 0xFFFFFFFF);
>         wr32(hw, I40E_PRTTSYN_INC_H, adj >> 32);
> 
>         return 0;
> }


---> code after that commit <---
> /**
>  * i40e_ptp_adjfreq - Adjust the PHC frequency
>  * @ptp: The PTP clock structure
>  * @ppb: Parts per billion adjustment from the base
>  *
>  * Adjust the frequency of the PHC by the indicated parts per billion from the
>  * base frequency.
>  **/
> static int i40e_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
> {
>         struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
>         struct i40e_hw *hw = &pf->hw;
>         u64 adj, freq, diff;
>         int neg_adj = 0;
> 
>         if (ppb < 0) {
>                 neg_adj = 1;
>                 ppb = -ppb;
>         }
> 
>         smp_mb(); /* Force any pending update before accessing. */
>         freq = I40E_PTP_40GB_INCVAL * READ_ONCE(pf->ptp_adj_mult);
>         diff = mul_u64_u64_div_u64(freq, (u64)ppb,
>                                    1000000000ULL);
> 

Here, we assign freq to be the I40E_PTP_40GB_INCVAL times the
ptp_adj_mult value, and then we don't modify it, instead using
mul_u64_u64_div_u64.

>         if (neg_adj)
>                 adj = I40E_PTP_40GB_INCVAL - diff;
>         else
>                 adj = I40E_PTP_40GB_INCVAL + diff;
> 

But then the diff is applied on the wrong value, and no multiplication
is done afterwards.

>         wr32(hw, I40E_PRTTSYN_INC_L, adj & 0xFFFFFFFF);
>         wr32(hw, I40E_PRTTSYN_INC_H, adj >> 32);
> 
>         return 0;
> }

---> current version with adjust_by_scaled_ppm <---
> /**
>  * i40e_ptp_adjfine - Adjust the PHC frequency
>  * @ptp: The PTP clock structure
>  * @scaled_ppm: Scaled parts per million adjustment from base
>  *
>  * Adjust the frequency of the PHC by the indicated delta from the base
>  * frequency.
>  *
>  * Scaled parts per million is ppm with a 16 bit binary fractional field.
>  **/
> static int i40e_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> {
>         struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
>         struct i40e_hw *hw = &pf->hw;
>         u64 adj, base_adj;
> 
>         smp_mb(); /* Force any pending update before accessing. */
>         base_adj = I40E_PTP_40GB_INCVAL * READ_ONCE(pf->ptp_adj_mult);
> 
>         adj = adjust_by_scaled_ppm(base_adj, scaled_ppm);
> 

Using adjust_by_scaled_ppm correctly performs the calculation and uses
the base adjustment, so there's no error here.

>         wr32(hw, I40E_PRTTSYN_INC_L, adj & 0xFFFFFFFF);
>         wr32(hw, I40E_PRTTSYN_INC_H, adj >> 32);
> 
>         return 0;
> }


Thanks for finding and fixing this mistake. I think its the simplest fix
to get into the stable kernel that are broken, since taking the
adjust_by_scaled_ppm version would require additional patches.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

