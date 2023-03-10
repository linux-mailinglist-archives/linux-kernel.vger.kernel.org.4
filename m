Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2636B3FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCJMvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCJMvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:51:47 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243C10A2AB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:51:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZJ8hzvK2n4wnE0rVFk0QPM1aOrvf0wi0bcdTOQA0vTPj2fVp7ZQkHbVJXLLXr+hYFM5JpgjmbSak5QYEP9XxrFiqobFwPPjHDpXyIFL6hsh8ZcMf+IhZzrdGUZYwKOy4wCEA1lpQq4OFLZDMwk6BwlmIgDXZjmKHlLAj5pW5pp6KGMCf27zatjufUDindXpgA1393ZV5B9cZPkz3Xfp75FwoaMQDgMZqxu4JqwLPAw5QnKGQ/sL/E+1k9MWF7Jbm7PVomUjVNiPGMeB179B/2myVe0ZeXPfT/aIKW2wkdeOL7IhHLXJzn3GvkA1gcbyKuyZF49uENbBgfAUD0ghSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhSzMXdxLMDTnQUAlXjspIWQXT6gF3ZAph1C2HBi1bE=;
 b=eMPgKFjqh+DOt889rEAA5c5t4bVOU0o0LIpHhy1qu823VueenoU3KN/jQmF6x0xirxBUJGbWWYV473km0sPvqw+1O1CEpyxuZw1ZvhLnNIBCTl8cAQoRgq3UQSWy2xG6yAkx5AlX8XL0mHqeVlBJToYUtn54THUSNkX6ikgsEeGRjCXRKPSsHh14ROp3ZfA01L41JhPX9DuOp5GQImgyaTqK6PIrVFcoVeFLm1qsyI7TWZJfUYXS35iw2jPy0CItP1guZcMU0pevIDK03SvDgHX2YJonZYH7jkWGpdTv884ALfVBhdc1D+BtYsAhSa8BhnRic0iDKJFWea7102ISmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhSzMXdxLMDTnQUAlXjspIWQXT6gF3ZAph1C2HBi1bE=;
 b=oTGmZxCaPt5dERMGAnJmjdbqbPQuQEdiiQJf+u2NkHixMmyi47WL4piakY6d0UBk2+HrT0D3A6svla2xryoS0RQr6sKJv/Ou3aLULLEFd4xYQfpJQIvhiKJqe2jCntZxspq85LXr+hqq3xWYqxOdR6U514ul5i3Zq7a+6xFu4UdoWl0NPdERh1cU2IXshDtVGczLsyPGa4vZXPEU8m6ehczQqptMco6oqS9+cO0vIPXmgX4MqByug32oKpv6sMn67UXh5R2wIbIkYBBUTDMmX9rnkzwaTpLwodLoIXG1ktbhMoqbAnn4vnDhFPgDOIQdHKzOaKaZw3Mq1TDvrXe3XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 12:51:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 12:51:40 +0000
Date:   Fri, 10 Mar 2023 08:51:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
        will@kernel.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAsn2EkRnEmsfmmp@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <5288c0e9-b806-370d-e7de-8d69d5b8e902@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5288c0e9-b806-370d-e7de-8d69d5b8e902@redhat.com>
X-ClientProxiedBy: BYAPR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:40::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d75219-ab39-41bf-bca0-08db21663125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGyYtQwWwxF4HCT3LpjijUv/Bsyp6b03jmEYAN6x9aCJ0SlDsKcnLvXSwJcwHRNK/vwmerGLx5eaYz6qd5AcQUDQs8kH2cmnU3B3HitwSZvGpqVD28p8YhKTKbyXfdjh8X5Z1mDEFo+/EqdGHP8bekcQaP7kR31n+uEXv3fwWfp7q9edUVEDgab9iLrheoBZvymfW7MxK/TASfEJ/TZ2Luy4unNjfMCZhZEahmzGWqmsJ93EfIgVv/G56Ggt/qbm2hoZZPiWppA+eNmsjBrLQ1qetIi4Exv7jG4LULU8OQAgF7WO7XdvMGYq9BEUOkvjCIGakwHO/+wjjVd4diT19C8ZmVs5CE8boVYdS5tazThcWvzvbXuXvWXxcTXaeM2WT0L/NUK7DPdhHnRvq6PgbdXxRFG4vcRuPOifIhst/xM8Y9D8IkyjI+ZeUrWUiLX9n8JDWnMCRphJwHfDdgsp83Uph9++PtVVSGyzNNQQqpAsUajOGK76IwjIj9Xm1UIic8UB0Y5nFETbJ6z4s6xcKoNvJduy3tHZkabW2U/q42ED1CmUnyLrPsCEjypALfn91hbL9KOcjqtWWp7/IWWg4kPChmuMUVmiKmGUstrX63p4hQr7WGiI3Bj+hFBbXIPvCKuWQR26pZ5EbOcA9fVcuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(2616005)(54906003)(6486002)(478600001)(6666004)(26005)(6512007)(6506007)(186003)(83380400001)(86362001)(38100700002)(2906002)(66556008)(36756003)(41300700001)(5660300002)(8936002)(8676002)(4326008)(66946007)(66476007)(7416002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EoyXA5Zrgh8FC0YBzy6Rx+GX7zhcK7OC7GoFc5vhk0JHLCtuxUpOG3epxvr?=
 =?us-ascii?Q?ZjiZzLYsVcqTZanbDlQxJJkJhW6mdmEneB7cF6NynJ9LvnIhEckrhQXFd5Xp?=
 =?us-ascii?Q?hOLnek7445tZv0InTs5lVcHC9BUZmPVj6sU3ik3wqCeORA+Rv9Up51cyQxHf?=
 =?us-ascii?Q?qBuLnlv/y+4Cg+tq8tsnxHvTLcERcYDwMWPpzEGqh4ioPm43yrBfCG/5zxR7?=
 =?us-ascii?Q?eBeUNvg7VVUFvBZXvHQaABcMjtdva3iR8mlBl7sG67RBshetFQxPUiI35iOd?=
 =?us-ascii?Q?kgt+4o+Umrnv6FcYcW56IVdS5STtWgnbZlzExGMiJaJRdFdF4tDwICFzD2Rh?=
 =?us-ascii?Q?ghxgMrUPJaF4H/X/CXj/5iwRrLDixQHR/CM/cA/RXb/Wj0PVm1xWzg4hVtTx?=
 =?us-ascii?Q?Wu39eaONlp8lJgbgG2hlv4GANaM6enEoY4gM3YBJH6kDVhIcQ+UE2w529y91?=
 =?us-ascii?Q?6FbNBwKjCz/MWVbYTEqzkH0yz9uOW0l2bZ3kmNZKAY8fihMqHjb6I5KvzIih?=
 =?us-ascii?Q?ZIDlTZxxPrlimPxtgBqk9Ov9gEK1cZA+IoI5d26KTBiqXI5Xri1/ln8QGFWv?=
 =?us-ascii?Q?3XgXBsh4kM6B05CbnNtSPLtuJurZ4gcLjlCuOU+iGZwaCkTtHNaSktwUYQDp?=
 =?us-ascii?Q?FYH3yJq1Ccp+5RgrSADZVDR1akzXiu//KlhuUCeqECdfZhyrB7Y3bt0LaJgz?=
 =?us-ascii?Q?CDjp540RYEKTNOedq9pWZTiwG/sBnAy517+wQ4q8mxDujLjFeZLP65bga6aW?=
 =?us-ascii?Q?pBsJaOHEVqq5JXH2cnqQIMC4rbp403s8ipVt+RXUEOm8fHhakGft4zeyMMTN?=
 =?us-ascii?Q?1vQHkKzbgLe24qU8MnG+KIaG/JewsKqTBEA49XdARiZO7kBf4+FCz5P1JOEJ?=
 =?us-ascii?Q?AGuZ0mimgTSva0sQZbkiBWcvlFbPcjOZbc09DAnLIot7t/OxUXY0jHI57LWM?=
 =?us-ascii?Q?HIcMWnqnY0n8rUV6G9a4NrxuK1eZhYXdjixl3SBD+UlI4vERPQK++u8fbVjX?=
 =?us-ascii?Q?P9RRQ2gLw+vzvQ8JenDHE5Qe1M0KZpTWwvpxbqEu0ai3aWEu2DXF+Kt1yuxs?=
 =?us-ascii?Q?AzL8uVXLdjJUsstttdNKEZ6zmZimLK2teYz7uHdBtsFpoePr5DyOp/Wh556u?=
 =?us-ascii?Q?PxGtTEnSuYOui3wvfMMWXMfmdGdrIExYtSQFaJWQBnGc6X719S2zP7CfCjp4?=
 =?us-ascii?Q?MOUHB/UirmMofYZOBS7f10/Ldr2AfAMHo+IUv9U/Mr0psoKsqlBPsS26ZggW?=
 =?us-ascii?Q?qvHYPH72wjKpfu/wTN3uadLvI+te18GWP72oHseLbKI0rf8aj0qHsr9zB6ex?=
 =?us-ascii?Q?bNqgPNn6b1sOdL82zz+KsO/y4THeW0BzeGCi+yv6j7SmWQ6FVBxKKroC+WIV?=
 =?us-ascii?Q?a/Ihrkr9LWOnXsGduRwsqyVgRnI9SqPGbOvEBP8P7UNHwHRYGsKpeZiFTEvi?=
 =?us-ascii?Q?PKQevYTqJFoGgTLN/MEIL3WmQpSCh9E86t+6rTJTVyKXhKyMO2xX98xg9093?=
 =?us-ascii?Q?gs3/Yom3I9Euny1fkXdCxaSK+BQ5JjBVFvh25u8JLTWr+izLX3+HB2P/y/tg?=
 =?us-ascii?Q?xPT2M6oy8R9jS4kFqGevLtlS1+u3WOzEPU3GHDD7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d75219-ab39-41bf-bca0-08db21663125
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 12:51:39.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SU30dnhpkPAELU7ijO2FnJyLKh8qNDG/x97WOPkt4UKhksqVjKzKTpBLWzjKVFej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:33:12PM +0100, Eric Auger wrote:

> I do agree with Jean. We spent a lot of efforts all together to define
> this generic invalidation API and if there is compelling reason that
> prevents from using it, we should try to reuse it.

That's the compelling reason in a nutshell right there.

Alot of time was invested to create something that might be
general. We still don't know if it is well defined and general. Even
more time is going to be required on it before it could go forward. In
future more time will be needed for every future HW to try and fit
into it. We don't even know if it will scale to future HW. Nobody has
even checked what today's POWER and S390 HW need.

vs, this stuff was made in a few days. We know it is correct as a uAPI
since it mirrors the HW and we know it is scalable to different HW
schemes if they come up.

So I don't see a good reason to take a risk on a "general" uAPI. If we
make this wrong it could seriously damage the main goal of iommufd -
to build accelerated vIOMMU models.

Especially since the motivating reason in this thread - use it for
virtio-iommu - doesn't even want to use it as a uAPI!

If we get a vhost-virtio then we can decide what to do in-kernel and
maybe this general API returns as an in-kernel API, I dont know, we
need to see what it is this thing ends up looking like.

Jason
