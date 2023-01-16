Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9054766C664
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjAPQTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjAPQTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:19:11 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4200428875;
        Mon, 16 Jan 2023 08:10:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7YTDpjrSzmKTumUly9Tz6XngiN2MKfLGjYm05q8K8gsa5gaACjBxL0Z4cAKhVD39JljIH0imOvTrCp8EVH1izem7pDcFtYpeCQUhxYGWPEQS9CgSSyNMRyx/5389ldM0zVVFV9vtxvWjGR15azLqu4jUHGYHLTFP6MDNdpLhwNmTCNVzLJ6qpPRFrPIgrqUSf2hW41OYq/4W6zDsaQBfg0hcGUj/GJ9e8OMtqyAnsw3tS6rOu76GlrVNNCnNvUf+wwyUlQzCZttgGyJqfUx22ufWN/8UY3jrO7NUeaXMF6Mlo23lQpS7ziPETqZf++HDRaYf93A0G+3ejssaFlDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcTCxf/7UxqDdNRS4Bi+UQ1USndCdZbm7iN5Ob7nMJU=;
 b=DnPMUrnjQT1jpe92Yw5hzEgQ7QfkuW7vTSLZo72jAfUkkg70WUYEjoegMPHjDqAFpELsJQlHgpb5H2YEaclkND1ilzvez5g5x65rfLOqs03RsxZBPFZmbx12cI9isSTQitQ66QxCB6CULmzibKnW4c7v1qzlDTYyUnId/9lybsyppYRI3L0TSAT+Eopt8Asm6H7MYRZMYp4cizFzqLsxyKM0ka4FjRkM/w3ZoZFPV8xtOZSZdYDR3eNO4IHVhUpQ9y5lmSepz0D3us2rjed4ljmhQNOpKepQ1GPsIQgd4z608TJanLTApQVe+lnD+fEf2+/EsdSZWj8UXoBMq2cX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcTCxf/7UxqDdNRS4Bi+UQ1USndCdZbm7iN5Ob7nMJU=;
 b=JCvu6IhdSxTktw6h5USEpCOVtyrZkEFHStUkd9zgnGE8y07Thd9g4bIL0P+ReINpH0Z4SjXfqxR4KTY8/w5MqX/2p2PpP4y5uYw73C3/toScxDSULtpP6JG0cxbs6q44ZAG81087XoKoia49jeATN62GLK5tPs8Yg1owvLrT9GkTqO4Bt4VXk1tcqY7IlDmG8US3mm87QXWrRqW/RD0vFwBc1UzLVUt7Ha94mAqkVgzxO5BFMlEKJZYvzoaXOz27P2ekBjc5n0fk07URS9NQMgr+/y2lQtX0TT908SgINQd8Xx5DlN5LMH4OYaltPUoBqVZFIdx7RPbil/TJWgQ1Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 16:10:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 16:10:24 +0000
Date:   Mon, 16 Jan 2023 12:10:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, logang@deltatee.com,
        akpm@linux-foundation.org, willy@infradead.org, hch@lst.de,
        alex.williamson@redhat.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V1] lib/scatterlist: Fix to calculate the last_pg properly
Message-ID: <Y8V27yFgM60+KS1a@nvidia.com>
References: <20230111101054.188136-1-yishaih@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111101054.188136-1-yishaih@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cb6218-b650-41fd-95d4-08daf7dc2cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nPysQRWWIkV2aicfx+A9gVUBms5uSnXhWZwa/F0GIuVy12HCvBSFXL/VUuGa8zRb6FSeBYzDWmBbcJKSVSn+HtrZFfOAaaeSxauHdh+rO6xa+H7pVA92qr6FjmQpvgbEnLK78xPcwzKsXw6zoI8Hryz5vyfZOrijnE8Ab/t+4uapK30LW/1oIGYakZfOrTbPmYM6nW19mAqGrJNZl7x/xDdKR+nuecBDTBibbkqcdqFB5HNcxfjpvbqt9HYenQrNv92SPQdykQsMVpLF2Cxh4u0uY3tsBoXwAHDRJYXEXusZN+h0qTaIkJ3g5OP1uIUwdTeNa1DZ27DhPtqUOOG4WIu2HqxsJjpFr1z0PrsuKgdqAN2vXiNuy6NiT5U7vJ+ucUAcXpOj+XG6MrTD4N4QC9LgvUL0ZlFJl2uLj1+m7NEwhgjLOD9Jj5kj2vMguzqmNwalJ/3zip8BiRQcJX1HOTa8QV0Z2TfTNazBCR4GVZvzfBs63h/SpXHWXCrcs/TfvVnR+Q8y8a2CEy7qoyZJwwzOlEq/Ifb0WhmVijZzxs9zsGz7+dEyGKRm4P4Kp0cew67J174L97QBFdYncK9dOp5mofri4VErkp/JicsbLBH3cOJxs8S9H+CjuknKBVmHl996awVlmxBBMmpx86N3u3I1YzRhn5uywQxLwx8tsga9Abj7xZTJqoSMd65XkJP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(38100700002)(86362001)(2906002)(4744005)(8936002)(6862004)(5660300002)(8676002)(66946007)(66476007)(4326008)(66556008)(41300700001)(6506007)(186003)(26005)(2616005)(6512007)(6636002)(37006003)(107886003)(478600001)(6486002)(316002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Umn4fXgwY9u6LlHwiXgCFb8S4zpqUuME6Hf4OAkReus6U2prNgGDG+W1P6XC?=
 =?us-ascii?Q?MCRyCOJ+pFW6nNlVn8ZOkcgVKPLb6oE5IEjfLAxuqDqrhUuYfuDz5irSEkFr?=
 =?us-ascii?Q?abKFeG9LgijPUEvzEh7c29NV26CyQhy2BQ+P3lchtFNQx02DWaFmhQ1wEI+0?=
 =?us-ascii?Q?4Ckj0lYHDWweyn29u85mbxhnLhtdLYruKNA7wNEtZAGYm9oUn0RuoREUw+NE?=
 =?us-ascii?Q?N1FZUM+CBN/GFRgXkLmyTATFM8HiS/65WNJ8rBb/c10j1P+/Y1vqGgKXHYas?=
 =?us-ascii?Q?fMNOLlgt+J+pKdqckKWyth4Q9x1yZxuVBjEbq+8XC2OU/bkuvgZ4gwIrt2c3?=
 =?us-ascii?Q?/i2Zz4SHNjOAmzAIrhuw95V6LKFEMsM+TT9WeJhfmq2MP0ohECIP2DBntdlP?=
 =?us-ascii?Q?IlAU0hyytaS8NG2JYc0wl1HqpFascUyq4AeTxt6RrWk/FLqzm18qVwa9YH2t?=
 =?us-ascii?Q?gSDGKuO6YwZ+s+h7BjWPVtTYAE+nmYFLGb1b6xjMQrA36B3/xI8I48QqV7mx?=
 =?us-ascii?Q?g3OrFatf3918SD3OMIjISGo+MHMBnjCZFbdsBV1W+4uyyRUGLeGukZtBfQZU?=
 =?us-ascii?Q?TQEdKEkLNWpD4tp00B3dLV7FaWXsVBKGlvXFCeMz8vMmM2h6UpyCWXRhpXlN?=
 =?us-ascii?Q?BS2O3X/99/w7R982zoPBZgWTaAVYOKMIW6wigTaqqkiaX5AR+ys80YQrl6Zx?=
 =?us-ascii?Q?F/5jLibYmv8MHBSQH1m+7OkjHUQycFYpKenz6mpQBhbjmS49nagsFCwY6j4A?=
 =?us-ascii?Q?O1qiv2EFRYFL5e8zKKdBqg+dtk31U11R2XQs8jOhIW5Rz8DajK0pJQRa1qhj?=
 =?us-ascii?Q?IZyVQL4QJLCnu6Fun93PA9o80UprbdVzTqJjUqGzJJ5DXDUzKafg6T4r/OPB?=
 =?us-ascii?Q?4wlGWKJDj3HscF3wqI5ZtwhIjHKKQkO9xkBJ3UTHHuZ51B6Ry1vvuOi0XOnm?=
 =?us-ascii?Q?8hZfwT4N689Cz9SYXAFyUHsqk3Xwoz1/20Y0MaaPKFyS1iINTwhAQa3J6dq3?=
 =?us-ascii?Q?bDpSZIg58zFRl5mItKdPeu7AAtmw9LuYCooowP9jLy2/TbxH89HCDnhlmhzW?=
 =?us-ascii?Q?vKB7dJSpTJcwV7+ojpGw/Z/POtyIchFzMWp9vXHMf9JuRXHI4kp4JfoqVjkC?=
 =?us-ascii?Q?erLRGSsanuLMsO4subXZQhxv3yEhtXt8UNfsKhMQWeAnJRmJuQzXaDOfk2hu?=
 =?us-ascii?Q?ocuAOnrH9lDsivPwtQ2eRGYoCLcIYV/20fDz15Jkz3vOD1n+HR12EnoSgAOl?=
 =?us-ascii?Q?VVtBZzzgkA9URvB4b+bizg3TXonR5WGZxNsdh9KADq0Vw6pPGxNV5yYaMbhO?=
 =?us-ascii?Q?wouosJmSO6WRb8FqNRHRBtNBFoR1k/z+XuahYpglwH/ryeJ95xwMoTyMAyyt?=
 =?us-ascii?Q?n+Ly2OArEWkddOh6wAnjpKGEOQPnX3d0uJquhwk75bWo1h+TspqcFDTr+Fk3?=
 =?us-ascii?Q?xRKcvP8A4HDjic0Oacc+spOZSvaO20xv2ROgq+UYPiS/QcC1lTCNlK5cOSKr?=
 =?us-ascii?Q?DexnB2RGkmedU+ZiMoqRywe67Ny2Up2/kjuRh/8J9C/gZZN4TrWbUALvuBys?=
 =?us-ascii?Q?Sxjlm130FJWyJ80AuFMx/rv60g3jsqRIAhxLJVg2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cb6218-b650-41fd-95d4-08daf7dc2cef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 16:10:24.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuuFkzgh8zRGKxX8Dnl5hdfGaEAtk/3/EcHxr9XFuQbznH62MR5VaGshqfoNLXhS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:10:54PM +0200, Yishai Hadas wrote:
> The last_pg is wrong, it is actually the first page of the last
> scatterlist element. To get the last page of the last scatterlist
> element we have to add prv->length. So it is checking mergability
> against the wrong page, Further, a SG element is not guaranteed to end
> on a page boundary, so we have to check the sub page location also for
> merge eligibility.
> 
> Fix the above by checking physical contiguity based on PFNs, compute the
> actual last page and then call pages_are_mergable().
> 
> Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>

Applied to rdma for-rc

Thanks,
Jason
