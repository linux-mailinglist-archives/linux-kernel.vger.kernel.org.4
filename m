Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631D572F7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbjFNIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjFNIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:24:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2105.outbound.protection.outlook.com [40.107.223.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE24129
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSk64drSbEyO0Dv6tXzQdEqIimiEABcC9k73k3/YQIxsYfMfaWzWmrTtV3vA9i55NspQHjjplkGwIeBaiouBAXpcqla/1aD+D/bpaROn/gOxXj63PYsLZGSbyVN1y5bONf4CYh9PaA8wVuHEgMC0pq+rB5NmIYz0xdJj3Vae25Xedqa3If8cpGGyDJTdJ9WMfVCI0Of70xSwViyHTB+nocE/iZKjM9vY9vSBkfApRqs7/2lWWiJv29GzR7AxQqnXGvpmajHwc29dg0WuqRW9Gzi/m56aWo5c79FYFwNiewqWY93+v7GA5XLPZ9blPt2ZDqKWDZuuJMywWH38jNzBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LnnECr4ZPiPsgUALQMqNsNkz0R68yxH/putbJV+Eh4=;
 b=UBejZU70Fm2LcSK1BlRUtmNTakLiyeWytMiueWYn2N8sKa4cwN7QjGnYv2m5MPo/P8JB5q5p87MrxfsvRlaIhKFpexvqP9lp+9eW8vTBMuWZsfnKc0er/8LMPl+cvmYdkL0BaptXjTRp8GWT1GuVW272TE49+ldIJLJ/bqX6HiQ8Zo4u9lSdETklOITKAFszkA+8T7DnR/NPJvI2t44Huhy9aE2YOcVvV4WJmRA6zPEQfYFackhM2S/E4bZFkG4MFD2BDaFpobe86PjpXg8KwtjCyruceqB430UfQNM7wu5rxFiT4up9+ApWNRBbXnsb6rwpi1cDSai1yeER+KaGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LnnECr4ZPiPsgUALQMqNsNkz0R68yxH/putbJV+Eh4=;
 b=bb4eB1TwMrUAwReKZIR83lXdC3eTVmSfOzLViChcqacyHikSPtNu+hqc2DuTeGxO1V1FvPtZ+pU0IFgVoXMcrGfWN6S3rypJ0Ya9uPXGcz5FfDYe+Caew+TmnouiDBvcgWvV4L7mUlsIzub89DmXGPrgvdU7olue/VXII/LmLz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA3PR01MB8524.prod.exchangelabs.com (2603:10b6:806:3a1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Wed, 14 Jun 2023 08:24:32 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%6]) with mapi id 15.20.6455.037; Wed, 14 Jun 2023
 08:24:32 +0000
Date:   Wed, 14 Jun 2023 01:24:15 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        ilkka@os.amperecomputing.com, john.g.garry@oracle.com,
        renyu.zj@linux.alibaba.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf/arm-cmn: Revamp model detection
In-Reply-To: <3c791eaae814b0126f9adbd5419bfb4a600dade7.1686588640.git.robin.murphy@arm.com>
Message-ID: <57b0e938-31e-dbea-e5cb-c31caab1c59f@os.amperecomputing.com>
References: <cover.1686588640.git.robin.murphy@arm.com> <3c791eaae814b0126f9adbd5419bfb4a600dade7.1686588640.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:b0::6) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA3PR01MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f89158-afdc-4a7c-b2ac-08db6cb0c75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SpC92eY+IWX/LDvIDUAalfD6NjUYopUTQJnX2w8vxXmzBzTQzeXqweMINfXOdE4EKgZjhQKPPw6vWAPeiU5kTli3N2Jb45al09PjRK3nkSjRMPyOrHr0efLBP0Jhm/JQNaI0+tm0LbnfuwBhjHGrsPOAgEfUZQ8mLt9+2dEX+WJPoj7XOBpfaFwvQ/XqKq7XnmlhkWXN9Pnc2T/ZxtZol+14d4tcZP4K9bugWXPjK8/9+RFczEuS+00v+zPwgBYB6F7kJkRA5oGw7frwoZar4RYbhIYYA7gu9d8XrQpqcIrd+5LI6Zi+XMZfFE8pYftdZRba2zUJu6B9DqbZZ64rbgSF67qQrM/vFoVRfnV3IRoG6/CsR8R1q9V2JE0hFQzcv1wek0p6jAgzjnP+RYZV+Y7m0MqA2mmE5eS4U02z5dlyqfZvczB3m88yZcb5QwiP+Yzr7NhKViec8HAXEs/aLAgXmmrm8ge4NJYdaknht6pt3oWNjTY6+FNUxsZcYZo+dNTrgZgem1Ec4OD09nDISSjO55SBPyX6c6misfyZgxeVsK56jsDi5R2cPY1Br2+g927jKLs8NF8NBsZ1pUVetROZGP9gOPWnsp3AQurXa73v5w3qU8+55Pg05gV4TZL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(83380400001)(5660300002)(186003)(6506007)(30864003)(2906002)(2616005)(41300700001)(6512007)(8936002)(52116002)(26005)(8676002)(6486002)(316002)(6666004)(478600001)(38350700002)(38100700002)(86362001)(4326008)(66476007)(66556008)(66946007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cv+k5GLr4T9eD8It+pKbPaIlK7PLbpWOSENOQ+YUsPPcvUw7q4HDnwfhPHa0?=
 =?us-ascii?Q?Sjma5vk6iXRckrOGu3U5WLFW6U4dFKst9G6eikMwB6hgumgcO+28kXF/wSQg?=
 =?us-ascii?Q?8Ht5U+fZOawwx/1c1oJB33XIfZ8Lh4PjjoYuSBycQPetDsXmeOugJASW8ouE?=
 =?us-ascii?Q?EsJmiVVE2FWAjjSS0h7b0rgyz1KgXX5GqsELZBt99+v1T7uQoR8wx54sm8lb?=
 =?us-ascii?Q?646khJMshE94wGrbULJMJAWtr9pN7vABaafFsy0PNWBmQMxbOFnboLLIhg+2?=
 =?us-ascii?Q?Ov4/yL1CTeXamCwF/rKH+8vyX0PSBh7Ip6DMzkCQ2s0v2gnGinMMg8N/gAOx?=
 =?us-ascii?Q?GIL7Y8ydMpOQuGFF726NezptA32jEpU1TSeiRDHJh6EsbAtR2Jf0kFzB76ZZ?=
 =?us-ascii?Q?r0PDfMkte3C0xspZZ9STZcrdGw9Nsyu/K5S3eXeFTmXYF0DVelWPZ4Ra+Vjx?=
 =?us-ascii?Q?QkbIZc8tyhpTBc5b1KC5k7eGbGsmCTMFZVtBl5i7rj6I91xRtUCoYPB8S5el?=
 =?us-ascii?Q?8iBubv0fBhH+1ABSKXGL/c1u1bj1gwDpqGsBEKJksajsSbda7vY7oiSeN7JV?=
 =?us-ascii?Q?5SKc4E46Ssvlnb4HhPkWB8KPBUpGaeIEEQENw8S40VHSSLLwvQpoXd2Xi6Jt?=
 =?us-ascii?Q?SKwyz2CgJp+jM1iJw58SjU8dewnx4THKEL2V0MQWFhWlntA/BplMX0ko64ks?=
 =?us-ascii?Q?HZsZEOTblJ8sLrJxZLpO4upqeukkLjXO3O9OHy1dh+vvzxG5OJyq+cw7PZwn?=
 =?us-ascii?Q?ZVuPhL1Rvk9W4dxuB8fKXwg+Hrr+Di8QtRvO2QkKZ9TbjQjGKCa5uiJrfBu8?=
 =?us-ascii?Q?S49yH467BXpx6J6RTATkkSOU+FbH7/CJmGXnXk3QLJhoiqHQoMfZxE6CtY6S?=
 =?us-ascii?Q?AuBErVbPfFF3Xxj1PFEEF3awNvOiyd5yrVQRRIhRzAsflE8fuPMRleVFbLAh?=
 =?us-ascii?Q?Cc7ISYPifU1V6nfZk2fWcArCIufZx3qKqC3lAB25xSN9Fi2i2g53Gln23mqW?=
 =?us-ascii?Q?m5NIs9VqFHxPO4oRELFxtAK1VyvbkMH/Wvn/6ObBtDceuNJ0xy0NE64QlFXy?=
 =?us-ascii?Q?flwmTHGAX0mDgcSNENihX3AMWNMKK1jktfIhcjVjhUQSAOgb2U947zBj1rEr?=
 =?us-ascii?Q?KA+T56209KbHEy19n4EUrudJDRvkI5LNibRMfbXrlGZSbIJaq+7DAF0ikZzJ?=
 =?us-ascii?Q?bEbJzNlayXy2fTQEFwBfNxZWm6fk3GB8nuYxSMv+xbWDwcYj6ZslEofjBja5?=
 =?us-ascii?Q?1KEymLf1m5lS5eUfKQVPcUrKJuy0pKl056nAv1A2GNxJMt62uGNy+AATjeUQ?=
 =?us-ascii?Q?T9Exb4f8eF7tGxKTUxnuPOe5PrY81mj6xk0uqlOBCHNaypSeD1HP3ADPuFBG?=
 =?us-ascii?Q?JpAga2mRc8bHrydtKW/HfD/zplg/bYrM0zdRwkbqAXppdc/6ZJ5esdT4TcxM?=
 =?us-ascii?Q?F9KqOuOl9QRGkdJ6i+v5HR9WvBicUH1eM8YSNlXhgfUMAlpiI47WJaPGuxpt?=
 =?us-ascii?Q?ult1BTyLUUMoYOR+bo6KseNC/H30nuoYXxu+v8PLFLm68IV8OEeMjRwcMyth?=
 =?us-ascii?Q?wjoaQtCbA8aiVIDNKBDilcWTPp9NKFO/X5DSObHzBPhz0gyUlcmenw4U97es?=
 =?us-ascii?Q?YcLJMpuPKMvmNTn3/u4a0RA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f89158-afdc-4a7c-b2ac-08db6cb0c75e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 08:24:31.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlGnCM9Pm4QgC35JUQB+nABNFagu4K57qtK3O42gtxF+X7EihvsRmpdLvqDIj2kqMF3HxMrYOgm1/SqvMl1MPXBsIh1BSI89U5RyaHNaivzJoPZH2z3l6SmOKn5KjOCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8524
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Jun 2023, Robin Murphy wrote:
> CMN implements a set of CoreSight-format peripheral ID registers which
> in principle we should be able to use to identify the hardware. However
> so far we have avoided trying to use the part number field since the
> TRMs have all described it as "configuration dependent". It turns out,
> though, that this is a quirk of the documentation generation process,
> and in fact the part number should always be a stable well-defined field
> which we can trust.
>
> To that end, revamp our model detection to rely less on ACPI/DT, and
> pave the way towards further using the hardware information as an
> identifier for userspace jevent metrics. This includes renaming the
> revision constants to maximise readability.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Hi Robin,

I quickly tested on two different SoCs and the patchset seemed to
work fine.


Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>



> ---
> drivers/perf/arm-cmn.c | 145 ++++++++++++++++++++++++++---------------
> 1 file changed, 93 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 51c703759d3d..8cf4ed932950 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -44,8 +44,11 @@
> #define CMN_MAX_DTMS			(CMN_MAX_XPS + (CMN_MAX_DIMENSION - 1) * 4)
>
> /* The CFG node has various info besides the discovery tree */
> -#define CMN_CFGM_PERIPH_ID_2		0x0010
> -#define CMN_CFGM_PID2_REVISION		GENMASK(7, 4)
> +#define CMN_CFGM_PERIPH_ID_01		0x0008
> +#define CMN_CFGM_PID0_PART_0		GENMASK_ULL(7, 0)
> +#define CMN_CFGM_PID1_PART_1		GENMASK_ULL(35, 32)
> +#define CMN_CFGM_PERIPH_ID_23		0x0010
> +#define CMN_CFGM_PID2_REVISION		GENMASK_ULL(7, 4)
>
> #define CMN_CFGM_INFO_GLOBAL		0x900
> #define CMN_INFO_MULTIPLE_DTM_EN	BIT_ULL(63)
> @@ -186,6 +189,7 @@
> #define CMN_WP_DOWN			2
>
>
> +/* Internal values for encoding event support */
> enum cmn_model {
> 	CMN600 = 1,
> 	CMN650 = 2,
> @@ -197,26 +201,34 @@ enum cmn_model {
> 	CMN_650ON = CMN650 | CMN700,
> };
>
> +/* Actual part numbers and revision IDs defined by the hardware */
> +enum cmn_part {
> +	PART_CMN600 = 0x434,
> +	PART_CMN650 = 0x436,
> +	PART_CMN700 = 0x43c,
> +	PART_CI700 = 0x43a,
> +};
> +
> /* CMN-600 r0px shouldn't exist in silicon, thankfully */
> enum cmn_revision {
> -	CMN600_R1P0,
> -	CMN600_R1P1,
> -	CMN600_R1P2,
> -	CMN600_R1P3,
> -	CMN600_R2P0,
> -	CMN600_R3P0,
> -	CMN600_R3P1,
> -	CMN650_R0P0 = 0,
> -	CMN650_R1P0,
> -	CMN650_R1P1,
> -	CMN650_R2P0,
> -	CMN650_R1P2,
> -	CMN700_R0P0 = 0,
> -	CMN700_R1P0,
> -	CMN700_R2P0,
> -	CI700_R0P0 = 0,
> -	CI700_R1P0,
> -	CI700_R2P0,
> +	REV_CMN600_R1P0,
> +	REV_CMN600_R1P1,
> +	REV_CMN600_R1P2,
> +	REV_CMN600_R1P3,
> +	REV_CMN600_R2P0,
> +	REV_CMN600_R3P0,
> +	REV_CMN600_R3P1,
> +	REV_CMN650_R0P0 = 0,
> +	REV_CMN650_R1P0,
> +	REV_CMN650_R1P1,
> +	REV_CMN650_R2P0,
> +	REV_CMN650_R1P2,
> +	REV_CMN700_R0P0 = 0,
> +	REV_CMN700_R1P0,
> +	REV_CMN700_R2P0,
> +	REV_CI700_R0P0 = 0,
> +	REV_CI700_R1P0,
> +	REV_CI700_R2P0,
> };
>
> enum cmn_node_type {
> @@ -306,7 +318,7 @@ struct arm_cmn {
> 	unsigned int state;
>
> 	enum cmn_revision rev;
> -	enum cmn_model model;
> +	enum cmn_part part;
> 	u8 mesh_x;
> 	u8 mesh_y;
> 	u16 num_xps;
> @@ -394,19 +406,35 @@ static struct arm_cmn_node *arm_cmn_node(const struct arm_cmn *cmn,
> 	return NULL;
> }
>
> +static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
> +{
> +	switch (cmn->part) {
> +	case PART_CMN600:
> +		return CMN600;
> +	case PART_CMN650:
> +		return CMN650;
> +	case PART_CMN700:
> +		return CMN700;
> +	case PART_CI700:
> +		return CI700;
> +	default:
> +		return 0;
> +	};
> +}
> +
> static u32 arm_cmn_device_connect_info(const struct arm_cmn *cmn,
> 				       const struct arm_cmn_node *xp, int port)
> {
> 	int offset = CMN_MXP__CONNECT_INFO(port);
>
> 	if (port >= 2) {
> -		if (cmn->model & (CMN600 | CMN650))
> +		if (cmn->part == PART_CMN600 || cmn->part == PART_CMN650)
> 			return 0;
> 		/*
> 		 * CI-700 may have extra ports, but still has the
> 		 * mesh_port_connect_info registers in the way.
> 		 */
> -		if (cmn->model == CI700)
> +		if (cmn->part == PART_CI700)
> 			offset += CI700_CONNECT_INFO_P2_5_OFFSET;
> 	}
>
> @@ -640,7 +668,7 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
>
> 	eattr = container_of(attr, typeof(*eattr), attr.attr);
>
> -	if (!(eattr->model & cmn->model))
> +	if (!(eattr->model & arm_cmn_model(cmn)))
> 		return 0;
>
> 	type = eattr->type;
> @@ -658,7 +686,7 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 		if ((intf & 4) && !(cmn->ports_used & BIT(intf & 3)))
> 			return 0;
>
> -		if (chan == 4 && cmn->model == CMN600)
> +		if (chan == 4 && cmn->part == PART_CMN600)
> 			return 0;
>
> 		if ((chan == 5 && cmn->rsp_vc_num < 2) ||
> @@ -669,19 +697,19 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 	}
>
> 	/* Revision-specific differences */
> -	if (cmn->model == CMN600) {
> -		if (cmn->rev < CMN600_R1P3) {
> +	if (cmn->part == PART_CMN600) {
> +		if (cmn->rev < REV_CMN600_R1P3) {
> 			if (type == CMN_TYPE_CXRA && eventid > 0x10)
> 				return 0;
> 		}
> -		if (cmn->rev < CMN600_R1P2) {
> +		if (cmn->rev < REV_CMN600_R1P2) {
> 			if (type == CMN_TYPE_HNF && eventid == 0x1b)
> 				return 0;
> 			if (type == CMN_TYPE_CXRA || type == CMN_TYPE_CXHA)
> 				return 0;
> 		}
> -	} else if (cmn->model == CMN650) {
> -		if (cmn->rev < CMN650_R2P0 || cmn->rev == CMN650_R1P2) {
> +	} else if (cmn->part == PART_CMN650) {
> +		if (cmn->rev < REV_CMN650_R2P0 || cmn->rev == REV_CMN650_R1P2) {
> 			if (type == CMN_TYPE_HNF && eventid > 0x22)
> 				return 0;
> 			if (type == CMN_TYPE_SBSX && eventid == 0x17)
> @@ -689,8 +717,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 			if (type == CMN_TYPE_RNI && eventid > 0x10)
> 				return 0;
> 		}
> -	} else if (cmn->model == CMN700) {
> -		if (cmn->rev < CMN700_R2P0) {
> +	} else if (cmn->part == PART_CMN700) {
> +		if (cmn->rev < REV_CMN700_R2P0) {
> 			if (type == CMN_TYPE_HNF && eventid > 0x2c)
> 				return 0;
> 			if (type == CMN_TYPE_CCHA && eventid > 0x74)
> @@ -698,7 +726,7 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 			if (type == CMN_TYPE_CCLA && eventid > 0x27)
> 				return 0;
> 		}
> -		if (cmn->rev < CMN700_R1P0) {
> +		if (cmn->rev < REV_CMN700_R1P0) {
> 			if (type == CMN_TYPE_HNF && eventid > 0x2b)
> 				return 0;
> 		}
> @@ -1200,7 +1228,7 @@ static u32 arm_cmn_wp_config(struct perf_event *event)
> 	u32 grp = CMN_EVENT_WP_GRP(event);
> 	u32 exc = CMN_EVENT_WP_EXCLUSIVE(event);
> 	u32 combine = CMN_EVENT_WP_COMBINE(event);
> -	bool is_cmn600 = to_cmn(event->pmu)->model == CMN600;
> +	bool is_cmn600 = to_cmn(event->pmu)->part == PART_CMN600;
>
> 	config = FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL, dev) |
> 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_CHN_SEL, chn) |
> @@ -1520,14 +1548,14 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
> 	return ret;
> }
>
> -static enum cmn_filter_select arm_cmn_filter_sel(enum cmn_model model,
> +static enum cmn_filter_select arm_cmn_filter_sel(const struct arm_cmn *cmn,
> 						 enum cmn_node_type type,
> 						 unsigned int eventid)
> {
> 	struct arm_cmn_event_attr *e;
> -	int i;
> +	enum cmn_model model = arm_cmn_model(cmn);
>
> -	for (i = 0; i < ARRAY_SIZE(arm_cmn_event_attrs) - 1; i++) {
> +	for (int i = 0; i < ARRAY_SIZE(arm_cmn_event_attrs) - 1; i++) {
> 		e = container_of(arm_cmn_event_attrs[i], typeof(*e), attr.attr);
> 		if (e->model & model && e->type == type && e->eventid == eventid)
> 			return e->fsel;
> @@ -1570,12 +1598,12 @@ static int arm_cmn_event_init(struct perf_event *event)
> 		/* ...but the DTM may depend on which port we're watching */
> 		if (cmn->multi_dtm)
> 			hw->dtm_offset = CMN_EVENT_WP_DEV_SEL(event) / 2;
> -	} else if (type == CMN_TYPE_XP && cmn->model == CMN700) {
> +	} else if (type == CMN_TYPE_XP && cmn->part == PART_CMN700) {
> 		hw->wide_sel = true;
> 	}
>
> 	/* This is sufficiently annoying to recalculate, so cache it */
> -	hw->filter_sel = arm_cmn_filter_sel(cmn->model, type, eventid);
> +	hw->filter_sel = arm_cmn_filter_sel(cmn, type, eventid);
>
> 	bynodeid = CMN_EVENT_BYNODEID(event);
> 	nodeid = CMN_EVENT_NODEID(event);
> @@ -2055,6 +2083,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	void __iomem *cfg_region;
> 	struct arm_cmn_node cfg, *dn;
> 	struct arm_cmn_dtm *dtm;
> +	enum cmn_part part;
> 	u16 child_count, child_poff;
> 	u32 xp_offset[CMN_MAX_XPS];
> 	u64 reg;
> @@ -2066,7 +2095,19 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 		return -ENODEV;
>
> 	cfg_region = cmn->base + rgn_offset;
> -	reg = readl_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_2);
> +
> +	reg = readq_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_01);
> +	part = FIELD_GET(CMN_CFGM_PID0_PART_0, reg);
> +	part |= FIELD_GET(CMN_CFGM_PID1_PART_1, reg) << 8;
> +	if (cmn->part && cmn->part != part)
> +		dev_warn(cmn->dev,
> +			 "Firmware binding mismatch: expected part number 0x%x, found 0x%x\n",
> +			 cmn->part, part);
> +	cmn->part = part;
> +	if (!arm_cmn_model(cmn))
> +		dev_warn(cmn->dev, "Unknown part number: 0x%x\n", part);
> +
> +	reg = readl_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_23);
> 	cmn->rev = FIELD_GET(CMN_CFGM_PID2_REVISION, reg);
>
> 	reg = readq_relaxed(cfg_region + CMN_CFGM_INFO_GLOBAL);
> @@ -2130,7 +2171,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 		if (xp->id == (1 << 3))
> 			cmn->mesh_x = xp->logid;
>
> -		if (cmn->model == CMN600)
> +		if (cmn->part == PART_CMN600)
> 			xp->dtc = 0xf;
> 		else
> 			xp->dtc = 1 << readl_relaxed(xp_region + CMN_DTM_UNIT_INFO);
> @@ -2251,7 +2292,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	if (cmn->num_xps == 1)
> 		dev_warn(cmn->dev, "1x1 config not fully supported, translate XP events manually\n");
>
> -	dev_dbg(cmn->dev, "model %d, periph_id_2 revision %d\n", cmn->model, cmn->rev);
> +	dev_dbg(cmn->dev, "periph_id part 0x%03x revision %d\n", cmn->part, cmn->rev);
> 	reg = cmn->ports_used;
> 	dev_dbg(cmn->dev, "mesh %dx%d, ID width %d, ports %6pbl%s\n",
> 		cmn->mesh_x, cmn->mesh_y, arm_cmn_xyidbits(cmn), &reg,
> @@ -2306,17 +2347,17 @@ static int arm_cmn_probe(struct platform_device *pdev)
> 		return -ENOMEM;
>
> 	cmn->dev = &pdev->dev;
> -	cmn->model = (unsigned long)device_get_match_data(cmn->dev);
> +	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
> 	platform_set_drvdata(pdev, cmn);
>
> -	if (cmn->model == CMN600 && has_acpi_companion(cmn->dev)) {
> +	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
> 		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
> 	} else {
> 		rootnode = 0;
> 		cmn->base = devm_platform_ioremap_resource(pdev, 0);
> 		if (IS_ERR(cmn->base))
> 			return PTR_ERR(cmn->base);
> -		if (cmn->model == CMN600)
> +		if (cmn->part == PART_CMN600)
> 			rootnode = arm_cmn600_of_probe(pdev->dev.of_node);
> 	}
> 	if (rootnode < 0)
> @@ -2404,10 +2445,10 @@ static int arm_cmn_remove(struct platform_device *pdev)
>
> #ifdef CONFIG_OF
> static const struct of_device_id arm_cmn_of_match[] = {
> -	{ .compatible = "arm,cmn-600", .data = (void *)CMN600 },
> -	{ .compatible = "arm,cmn-650", .data = (void *)CMN650 },
> -	{ .compatible = "arm,cmn-700", .data = (void *)CMN700 },
> -	{ .compatible = "arm,ci-700", .data = (void *)CI700 },
> +	{ .compatible = "arm,cmn-600", .data = (void *)PART_CMN600 },
> +	{ .compatible = "arm,cmn-650" },
> +	{ .compatible = "arm,cmn-700" },
> +	{ .compatible = "arm,ci-700" },
> 	{}
> };
> MODULE_DEVICE_TABLE(of, arm_cmn_of_match);
> @@ -2415,9 +2456,9 @@ MODULE_DEVICE_TABLE(of, arm_cmn_of_match);
>
> #ifdef CONFIG_ACPI
> static const struct acpi_device_id arm_cmn_acpi_match[] = {
> -	{ "ARMHC600", CMN600 },
> -	{ "ARMHC650", CMN650 },
> -	{ "ARMHC700", CMN700 },
> +	{ "ARMHC600", PART_CMN600 },
> +	{ "ARMHC650" },
> +	{ "ARMHC700" },
> 	{}
> };
> MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
