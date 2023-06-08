Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8D728193
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbjFHNjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbjFHNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:39:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2DB1BEA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU5d9TaIEeOKGcx9fjcXB9dSEz5hb9oq7CBHIn0WEKUIRAbmcU1MuyGI90brQegbHxB7JlwKt4PDFO9tYo50Qtqy8ScSn3wIPuGLfsH48jKPjGPHHxFBZgAUgQWlyAx5rBbqbOLQZZmwuFwvNQSpXrE/APny6ozOj7Hz7OBA89ENYAVYcARtIPbcDcDH1l6wreCTFiaYgSIcgjd8znTFqm2PegPEo3r8iopDIF6vZc521Hwxe5bXIuNJnK9biMzBktiPuY4o5Wh/QzVal3TLlHZkLdXQWqzDWOYa6ojkh6OCOE/f7YC7LozVnruEn41Po0fPwRpLMIDKlquphfzHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhXYZaAOsIcenZi6X9/sNKFSirThFdp14q8lVTXpiXs=;
 b=dCbdL2v7qGp4DxBbwjN47zNMloQdsV07SqmSh15qpNycFvf1arARNxDO+fnN8cF4upFTIq9V5FHb4hd1sUiy7NGwoxMpYz1DDae/hWhO3akYNT8CY6F2Mteu3iKkeCaDaup7BGrezg2fUAwZs1sZlIHUQOw55i1VwBfsemv3VftkE6kQjKT5ZzvGZHuqDZBWoNUherwGAuU6Uvd7fPIfNujAydJw9JQWJR2qq8kuBRrokYv2yq0AS5OI17tsSbww0ZeRmGNSGTQem0fyWndO3qt1ojVZmgqJxNbYIg4psP0sZoFgzzgogf5VvNc3KeqbxfNWz0Wii9vQZ1LqxW2aCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhXYZaAOsIcenZi6X9/sNKFSirThFdp14q8lVTXpiXs=;
 b=soTwDQzWGlOm4IMDpmAGEsLFKhHO5xW1u++7d7+lvUqeEuh0Qe9BWj/0tNKYxdqzDQCEORtDA7ZrI2QRfTqaKL0WYpZd1dNxO8tGjmYCXfTaXFtetCbbhN2y9AEJ0EaF5O25E7c57trcbp6Lqd2NtJ4vPM8dVJXOAuop3rZR/e2pV7SUsnKslkUxTK9cnZQWRbAF8BNboo5TFQC9Uo9ZnzPrii6U19Vxf3+doxROd5J/jIcXWZ6F3wUHN6p6RPHXkuk7oOhGd9lqJMKFh5syraD79gv0/BENbwmT6dMlSgjib0x95NZTs8TTuk2hxBVBDpNwmDBFgV0umVAAqE6a2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 13:39:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 13:39:30 +0000
Date:   Thu, 8 Jun 2023 10:39:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Message-ID: <ZIHaEFJFVQqvJvmU@nvidia.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
 <f0a691fa-d050-f457-9c8d-0ae340eab58f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0a691fa-d050-f457-9c8d-0ae340eab58f@linux.intel.com>
X-ClientProxiedBy: CH0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:76::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d392b8-55cc-4e83-5661-08db6825c8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oe5mLQlFglWJUVFUi/vHvF2Zc4Z9ZuxoQWb1+wvoZMiv02amboOWW7jhFLa2HKVpszFa/5MvFAgB1cjfX2Ff61MCQ06lST5BHXzdF8gGGcOWydtWpGmOwwBX974oFc0Cr24VBC/vHF3CDuYI449v5UaBYJ300erNjEdVnglsjbVokogVcGl1yamH1+ZT5Wzj2y8kPonG36siqMNtVT/QQuXTGGXMD6vCRqpS/DY/AcNN+lVruWtcIN8IOEWoxJymO690lVJN2kvkkjy+HE8DMvTkp06yTZv/fTj1fXgnDPWHLaQwBLm522NI4DBg80sgI3a8dcp+2ZRqmJ2haZTyZsdt6GCmAtvIkx0h5yzeUcE/5yKEVkkxUT6uO46YEvWccFPhlZfoD700rTU7tOij8tWCPVLlKjWf4QGXRpJrctJtfZkwmDpn8ObN3heNrz1APMrBQOGHRsGflLPTcdWnwSzI2NdTvPfxtstZrByksyIUid1Lh4ih3wQqfMd3tQJlmNK4UM3Np9jcGJlSKc5F9tfagIofJS611Is13KXIync0h5f5EyJB3zcIzj73jYPe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(2906002)(5660300002)(6916009)(8676002)(41300700001)(316002)(8936002)(4326008)(66556008)(66476007)(66946007)(54906003)(66899021)(478600001)(36756003)(6486002)(186003)(53546011)(86362001)(2616005)(83380400001)(6512007)(6506007)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmJFa0FUYlh4d25yME9tVExYL1ZHMnM2bUxVMFRCSzNuYUpsOTR4cGZocm5U?=
 =?utf-8?B?Wk9DMkVGdVF4NE5iV0prcCtjUlkvTHM5cEVwdGZMR3BUQW52M04yQURIUnQr?=
 =?utf-8?B?cGN5bkdNeGVWRDVGdU8wQmE4K1c2MGo0b0xQQnAxdG1UWU1nM2pGeEJKN05x?=
 =?utf-8?B?aXgwZ29LM0FCSWlzOU9lQTVNK2Z2dlVNczhoTEV0aGdFUmRuTnM1eEY3RlR5?=
 =?utf-8?B?QU9QM0NWVE1FT1RIdHRPcWZPZ280eXlRbG95SWtBbCtxeU1EanZlMnZEdXh2?=
 =?utf-8?B?T1dXaG1RdUpiUWtEcEQ4aUlkSFVvRnlWVWZvbjFpZ01TY3dHZk82OU9JUWNL?=
 =?utf-8?B?S3RmMi9sU0w0b1VVeGFxRU5vQ0wxZDNnWVNkbHBYOEczak9hazVJVHZ4OXJB?=
 =?utf-8?B?V082YkJnMEk1TWE5SnBZcUNwRTAwb3VYR1J6R1hxdVlualpkMWpMN20razls?=
 =?utf-8?B?OUtTNkVscUxadjBVSTJmOUJVLzk1djBqUDEvb1VhdG9vSFovVzZtV3hTVlBw?=
 =?utf-8?B?NFY4WGgvU0dtTllwdEh4eWswUkRxMTZIK0huZ0VwaUdZcGpyelZidDNGR0Jk?=
 =?utf-8?B?SDloQzU4UGdMRFhVdkJwN1NXREsyVmkvQ0tnditoVFgyRTJrRkt4SHNvRytV?=
 =?utf-8?B?RUoyK0phaVFERUU1UVlqWlFScGltSWE1MjA2NHZxTFNCTXBnbFpyMzlvak8w?=
 =?utf-8?B?cXRUZEc0SnMySnRGVEVzaWhCTDdGZkE5YkxwMkM4bk4ycUpmaEhSMEhoRGpi?=
 =?utf-8?B?cUNPK1VjeHovKzJUSGgyNkxGdzBHZm5IazRoQnUwTWVPZnBpdWpPdHR0MWxt?=
 =?utf-8?B?cVo1NitNdVNxblg2dTdjYU5ERWZ5WTNjamlOY0RTWjlVR3VjNDdrRG9zUWxL?=
 =?utf-8?B?blkzejRxOW1ndTNBUFRVRUdNZHRSa0NhajNvaEY0WUJMRTZ1Sy9yZlRQSHFE?=
 =?utf-8?B?OGx2eHhLSThZV09vVFJOZE1kZTZwNzBmNHdMbGN5MDc2cVp6Q3VKancrR0lo?=
 =?utf-8?B?ZkF3ZytUWU5SV25SYUtwdHRTTFVoQUJGRWRHZFdYRDlaYlg1UHpXVkV4UTdG?=
 =?utf-8?B?WHNuSXFLeFNON3FxQmxtOTE0WTRPQzFwc3NwR2lIZ0tETnJCNUlId0hKVW5I?=
 =?utf-8?B?bms4VUMxRWFtZzNGM2gxTkZ1Z1FwbVlLUVNydVdsNFptVkxnaWxzQ3FNRTBj?=
 =?utf-8?B?QUFNek44RHlZelRUb01uelVkSi9XNElIR3V5WCtmT3lhOHEwaFVBdDg2MVFZ?=
 =?utf-8?B?eHoyd1dUNjB0WGR0T0VuYWhNOGNLVE9UVXpXc3oxTzRxNXJmaTNweU8vbHdZ?=
 =?utf-8?B?NUlNb1lRYStPM1V1ODJtanU0Z2lUU1lvR24rc0xXSm1JZ3BZQkJSelR0WStR?=
 =?utf-8?B?U1k2ZUM5WWZ2VHVBR20zQ3d3NWVkUUVCWjA5RE81eXh0MmVqMWh4RURXTCt6?=
 =?utf-8?B?dEZTVGhVaklEbVBDTnRsMGtxakxMMDVUTWQvelM4NVI3QmVsa0UybkUvZi9L?=
 =?utf-8?B?TzNPZnRlWGdmN0liRE5wWEdQOHF6d1pSSURDd3BpcVVrQU5rRDc0elM4dGZY?=
 =?utf-8?B?NHVtb0czSUJBaTgycENSVDQvUFVKWCtNQ1lqS0hxYVBqK25zdDhLV2RMTTJ0?=
 =?utf-8?B?dHozby9DTHpPYTdLWnRVTkIyR2FYSFFpRmxlUDIzTkpPVlVvUFhKVDJ4NDhX?=
 =?utf-8?B?WloxSjNmd2dQNzVyQlFVK3pveGlsY09WQWNLUy9kd3BQQkQ4Ky9wWHFqb25q?=
 =?utf-8?B?MTYvdmJiMmZLVFNaYWhSNlBNcFRhZHVxclVSd25vTURnaTdqYm1jQXMyZVlN?=
 =?utf-8?B?ejNQYUtabnN1WVdod25jdEdNdXkyUnVBZ0VNalJoK3MxWDU0MXMraG01NDNw?=
 =?utf-8?B?aXk3NHFYQnovM1B0eGJxTWZoWUZDQUgrM2tuSnBnb3FpYXB2blJuQUQ1ZFkz?=
 =?utf-8?B?dlhvc00wbSswbmt2SCt5Ti9KT0JzOXRwUEEyZFFDVjBFVGx1SS9PeU80TzBT?=
 =?utf-8?B?QTJGdURCTXZTV1RZampDbTQ1VEtWQnVYc21FcHVXVDRhQmI0YVYwR2hISitT?=
 =?utf-8?B?OE9QTkMwemNqWWNnS0N0WWN2eFJZVnJNNGJpNnkrREUwVm9jSFhZbDNHb29Y?=
 =?utf-8?Q?kt60=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d392b8-55cc-4e83-5661-08db6825c8fc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 13:39:30.0382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMv+cV1qVlWgwZxECm4zeCkmcC9JlRmhW7ofqP5VjK/8fsFXmbPcpllumDV1js4u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:39:23AM +0800, Baolu Lu wrote:
> On 6/7/23 7:59 PM, Jason Gunthorpe wrote:
> > On Wed, Jun 07, 2023 at 12:06:07AM +0530, Michael Shavit wrote:
> > > > What we definately shouldn't do is try to have different SVA
> > > > iommu_domain's pointing at the same ASID. That is again making SVA
> > > > special, which we are trying to get away from 😄
> > > Fwiw, this change is preserving the status-quo in that regard;
> > > arm-smmu-v3-sva.c is already doing this. But yes, I agree that
> > > resolving the limitation is a better long term solution... and
> > > something I can try to look at further.
> > I suppose we also don't really have a entirely clear picture what
> > allocating multiple SVA domains should even do in the iommu driver.
> > 
> > The driver would like to share the ASID, but things are much cleaner
> > for everything if the driver model has ASID 1:1 with the iommu_domain.
> 
> This means that each ASID should be mapped to a single IOMMU domain.
> This is conceptually right as iommu_domain represents a hardware page
> table. For SVA, it's an mm_struct.
> 
> So in my mind, each sva_domain should have a 1:1 relationship with an
> mm_struct.

If we want to support multiple iommu drivers then we should support
multiple iommu_domains per mm_struct so that each driver can have its
own. In this world if each instance wants its own iommu_domain it is
not a big deal.

Drivers that can share iommu_domains across instances should probably
also share sva iommu_domains across instances.

Most real systems have only one iommu driver and we'd like the good
iommu drivers to be able to share domains across instances, so we'd
expect only 1 iommu_domain per mm struct.

Jason
