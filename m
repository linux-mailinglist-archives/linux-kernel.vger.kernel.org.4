Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573B764DCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLOOOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLOOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:14:28 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6D027936
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:14:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeQDutYHNFNSgwWead8JeEgHDZsa3x5/xDLL/+R6z84JpS+c3p6zbDJXxNd+0CmM6RuXXmkbqcbPwkE8qiN6B1PgTCkz2EOpfVohh2c2/YZqwEWWim/yJ2MkmxJYfaBpr0GegALYc6zi08TDbZhJNSRUbqLyKiCw61/EEQPJLTBECbkW9rNmnDB18FxisnZoTIJRL/d5ylXn7EN0uoBcJQ/VXyrf3Qpq7gOfpzvyI3SgxPPsxCNz75z5XvOkCb6+HGUnLIlI4zMQTOiUKt6lU498oC7OZ6toKtVp25qK3uQBwcQgDzfIpCBTkFZ65/H2tL9xi3ofcm62d1ctVs3ROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN5hrTRd6Hu27ZAqqbYgSNmcH6Wdij9omXcBdnh80qE=;
 b=EDr82MgkZRmsG9JaCiehpFHQkQObMLAAdezDvzIk9D8uYP9HRVXOon2JXWZ/NhjeG+mD77Z0V7wPbVnCOJqmEaOj9irUvs35FwY0VZhulVLeWbJxqzGbm83iWTYF0h+5UsBzr1wBuhtqntgbztr6Js2XgMgZ+3KqfITI9AiXoVnVQ6CN3lI4nBCbPzxG/KkI2s4/QLgaHoI9FQDSsu8x3ZY5bg2SqdeMoHuiMs7GQKVRRZk9kqm1rOAoP5eD+6vkDRjLCEO6XPeRXXR+Lmr3Xw7Kz0FZWrRdP9mXjwa+TwD6M2vd16K82iJW8ZttW8m1bdkT3SSdsNbNeAPCViTf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN5hrTRd6Hu27ZAqqbYgSNmcH6Wdij9omXcBdnh80qE=;
 b=UQO+ciXlJGi1BxcoLBKHrBvwZJNyK78JXbSZi5/kkl3wnDNX0lMi9mZ92DXIwWLEme2nzpTBhQXvKghr6PzzyMQP/m2TGGOo5DfpQvJ/y19b+YcVbhji4LTXFqw85PVf766b+CtsJjI8yuHwsoUJGDuSmN72uJ0/5TShc0t9exzVjbhW16igd66jxg0y5b6JijKsuL+t8SNVRtKXanspt/M70IQDSQmAFsS2+1zMOFpDOiKthQyVi5ssPikWUGH3QVrpos9TVKjdK60w45IXB91IAb0FUtYwaw/+1sP4KItLMws5nTVrSuJRV94/u04gOm6bl5rDPwHgIcO271BvGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4556.apcprd06.prod.outlook.com (2603:1096:4:144::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 14:14:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 14:14:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: add missing doc for fault injection sysfs
Date:   Thu, 15 Dec 2022 22:14:12 +0800
Message-Id: <20221215141412.66752-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221215134844.12951-1-chao@kernel.org>
References: <20221215134844.12951-1-chao@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dc2a6b-08b9-4ce7-4913-08dadea6a8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9T5fJUWiyMgI5wbS07Cae5UX52FcSGMbti1ivQwSlAMiJy4SiCoxnZ3UyynTDsT3hAB3IjH7nBTW+T6lstcGRcA+n5S7Nd3iy2ltKpQJ8jZHDL8MspBIrw52/zA2FkuuPwRk8/SvfEWIp2oMnfNY+5LHSCNv7T5cU+p8mKZFstg3MRZeinEFmbDU1I9e+oVkS2/ybq3wWcA9PWz5ECgIWBgHl2gFOqoo9wx8NhMatNLVTVVMM6nB7ahwvTVlTsWxs74VkEnC1sGU/d6iNlUF/3NZEPSs6cxr/2fqTV0RSzT35K3+ue1TE+HdyyMlxz3C2tT8j/7mH3TeebV/+9KDxXr3uA9/P+S576jG47a4o+ADzUdcEYi9sZOyE9kSGuSzb11pwfhN+JWHwZM+g1/96BHZfIF753CDubXoMFiRAZ1Iy2hREcYGohFbvfCDxZPWSFVRfZZccXKthO6q6wCfvTsRbB1i9s2cXUK80ygtZBmG2Y6EY3OPblfYP+PCMY/bq0g5duHHxfKLQUHmA16IMOCq9SgmLmlTVPoj3BybqODsUK+ip11yyTz393As18+E5JAZZegRPiPkdunz1A9DJorlFBZLiKOtEMYs2eVMcOkoNyU68tyeHVPyAcJpaZxwjjjdvT5f1LmWTMDHOa7pd5lYZ6BwifW2YexB1aYnOt9YNrQZehrsgFTdWj3d0Gj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(5660300002)(8676002)(4326008)(8936002)(66946007)(66476007)(66556008)(41300700001)(6486002)(52116002)(478600001)(316002)(2906002)(36756003)(86362001)(6666004)(186003)(26005)(6512007)(6506007)(2616005)(1076003)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6fGAmbj190ziV/ICNXlCfDDpswKxLngecFd8j7MHoHodK6sUDyZVLweD2so?=
 =?us-ascii?Q?XQx55kZvgmJqM7wenBl0e0DOB9It4UsIusiIsUOWYxTbRpvD25GYD8PFeFuH?=
 =?us-ascii?Q?L3Vc8zJ2BHqhghCh7JtibfNQZfnmHA1h+JYhi7KG8xvdWAStQG0PDEHp7r9j?=
 =?us-ascii?Q?HjUDXFg/nqs1twMRVh6ux3OQoj/KdbS4DTFo9sKJdcD3JI3/bfsOSnMKNAsS?=
 =?us-ascii?Q?G+Z6x0vIombA/QSEJ+v7w10dAY1H5TOzNZ6LtO4O08fRck9upJiEOfZy4mmo?=
 =?us-ascii?Q?ShKq33SQLqqQy3y5yg1e1SXijjYjSswLaW9w/pnB8tRIrcT6cCBA+/z+SLyo?=
 =?us-ascii?Q?Qh4N4F4xoWB0SfFQRaSU2kGp0Z1maHia3d44TZoyo35RA8EpkpJFrOozzGg5?=
 =?us-ascii?Q?o5xhO+G/dIsqT9WGvPD+sR1U4C4FKKoielLBuIOzDFvBWd+8VTWS7x7ie8DB?=
 =?us-ascii?Q?E29ubASNx5taRtwBkv35NlWguBrhl7BpL7509UjDw8tqrAYuLoh1HgW2sa5u?=
 =?us-ascii?Q?JhM5L3FF28EFPNZeH+VlQcuNWj1RsS5g8qYCqB9s3pIJ3qEvkdCEm055ZSF7?=
 =?us-ascii?Q?gAiAEtjSPyFrAznx//xEX2Nb4xvMk+LhnV9lDVXtVPB8e2KEzuR87kG7NEvw?=
 =?us-ascii?Q?CvRApQM5zFkIPv8yn4MI+93RQ+IvKtY9ZIf93XSZUBuXRRsirK/HRD+4ti/d?=
 =?us-ascii?Q?7Qx2lVySXD440vXk0FpVLZU/GIzg8YLoqS9pUutYoO9uq0uYJZmBSB2rcNyl?=
 =?us-ascii?Q?IZVWIcVTz49npzU+amid1N8SRB8tfCmvAwKTWhV7LOf49fiCOrBYhw5Zl/AG?=
 =?us-ascii?Q?9kU4LcxIsu+GE7Rrbt0Y7qNE+aonOlp7mlrkfhyuDBVbXUaVbWIlpMc77XjI?=
 =?us-ascii?Q?uv76L+Nn2p1PGKwt2YwuBgIXfw4KJr9HzBnD/BuubVVTfUHj1kGIDjw+ypru?=
 =?us-ascii?Q?jwo2hvYpZkpvSoZCkx7EBJatb6t323WbJ6V7JBigQgdoXzSi2mrbbDa9SJ26?=
 =?us-ascii?Q?+0CYeS24eMDOCgBWDPAsTTebTeMSEBcOAh53qISJ8ADj839MZJr/FZculGfa?=
 =?us-ascii?Q?oEG2i+1QpmkHxaPEDYmHEgWfqtkaaVXAf3wWVFsTeVkngqxpW9Lz5nRZw1B1?=
 =?us-ascii?Q?pYVrOZfBpombFIVpyKqB9gWIQ7oIKCtF0z18jTNGt/hlo10yCeOOEe6xRygA?=
 =?us-ascii?Q?bDzWOLwiIHV/MzbRacWmOOdO2cgR862HZPSZABe33lwTCEHiD4hpG8xRrRrL?=
 =?us-ascii?Q?uJyWm6Y9MJNcUBq+qOWTl3WhPryoWRXYRZOFzLgkh9Tk6X+OGryC9o2CbZab?=
 =?us-ascii?Q?a76E+B8YiB9ayBBhJAEIRauMvYACPdwnhEmzkzo7ibUyxDFpwmd5/gOD/lDQ?=
 =?us-ascii?Q?gK8a0DLy4XILwHPUBgmMvNp5jD88KknXwspBQ9J+3P8z94xaEKu+GkUHBf4Q?=
 =?us-ascii?Q?3br46jX+rst86JfnUoA+hOEYrFFd+gUHJLTTQnOWy33xtuTx7P6xBClMiXkm?=
 =?us-ascii?Q?y1Y1joEldI25hMJ8GVz7ncIoR/F1AwjBrk4sIsq5nmDlvFGYUb0goBnCCE3s?=
 =?us-ascii?Q?WKxyNOnUyj0Qm/yb02VML7Dwh2f2397mjT0auE29?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dc2a6b-08b9-4ce7-4913-08dadea6a8b9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 14:14:20.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IENxjMSYPSBFNGkI3pYX9Ttivu3xNvwm5antpWPFHp/+MrQj7ZffSw52DVcD+PWDqyIRCCJMZNKF3JEta0F8hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4556
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

> -What:		/sys/fs/f2fs/<disk>/gc_mode
> -Date:		October 2022
> -Contact:	"Yangtao Li" <frank.li@vivo.com>
> -Description:	Show the current gc_mode as a string.
> -		This is a read-only entry.
 
> -What:		/sys/fs/f2fs/<disk>/discard_urgent_util
> -Date:		November 2022
> -Contact:	"Yangtao Li" <frank.li@vivo.com>
> -Description:	When space utilization exceeds this, do background DISCARD aggressively.
> -		Does DISCARD forcibly in a period of given min_discard_issue_time when the number
> -		of discards is not 0 and set discard granularity to 1.
> -		Default: 80
> -
> -What:		/sys/fs/f2fs/<disk>/hot_data_age_threshold
> -Date:		November 2022
> -Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
> -Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
> -		the data blocks as hot. By default it was initialized as 262144 blocks
> -		(equals to 1GB).
> -
> -What:		/sys/fs/f2fs/<disk>/warm_data_age_threshold
> -Date:		November 2022
> -Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
> -Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
> -		the data blocks as warm. By default it was initialized as 2621440 blocks
> -		(equals to 10GB).

Why delete other node descriptions, mistake?

Thx,
Yangtao
