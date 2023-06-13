Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861CD72EB14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjFMShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFMShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:37:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D39D1BDA;
        Tue, 13 Jun 2023 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686681433; x=1718217433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6yIAsWAMpHS1qD4/gzfoVkRKOsYjCqQVsJ/RQ8uy+fo=;
  b=AF9r/iMfubk1IKNcM+dk+MXC48ViwgYaMXYECyEN+khETEiLESFkPWD5
   arL0HA+YbZ62I/FgTClIBiI4zlp2VANRg1+Sn/bgosWdOu7paBvFmU9qe
   zDP6EbRf5LL2RHLN/LUq431o4zCjYL3p4jvxEst4/RDLS0GUJjn7yteaV
   cQVYM6GIt1YE30FWySqmUOU3OAmRT2HGgFXVcuzy7MaXK4JEzvVyPGxQb
   ySGAoHnDM4bzf8r0G3yDQN7sOHh/Wpj3shErie+ZrTChsiSSMOXNbcB8g
   MjBkBNVsWEKYd9WGm1GWW1icmi9qtrOPSypkIA5n1ERPBXNrru8GM2jTI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="386825997"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="386825997"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 11:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835991927"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="835991927"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2023 11:37:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:37:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:37:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 11:37:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 11:37:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcXtoRB54JTGyh8W/Pexfa8iRXoc6Hs0zVXDlBalpfjDtyF5KUKKZVBNEgQozDSgm2qjt05PuHJGz39hTyGYedi9MNLi3uQZxe/Gp4cBeGrfDnxYsvBNI/wDOcMoKFX6tYl5LA/wJLge5urh5J+KlpIFV3yKp8+se+eWLFeEbAzI/NwRL28YxInL/ilOg4/nmCkxDviB66wb1LzZEQ4Z0ZlwzkVzCh3AuIByhXRqhK5IKv/koQEwl0EgH+AHN5SYngD7G25xxN4Z17at9dBKADSRbzmGw5qaGMPSvm+RG/3tPa+vN7VnKEULQvY4NT+xjfM8LBZMyeheifaZNWeY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj87cxWlXSJwH71WXtOCZcouxVgvBInjug0FdRMxfYY=;
 b=FbepUWwkBl4XDlY+oavb4WksPXMas3gELT0SNjdMIOLiDsjB0tT2mNCAntbDwFXz56/iisJ7rLlmh+rPL2pDn1ridII/3DgEbMUGhGD7kbFdGSBgyzsS4Hn/lHm6OvC7urDc1qds2iIrSVrIWMaSP2OXXkSM4aatpQz+QU/Oa94Bq0lxqmdYQVgUR2pezCrEMjBr0Ml5fHF12pJor8Yb0TDcqggr6L6VKd2yOUyHoTTYanFrZHeoeIrq4VcTsNmGQgzld/CN3EcAmKRRDSDJlfutvNZw9v6rFAm4xYKLiiPj7CaG4ERvmAs3jBuLdfqMT3fca8OAH4se5Hxfjp3h9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB4840.namprd11.prod.outlook.com (2603:10b6:510:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 18:37:09 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 18:37:09 +0000
Message-ID: <f8460975-731a-731c-e4a9-a310234182a2@intel.com>
Date:   Tue, 13 Jun 2023 11:37:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3 2/4] tools/testing/cxl: Fix command effects for
 inject/clear poison
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
 <20230602-vv-fw_update-v3-2-869f82069c95@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230602-vv-fw_update-v3-2-869f82069c95@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::12) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b067c0e-6c6c-4629-f5e5-08db6c3d320e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgOC93mAUFEgyR9lJKuxKZg6WSmmTYwrH5sqrelmb/esyVGKbe37zz0XZzHB5Vl09YQ7jOovDJMX7gOMrNnj/oQMbfRsNm1yOYZuz7coycOOYZFoNo8Ialf8bsev2RBHCfpjMDYlP8gPH3x2azMBb2t2kXSdOTm9WpmSz8e1uVOfoR8KIOcCgNqgEi+Gq2Eb9Sp41mSBrbjgVn9yoZgRLrsHfXf1IaULS28g0+y5bnGxpCFCxgc+bJ9SB24pY5wN1b1CWG7S9BS7iiTPYgvFGRJQxKe853jwfQ6T3OAwJJaZyiTwvkpDK+HfrKsbKLTC6BBc+KwVXox0R4sqdKFM6i0yFI8yLCXxgSzWdHHtDgjaCYmL7LY7UCmnMLHQrkfXVeG8pVKgyqaxm47lg12nJ9c8cj6/z6Y3qoGgMMQCx4XWVHKSMzBL2SxY++Qqf8bsltx0Q8QXz2cQcy/YwPssOnW8DYxZGSykbT/K4C3qyJmlFVwp6jPhgA25BXKml8lLnyvsMUe/a6FGs5EyKetTJyGFsIU9xhHpkVcp5HNBjts0ONxW+AFd+eVE6VW+ga3BNFX9rWsA2getkiKHzFUePSLoxiJMqmzfz/6//ceYMIm6tQM4E1PKkspAvfo3ARZDOCGGC9gob7MnH3pHy+px2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(110136005)(5660300002)(54906003)(8676002)(6636002)(66556008)(31686004)(66946007)(4326008)(44832011)(8936002)(41300700001)(316002)(186003)(2906002)(478600001)(66476007)(6666004)(107886003)(6486002)(6512007)(53546011)(6506007)(26005)(83380400001)(36756003)(86362001)(82960400001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWs1VDJMbjYxMWtnc0pEcWR6aFBsUkptaGFVWk90V0tBYVRWa1p2YmFwVkJh?=
 =?utf-8?B?OGc5UmpkL1h0aHlUY3hNRmszeVlaRVFmanRmcC96K05TMUo5d2ZDRmFEVFNs?=
 =?utf-8?B?dWlocW5lc3JlMnF4cit2TjVvK3JrTEkxOVN3MDFNRXFsSFE5dzFhcDlOMXZu?=
 =?utf-8?B?RG1tcE5YT2sxQXpoZUhaUUdqa24wTXRUam1UREhPWGRxR2w1MDJuZlhWSUt6?=
 =?utf-8?B?UE5lSDBCWDgxelM4ZWdxNTNEWXFNUjB3UHJqbTl4STJ0anZxNHgvOWE3YU9o?=
 =?utf-8?B?TWFkMUM3T1BHUDViMGdVd2t5UFpiM00xY3Y3MTArSVV5eVNLS051SkpjV0RX?=
 =?utf-8?B?K3Fjc3M4WjZVaXVhUXdJd3dxL3FRQmkvZTBSNFVHL3ZRN2s5cHZmeDNzR1Jv?=
 =?utf-8?B?R0xlQ2NRTUtQaWF4ZXlSUHhwVE1KcUJVWm5oZGRqWW5sL2o4Y1NOY095Tm54?=
 =?utf-8?B?bTIrY1hCTEJGY0lTeWxSSlRPNWJPbUlIeUJrYmJGang1alZsTDNKMUFsNUpv?=
 =?utf-8?B?OXNxRnFJU2RVSmtYN2JwUlVmWVFOb2VBWk5XSGlRa2Q3MUhzQU5UcGk5Z3dQ?=
 =?utf-8?B?OUwwdHN2SmF5ZCtDMjAvN0g5ak03OWFkWk1PRDBJQks4TDYzN0xGdURCZytw?=
 =?utf-8?B?K0FLQ0h5R1UxeUI3M2MrMTFhdjJTOGYrNUZjTlhKYzBjWko1VnVCVWNmMzZM?=
 =?utf-8?B?Nisyakl0Y1h5eEFIYy9sTEU4T29pRUdwSWQrWURDU2FNbTF5NWZNQjdRbmNB?=
 =?utf-8?B?c09pTjlyZjZrdUE2QmpxemQ2RTlreGVYNEI5eGFPM2kyVmZZeHpkbHdvUyto?=
 =?utf-8?B?engzNGR5VGd1SkcyVjVUTGJncHd6ZW5ZckJqNlZOSjJNUHZRUm5udStLMmtj?=
 =?utf-8?B?UG90dDBWN2xDc1RVT2ZqY2xHS1Z2eFMrTUFQalFWLzNBQ3pJMWNUUWpRaUhh?=
 =?utf-8?B?ZXJ6YXVvSHpOMUljdS84RGFuNjVIdTJxVG0zaldFUFFPRExUTnFXSjNKdjUy?=
 =?utf-8?B?U1QwNzdBYjNmUVFrbGU4T3Z6K2VmUDZLdnI3a0JaeVJ2UmRkMloycDZHTXo0?=
 =?utf-8?B?cGE3RFFHeGNjYXJwOGVicm9BUUF0TVozVW0xYVNOMnl5cVV2Z2JocDFMcWpp?=
 =?utf-8?B?SU0zc2hhOW9xY2ZSTElMUWZ6bUpoWFpuU1I1MmR1Y09ZbEdEU3BjTkNRUnhk?=
 =?utf-8?B?RTFNSjdicGpzUGJmMVFrT0pOOGFLZDJBUnc2azl4a2NCQUhEQ3phZ1NWUXhF?=
 =?utf-8?B?RndOY1BadXNCcUhZb29ndDF1a2VtOXhXdFZsVTBoblZ2NHJpL3JDalVIK2kr?=
 =?utf-8?B?QUdoeVZ0MW4vNVRVTXNPbXNsVjVpZkpacHJCck04OWRvM2V5a215YjIvejgv?=
 =?utf-8?B?Q0ZDbVlDc1hadHJwNnAzMGFldVNxZm1RTWZjY3oyRG9JTzRQdVMyZVNpb084?=
 =?utf-8?B?MjVBT3R1UGRBaGZiQ1hOcXZ5VFVFTnpoZ0Y1QnZYMFdydHp1ckdwencrMUox?=
 =?utf-8?B?ZDdpMnExNG91OVZ6SndKbUFwTVpNQlV1SFlXa0J1SVFQUE9sYWR1aS9GaDhV?=
 =?utf-8?B?MmxmUGtpWlcvWHFqQTRQRmY1S2VXRSsyaDZNV0h6QXN4bHF3cGYrMjAwN3lB?=
 =?utf-8?B?dVptaC9rZmF5ZGtPdzBRc2puWU1Vd1o5am9USFVLajM5UTVDM2l3S0lzYnlw?=
 =?utf-8?B?TUpralN5UXlVV21nWmhDcXoyT2NMcjNkWGY3ajRBb2lYMW83SkhhaUN3L1U5?=
 =?utf-8?B?UTg1SzZwbDNaM2xXQndGUWJ4MGdFWnNDeGkzYUQ2Z3dzYUZ0MDJtRnhUV012?=
 =?utf-8?B?eU5BRWs1RGFralVUUHpoeDlVMlNMMmNYSnA1ZzR3WnVSbW51Ulc5YllkMXhh?=
 =?utf-8?B?SmJOakN6cjNVWkpqWm5KZzdvUXF3YjFqVXJ6RSt1S2VYSnNNNFJzZkZYek8v?=
 =?utf-8?B?L3VUQmZyN1RITlQwaUtyc2Rxa05DbEVqajV1NHpwWHg2YzlCRWU3QkluV1JN?=
 =?utf-8?B?YkhGQ2gwZ0szMGN0WmhrbFc2NGMwQ1gydldPbE5iVzM2SWN5Nk05bGNWamxH?=
 =?utf-8?B?WXpNdGE0Z2VOYzNwRGdtV1dIeWdsbERSdXFaWS91TWRFZGFnNmxLc3kveUFh?=
 =?utf-8?Q?xwE8IewNY/aMhEtsJrRTaBdgB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b067c0e-6c6c-4629-f5e5-08db6c3d320e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 18:37:09.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfYA3wpMukvzgj3LYvitCwIdGIoHvPCC4BVMKpwBEkBpVJXMbtyPZH7d0IdRYpCUf54vpv5NyQSG+S5tlwmU7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4840
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/11/23 23:55, Vishal Verma wrote:
> The CXL spec (3.0, section 8.2.9.8.4) Lists Inject Poison and Clear
> Poison as having the effects of "Immediate Data Change". Fix this in the
> mock driver so that the command effect log is populated correctly.
>
> Fixes: 371c16101ee8 ("tools/testing/cxl: Mock the Inject Poison mailbox command")
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>



> ---
>   tools/testing/cxl/test/mem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 34b48027b3de..403cd3608772 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -52,11 +52,11 @@ static struct cxl_cel_entry mock_cel[] = {
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
> -		.effect = cpu_to_le16(0),
> +		.effect = cpu_to_le16(EFFECT(2)),
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
> -		.effect = cpu_to_le16(0),
> +		.effect = cpu_to_le16(EFFECT(2)),
>   	},
>   };
>   
>
