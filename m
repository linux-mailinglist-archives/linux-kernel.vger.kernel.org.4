Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3E606C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJUAdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJUAdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:33:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A31C4ED7;
        Thu, 20 Oct 2022 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666312385; x=1697848385;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oy1s4VUAMOrDlOPTsXayK7grsmmWpnpgBlnHYI2CMRk=;
  b=Ap93osmHu1Qb3YGDXM45gglZPgUOsopHPvHJ5OE/SwIN0I68pOChBYbc
   F+Xjpzv8bOH5qTTRDJH2peNzmG7kz5/Ot8Qczk86C4maKV0We5p/gHG7D
   ZkTK04qRVUcY4NekL4mQTUXU+EQeJJGtViYdD+JlemOkQ2Qp0Q/AWb/68
   pUwtBhuT4Nsip4YqYcINj43UgxXObY5JridgZhsc1oPUsYE3Vs8Gx7qsd
   4kTnT8vsTlRxkR3j0vbnYVgqvpPwWbT90zohvwGtEGvKVwE/QG8xlLR/M
   apDDnsDLoIJDxUvda5MSCh6AE3K4yeA5L0quneJRkYR33vsac4OKqSwvL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304488787"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="304488787"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719392415"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="719392415"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 17:33:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:33:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:33:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 17:33:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 17:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFcFEclY8Aw+Z+X6Rz0GlaFlV8n8R7e92G6ZzleLcDFH+TDrZFjPxzCSLxcYhZzX7nW/am5pMQ+XcBKXdt3MbdbArscQfYdkHNfwyPyCemNh7DzSNkpDI+plaC04o/GCQ7i2anL2bckiSLiUifGHmUSMrfXpSnuWBzNiwcEKzvK1ZtD7govR5lMkTVXXCBe3BcRYdxo5YrDoyLMx6VfQXso0yCv8kpIeljhzDVoT4keUmXU8UadMmHUP2TZ6EaOlKxP4KHZSL9a/elofJMYPyVY0G+AJzbMD9JzxDqrvGSxppbTQnjNerVx5F7N20g0qqCsjX8SmfvcjWfe1NzZASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/tf7mz+6O4eTL4RwGH4E1+gWBxs9/g1/qKCmXnYIGo=;
 b=KaFmc2byj71zR35rBZ3zuXiSMhCARdNGt1XpqJeVsCOGHrIlTTRuUpQZbhk5WulB/hJvfWhseOwj5FepRKkXvJcjSnX8DmvD/e21ju0UpJB6q4ule9NWe5bIZT7WRkaDTk9yFQKfavjMj0Xe4OV8/BH+MXuRzVfsRaFI3PqkdG0dc8EyTqUg0d9B5Qxx8ofNsq214Eo8iTu/ByKenLT55oz3jq1T1SMxpd1m+4M9F1G2eyw+1SajcgRzbigcccAf129svHCSWQkoIbhIbA+1ejSREGY4nNqTZkUUh2U1BJ3+nxGEnMgJuI8vgl/Gnf8HNfOKloVDN23X6Qg+r+z6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH0PR11MB5393.namprd11.prod.outlook.com
 (2603:10b6:610:b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 00:33:01 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Fri, 21 Oct
 2022 00:33:01 +0000
Date:   Thu, 20 Oct 2022 17:32:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v2 04/12] cxl: Unify debug messages when calling
 devm_cxl_add_dport()
Message-ID: <6351e8bac4623_4da3294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-5-rrichter@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221018132341.76259-5-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CH0PR11MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: e67c3c07-a271-489a-05f6-08dab2fbcf73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMtYlfX6OeYAbzYk6BQ+TZste112zvW0Cjue2trjZomAKzph8QYK4yr3tlN4xidhzf7B8pBywOjd2e1qgbzg4IDJXYnTIjawasLXzEB1cd+bBZf9pTYIqNz30EsQKdfzm4Ucd98Ji5pjkt1bZEuQGu9VB/33AI2BKDhIM3OqcqmQrDsxgXuiwaSVGHtCel0lQJb2pfRKNp76JajftSjrix8fkPuBVCV/x8HIeA6hjW3zbTaTF/YqYKR3Jr1SZsDx0GNvDAbNDJ8Mi1XOCHGnZ2olmwnqT06ra5sGPOVMdVIjGFIi+pM5XMVFHkOAuSmeocdOtWGHJe5S3cwStk6xymlSbChnJDduLJsSvGEr75UssgaaeoRp6a1OvyjoRa4EXPiFpX3bk6NqRnRpgRyH4BaWKRUaxgx2FaaF+ftFczD2f35UMLNBLmNJv6LOUI8X4bJ3XbQw7haN9vc1OlwMG3Y3PFMmlA3iVLjRvGDC2Y98QMM6bP0e8NaSrBDOEj5wavOCKkA0dZgUv/Q8d0lEMHMDnQyeRTLEP3JZpfAhH4Cozre4QrFEByrOeIQiH5NGUEmzoWCJ0IOgoWzcXFNE2+0hdXaN5JyHxMgeKiV5UnRlSueccCfG0B+g6ITaRDaFWtyMUJLjFYeVagYUlVCLJ996L7Ou1loyTWES2+3zr5Pr00y7qSDLFcT4Gq79ivd50MO3CXr8OebtKwHjKNwkGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199015)(86362001)(38100700002)(82960400001)(6512007)(26005)(2906002)(9686003)(83380400001)(5660300002)(186003)(6666004)(6506007)(8936002)(15650500001)(316002)(110136005)(478600001)(6486002)(4326008)(8676002)(66556008)(41300700001)(66946007)(66476007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXRKODduUEp3K3Z1UzNETHVMSnFPL2hhMFhXeXlxY09UUEIwNWViL3lkWE9P?=
 =?utf-8?B?eCtDY01paUV1VHpFdVZmM3lIOHFJRDR1OHE1ZG5vNmovUUNobXdha0JtREdE?=
 =?utf-8?B?ckVtb2VLZURVODQ5OUdRMUdlVWVBdTVncE15Y2FtSWZRUlIzUjlmVEtraXU0?=
 =?utf-8?B?NVp5a01NZzZyY2ZCRlBMSzFQaERuQnIxdFNyU2ZuN3R1OVd2ZHE3aEZxdWF6?=
 =?utf-8?B?VzV1WTYxS1YzbG9GL2o4U3VjSmV4d0JIcFN4b05WMUFNanR6Wnk0WUlLOVdD?=
 =?utf-8?B?bXFUaWRZQ0w4NUlXM1BqWGs4Ky9hVmI0TnpVam1uT1dYQW56VWQyQkpNMzQw?=
 =?utf-8?B?a3lHMzBMc08wYkRqL252UlJ6K2ppWFpSZ2pkM1F5aFVHTi9mNWszeE1UZzhM?=
 =?utf-8?B?OTdmY1R3NTVlQVcyUm1vTG9nbFJWaCt1Mys2WjJJL2RhekxFZTFONHQyS2Zz?=
 =?utf-8?B?N3ZCSm04Y0dFOEtGTU9LbFA0a1JEdk81cGEvN2lWM04zVVB2SGJ5SHk2SGx0?=
 =?utf-8?B?aEtNeTJFekliMzVXYXptT1ZNdm8wUUNpcEtFdnlqdENLOFNMK0pvM3oxV1J2?=
 =?utf-8?B?Mi9HbjN4VUtLU2Evbjh0bTlTSUgxYzJkL3pkQTBvVjZsVE14T21Tb28wSXpI?=
 =?utf-8?B?WDlPNDBCYTk0OTNyNlc3U0ZwbmFjbXBHNVJkSUQxNGFwRlJtY0p4OGZac1Ax?=
 =?utf-8?B?RzBFb0RUbVMvcXVCTm02UG1Ma3ZuRStybHdtd0lSbEsrcnc5eWlmVS9TUHM5?=
 =?utf-8?B?WDJ0aS9ua2dPRHZVVlpiTGtvdnczdlFncm0zQXNFaHdRUlpGdEgwREVacmxv?=
 =?utf-8?B?bGtZdkkwcjZBZVJVVGRoZUFrcEVUSmRmWjhmS2U4akF6elRiTTZLY29PVGhV?=
 =?utf-8?B?bnRKbDlhSm5FZmtZQ2RIVjc1VEF2NDhhck05eWJ1SWVxbFFjcHJpdHFBMWtD?=
 =?utf-8?B?WWRwcFRIT0FhMk9ERUlmTmYrYXZZbzhMQXRNRjl3eWxTRTgyQ1BpSEFPaWUx?=
 =?utf-8?B?YXEzYVpPbnJKNFdONXpVbWhrZ01ZSnAzRlJHMUtOZlFFZ2NDR1J3cCtxRVhZ?=
 =?utf-8?B?NnZna1RMZHFFa0hCM3ZsVFFYZkpqN0RLaGM2OWlTaUZJR3FGdEQrbS94Wm5n?=
 =?utf-8?B?Y3Q4djBvTFpPRFZaOUU3MCtpTFlzc1pTemFrSXp5aHFRd1N4c0hxZ0JvYURu?=
 =?utf-8?B?dzA2YlBSdVpCZWUxWnVZUlI1emlFQ201dE5Ic0k1QUxXa3pxbzdiSllOUnZX?=
 =?utf-8?B?ZktQNklFdFplSnNuWUtOSmFrcXdoQUtLa1lXcmhTRlMxMTVlcURZcXlCaURj?=
 =?utf-8?B?cU5udTNESEFtZDlGRnhWR01tbEFtWEVNOXdrbExXT05UOE1ONzV4dVBuMzUx?=
 =?utf-8?B?UmFmYTZxSU04REZQdGcwbzNacWgyVmo1RElvOUVsUnBBWTR4bFdVenE2YTZJ?=
 =?utf-8?B?WXhRV1hUQ3VzOGJOTHd6WnBzeThOQ3VPcVp3VU5ZR0RSRTRVSm5BUlA4Nit2?=
 =?utf-8?B?TzFYMkttQk5qeFljcFNMTDg4Q2cyTU80RmJ0SkFsTCttbHFiaGIrT3lVaHRO?=
 =?utf-8?B?NkUydXV0ODNRbEc0Q0U1VXNBT2xtNE9BcmgvRjFEZEpqeTFiVllyNWwyZDhr?=
 =?utf-8?B?TUdacytGNkpYNHJucytWVDVITHhCb09ZZTBmSFNKZS9Ua1JwVEEycXhaZXZ1?=
 =?utf-8?B?bmtoV0tSN3llcHphRnZ5eFRWcGdpNXBwTFc1UytROGZBK0VlWnRteDRlVW9y?=
 =?utf-8?B?M1pkSnRNTCtFbExFRldCcm1LeU9nVFRKUDJ4bnExRDhRWTJTd280NmxYUU55?=
 =?utf-8?B?cU1OOERQMHgvVXNvRzU1QXlJSTRYWk9VVGxOdnp3SEtoNG5vSjdOZ1dRMm5R?=
 =?utf-8?B?aG5KMWNobkZPa09LbmQ2Nk81YjZKeFYweDY2QytkVGNVMVpqYzlVUWJTVWVk?=
 =?utf-8?B?OTR1YVN0bHlRdU4yckVtZSsybHErTE1zaGcxbzdWMkpMWFNjSlZpOUZwRERE?=
 =?utf-8?B?TVlrcmtVRExERjNvRTQ5bktDL0lMME55M0cwWXJtc2hHeFBlemVCeFhvTHpl?=
 =?utf-8?B?VEpyWWZKT0hzSkZFRWxWcnAwcHREeWtIaUZMU0ZETDNtSEd5enMyRXRVNmx0?=
 =?utf-8?B?S2tPWnhFeWF2ZWdtZFY4Ym13QldtVytpUUNIZE9CVXBkKzFLRWdCTkNTUkpw?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e67c3c07-a271-489a-05f6-08dab2fbcf73
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 00:33:01.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WzmUIN1Ju1AioxM1Is+QEov4j8YSDpbwzvb3iEShxF2sutAFOZ6SLAYkOYe5wRxwpwwS/t1vVpn00VIUXzAKL+tGsZlRHrnPtMzOCdiSso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5393
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

Robert Richter wrote:
> CXL dports are added in a couple of code paths using devm_cxl_add_
> dport(). Debug messages are individually generated, but are incomplete
> and inconsistent. Change this by moving its generation to devm_cxl_
> add_dport(). This unifies the messages and reduces code duplication.
> Also, generate messages on failure. Use a __devm_cxl_add_dport()
> wrapper to keep the readability of the error exits.

Looks good, I fixed up the wrapping of devm_cxl_add_dport() and one more
fixup below, but applied for v6.2.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c           |  7 ++----
>  drivers/cxl/core/pci.c       |  2 --
>  drivers/cxl/core/port.c      | 48 +++++++++++++++++++++++++-----------
>  tools/testing/cxl/test/cxl.c |  8 +-----
>  4 files changed, 37 insertions(+), 28 deletions(-)
> 
[..]
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index a072b2d3e726..c610625e8261 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -582,14 +582,8 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
>  		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
>  					   CXL_RESOURCE_NONE);
>  
> -		if (IS_ERR(dport)) {
> -			dev_err(dev, "failed to add dport: %s (%ld)\n",
> -				dev_name(&pdev->dev), PTR_ERR(dport));
> +		if (IS_ERR(dport))
>  			return PTR_ERR(dport);
> -		}
> -
> -		dev_dbg(dev, "add dport%d: %s\n", pdev->id,
> -			dev_name(&pdev->dev));

This hunk causes this new compile error:

tools/testing/cxl/test/cxl.c: In function ‘mock_cxl_port_enumerate_dports’:
tools/testing/cxl/test/cxl.c:559:24: error: unused variable ‘dev’ [-Werror=unused-variable]
  559 |         struct device *dev = &port->dev;
      |                        ^~~
cc1: all warnings being treated as errors

I fixed it up locally, but just double check that you are building
cxl_test if you touch tools/testing/cxl/:

    make M=tools/testing/cxl
