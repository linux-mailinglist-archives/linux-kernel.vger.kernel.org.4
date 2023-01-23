Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B16678BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjAWXLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjAWXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:11:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2107.outbound.protection.outlook.com [40.107.93.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1134D3A5BA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 15:11:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW1ab6HgHIrD7fTZNee491izwWs1yLEb1x3nts4DQI8JTUJjXuoLW9q+rOQJW14xYWAsKThdtsvQw2r5N5Gt3gdMHn9SicIJIiSfFUWkLc7l/30S5mTgbfdtLT21GCoX0G77wTJPAWvhO4QO4BcxqaUcDpeWxbef1A4ct8n8yNXzOilC+XbegsiNwr3fGmVp68vBiy4rOc1JdjMz/GIFki9GXraF9fp8w/B+Zzn2tl3Vlg18IvK4PKTsIfeXPPTBHthYD07TVYWqzkh+60GObm4ytGc79Wt4HV74mmQlKoJwXpW040Vxn1VDlvN7aedQKqOpuCqNw1fAJNh5rQHByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1D3waDUz9gU9fn4w59LxM+yF15GxzGg1S2AuzSWxag=;
 b=ZnzcQGRGzL9LrSB9jTx6e2KQVy/zc8kseq1CuYu0ItverwL+uDK7vSWGxh5C6sPQlPWlsqx8PCIRErvTAkfVLSV+2585fhnyoG+pZoj1yFTWPziZ2Ooljy3FGhHjS19xZFTDFdGWTxJEjrmvnLpAmFmfN72C2n+zofy5EoISvuse7arPcJ6NzcZjcHZMz5S9xg5cPQJqr8U8lZANvCHmUBdI6eDT4r8kdDgD2DtLDwNfkNjoWE0cFOjzItGWtPDyVhJuKSTs3qwzTLhbd4kKe4lgbuYfJdHwCbRRpkTMIYpE/9u44q1ajlpM8GLqfVS7dnkv+PetJd4BtAso51U3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1D3waDUz9gU9fn4w59LxM+yF15GxzGg1S2AuzSWxag=;
 b=NyBnLLj1tFy0Zet4Rp7deaDfgosCqWyEUH08t4wv8jKaTiaHy4pNZiVIdUN4LT5qv1gsh4nXaUrJTzcEmjpDjwI23laF0MfTaLKncyvY6g+RYSEsEzOvpjXEOAXiVnjahcJM2NqvtV766qIJaC+pUZsshUwTq3LQt+iXyNfqgvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CH0PR01MB6812.prod.exchangelabs.com (2603:10b6:610:111::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Mon, 23 Jan 2023 23:11:27 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::7d63:761b:d152:27e4]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::7d63:761b:d152:27e4%2]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 23:11:27 +0000
Date:   Mon, 23 Jan 2023 15:11:12 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ilkka@os.amperecomputing.com
Subject: Re: [PATCH] Partially revert "perf/arm-cmn: Optimise DTC counter
 accesses"
In-Reply-To: <b41bb4ed7283c3d8400ce5cf5e6ec94915e6750f.1674498637.git.robin.murphy@arm.com>
Message-ID: <6d4a6e3-eba9-a5a2-fc41-393d2b5d755@os.amperecomputing.com>
References: <b41bb4ed7283c3d8400ce5cf5e6ec94915e6750f.1674498637.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:610:e7::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CH0PR01MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1dd8da-ea9f-4d2f-c37a-08dafd97275b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbB3B10neXHzeWSsalgOI3nV7iyKcJ6xqiLdFBGzqqVQekHv1baWS8q4MX3GQxFhly2vrdmWcUIMeF7z9mNHTXu+h6JoyzdydPK0Hj6NByarH10VFHd06mpu/GGNo6SvOl+ghnfn8Wt1yhlKQOgUm5YQeR5Kd6rK7HAWHeDI766Dw+2PLndOjmiZr6oENBfk6PRd1FUSF1t3jxVFrGyXcV30kNDRsOqXOMPiMaHNpCn/OHZFsrQ94n3i9JNsFV1c7kiGySxIJfdQMRwTnQxOnUU8E+dM7DjQBOswKYUzvhyDgw7y9orqebI9S/CViEvZMsaovX7UgR7GzwBmITIAIwrnTTMckzpo5XwH8HPWZyGpzMjHplnS5SCd4YjCGDqOi4+rhHfwmk1u01NpBCXWPeRt0NslGndbK0c8CGbhSa6FpQvDgKXNdIN+fWoLm/w0YEIEs00Ys+FRjrkrIUsIN2dQrC/qewJK0sU+csud8Js182X/Yx6ARFvWz2iEOmfIjQSFMy0rSA6IgfKFazNNx8pYrKoM2TStAZRvH1agnOUqgc2HRxdu7B8WLcVwRMSDW/EuqbCsUc1sqXmJO5SXphg7ZwGTccDxNgK6N/V7GlWUlY4DBxkb01GSDsIL/bGUAKsM7AYo1j5vyrrkfkRz/co6MBm8zzz7ozR6R39w9XTbuMe26fQBjGdqOiH+JGmuuesis6sN/iZ0MPnln9XpbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39850400004)(346002)(136003)(396003)(366004)(451199015)(66476007)(83380400001)(66946007)(86362001)(66556008)(4326008)(6916009)(8676002)(316002)(6506007)(107886003)(6666004)(26005)(186003)(6512007)(52116002)(6486002)(478600001)(2616005)(8936002)(5660300002)(38350700002)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JVz7eowFOs9V0mxapX0YLJU1rVSV7STYRMBDNbD4RsTighAPigpeKS/HItuw?=
 =?us-ascii?Q?njhW5apDSLYm1g+bdhiPsx2aBDh69FlIPuipPVPryCZISNvoAd6oRSbavsuI?=
 =?us-ascii?Q?FQct/3jq61LC9Uu66vI7ZlebKt3DSM9q07go/Pl9OELK4BwdyUU88JfGKFCn?=
 =?us-ascii?Q?AuQJMKcLdBpCJC0oWjOBz3ozaC3dkFvi1xXvkCj2HIeV/l0FMU0wIltGrEV/?=
 =?us-ascii?Q?KXYIJKWCUW4A7arv6tJWXvGWT3YKCnDepA5aDwfWibKAHLMXb853PobRqINL?=
 =?us-ascii?Q?YjZCWID4x+EyszhuvL2X56e+ZbKi9fe6siYhKr2z/LHWkIYtbBlAtWY3nnge?=
 =?us-ascii?Q?rgRDuCeOVm5lUBt50FP1R3NcHrXTNhcezJfq/IjEQkCEThyYwx1u1hsBV+fn?=
 =?us-ascii?Q?srQqP7phnKfxQkvO1i+X2jyzjnyFaZLY8jiFtcF2Vjt6hHqrpCtRRs/RoI3m?=
 =?us-ascii?Q?UNOSvgf1qSLrJEPJCdFCfb8gYZw4jFxsnqhZLSW6ZIvgxZ3zGQf0xd0iErDm?=
 =?us-ascii?Q?HgXdcZg0A7qDiEFg0T9oFBxVarEUW9t90GCdVPnuX7vQG1OI4PVU4chKGLaW?=
 =?us-ascii?Q?GTxjvi9QaNXi8TCZ9yDGNuiwuwWJrb2sSEq5WTHU86pJgYSf8Zt7awL/fxyj?=
 =?us-ascii?Q?LmfydfsVqSWlQoW9HegeNhr7yMTCZat4E+IVfXedj9dEkiJ2RpnPWqJsiKdz?=
 =?us-ascii?Q?CexnKM+uQ3i4mUjsGCh6UkUZNapxFvKscJbcApju3KaJjOdjNR7RfqJUZJEP?=
 =?us-ascii?Q?k3WOVE2l0hTmsyHIoJuBZHhNd4kmU9S9I+xWw4eX/K8bSqthIdkFDxcphqTr?=
 =?us-ascii?Q?QXR7H87MHKdL8rBGRiIZOC5UEqkL3cG88s9pXFgNzksjGawBFsradVsNMlDQ?=
 =?us-ascii?Q?E+7gwbH5eDdTqXQnctIOb9gJrHDf8mZ4QEmeVH+glOi5KCnSgOSnbSfUNhKa?=
 =?us-ascii?Q?7+Jfp+GHO1y8TajoMh0StPJJh3Fo7VZGMysP3llfdHwKV4RiYHNDxFK3xbv7?=
 =?us-ascii?Q?ElILZQxJYkXBddqH2kqBXmkdhg9e+gOAy+KMuiqruStpkgkEdde1Uni6bdI0?=
 =?us-ascii?Q?nUHf15YrBiieBlQsWFJTRUN0gHELxRuUywHqDwXWfKYZQHgtfiDZMVI/E+sT?=
 =?us-ascii?Q?Ki3dR/+ZzwYnLKRDskqgPoLhR89lE2DRJy0/IuapYAexOKRfac0Vt0HWZckw?=
 =?us-ascii?Q?Jih2qpz6+MFXcAZFYPwZk2als9Bc9w77qdmmaiN4KM5uecZmmE7ptURoigZB?=
 =?us-ascii?Q?aT6ndij26NTnPscIlZ1dCaJZcsKxpJddRsN2cpEpnzwWYwaj7VlRvXE1gRuh?=
 =?us-ascii?Q?KlP2t50+jMAAfEKm7KySHyBiSVyaKqDTY7QDk0iPBOoy6g6IqfN48b1f+0HM?=
 =?us-ascii?Q?7cZNj0wWY69WcHdfphnemsczQRrnSbkTd6qzKI4thnQFAJQxj/13zPNAxbcV?=
 =?us-ascii?Q?N6u7Kd90zBIBr0wC3Tq3FBW27DjfcZ4y/7/q8vL2lAup0f1ZlybUypwHdJBF?=
 =?us-ascii?Q?VSo8j3pY/QTfuO5pucjI/24K5shjgPccZdWPNcTIpAFhE6SRWWLNqOSEQR38?=
 =?us-ascii?Q?V+QiLXVnVsiE1PmQ8DWl919G19n7JeNx+Bc4tpriFEFoL4CyLIvT2E5xPtT5?=
 =?us-ascii?Q?hvbHtIQiN/UvEkI+54Dw7vg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1dd8da-ea9f-4d2f-c37a-08dafd97275b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 23:11:26.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NW6NqPkf7yGo+X/QCvtAWATOpC2I5jLjbxqHV4btl2fUAuccIfptyNav4f7uc4hUEttNY0LE937gbwgOvq931JNQM3qVpqbU3RVpp+hEvltGwwzpuXL2/neevMOZIjLb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6812
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, 23 Jan 2023, Robin Murphy wrote:
> It turns out the optimisation implemented by commit 4f2c3872dde5 is
> totally broken, since all the places that consume hw->dtcs_used for
> events other than cycle count are still not expecting it to be sparsely
> populated, and fail to read all the relevant DTC counters correctly if
> so.
>
> If implemented correctly, the optimisation potentially saves up to 3
> register reads per event update, which is reasonably significant for
> events targeting a single node, but still not worth a massive amount of
> additional code complexity overall. Getting it right within the current
> design looks a fair bit more involved than it was ever intended to be,
> so let's just make a functional revert which restores the old behaviour
> while still backporting easily.
>
> Fixes: 4f2c3872dde5 ("perf/arm-cmn: Optimise DTC counter accesses")
> Reported-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks for the patch. It looks good to me and seems to work fine.

Cheers, Ilkka

> ---
> drivers/perf/arm-cmn.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index b80a9b74662b..1deb61b22bc7 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1576,7 +1576,6 @@ static int arm_cmn_event_init(struct perf_event *event)
> 			hw->dn++;
> 			continue;
> 		}
> -		hw->dtcs_used |= arm_cmn_node_to_xp(cmn, dn)->dtc;
> 		hw->num_dns++;
> 		if (bynodeid)
> 			break;
> @@ -1589,6 +1588,12 @@ static int arm_cmn_event_init(struct perf_event *event)
> 			nodeid, nid.x, nid.y, nid.port, nid.dev, type);
> 		return -EINVAL;
> 	}
> +	/*
> +	 * Keep assuming non-cycles events count in all DTC domains; turns out
> +	 * it's hard to make a worthwhile optimisation around this, short of
> +	 * going all-in with domain-local counter allocation as well.
> +	 */
> +	hw->dtcs_used = (1U << cmn->num_dtcs) - 1;
>
> 	return arm_cmn_validate_group(cmn, event);
> }
> -- 
> 2.36.1.dirty
>
>
