Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7986B4CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCJQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjCJQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:25:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D6E12EE59
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:21:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKIegkMVsZeWlO+5vGVfJYCR2LSFomdy4L1eb5zHHhREgFRBhdSzncFyHEmzpK9ZrHnBcoM5d2ModIMq4ouG5/kBPUtIh4ajWpTn1PBD/TeHwKE/3elcVnN1VoANs4F8RjJDsfq2gnCslciJEdppFY1Oxz8P+iqXU+R7Z00/zCPt8XXf+40+zLaQ6B9ht27JBYw58WnpjQ89DW43eIrYrz1jl5waX99AWj4dRkauaCPi0lyB/VWTUKsV+BeSr8PYqRFRTI6kfZh1495IjxUg+XWCNMwB1La1wgKs7vLblUTmwtt2sNE9Jwu5WHW9Gv3uJ+pUYbYcMIbbdyvpjreRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIdw11xozd9MUt1xGC7Q7gZbz67ZbTOgmUPIaWLMB/E=;
 b=h1GFdEYHVBpMZc7V3ZveLgiYiJ4m79wMfAN6qdTcH7DInNX5ipxWc9a8qYc4qbCphaA/zNo6xHuElUOIuxpViycnedgNvRc59ezFcbT7gFtlC0h+3/QMhjSsKU4TRx61xqPWQIHjY23RSn8u4HrOn1n5uHeP8j1V8GBbIjvwof2DTjREyGoSaIMFEOLhFojYit7LSJ1a2lBiHhBN7cRI57NWfDtWyJ33CHIXhgt1PHJtblLnf1nYTcOqEuR/0/covouhVYdLSZmTEohUL8CYROomwTb+jvjFAxlUIP1w25BLN3bcAThSeIDVeHyl4MEUJv+ZZ65iIfn6u7w7UENk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIdw11xozd9MUt1xGC7Q7gZbz67ZbTOgmUPIaWLMB/E=;
 b=Qt60v/jwwqy9XrpUUYjDZpC0lMxKWY3WxCHbWrJ/K2O1F9uRIoyQtL8kVks/jGE5/de8c6ooLYC/+EKN8fPQMTuVz6xzxKgu/bpdihZ0TdhhKYW5BdLcQJ15nwk/S/la1mOh6Hn4EGNFKEVvVIievzj4drvF3pspZnkM7f6EW4hmIO8ShcWM+aE9OjA9csypRIjBWWDFVIqQwxX5t1DlaBsYjOGOK8fPT1U//JlnijmZPr+jy/aD9Hc9SlGPJy/b5wwNeG7anDrCZ19068XZQI4dAbeaW7LxpYp4Tl0BugP6T/bGoVslH/J9vTbce1sotKAOUCf0zcotfEqd76hnIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 16:21:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 16:21:09 +0000
Date:   Fri, 10 Mar 2023 12:21:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Eric Auger <eric.auger@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZAtY8S53//5P5egd@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com>
 <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com>
 <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d0ac89-c620-42f6-191c-08db218374dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1XMFGxYYx/+q5OwG/nkj5d8T6vnTgWC4pv9/CM6xJXoopQvh/NSqoGePe8ms0deHEUykRQCGo+LIqvas1wFtepbIYVgf7P1ksqoa0OhZR03WtO7KbKNN1bkdFB1y2k0hItP3OYI4Ne4DtNHK29NFYCxtZCWV3R1YoMU/oOoTs1ymV+OxldMNGCcBkTcoV5LZbXTf4jw45f3Ro0Hiqc6/U5SPR3K6TnWVKrty8IPZbmZ/tYy4Bs/BUU71e5KY5WGtP4KIyCX25ZQoCT5nStnfoiLuiAEIWMf8UPb62me3HWRha7lIQmnE7MsICiF6Jc2XBw+caF2rfUEYY/oITh1KaCV+UJOfK8e67wdtLZvsdKkRsRn/dWpKicCygippq6Ucme9fCRogDTULWHlyrJDaB7KJITFrTS021m2URk18FDaSYd2MdxFwGdjteLRzvJnpr36pYKyZSlKPsmuxMajTeu7vNTwoQxRryT1mKZGrcXCXWInRYllF1+CmPsS+O77c+KD+IB+22Fxu7sKVZvjahTqJs8LWSk4hC7TYuERRADTaG6UZmGq1oDQmHjyvpcVySVnRHLIAZbB4P0P2mNEeGToHgKobdfnW+/r34swq7i7Nmjgt8rxriId3GrNgQgaZoYFpUSJYW6OnvtbawXXQtf5JNb9lNSGBg2nvqesdEx1RXYvMM7YDgSR6b27DZvD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199018)(2616005)(2906002)(7416002)(186003)(5660300002)(66946007)(66556008)(6916009)(4326008)(4744005)(66476007)(8676002)(26005)(41300700001)(8936002)(966005)(478600001)(36756003)(6666004)(38100700002)(86362001)(6506007)(6486002)(316002)(6512007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGbMrrs7t1F7gUfEVRuwYoTHfZQk2dpO6AcGVjajbdZt+fmTWvvj/g+3VJAv?=
 =?us-ascii?Q?Zb6Zfi5CmC2N62W5X2q9QVtbPGQMBPw0gOniXozanBvrVH1eiynzKQevUu8g?=
 =?us-ascii?Q?XJfyWgauwamgIBE646X6aHdkYBwpNxTSYLD+GZ9mLyM2vMBgqWtK2aBWd4SL?=
 =?us-ascii?Q?igKCRig+TtvzZAazzbhORyjDOEJ9C5zrxAkC4Iscsxw4qlA7ENt5b339vSs7?=
 =?us-ascii?Q?s9BTvpJduc7pXjIQXlKXmgyjeh8Lc66H8Dga0I02yVc1k37+9RqpeYCuQGhe?=
 =?us-ascii?Q?nxSju9b1uDdDVEE1rRhSzB7isRsm5JUA5Knc6v+flTdbhiY+WFCoVtPIAy3z?=
 =?us-ascii?Q?jsijATkTb7godeOVZVY6pMpUv1W3Xm6qFbHoVCSBnAbr5KZ+BhasUVYMs6Kz?=
 =?us-ascii?Q?5bIaHNW+AkxT+A4CwACHWrv3e2XnPB+bq9Mh+SonBzTaBFqtIc4liNQra0Og?=
 =?us-ascii?Q?EcSXQdwq6LZPRrwk0+6XLEOTcvEwfofNJxdP2fT8AgBE275aemNBSWCaeM2X?=
 =?us-ascii?Q?kFTotRzwJb9KBAoRDj+Hwhlh65v2oYNItfRfd5GtFuuVp/PAPRP0okk2GtC8?=
 =?us-ascii?Q?F8voklLhDinz+9dVNjwR5o7jkezSaQ9CcxIND/esVZuiL0nt4c9noi15fIbP?=
 =?us-ascii?Q?J+Tv4zqao1fEQ8araaiPVD90SaqrvPBKEo+WHrzZaekvIdO1nhe63noYegen?=
 =?us-ascii?Q?cenQq92Cx7ytMfPULMeyDSdUNwUuTkgZvvN2w+OSe6VYi53k211aycxkudwq?=
 =?us-ascii?Q?503EVuhOXC8I8nrESWorwCZ0+GQAOrfg2Js/aiZB2dlGtot/pXOfyI16zxjz?=
 =?us-ascii?Q?qVO39D5eh/7GmPqDidzC6rCxzfOmyoA4N0uldYpt86cxlJaR7GxJrPk2dNCF?=
 =?us-ascii?Q?ABZ4+Q0re8u+pOl9+5YOdJoYkRN/MsZrguQ7xzXe2gPHY6cfnbj+j0ROdOnt?=
 =?us-ascii?Q?6MqVuVCF3KG+eGNFg6y1AyurfdDe3iKqwE9pfbz7Qt/GtZooYkjtDqM2GFFg?=
 =?us-ascii?Q?hvrw/0Dm3UFB7JC3bo5d6SPjRmeIpGjARr6N5xS6fvM/8QmG3ztLO8DZjJ+m?=
 =?us-ascii?Q?5odm/mHxKf9GClUn3emqO2nMmcJ8CQG0DoFTwRqFInppneenTKVCNLX665Pe?=
 =?us-ascii?Q?VqIXzhLW8k23vZDv6kZ/Lto60Y3SGy69QpVzwEXXfhze+5SiE/gNQeYx7zPh?=
 =?us-ascii?Q?WL0Y14tm4yzLLfNG9o1+f0lbh9eKYfZEQARdROSqxfKAK9Q9AvMaVXVwxwec?=
 =?us-ascii?Q?du1Gkc5S/b4BuyMUOAqde75/hPKZpgHTaVgvI+8qxSumC6PczpWvkIPQ6p8h?=
 =?us-ascii?Q?8HBeKZiv9qi+QBPB936CfbG+E0jPBq1C9SFaQ4pVZ6oJ+xo2CGyq8rYui907?=
 =?us-ascii?Q?CTtUTEy9Yh6HQM1Ej7PmXyxuovvO7EQEyWt/EAPJSLCvgbC/AHGP5Tq9PiEz?=
 =?us-ascii?Q?7QRFJoK4j/UpbJZPeeMhQrpipVcOzKPIf1B69UvX3gfqG1wbPabhflAvPWvm?=
 =?us-ascii?Q?ngF5RcFnW2cLNnYNCQooVlL010Vh7LTf5r1pizSnskAEVtM0oZj3rlp3snWa?=
 =?us-ascii?Q?/1r3QMtHsX9ZtDnwftkEHpB6QYTlBAJlLvY+VpBv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d0ac89-c620-42f6-191c-08db218374dd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:21:09.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atuCzj5MNX3wr0w5FBtc/zjBQZUNJVvup7Inrh9UGmLknCfQH1DZWxPUZpL9pyfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 04:07:38PM +0000, Shameerali Kolothum Thodi wrote:
> > https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shameer
> > > ali.kolothum.thodi@huawei.com/
> > 
> > So "boot configration" is more like "don't change the RIDs"? Ie don't enable
> > SRIOV?
> 
> Yes. Don't think it will work with SR-IOV if you can't guarantee the RMR specified 
> SID.

So I think we are probably good them because vSR-IOV is already not
supported by qemu, so it impossible for a VM to change the PCI
configuration in a way that would alter the RID to SID mapping?

Jason
