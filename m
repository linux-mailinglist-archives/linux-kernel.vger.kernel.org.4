Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B666742E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjASTfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjASTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:34:59 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E494DCEC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:34:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/MQfmIQtmPuJa12Q+ynCxX9n7GV1HXhkgJXj0w3WwnVFMvo1QA7E/xXJj+Gh/RtqKqQjWnxn22j7/ouCNizB9KdWziVI7XRrX0XGefOc39Y7nZ6GDesvmHu1x/Twer8DSz3jwIguRD/pobRj/TQ6/g9L6lDkl4bR9zFaQDg1vFmaCl9LKYSy3W7fZR/plPpKtB2g8nd8mG7yj1kJy038808Kl9s3oKg/dTsfqdXIMXTKXsg9fNEVzIGaG3NzZKhhVDlROYgZT2Fk1tI5lSisSv4MlLNAyKrcA319iDX3kuPOkGZKJMuGbozsDJz50e63ptouahIYAUNbzsNnvnqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VGDj+tfdL0XZEdvQpQo+siqqeRaYY5uUJ9Huj/lR9o=;
 b=mo6lSJKzC5SnEGsG+pi4Jmhxd+aePCvMJIDAHjiMUIypdlLQaW8rC+y8JnYIRhklgoUjsx8T9pLBeuNtXmRMhunYJdYhEeNBeHAP6CHKVG8R4OV+Db0TRfZbGVVWZlc0sv3om9o9bWtEtXyp/YXbvdyMlIwPHXeAKJxx9IhB3G9HphMf3BWsWcGAWOqrYH5lIMcM0JOBnEGShafJDlq0bUGEFzZsrDH7JnCr85SdBkr15EtAo693vL+QwTIGBrXZ41speTCNK5Kqoetsqygu7ug8pY9IrYdFdcNnvoM0DL1yEIS4aA4mOgMWewyMazg9rrPAALpqxZQamgKquhPKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VGDj+tfdL0XZEdvQpQo+siqqeRaYY5uUJ9Huj/lR9o=;
 b=BZyMMVwRLR4SpSB/pe55Z6P/V+iPh3S9AvpvvzFSoyAuBhIpm8Jxu799ChV3ELmLmD8mvjM1nIpcIgZSRK9oKjNVHnMTzDwxywq5LKaTOkt9zkusTUR83ThuTESBJx3pS/syIXml1a9lLg6eAi3PIgr0e5Lp/xbPaJ4YQJjdrKPecC78ZIWtjklVCwZicn+jf6OCtRzHIKTvGd1GxgAFLmT6mXXYnKs/QTIQGR8fAuki73TmBuK8Hqs+PYhU9G9zfq2hv9n3knQAkuOJJBiLLgo1NuQtLidKW7NnbbGI8qR1W3yyU8MkW1Ui75YoANeBGFMeuazFTK2yBT5xxEfNQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 19:34:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 19:34:55 +0000
Date:   Thu, 19 Jan 2023 15:34:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, hch@lst.de,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 0/8] iommu: The early demise of bus ops
Message-ID: <Y8mbXs0nai1BOxZy@nvidia.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673978700.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: e3319e3d-cf68-41fe-d088-08dafa543df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TdWlX0Ux870nbr8JmFJHNunGL0UhFHlMZl5Ux6PkjuUm5FB7deeS49MSNlzx+uYtWt7/+HyqXnogaIADoTijD1c9DDlKkwl6qRDA0Ch/EjIUmV8erzblcswBkRD6Te8dNHGOFTcG7/s81y57THixlM5Jwv2qreoXMq0/9zKpHt9XacflygSWPFmEkqCjooAAowd1IymG5YBPQg+oXDZ2JmkHELo2fc/RFpPDyfaj0MzDP3C41474rblfgXk396DPJtBSrgrzoNlNNRpFsyOI9fXNJoJ6oFw0jiCNOEUcq1HAAcHqHq2hB5kXGYjjKJtUZk76y2ZjP9sAfhPxox+EmNzQsyW56OiHGi7K/3IS1Pc8e7vJit8q8pgMDy8ZKzw5wrSkPVVwyngDtBAr4k4Mb0Qol63RxQQuHFcxw9tkALjB2GWk5KV3lS9L8TmXzPGJ+ebBanrCFPur8RW08pKo6EhIcYeq1aOayrUCH9a4dmrWxI7CXv8FM6LHOkLfUz4Iq2yM9DM8+l8ylOZG5GtbQwWSbad/Vuc3JT/6uety0XdNuZxkEgHHpQm72teojwZEiG7Rtcr8UaB3eRWjDPMo62cALuv5ue5Bpo1kU5sbFQS3Qh5a4paEwi+9d4ejDWRiHyQLbIKT5KntKZSfMFMoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(6486002)(86362001)(4326008)(38100700002)(66556008)(6916009)(2906002)(5660300002)(8676002)(8936002)(4744005)(66476007)(66946007)(26005)(41300700001)(6512007)(2616005)(186003)(6506007)(316002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7OaN1G2qYO06TTOfh2ZCDWHJbMmdH4Gdcc+DxpCtcxVq+S1fHqY1Ozvmxo48?=
 =?us-ascii?Q?UdwIuw8hMsRGO79EbViuXsOR+BL9LXLPxz75JNA9at7YplU4EsDZXsHEmUwr?=
 =?us-ascii?Q?q99F8RzFdlCjMg1uPuyIzJk6I1tNBBopFm5DkQqkB5WDhrEcWU4MRgibmKPb?=
 =?us-ascii?Q?wIpHUEl5iAIKNniTrQMwvFKIPJ0/p0wfiguOKEtXErJ9JAS4iU+fRv/RGjuZ?=
 =?us-ascii?Q?EzbFqhOHR8dytNHIx7zB3L3TO4gJ2FzsOYzQalMJsJ+0q5VVV69XIK/Nlz2r?=
 =?us-ascii?Q?dZaFQSyUiMKl0Et0oXUE7hu/5Ra98kGu5s/II8wmvB2D18C88QhYaC/IUlcX?=
 =?us-ascii?Q?42io9lTE/Rw8im2pvN6nldnWCQokfYi4LxGSN2ZcFdK8mTQgVhJiBrmnTgfw?=
 =?us-ascii?Q?ZPaZcjyTxqyDWaS8uHXOiiWchgkGHj/ylwopYw1PFBuizrAmHcQn9VTC41+C?=
 =?us-ascii?Q?1zxtfxA7d6qMh47WSTKI5fw3qM0ux7WdSGDzBLysYITCMZr5aW2Yj6V05OGb?=
 =?us-ascii?Q?SVSjIcxhvuqfHZA3bKJ9ub8a27WSMbGodlySk5EV6UpHH7NggWkkHLzexNQz?=
 =?us-ascii?Q?J7gtdliVdTrRy9RryTijDTR4CMVWHWC6/Zu1icscqH1r1KbrmTvYdHj3V79B?=
 =?us-ascii?Q?m1I5/rw6AgHbiBgPd8miDiTN3jkddTysF0kle5zXL9XPekgvrm9wECofdeIL?=
 =?us-ascii?Q?sc16fhDd6dVQNZ2T0KoUxoqBliZsefis4dSWk6Hw28TOtuIlpNhOhULMFXMe?=
 =?us-ascii?Q?/cXeTSgBotY8BytzF9qB++YQFaav1UvRK0/GBTZ13TDqW/kc7I9nHcfgrD5s?=
 =?us-ascii?Q?C58WrVtSvR4bBiD8vTHq+T9ZLItMfm9UnHjo2Gb+OotiTSqLRWMfIAs4YCVe?=
 =?us-ascii?Q?X+kqGrCdEfLF/jAv1FBpsXc4Mpd1Sgl9Kj6epRe2EzBMWW59ztieH/2G9UTq?=
 =?us-ascii?Q?xlzAHZSvn0MVadM3zLmFAiTWy5XkTtPe2z6o375MzmUXmKbfmyHtN6eFj6cH?=
 =?us-ascii?Q?pVOr9OsM2vekfcBrxYNCn6qsUNiTbK154pZB/m8icYuE1DYBYE6Fq4PDlwHK?=
 =?us-ascii?Q?IpI4OZx+K9qukMHuOylqfmW5LTq0q7e4FX5EnraqZ+MXAlTWOJaUWg1Qp2RF?=
 =?us-ascii?Q?XcS4XqMkQomeFSZCJ+8f+sNDSuA3DLsp0jsloA7ytAbVSut7jYFy5lLQS1PM?=
 =?us-ascii?Q?EPUzq/LH/GnI/c4E9q0KJ/ZgCAsDdZSiVss4kTMMovnnzeC42HFS4ZSyq0Tv?=
 =?us-ascii?Q?bB+LBM76us5ieDHzFVD3blMS7+mo1qM1jqbCV5oDQr6rSFzjhwYxAyInyzlj?=
 =?us-ascii?Q?x8PKGSTLOp79TVtWClt0o8FcPlovTNzwD4IMtPRfZtd+zvwApe/wd6xLHCqL?=
 =?us-ascii?Q?6Xcovv2YH/tF52RegU4u7Ltdrt2bj8mT1CyJ5/RmpvVC+hgIGpFlkKGhNlGP?=
 =?us-ascii?Q?b3YnQJS2LxPfQYvnnzdBYOIGvFt6ZpQeD/13WzUKKxbjD7BTtMcA4hk7kgbY?=
 =?us-ascii?Q?NeavnwGhRpI2+Oh/yG9lUx7R45vQ3GXIiNd73LhaCWIlp+x+daU+48nRAAne?=
 =?us-ascii?Q?I66125igl0fUUZfiCsf81JtVeFd7Buvi+PT3k/gO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3319e3d-cf68-41fe-d088-08dafa543df7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:34:55.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qol+vzUBU4axzS1T6TfxdjZmvHw4Nc3amOLiPkCJuhJIsVNTtIp/pyv4ACCgEwbI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 07:18:18PM +0000, Robin Murphy wrote:
> Hi all,
> 
> [ Christoph, Greg, Rafael; feel free to ignore all the IOMMU details,
>  just a heads-up for some pretty trivial header motion in patch #6 ]
> 
> This is sort of an RFC, in the sense that the patches are functionally
> ready but I don't expect that we necessarily want to merge all them
> right away; at this point it's more for the sake of visibility and
> checking if anyone strongly objects to the direction I'm taking.

Looks good to me

Is there anything beyond some typing preventing the removal of the bus
from the out-of-iommu callers?

> I've based these patches on 6.2-rc3 and made no effort to integrate them
> with the IOMMUFD-related work going on in parallel and/or already
> queued, even though there is some functional intersection and almost
> certain conflicts. If we reach a consensus that we would like any of
> this for 6.3 I'll rebase as appropriate.

I don't see a reason to wait..

Jason
