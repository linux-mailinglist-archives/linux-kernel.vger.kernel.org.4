Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1984C5F5976
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJER6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiJER6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:58:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD5878BCE;
        Wed,  5 Oct 2022 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664992709; x=1696528709;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vRVweCH7Bujw2ZP24cY0U94sm8CXEJbSIN2/+7L2HVA=;
  b=aLcPdZrxXLVDRElF/4JbYWRHPw1U2bJAF7i/NU9W6zVB+ceY5imlAWdE
   /n/QoU/gxzI86ykFTf8o/z5tti3rOYwIgRGv5dpCX2jT60K+MseN8xdz9
   Cw0IsHvyAyZoblGMkOrredyZZsI4G6gAJ02T/FXvIkNrnV+yM0fpYJtDE
   CBvToZAnai6dyBfjLP32wgkMpym2xNkCGuq/as5gb+gU9saoGCHrXubDy
   f2FqXR84iJH68bIRso+O4jXsd62Z4O45INLRnR85ZeBllmWi77TUul2mQ
   sppz3m3KvMao7mtgPo+xMrdWQP3vXaBSQdDCEIYafOHRcs1jkQLlMNJIU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="286442298"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="286442298"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 10:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="602098494"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="602098494"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2022 10:54:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 10:54:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 10:54:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 10:54:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 10:54:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiE+2OdGYAW0+dsaLqavF58t6VqjjPO3+T4t8OmOEN1JuwJWQT4K2fCOg9tL0InUQGe56DTkM8Tg0rS2N88eVgilsJr/SkgmcU0ZnVE6iR+M9PTodhU2tH+W8Erp587o6MYMMRugDF/djhk//n4kUSHqYrMQvdhPMxXvD6AdAgb7UOzL5UH4rd5JZvmVLS0BABGFu35q7VTtaf83vfPqzw5E3hIq0EYdItyi0VyEunYb3Ki6PTQUU7i1p0peUFKzRzGtiO8y29XpA2yjej1WU+HDMFNsLdOP5l4BORCPjMd6PfPfXN7MjZuLUHiucWf69gEn7aXUxpHTJf7AtoFW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA06Nnt8maOjHO08RDcOq91mvmeajw36Hef7eEEVMzo=;
 b=Np7eSXTFgYBEQzMDVfqsiDIZgpuG4BFbLTitfsQmX34dI4Fl+c/ipRV01+Y2oHZBLyhyno6yyPfLQOkwv9lGh9j2DvMGSKx5aVIGR90zTFdXrQ0vYxmEwaB5h4X+QB2KNE4qH46y1lCnbDyyDlWXK2X7Y6PXHXIsZHvcKYT0jGDaNvQIvfLUx0aRP97R98SlLb9UOpChuf5Yl643pCorPbBDFec2FnQIecKkwiRrIBv90uV+rVvyjz9g3UfdXD8XurE9oFlI8/mB6x/IzNRpMWRWDPWSo8COXfEaO1MkXlB60G2pt/zqIaTFxXKsTU7uP0EJdL9eKd1qb4hfPhW1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4764.namprd11.prod.outlook.com (2603:10b6:303:5a::16)
 by PH0PR11MB5676.namprd11.prod.outlook.com (2603:10b6:510:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 17:54:37 +0000
Received: from MW3PR11MB4764.namprd11.prod.outlook.com
 ([fe80::e82e:c89f:d355:5101]) by MW3PR11MB4764.namprd11.prod.outlook.com
 ([fe80::e82e:c89f:d355:5101%7]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 17:54:37 +0000
Message-ID: <1fe9163d-69b5-6520-76d6-05ed0d4a100f@intel.com>
Date:   Wed, 5 Oct 2022 10:54:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 1/4] crypto: aspeed: Add ACRY RSA driver
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Chia-Wei Wang --cc=linux-kernel @ vger . kernel . org" 
        <chiawei_wang@aspeedtech.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
References: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
 <20220902060012.3758637-2-neal_liu@aspeedtech.com>
From:   Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
In-Reply-To: <20220902060012.3758637-2-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To MW3PR11MB4764.namprd11.prod.outlook.com
 (2603:10b6:303:5a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4764:EE_|PH0PR11MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a5360d-9c73-4759-f81f-08daa6faab71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4jLj2B+uvfeL4U//BuumsPVOcCYyotFLgJ+C11hOO5RBRi51hPwq0mjK7MBtwOYOeEOdNoCwHxiNlTKb7CFJBisx4l+Lk78YQYggahxelMcYL5m7B36h9MGUWV3iDYfC8j+xhRSdA+e+SPurP2LSqUziJ2ppmZRvzCTNh90uIYmaNJX/banH9bbqcvteathKDd3FPv7wXEJtWAGRljjmHf1biZ52CpYVnZv2sWwHA6w3JpKkulpsyx6Pm7HU2ACp0XSdyU+gJ5+wyRVvpoCzxvWnNV4S0eOlF/pX9lx3jKJilJFkxap2IIxOaweB/WsgPmBB7yyf/5eXT2VRLdiInmxjNYt+wN1LoGl60Ri/2d2x6DhQbtH0qeQ2VO0c4aXb89eW7Kzjyj8fvtvPvjs76apvHsI4SWOZ5kyGZcteKT9AVSGLKMfWiWZ+ka3COtSUYAwHEdNnoO0unar4t7dRhyJmu5Hs9Rdex++EeE2c3XG1b7f3Zdo/c+SiZzodcD0t586/ByILZC+UswIRMAuu8p5n2j2/sAjf6Mft/RPLWwU/MrzKk/BSAYySoecOe9iqCmRmz568qO52p5CVMXuaLSDfiA8TMuhs55vKa/uR+0RjFI2D7nwv1NUDyDP1wDOuFhOBymqz6SBzhCT/duXzfWs4ObrYHYHZuYZS8IVpCg1SlGmqewGMD0XjnQzD1F594iogDuOrzts3O3EE99xWsvmK8ACqiQHFe3r9ahNSH2JZG7uFnCfdh+xNZMXXOzQME1DXHY4MQs9yrvH1/lzS626WP8gbAciVMt1/O7HVuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(5660300002)(110136005)(6506007)(53546011)(2616005)(8936002)(41300700001)(2906002)(6512007)(7416002)(86362001)(44832011)(316002)(8676002)(83380400001)(4326008)(186003)(26005)(31696002)(66476007)(66946007)(36756003)(66556008)(31686004)(38100700002)(478600001)(82960400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0JvZVo4MGE1dDAydWtWSjEwQ3FiMTl2VkdhMGNpNXhPVXNWenVEYW5nTG9R?=
 =?utf-8?B?Mmgyc25kSFd4RnlBNmUyNk1DYlZxNDlIWjBpOGkvR202ZjJTMUVKVkZTMEhk?=
 =?utf-8?B?WGVUQkxQZEFrRUhKWVlvNGZYYlliTThoWHl4ZlowNm91M3l6a1UremRyN2tw?=
 =?utf-8?B?ZEc0TmM1WnYvanU2TjRHSnlRdGRKNVZqK0IyZVovQTI5NVA3eDlramJRL3pR?=
 =?utf-8?B?RVN1cmJ3d2k5TFNaZnk1N21qNzJmaC9YWEpTRnBJMEtUTldOeEF6eE4yNWJD?=
 =?utf-8?B?TXRoSk5NVkJoTXJjNkdmVWNqVFRxaFdGVmtiWng2T0I3Y1dLK1l2SmJmWDNi?=
 =?utf-8?B?aXduWDB1bEVSWnF2TUNFY1ZkaUtTbThqTmU4TFZOZ1ZRNzhwOFREa1RTcEpZ?=
 =?utf-8?B?MEVVdUQ5aG5iQjN4UU9McjFKYmVaelZaY0RIbjZlVWRld0UwbGk3Q0plRTlW?=
 =?utf-8?B?S2lYSVBmWFZ0WW1JZEd6ek9DUW93SFFlS2tSdUxSMnNXUUZUeUR2THR6c1Az?=
 =?utf-8?B?c1ZZejN2RW1OdzJZYmVjU3ZpcExXMmZzUHl0U1BjWGU2ZllicWtGYVBhUk5N?=
 =?utf-8?B?NkVZMHpzT0FxY29zd0RFRzNKWFFkd3pHR3IvVjBRalVqdnFWWTA1ZUhZOE0x?=
 =?utf-8?B?ZlRheTZLTlZzSUU1WG9oZE9velhoeDZvR0pFcXQ5NUtyem5Cazgrb3A1MGxN?=
 =?utf-8?B?VEl2N21tbUN4QVI4NFcwUHMwYzVwRGRQa29YblFWN25xd2cvMzV3UWZPRjJu?=
 =?utf-8?B?Y25kRTI1N2JHQlZ6OG5yK0xIbU56U1FtQUo1R21iTkY3ZmkwVXpLSTJJUW50?=
 =?utf-8?B?NURtUFc1L3N6bXRTbVZrVkNQUEY1WXpUZU9LZXBJbXV4TU9KUG8vdm01NE8v?=
 =?utf-8?B?Q3BwNXlLT29xaWhJczFnMjh3eGFMa0VFSzhyd2hCdHpMa1ZpajUwOUI5TlVx?=
 =?utf-8?B?ZzdvVFZJN0FkYXNTcXpmcURGSzAzOTM3UzhhSzhkV1ZMVnRuVXkwQXF5dDJ1?=
 =?utf-8?B?MnBJZWpmMUVReEpzcDh5TnRGbTN2QUxvVHBRUHloZHlvZHBYb0lFV1lraFI2?=
 =?utf-8?B?eEtGcmpxcWZFVE00YXpnNDBVWmFKQTNRek9LY01CRGZ2SlpPbG9QeDl3UmJi?=
 =?utf-8?B?ZlpSYjNWcXk3RDJzV1dUa1VTYVU4bU10c1ZVNmtCcHVLQURNaEI3YnVHZCtt?=
 =?utf-8?B?YU11VVl4c0txcGwvRDYxWWRDcUVOemlLcUlGbzJUaEw4RTNpTW5Tcmh1NnA1?=
 =?utf-8?B?QzJnbnRvM29JV2RiRUFUSU41UzlMOG1EYlpkT2RIMzVHMTdHRVhEbnd5ZndD?=
 =?utf-8?B?b1RDYUU1UEo1TDIvWktLK0dMdnpaaTJMTyt1cVdHQlpmR2VJcHMwMnJ1RkFQ?=
 =?utf-8?B?YndPMGY1bDF5anlFV2xTaDB2Ti81cjJkaWxuRGtCbk5OdkpxR1UyMjJtY2da?=
 =?utf-8?B?Q2JyTXJBSXJ5NUpSK3JONkhQMEsya3RPQ3htdmlNWWNnUVlzaUJ0emJ1T05K?=
 =?utf-8?B?NTFuTVNFYWxjVThBT1hWT01LOGdWdkNrQXBGSFlqeEFzWjBRMlpIYll5L3dl?=
 =?utf-8?B?SjNpSzFvM1plT1ZTUS9Icjc3a1F1bm9UNThwUTZUam5EMjhENE16RGhlR2xZ?=
 =?utf-8?B?TGpjaTlCRk1ZRDRsSUpSWTJPbW8wSDNlRjdQbDVidHc1eXV1Um5aMlhYWHdj?=
 =?utf-8?B?TFFwdE92dmQrNGRLZndmcUhhajNzU3V6eU4vM3poNlVka280VldwbmJsbkZh?=
 =?utf-8?B?VFdSaTJDK25TMkg4Q2NhYlV6NnoxWTdwNFRWeXNtYmdUVlJPdFFLUC9US0dv?=
 =?utf-8?B?L0pCSS9OU1hYRkJaZlM1ZjVTaGlpUWpuRWFSbldFaDRqeXdwMGhJSDlrMzlh?=
 =?utf-8?B?TkJwZ2F6UFJhYnlqRjR6TnJ0Zng4QnBKL0NlMHpWN2NVQlpkRWkvYXBMZVFi?=
 =?utf-8?B?ZHRIMXVTNUs1Q3IzeTRoVFR0V1VFZFlmRzM4SXo4QlVla1hDMnFoUUFFVzJp?=
 =?utf-8?B?ZjJjYzdJNzVkc2dPNW1QbXZDMHQyY2YrdGxZZkFRQkl6dmRGeUJQN2pBOVFT?=
 =?utf-8?B?TktjYzBWWDdUZjhXSjh0a0d4S2pkQnp2dVVxU0UzbmV3OXBLbnNpTmtOM0Fi?=
 =?utf-8?B?OE9KajRibDFPY2MvRkp2VWVUdFlrVGZVdjJ0ZXE2S0UzVVhJM0JWN2N1clEx?=
 =?utf-8?Q?8E7G+K4afuaVPPgqiqRHXLM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a5360d-9c73-4759-f81f-08daa6faab71
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 17:54:37.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcrKkyh6tYtsl7uP8ei9p5iOnospA05SlyFXhfTN828cytFZZTuOxFFk8LxUx0ofECc6JKdMlZZwvOPAIUhJ1JSM43DGehh3+sXl23iyp5AEjJVPj/O3qFXhBcItuGOA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5676
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/2022 11:00 PM, Neal Liu wrote:
> ACRY Engine is designed to accelerate the throughput of
> ECDSA/RSA signature and verification.
> 
> This patch aims to add ACRY RSA engine driver for hardware
> acceleration.

> +static bool aspeed_acry_need_fallback(struct akcipher_request *req)
> +{
> +	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
> +	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
> +
> +	if (ctx->key.n_sz > ASPEED_ACRY_RSA_MAX_KEY_LEN)
> +		return true;
> +
> +	return false;

return ctx->key.n_sz > ASPEED_ACRY_RSA_MAX_KEY_LEN;

> +}
> +
> +static int aspeed_acry_handle_queue(struct aspeed_acry_dev *acry_dev,
> +				    struct akcipher_request *req)
> +{
> +	if (aspeed_acry_need_fallback(req)) {
> +		ACRY_DBG(acry_dev, "SW fallback\n");
> +		return aspeed_acry_do_fallback(req);
> +	}
> +
> +	return crypto_transfer_akcipher_request_to_engine(
> +			acry_dev->crypt_engine_rsa, req);
> +}
> +
> +static int aspeed_acry_do_request(struct crypto_engine *engine, void *areq)
> +{
> +	struct akcipher_request *req = akcipher_request_cast(areq);
> +	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
> +	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
> +	struct aspeed_acry_dev *acry_dev = ctx->acry_dev;
> +	int rc;
> +
> +	acry_dev->req = req;
> +	acry_dev->flags |= CRYPTO_FLAGS_BUSY;
> +	rc = ctx->trigger(acry_dev);
> +
> +	if (rc != -EINPROGRESS)
> +		return -EIO;

So -EINPROGRESS return is converted to a 0 return, and all other error 
returns are converted to -EIO.

Why not have ctx->trigger() return 0 instead of -EINPROGRESS? Then the 
code here can just be:

return ctx->trigger(acry_dev);

> +
> +	return 0;
> +}
> +


> +
> +static u8 *aspeed_rsa_key_copy(u8 *src, size_t len)
> +{
> +	u8 *dst;
> +
> +	dst = kmemdup(src, len, GFP_DMA | GFP_KERNEL);
> +	return dst;

return kmemdup(src, len, GFP_DMA | GFP_KERNEL);

> +}
> +
> +static int aspeed_rsa_set_n(struct aspeed_acry_ctx *ctx, u8 *value,
> +			    size_t len)
> +{
> +	ctx->n_sz = len;
> +	ctx->n = aspeed_rsa_key_copy(value, len);
> +	if (!ctx->n)
> +		return -EINVAL;

aspeed_rsa_key_copy() calls kmemdup(). Feel like -ENOMEM would be a 
better code to return here.

> +
> +	return 0;
> +}
> +
> +static int aspeed_rsa_set_e(struct aspeed_acry_ctx *ctx, u8 *value,
> +			    size_t len)
> +{
> +	ctx->e_sz = len;
> +	ctx->e = aspeed_rsa_key_copy(value, len);
> +	if (!ctx->e)
> +		return -EINVAL;

Here as well.

> +
> +	return 0;
> +}
> +
> +static int aspeed_rsa_set_d(struct aspeed_acry_ctx *ctx, u8 *value,
> +			    size_t len)
> +{
> +	ctx->d_sz = len;
> +	ctx->d = aspeed_rsa_key_copy(value, len);
> +	if (!ctx->d)
> +		return -EINVAL;
.. and here.

> +
> +	return 0;
> +}


> +
> +static int aspeed_acry_rsa_setkey(struct crypto_akcipher *tfm, const void *key,
> +				  unsigned int keylen, int priv)
> +{
> +	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(tfm);
> +	struct aspeed_acry_dev *acry_dev = ctx->acry_dev;
> +	int ret;
> +
> +	if (priv)
> +		ret = rsa_parse_priv_key(&ctx->key, key, keylen);
> +	else
> +		ret = rsa_parse_pub_key(&ctx->key, key, keylen);
> +
> +	if (ret) {
> +		dev_err(acry_dev->dev, "rsa parse key failed, ret:0x%x\n",
> +			ret);
> +		return ret;

Do you not have to free ctx in this case?

> +	}
> +
> +	/* Aspeed engine supports up to 4096 bits,
> +	 * Use software fallback instead.
> +	 */
> +	if (ctx->key.n_sz > ASPEED_ACRY_RSA_MAX_KEY_LEN)
> +		return 0;
> +
> +	ret = aspeed_rsa_set_n(ctx, (u8 *)ctx->key.n, ctx->key.n_sz);
> +	if (ret)
> +		goto err;
> +
> +	ret = aspeed_rsa_set_e(ctx, (u8 *)ctx->key.e, ctx->key.e_sz);
> +	if (ret)
> +		goto err;
> +
> +	if (priv) {
> +		ret = aspeed_rsa_set_d(ctx, (u8 *)ctx->key.d, ctx->key.d_sz);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	dev_err(acry_dev->dev, "rsa set key failed\n");
> +	aspeed_rsa_key_free(ctx);
> +
> +	return ret;
> +}


> +
> +/*
> + * ACRY SRAM has its own memory layout.
> + * Set the DRAM to SRAM indexing for future used.
> + */
> +static void aspeed_acry_sram_mapping(struct aspeed_acry_dev *acry_dev)
> +{
> +	int i, j = 0;
> +
> +	for (i = 0; i < (ASPEED_ACRY_SRAM_MAX_LEN / BYTES_PER_DWORD); i++) {
> +		acry_dev->exp_dw_mapping[i] = j;
> +		acry_dev->mod_dw_mapping[i] = j + 4;
> +		acry_dev->data_byte_mapping[(i * 4)] = (j + 8) * 4;
> +		acry_dev->data_byte_mapping[(i * 4) + 1] = (j + 8) * 4 + 1;
> +		acry_dev->data_byte_mapping[(i * 4) + 2] = (j + 8) * 4 + 2;
> +		acry_dev->data_byte_mapping[(i * 4) + 3] = (j + 8) * 4 + 3;
> +		j++;
> +		j = j % 4 ? j : j + 8;
> +	}

Would help if you explained in some level of detail what you're doing here.

> +static int aspeed_acry_probe(struct platform_device *pdev)
> +{
> +	struct aspeed_acry_dev *acry_dev;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int rc;
> +
> +	acry_dev = devm_kzalloc(dev, sizeof(struct aspeed_acry_dev),
> +				GFP_KERNEL);
> +	if (!acry_dev)
> +		return -ENOMEM;
> +
> +	acry_dev->dev = dev;
> +
> +	platform_set_drvdata(pdev, acry_dev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	acry_dev->regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(acry_dev->regs))
> +		return PTR_ERR(acry_dev->regs);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	acry_dev->acry_sram = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(acry_dev->acry_sram))
> +		return PTR_ERR(acry_dev->acry_sram);
> +
> +	/* Get irq number and register it */
> +	acry_dev->irq = platform_get_irq(pdev, 0);
> +	if (!acry_dev->irq) {
> +		dev_err(dev, "Failed to get interrupt\n");
> +		return -ENXIO;
> +	}
> +
> +	rc = devm_request_irq(dev, acry_dev->irq, aspeed_acry_irq, 0,
> +			      dev_name(dev), acry_dev);
> +	if (rc) {
> +		dev_err(dev, "Failed to request irq.\n");
> +		return rc;
> +	}
> +
> +	acry_dev->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(acry_dev->clk)) {
> +		dev_err(dev, "Failed to get clk\n");
> +		return -ENODEV;
> +	}
> +
> +	acry_dev->ahbc = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							 "aspeed,ahbc");
> +	if (IS_ERR(acry_dev->ahbc)) {
> +		dev_err(dev, "Failed to get AHBC regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = clk_prepare_enable(acry_dev->clk);
> +	if (rc) {
> +		dev_err(dev, "Failed to enable clock 0x%x\n", rc);
> +		return rc;
> +	}

See if you can use devm_clk_get_enabled()? It combines devm_clk_get() 
and clk_prepare_enable().

> +
> +	/* Initialize crypto hardware engine structure for RSA */
> +	acry_dev->crypt_engine_rsa = crypto_engine_alloc_init(dev, true);
> +	if (!acry_dev->crypt_engine_rsa) {
> +		rc = -ENOMEM;
> +		goto clk_exit;
> +	}
> +
> +	rc = crypto_engine_start(acry_dev->crypt_engine_rsa);
> +	if (rc)
> +		goto err_engine_rsa_start;
> +
> +	tasklet_init(&acry_dev->done_task, aspeed_acry_done_task,
> +		     (unsigned long)acry_dev);
> +
> +	/* Set Data Memory to AHB(CPU) Access Mode */
> +	ast_acry_write(acry_dev, ACRY_CMD_DMEM_AHB, ASPEED_ACRY_DMA_CMD);
> +
> +	/* Initialize ACRY SRAM index */
> +	aspeed_acry_sram_mapping(acry_dev);
> +
> +	acry_dev->buf_addr = dmam_alloc_coherent(dev, ASPEED_ACRY_BUFF_SIZE,
> +						 &acry_dev->buf_dma_addr,
> +						 GFP_KERNEL);
> +	memzero_explicit(acry_dev->buf_addr, ASPEED_ACRY_BUFF_SIZE);
> +
> +	aspeed_acry_register(acry_dev);
> +
> +	dev_info(dev, "Aspeed ACRY Accelerator successfully registered\n");
> +
> +	return 0;
> +
> +err_engine_rsa_start:
> +	crypto_engine_exit(acry_dev->crypt_engine_rsa);
> +clk_exit:
> +	clk_disable_unprepare(acry_dev->clk);
> +
> +	return rc;
> +}

Ani
