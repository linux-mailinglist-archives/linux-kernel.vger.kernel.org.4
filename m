Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69F6FE16D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbjEJPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbjEJPSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:18:33 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D525A2119
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gaSJNLrlAUsRDKyRF+NN8gEa62rpZqfsC3JIIjof5k=;
 b=9cZ5RXrEoHZsTGx1T2/vlZma1U/JT5fqOg/MtDpTwKqsXTHxcSxmBUmaGI5MSp6Sap5aoth3FY4vfsW4pKbn3NvZrJHVt8Ywr5IfQioL77pb1w4Lo1zyfp3sNL6UYxid7/gVh9luLwgUUEwFcE5OijOYib7z6S/VBKX9eby1c2Q=
Received: from AS8PR04CA0185.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::10)
 by PR3PR08MB5707.eurprd08.prod.outlook.com (2603:10a6:102:8b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 15:18:22 +0000
Received: from AM7EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f3:cafe::df) by AS8PR04CA0185.outlook.office365.com
 (2603:10a6:20b:2f3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19 via Frontend
 Transport; Wed, 10 May 2023 15:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT044.mail.protection.outlook.com (100.127.140.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 15:18:22 +0000
Received: ("Tessian outbound 5154e9d36775:v136"); Wed, 10 May 2023 15:18:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: afe4bebc000c05f2
X-CR-MTA-TID: 64aa7808
Received: from f84fdb1e2bb4.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 691700CB-FA69-4183-8D61-760D760E3C5F.1;
        Wed, 10 May 2023 15:18:15 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f84fdb1e2bb4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 10 May 2023 15:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VatG9XiXVDp4Ez3gCKOWbtWDpAvC+Dn+VSleqA2y53Uu++iKypYsBRkVlM5oD7hNE6f5kreUvnJpONcghaWs28JOHKI4SES45F/oVauxnNgzVy44/ic/2rAfC1sl3LHL7U+9AvYvBMVlEa2B+Iqj4ngRNcD/yiA+R56qPj0Sj3Ue3w66+EdcV+RxHF197MPLT8qAihePQ2tmG7LfphfQ5pTAhy93OO3bfZcw1JwsrP+34Atw/hfaCUvwIL3UzDvJRYH+k8aV1LxnMaYbSvotPXzakjjfE5gyYt4o8MaM6EQ5XJKwTVaPxObvHDVIcHNM+0GprWHyT3b2n8zamghl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gaSJNLrlAUsRDKyRF+NN8gEa62rpZqfsC3JIIjof5k=;
 b=TJKmzlT0Kcj5AR2ApmqBN3wPg6TNQfDkg03rG0tnqaEF9nm7IxRLy6vmTPzBtDnPURsFZ2rIuNDSsGrl+rqGYhh+n6kGP49uWrTEZfM5U2QAZdBJML5KbZm2shL1Y6+aOAUJrOd0pUkABT9y8A4FIQQBcNHZN+Fxy49R5/ORw+v9Ef+X36g267y5ToxaPRVv6dLlqWfdBga2eyODzv4pkkeuCB82LCHHXtj3LP1GfSCUZfUPyp892LcYjXEqHrzzctjDktZe0HdTSN0Pa6RCuCstKi/vIihJYL5aSZZVN6XBkfiyA0li0HtvZXtneMvJMvR/uj9OE8Pvo+iplDLfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gaSJNLrlAUsRDKyRF+NN8gEa62rpZqfsC3JIIjof5k=;
 b=9cZ5RXrEoHZsTGx1T2/vlZma1U/JT5fqOg/MtDpTwKqsXTHxcSxmBUmaGI5MSp6Sap5aoth3FY4vfsW4pKbn3NvZrJHVt8Ywr5IfQioL77pb1w4Lo1zyfp3sNL6UYxid7/gVh9luLwgUUEwFcE5OijOYib7z6S/VBKX9eby1c2Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB8563.eurprd08.prod.outlook.com (2603:10a6:10:404::17)
 by DU2PR08MB10277.eurprd08.prod.outlook.com (2603:10a6:10:49b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 15:18:13 +0000
Received: from DU0PR08MB8563.eurprd08.prod.outlook.com
 ([fe80::4793:c06d:4c39:2176]) by DU0PR08MB8563.eurprd08.prod.outlook.com
 ([fe80::4793:c06d:4c39:2176%5]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 15:18:13 +0000
Date:   Wed, 10 May 2023 16:18:10 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Mihail Atanassov <mihail.atanassov@arm.com>, nd@arm.com
Subject: Re: [PATCH v2] MAINTAINERS: Cleanup Arm Display IP maintainers
Message-ID: <20230510151810.vzmwtrsmw6542ynd@000377403353-vm>
References: <20230510121618.1871790-1-liviu.dudau@arm.com>
 <20230510122811.1872358-1-liviu.dudau@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510122811.1872358-1-liviu.dudau@arm.com>
X-ClientProxiedBy: LO4P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::14) To DU0PR08MB8563.eurprd08.prod.outlook.com
 (2603:10a6:10:404::17)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU0PR08MB8563:EE_|DU2PR08MB10277:EE_|AM7EUR03FT044:EE_|PR3PR08MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a685cb-8f05-4155-10cd-08db5169caef
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KGZCZUaUecOpw8LrB1P08t5IDF2mTb/Yd/aT064TPd2fCSYWIb3uXrd/lQ0y39+Qax/JjA/2I7/1+qoMSVwCB7SfUjpwddlU6s0qGKJYU6MDSp681uxX4MWNLJrAoI8Xt5dVByaFUJw3Ove/RR/kEWh8CGD0EnrUHTc3YfHWSgi+jHPmunomOb4atyek+RfadQ7JXAxAz3R+ZT/GWzr3cWbLyCtH3IuIldAuzYInNOqHYcLq9i7Bd0h0A4KOSztIep8UCyI+YqLYZQ4ZMU2G4BtXZCmEmvlLUgWdQK+ZZpe0FZ+Ufnr1+Y40pMOCJoPZtyxr/MABhIFRxz+aLo57WSpkw8j4La58mzHX16kGuCzGhS7ETubgkaY5XLTbk7CaNmEYRDsz7sIccJxyE16laHcM7xrt0/4qV+twsed/cJbvVtqgqlGoSs3PmFtXTPtgnbj24tzB7tRCCFJeNj4iHk1rAn6SKpLcwxQheRz5ftVjcxTLY/xNIAKKuaJ5RAHwFEGbSOSt0Nb455i70f+PpnrOa898T7iRje48k+HR+OruOr3N5hC3HbZRBBCzZaaB
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8563.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(6512007)(6506007)(1076003)(41300700001)(26005)(9686003)(38100700002)(6862004)(8676002)(5660300002)(8936002)(66946007)(83380400001)(54906003)(6636002)(66476007)(33716001)(66556008)(4326008)(316002)(86362001)(186003)(44832011)(478600001)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10277
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 07af2e55-8103-42bc-25f4-08db5169c51e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qp2z+EQDk5YYKZOhkZasKacVT8Qt1gEPOb5UbyUdvYoGoroUke9bOJwgqErLx55O4ZsYuk+vGVdKG2PpYHXWN1S/dvQXPNQztAoDNeNB4Cpcxqxim/AuTH/bLJ4ZCA8yEtxwrkK/DtWSoyJNyrQ8VVSITpYuhcFKYDfmeDUkrFd7rDIACnXa6vynX0IMZvhh7cE6QJFwmyiVdKtYeYiv8f9+xnDsOImWYceBSAQTMckHV+jnr7BQUxJwiZ4Prg+w5kYFF/O8p/etQ8sBOwH6lw45Wq930NX+TE0djKwD+9SlZQKvQZhmIfQZKIlbpaumf4oVcWTRPKgrQhzrEQCLN4p6wEsrfwnJ1U4N+NiHYLv/qNORYcHeQ71Ik3lUl31snY/OWR8dFLJA9XDpeHPH9DVM+IDsoBE2nXOqnHTY43dpHufqeTrLQNWJVAIDaRyHwStml+fFlppUh1W9kEqzEfK9hEVHaPA+u4Grk8WqcorTbTx3TzUdEPHVZLUd7y0adMDBCq8bLHnvYG66tmoVetUPGqVKbU1Fq+ksM7/N+nLTx6koj/5/mg4QrAqAPuxyD84545xO+8NA+apNnEmHfFKthvtQPg1QX8fkaCGuV1Mctesz7BqhVfFSxPtf20f8lecAR/MRriDfmxdsYp6lfSYRwfKlYQUD1kAeP2ck1AZl4NIhpWw7Lh3Zx1Gb52dg4aZmIVpx9FTO1P2pEBovMQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(478600001)(6636002)(4326008)(44832011)(70586007)(8676002)(6862004)(5660300002)(8936002)(1076003)(26005)(6506007)(6512007)(316002)(6486002)(41300700001)(54906003)(9686003)(2906002)(40480700001)(83380400001)(336012)(186003)(40460700003)(36860700001)(356005)(82740400003)(81166007)(47076005)(33716001)(82310400005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 15:18:22.0513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a685cb-8f05-4155-10cd-08db5169caef
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5707
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Liviu,

Acked-by: Brian Starkey <brian.starkey@arm.com>

On Wed, May 10, 2023 at 01:28:11PM +0100, Liviu Dudau wrote:
> Some people have moved to different roles and are no longer involved
> in the upstream development. As there is only one person left,
> remove the mailing list as well as it serves no purpose.
> 
> Cc: Brian Starkey <brian.starkey@arm.com>
> Cc: Mihail Atanassov <mihail.atanassov@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
> 
> Appologies to Mihail, looks like I have forgot how to spell his name.
> 
>  MAINTAINERS | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 276298cfc7ee4..7d5184550a11e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1660,10 +1660,7 @@ F:	drivers/power/reset/arm-versatile-reboot.c
>  F:	drivers/soc/versatile/
>  
>  ARM KOMEDA DRM-KMS DRIVER
> -M:	James (Qian) Wang <james.qian.wang@arm.com>
>  M:	Liviu Dudau <liviu.dudau@arm.com>
> -M:	Mihail Atanassov <mihail.atanassov@arm.com>
> -L:	Mali DP Maintainers <malidp@foss.arm.com>
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/arm,komeda.yaml
> @@ -1684,8 +1681,6 @@ F:	include/uapi/drm/panfrost_drm.h
>  
>  ARM MALI-DP DRM DRIVER
>  M:	Liviu Dudau <liviu.dudau@arm.com>
> -M:	Brian Starkey <brian.starkey@arm.com>
> -L:	Mali DP Maintainers <malidp@foss.arm.com>
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/arm,malidp.yaml
> -- 
> 2.40.1
> 
