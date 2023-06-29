Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5C742909
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjF2PCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:02:37 -0400
Received: from mail-dm3nam02on2068.outbound.protection.outlook.com ([40.107.95.68]:13297
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230353AbjF2PCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:02:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVgR/mE5L/1RTZrPLS7OBr+FfdTpUM5ljoLWc82i/hGaQO+GfuOV+Ik/T7ydiJZyll9ArX9d5I2xJnhxWxv7W2UQe4XjW/nPkt/CBVFWdhVMYAwMBaJlW9c9djrlOoOQm6h8+MDkvHWW3oWog39nROQCtS9JbVGpudx6P3PufbjBjp+cV0t3Ibl76YJAY85qrVk/Gu0U/MnVFcqy39sKSAnScLX+2uPnP/TJumph8yDAuRt5PC/6Ijfx4ho9UawSm6J1u2IJWPIs5XW29IBjDWFdyiRzn1ZJd6lxn/PQ+s2Mn3BnUt5hxyfqtByOm9BadrfQoHPvrlVGTv64UDsPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBnuqZyB3arxQIr4T8j1Kvb+OYCEAsmUMkPM8DWdDFE=;
 b=E/M7cg++ssJdwh8BMc46j7bwewnGq9Bk9D7tS1CAvkonb7d5IZk0LLg2ogOQqYZZ+L30gyYy0yr3ut94gxuNfcd73w2vqlWNanmvbxlBsFsDXxrn8footfp7Av4GZbsdxM7FKlKTe8RMrVCNBJhfqWKPQnLx1OF1Yj/DhP6zLnD2NB7OoZtehjpcZMHqau/irjsS1pz9LqmREkdzCOPtYr2xx/7Z+0pVPT2pAzdHkF5zPJZ8ZFa9yl4kVKb8AhX3XOby2GXzAfSz5Hgd3WcsKK0h598lTJ5nZbWZ09is/1yz8nqdvm8G9/2cymTVpjhTO7nIqwS711+HP9snuBunDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBnuqZyB3arxQIr4T8j1Kvb+OYCEAsmUMkPM8DWdDFE=;
 b=kvEBtvbF9vRN8tEAUACjFwygkg0H3ckicTV0K9QptY4vaQ/6ku9FQ4v6U8PhDto4qy5/JK0i909/rGH5icq9qDvYozvUQjXL9HzOWWcnunbiEt/ZYZal8EMbawJ/N/EcUWPrGuXVo555CuPIbk1r8B1oNu4St2uy5ClXhZ/7umwYW2CZ0KNWHd0iPkEqiFTH3l07fbHeN9sOALc6+Z6PCuqGl6C2a5sd85OISW7MSljf6yeojd6gWEIU4qILWwDH0eCwpr/3bzu2514pKfM0HoOeMpgY586nw79uEc/wJfvs3piOMbSHoN9lm7rzRQSRXAdF2uiKm7BgAjpgGETtdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 15:02:32 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::4651:eac6:ec70:dc3d]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::4651:eac6:ec70:dc3d%4]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 15:02:32 +0000
From:   Aurelien Aptel <aaptel@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
In-Reply-To: <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me>
References: <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me>
Date:   Thu, 29 Jun 2023 18:02:27 +0300
Message-ID: <253jzvml3b0.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 02633a7f-af58-4092-a6b6-08db78b1dd45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuC+kShPaVUyHtCvUoD4BE3b5R9sX1fBAIMVg58iQt0avX6QKBr9ZJgjil4nBP3pQnqpobeLnK/uASzV4EJR5FDGCsRlw4pKMD1p1vMRx2CDzQsffEDpm3hRJtxbn5R5bxxlpMDItyMKZgrGCXaHOk9AkaTZYy6uS1yvIGjve5f4bg9SYyhsilzGe0bNTZAiAMu6QUwRRJ69rpylWqcXP8uWV0VWulIJ+jZ6eJGSmq+EhyM7wKNx9sKRAfHAtHiXu1MEXEt0t8WjfjQftpWc8N3O17Tmjk3Axd2rlA8ezqfUMklQZ7ZKLakPVSLJZlcDuTOlFqdcF6wUpxY0flEGCTnF7Oke7yTLgaQPt/SBiVLeLgZECAiEtvbAj3TY+g7kZL+03XYv0KggrFYuFoJiJx9sKCiH9veIqfp+7aT8MPTGp4x0enboRU1NxxnFJV0CkGvbn33zoEfaWexNvQpEf6sz2ISQrWscZ8/QimSm/bv/4lTPrNrpuGA4Lx9QM4xDSO8BExN+mFe1P/MdMFxg5Y1BeNwqY7t9/B9K7d/cOfzykpJET2CtiXVTfscgzCBNlGJLHCbjiXoJ2eeuRPi3QX8m3LvdObSPcuapc9+aY1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(6666004)(966005)(6486002)(2906002)(9686003)(83380400001)(38100700002)(26005)(6506007)(6512007)(186003)(41300700001)(110136005)(86362001)(54906003)(4326008)(5660300002)(478600001)(66946007)(66556008)(66476007)(8676002)(8936002)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxpHW8daRLkbic/vjFD5vK6HqSBwTvCM6qbf5QA03EIyJg+TCzzIsU4B9RjO?=
 =?us-ascii?Q?zP1Uvr7uOGEbob/r3HBvzVizqWzH9iJvnFMMkDmbO4GIA/d09bwM9UN8ysWw?=
 =?us-ascii?Q?u8LK1QKHfd101PXPyGQUJY2xfD9q4FaUsUXDGEwInyR3MvKWFvpd5adRhkAs?=
 =?us-ascii?Q?/oreQyNCIzggCg6Dml3DPCKriVYav6X4gRqyHgMGA76o3CJqNA0CPRHYu357?=
 =?us-ascii?Q?CCwYHrAPpzyVCThUliQQ3GedLUGMfbv1y+dUKvUPPAl6SsBpAuwyb/FYeDwl?=
 =?us-ascii?Q?ctkG8J9FfU5mqyabLjHdMPWbuO4mWs7z61qBalr/oodZFXKiO/a92WBtN0VJ?=
 =?us-ascii?Q?DwCWeqxR51Pog3mksqeJCNk3gTlu+HYfA5VPHmpP7/RaHlFtHPwcNGwXWmyI?=
 =?us-ascii?Q?eK61nEUlOQsHKdFEwIxeLXwyc1TovbAZ/xUds0wKmHWUgG9wWRyBFisoxOAr?=
 =?us-ascii?Q?swsJo0lRi9Lf+xexTbzkeyX43MXIhBWU5W597WFIvxni0KDCNiLKGnm1rvOi?=
 =?us-ascii?Q?6lPsCXI7cA0u9/12dTDrQSFeKc09/PBA7ufrhEdYAhe4UjfQOoLGRTTVm/Gx?=
 =?us-ascii?Q?xuaFwmjrId/wZhp19+KW+7/XyzDykyzkLGmPZue6LBza7NTJ6ZP0PUQUKtz2?=
 =?us-ascii?Q?tshW6fbRiTtVt1UpYrMuVDsVwu/t9wSXh2sAUejppsKFU8bD5/l5lA+CB5Tg?=
 =?us-ascii?Q?C8EwSrLKTnecTnUK51ZtXqitTOwaHNYjLTibD/jwkg7qf3rvepMB8520di2m?=
 =?us-ascii?Q?rAXRa58T3w46osWw+ghP0Dh4GEbpKbsdns9Y3lFcvda2XA/oFrIbvPW2oXB3?=
 =?us-ascii?Q?VsiPWhjvYd+4MKovUOoGpDAz+Wf+lHqEG+RN32LpdgsEz23WolpTovi3Ioic?=
 =?us-ascii?Q?98ntQw3q/wW3EhiwEvEMWeF//KawfG8IcME2KYMmLc6rzX4mVGzJ59vGZmz0?=
 =?us-ascii?Q?35I5bvXvzf1Sqael8/BctzZB2MX6IDcM4KRUcpGSu4agJ8bTnohsEGsQJB4A?=
 =?us-ascii?Q?E/aZ34l2mGULRYQZFKpo9RKGZ0BO6eoC0W4rOlc4LHCtpmmJYHPqipFxLB+u?=
 =?us-ascii?Q?6sm4nSuvNRLO3+Zx14CGI7YkN0n3Y4wU40BJyx6ilen1HqbWqHOF27UyTht0?=
 =?us-ascii?Q?YbB4okDz4Fw2NxodO4CUx21V91V7izR482KDwlJ3Na7J/+ZqvmIbVpUXolyE?=
 =?us-ascii?Q?DezqtVDOrKu7G1kVt55FmQ8QL3Nx5cXwwGqVeGLhgMZ8bka6JFNmRA/lCEVo?=
 =?us-ascii?Q?OQiZYCVvMqN5wGGi0xZFTZGISH1GvagfEjYKgsLpLdYrTvSqznA6XFFZZxHu?=
 =?us-ascii?Q?ODlFkZuTSr0DQCG5eGn/B6oTH0jiPPleMjPx4deM0qK1mz5kSII1IyCP5sX/?=
 =?us-ascii?Q?Ff5YTUC0uvPmh61ZA6EKLp8V8isiaf/yMsjGu7a99QdGahYa01upliELkavG?=
 =?us-ascii?Q?VsyB9VIUMTrzdQdQyfuN/3PxFh2Sh8uuvBEiex1dpaEsDRn5FlFI8e34lqZV?=
 =?us-ascii?Q?ib0YMv4ERcFS4s6cotapxCyffmKGd0sG+mFun2ymIWWD5wjrVJ7zjd1gz20K?=
 =?us-ascii?Q?O7UPNJbRCZpF7+rAtwFSgC//t5YRFrk+92oM4ZFB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02633a7f-af58-4092-a6b6-08db78b1dd45
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:02:32.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqrzbbCHeVdk12Yq+EKrnnKrYFCEPwbtSE20B/aJJpHKOPdPBjshx9Ijbzp8FlEIGAia7+BmcxWyxQBoMtdouA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sagi Grimberg <sagi@grimberg.me> writes:
> Most likely this also reproduces with blktests?
> https://github.com/osandov/blktests
>
> simple way to check is to run:
> nvme_trtype=tcp ./check nvme
>
> This runs nvme tests over nvme-tcp.

Yes, it crashes similarly during test 10:

root@ktest:~/blktests# nvme_trtype=tcp ./check nvme
nvme/002 (create many subsystems and test discovery)         [not run]
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime    ...  10.389s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime    ...  1.264s
nvme/005 (reset local loopback target)                       [passed]
    runtime    ...  1.403s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime    ...  0.129s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime    ...  0.083s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime    ...  1.239s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime    ...  1.229s
nvme/010 (run data verification fio job on NVMeOF block device-backed
ns)

Same trace, null ptr deref at skb_splice_from_iter+0x10a/0x370

Cheers,
