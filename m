Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64A6D5868
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjDDGFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjDDGFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:05:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2100.outbound.protection.outlook.com [40.107.93.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB40E2686
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjY+EiV4rRK1CT4vw2aBikm73A3Tsm7r+LFvJFoUllJQ/gUBpP0lqkfhZ+3Jg0sfKwQuzS7VwSQLm+c0Zbi13NalrgptHmAJnNabL2cru5iP53/UFeADhCLbDuKsvLvjl5NcTeN/f4pRHXIWStKeVJYwvvG5xmuvEthpLMlS76PRL4PUhR9Qg6kYAhMep2ba5CDW933jMelpLwLuABeaHNLd3QdmLkkRR8JEWzHew9F0xu4uMbhJEKSHvf/WIs2x073v4AKkvtPBbI3fHDkz7YHHU6XRHD3ZUmKDw+fw8eWq3XOxc4mc2tNXEMC3ohtRAKQLrxPat8qdUwjibUzejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t32NRh1bdyNZdvpTLd5UGcDmnm/bgAuaomPnSmiM/co=;
 b=JCWxiwNquncBVv5z4vl3coew+tGLpUXidh6MtXcu5/YDB6r4Xz4gMJzONPSKieMnO99DrqZciNZpteAAQm0HiXOeLYJl4bE/ZuPHvg39vCtzLexSb3juAUm9nuLfCcmZ4rezLxQiMHAQDGDfbhlbnVh2D6sBlTk7oTR7+vAGGXak7+h24FOR8tBEVYPomTrN+JDdJLx/H05jS+X/LR3g39BWfuf+/YGXMw/aNJ6D+wlhGDLOUERRoZoCZflGXcdH6dm9917HoxGH998YiuT5lXgayXGB2IcfHedgiGhIdyjHSJLybCk1zZfs4Vdk7U+MB9GA51dxdQurH2sHGJa2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t32NRh1bdyNZdvpTLd5UGcDmnm/bgAuaomPnSmiM/co=;
 b=o9FrC/WfvZJCtWj7L7vTpmtc1sCv5R60Aif8UyFNr1aKWGarqkjdSQusvr8couvOy6U1l7l0a1/RbLTukItHke0VvgaTNflXiePhvgFh+sVn5GTpaXdhqmTQikYmtCBxHTLBa8gzH37dP54cmD3AmLgLxmH3sshB+aH9kSamAFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH0PR01MB6472.prod.exchangelabs.com (2603:10b6:510:17::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.25; Tue, 4 Apr 2023 06:05:36 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4ac8:7982:7ee7:cdb2]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4ac8:7982:7ee7:cdb2%4]) with mapi id 15.20.6254.020; Tue, 4 Apr 2023
 06:05:35 +0000
Date:   Mon, 3 Apr 2023 23:05:17 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Validate cycles events fully
In-Reply-To: <3124e8c276a1f513c1a415dc839ca4181b3c8bc8.1680522545.git.robin.murphy@arm.com>
Message-ID: <1184027-2e39-2ed2-fa93-70c0a9d8e11@os.amperecomputing.com>
References: <3124e8c276a1f513c1a415dc839ca4181b3c8bc8.1680522545.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:610:74::27) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH0PR01MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c18895b-812a-44b0-0cea-08db34d29b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Psn2DdCCTtq8TFg71H+hFIhQnFL1YHxuCLmUIrl+ZB6i7CtuLWxgUt9cIt27CAxBzpN8OE9SGU0Av4CRX3A9Gma8Co/U6TbExMohqlXrd30zBhjn6qzqNb8gmCSok95s2AgeMWAHU1f5mKo9f7CSdv7ltP2Ly5M+AERtF2t1FkMcEuEaCGCMykWn6Of6vuhWuGWjDcwiUIo0Mus8DzVGO8NYBn0WSyNB/Cw0y4XXoDX2fnpNGmjcF38nJmG2Ccv4GT5tbXUHbBf1wUMl8OF85nx+OwxTSoEE3je934IL9knedSuFd5lzyUnCWszXmmWLgt74g0QTCzM+O2iSyuorI7HDGnyxqPq5bwdolJdXfeMRJTYsA8V0KESNDfPdTH9XyztPkFvjv/XzvbSqpvTT/o4pU2QFGrGZt1B4RtdwWxbjaGDm7pgO2q6EZnWX8I7m2oOxRKRWXN0QY7Ip+wwW1xbXX/VGQZ1tpRkRh1BL6Ta+E4jl9OHz52M92vlJZ1h9xETbqDl0AkKmGMhSwA6wBKYtf0AAUaKjCm6Rjz9/rFYUPSwqsXQ/gx6boUgu8BEOZga5z30tx00LiZbBMNQulRB4Yx6fuJL5ep3CQVYRS/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39850400004)(451199021)(6512007)(8936002)(26005)(6506007)(966005)(186003)(8676002)(83380400001)(2616005)(5660300002)(4326008)(41300700001)(2906002)(52116002)(66476007)(6916009)(6486002)(66946007)(66556008)(15650500001)(478600001)(6666004)(316002)(38100700002)(86362001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sinHxvXI3FD7b4pJuPfhy9k0nWCb7h3sSyhJMyircJ+Ps+U6eycQ6OnKpAhi?=
 =?us-ascii?Q?rGkfgk3logva4e+WVHXBsdpf1+iPqfBCGKTOCjXJM8ZIUOgJ28uP9rwyd36E?=
 =?us-ascii?Q?bHYtTh+cz7NCglVseBpj66yaIQqG1JDY4f7aKp22RfcAiokFNTl72Td7/9X5?=
 =?us-ascii?Q?C3JTCoY+vvvcasSpiyiMvrmUOAj/cSfFP9k5J3OIVxlUjHgISNOan6n+NwUV?=
 =?us-ascii?Q?sTEOgwcmtfZr8sJoMYR8nDAAOqNtuvM0aglpcLqsAw+APIoC2cnmMc1f4fJH?=
 =?us-ascii?Q?hxb4DXKre5p0NHFrrPRgEWZZM+DumVJpaLbVVTmKmhnYexP9QMCkrj3Y7rfJ?=
 =?us-ascii?Q?/tB2GK0jVmxiLf8L2XG1h++4fmQL6NqgzTqmYKlEGOA0J2tNZBGJ8hGxGRhQ?=
 =?us-ascii?Q?U50LNVlzuCbTwYLg/3OHN1uYzVszrwsIDdvDacR4iZfMRBEyFvy+zxjhMw7m?=
 =?us-ascii?Q?LYPC1J/DbFr14RfDgP1tcrG88hGI/PQbcrFW/RKlh6d2FmYqtniRMu96edw3?=
 =?us-ascii?Q?IrWemE0JXVM9A+JISJhBsBDtgGriCjXHXFgS9kztZgI2mX5hDziTKMGNlQWt?=
 =?us-ascii?Q?IBFkgBLTjuHGIVlzJJxArT8WPy/w7Up2/gBdsgcdkyI5ZT2Wo9qEZl4IHdMe?=
 =?us-ascii?Q?hNR+iNZVr7AVuxNwFUYaT/WyerpSItFOSnOxqcrZipbiAciz/ydct/RTwQHh?=
 =?us-ascii?Q?64wHxj4gqXdlMPPhieamYEcToOax1ITHad0ozRe9UN6Ogec+ylYcAjot8Ks4?=
 =?us-ascii?Q?sBwkkYN6T0o9pmRdWK2zhGCjTMupr2xT96jwClEjo3dOQJzVqkaguRiLI8Lc?=
 =?us-ascii?Q?H5TTSc3hyCPIJKki17mPk9d9L9imKHH+Q/EIl7tD3GkhF49UE7JsAAgMVuMo?=
 =?us-ascii?Q?plhP4jPeEr+7IIuaL/7cXSQ8fzBgQGwCVyjIryak/JPX7iU335lh9Rnvz03v?=
 =?us-ascii?Q?U4+TZ0V+YmLx8QRTmLmG3OrRhZh90nwNDT6Ot02G9okgIABGaEvk5q8+p8QC?=
 =?us-ascii?Q?4sFcdfmot/4jXn/HHqUZAJDRB7VK2X2zerA1Z9E6fKNYI3pyRZaVaVqsi/UV?=
 =?us-ascii?Q?nlGSEUZqlJVI96KH1dkUH4ptH1ZufBcOe3ePaw2VD2BlbQhcqApwso5rJs8j?=
 =?us-ascii?Q?VBiXv41ZOm4juNqbTyDs5s8KxRo6jhJOldTBVPL1pJIRBmSg4XFy3xwzoKCR?=
 =?us-ascii?Q?KEnTKhr7YdCSjCYEVT/1mZ0+vf4kqGH9L1YLfMt4huc2KaOJ0LFhXnw/6rw+?=
 =?us-ascii?Q?1UTEPa8aa1YqoCppv4KUb8F4H+3CBom9Iaoj4M02kIGTaqEHHyBrmXPgD+Ss?=
 =?us-ascii?Q?iHAWAcy66H1q8PDLrKAP4mMgAgKPfgRHZxbGn4cS0CM+n5gXFGJe9OyzHFbn?=
 =?us-ascii?Q?FNb+AE9zg3FNAi9/dgEqhiP3joqlNDQp3w9ZErQNOU+r2VjiiwKdN7P/Wh2Q?=
 =?us-ascii?Q?b4+1yr+QBJB++jJw+tCEKpqkWXH9k2/gMGhmwwDvpz3P/RTBDhkNzY1PpUsS?=
 =?us-ascii?Q?WcVCgINoQy6RicOUrgQUF5M/8O41v8ASqb0d+CLMQztvb1VLZaeoGXL7j5Ei?=
 =?us-ascii?Q?IjNR9D1uY8fCpYemzT0rlwgMjHg5h1k6u9twxZz2uPkxAhZvtRa1FYbEYaLQ?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c18895b-812a-44b0-0cea-08db34d29b2a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 06:05:35.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/L2Zo/k6C+fdhZQ5cXLpYQkuI3cZs54MADaF5Fb7RXZXsxLDJvrhEHVSXdQXvM2Vz7WyDPHAfZ7rmui2OTiXHFoW5qGWF1BXJc/2M2Q4BHg3wJ/0kVmWW7PiPmLH8NJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6472
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Apr 2023, Robin Murphy wrote:
> DTC cycle count events don't have anything to validate or initialise in
> themselves, but we should not forget to still validate their whole group
> context. Otherwise, we may fail to correctly reject a contrived group
> containing an impossible number of cycles events.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good to me and works as expected.

Cheers, Ilkka

> ---
> drivers/perf/arm-cmn.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 367d41c5d983..45819528facb 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1558,7 +1558,7 @@ static int arm_cmn_event_init(struct perf_event *event)
> 	type = CMN_EVENT_TYPE(event);
> 	/* DTC events (i.e. cycles) already have everything they need */
> 	if (type == CMN_TYPE_DTC)
> -		return 0;
> +		return arm_cmn_validate_group(cmn, event);
>
> 	eventid = CMN_EVENT_EVENTID(event);
> 	/* For watchpoints we need the actual XP node here */
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
