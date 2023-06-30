Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A82743C71
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjF3NNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjF3NNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:13:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C090110F8;
        Fri, 30 Jun 2023 06:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyuOlaSCNv9u1dr/ihGLLVjWbTd/o1rgZP1lLVYuofZujsXHhoPPgoqMKg65114V0vFqLC0FbreQ6X9I5RAw7l8kYClcbJkGLLgg8nJKAf1Fk4wvTyQvg3cJiahrHpg7bGWqIB3E6VOf0zvCzBNzp7uU9RwajWHZTgz+odIgnIAgxtkf0SU1svhzzXYPFVODalAsIbKnN1XK8ZiUH38yYXa/6RK6axW1IS974AMapsmbQ7u3yNRcEJ81vk0oQXuuJB233BGKL588h12ZLeWgzjRvstyymgAn+7t++fE+eAsUoJA53bGA/8EutPvBqpr1Wvpi06TC2KMFfhJyYGMzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+HbUF1KRKwJCTPH3NecUSOwROxVz7rLh2NqXFaay7Q=;
 b=fxODG1TGwYMOA/PKi3gEyZ1/TjmRDg529w50xf7bU5Ll3ayZvoJk9W/Fo+CMQzqtrli6EfsVFUPE9y7Lh27OeALZlwjnfJJPRsqaJhXEllRfcabjL/Ic/wbPLEKOjestfXY7A+0NDixXoQDFjzmICDvYNxSaL1sD3kwsNVrBIRhFvSc/y3kk51Ay0LjciilPR5vxaYcB69aPn0DURx/8DadEiFou4wEDy3x8SX/Uvt/ReB8Was61Ky7kZIyOqpPz8O+tIxud9AkaKyLobjb3JOeHWcOzF2iq1SosCklMZujZ4sfU7TnSOsPUAsYvhYgJN9rX5yZ4WUGahie8O6ABqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+HbUF1KRKwJCTPH3NecUSOwROxVz7rLh2NqXFaay7Q=;
 b=MwsoI6Q127B/WgsAn3q2Vj8R+CeYmknN9Sh6ML1tjMPebHNpQhpjnVLIMnlskcfhTMRhzJee3B8TRSZFLXVZ6N/cl1yIvho129tU1/ekJnrLJCoBoO3j60RzsGGvJtfibduA0qnhpzMU2PBgusR4GcogQWefA6CR5ikICKxxbp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB4572.namprd13.prod.outlook.com (2603:10b6:610:c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 13:13:28 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:13:28 +0000
Date:   Fri, 30 Jun 2023 15:13:20 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc:     mhi@lists.linux.dev, mrana@quicinc.com, quic_qianyu@quicinc.com,
        manivannan.sadhasivam@linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1] net: mhi : Add support to enable ethernet interface
Message-ID: <ZJ7U8D1Ej63lX06g@corigine.com>
References: <1688118281-13032-1-git-send-email-quic_vpernami@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688118281-13032-1-git-send-email-quic_vpernami@quicinc.com>
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: b4365730-030f-42d8-04f6-08db796bcb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHVctQ2tlXTwLeLzAq5nnSa3U9q32PVpeosqAtUNaWVoZLKbwJZ9IXKy2Mma0MhBdBdTZZZoS42mVUCTxAwd4dmrjgnWRNBfNXzyOVmXlAaCUr38hP7Hq6pMpXLmFzn6eleLEr6Ysup3L+ZgAUkuX4Uvi2MZhwO4yo/Po4BrV50sv0dIHy2q2M+3uhYsEc06RE3n6HNoh7uTk+Xba3xaVBgdv1KvTNqd5cF9r2MyuSz9EslxC3zvJBqNON7inaFdF8EWAeeeHPv8yzFFEcOHXcpLSwEc3xHg4EFDrsZX6WC+V4o1CEpn5fHHwyiqBFb3dHRcBewKWG8RgTzJ7Fm35Bz1r09zBBAvqf8hop75SkxfFm+XhzUmg3YnS9KiNbmTqyjd+7ihiIm8o31NL/DzL/5XiiL2CcGd7rqrSJrilf/MDxxk9JD9leIy7/Rg3YWm9XH1MdZHwoIrvWMOSmeuWTIxZjmxLpFHfa27krWpJw7dT7OnXlLCu40igb5xa+SbCWcePiKC5LnWaPWabQYzpuCI+HRVFnxSnHjVhvh4FVaTurA22C3TZbHe/ze/XCL+bQi1r65YleTpd9qOprkWDO04BLiTNKZe1z8H9MNR8D4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(346002)(366004)(136003)(396003)(451199021)(8936002)(8676002)(7416002)(5660300002)(44832011)(66946007)(66556008)(66476007)(6916009)(4326008)(2906002)(316002)(41300700001)(54906003)(478600001)(6666004)(6486002)(6506007)(83380400001)(36756003)(2616005)(6512007)(186003)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zhZvINureo+c/P2MK52jam/zAYchwniE1F7YtFgebadJ3EVTOvHonCYXwtaP?=
 =?us-ascii?Q?+hiec+1jXSv6Jgbqbg3pK00ocextjrE58INM+dbJlVFTWmFUsnl0j6+fjncS?=
 =?us-ascii?Q?ZvrwqdRa2CBkeLcEY5dFj1NGsng3DVClkEdGJ4Qt9WSPrQqVHV4/D3mL4Hu4?=
 =?us-ascii?Q?jv0p+RVtuPt/aSaWv+FnLNKixifXx1EFbMgB0VWejiFBnYzc84C7+jc42Sek?=
 =?us-ascii?Q?8uBPmnn4f1TmIkbNv3Q2rZKhVPT9j0KhL9Fz9tuymzOkr7khzFNkrdoDPAM8?=
 =?us-ascii?Q?y2I1b25z/h0ydOh5RICNjBW/aghwj63JbyPyposkhf9irhSuNnkAGN/UCUMg?=
 =?us-ascii?Q?Aw2eR18qkV7DNrHDplq7Uk9rnz+NID70hecdJ7JMN8rYSZFkTOouXcCmDI9/?=
 =?us-ascii?Q?BBYtDdQf6V8SVNuvsKkr+w/ggYIsECHOY3nEFOQIspZ9cwdVhHrzlpL9AcjD?=
 =?us-ascii?Q?IRAQ5ccGo0mT4W4ZBqy+GgAGJQcEn2MW9+NNHK6DhCnn4DAOYCTOhR2UFqrC?=
 =?us-ascii?Q?ba4BFKxbmHxc37DGWtBHf95JU5in+TyQt6rG2MA9OjIKwJ3SAkUaGQh8PAMz?=
 =?us-ascii?Q?rcWFOG6b4J7s4KcGeBU1/aaccLPTwJVIqKizLp3YLCQ1EmEyrzmAjIUnKxGz?=
 =?us-ascii?Q?K767mLJZvj50HwEFq6C/h4N08MnhTS8joBUrnPoK/TAv5AdsasXIEAZXq8QX?=
 =?us-ascii?Q?IhzBTIvVFetc2DEhU+409bRLmsiYpdZh3+y3dpwoNzwCki4zWL6oW7leokn8?=
 =?us-ascii?Q?gvIsex1pkGyZ04/lR764ymwxUlB/lTiUBo3Vunv1KX6BBdZunaxqpH/pHHfu?=
 =?us-ascii?Q?x7/NWqihofYCsEYxwcP1OZlh1iKxob0MH1u5nhij/UUhfV0i7VSfowLYhDf9?=
 =?us-ascii?Q?0TugEYrCfhHK3NiuI/rX0T6XDcXbb5l3z+aJcaLUA0cMlzURxzrNiDlKHhuL?=
 =?us-ascii?Q?doyQn/PrU1Nua9W+41q1zIgHHNOCW1nCgrVxiI6ZMyw8vT2VoZGrpu/rxOyh?=
 =?us-ascii?Q?xkyKDYHyB0AgkwcXOTu5aAZTXY4HRpDEXOnHWKlT18DoyxtT0skixu6WPCf5?=
 =?us-ascii?Q?kgfZUk/G52L4zoXHWW2QD3XU4dzyXqBZ8yJvgjgEuSThi+At5aEpgkcQ5+0v?=
 =?us-ascii?Q?jqZCaZT+b9YyXdFbbsRi9dHBpEZN9RIDcBeXQQK4/xHiWWA2yPDQkhnw8xX8?=
 =?us-ascii?Q?JPFMlGAa2skEGrlDOY7sSmVaD4qobuv2voVU79z3BGy9ob1N+/LcByRRUssh?=
 =?us-ascii?Q?si8RpweMaOcjwKOKtS+RsYO8NG6Ase6f6xC1rACM+KlCjn6nR/6q2YhxTaYT?=
 =?us-ascii?Q?7AsCTxHof7iAa+LLooQSQXBWXkwXE2Zwcb0btykSu3iEp7RoCxw4OYImiW0v?=
 =?us-ascii?Q?6NUc/uExobN+JdBhLorIWXkzfX98nF61siErsX6HyqfGflBfbpqTds9mY1xg?=
 =?us-ascii?Q?BD8SONuwQrAEpHw1TDRv6LPYDo/A1dYMwyVWwF/r0mFH+NkqqYmRreQzzxzt?=
 =?us-ascii?Q?sLcFSto5V9OBy4m7BhRI1J1xTSXdTUuSl/axdSlqjjmuF64ieRGK/cVZEUhy?=
 =?us-ascii?Q?D1tum3ehvdKyzKzwBeXyABqajfrCCMpa72kbXOiHFkM7zs0719OzCSQsFCQ9?=
 =?us-ascii?Q?fInwLSkF5ZElgBl03/4udfpcxERj38LQIGSE0UtrHKyhYj89kCt6cbNYUx1q?=
 =?us-ascii?Q?DF2gGQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4365730-030f-42d8-04f6-08db796bcb1f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:13:28.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJgRDvkQq6vuYwRpQunEP2VTwBzA0KOnO0Q/oRsB892LON5wyJUK4g2EAyeX8wOh2wbS4WRS2FpWgEXlWrZbLJKUKFDVIS078/SAmMwuKns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4572
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 03:14:41PM +0530, Vivek Pernamitta wrote:
> Add support to enable ethernet interface for MHI SWIP channels.
> 
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>

...

> @@ -301,11 +318,17 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>  		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
>  }
>  
> -static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
> +static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev, bool eth_dev)
>  {
>  	struct mhi_net_dev *mhi_netdev;
>  	int err;
>  
> +	if (eth_dev) {
> +		eth_random_addr(ndev->dev_addr);
> +		if (!is_valid_ether_addr(ndev->dev_addr))
> +			return -EADDRNOTAVAIL;
> +	}

Hi Vivek,

This doesn't seem right.
As GCC points out, dev_addr is const.
And I don't think eth_random_addr() produces invalid addresses.

Perhaps you want eth_hw_addr_random() here.

As was mentioned elsewhere in this thread, net-next, is closed.
So please post a v2 once it re-opens, after 10th July.

-- 
pw-bot: changes-requested

