Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140CF6880F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjBBPD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBBPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:03:52 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B57729E3D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:03:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B151Y3Z3yWEAo8juSGTinWNbOzpm8PVXY915YS0fd8qsgu0ote95+wr/E+WkQ8kvgK7B6gkVSoqLvael2jk46NFZmKbJyJ4Nv9mlLOboPTtDZeEhic3QzMaGFSVJYLp/4EaepJyEyCWyEetrYqGnIZSdnkk1+mKCJ89pLUAI+l7tQBJrLkH+BGd+Td+fblZvkoffxsrDLDkR01EtPSnYu+ya4FnF1F9dO1b4DvfDwE6TOXdqy0AeUZMf0ZQsVIroNBBqEr1SUMztq0jZUgwW1AwPpjAoUgYwp6nKnPFZmq6WQEZBMeRfOzKbFWQXTtOnAD+JeAhMJwHf1241j+doSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHZ1nhynjaKBZWrhHav4HfcQA5Nc4rICHdeKtWXBO6M=;
 b=k2hXf394qUOvVpBkERsLh+GZhcRFVC7Kk81ANeAAaLYK565mXhN41rAJOIlmATTOtLGYvkXaChfdele3igxjilSyiZfFDfOtrZedGeGUeE8fPQ18br+mzXULO34xtKMAHcACknwvjcxfxMvC90++ymWW1W4z3t09rm/cVIN7503Oc6L6rkfMFCtahlEG4wcwq9GiM2R/9RxJlgm9CVu5727HFfsKIxQcDhTTEZQoAZF5Y7VEFaCQu2S286yZCYai0l41775v1olrEWxFNHtuBXM/GhEaVhUXW3zXr2cqRC4zOH+eBlg+hP13DKGPr7PcsP4atKEEd6N1VZkzESiHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHZ1nhynjaKBZWrhHav4HfcQA5Nc4rICHdeKtWXBO6M=;
 b=c31RTsvxP9tUGGoGAQGxhihbmCcOzELam3LsQMxr9g2+CIKuBp2O/F0+u15Mhajs3eTezv0/g8RkmQZxCBimsS2bA/KGIw1Znwkgx3z+D06ezC8QSJ90PKH39j7EqUNsopx2iRglk2n0v/1P+gbGOXAVi5pzSStjgjDuWIbg3xYWhrFbbFe1NdIbRG0PhMpZQTZfIfGY2xg5g6e5Z4JNrsh9W/mykRJQxAwcttCU4WVL82VqhXRxETu6D3QfJCSpCD0W16fhoHAJRcz4NrN4aVQXr3H33/6GqyitIARDIZ4Ka/V8P0BQ8JARhbkFECQH6VbtWS1hqTV877+EBbuhJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 15:03:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 15:03:09 +0000
Date:   Thu, 2 Feb 2023 11:03:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9vQrBi/cE0oXuc0@nvidia.com>
References: <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
 <Y9qK3nJHjU4Bvxaf@nvidia.com>
 <Y9qlb0SZWEpJs0v1@Asurada-Nvidia>
 <Y9qxdinaS6anoWhH@nvidia.com>
 <Y9q8llC0JVokHLf7@Asurada-Nvidia>
 <Y9rE6L8Nr0xShiKy@nvidia.com>
 <Y9rW01eROepZuMt3@Asurada-Nvidia>
 <Y9tmBW/wnZJ0JyBk@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9tmBW/wnZJ0JyBk@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 237ee8e3-d5bb-4243-1869-08db052e9908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbdk35VvKaZ86EYQYkaJHDQQH5NcNEoIx9XQqgDvADDdWrZjaTEWWFZBx47y8ZZM3mSYwfr51mUONXGE3aezk6qTWCkwtYjWdb88B25DN5lGN3xlPGK3ZkE2w+FW5qQKB3dvu1M9EDVKUvLjePt8QGNgXb5QHff/Z/1QIZZDlu5lei6Uh+A57CJADT+bs156f+Q+dYaIYb0vAn5n3veJKLh4JGfbX9tcbe2sH7LRT9w8lnoJX5H6CC5S4leS/R16Uf17A+09w4gtvkDR+SY2e2mrqAHra67G6hpxmQyrgYxvm+jvPISaswGJq5okisVunvj35YvKczMuOf0T6KRwim5CMnAtAZJzdf2jfB07/aksXhe31j2xJdMkm6HZGeI0ZAgMta7Lemy6vESEHIsLOLh2TYDFaFZjh+0chtS6ZCdqS8HeZ/3PWrCbjvYsUCHpyM3abMBVUZKl33oY8fcShB2WVYYD74S84aj2GFYG080Al+UDJTdCU0wrKHkA7sUb5lbHACsCuxpWw+akc6yHIB4PBNUNt8mvBthSixgs0bTsQ3PdJAqmgm3VEn4/RYPoj1TNwlzuHIjAuiSUs6sre2aJ8rgppfxQq8UBakgvaAlzlRWxrjrwC/f+bUkan32XHDVp79Mqil4Y75F1SjOgDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199018)(8936002)(6862004)(37006003)(316002)(6636002)(6506007)(86362001)(6486002)(38100700002)(2616005)(478600001)(6512007)(26005)(186003)(4744005)(5660300002)(36756003)(2906002)(83380400001)(8676002)(41300700001)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/JYYxEqv8lQioIDHlgkw8CjqyFOJ0iGYYp5JFk4cW4GsLAwKVysr9zDzNTgW?=
 =?us-ascii?Q?v0MY3nEu8Q7wIx0OZfftcISR1RnroiQF21/z826faXS+H9ZwZX/CLB+3+JkA?=
 =?us-ascii?Q?Dsj77JE1V4cbHDPkl/6w9JmKKgcRUe5aEN9l6nuy3wlvDIVN2JwQLp6JWmDT?=
 =?us-ascii?Q?VNKBq13qeGY2QqaadoeLHslWYeNkxNtHaBtmigXij+cQToz690++GonbjfaB?=
 =?us-ascii?Q?Fjb0zUe5CngxRbSxtnxsAF1t5gmuRjDbgHAcJJHIh26N31kqNKJcVrq+yNAx?=
 =?us-ascii?Q?/xUTL53sRVw8NUKxrxwMroywjTD7QoUwmVIutV2TFSIVahZBiJLx0lzhZQXv?=
 =?us-ascii?Q?Z6RUKh6HlSs6qjmk4YGnm8i/cCP+XwSFxHh6rVXuRk9h/B8DS6ZLA4dNfG1t?=
 =?us-ascii?Q?L6kU9+6J+AGnw1H62edCnNPJenFnrhE3EOlVA1GdvrKwZhhOeHfHztnhS22m?=
 =?us-ascii?Q?sX22XVZaNYoaPZjCqxhajr473NV51THi9Vzv9fc+G5CrGjleM3s66MKeJ0xG?=
 =?us-ascii?Q?AbX98feQaWGk5M6BFejpnzHDKlqUy4sPkAcGgePg2d6/waRmBx8pW1mz+Efo?=
 =?us-ascii?Q?wHITTTqlVsiknSWOB9bLpFSWiLB5l9oM79OboZZwTryE6UrjMVBgTCHWgIRp?=
 =?us-ascii?Q?DcuE/9XWyiUxwwEiBjTLGY5J3JDDIuuDMZ0BT/K9o/pYFmnmvvC8vgNeYHYX?=
 =?us-ascii?Q?CIqvKYwFBl7/Y0uKpFxO0SlOoTEQQ5+FQ+mdWG4BA2cTJiq59zJbJw+lGR/3?=
 =?us-ascii?Q?k+sdXMCF/FpIcIBy/SukkTeCwiv3dbP32A1huxl9U4G3SKNpZbnl4/kdFJ37?=
 =?us-ascii?Q?8pzRas2s7/3ZLm4ND5z3YkJqsTDZZ9//MYGu/KNtAs6C55M604nmn5464dyu?=
 =?us-ascii?Q?P6Ad7xEFDd4fST4PoW7SNhId+0cjDM5nJQXwYRJ+Zr6S9hoSO2gajWRW3gw6?=
 =?us-ascii?Q?c9II2lETLpVdE+f5Y0ak4Ly5ZR6eId69SymjxhPgWcsSXoHm/fs63DVtsF9n?=
 =?us-ascii?Q?wr9d2C7aomcZ7Te/tittEfXk3U2igU+bZuodJ4JroXnY8/RodHjBzSrOTy9l?=
 =?us-ascii?Q?FuZMCDOeAbccGhiKl2UMS+JND9xS3YP6WeBuyBnjGrHZgJxmWcSfHvcGGzaB?=
 =?us-ascii?Q?ABk27gA9r+ey5wlNLLUrmBxGuGJ2floqD59xIF9VAYsYc0pCtkkPnODXzNAI?=
 =?us-ascii?Q?yb475HkL3qTBU5iJ5gac9PN1rwEYOxn0DrBUfjZeSkv0fqST8fs2EJMURKUe?=
 =?us-ascii?Q?gpE+3MnTF4+Jdv0ZLbeXEmVTA8CSjLvY12OFrPOmkMLq5aCoTI15qUbHnbVT?=
 =?us-ascii?Q?NtoOzZ+4fop5bCQdSZbu3KrwLNVZVA7ncIBkDNjnS1l6+e4qo1SoD8NxzH2z?=
 =?us-ascii?Q?RPsprKLEB5/m2UTvVAQjgNJ5Q5lM0mbxae7gEyBXk7DYh0yJLrQEXfM9rXFo?=
 =?us-ascii?Q?+Q16kN8tSSp7+HCUXN9HHI1KW+VTFCD9ueDd7zzQve1fzTWxwEY/OwfFqWWU?=
 =?us-ascii?Q?+7cID4lO1cIVuydRmPpM9ElxrLCrCIVcJ1toDdTN8+ByTRwPUKtETf8pp3La?=
 =?us-ascii?Q?qufEntv0MX7wXsRK6euTWwaVzpzEE43WupQcyKYn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237ee8e3-d5bb-4243-1869-08db052e9908
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 15:03:09.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydjk0E2dJaC9g4Umi6xUoa+mUeyxT89cOu6d/5SBF6NUQ1eGPyj0+FOwN1oG0vrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:28:05PM -0800, Nicolin Chen wrote:

> So, in short, we'll have to wait for ->domain_alloc_user()
> patch (in the nesting series) to unblock the problem that we
> discussed above regarding the iopt_table_add_domain().

I think that is probably OK

It would be good to prepare a SMMUv3 patch assuming Robin's stuff
lands to move the domain iopt determination to allocate so we are
ready.

Jason
