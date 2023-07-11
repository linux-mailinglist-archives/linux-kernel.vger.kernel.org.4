Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2474F737
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGKRZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjGKRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:25:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87241BB;
        Tue, 11 Jul 2023 10:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8SS2CYuBCBZOebMhvGbN2G/OIYZjIb4IjhyrP2SB84xhipH/8vqUzE8nomVT/nDu1bPD+NhOTWyNg+DPjxuPOQz3zrxt7tMe/5QxuhOsQdnuoHPwu2u0DUBsh1cWjBG4lapr3XPOh2mJIsbII/DBSYS7pg7yTCcbXQwKny+C80UKcxFChNO3Y+lfPVczfNnrPShgQ6eHa39D0JQBgYmT8Gs47v1OKxaIc8MCYUlNlhO3527qq1t5qE3w3jMQiTxh1oTSjIAFNNVLYcENjx49FRnenu7by2i4XBBP6tP5Z4bNNQCZl7o8xhuE7nKuIbjS344/6q9BuNYfNFBTQP9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y+re6ONZ553vKGeW3MM5fjpxsV5Qv0GFjYYZfQVfUY=;
 b=U8M4tKkcv+Ku9CqqlC1+BMpcgsKMtTG9mLnLbsqV267KnrMlXlGb7ZfryzMWHxZR4/RU0CYo80CwzKb4UZ1CATY/bnxo5Q7pyB92WaFzYCTZq+SoEc+jtdrp1U3gPzmSexYAN4CQgwHsRHLpzVgkbhU20ag8s/oLFeyHbra0FiOXcGD5lGada+S+Irbww+ccG94KscotkyFOKQj4085JeA5WjIDsQBjqr5Fu87+CO0pgMOjBeEjM3pbwGpCALMAd1tzJu1uJyXjH43CxAZCVNkFlPqlSAX4Q+GsBoP8rESLhUaIOgdkh96GH3GhcXj/8dZVbNLIZxhBKWuX1JpLc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y+re6ONZ553vKGeW3MM5fjpxsV5Qv0GFjYYZfQVfUY=;
 b=Qu3Zy1T+2nXs3PQlH2cCetR17t9h3vUiOopv5cvvGhNY89ihIIhKJ8yN//RX3aJQYWYbuSTisUuEnBSkSPNb/pEA/TlFX+a94u/a7d9YwY/OZKwimRnwFJvQTJCaVf1WkM7ZUy9r15kXHOd3k6nhkKarO/Dw1/zRM3UFivs7m8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB4884.namprd13.prod.outlook.com (2603:10b6:a03:354::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 17:25:19 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 17:25:19 +0000
Date:   Tue, 11 Jul 2023 18:25:12 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] wifi: airo: avoid uninitialized warning in
 airo_get_rate()
Message-ID: <ZK2QeBZKWi0Q6vuW@corigine.com>
References: <20230709133154.26206-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709133154.26206-1-rdunlap@infradead.org>
X-ClientProxiedBy: LNXP265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 09da4e10-b299-44a1-64f4-08db8233cc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aESLwaYMhbdJD3+8FHsONcPCY4zgDBY5HE3PeUH09kpWHc58wdUUtG8aDomqq6X8qzkQal8ZjO3RWlve6joPQVDDVqOt668++Lofl6tAwSYRiEFkH+CANdo5s//AoDBGccHpxbgo9dOuHITrm007Koux4hKnNMmiV75zmYAkleTObOWPaYeoWV/TUpvLv0BN0ufXGn4p8HgVpddcktc8bowfRAUaITGKfLCPHve56gmm0EN9zjcMfL6B6lQ5idU29OX4uizwfdJ2XJXuHB97a2c/QJ6Y0MUcFv0NED3Y4Hi6NVCSkb298ohb+DrSAgiwbBbUmyWZ27GFHHNGCch87BRg/5qMBZvai/k1RoxNIDZiGxst4VwhdaFgGUFaJsOdFI+gXNmyOCQbOdJQ9knvAge0KBCq3MuHJPeMmnjpfctZmqxT+n47ESraJyyiOFk697XfVOZ4saX3WltbPvhxyGo2NlkIvMSTV24+/SRcbC8vKQg7a7pB9WDTf8uN9WASeYIwqRMPHaIdQWAHtpHJrw+tkz1h49n/AEg//HI8ncS5u14Sp8HKlSMYbNtbOCb/epx2X/0+7gSMmAgMatNzbpGQsCijwUQ47osc3XctQ7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39840400004)(376002)(366004)(451199021)(478600001)(36756003)(86362001)(38100700002)(6666004)(54906003)(84970400001)(6486002)(6512007)(8676002)(8936002)(44832011)(5660300002)(7416002)(2906002)(316002)(4326008)(6916009)(66556008)(66476007)(41300700001)(66946007)(2616005)(6506007)(26005)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?08hegpWuPylQG49MBfGzD+gfs3N3I9Q8jtrDhjDzEEx/gTQI3/P9p2waUo0N?=
 =?us-ascii?Q?03bx2z523RWAO0LMOkvAmitpJohVmrNhCpSW4xr4pevUSLWJ8K1KZE95CSR9?=
 =?us-ascii?Q?O9cYiCORxT6xoLsZoa+1w4mhcOYYuF3qqRi3sjLlliZ2oIifjeOVSSaef7xS?=
 =?us-ascii?Q?YKbHrdRs7UmnF6C8v15Y3SaUxMroaDkr275cg14qwBmQj6YCxatRyusggAcM?=
 =?us-ascii?Q?xhiAdSxHPYuZ71KcN83chbdq6ALNSp7NitdI/+i/uxHZsBwVwf9NiSHCH8T8?=
 =?us-ascii?Q?Xw66aMOuMcwMW92CCz3O1Pt4pX7C3XozR9vNRsB0yMg2tw2nov+nqj+Dvcoi?=
 =?us-ascii?Q?FVIl0vtNOfMxVZlU9iwdF4gQkcR8nQS9o4xQK25uJh6G79I4tpzq1tFYW4ee?=
 =?us-ascii?Q?FKMH5GIZ6umrzNt06qn27APQnQC4SkFc3YRCVUdvHRJvK6eVtyD+8uBOxIaG?=
 =?us-ascii?Q?pphWwA64oDFUp9jtFAjB+NgO7+yG1yaeRzixcIypkjCD0zBL0rpxcKqheo0l?=
 =?us-ascii?Q?twyVKXrnBqSeYtu8s8t/azTESafeeTUp86nCXDUfUdCDuzDtmQi95WFqKDDM?=
 =?us-ascii?Q?XYDNkzaYHuQipdfPECkeSvftrhUOL18RpwbbTIszn+f/ylwv/amAbtpL8Jfq?=
 =?us-ascii?Q?9dx9u5a4ElHtMrwbZOPtVZGH+uAr+FsJ5e9fkQuLlpssyMtuhFanRXlNfPL+?=
 =?us-ascii?Q?biXCRl1fiBtAGL0Bf2RHY1P3sk63twosF9Y6alfbuDbY2qcGibmX26dtCoLX?=
 =?us-ascii?Q?RFHMAcvJcWcwg6BlfXxDFvUkKhbxj7DOGNGeM8WyPfz/J4aZuhsyaoOSXKB9?=
 =?us-ascii?Q?wlLveQIVGDWMS5mqDDHWUDW0NpfzyouMzI1sQlY8njddPVnmyu6StuNJ+hbp?=
 =?us-ascii?Q?XkxLjX6JsD9ZXIfhabE7IbtMzT1N2z7c0AJ5/v9iFN2ordPf2Ows8jjDb3W6?=
 =?us-ascii?Q?OltcU9j/vjuqq9TX+if1ubadMpwVbju2nsO2xPANql4Frmh+HHpcqP6SonBr?=
 =?us-ascii?Q?LkzZCgf1BACtkuBA4V8Q5vm6b39DVtBZFOWs6zYcxiVL2qkhl8DgpS/cPKI2?=
 =?us-ascii?Q?Vx6u0DbpmVfAwIw4/06SM3CDTsw0wsFUX3HOlDEx9nqXQCbchcTeKKv85p0M?=
 =?us-ascii?Q?8eF61A0quWTo4on06Ah8HUFLb9GIKyAkmdS0E9VC3AnJLlVWq8zYFFMYTo7p?=
 =?us-ascii?Q?E/HHkyCAoorxm3koAl/BxTWEjF8WVYFv6AM1fHd+0N3XBXSujTe855KamzUy?=
 =?us-ascii?Q?HXcHk65ec1TTcpg0NUTLM8MNZeREt7i1MR69MpidBWemeA7gwfA7KFoP/0IK?=
 =?us-ascii?Q?FXtZx7LhOleSCsiJNabcKix8mzLmdpd3hPPUyI9UGELMarYd5yb/oqr/wQl2?=
 =?us-ascii?Q?ZxqgJ5o+COb1f5QvjG8iRgxHKW/e0LLiEmLoM3ter6/Hzfzx4zlubs5JeTs2?=
 =?us-ascii?Q?lizaoTGwFRiEpKUdLCafkJsq6OOowWv8RGqIkPZIfLv5NwhgMTty/wBh2P9+?=
 =?us-ascii?Q?rLkrSd1jmg1gyZXBTxpV3JAcCo3GrVm3hX1leVNcRsyP1Pn1AHhSIic/KA/D?=
 =?us-ascii?Q?5SKmYS+1zUQljs8QIIPCvsZ651BqWQgtl4bw/ddI+61xcBAxFqbaE1XpIaQ8?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09da4e10-b299-44a1-64f4-08db8233cc6a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:25:18.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eagEkZKewLFtqcINSaRLVytw2pXDcs1RYqKBod7F8PPKMV/NlrReFwUPVfzvcMSfyRCVws7REFQLrWRHzYxEkeGQw7Bwp8Okceitrp+x1U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4884
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 06:31:54AM -0700, Randy Dunlap wrote:
> Quieten a gcc (11.3.0) build error or warning by checking the function
> call status and returning -EBUSY if the function call failed.
> This is similar to what several other wireless drivers do for the
> SIOCGIWRATE ioctl call when there is a locking problem.
> 
> drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]

Hi Randy,

There seem to be other calls to readStatusRid() in the same file
with similar properties. Perhaps it would be best to fix them too?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: lore.kernel.org/r/39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/wireless/cisco/airo.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff -- a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> --- a/drivers/net/wireless/cisco/airo.c
> +++ b/drivers/net/wireless/cisco/airo.c
> @@ -6157,8 +6157,11 @@ static int airo_get_rate(struct net_devi
>  	struct iw_param *vwrq = &wrqu->bitrate;
>  	struct airo_info *local = dev->ml_priv;
>  	StatusRid status_rid;		/* Card status info */
> +	int ret;
>  
> -	readStatusRid(local, &status_rid, 1);
> +	ret = readStatusRid(local, &status_rid, 1);
> +	if (ret)
> +		return -EBUSY;
>  
>  	vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
>  	/* If more than one rate, set auto */
> 
