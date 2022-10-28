Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9FE610800
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiJ1CdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJ1CdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:33:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0277A91856
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOQOXVEsAvf8KNdwfWye/ODHZO2YfLftzg4tQWvUT/1lRmn4yNfxlaYUCdVSZbqoyKv0zS6yhJGGWHldGJ/G0XjMnHzkT66broxihYHK/YoJuoweLDZ17hkoccM8hUEp+KWeER9r/xpqUGbsvLwYmQPqJolYBKqAaf/Ypivcq7dM82jt8bccl2ywx0lunz3BytXxMgIyC1gxD8KjqIWDICMLKBNOF5xjDhBDw9fmk5ceunWDQgLGXPi5+6bLcATMn+PxSW/JVN9shSaWBIaTr9hjuY4fW4hVv3dELcTBY/CQ2W83olXa/FplFo5cn9+gThxuJo7t/pB9U84Kxfjyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruqTnhEg5CKXqtwnoXksV8H8S6b6Z3z//e/6UTbO9HM=;
 b=ANFDR0+Btd+KheKQNElVR/3oBC7nCg3SQJuGo1Xwv28CsvIDl6yQWsSRy/Haxv6MSeSVOTTE4EtNCr1aK+SC8wVy/cEYP5BgQITzJgRwIG3NXYCnVr4qU7pjUhoH4nAcDr5Qblq+5Ni21xCmHZGdWylStSzpXn7Wv1PsUiMHeS/rZoUsJRLOv5MbzeZMAeSOKT8AuxJTndGY9c+awrowPimVw4SGL/E/4/QbRHDVnGnztuqvR7OGo4YkssuWT4SXTW7zNEYctToZcANaPdsDqhGIIwUQvO99l0gExHfNCR6NmPs0IlZAtZgL7H3y1+x8M7af2RHHDnj78jqWemyEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruqTnhEg5CKXqtwnoXksV8H8S6b6Z3z//e/6UTbO9HM=;
 b=eY09zOjrpt6BrvFHfyRE26ilnUe04F/2efSYlFf0sM0a2KEcbv4CvysOFmJwyVgSdNQXZIpv/xPg4QC2sXdcSrZL7nPbruTnn58v91u8MbYPz2WmbMIChOpEFk3YerKZn2DubzAvhWHfCRq7tsg88g4M3SAsUq+LFvrVWpyHCj6etAV62fvAHCdIV0JpTtwo2DYt/7c07GFh1DUHEIOd3VqBpgHpQ8ze0JWCQdXdffUfuPhvuhMVsN/qdToZHa9E/0NxpcskpIqmC7CnbW3Sof5p1+4m1OoE7HdIjjh0ADQHBsaL759WhvxIl/RgEnSqsbK9h3Njgx4/+baOMMawig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5664.apcprd06.prod.outlook.com (2603:1096:400:284::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 02:33:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 02:33:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] f2fs: fix to f2fs_handle_critical_error when errors=remount-ro
Date:   Fri, 28 Oct 2022 10:33:03 +0800
Message-Id: <20221028023303.28020-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ab2f3576-bedd-8c27-5549-f9ff5462aee3@kernel.org>
References: <ab2f3576-bedd-8c27-5549-f9ff5462aee3@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0765d7-5de4-406c-0888-08dab88cc2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiEP2NSu4s199KOJ0buZjTM/w0STPWU5Q2pW+zy3jz/sL5GbmWVjj/rCqe9ZmlB/qooIrvivXVtNQ5i1bR+35V22bV+yZmwKrt4pc0xNmBzA0nKDzk754wPYerULgRk7FfhpCxdP3V+QvQ6D9K9sVmq4E7l7ZzFqwbYm1F+Vazp0LDSCl0CjcSZcTVWOkfIGkog9CiCvoYzXQM/PiFjg0oYhTqyADQ7iKYHs3EyYJ/nxFY7BiSfBoByyeYVVc/YSaTgJyhvxq2FqdboUQYMAQh1CKghW23Hk5ul/F0UqWwPJccduCwkUr1zs4qweJfbiVCc+JoqaoMEX6QZ16dFXlDpiMiP6jCX8w5vpQ+kHtB0w03P3RHtUsC08ipvvGh04Hg4AydjXbKojXDfaisV9rnyRmzv57d59bEZhbeZVyUmBASxIzfnB3yFAom1CzF+5wK6bnH3hFsiNCjdoTs9q9QUU/5tVUL+z4qAAqG1o1Tp5pDU3VO/n7+pl8qw6Jcj5jroENSIXtHisNluXBFMr7GUNeKQYnu5HfDbul8/6czEPGrgLBx9VO/hfa+mgrh7QH/O+8Yu/Xrz5wDjTd5urHIUMypvxACgpiXjesSEL73irOgiIJsuUAKSh/kNADBS25s0X9LXZxqcoJZtapASH8Sl60qtrHHOkcYD0K4y8+1eUX9TbKCBy64anFzYHqhhxIAknd6e4R7G98lIykHXucEM9k5MgX25/W9WzNtnCoTpVLBVCZGWMcTRLj1TrWCazZcP6YxXc4pog3DJTBU/PzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(6486002)(66556008)(316002)(2616005)(86362001)(66476007)(66946007)(2906002)(36756003)(4326008)(8676002)(26005)(52116002)(1076003)(186003)(6666004)(38100700002)(6506007)(6512007)(478600001)(38350700002)(4744005)(5660300002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uhBqFFQE7UV3GSljdI/rXw8P/HTXwfmhxsC1j2EDGAaGPG0gI8SHYUWe86lz?=
 =?us-ascii?Q?61uz8fGvrInMJeLXxi1RSDacP1q6p+PxmRmAkIRBj70MFYVEyMFL5FVYN+AC?=
 =?us-ascii?Q?g/twvtQfnoTO1oh0dbx81CKOI0TJMmj1GXp4suPeU08MjA1k1BCoKajTsAPY?=
 =?us-ascii?Q?43IljzcECDD5ssabekFnVMNFaYjNVB2PtLDoi/hZs3u0j9rfN6qksycex4hK?=
 =?us-ascii?Q?WvHZVUKEvspUHCJh3Z89DI3YNmERFUa1wkRfvoxoHPQkCotVLOaUZehftB9D?=
 =?us-ascii?Q?t9wlfzF+pdJit3K6c0GNqX9vJFdlSwQrPSs08ca0fpeLfIfjNEAVpmZ38rqI?=
 =?us-ascii?Q?byriT6V8bqjNyN1RrOBMaVb3Y4PK7/SADNwEEqrXmeELKf52IRVTh6MLTamQ?=
 =?us-ascii?Q?r8UXTHTZZjgHXpiMDMy1hms+5EEpz3tez5FzCFW+OMU2a/JOD6BUnldFL+7L?=
 =?us-ascii?Q?/JhwkOTikLEhp02tzUTGGxSkzQ25YIHM9sU+1t0MKYDc8ztjjGme1uQ7aFaC?=
 =?us-ascii?Q?lc1TWBGuF3jW5rKTeMbMeYL+4uvmO+mvOH8pRD+Rox+hFSAn8p72k0pJixFx?=
 =?us-ascii?Q?mk1mnGPtL0x1/UvC85n8CUBtFKeBTXqGAlSULjNCT9UwQLo0b/mps0dlkk4D?=
 =?us-ascii?Q?ksHrSFgxbp7yj2WoK1auSdZZmNfvIlg+VzSetNPOZbl2Kh/IuNig2LOyDjKC?=
 =?us-ascii?Q?y7s40mrotuFrhWV2FwOZ7sg84ukTC3fsrSATTwQyyrqWl/fKp5WvX+nFi1zu?=
 =?us-ascii?Q?Y23osFOvxEWviWKLaLiLEkDuNuG1w9p1Pey/6xaBbY6nnkUczA8Np6QUrwAd?=
 =?us-ascii?Q?Y2a1Iut/KoHV6/m1yVc0xB6xO5ETBBF6DcJovKZ16pzOMy3JMxFyLB7Oy3nG?=
 =?us-ascii?Q?9CP5OKs90/AEqghb1fv1O/yl6S5AK/oyEy6qAtBx0hwNO4CJv5pONe9sAokr?=
 =?us-ascii?Q?IQ2Ys4B83etmSS1bBMrupUY9Z+DW0kAnyHj0Wzj7cpkpQy20GtyhbA0TUllj?=
 =?us-ascii?Q?iBjQ+t2gwuuLf9qG22PnairFqA/wImcGJpQmFZK8QHL07k99Q1TzafkechXN?=
 =?us-ascii?Q?EyO6Om5nus4+tH+M9SKcOiULFu9WDubRduBQNgiHK9H1W7vA8pE2JkYPf2vv?=
 =?us-ascii?Q?jN6/PxnRPmvXhjQWg0+vlZu0WbGjiaNcqwecUqs2u/Q3K96QJyp0KJf6QEs6?=
 =?us-ascii?Q?ybHMOsTiVBGwhye5ej0fxjGVQYFkkixsu2kCIMrVv16TYJuVMFWxiORvo2hz?=
 =?us-ascii?Q?ZRjZn6KEtjYB3sA3VBz2H3aIIAxbUMY4J67dm3Y74LAOyrhygWm4DQacI+H5?=
 =?us-ascii?Q?h/t5YGOE5IOigvJa9pg/ef+wBhM1LQXwoLoVXw3gAjk/aqu4UeM9T9v151xh?=
 =?us-ascii?Q?uMZb6+nJdonYOZuO/UjEnFdF05iq8Jbbo9ypWHhL14jr1lcFypKH56mYyQmI?=
 =?us-ascii?Q?iUN7+0rdIZEixd62vxIn2nEyZQ0kQSc0Y5FuhW1MAnEB0fIw45g/ccrpce+Y?=
 =?us-ascii?Q?ZwFVuM5SbsZnN3F93XWo/whINukfCXzifhRbDcar2shZUzXLqeCdM4Yd3LrK?=
 =?us-ascii?Q?aBpOKpeqda+ncA7/ZwQCp3UbEpslPLfp7vhK8Kx5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0765d7-5de4-406c-0888-08dab88cc2dc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 02:33:13.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je/Kb5LNgMdRGA/eQukE67LOCQuTJsKGSYmmygHciFhoAn6E+H6GxiPhyOkQQkbBECUtMYKNf0UKjPZjpwvmMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It won't pollute global namespace since it's a static function just be used in f2fs/super.c...

emm, I think it would be nice to see the f2fs_record_error_work symbol
in the stack, it can be explicitly a function of f2fs. personal opinion for reference only.

> Do you mind letting me merge these two patches into original patch?
> since original patch is still in dev branch, rather than mainline.

Glad to see, if resend.

> I guess it needs to stop ckpt thread as well...

agree, :)

Thanks,
