Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8974B6D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjGGTD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjGGTDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:03:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE11271E;
        Fri,  7 Jul 2023 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688756600; x=1720292600;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GRnVQoXcjvhm5OoSQ63fEQ9Cu5kAM+1gtkx5DRojiKw=;
  b=bEAi2Ykyv9w/jK/nKC/+NN/KW6TgGt7E17Yz9UZoYMu4d1PlSpd3cdr7
   sr6AeMxzqXGh46pqiYKV2FK+A7sC5yN0YvEl2XDksNDaELoYeumIZWVpc
   wY9KxTck22W4sK3t8CBGsGoVoveZQLimkpZBwOV8pNEdTXWOckd868sgo
   8OE+LHGsAjjwfkYRQGARgjU2vvJKwZJw2NSeEd5TOXvyU7xrk6pKyxxCe
   TcPn3m4yvvL6WHCDPW1kADJpoWLAQ7A6SMqLECrNz3L8RJ3DTHXF/UkUb
   dob1DQTwosCUmErwquW4Gd+oCSwEOKwOoIiMAXuQJA6nZxodmLopEmwE3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="343550628"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="343550628"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 12:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="833503955"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="833503955"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2023 12:02:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 12:02:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 12:02:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 12:02:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 12:01:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtWVZRsEJEMFFKlSg2vW3v7mpvhdVcujXxb73jAFTfKTTPfNGul4MwgLe1Bsq+dbqUik7k+aPaGsNiGSYotq309v+zmHdllCoB7zmmAnTTYEz1eMH0L3fPqU+FjY17JgkAQqBdVrbTizPUmj/lxzYU87qZnCOiBttt0Z8qddmJVXnYT08HQQJXMUcozl0oz5uRNKZaPsrERiYA44laCSHsdHS0ZuY+yyFm3zf7TAj5wp4IrH2aaDkVt1qMZGD4XY2T/Hik6Y50qdb/nC/D8eDgPxBMhmNhPMDwJKjs8rlVCW8+E21YOZ2AYKwdaoMLIhJ49py3WcR/yzlmkPcDHZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5Qa+3SVT1A2lUD3BJg0eIkoNQKhiXSBV6FAU4HXrL4=;
 b=bvQdmymrNR+3fpa3+SDErNtf1K7cv/SvyqsnW8NQJGDUkiBgXv3FM5mOYQSZWPrROy8tLWAKdIIBEeJvlyQ/QX66DzPaJGGHVKCbObwdrh0b5N6cQ5tl/mBD41lU2EfoyqmipUP6XorRihOlgR+eBDj5vid4ZfAZ+X48NRfcJk4I0b6PKpA6HQQdSKZ6jKSdGjRX5tA5xmUgnLFAHyj9dpNjc2283CAoUbHE/V9MH7hODmy/2LmV9Ep08qS6U6euUS8g23BjCMAoB9Z3bJqZ03VrPP+ICPN2TB3jUssP1jHAoEbAlUhUTKxFHr8WnrX/qxzPUwExg+kLlh/aMYLFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB2943.namprd11.prod.outlook.com (2603:10b6:805:d3::26)
 by CH0PR11MB5236.namprd11.prod.outlook.com (2603:10b6:610:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 19:01:55 +0000
Received: from SN6PR11MB2943.namprd11.prod.outlook.com
 ([fe80::af65:2282:23bf:d2d3]) by SN6PR11MB2943.namprd11.prod.outlook.com
 ([fe80::af65:2282:23bf:d2d3%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:01:54 +0000
Date:   Fri, 7 Jul 2023 21:01:41 +0200
From:   Michal Kubiak <michal.kubiak@intel.com>
To:     Suman Ghosh <sumang@marvell.com>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH V4] octeontx2-pf: Add additional check for MCAM rules
Message-ID: <ZKhhFeKmxlN3hFYD@localhost.localdomain>
References: <20230707035321.2227742-1-sumang@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230707035321.2227742-1-sumang@marvell.com>
X-ClientProxiedBy: DUZPR01CA0296.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::25) To SN6PR11MB2943.namprd11.prod.outlook.com
 (2603:10b6:805:d3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2943:EE_|CH0PR11MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 3459bc1e-3c8f-4751-97ea-08db7f1ca169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5tyu/LwLMUU4chVfwscnOLTgdv/7XdNfNBlco1fie/MSjJVNsHm+1VlxNPjja/AdCHF0Ujevk/6xb0fHiwnunsXJVO2zyMaKmYFK5HpKBW9WCiUC9FrzYiTQpHkA4ggGVb8ykj+RGrgtTd99cMu/noaxjut3pM7peNxFGNEMJZQbvilIv0wm3hIogOu9WYqOG2eH3deGAwuoNrAh+4vo58zlMU64X8f/kPhj9tpU1JHZlt6mgJpEWOUF71tsfrOrcFn5jkRg3gC2TZfmaqQAkZV453NpP6l65Jhvdu6Ts2N5QuNNh7ovZpernRo08ITeiVuz0hXBkzkZBST5bNrYGkTan2XqZMoGGIzBE0GRR99z5Di4FFiq/I6kwqJaom9LhJPtGvUg+Q4uEwOUf0x2LiZJTmmwio2ZBqwfkfdTbZUcUAJkt3RoOmbGRjDQ5kXhys0BUMdWrX593UEqdHjWs5xcI55XiWScn3LTulHH9m9hUvixn/pFTiEgXFfAskkGCmxt1ePtGho5pErD1u6xTeIpaPK+dLvy+R4kaDpPaTgHshP0E1gIMMpuu+TToyu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(38100700002)(186003)(86362001)(26005)(6506007)(6666004)(82960400001)(83380400001)(9686003)(6512007)(478600001)(6486002)(41300700001)(7416002)(5660300002)(44832011)(8936002)(8676002)(2906002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VqOM/3rkca4UsdLSkwvl22yZkUQuUv3ntvLRvrc7DH/uqbD1jv2Q3sCtaZUC?=
 =?us-ascii?Q?CoZxZVAVr4jUqezONOlRNLchDM8sZ2FqturWNzdxMWNChFnKK2wEFUTI+Q6c?=
 =?us-ascii?Q?sDmYQU11ZMKXYuXCfueQVYvlDEPIDR+pzZL7jDbjZTUBmJuAV3MNpccqWqD2?=
 =?us-ascii?Q?wwBj6EORgzHSip3OPGZKaEiY1tCbaQovhVTW5+qUngIyOiciJQDkzlnH5pwn?=
 =?us-ascii?Q?1ruGlgPy01m38Grkgqk8nMT0KeWZJ7ZSgXRVrgqoTngFtnaFfBGi7wXWwkg4?=
 =?us-ascii?Q?+nqMMyFY52siEyDpMrA/uC2PgrBE+ZW8nkMcJdGtDw7HEx9EPCwYJKP22b8O?=
 =?us-ascii?Q?+F+48kHXFGxnvf+Bogk897ubRwhvsSRQ8i0tBG9ysSzC7kXVvi93Hoa5w9zF?=
 =?us-ascii?Q?ImwnTfGRUY9Hok4M9TP0oLzYoy7ic+nbBGrXrj577/U8iqtdKjdEJ6jAwhY8?=
 =?us-ascii?Q?a88n2y9zMQ7mcEGSDoMiDnXcMvP052f7x9JgBD5ViihTpb/X5pE90WaH8HlK?=
 =?us-ascii?Q?MJp7P6VCe6ZcGARlX62msW516TifrrIl4wGsE43pH4VN8ps2pRuBse6aCS6H?=
 =?us-ascii?Q?ZjI6WVSwsiOvLVFswEYAdFDtt/oeSltOmup7CgYPEy9AVs0Ov4Nf737cicWI?=
 =?us-ascii?Q?iZXXtGLy3pNoE/WK9yAnh8Zm9+WmhdRleTIZLwE3y8C/Qafz4TLqAtckE8ql?=
 =?us-ascii?Q?HWjipKabwEPz0z17Ah98X20fE6o7XWFI51FTFqgv+MxgyhjiPN0I1BBAAZIL?=
 =?us-ascii?Q?1jK1ZvQRaONbXyi20haVuD/dHu7EfqM6XoMkw3srri8Qt2nM+MGfjfL8giWK?=
 =?us-ascii?Q?As180J/hQF6yKJnjiFdnfBVlcR49+DF7935dQZW3spZk/0WuxeRDTI5oxIIZ?=
 =?us-ascii?Q?2dNc5ShvNM04uaYdtgpWKlfwejbDMfOLk/WY7djBfXXM5ylE19Yu8+k+sqki?=
 =?us-ascii?Q?QVbIpHqA2att5zyF3Yv0u17HyFWFGXiEew48nS8Hf+3fu1XUCn6Cq2CLVG09?=
 =?us-ascii?Q?d2lovbAt2n+fP6FoS3vUM7yJ/hsbab9vtSgbq3mnQkpzg0fwbjkJihG5hXY5?=
 =?us-ascii?Q?aOsGdgZKvq9F57YYWIZjb3BmjbLTt4AEahGiB3gQ78taoBJlCBnp62cmakc9?=
 =?us-ascii?Q?27/SAz1JBEAH6mSO+9fDatu3T235RDOWkAbcd3d9Z7a8Rxaj+Nlro8bNpCSR?=
 =?us-ascii?Q?c4ZxYXEYhSpH4H7bMVsNMzaobM2orZUQ+N+QtzTSCyB1loHyG8Eku/0o5VZR?=
 =?us-ascii?Q?d7mmYH3YV/4E15w+dz0cOSIMC0IJxisi6HrXLQZJ+ScKl3pYV7Nal1CWyUYI?=
 =?us-ascii?Q?LpE3bNqYLhssu2DwvqLI75lLlBX9fP/yfzWJEXauCHJsPkNUv3r6u1roA8UK?=
 =?us-ascii?Q?XyvwvgYd7pYpnEMalfZG7mZ31H8h1Ctf7Rr+5Tpobs0jLfmrIclKxgAdezMm?=
 =?us-ascii?Q?IppP+u553Hd/PlRXzgVer7uAOn1xhxc9yY4BqFNW6pXXi9+fKBzygkHpd/mq?=
 =?us-ascii?Q?qN1TRtNHviMtQ/8ChPiEjSsuXOYokF9d0v8XleecdHguwkzUeBfrqTi1zf55?=
 =?us-ascii?Q?/8zz4jm0ijiwF3fAPUz4YZCaPAhVR21+njAKXGhuc3AJDnwFw5/uyHYWnWyo?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3459bc1e-3c8f-4751-97ea-08db7f1ca169
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:01:54.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2isGb4VMN1/Oczs+zy6XHzmgiMRvqRSojbURfm37TTwWLowOg1YHFiKrsMSnD4Ocom2RQVOGlStkvZWLXo0zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5236
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

On Fri, Jul 07, 2023 at 09:23:21AM +0530, Suman Ghosh wrote:
> Due to hardware limitation, MCAM drop rule with
> ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
> such rules.
> 
> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

(...)

> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -604,6 +604,19 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>  			return -EOPNOTSUPP;
>  		}
>  
> +		if (!match.mask->vlan_id) {
> +			struct flow_action_entry *act;
> +			int i;
> +
> +			flow_action_for_each(i, act, &rule->action) {
> +				if (act->id == FLOW_ACTION_DROP) {
> +					netdev_err(nic->netdev, "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
> +						   ntohs(match.key->vlan_tpid), match.key->vlan_id);
> +					return -EOPNOTSUPP;

The code got very nested here.
Please consider moving the above check to a separate helper function,
or at least reformatting the error log to fix the checkpatch warning about
80 chars, for example:

			flow_action_for_each(i, act, &rule->action) {
				if (act->id == FLOW_ACTION_DROP) {
					netdev_err(nic->netdev,
						   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
						   ntohs(match.key->vlan_tpid),
						   match.key->vlan_id);
					return -EOPNOTSUPP;
				}

Thanks,
Michal
