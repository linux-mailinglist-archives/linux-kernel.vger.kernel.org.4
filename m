Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B45EACA6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIZQfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIZQeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:34:44 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10076.outbound.protection.outlook.com [40.107.1.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B8E12477E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:23:11 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=PEkV8dpTlhDRuoeEavgc9VMtB21M3ETtml5kgculDl9fr+S+ZYEsuLL7x3hkCjr5Q7Whu6WcDaSbm6TTefsFCeWUmWEvRTdV3ixubyMmj8VnkruCoF+X+XHF2YrgjcfYFKb5MBXltpt2IsdCPT4RhIQ5cr5bikbV6saSuAsvXYn9fsVXNqO93AC2Fzc5vhp4VmcHnzW5aNUQ2c+j301ZiDJi4pXOTobnzXkcs83E5aY8Yv14nq3mFyVuHf/LnK0HrBrCZLpaYdEx3yDHlSyTrVHTk4v96x9Tt1/s6LTXby10tXszolWNO60mimZDyYGrzppRF+p+JkUsKkhZ/lUW2g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJipSpId6qD6J7NQViFbW/DWH/mY1gK+kBqlRzCr+UU=;
 b=FPkgGMlhC4ueRO4c3OsrpwNRe6jWeHR7GhQTxEEZagGg9sfaqqO0wY4p3OrRmXWG6IIatxY8pq8RFjBenC9lshNjroCexns/f50/W6JIsJDmR5IVTcStLCoylngKLRIk1W6Pv/VBnbYHUEcDvHe3CxijojNJCXqzOcPoZPzgsbhBcGZJC06zqqlKR/dIqXbrSQKmr1AusatyHS0V5XNjLp0JStcsw3cJf2i33n4frM91pXYr9hLAxlSEdl/LjPgeOaJZ2mzp2T6v2XlOk4PqEq/dzYRnD04mfmylXZ91ojMRpc89WZnEJQYF2U/Xfe8wfSa+QuNAq5Yp0WzSNHyHCA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJipSpId6qD6J7NQViFbW/DWH/mY1gK+kBqlRzCr+UU=;
 b=Uvclu5tL5LX0QjN63d7QYcQ5r+iR1Nu+AzsjNZg7SpfteeCJkkiZrBXdPY0b4HMYnZr8Src+jXPGxQCxPEu0o6yaOMvKA9phlf3KmQ0RoVxqCcMwBDocC5DXiysdI9/utHic3u6AjZIXLQFpkxpcmcEVbkFBZTN4iHQHZLU7CMQ=
Received: from AM6PR01CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::45) by PAWPR08MB9053.eurprd08.prod.outlook.com
 (2603:10a6:102:341::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 15:21:33 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::52) by AM6PR01CA0068.outlook.office365.com
 (2603:10a6:20b:e0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 15:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 15:21:33 +0000
Received: ("Tessian outbound 9236804a5e9b:v124"); Mon, 26 Sep 2022 15:21:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0cf3769401a44136
X-CR-MTA-TID: 64aa7808
Received: from f74eec0cba87.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 81BE53C7-F90A-497F-9464-C856BAE6B8C4.1;
        Mon, 26 Sep 2022 15:21:25 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f74eec0cba87.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 26 Sep 2022 15:21:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nulgPK/n2SfBlSpazq0AbDKx0u87NZviYeE++UQfboEoGd7E3W6D9Ch4jpA6bae3Adkany44MBKBzUwA31reiv1db6+1kb60zjIrnBJzrheg17KxgfA99UfE97vYtIDMzHRxWvANIACDtSy3x1os03AhQF/vnQShWrVU85jgB5XCZEVfED7ueREpwnXuHZnEsdrw9OJwtAd4sSiIvnzFUCOSqABl9mwCEZetHZMbGR1Wezf4ZmEzkdHqK+83XWjsbT3mYZAU5+xZQFNxDSsE2ozJuh0I3m06QTc8EkVF6qJ+87gkWGgWpCDQ9bvMwJa6kyL4gnoTnlll90/jsmWWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJipSpId6qD6J7NQViFbW/DWH/mY1gK+kBqlRzCr+UU=;
 b=Heb2Wc6IGkutUazbQ6y5F4ElpJqfhxhQEVdvJPo5qOglo3xn76M2/LUixNLZqg/EpE42+ELmtAIwtGiqeRLYTaxl5YH8niX1XOO1h5gBqMaynoJDISujXFbMGrQ2K/qrecp/RqfZyFRY3imc64+X0HSvir3PVg82DFhq4B5KmMZtlBwFwqq3wqYz9ntJgc/eMzLFMMuXL5KFUu1gkVVLMWRSk8HtCzwKmkw1GkahWEtbNN1IXWucG8wG7+Qv/SzOvjsORRl9QaBxkjFx7eWtfspL4gGej6ukWWSRQ+MN6LAmojaLSr9zxiZBT+yoqXENHuuy4vxEIstozuFm/ARDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJipSpId6qD6J7NQViFbW/DWH/mY1gK+kBqlRzCr+UU=;
 b=Uvclu5tL5LX0QjN63d7QYcQ5r+iR1Nu+AzsjNZg7SpfteeCJkkiZrBXdPY0b4HMYnZr8Src+jXPGxQCxPEu0o6yaOMvKA9phlf3KmQ0RoVxqCcMwBDocC5DXiysdI9/utHic3u6AjZIXLQFpkxpcmcEVbkFBZTN4iHQHZLU7CMQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com (2603:10a6:10:2a2::15)
 by AS8PR08MB9648.eurprd08.prod.outlook.com (2603:10a6:20b:617::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:21:23 +0000
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::a677:eaef:48c4:9e11]) by DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::a677:eaef:48c4:9e11%2]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 15:21:22 +0000
Date:   Mon, 26 Sep 2022 16:21:19 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     ville.syrjala@linux.intel.com, butterflyhuangxx@gmail.com,
        tzimmermann@suse.de, jonas@kwiboo.se, airlied@linux.ie,
        linux-kernel@vger.kernel.org,
        George Kennedy <george.kennedy@oracle.com>,
        dri-devel@lists.freedesktop.org, ben.davis@arm.com, nd@arm.com
Subject: Re: [PATCH] drm/fourcc: Fix vsub/hsub for Q410 and Q401
Message-ID: <20220926152119.aycl2thery6dtwyo@000377403353>
References: <YyA9Y+Cs8ZCYHXAT@intel.com>
 <20220913144306.17279-1-brian.starkey@arm.com>
 <YyCjmQUZGKP6e8H1@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyCjmQUZGKP6e8H1@e110455-lin.cambridge.arm.com>
X-ClientProxiedBy: LO4P123CA0400.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::9) To DB9PR08MB6812.eurprd08.prod.outlook.com
 (2603:10a6:10:2a2::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB6812:EE_|AS8PR08MB9648:EE_|VE1EUR03FT055:EE_|PAWPR08MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 205bc58b-053c-40c7-9815-08da9fd2cba3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: v4URS2sdYqtvcaRXgpndcFboYE3OuMsl3VaspXEN02a89p5pf/b+dWpz0SWcxBUh6ECsvtogu7gXgHp/nUoNPC7gagzr5CgF11lICEetB4T0kb5r5ySzYuxyX3dMQybTDL0ngcfsXTFmicxxAFpf3GPM5X+QUgSyFgA3sQAJTIFqxGF3Fy9l2ZrsIi2e8Dv5r2cB/0xSE7FgqVMfQ1I5FUgsv2R8IlGFWQQo/QvdiQcsU7SKgFlMFH5Y6ODawPfM4kFh459opo8JR5YDiubvfmI9N+MDwPgaVQ2pPpekLqe8CVo1XNJ71XCheS8oBElBgFouR1sgz9V8LFM8efEoenkzpBcc9z8p0jTkUXitnkiwqFby5wcVR9q/9+xlq4XyrJoslsDNAuy3XfvQO1KLrqhmXHzNN06H798PbDCGnPf7NMi1Y1lPeJeLPQyeKmrkjkprYSiItANFKHlBdXgOiw9r15TUUa+0k47eUvmmQj2uQExx7x4m0gqKbGXn7beFJE/ciV3F6muJ02XOq8ZtAGbRSXRHYXTiBzpW/d0FkOEsjBFfk3cW2nXAeO2meqgPGCu4MQUR7PL4n6wYGLa6SZ/tKdXwQTFeMZBb7KOIqKHPrD3NtL7N3mttJFGtSkSS1+Jz72HmwJM9G2e5i2uSP6gzJuJiniAj7tWAvtQLITDo6XRmGvs0P4Nn9uJos0tqpkhVq8q5cTR+bLRhGjN1dKeGixWEXLc1phucVJLyW5276wGlC8yym1LiFY//BpbZ
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6812.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(366004)(346002)(396003)(39850400004)(136003)(451199015)(478600001)(6636002)(966005)(6486002)(316002)(66476007)(186003)(1076003)(2906002)(4326008)(6666004)(38100700002)(33716001)(66556008)(66946007)(8676002)(41300700001)(26005)(44832011)(6512007)(5660300002)(86362001)(9686003)(83380400001)(6506007)(8936002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9648
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e6ac526-62ee-4d9e-a6f7-08da9fd2c530
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8ZjIrEqssjZ0xc7gk0niSJC5I5XTL++vmlljjYgadlxe2xeutdunYp70H0xBxEhw3w6m35uLQumaqErcykSTdUMINrAZYZHa4k17s8rkKXMlS7/5OlYM0DApj4GpSrMZreJw9w4tyikN4cPSPpyARPiwTI6hI8vd7i6FA85cArBaGQHhuilGMNMReHn2qE8a7Fz8V/qOq2hNCXhm4Xco5X7N8jKTfdsgOvyd+tV/CRdylBViH0n2BXEx1ZoEKOr9KYrgF90CVDfmFoEJapVvNT/M0pJC0IYr/LYMZq+jWWo+10fj9SZRDSaKPDwGMkP08UZwL/mp+TLFIABjJTVIApkKJ0THtmd/oCqMl/WYxBV19vySgjLXw6i50yXA7K9ED056ZG5JVMZ8Ie8RMGAmokmdxMVG1R50hCTHohGBdIZABG1wXj9mumIbGpVT+scJ2Jn4g3eCpcjEfO9hnhPQxvvn7qpF3Q3yGGQ8uk8nHmWT29kfsbivqbtILPTzztGbuaKggBSvuKPmSkGV2OtDfdZhilSum2F/U36xxYG7fWhxh9ntTBP3sbhAS8UgURnbfdMJUZyBvOmQB8hT4nuetvAtyBVceQQ4yprCJcOwJkEhenLet1Vz9HzkhUzPC3mu9KGZIx4vS6XrPnpwfkzn1cuAPSplhtVQwkGYWgrF6Z8YUOXFhtCZb+twEFLLRD5n7BAYVla827h4eV6QXs8y0cia/n6vvrv/UMDBapcXca2Vd5bexnfDuNQ4qFFu9CPz6KMVacQ/KaKdh2v4dnbYCc6bRZdR0t7oL/mOgV72Yk=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(966005)(478600001)(6486002)(8936002)(83380400001)(36860700001)(47076005)(356005)(186003)(82740400003)(1076003)(336012)(86362001)(81166007)(6666004)(6512007)(6506007)(40460700003)(26005)(6636002)(316002)(9686003)(40480700001)(4326008)(8676002)(44832011)(70206006)(70586007)(41300700001)(6862004)(2906002)(33716001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:21:33.3697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205bc58b-053c-40c7-9815-08da9fd2cba3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9053
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 04:36:57PM +0100, Liviu Dudau wrote:
> On Tue, Sep 13, 2022 at 03:43:06PM +0100, Brian Starkey wrote:
> > These formats are not subsampled, but that means hsub and vsub should be
> > 1, not 0.
> > 
> > Fixes: 94b292b27734 ("drm: drm_fourcc: add NV15, Q410, Q401 YUV formats")
> > Reported-by: George Kennedy <george.kennedy@oracle.com>
> > Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Should this be backported into stable releases? How far back to we go?

Probably, git says 94b292b27734 is in since 5.10.

Could someone merge this so it doesn't get lost again?

Thanks,
-Brian

> 
> Best regards,
> Liviu
> 
> 
> > ---
> >  drivers/gpu/drm/drm_fourcc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > Sorry, I lost track of this - I thought it got fixed after the previous
> > thread[1].
> > 
> > -Brian
> > 
> > [1] https://lore.kernel.org/all/26fdb955-10c8-a5d6-07b6-85a4374e7754@oracle.com/
> > 
> > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> > index 07741b678798..6768b7d18b6f 100644
> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -263,12 +263,12 @@ const struct drm_format_info *__drm_format_info(u32 format)
> >  		  .vsub = 2, .is_yuv = true },
> >  		{ .format = DRM_FORMAT_Q410,		.depth = 0,
> >  		  .num_planes = 3, .char_per_block = { 2, 2, 2 },
> > -		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
> > -		  .vsub = 0, .is_yuv = true },
> > +		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 1,
> > +		  .vsub = 1, .is_yuv = true },
> >  		{ .format = DRM_FORMAT_Q401,		.depth = 0,
> >  		  .num_planes = 3, .char_per_block = { 2, 2, 2 },
> > -		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
> > -		  .vsub = 0, .is_yuv = true },
> > +		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 1,
> > +		  .vsub = 1, .is_yuv = true },
> >  		{ .format = DRM_FORMAT_P030,            .depth = 0,  .num_planes = 2,
> >  		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
> >  		  .hsub = 2, .vsub = 2, .is_yuv = true},
> > -- 
> > 2.25.1
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
