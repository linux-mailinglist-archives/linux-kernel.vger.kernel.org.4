Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A400765F78D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjAEXZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjAEXZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:25:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5569B6E40C;
        Thu,  5 Jan 2023 15:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672961105; x=1704497105;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hXqUVT/upEnUUi7fjaPVeLYwfxFzq9DTbBRm52nCOqI=;
  b=EYSf/iU7XJPq8K26JuMdlXNYzRE2gu6yNOlNBLcD06RQyuwZVEqJ4C9q
   oAC1TXZYJWgSM3xsFaf5IMeol4EFX+7VgNJzUAMt+yAo1iSRsDIwiiaMX
   7O7gayxmlTdhEqBQwHkQtw+5POVueneouyq6nam/f3cmeHvzSfYPzPMkb
   SuKBvkTcMK2IDmlu2tjf0ftkkBFTdIPEG7MzdjMaqBEUCDA+ZfWQUGqId
   5iKRYRI/39C9xiCvMFjaPsJNl9cXyX7lkCrKCaXlEgsYxnMu7cDqZ0paX
   h7Tv0iKwO96H1/CA39K+9w/5XulCRJKzLoRMSrCnpfiWc0y2PJn168GpQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="323602872"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="323602872"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 15:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="633323775"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="633323775"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2023 15:25:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 15:25:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 15:25:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 15:25:03 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 15:25:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgnmVoBdZVOFPpWirhq1txlq1tP0sUCtfXFr3uo+RpZ32Ne9lUFR7DbgtyNMMyXMMFk4FJqHuuiP5GU3ollRCC6OhBofgDmfHV27g/I8CtgSiXn2739YWuPFL805zn7GWz1gqPC3trqTMoxn85SuP+ErEWuXXfuBTgWU+0pMQ8yjiw6xa9a+GyjbYWs6PBdWv1mbY9p37sIsIP9Ibvsy6W8VOs80r8STnFMCDxSdxCkUP9rDoGDVOAatWYoENGXnmLg2hhJXPWpi8u6OZD+Mm8/1MMFTdNEPjyItJgsiNAy9DwBt37ooJKPMKF1nED3MDIZ+3v7JOee0V6SyjqRqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4igUcGBXORv/1NSWMlpdMTglxw+/wVxFLUnKYeXsPI=;
 b=hr6F0d2z3D8PxFIF8USDl+yzeVOKf4beZ60neyOlpETPfBX0Pn4rM2z8MDNO2LCEIqZALVtyeQjr1Bo8hpm6v4Yu6/eu5ZM4LpnUqbWVnT+WOdp2FmcS6/vqGr/KND/kJZfYEYqrcUwrHML6stKYPFpnn8L1/siRZe8MWgF5HrHg8YCdlIV8uRf0gghtGNBlYDLB2Xg07f0BRt0a+kdYr0W4c0An5xlKJSSIJ/Wfxh5EoTO+KnYD6mthDNJoUHFOH/60dCmcDKA6ie6/lghSxPA6xY4K6Gamq8Wx7eBrwRz8iJF8ipSXEIRGNWd/srq81w1B/xFSapv4Nlv2cclu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB7375.namprd11.prod.outlook.com (2603:10b6:8:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 23:25:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 23:25:02 +0000
Date:   Thu, 5 Jan 2023 15:24:58 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ips: Replace kmap_atomic() with kmap_local_page()
Message-ID: <Y7dcSswZppY4hn3H@iweiny-desk3>
References: <20230103173131.21259-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230103173131.21259-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: d44ea8b0-74fe-4ebc-82bc-08daef7411a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaSciA6KWdXGcR40aiDrYb9z5Vj7vm4STrFAooerVG8YYTlZvjG89GavCzwixPwrn/I3rB3KeDvdjFevin0BZd3M8KmPSNBlNpaxgjyRVYCyznMhXUS8RQCkBnaHnxws9fZDyrJvXtYWuVE9QCN1qRvHSnY16z0h2jAVm0D5ptk9hQ/U4y/Lxdizc+IlTHoouyYtGN0qaK66EfFF6Jv0QPhgl6R99pXXFOLpzcSxWy2x+fLcX/3JyfkC2ih5IsEr+6AooXNtKNr91E5pWB80m5ivuZl0/NmHFssEm1ZdKrkkA73PCRTQdoBw0vSnSIoy/Rv4QHZH5+Yx7oteuynYgXNKtej3QjeYjz8iO+ki1WLe/sN42kzwkYRoNLssdgzj9a+cjMHxRMverpe85Qoshjf3ViQAPnQoYro+lt12OlEWrCH4e6IU6g0OctvvJ0RORY7hDyOfiMm3PtCn9mzeMUX8yj4WTEey7PXoTnpFWGov7KzCSi8SKxqoOdEjc+CgooUyd55prqkH8GgmoxUBdmrK0vKKpA2BwSbIrKf1Zex3Y34YCii2OCpuUHSRgxllbvdNHHQTsQgwBmQND9FauFo12Zn/Y4xa6lSvbA+M/e6daF7iXaDAhJZIAAMmyFxDmQVRjJa5B0pw1+ZR8U6APg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(6916009)(478600001)(33716001)(86362001)(82960400001)(316002)(54906003)(2906002)(38100700002)(6486002)(6506007)(44832011)(8936002)(5660300002)(8676002)(66476007)(4326008)(26005)(6666004)(66946007)(41300700001)(66556008)(6512007)(186003)(83380400001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EpTqEmeRL/VdsDB+MhRJgY8w9N2SlfkShxL9OvgI9sK9eFLe/jEtRSa+y4bq?=
 =?us-ascii?Q?J0IRtOi4TKbPGTpD0Q2zB6DFF1fmqywkRXr8lRq5Y+7MtgSgkgc+BMo8xGHf?=
 =?us-ascii?Q?09Q9AHZI6eE2u6K2xAW6tQJutVr42qCPbdOw72RI/gMIVeW2TrjNuGvvI5Cs?=
 =?us-ascii?Q?VN6QCGTCEXUVBch0Qir7HoFPXaIVT/Ch4fqOJpxPrC3zmxpNah0DZ2t9Cb4p?=
 =?us-ascii?Q?BhJAzvEb6dKNXu9vdFGnf+j7KyDpx1LnAYp0k7UzLiHYfVTkWje3Qr4V4Ev2?=
 =?us-ascii?Q?SLZOL05r0eHrynyTgnzh6CC6Kr2ujwzqOYiopTev9Uvjr4dV78X16t6PVvmn?=
 =?us-ascii?Q?7cw+v4jewaEVBRLt16/vjmmqj9oQmKtQxZofr4rbYaz5Mm9KL4ztB11xijPW?=
 =?us-ascii?Q?YXxJEgRk5ktBw8EYT/HcNuQ31B8N1ZZduT8vbDJDlF9j4Xriyg3crEjx2z92?=
 =?us-ascii?Q?NrrAmgSR+gizjqwXeslphGFKOuvqvkyeggaHeJNHVrv6aqyBiSivwm2/9rJi?=
 =?us-ascii?Q?ZkNcB5zEgRucNKGnZ8GAjwAz8jWCH8yeod79djD1sLkhXk38Z2e64F2zY/Vg?=
 =?us-ascii?Q?dUWCh+hIFfyaWp/r9aK0dpir2g/10sgKmeSsDmSH99/BoHFSECU2FvWYlVRS?=
 =?us-ascii?Q?/sCLaxLrb7bHehv1ZaM8n2+tWN5+yv6p0WqWC2EhndG2I7ANjZyFAytIVGrd?=
 =?us-ascii?Q?qvqkMKNDzQLS05bcHwVWVfS9X6ZgqbQZy3e0OrmZAOxykIGczGBiJ5n1ARsN?=
 =?us-ascii?Q?ZkqxzBBZrPV3X9LD9VLB1LQ1Yu52Iqi1Cg6WT9atCvgzNHRbBRfS3gjEA/5s?=
 =?us-ascii?Q?w1EyEK2jOFoD2HwlPnemTzi/gsJ9QHVS8HYVYyeUCXAFQpXBj9DOpPiqONeO?=
 =?us-ascii?Q?B/u/ZfD9gI7J0rISX5zfL0WEKNVFtUIfiAOWJ3bZc0NHIk5th3svODIn981J?=
 =?us-ascii?Q?7bJUbED4NQW4hFv7dWdxaRCaUUocslH9QcV3vyoVpxWuRSufDJeQVUbu1o/e?=
 =?us-ascii?Q?L7ymTvsTr7qoqow6zGOajhhkmsXK2YwsD4gbEdsg33mV8hPxXJ8WkSH2NiI6?=
 =?us-ascii?Q?4YGFbda5JF1xvl4268FX6c7GoUidhYrNqg8fRCiOvuWBLfCxcx9LuRn2jSu9?=
 =?us-ascii?Q?gi5gDBKKdMxmhIOj4eQK7xWSkTQOE5j/Je7cY+b29iSAWbTeDAPZfkEQUEfh?=
 =?us-ascii?Q?TxYvGaxHc8urHf/m6JZhUvLfF2Py7tgibjWj2yrUr0q5pHocwuBvIKV84NYT?=
 =?us-ascii?Q?u7RD70/Lwg4oyLcc1nRc5d2Jak4gBwqhSguye2wRbueNh90MpHU71T9J2fzS?=
 =?us-ascii?Q?1/6IQmq9yAojUzKUX4gk9c7/mMhHTqPvR+/MHesqSV+40JkHUS4ru0z8KGDU?=
 =?us-ascii?Q?g5UyqF048EuKPR1VFIkf4IRme/aSXXVrEMhsAXsaEMql8xwsNXWiuAmfXWiX?=
 =?us-ascii?Q?Pq5JIQNwgyA/Q7Bxcr48Yl9vVEntb3DBqypm0VX7FAztLspl5OLJaGAZLx9x?=
 =?us-ascii?Q?RLIoA2liYVQEPu9uKQQvsjE26PdSz7ERAykV1ZxQGQ53pLa3EkwqBkyNb4rV?=
 =?us-ascii?Q?XHM3HZyXWKK84VeARPrFdA5VONL2O70OOU78n5latkqjQ6yywwxRFRe8r9ej?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d44ea8b0-74fe-4ebc-82bc-08daef7411a1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 23:25:01.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQES8KeOVZpKNfcD+ZAHFQBykro+DACJVWBhKe5wd6WDn6IF3mBRNT9btCqjzrzmC4/k1G6xcXX2AgoGlO55ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7375
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 06:31:31PM +0100, Fabio M. De Francesco wrote:
> kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
> replace kmap_atomic() with kmap_local_page() in ips_is_passthru(). In
> the meantime remove an unnecessary comment soon before local mapping,
> align code and remove spaces (the function is short, therefore the
> reviewers job won't be over-complicated by these logically unrelated
> clean-ups).
> 
> kmap_atomic() is implemented like a kmap_local_page() which also disables
> page-faults and preemption (the latter only for !PREEMPT_RT kernels).
> The code within the mapping/unmapping in ips_is_passthru() is already
> in atomic context because of a call to local_irq_save() and
> kmap_local_page() can be called in atomic context too (including
> interrupts).
> 
> Therefore, a mere replacement of the old API with the new one is all it
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

The discussion about preemption is irrelevant AFAICS.  But what you say above
is not wrong and the code looks right.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/scsi/ips.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
> index 16419aeec02d..bb206509265e 100644
> --- a/drivers/scsi/ips.c
> +++ b/drivers/scsi/ips.c
> @@ -1499,17 +1499,16 @@ static int ips_is_passthru(struct scsi_cmnd *SC)
>                  struct scatterlist *sg = scsi_sglist(SC);
>                  char  *buffer;
>  
> -                /* kmap_atomic() ensures addressability of the user buffer.*/
>                  /* local_irq_save() protects the KM_IRQ0 address slot.     */
>                  local_irq_save(flags);
> -                buffer = kmap_atomic(sg_page(sg)) + sg->offset;
> -                if (buffer && buffer[0] == 'C' && buffer[1] == 'O' &&
> -                    buffer[2] == 'P' && buffer[3] == 'P') {
> -                        kunmap_atomic(buffer - sg->offset);
> +		buffer = kmap_local_page(sg_page(sg)) + sg->offset;
> +		if (buffer && buffer[0] == 'C' && buffer[1] == 'O' &&
> +		    buffer[2] == 'P' && buffer[3] == 'P') {
> +			kunmap_local(buffer);
>                          local_irq_restore(flags);
>                          return 1;
>                  }
> -                kunmap_atomic(buffer - sg->offset);
> +		kunmap_local(buffer);
>                  local_irq_restore(flags);
>  	}
>  	return 0;
> -- 
> 2.39.0
> 
