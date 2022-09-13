Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35955B6ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiIMOE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiIMOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:04:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C318E3E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663077863; x=1694613863;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1X1Of+Y7KeSvygtfqhyGcOCVyEH3UgCZNInWGng7qsw=;
  b=LMT4fvLL5VGuNlkMmo9GhuqagYrZgBWkITXQ3fMLn2kT3XryZnfuCmQp
   eW5pTItz71s7Dd9lJn0D/F9X5T+BdDeHrG3o8ncgFn+4hidvGoM9q1e3P
   k5mHhxe40+CqKsdjihWDEOp9ElaTlFyhWJbej48vWMVjGS66/huw5gHz2
   gj4HZ95T44MlCdGlMy+SWX7wSJrar9jxh+arQd3/TJfuj8llbA9Gx47wV
   wukOiR6QsM+vMrH7vYMt+qcGPPnBe3DV2TpVjXJTFqiC3p9tmg8PFcU9Z
   gEXuyrtPtOHK5EgAYNUoxm589dI5MrucPbI2V++sHjkueJob7N+Q1xwSX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="324388774"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="324388774"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 07:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="684872868"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2022 07:04:00 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 07:03:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 07:03:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 13 Sep 2022 07:03:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 13 Sep 2022 07:03:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4JMPZCCZuI6Dx0qKwPDG2N/LY/BSvKoGY/NH4gSPQBP3vKod5m0foRnG3w7Cn1fFHSuf08zUBmFZWIkr+TyAJ19+FNcQqRnr71ET5Md/7twJgvk44f05NHqGbkjhaFPCbH7oPFVOvxPgnmjdawU7iBZAxrLAX5nyVlxBkRyottjJ7W4mEdep/g2kUa2aYtwkjlwVo61p1wETOeRvlF+aOanqqeSDxHXuVr2DTpDBdi8Iiojz3Qin+VPmBDZ4CmirkNJPgvbxrbcK9pm3q1HdlWYtOkaNs3JPi7RA1vHvvS3cHCCMYgIpPaa0o9oQtE0MKlNCRsYHz9CUGE/d/ycSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+VoecESdJIcfhgomQQr0CkT70zRJkMXhEKaFnJl1Dg=;
 b=DyXMPs0QsSnoTkxcG1PwFcQbWoMNpAV7EZPznH8GFPOd/265tiBXkbiWpiSu9sdCDZQllQGhs7pgobJTL+Bp2hsQLcOWVXtBQ7uW9fZiMta8PaiXG/v+46CD5jJ8TifOLCm8PtVt2ser/EL9n6jYLhRHxC+0WrEruHECpeQCinc+uIzWSg34ZtPJOyUWS7g+5Yafsh6GQL6vj3svinBry04dYB1aGBs3YHGA8xXxTAQymguMUOUigH4xn6zakwHrfmLV3yqh1j8JPN5o/X7e/WBd48E2dTKvabj27BTQr9WQ2ZzP2Lzo6qyItxviQsHgQERVqtTX2DDJhcDxiKygZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Tue, 13 Sep 2022 14:03:43 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::b5fa:8b77:19e8:f342]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::b5fa:8b77:19e8:f342%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 14:03:43 +0000
Message-ID: <39b0bfef-be7d-05a9-d964-19a74757bb8d@intel.com>
Date:   Tue, 13 Sep 2022 16:03:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH -next] ASoC: Intel: fix unused-variable warning in
 probe_codec
To:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <liam.r.girdwood@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20220822035133.2147381-1-cuigaosheng1@huawei.com>
Content-Language: en-US
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220822035133.2147381-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|PH0PR11MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: d61e368d-9ae9-49c4-a0b1-08da9590c478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBxhOtV2nGspDzjnQQ6LheH7Gdgy1ewkMRE96mnaCAEQWADITj091DiYgmKffhSKBHR0jvXFW3P0TeR0V+Zjbo/tvYqIDJtRFTyS+q98+agieAV8BOTrJvE3wDOeeYrQRM5enBGWYey4EoekdoYrzjhM5urbboE5FWRifBWm8/6jdnrjZYjdnzSLqR2x854k4U4vQx/CzszosF7vOy9/08tiXG1sfJFwHnGDlc3RKvR+lcAOkfgXD3MlWpzYmXy24v5MmMOBYrVEoEnIEeYKzviBUUiJwA3dXigzRUDYHiPycJ5kyDNJ7TFYyQg0zkubaGPHVlypNey5Ji2TtJTDaocNBwMpA01h4q6/DQvZ5/LqwbrOVZBpXAYXHcDWlOgbLup0cCBp0Ovjz9xpUd8sXSZ8tpTD0pKjW6g5DHCuCI5BhQSzl9K5M1YkgStiMgvw6b3pGjmL84KH3lY9NJuDZZenKU5eL90FcH2ynULVOj9JPbVMxMU+ImGsQBLAFt0xA7HAzx8rFzl6MfSQupgp0Z+8no4P985crg4cV3Zy4OTcIhC0vtHDYKmlyUfHyu+8Iky6cSoUDL906WAffEdd/EJuOhzPrgf4LFUB3oF3zo0/1xE/ZMbsQfRlr4bANO805x05Pyk1p64QZObX0404OGfH1Lx/OuTkh3SO5Tnqta0+rBenyStyPmeWTb40c8LRWwCuKOQHrghsKMQRFEg4htxZDn2YmGW5wGvVRbANjPAL8xVizjK5UfBrWK/LCsIs5TdTXsKrSZFuZdFjh5h3wzN97Rqa6dL4TDBh3FkHEZ0wpAXJmoAqBoAbOGS2rJTR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(8676002)(66476007)(2906002)(86362001)(41300700001)(316002)(53546011)(921005)(31696002)(7416002)(6486002)(186003)(2616005)(6506007)(6512007)(82960400001)(26005)(5660300002)(44832011)(66946007)(83380400001)(8936002)(478600001)(36756003)(4326008)(31686004)(66556008)(6666004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5KUFRqS2JqaWQ0RmdSWEgzajFSR05XeUNJOVZ6ZW80QndYSTkxekkwRGpk?=
 =?utf-8?B?YVJMYXBSdk9HN2gvbURsT1FLTGtNTUdUMDlDV01SeFAzQ2NNMzMvb3NIMjF6?=
 =?utf-8?B?Y0dXWlkwOW44RnlrOU9zRThUN3IwMmY2OTlsV21GNng1a0lyZExQUG5ZK1ox?=
 =?utf-8?B?ZUVxa0tOSFVINE5nR2V5NFNoenpXTHFIV2dlUXp0Y3BGZXdKNlBuanZqSUJW?=
 =?utf-8?B?WnVjd3hDZWlHZ0c1bStma2JKZGt1bVVkQ3BHMlRPSVhxSWFJb08vdkZrWk1k?=
 =?utf-8?B?OWRGOExWMklDMENDU1dZVk9JMVVDOEJFK2J3aG1LaUZVQ21UUUkwQ3drSmlU?=
 =?utf-8?B?WFdmcUx0by9hcTdOVE5xM2FxSWtjalBUaktzZHI1akg4cjNiZUpyc0hIOTM5?=
 =?utf-8?B?MS9MUGxPeGdMZ0ZJbGtlOXAyMGJmV1hPVVVoczJSeWtOTnd3d21ITW83QnZG?=
 =?utf-8?B?OTFwVkZ3TTlYblYxOXlEVjdPeU9MVjdUcCs5L1JsTUR0MXljMElCZHZLN0o3?=
 =?utf-8?B?ankxU1ExdVVFUWdLdm5zVlN1STNndUxqUThwM3ZPQWVadXgrNHh6bDdyMXda?=
 =?utf-8?B?RTVMY0llQUlsZ3NkWG4yYU5ycWg4Z2NDTlpMZmxtZFZZNit3VGpvcUxISjFN?=
 =?utf-8?B?K0FzaDRMczBML01Ud2gvU2VvK0RXbXdtUVFGdFdyT1BFV3I4NVU0Y0xaSnVv?=
 =?utf-8?B?Y1dqTlRPV3JUTFcrd25LT2ZWSmJBUCtXQVpXSXRON2ZJODdLVlN4K1VPTVFE?=
 =?utf-8?B?SllqRzBXL2xZZDBoU0wxNkN2T25BNDVGNjVldUhxZ1dERGw4UkhXMys4M2Fr?=
 =?utf-8?B?a0luWmlXNmpyNFVnTElmWDFnalQrWlYwV0tmQUJCTTdseXkrL0Q2QzEwZ1BW?=
 =?utf-8?B?SG9DTTg2K2dZcjduNnpKcVh1ZTM1am9NajZFTzFtV1VuOHNuK3JaU05wQVVZ?=
 =?utf-8?B?SlhCZVZxbmNjZFd1b0lhdEh2WlZBQmxDMC9GMFB3amg0MWsxRlFZcU12Wkc0?=
 =?utf-8?B?aGJXdjAvOTJ1NkZQZmh5VWxidEhVaHovaDkvQkxWUTU3dkRqbjgvc2xKS0VX?=
 =?utf-8?B?TUw1aVVwTHpybGZveWw1dlpYek1NTWE4MlZCUk0xa3hsREFyUC9udUZ3K3A5?=
 =?utf-8?B?RkNHTFF0cXk3eTN6YUtXeHUvRlRLU0o3U1UvSGNkR1A2elFsT21RSG5jM1pt?=
 =?utf-8?B?Q1YxOEJobGwyK2F0cG1XZHl1VDFqcFdqb21vckZlR3JUeGRNbkcxWmNiQjVN?=
 =?utf-8?B?MlorWFpBc0VhV0xlK1QybmxqQlZ1aWN0MngzZUlWQWhJQ3NQekFVSEt6Qi91?=
 =?utf-8?B?VGhpRkZBcjNMSGhyM1dQYmhNbitUa0h1aTh3cVM3SWlqeUVpb0krNlZiSTBZ?=
 =?utf-8?B?QU9BWXR2VnQyeFNqN0lFd1JzNVMycEpKbytPMTdFb0Mwb215TUx1cEhvdXI4?=
 =?utf-8?B?M21WdE0rd3FHbk85VVRjR1N1NW5HVmtObzhqSnpWbjd1TURTbUFmNmFRSGtB?=
 =?utf-8?B?WTlST0JNQ1VvUDUzdGRwdU5ZNVMzeGwxd2tCWWZjY2psRExzK2x4ZTFDSElu?=
 =?utf-8?B?UnUzVk9GOS9ZaHN4dktpVjZJV1RkSFNFbWhXcm1mS0QvKzdkQVZLZEYrTVBk?=
 =?utf-8?B?dzE4d3RPNnNML0NpRXo3NnpWcndMRFpOQVRSNk9iUHVNZ1dPc3BmNEFjTnFi?=
 =?utf-8?B?THlVWG1Ta1EzbGh0dnZFN2JTbS9jQWtKRG9lbm1mVXJndkdPS2Qvb3A5V3dR?=
 =?utf-8?B?UGZmOTFvRjR2aUZxUU8zMk9XK28rVWJEbUtWYUN2NG5oQnVRdVBGMG9IT09u?=
 =?utf-8?B?cUZJc05BbFNhZk9UdHRscit4S2J2aVBHNWxLaWtWR0QzQWhqZ0h6WS9HSEpT?=
 =?utf-8?B?dTdiTG9ESHc5SnEwditNU21lWGg1Yk85S2xKYzVtZWNZdUlicUh1VzBlOWlI?=
 =?utf-8?B?a1RvSTE3OVBFU3ozb2g2L0ZaZmx2TU4wMlJTMHB3TVMvWHdKK0NkQUxOZHNi?=
 =?utf-8?B?djl6ekpTY3YxeUVyWThraEs1SUp6RDR2STUwUGtCb3JhdWk3Tjd6VU5tNFI5?=
 =?utf-8?B?Tm0xbTEySjlTVmZjY2xNaUxqVlFhcVVxbmhuRWFsalRiUWEyNzlsamZzbFRU?=
 =?utf-8?B?YTdTZlBnSkZJQm0wRXpTMGJ6V0dJdXBDRlk2QVZrQTVQMy9XTnlESHZYbms1?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d61e368d-9ae9-49c4-a0b1-08da9590c478
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:03:43.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIB5o1S1+Xj9hdbulwZX4jub1cnlKSSbUM2VAdhG66xrO0F5J+0sKX8GVnelL7tx6DM/UWpzs53VYxx3tjUTuena7Q60/uwcpMcCGwC0n0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-22 5:51 AM, Gaosheng Cui wrote:
> In configurations with CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=n,
> gcc warns about an unused variable:
> 
> sound/soc/intel/skylake/skl.c: In function ‘probe_codec’:
> sound/soc/intel/skylake/skl.c:729:18: error: unused variable ‘skl’ [-Werror=unused-variable]
>    struct skl_dev *skl = bus_to_skl(bus);
>                    ^~~
> cc1: all warnings being treated as errors
> 
> Fixes: 3fd63658caed9 ("ASoC: Intel: Drop hdac_ext usage for codec device creation")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Thanks for the fix.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

> ---
>   sound/soc/intel/skylake/skl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index c7c1cad2a753..52a041d6144c 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -726,8 +726,8 @@ static int probe_codec(struct hdac_bus *bus, int addr)
>   	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
>   		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
>   	unsigned int res = -1;
> -	struct skl_dev *skl = bus_to_skl(bus);
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
> +	struct skl_dev *skl = bus_to_skl(bus);
>   	struct hdac_hda_priv *hda_codec;
>   #endif
>   	struct hda_codec *codec;
