Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF774850D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGENeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGENeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:34:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CE61713;
        Wed,  5 Jul 2023 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688564053; x=1720100053;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RmChDKR83qxZ3iePaUY86VO+ISEOEIIKO9JP3CvU3MM=;
  b=Jcy54qZuJEDLM27exsq2NLMrABvTbFtL3YKCsPTEMbIep0YyLElXFpH0
   1iyz17T+8o9/qi8ga7aBNeuwmSJugmMbDHXtZgf1iS0Cwgm6n5V+s3Smf
   Y0G+9u/9tI7ABn+9+H6F9Yhz3dz97jsO1pX7OoXwvgkmK/FQGNT9etwM/
   JS9MPPAEqGwP3ArYDetCOQPlGkvLx63QHTEcOoIgBSF4H2ZRpFBzXTyxz
   nd21wbRWgMnvBC9dBXR0a1wE/jgavzr3dE7mpXMFhBVuWl/9dDH7UVtdZ
   TN740o6gz4E8IGCuCMMUF7XZdoT2LU+kCOJXzZxa15ITRk3E2A4KMgm10
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="342929521"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="342929521"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 06:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719234087"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="719234087"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2023 06:34:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 06:34:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 06:34:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 06:34:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 06:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5XWOTkyMXdH2PCF2eiDW/NdxnxEuOPy+/83b3+ZyGaExRgTqN5dK48SzWUyVcYQkgoF7WVw0PNtlBLp7xVir5LyONZJJbz6N8qvtyofJs7Nx6Wj8BA4u0zice9oaJkDCOvjOvln8L+Rf1qnIoVZY0Qt29Wx8lyLb1Hw4kUNYXi9TF+IfkzXZaWxM3+kQE7cxMmodJlIKghfVQccYKOVXugog1aEnWLwfMibbTg4eaK2o96cdh0KmEmZf78WfId+9exiQ5OhWYw+6BBFFkp9s9HZ72IWlwgc6D78AxjQ0/vRoCgQ21+78LX0psXZt9tLX8utBD0Y8nW9eYisAqysLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgcf0ZKpKuBB1jLsRbiChoHhNJ+6FVMcnYC9vuO5PKs=;
 b=fT317bsCZWPlu81re6h9+OSlgHep9ClHZda+EZRFDm8GaYx4291gMpaawfvFJ64KsKGgJjT0cYdM/NeQ04A9mYcxQqvb14m8YUQZ7PDpuK9qmsFHCYXmw/VCsAORnrUXKCN8uFtynY7BENaZFN4kKzdmPTrgisZ5IXv3GsRb3cY5+VfMJL1wTSCpApWUv2jrs06Fd7HH5HWZFUG+ue2TIdj1zMSteOZJ+qFRmWBF3y8IKznUFIfjFyyUdo6E9VkutDVik08kPc2/PHSBx2jcj8HkdT1CN+i0z2u3dLqzfUlyoIl7edRqe2tcMzqFOz/DVTl8Az4IKfzPkdMQWHZ6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 CY8PR11MB7268.namprd11.prod.outlook.com (2603:10b6:930:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 13:34:08 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:34:08 +0000
Date:   Wed, 5 Jul 2023 15:33:55 +0200
From:   Michal Kubiak <michal.kubiak@intel.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sbhatta@marvell.com>, <gakula@marvell.com>, <schalla@marvell.com>,
        <hkelam@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Promisc enable/disable through mbox
Message-ID: <ZKVxQ2HtG+GtumCj@localhost.localdomain>
References: <20230705033813.2744357-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705033813.2744357-1-rkannoth@marvell.com>
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|CY8PR11MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c5e601-86e7-4a4b-b48b-08db7d5c81fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORWzTh2PRFctYWfoyMiVu8YBSUJ3naWfjL7NqBD4ZW14NgEx5OndQhOicjl3Q3VypGKrFWyXZg3iDy/EyzGJDzXmZn40TczbkHj5FPyBQyBuyLpaoKwomoj8Oo2SiSJzdpHBwjhHQ7ciHtz4/5rP6LTeJmQCUIQYQF0nAJQBWR59MuL0YjVTEkgfy1hYvaYHtNjkeVA3UljkLoeKOEIXPJS24S9y5dF7vHqKPpcleIZ+wBtdCxWMM0o2CZUOVYVOb/w8Sxle616m3LE/VPhIPkVlfNeviovqs18u0O+MBHb8JAmqTdfk1QlSNof8KTf6w1yrdRUtTWnQrgwvUn9VofKK07DV3vbtRELCqi18AZLrjThzrCghJnkbIbz3x7juAFZ9Y4QkD+O0iUGfFTf6R0ewmFi+0BRXQaYqs98IqSfctVoabdohsH5kCdQApz+4P7jq2CciDY4L7O2anbkcrZKpLVcdLlT5GbFk4OeS+2q2T/V0gQuXXzQKwVr/na8ad9P0AxVcQIXuMVHOSNGDiLZ9xuDC8sFqSWzfDj2Cl26jyIrCkRsPDyPyvx9m5mcbxRNBWuD3PkKqUTwc/loeNXI5G8S8w8j+4R8AhJyoyR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(6486002)(6666004)(478600001)(83380400001)(86362001)(2906002)(66946007)(186003)(6506007)(26005)(9686003)(6512007)(82960400001)(38100700002)(6916009)(4326008)(66476007)(66556008)(316002)(41300700001)(8936002)(5660300002)(8676002)(7416002)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U/dR+HeRKIlusAMdDeQMavYBviEQAqS/BqOm8ESfG9baHIrasgnz7vgdhasu?=
 =?us-ascii?Q?Z2IPQ7yD5Uh1dwU6Kk/atYWxPcUkwju4gWpOOnT/fsRYRTZEs7NoqMscs5YN?=
 =?us-ascii?Q?SJ2aDpp8AdmW1yoOkYrsibVrDCbk3kPqJufXve4WZcd/VSjY7c4GxvOvotqf?=
 =?us-ascii?Q?TGqS6AX5d/8NCTbje59kfpicd/skT8p1aYp/DvpLxh32Trb8ReN/UbSpD+D4?=
 =?us-ascii?Q?NQ6wZXUUYKW46tSMIcn+S4NvlzPqnJBAyYowBlHt+pitQsUAUwrBS0R7rRDz?=
 =?us-ascii?Q?mdRS1QWtFu6SwEzI3Nk6mfdpRRWD0GVf9RvCZ9m3LdN/6l0mmUcR6cogsXJe?=
 =?us-ascii?Q?4NRWHwfBQis/j+JhAGBrkz5E+lWIcAkl649qNVR1AyzTxe67Rg77Qb3E7NPc?=
 =?us-ascii?Q?fRafRnRtAIAYhcATtkrV+GEGIJg+P3nTsUPCc2vhGXVt3ftEC8dNAOSbtfed?=
 =?us-ascii?Q?jHqMlDeqXjxAgd5OAoMEGDvaetbDTZq6fEdodxVGd9OCeVJjijubx65cpyrV?=
 =?us-ascii?Q?yFUOl2lo1m/YaYPuIoqQDothkT5TNnAuH4Ei61/mQ1aGQ3ZDtIxYUw23e/tt?=
 =?us-ascii?Q?KWHyYYHcYTz8NsGa1W1iCPNj6BctzUpsUrDgciwGLKTgNcIEcrj334aUFqWl?=
 =?us-ascii?Q?RebxbwspP1jDGzqlnpzqnDQP8u99Ofzl5tVlMpc7G03QWvPVnVxYyRoiGbUe?=
 =?us-ascii?Q?JzkwrwNUGR7kO5syT27EE5yQ06uvwyxGlBDaa274bCM4dVpLqbXTZ/Zn2eDU?=
 =?us-ascii?Q?9PJl6sd1Qd/QXr3JEGp8IvCnRxSDDO9oPFAgTZn7OEzquGT/z6BAPeVcXW23?=
 =?us-ascii?Q?vuh13yBNYIkallNW5Qn9Ij0NchBFCc/vccysRpPoPiQsjL5nV65Z1yKrcGZN?=
 =?us-ascii?Q?D4ZLvE3Rzgo62SCvgMloVBRLSk0TyIQ0NzXSICymATA++UQOFXmR5FjnAQi4?=
 =?us-ascii?Q?FxJYCsyoFJ9eT7Aqu0dMOA6K5aK1JB1hiO6lQqRIcD7VM0lZGBpbDA1ifsmL?=
 =?us-ascii?Q?OI6jKlKVzidhVLTjQO7yMYogI6maC2uOoTAPIkmh2j8WUtpFyplTJJzFl+5i?=
 =?us-ascii?Q?byBLuT1Qux8jvz7g0VWGx9pr5Lv5nSQbdxX8I6rZ0/4gIKFYMq0AvSdhMyX5?=
 =?us-ascii?Q?sz+hzzQEfu8WDkrJxzB6Wj7Djmi+E3DZQW9jkpcgYydZoVHB0WJrOD73ozUB?=
 =?us-ascii?Q?6KfRt8G+oLZHtnRC5gDayut2kKzHdeaejCM8vW0XgvzO+HC24rDUoWhv2DqI?=
 =?us-ascii?Q?MIEjmJZaLyGfvjwtRwczEKpn8DDVBfPmVUgh3s9p0W61hOZlGbidTRsDxe71?=
 =?us-ascii?Q?/EF0CZT5I8iQ0beimhdncMlS1DV0l5ksM8iaILI/Til3QPwGep40odo9CLBc?=
 =?us-ascii?Q?sPZ+KClipi1hDVMl8zf0hgkHkAuZ+abWF4kb5IHdN7bvnx+KXKEMmihyjXv0?=
 =?us-ascii?Q?m1bKXf+4xJgYiXH4aYAh9iQ804su9faJCQQIGQ14Y1fnnBmoFLY/2CcwyI1p?=
 =?us-ascii?Q?ixoAd+4qxdH+IUHVZwNzbhFX/0QQy+5Y/IfD4Qmps0uSeXBonL6MGI2ND0hp?=
 =?us-ascii?Q?dXxPCuTsVUoavrZKIZLKhzmZkU1rjpzS5WRjcbNnahEOdRfihYoD0puNNq4i?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c5e601-86e7-4a4b-b48b-08db7d5c81fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:34:07.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMTbLnhAwjatxlzoluUFxffrEFxuVbCcZulghmJlONUZA/xbFdGtqmJRx9lYsVrJmJgzrOTxaMui6fmDvEl1Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 09:08:13AM +0530, Ratheesh Kannoth wrote:
> In Legacy silicon, promisc mode is only modified
> through CGX mbox messages. In CN10KB silicon, it modified
> from CGX mbox and NIX. This breaks legacy application
> behaviour. Fix this by removing call from NIX.
> 
> Fixes: d6c9784baf59 ("octeontx2-af: Invoke exact match functions if supported")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Please follow the Patchwork report.
There are several lines exceeding 80 characters.

Thanks,
Michal

> @@ -1177,13 +1179,16 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
>  
>  	*enable_or_disable_cam = false;
>  
> -	/* If all rules are deleted, disable cam */
> +	if (promisc)
> +		goto done;
> +
> +	/* If all rules are deleted and not already in promisc mode; disable cam */

Line length above 80 characters.

>  	if (!*cnt && val < 0) {
>  		*enable_or_disable_cam = true;
>  		goto done;
>  	}
>  
> -	/* If rule got added, enable cam */
> +	/* If rule got added and not already in promisc mode; enable cam */
>  	if (!old_cnt && val > 0) {
>  		*enable_or_disable_cam = true;
>  		goto done;
> @@ -1462,6 +1467,11 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
>  	*promisc = false;
>  	mutex_unlock(&table->lock);
>  
> +	/* Enable drop rule */
> +	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, true);

Line length above 80 characters.

> +
> +	dev_dbg(rvu->dev, "%s: disabled  promisc mode (cgx=%d lmac=%d)\n",
> +		__func__, cgx_id, lmac_id);
>  	return 0;
>  }
>  
> @@ -1503,6 +1513,11 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
>  	*promisc = true;
>  	mutex_unlock(&table->lock);
>  
> +	/*  disable drop rule */
> +	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, false);

Line length above 80 characters.

