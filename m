Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7AD735C37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjFSQdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjFSQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:33:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5EE60
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4qBU8D+a8cmKtqvg0W4Kq2IoKeR7qc5uqHpfBYr3KBrYmboUbrn72bMISDOXCwi0fTwlLterTYltxlYbhSPu9uGt4T7QDbNBQe5FKSAUxZjKvYx6cW4/aZDh9GGWAvBw9aOMu9gW524DU5UJM6lbcrM3hKZdVxRkZzs8hrcYaG/mdMiBiyVvlv73G6CveEUgZrIr+o7A+SD9LvjUD5bfkZvc8Kci822x3GeJjqXpDNFS0LkwKAEgmxFsyCc2RFn3cmpZ72PttZVCk5Of1jm7DSi/DYSg1napOmFUM1tvB802JARIX8pbd1vCWCJkLxq3o3LBnVwr7F4bgketsFCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVjCL4ZS4XI8RYD0mw1yXqErj83GV7QerrtD5v9whfc=;
 b=Vb+4OPcL9quGodiOXhPVgX1m0MSFLc5N449EfGNqraLMcGPAh70CpG5zUSi1xbTUXXUHPm2UGxFOlgT3fjIGmcNaf+GQXIEeOhCtH6I1fWk/ch7/GLr4S2ArAEpL9RnFvqxih+QviUMU3V1E79y0vBC27WsS7EO6yqyQdhhX3+xsaywgLr7A81/cGJgofMgZeaIvDcXD0a/M5xg5Au0ySj4ySe3XxAO19tpfjmdlDqKeBqYIaeKJ8tLHOGF4TDBn6IpkI4RSEAZLhmEXKhavJHBsdkISOB5h3/BTJxH61jaosBwFtWU7AXBiGkPPxT1rWbrkX8B9CQCJQ+jdqravHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVjCL4ZS4XI8RYD0mw1yXqErj83GV7QerrtD5v9whfc=;
 b=C3qqRphmHTG3TBudZKn9irAgp0bRVGGkNIwTYjV8tOllACVkvU+aDlTUzDqbgo2puJacMFRJuHwFGeN65Xgk8lNzI9VaLO81YEeCT5kDwUWOOATWWM3AvWvngjNUWHcrD6MlinhtHqVbSurUNj/CiMFtCRf1y7hl4XKdj5p5WE/K+qAzrrehBJHo1NtkcCtWcpu/k8Xg1oJciiqVI4LiF0Q49tXAtgRkh11XoDAV86vLMxIYU/iCDyhukqiW/gTXOAYpg9CxRl/vxIzJDF5adk1k3QAwdC0E/zttQCkrz7FHxR87Jbm/e//lhCYNjmMIQNQXssEDpI854XPR3YKZ1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 16:33:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 16:33:41 +0000
Date:   Mon, 19 Jun 2023 13:33:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     syzbot <syzbot+94646b0ed2dcbb1f9c2f@syzkaller.appspotmail.com>
Cc:     iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_test
Message-ID: <ZJCDZEdL82Wal1XP@nvidia.com>
References: <0000000000000cd0fb05faa4d351@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000cd0fb05faa4d351@google.com>
X-ClientProxiedBy: YT4PR01CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a4f113-c46e-4346-34d7-08db70e2f143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xazCedXkuSjvM9inj8XXLWY3mO2vsAoVf5CtJA1cphY/OGAkYCUh+N/O/zbCs+RMICQylC6oJB9NKzhXZPMNBGliSMPVPxfiMlqtC/cwwBiWyDbK0jP9pJ2MuVJK5fE1a2lnShR7f0tv1zSnn+Rvx2jgUXNZIPiFuflf23Hu9cq8Nf+4+imKN75rR68gHvvTWtPAKpbVKCRv33esn1Vb+vplk32Rd4r7ergVwnea0ZHAmYqJaZgmkDDHy2SwFZHMs8YM7Gwv0Z7qOiSgIZTm0QbYLJtkan6Ve3i39s9JeeOdpP8Wo7VUsx6ENzw2pHuwfaHK3N7T1J1Ggg9/CYRh4nCn1K9jFeM2GeO+OI8ixwVrzLl8P5CND2L+mdoUgX8ltbKyN0m4WxxFMrdr7kO90m7jBVXLk2NKC9X9H4UOA6eEHbNo/59PWyCkZCMzujx4STKVFZLz9xvMp/WkflbKFMYp8riZFYVbOKS/BiUSEYGr3T/AkUdWO5oQ+niuf5nza7R/83OnD5MWN3IarQzezuujK8Kj6h5va/z9GJ+rt8wos2bYLsISbpoocv/mJTCid3Ts9UZpFbvXfxvxlOCE5Tdj2vBinpkR5hNtHKSstZKVWHMfu8PvssIPKfSGjt6zhi56+F1OvFrg0VqgV1exyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(966005)(478600001)(2906002)(6486002)(38100700002)(316002)(83380400001)(5660300002)(41300700001)(66946007)(66476007)(66556008)(6506007)(6512007)(36756003)(26005)(86362001)(2616005)(8676002)(8936002)(186003)(4326008)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gv71zfAm/uaWhWQDN4Sr3d+akp/f0Kb3tYKQIX6r/NqbglWC38cjSY3oyvLf?=
 =?us-ascii?Q?vKT3tN/Bi1jaV1tHc11PAyGVj9/bdQ/Z3lcXgZQ++Jz1x5aQLxW8rl7TiaBl?=
 =?us-ascii?Q?UDLeMipV4IwvJkLieiAO1ktT+m+iCpUrXi5cERpw/pZQmEWJ6oHljHVenEHN?=
 =?us-ascii?Q?oju90PCa+ISDoAiDg9Av+ckQx7GbK6PHoZqE0UyVF7sT7DaeYeEMSEA3/j9O?=
 =?us-ascii?Q?5OwAAmXNCQy1H7sr6YWB07a+GkDrRn4jGqtAslweq25Z8M0Fx8nw4FC8b5AZ?=
 =?us-ascii?Q?vqU3dHqS6eCudbjOnYlReixdcjil9QIp2nbNsgweAITwFoaZT1+4bFOZWlGj?=
 =?us-ascii?Q?yeSUiCoQoxvgx013zNM1Ei1l4Pb+bkhn4ko8sTMAO2/Aa6pB4h14krdOWuzi?=
 =?us-ascii?Q?CRth7EG43wfMIdglfIjWI8AYqtVeWYm1vyJ9uo46+DoTLmBPhcY5RuesY/Uc?=
 =?us-ascii?Q?AnemCl3puiVS/OQ2ieZLAB95TOgu7M27XiRn6TaWaU8pQNj7gcCwWUbtfX4Y?=
 =?us-ascii?Q?3vp6rOFM8+0gljKcPyqg/s2AkSlx8mThsqF+R8BlgfFoyEtIxBVR/6JrLFcP?=
 =?us-ascii?Q?cZ/9KNsbyLPUefahN3Wkx/XChFy30lOntkprnl4obion7D92a6FhMsiUMYy0?=
 =?us-ascii?Q?hnJ50zPecQCHJ6NIKCyDn1NF4mCgSnk3GJvQpd3G2+36Xlfnph7DUF2XwgdS?=
 =?us-ascii?Q?YX/5nai3WOs+MOvdbYLvVs8KZitxvRia7Vh71Zp67AUbynED5VqUWt69ZDjO?=
 =?us-ascii?Q?qyCVyiA9Kys3Lqde1xxL33V4YuRMZQK+++l4OgbaGFzGfuQxRVcTOY2mZhLz?=
 =?us-ascii?Q?fTpe09BKkdw2LnqOpiBu6C2ukjd8YnudkMWj7GxLOQ7kwImf7hoL4filyYpb?=
 =?us-ascii?Q?/Y0b29dzs6BkEJNQP3Uzt+qxDuRHVPO01WiXRnQI4cr2l5Ctx1KI9QimhRWt?=
 =?us-ascii?Q?LTvzKN2OR2fgSAV1qHgIzrisVfvLhDDbxYVKDB8C3WRPFIHiaHxVRIcwzOFZ?=
 =?us-ascii?Q?WLziEOYBePb5WgnfN1Ve0U2Y7NmXUQKXThCLqAXgwG3YPrYwz3IIn7+FJa6a?=
 =?us-ascii?Q?DSjdydcl0bBGxr1Hjzv5jl0+u0v20cdb82sBxwOmaMvTfXKQihBdBDs5BveB?=
 =?us-ascii?Q?oWIIPxUMBJybQsxJ55JwYGy4RSIBeHIFFCQDMFI8E6gilTW6RQZmMdiyzZ5X?=
 =?us-ascii?Q?eOZKWB0hE5aZTeWOi5qpDLaT2tU5bdCVByZ+BBg3AxXpdp+3vWEfQLMMZQNe?=
 =?us-ascii?Q?nA1p0injVlKlkkUtHpMIk2RvlNLBv3ci4kBT9kjK4s5R9APl9lENbwDjVsY5?=
 =?us-ascii?Q?WgNoc7qKDWQ7dWHHh7gg04R7vWKXTKcnt99UWaBK14Jt+c8xtB5YlVBqkmUw?=
 =?us-ascii?Q?LEJzGKMnJX/jRskfxCujLWYzx6Cltq82ld18IbOK6tt1zZr7eHYotia9tYGC?=
 =?us-ascii?Q?uKwElO//81P1U7f65+cS9yKYoPbLVMEzwRC1nmzrq9p6/qbXBrXBeFLnLPO7?=
 =?us-ascii?Q?pbMda0W+S6ha2W5vOpadgVKLkrRk1CFJ4vcayKzaXMiTOm7hkkXHA2nT1t6i?=
 =?us-ascii?Q?ZBtfvgIGaRoM9vBDJtGS3yvG7GfIrBNT6XXf3Ka4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a4f113-c46e-4346-34d7-08db70e2f143
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 16:33:41.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4KS21zwhgw1x7tl6pfKHOrjaPhlCMEKPTjcTac+Ox42JsqzfNM80ndzFi8gbioG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 10:05:05AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=171c01f8280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d56ffc213bf6bf4a
> dashboard link: https://syzkaller.appspot.com/bug?extid=94646b0ed2dcbb1f9c2f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16310d5fc80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168c5330280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/51c43e265c8a/disk-58390c8c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7c64f4eeaf4d/vmlinux-58390c8c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e5d8f49c4804/bzImage-58390c8c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+94646b0ed2dcbb1f9c2f@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5005 at drivers/iommu/iommufd/selftest.c:762 iommufd_test_check_pages drivers/iommu/iommufd/selftest.c:762 [inline]
> WARNING: CPU: 1 PID: 5005 at drivers/iommu/iommufd/selftest.c:762 iommufd_test_access_pages drivers/iommu/iommufd/selftest.c:831 [inline]
> WARNING: CPU: 1 PID: 5005 at drivers/iommu/iommufd/selftest.c:762 iommufd_test+0x1bed/0x2c20 drivers/iommu/iommufd/selftest.c:964

#syz dup: WARNING in iommufd_test_check_pages

