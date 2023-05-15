Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7103702D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjEOM4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbjEOM4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:56:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9442D41
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFN2pmYRMZ6YmfT6gj4PtV9nTYJeC2dlmPUrcBf1KAumqWqAcOeaHI1dddq3XNG9acj0pbdkeH5o6EJTEh8+wKDuPfCuQoyZOsB0pXh5cOCOxN1fBWYtWddJn46rJ6ZGpMXx3EB44dK6iXd7p3irXa0iSfOP2LSwgPbQyKOI1VFhjtHHVsvcTTLmIz3lSI7KVPhrT4y1mCwx6MCEOkw6zKKz36S4P3IDXwADvi0o3tsygXMkIZ8DDyvj71n4uN3Ccgv5KuMfb572c+ZH2Gl9ez9WTOOIRgrc6RepzR1r9ZZYm6Zb8/nYNL945Zs6AYBuMUEziGihxQ8DPLkC1NV8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAQ6hJD2ue2TDUdTIdkLsVV2C0BW+YKhHRhR3Lbd6wg=;
 b=hzbI/oGKKXgQgMeEyWXwd3S48Q07LyqjHzTleoe3Qc+vAnvKwk4CZG/V899aw+Kj0UFJ6GDtA0IHHfsi3pKVRmhg6rMhRVpax2PjLCDKZfbz7nrNLOfHtaNPEBrXgHtBkQj6hufBpozSjka/MSSak6BIsjoVAt/JB3+aNu3IN9ZAnxaIfWe/jU1JdWoyRFFuqZN3iqzAtNahxpfTuW+RmyNB/oE8T4uIwprGOJfPTb0Bav7ksRWjFjnf+87EZkR76j0wWceiSxy2VrKo6ucP+1+fNlP7y2VLWzNC65Sn8wr8tkQm/GqE5nKuEcCzXXTgxu85CCM1VF7Jvn4/WzSxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAQ6hJD2ue2TDUdTIdkLsVV2C0BW+YKhHRhR3Lbd6wg=;
 b=ACkSP4cGQzHkqAh+QHZpGgOn+vqkTlDltepq8INW7yxTOzXfmKV2OwPRrbyk0bl2yOelyJQJ9heshOGWjs1ScR/h2l/G430LaQImTyrDojCFKeRhwhrHVsmVWjgZaHm/CNf4kpGo24rgYChENvZdSylVUlZ5i6l0xA9fS7BGNxa1LTYRJaKvuW1CY34PWbRc5rBksnnCjRt05+Ch1viFLpeFNjmceKQ70eLTJgEEmwJrMWadHs6YsKlJS99Uwi3y8CBpcIazjj0JYkZkTO704ynpiONTnAFea13TsLbzlJC6Hz+91Q/1AdjY51u9IWTrXxTH8QjqstDxQF0NNSmXBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.27; Mon, 15 May
 2023 12:55:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 12:55:45 +0000
Date:   Mon, 15 May 2023 09:55:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     syzbot <syzbot+lista4d5b2a08cb285b4a0cf@syzkaller.appspotmail.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly iommu report (May 2023)
Message-ID: <ZGIr0HTkiKJfJno/@nvidia.com>
References: <000000000000fad0cc05fb34e6be@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fad0cc05fb34e6be@google.com>
X-ClientProxiedBy: BLAPR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:208:32d::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: c611765a-119f-4fa3-3e6a-08db5543b2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmxgaMZHuEvRcm6UrspNewJicv0PxSvKPSSSBOXGLAWmjHFw8QLYqQElEh9JNezDhnJt3oKLZSN1SKpC/Bi1DoPOKCMmij6fyShNrHoD7SBkVne84fE79C+n06ThLc/C+SoSf9VObnTVUYyGKvQnrLm13ZMjIjyEYpxVlNDq5Q3k0jiu2E3AEWYBAchbWSXwWprcSGnqj9h3eJN/6sEpK5NTpvZzOcL+YOD7rVcodu7O5gaxBlpbzpeOyqYYpcwII7XdjQNKskPQd2ygCmqi/+WSkEQub/JAotMo9tCBPLiTwqhHx+3BwihVcFqc3M9vrr39EgHdrRrb+SP2HcEKfQXPYP1imOlNZrdxie7zS5ue3kru6RcO+5Q2jTlvTZVXf0XkkWA1iYKKGCXqfXN7FHuv8eUfdIX9uO2CpakiPYtee3UGdQ64vFFb8hkBjQVOYEmsqJP9GufgZ5K8KKLEhpxAR+u5eUsB+C4HchHzXmo1Lw15+7RJzQAEcU42lZIy+c/NjmxF3U7v1onxlsdcfSkYexLXen3QzAC9MWPE3OYnh2AIW0BrQSWQ+SN+izUjo9s31lVDFxe8mJykaUg1ws3fJ2zHSKlMcdJU1vDsf3Hkyyz2JgmK0h9+SI9KyYZX4i4jbL2sjQnau9HJ0m6aSfKocP7Sc+WbKP4nLwaeAu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199021)(66556008)(4326008)(66476007)(966005)(66946007)(6486002)(478600001)(316002)(86362001)(36756003)(83380400001)(26005)(2616005)(6506007)(6512007)(186003)(8936002)(5660300002)(4744005)(8676002)(2906002)(41300700001)(38100700002)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JTh18ZiTdFIMDfmHBvqOqQzt0SlmybdBgrMvZr0PZJgbjhmHPjuh6fdw1HNP?=
 =?us-ascii?Q?frIDRfC2gvS95oSDhWh92mZE3NKpP58nl9jZj4wkr8GGX10Bf0mxco8bl7OG?=
 =?us-ascii?Q?UvqtQl6XG0UuRETPVatx7nvOsd+aqwkfYaO25mqdxC1m/l3ZttXwxZoHbh4C?=
 =?us-ascii?Q?aw7kqOfF/kUcHBw2knXtZ3BmHGZg+m6v3u0qR3tZ5u8rmNW0umDAMku0f22N?=
 =?us-ascii?Q?EGVjsDcDh4vSYOxqE3HYc6h9oVT6uJVeTThAuvDlCzLXou1YIuullJppMArK?=
 =?us-ascii?Q?IqSmfnic180bW2SbkKVEpMBHBITLU/M1WKHoTNiInVgZ0/adGrpX8SgC75Oy?=
 =?us-ascii?Q?SP4i3jEqQe63v5JwxWpAks5jyKgg4S+BSOselq+2AhAIHrLSiQhm5gX6URND?=
 =?us-ascii?Q?E99fDMKBwY/xmn/QclmByzKobUwv/XQXU7wSHa0CW3L+2YEDS+7TjXytoxLz?=
 =?us-ascii?Q?qqZcqAZOSjDN38Hpe985YvBjPjcbQpQi1fER+b2vviJ9YlmF7+hwyAltTsW9?=
 =?us-ascii?Q?qM9jGl5gOB5Ic+e4DWXRgqInnDJooYPE1XQYt94f0sxqPKC5wDspNA881QXP?=
 =?us-ascii?Q?GYzDiBmRLU5KaU6D11jNymD0JOh3NUcKSrmB7398u9EKsNhR68J6RLwDf9WB?=
 =?us-ascii?Q?grsSzKwnjpaEmLWTZJNc3Pp2w62D3IXQzyH8v9eLt3MT4wQfrthm/u1XUarQ?=
 =?us-ascii?Q?EiWoeYElgmIyngJ7wJakZEAHfATss7PhWTYN0zUg843FLmSdNLsbpkzWWfdm?=
 =?us-ascii?Q?kibjl/GHVQ/zKTy8HqxUeUfHbGSlLAo5pHeME2c8FXyRmNpxMxGTFAvy6tXj?=
 =?us-ascii?Q?59W5TQ/4ZLjoGf/LR2X09pYzw0aUEb/LOPLeO01TvsdnUomlsffOctB5F1q2?=
 =?us-ascii?Q?dUCYIwJnqJVAIFGjLowqoknfOIeps38zzupaO1W0LBwy6zkGhN98T0hZPq8l?=
 =?us-ascii?Q?bn4ueQEokAsgPVh01uGRhOF2WM0tGiA01xwNbqeBvuMEPG2bqHkDk/txPkx+?=
 =?us-ascii?Q?gnjIIEl0rHcMnBC+1zUyYtkCtlQR7L6e4ObyCAkZn5J9dx5N246ZHXlNTmS7?=
 =?us-ascii?Q?arbkoBVBsWENL17U97+R2hsGRSlVHT+c0cGzDrkMJNeYyIokSH6Hflo7rD2x?=
 =?us-ascii?Q?Ne+80aZr54ch8Zg0uXpE5osCZ8/bc/DzyvxsKJraqAx+Kz9PlJbgj3SCQyfe?=
 =?us-ascii?Q?ZU4iEq7qI4P8a2BgyAtPjnkoR2d0FQcRP3nO0rHtAxSqagiDQiz+snDj9/6S?=
 =?us-ascii?Q?1idfPUGUlotYGGeien5701pJbQUuNsJqcMWlVLA+n4St+ZyJhhC9lyE+9Gzy?=
 =?us-ascii?Q?GS5MCojEr1/vKMlO8rCzwEJwFm3m0scRBHJY+IrsIySu1j8tJGRV/fT2Ou1j?=
 =?us-ascii?Q?R1TVxL8sRbtaMWpRHJfUUGAGb7JZtDievt3xKC1GiotMNXeYjWyngqjeCfFk?=
 =?us-ascii?Q?quL5moCeI8KRfxgruZ9UB9nWNpGWpkCHKdXJelBt53oTxypCaHgVGt34ZYzU?=
 =?us-ascii?Q?jHsBRXp0+9sO9A7BV4xZ/tonMp5E6d61uCe4PSYkUXVETcwjyttTGZuNh/V4?=
 =?us-ascii?Q?Zw1euNA+cYMQNtRDPAF5KQKFbxoHwjxoxJrcktRY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c611765a-119f-4fa3-3e6a-08db5543b2d2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 12:55:45.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0RtdiH/WPrPAdfAlOfXup4pbeWM7Vd64Wx3VSwgSnzqV1boUjeoQLi7BnF070fK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 01:58:35PM -0700, syzbot wrote:
> Hello iommu maintainers/developers,
> 
> This is a 31-day syzbot report for the iommu subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/iommu
> 
> During the period, 2 new issues were detected and 0 were fixed.
> In total, 3 issues are still open and 3 have been fixed so far.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 67      Yes   WARNING in iommufd_hw_pagetable_detach
>                   https://syzkaller.appspot.com/bug?extid=3b81771e32dd5b2f9931
> <2> 2       Yes   WARNING in iommufd_test_check_pages
>                   https://syzkaller.appspot.com/bug?extid=353c7be4964c6253f24a
> <3> 1       Yes   WARNING in iommufd_test
>                   https://syzkaller.appspot.com/bug?extid=94646b0ed2dcbb1f9c2f

These were all found and fixed before syzbot got to them, v6.4-rc1 has
everything.

Jason
