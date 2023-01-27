Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E367F0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjA0WIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjA0WIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:08:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE7330FB;
        Fri, 27 Jan 2023 14:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674857309; x=1706393309;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=slYALif1LqHa+KFSOZ8TO0Df6mfm5IsWNv1iaAfbn/g=;
  b=jptOIH6104PbzqC62Ul2jPkZvEWoQ9qKtExYlniRnQwkrBYe60lnbFz2
   LhEd8jRiLK8Mo5a3MEhNoc/24iLrD0ztSupRafGRlQwTwJ6EuDBUJ9FSc
   l3t8/XMQgvQCct6jnsrb1uJSa/jrg0Iymq2IYTf+ctLUXB9FpLrgx16re
   1ZUo4mAwm9XFzI52VC6FuyRqCXjS/+NWORwgv/vq9wRl4mg5Qy4KZjKtd
   pPnzub1m8ECXLV5EZMpn5/TKnYy9txlMk/Wuo/KUMfHsc2B0FWXc9wujg
   UuvvZP8JeW1lZ8+nHOCoaV9RWYicNfmmT5orNCxqzeCu/qTZOv0RVz5Ep
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="324899907"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="324899907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 14:08:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="640840661"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="640840661"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2023 14:08:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 14:08:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 14:08:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 14:08:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 14:08:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVANuby8YN+Wl66A7+9feb0xnsdaWolVE7GYQHK8LSWw2g1qYeCEMz1oKxnVpLGZOH87r0q7c+D7zJn1kwgOARgddcl955Dp0UKLIgqQSt3EW6pMd/LAUhhldKHqs9P0R7060KpzP9XfadZcIXEyzkc1+IKI/qgS/rYNQnQebURTt5HGKqgviEnF2WVcGH/cNZ9mLnCarHeGe1G2PYBLmNGf4WuLTQH5obb8K37RIayvMXuxf6hLm8SgjELLoVldarbL5h71KmBuKsxIEFU1VeUOKSniU3ZdWQBPGSvarpwmmWua8McV57uvw5/nNO2o+9QGP63hSQBMcw3Q8Af4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG3gY3hYLv1T8We0tggdtew1SBIn7yY/fTqK3L10Fa0=;
 b=k8zTNtShO96sOyjvCCGnle5bLhgMs6522e2e5pQMlOIDnOjIin3ykaGkuhvHc0csoiqTGdP+p0/fPtYA9EI8BeNWWjExCiG0z1Q9g+hSLfwGXT3lDldiVKcuU02cla5eoxrrFYdk30kyM47mDmm1P8nv+ThbeVUj+4gXpYgJZiuUv3U06qM0xkA7aoFWtSdXznTxA6xcL+UHUtNECZBfPwqempTfshMc6NtFVCCeri+jZ1y4aef9ALfjgl6nPdEIgRjttpxDClRyPZJ04rGqVj4GWvKsLKEsYMFmpB7+m9EEbHdVdVqYyola9V8zpG8UZQirBlEnR7IBeREBrKBT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Fri, 27 Jan
 2023 22:08:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 22:08:13 +0000
Date:   Fri, 27 Jan 2023 14:08:10 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v5 5/5] tools/testing/cxl: Mock support for Get Poison
 List
Message-ID: <63d44b4a9774_ea222294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674070170.git.alison.schofield@intel.com>
 <cf91261216b809f70c4cd2c2637aee2c71da6b66.1674070170.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cf91261216b809f70c4cd2c2637aee2c71da6b66.1674070170.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:303:16d::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: b58618c2-d2e6-431c-0df1-08db00b2fbbe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vVTL7M3B+9obY7dBDdQ3q512rd08iGW5sJwWB36xSTRU94yr34HmB4iX5bbFqDP2eMW8YSRRczRQjDwd+snQ4p8KmRJBv8HsaN8JZV3zm/tqzR+AcqWbVmYYBOjAfdkFxNb09Y+6QBmbWyF61gUvNF0R8zzRcGppDNLQFDg4mObq/3wfBeR+n/g9yWEVzYmnyiAzYGJCVYWAjGWDC22ECldW3WSnNF2RuOKjnbzP13i3aVvbR6NEr+mZkEFnX+y2PPs4VNfIdPt+0ejNT3TW5VIWvos+1IMr4fyIhlguPG/7skZtZMB5cdSELPclcJckIALsOLScjiuz1iOx2qWL4cYSkLDk1LtPGxJdxLGKNJ3ikG0Fh4Z49OxofnvTFrMUUP+jQZYFW1mdS13mG025ypRGwQL5t0a9wtb9gEX5pj4nhKWAdlzzlmC+StvE5XhsLPVqPlkzg9O67ZhXJns6fQWXe4h6TSlT9CeJYKhxHSV20tvsCFqXAuNNsuQ0ffclRShAskenjGAF7hhmRnj3tlE3IInMGVsKDkcpdZNpWVMx7aGdlV2WG5uUyoEE4T9nDC/eFfpIy+5v9L7xejGn0KlCxhF2Epg+KPjSsR+K7glCGG2RRPzKX7stdeyAUnESRg5wjLWr2zYMAo1Xr2ieA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199018)(5660300002)(2906002)(8936002)(8676002)(4326008)(66476007)(66946007)(66556008)(41300700001)(478600001)(6486002)(9686003)(6512007)(186003)(83380400001)(6506007)(26005)(82960400001)(38100700002)(110136005)(316002)(54906003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zZFepJXCZAq8E7WS4xbw0b9ROr3GNhKz4r3LHOM3udhNf0xkKj8aEPkeJybL?=
 =?us-ascii?Q?Y8+xnELcnsLDStq9gAG2YtpF1iO3OZLo69BOhKkO4SL6KeL4cmMLW3ocd81v?=
 =?us-ascii?Q?Etv0b6mizJB8qobaYJoBeVh7KH25fzGURohjv47HV+sYSy2L17hSHdz9+MAh?=
 =?us-ascii?Q?bnEFEqmMTTqqaGIJaXxPqHLw9VVVlMPfPI1IVndOyp0Hp2pQwMcLtKXYqcBF?=
 =?us-ascii?Q?sJb9vNSrtrPhBNgF1zadKAIzE6iFN0oQ21wsHux4D68iCA/EnoZJvMHtLb+O?=
 =?us-ascii?Q?2aUBWscS14jlPXdz1P2QzXhardhY7FGognx8bedMoIiT4AOrLgic0JO4G2yP?=
 =?us-ascii?Q?1Ith44W6oh6bkKUuaOg3wKh0DD30pqlZIXJzh99cH1CzS6BTlZOq/B98c7uP?=
 =?us-ascii?Q?L3WgG01VfMGsVnlZZC84i2t5KEhwx+O1f4+TLqZjUvnKnx5vpV5nAfIPyOAF?=
 =?us-ascii?Q?ulbPw1p2CEhe4N876onnFMjIojJqxaLkBMCuuz9pYCou4EoeytIHbaWlX9zs?=
 =?us-ascii?Q?WkH9KwDbWnCAUKbIYK5PAOZZAwHFjA2BgjkxMUPlY+y+Ds+MJz43YFc8VJU/?=
 =?us-ascii?Q?nFjidY14f4JSy3ZvQn3W1xRInwwsLlmqEpSwM4oKlO+++fXwqmXLBuJhNU1u?=
 =?us-ascii?Q?UQskYP3vuVXnwRo0oqgklrj7gdfIabJjmfMEBXw/kQvP0YeQ7cznMQMHk/Yt?=
 =?us-ascii?Q?xoMv79vUurftIAgf3d3JGaxo/BxmIbgojcFJYjmeSS9bPvuvd+8yywFJlj1z?=
 =?us-ascii?Q?GuBLPCfOLjEN53118CeCbSNrhAQBg/pLbRw8g4BYuz9wKXGIw1L/g/Je47Bm?=
 =?us-ascii?Q?rtak+8g3I53uhFP7paM616k9GSGi12Gs6UcxETdwDi7d5vDwb2quBSpRKcIa?=
 =?us-ascii?Q?j8v4s/X914X8ymN7QLi/lxq5ISlzEUAaTBlX2fDWroff/4Cyrk58H3+eQYsa?=
 =?us-ascii?Q?jeuEbL+dD1IPIY2ZLZIuB3PYHXWTVDY5zMGTxt7/5R1P48Lt9or/BBd6dTwq?=
 =?us-ascii?Q?XPbgGSchqZAc1s+mdPBd3dDgPsPpI0PIHkLxeooecJ+BkpPD1gIlfc1Kqe0J?=
 =?us-ascii?Q?D4pjTD4e2b87sJfOa7jCXMcmHmOmAqMHrqKjj40+MhKM3z2yXZL7x4EV+27k?=
 =?us-ascii?Q?E4j82HZ9j1Sp8eojj8EhbUbt1afPOwss6JbSBE3OnM61IWe7b78P7N/3+6U+?=
 =?us-ascii?Q?Kx2RbtdPhWiJiPdFaxyfnTVmCMsiQvcPYCLxIGqivh/lp1GQ8MLSHvqmRZyT?=
 =?us-ascii?Q?3qog5gLrJotKEIjtKTnTFymIc/lkbppwWioNFDiKTnObPa51sP88kIvFfHA/?=
 =?us-ascii?Q?wWyo5mXUPT1wio0QNmZ7byFNDEtvtd3LvucN3PYnJj9WP81RdL+ll+rTB51U?=
 =?us-ascii?Q?O7vRwzDL1FXPT4erxhETDtUMa/79/65dkRcNVjXYqysjMzbvLvPZQ6qgQIo0?=
 =?us-ascii?Q?ZTP3piL7YBX9QD5BMOWYC0+enCNQ9jfbTvqaIac2v0KqOuxN4ACbZRvLy9U0?=
 =?us-ascii?Q?QaVmhfmX8iiSRn8lRhSXNn/vvsJzzMiXek564S6Pnsl/BHVBA8eM4jKY62V4?=
 =?us-ascii?Q?Kon5pGKdpem4vpC7B8/530HqKgik5NR1l14Ey7arLpzdAMNKN4LF6QafKply?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b58618c2-d2e6-431c-0df1-08db00b2fbbe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 22:08:13.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aHRiloYPgVpeEsWldVHIiwRIyH/MfaS0VPMNByhoLfmWrRRydzelDkeZsr4PwKMawYl26tG89D4cYJQ/k5e+2yZjEfa1j1Lo6dl+jNmpPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Make mock memdevs support the Get Poison List mailbox command.
> Return a fake poison error record when the get poison list command
> is issued.
> 
> This supports testing the kernel tracing and cxl list capabilities
> for media errors.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 42 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 5e4ecd93f1d2..09dc358bb33b 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
>  #include <linux/bits.h>
> +#include <asm/unaligned.h>
>  #include <cxlmem.h>
>  
>  #define LSA_SIZE SZ_128K
> @@ -38,6 +39,10 @@ static struct cxl_cel_entry mock_cel[] = {
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
>  		.effect = cpu_to_le16(0),
>  	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
> +		.effect = cpu_to_le16(0),
> +	},
>  };
>  
>  /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -141,6 +146,8 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
>  	};
>  
> +	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
> +
>  	if (cmd->size_out < sizeof(id))
>  		return -EINVAL;
>  
> @@ -558,6 +565,34 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> +static int mock_get_poison(struct cxl_dev_state *cxlds,
> +			   struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
> +
> +	/* Mock one poison record at pi.offset for 64 bytes */
> +	struct {
> +		struct cxl_mbox_poison_payload_out po;
> +		struct cxl_poison_record record;
> +	} mock_plist = {

...I think this needs to be __packed as well otherwise the compiler
could inject alignment padding between these 2 packed structures.

> +		.po = {
> +			.count = cpu_to_le16(1),
> +		},
> +		.record = {
> +			.length = cpu_to_le32(1),
> +			.address = cpu_to_le64(pi->offset +

sparse says there is a missing le64_to_cpu(pi->offset) here
