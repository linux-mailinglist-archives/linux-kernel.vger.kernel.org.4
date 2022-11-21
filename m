Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808CA632148
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiKULwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiKULwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:52:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E553286EE;
        Mon, 21 Nov 2022 03:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669031521; x=1700567521;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EwENrCij6kIv9EoJmuYTBLJq3px9fOup9077bB93MwM=;
  b=gQ696Fh+Abya/rJEnTD5BvL3mXoaU7cYwdrKuF6WI19WnQl2NqWi6c53
   S0yVmwkOiWt0SWm6NitmMkHMJwfnO3WEsjKhwDT3EoOPBfMM/OtKf5x6Q
   QHpMf/Q+Ov/QGrn1Z58jaUxUmikOmqz/NAKBZn2oaJ6cTtvRYUnqDm4ZY
   jIfnV42XciYoBUjX7yPsjPka0BacrYMimufzyDDWv1NkgvvD/Is89GYnI
   7BiP+r/FlrtRX8UAdgp5lHbuXwuYRmvPxE1VByz9mnYj5x2DXBpPs6VHc
   Cjb3h/gCyVx9EjQhj4fQCUpEpczmWFH6g19dzTwNJAMYGPuj90xjFyzJ/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="296896522"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="296896522"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 03:52:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="643293250"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="643293250"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2022 03:52:00 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 03:52:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 03:51:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 03:51:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 03:51:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwRBZyz9QwuMnglmUkkElT5WVzDlw5Ga45u6kRWyIkA5+mo6ur6hJJZu+Yhpweyfg3r7EaacXebaO6MLWQxgxRSPe1aHfv/kXaPrxH6TTYH4bVzQcJpvfJQk/NOLomgP0YlTe37hg7Z4rLmsQApS1gcFNwqZXhV6RtZePdhtzqDUlO6h+B/ti/DPdl604Z549m4v2gL7qco0dtsfbto9ThkkdtSqE1MvH/wFqFklTmhbPD8xvWtcrF/rlHSfic6gQYwck6dOxH9rDaeCUXK6572KgKxGMeQBbWYfQZquXjxC8xK1GZeQ0a8+O6Ch+oV/vjzd3/Ubx4UL2XpUSISozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9fQoHV1SbTFCiWToc/P7vSvKfNFQJl968vJ6LErc2k=;
 b=HjoiFthFlG9QRZ8KCer84ZgmbYzb4ROQyEo9LWHFXpD+r/26WDYnKwicdI71dDWfycgNXqlDSlwB5VEVdovn0+dPQjT2th1+arsYGBOiy9i8xpXXI9MPzh3pa+RDBjC5a5zbXE4KQvXCamNrMBxtRvsAh7niDLL7h7X7PCCkNbkUY1rHv9V9lnhei03SfQv7elUPaGP5jCZVPNJymBY1E4TD677tbUbNIZDKSGi4xWeJw43LLc7Yl7ENHDTanLD/mEINP+F12RjeXFiyvKGB3kolk2vbMPNSw2qSgty5w//ArGm9cMJunYf1MQq3cOqXeuOXjumv/X3Qwm5xEjuFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 11:51:56 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::7b39:df5f:fe4e:f158]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::7b39:df5f:fe4e:f158%7]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 11:51:56 +0000
Date:   Mon, 21 Nov 2022 11:51:49 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Wang Yufen <wangyufen@huawei.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <marco.chiappero@intel.com>, <tomaszx.kowalik@intel.com>,
        <qat-linux@intel.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: qat - fix error return code in adf_probe
Message-ID: <Y3tmVR3i65DaPxWK@gcabiddu-mobl1.ger.corp.intel.com>
References: <1669030054-9605-1-git-send-email-wangyufen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1669030054-9605-1-git-send-email-wangyufen@huawei.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SJ0PR11MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 528020e1-0745-423d-38b5-08dacbb6ca4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rs0Teb4UfYKVim3JG02EdnrYeidEvddmtyd/qBXvpNptH2z7hFCfwo/iQBE/kJJzmEpQbU1XM/N99rh0C/uvUoXBGUBc88IrHmuC4UXacDHYBBEYa/PQEOmj+JYnvtzHXbcRoBJhubLmTnWQPj5SmdYbOv/UQLoFxjueRuetW1Vt9D2NwoqTh2GFVJxJf0h5dU2wdkL1GngZ5BRHrwP11u9imkQAJA8mqJOJtubIIyW+ftf99iqmw1v34GTJN6yEkXpWkVIWnAxLjlzJZM311/itwZso6LAm6qSz7QJE0HqjRZXJaBw2IovcVNBonFtPJRbR/QNc8y+l+FrXEIoggcGBJNoaKIouG7KzoHhfV0CbK1EcwNZzY+xAOxads1R5QJjkar2IB4JOFW9dTTB9xt9/mtjIc02AnXFjbMKcsJz+IzkgagrhLBKXk1xq6T7I3YR0v8OPItWD227jV3uVvqDfm1OyYtfzE+CdWGwKPTuJ/pPKlWxealZUhpQ849jt4RsZE42uY9NDAczhAoLNbZW0kOgFiR9J2Wix4oYl4xxaTDrS1Z/IdukgpT9eNcWq0N0o5r6aMAYBO52gyttxSWWzp5sqH1/9aqY79mzMIYMKKBxGF8qpSKtK5OH1BuzL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(86362001)(6666004)(2906002)(6486002)(36916002)(6512007)(26005)(66476007)(316002)(6506007)(66946007)(66556008)(6916009)(8676002)(4326008)(5660300002)(44832011)(4744005)(478600001)(41300700001)(82960400001)(186003)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7xQ7hbWB87N55dQoZ7ti4y2T40xZDSSPJK7CBloxWASOWFvAbeUYf0viRpdT?=
 =?us-ascii?Q?y+pV0F6weIBgnpiP9Rlz+N+ZDFMYlQpeczAK7KPC9YpKus0i0ZwDH30SCLWd?=
 =?us-ascii?Q?qt/vpkyRj6OQXwa/BXHqZZtf/Y0w9L8dSnX+XohuXX4KcySB68wEOw+KoF9o?=
 =?us-ascii?Q?kaqi8QBBgSES0y/gvODac7DVrKH0qDY3GqMkO0jZ7cWNlDQ37BuSQXsPYReH?=
 =?us-ascii?Q?kNDAqgDDGj7J+SBrr68ax8Z4TV4w0p/WMLzbNgN4+1c6V0gvvR+/Cn8jZ8m9?=
 =?us-ascii?Q?5yZjf7TUn9YTFb7gK4DDok2DNKIQXuQ3E9LEwDYitZkS5RLzHAa8SBNqsk78?=
 =?us-ascii?Q?2QDZaJsMUz394hQY16AtCWFPftwbDBPfJHkMj0jvmSpPS7TBdRZU60og1x3w?=
 =?us-ascii?Q?ZULqnKB6ZVcH+SH9hASYnCOXG2MCnXFS5VMtmtSl7OvoanZ4gVUJIXEbS3iJ?=
 =?us-ascii?Q?4FhbZ9hjKFS/WqSqbMc+gmgxeUXZxrjhwEw2W/4V01R47dxjP0wbVAyx19LE?=
 =?us-ascii?Q?nToTmH7ecAkAAV7Yu42e9YVsArirUO0hd8THmik43Bx30mPeBppF/LCPu9qB?=
 =?us-ascii?Q?warzinX+/ZlmHuv5LedlumdtIgM1Mtp1XcKJYRqGu/6SMyB6oge9dYImqetE?=
 =?us-ascii?Q?192SIuV+M0JA/q8T4UYYKhYD2z5Sr9drPuDrC77Hmo+4A4yobMacBLyeQp1X?=
 =?us-ascii?Q?//cDj6HvAoVDpAfwHmi6w4U0EK4kfp2UGfPS9neX+ChT5tnU/HIY03vA4Qtn?=
 =?us-ascii?Q?YrWv4PkGafpx8PDLAFBC0lMPwE4DTHC8IWvagAShFYyBWbWFeuuFUeCNGAd6?=
 =?us-ascii?Q?bNW9u+G/545Y42n/UJWpCExHzO4eHQQLr7nfX+X9AqCOcREsXwpIaSTYblvq?=
 =?us-ascii?Q?rj/3tzJCeCmpCDwHXhREfHJEu/j38Q4GiBDuRhuaFK1McApP6+ZC5JcBnTPq?=
 =?us-ascii?Q?A7KZya8Wf0+D94Msol3AVq6Y17+2SP2ausk6+qxdLSbgdZiQ/rivbyiyV0B7?=
 =?us-ascii?Q?vqmeNg90cuU03IeS0wdads4sKCXfN4qbXDRYZxzWd7Brs9z57BxP/YutmDDG?=
 =?us-ascii?Q?bwAOmTWDuk8/QY91rgMYcLg2qt3vIXyJBw/ZjjPSHND3FGloRnqdyKdY9in0?=
 =?us-ascii?Q?cRGdkMcXLNU2gDrzxBQk9+p2nGIehwxk/6bdy1Uoh7VUYZJmdbUFW6mAc3Cf?=
 =?us-ascii?Q?v+aFI3G2ng94uAdrIt927foDwOtslGEr6IdEt4CDRYHFpV3f8sHpzZiurytu?=
 =?us-ascii?Q?NdqNcDT/LJoWcA5Z1DBTET8SUUnIXESz9LsqBsllP7RvItYQ6AxdPO6+50VU?=
 =?us-ascii?Q?QpQW96d6AsBL8QJFFEtA0bwBzXaZfO3mWu02ip26kgMo7lume9Fnsm9KQqbf?=
 =?us-ascii?Q?ZeLU6WKo1d8ja522Gw/A5h/773KVG/nlRsBEwilDPfPwEF2LImAc4RBFwpsZ?=
 =?us-ascii?Q?BW+mqllMUDZx0C7YBuai+V64c5oNDKejKmk6ehLuughXD98DJij+V0foUZnW?=
 =?us-ascii?Q?TnUVTwMVmTqXKx4IF8rHSvDNIxtL9FwouhmPeybAB3Y+gXLjQuYjCCm6riiP?=
 =?us-ascii?Q?1QT2F/iPaLBW8vSSM5XNoOGP3+3eJpGzuW+APfwGR536O0xj/u/mwwpxFKSB?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 528020e1-0745-423d-38b5-08dacbb6ca4c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 11:51:56.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdOVepAkzwtuUqxUXQFWC5jOL8kZfXye4P/ZOydpR7cQSWxANan2jVl9Ed9ifdWKRAAIPBZVF7wJHrcRv4JIIVcAAjPff0a0Wi88NLqZRak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6744
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 07:27:34PM +0800, Wang Yufen wrote:
> Fix to return a negative error code -EINVAL instead of 0.
> 
> Fixes: 0cec19c761e5 ("crypto: qat - add support for compression for 4xxx")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
