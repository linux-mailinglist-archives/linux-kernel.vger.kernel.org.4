Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92925EE87F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiI1VnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiI1VnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:43:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BEBB0B1E;
        Wed, 28 Sep 2022 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664401387; x=1695937387;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B2EQ6JORraOH1p08NUpPx7y1ucU7Zy/UEJiAmgLiCHs=;
  b=dZrl+dx8ZezoZeReDjZKYmfL4lN9YeXc1jMqQYud0YiQ6HwHqcgrENkV
   nIJoe2MdRhhIJTi+z4eSTe9EmvOdL7KISQbfFyeLx0EYGRuOB1Y9+8T3g
   dHwf5dn6+8hx0jZmdlywpsNA4fQ/P5s3xw5lVRFbTu46bbit88vsdowJw
   V1HG3K9c+HVIw1/klWmkS7tQP2upkNSjs4z5bhz7YPDhnWJV1D6qt1BON
   pvnzvnyULib0n/MFxwbQjziVHfaeIT7WKu1IGFcuqXZcwpLcHhdlneM9D
   W4HRhkc7ff00ms9dJHNYuJRROhQI7dJ85QMZWYYJhY4xKGiqjEMSWjUmq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="284856142"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="284856142"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 14:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="684571898"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="684571898"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2022 14:43:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:43:02 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:43:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 28 Sep 2022 14:43:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 28 Sep 2022 14:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZRtUea5FVLAY8KiweRbVWee6pPe0wENZd/rOpjde2gnuSIR8Us/MYhFikr6tGxeGteF2RL43nkdakCGQ2XpnA/cK0+FZ4/+QN9hKbkTkW97RI3AhUJ5tUN5ZQn6dP2MeG+VrQZXmnnMOFKKS+9a7S0jRtt/5JmUbumykELESJzGuggYUpbEyl7lBz5vCzRJMrm84Lq/gz5U3ekuubE5CmAANRivIWk/UcJlE7mYF7avPmcI7H3ROyDFPIWQd9qtvvIQt4jpAriBA1eNBFRNOuD+qWvoBE3ZYHwadgq3KiLson+ZiqZPPUVBXG4pNzxlkit7FzklT9aczzgko3PkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVaxNcNME0Tspfiv0/dDhflgWTIPeD6Gd2Kxm+mnxbw=;
 b=ExUP/KLuDOkn9flgF4ux+Dw3PyQ7wn3msdAmupDlYl6+zKmjR/LKOpMBbbTRgv90JqOuF97SUUXRlM1hh0X+Q3vE6XjH+UJAWW781kWrN6jqPUVDkOsNVcgYiL3h3P51VBMQA/rXnagnljbdh2C0X/PW/oRPZkKNYd2kQ4gGa9Q4lEtdMuGgHj31K30E7r8JiAExt6XJYY+StTeJEfX6IvovUtlKUqsktb8DS5Xlir4Dk1vN04OHRWxiIvC5h1YgFKVTiGdFVZrelnVHrM8XXPn//xhRuz4CzPSOCZqRJJOIa2C8rX5HIEWPuAAbE6+rj5xF5qr9PI//5Alrhkd0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by PH7PR11MB7122.namprd11.prod.outlook.com (2603:10b6:510:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 21:43:00 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::552f:d94f:b6bf:e339]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::552f:d94f:b6bf:e339%2]) with mapi id 15.20.5676.015; Wed, 28 Sep 2022
 21:43:00 +0000
Message-ID: <c4509d3c-f778-e00a-3b28-361b9321c229@intel.com>
Date:   Wed, 28 Sep 2022 14:42:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] test_firmware: Fix spelling mistake "EMTPY" -> "EMPTY"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220928211637.62529-1-colin.i.king@gmail.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220928211637.62529-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:408:141::13) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|PH7PR11MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6cc3ef-a583-459c-10bf-08daa19a69fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: On1Gdbf/qRRzzudg4+IRsDms2VeR3A5McsgmUbxfk4AqIpX7LUZXhTyBrJzk4z5lsEuAJD7T/j7RpWj4lx3+KbPbmq0kNNTnNwgkyGhwckD0XFmL9OWCpwYVy+bVBQOpi7c1p/zh+DW2raIGqi8OL74a3RDpTEdhjiVdhMlxEcrJ3Sgo1AMrcadEc90+L/NeyR4ueLKsmOEA7e8alRQGq8QYH7SjoIoJOhGiHrUbpOctMjBi0LNDFsz7dfVgvXwSIG7ehio2lJ77V6+wMcl+Jg6HAEdwpppEvNq2XXfI7eoUslrwAiKTWK0liUHz8agI4fqufJJ/Mfp3dI58/YUW6kclGCZjZL6jlwTHPoO23K3v4TwGotTXjsAjo78R15WFI9x/iHxkXmyCFXri/AkAzt/3sluDKGIw5EL1MPdEa9Ub2IP3FKGZlJxn9nGLD+LpAoh9cpl0eqgqPq+p95V/DrYWauObBrgCEUupFhPC+2RZNTKq9jC+nY1IVc/MSgeIG4SheGqG4zQK6/gOAmP97WW9UFwtTe8q3FIlGfl2HoBABcLTERVYkJ1HTfDXp2/slIC8jSNIL8f4r57/o350AXFZw5AOh8q3VHWj2DDYuxBF+zF5fhM8QMUHdpp5jumGdLStqLAIfPUyk9eXMGrCQs2tD2cbxzsnrnVMX1GsYs6y27yagUOopwbDuX2KDjDnscpp9ZGN5K9TZPuuIg3LAZitlnaVv0XgwdRXIPvdh5L5+seckwiY2l2pWlOsI2r3NPyoK/OO7BRYI2jHB/DflgfYwNyIeJq5fhgGuVbWsgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(31686004)(31696002)(66556008)(66946007)(8936002)(36756003)(2906002)(41300700001)(66476007)(4326008)(8676002)(110136005)(86362001)(5660300002)(316002)(82960400001)(6486002)(38100700002)(83380400001)(6512007)(186003)(2616005)(26005)(53546011)(6506007)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZxcE1xUzNOaFJlbkhaQlBrODFheG91dlJDNFB0a0dVSmtJc0pRL3NZRFRa?=
 =?utf-8?B?MmRVdURhU29naDR0UEN4OGlLSk9rOW5UV2VzZ2lzUnpWREtZU3FnbVhuQjNJ?=
 =?utf-8?B?cGMyL2V4bXc4KzZsNUpRbFluWkJZcmo4ZEtmMTZTdUZpMU00dTNuS2g4b05E?=
 =?utf-8?B?KzhrWk95NG1lL0FibEtPVmZZZ0lvalpNOC82L3B4Y2VLNTBVdG9TY2NrejEx?=
 =?utf-8?B?N3ExMzlydEVYSDdNOXk3SXZ0b3BEa29JbmVIVGJUVUw5aGc2bC9RcDZ3T1M0?=
 =?utf-8?B?VXJZQ0hFaFBGMjBJZnQ2WnZHWmN1SjNWOFAxRlRxUUQrM3ovK2VCZW54TjVP?=
 =?utf-8?B?S2FkSm9ESEhMYUYyV1J2NWlYUjg2bk5ZNndWYjViUktiQ20yeS92OUFmYUpQ?=
 =?utf-8?B?N01xbkhKZVFwV08rVXpodm15a0xaQnZ6Wis3RytFRGlWdDd6OGRncmRDZE5Z?=
 =?utf-8?B?VVM2WWpIOEsxL0diSkcwUGZkMisyTjVHZ2pZOWVKT1RzdXpvRThOTEh4aUQz?=
 =?utf-8?B?VnlsSWdOaVhNVldwYWhwbVU0M0VPdUcvNEhhTzZPMW5Jc1BhNTc0NWNvVXMy?=
 =?utf-8?B?dEQ2SXJCb2JUbUl6UFJnc3lhYUJGVlBKd245SDNHRkxGTmxyTkN0LzJha2d3?=
 =?utf-8?B?eWpLa0hEeGlrZ2xoNi9qU0IzVTlUd1VQNk1qNnNJYkJRM3dqZlhyV24xRHB6?=
 =?utf-8?B?ckxiNy9qbHBEdGttQWlGSDJKQ2djVlZGSHU3VVRUbjBxL2dPSGEzMG5hRFZa?=
 =?utf-8?B?OExHRzREUGlpa3hMQThZcHN1TFpmWTdtODBYL3dxWWJ3OFpXZEJza1JTbU5Q?=
 =?utf-8?B?V2hCMWYxajZHZnkvSG9yc2NRNXc1cDJYdHo2aGxrbENTank4bWZYcVpWdnl3?=
 =?utf-8?B?QytMUjNGN3B4a0VSQ0JBdDVhaHlGbTYxMU5oKzBhWnRMdmRVcUFWYVRXQ2ZC?=
 =?utf-8?B?SFJTbWFudmx0d2V2UWVXaHgrdThlMDBiL0dxbzl2aGk2amMrU09IRzBOTllF?=
 =?utf-8?B?RE9MNDZCOGdsbFhhQ0VxdmMyU3lmR0ZmdGJ2bnV2dGlsTzFFZXVQQTVKSnp4?=
 =?utf-8?B?aS81ZEIxMWdzNCszZTdsb0l1VjFGbVRwZzdZNlV6M1NEOHArOUI4UEswa0g4?=
 =?utf-8?B?NmdDeHJNV3J5U0g3bFY0RmJyekNncHJYVGxKcnR5NGNFOUJJa2tkdGFYaDV6?=
 =?utf-8?B?VkpLdC9IVjlmMUpTTTR2Wk00dzZJVkdFNEJRUVpYQUxZQ0ZjMjdqdVo0MlYz?=
 =?utf-8?B?VVZhc2xaS29MZGpzZmZZQWxGUTVkUHgxRlQrLzIwU0hUTTJmWXRPc1p6c3la?=
 =?utf-8?B?YWdYVnpJZXJ3YU1NYVl0eWxoTE1aUzBFeHVvMmRqRnVUL3Vaa2xNRTdHVVZ1?=
 =?utf-8?B?SDN2Vlk3NUttYnFQcURxOXNsTGlQdVFNUFpFTjM3eG0rbDE0NTQxTmM1WUJz?=
 =?utf-8?B?Z040d0dETGdYTnNhUk9ualhTK25uMUdFYU11TndxSS9kcTlHemxhd21wT0t3?=
 =?utf-8?B?cU5tQmZ4dXd5UmJTZVIzRzhXRjBHNkx1aFdoU1ZTU1hyZ0N0WjBMdTlUeGp2?=
 =?utf-8?B?TThoTFplWGF2ZS83WEdtcEc3MGtDcGpoZnVKK3k3VEpYVTdjRnlCdEk5THlQ?=
 =?utf-8?B?MEFIU1FKRlQ0bDUzSTVTT1dOMG5sZEJ0d0V5Nk90cFJUQTVUdDhydkZQMENR?=
 =?utf-8?B?ckxwRGcrT2JCTUZwOXRDL1A0a3c5dzY0WlFHbmZBVXZQWVVVTi81eUZ5SUcw?=
 =?utf-8?B?eFBwbUhpWTNHTGJRVENxdHRWLzR2TnYyODM5VmlsL0p6cnNvS0FDbEZTUUVL?=
 =?utf-8?B?Zll4Tk5BQTVabCtScEdnRjVJRWtFRk5xZGh4b2lPSGgvQWI0ZTM3MWMvN3lK?=
 =?utf-8?B?Tm5HWDhSWkhxQzBNckZCSkM3QVdaanVGZ2krSjNNQVJObmMwT1NBOHpIZ3ZH?=
 =?utf-8?B?b2FvZVVYOUdSQ3ExTDhsVkxZQ21maksxekVhTHhNOGJBdEZHQzZ4RW1tS1lQ?=
 =?utf-8?B?ZEFLTWdLN1AvWlROa0orV1cvRGM5TnBDcHlVOHVJMzdFYVZJUk5IUEFxMUt5?=
 =?utf-8?B?aU14bVZBcjdsb2xxem1NNVg1bllKbXArZTBWNnFnemhUWWNaYzBLa1UvZTB4?=
 =?utf-8?B?Yk5qTGJJb0duakVXbzBJT1RWcTlQL1NqRFNGOTFacFpJQTRWcy9rdndqRFdR?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6cc3ef-a583-459c-10bf-08daa19a69fa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 21:43:00.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9QBvFiZB2a1sq75wBiFddkdmQW6apZv/k5RY5lUMPo2cJBCo/mRw9hS20la6HagLTIF3C7FkO/s/w9Fy/a3V66YIy7rBSthqGRsAlPc+nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/22 14:16, Colin Ian King wrote:
> There are spelling mistakes in config show text. Fix these.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  lib/test_firmware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index c82b65947ce6..0c714cdd51ef 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -284,7 +284,7 @@ static ssize_t config_show(struct device *dev,
>  				test_fw_config->name);
>  	else
>  		len += scnprintf(buf + len, PAGE_SIZE - len,
> -				"name:\tEMTPY\n");
> +				"name:\tEMPTY\n");
>  
>  	len += scnprintf(buf + len, PAGE_SIZE - len,
>  			"num_requests:\t%u\n", test_fw_config->num_requests);
> @@ -315,7 +315,7 @@ static ssize_t config_show(struct device *dev,
>  				test_fw_config->upload_name);
>  	else
>  		len += scnprintf(buf + len, PAGE_SIZE - len,
> -				"upload_name:\tEMTPY\n");
> +				"upload_name:\tEMPTY\n");
>  
>  	mutex_unlock(&test_fw_mutex);
>  

