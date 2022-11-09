Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA0622C30
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKINMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKINL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:11:58 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C5D1FCE9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:11:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT4cCUATKTdzCaE1Rhm3P/uXelMGx00WOudSG4LsCjy28cI79GSLC8qpwg+EJ3BzWStUNYhnQA6b2Y0xtNfZzXnlZtgQHKdR7wg2HxdKQc1/Kib9IWDJxpVpRpOUYw6aGOtviD1YSXE8iSaFIDqxh8ZRju8v6zappscWXXv4JR3EXIvuG4NANKrrx8pfC4pKdnXjO8PLq/qBmLGtEcaWPRQMfGa6UkQ/4BPkCrbTvuQD1U2H7SZ93/E+w2p4pQQ72gHFKwYM+o9dcjE0Ohgp08mARWUjKdE9jLbyddRg/HXvsf+NBV3CnQxPsPhjq89glxApSaJRkhhMvu5JijPzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k94oPj0Pg2Cfp1tIUMQTeSQIIR/zSWETdvY7cyDZSIg=;
 b=PV3yZSH7w8sZtp+DS7zW4jsQXzw3iW56FB2Wk5oL/1Sh2aNBuRUe46BCXReISuvieY/0hP6/uNERAwryEzUM3Etj/VP7/4bhwMWwLdMsjd9tTTSLRXQm714T70bl3iBkuRCQpeQHoPPC7KawQCLW1PARDzq7Xb8LnpFn+PQbtqz2AZdvyKTDEmBPQl/NC3FP8Qo/f++3YCS9RwpkQPM2fr1/sF6VewJsGmDqG6FCHlSmO3oqvfXDtXLibooSRbXJF5/tRalCqWXIkIDYECDptbVdda0bvW0gFw9VN+GBIkWTc1n/K7EkmxEZZMbVU127c8vAvZkH1emUTp6DTlUlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k94oPj0Pg2Cfp1tIUMQTeSQIIR/zSWETdvY7cyDZSIg=;
 b=EGPNikT1yf+V6xjiBnUpqJ3IxwuUui6yY3VmTPsSR6+f/CBrSBae26nNyhT4ax/gk98mVWPMFt/vh20UePLS6kPECCOFOpOyl/5in8FsD8HJ0YZu9U3Fjowildrlxq1+L06us0aJByqmS1Ri3d4ENm5LoCJ/rCG8gsKmSGkL3+1u2LN3BxtRM7p4s/tTURaj2MdhbAX11sjFK1GxoS4wLWJUNQ5G2/OMpimomi1dxzRO9cMfE+hm5q++CVLKGl1dOgL9sYpWTiKGWGvLAMkPKo0JDQHtY7OPbV4eOYR7wST9lQ7KtCrn+YoBL9ATO6mVOuKUhrYB85UChFxF4ZbthA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 13:11:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:11:55 +0000
Date:   Wed, 9 Nov 2022 09:11:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        robin.murphy@arm.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Restore prints in
 arm_smmu_attach_dev()
Message-ID: <Y2unGf7trHbfPh1v@nvidia.com>
References: <20221109070713.9617-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109070713.9617-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:91::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c9dac2-b36d-48bf-0ae4-08dac253f95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zx/ggj6NTscQ7t3ktECDppVB4Al/ViY9YKU18UMqdevx49YxRSVhqE74qDCnSzW8njmQgFYiITf9l/AkZA7dJi6DTJfa/n+xuUhTCW2FjxgKFB8BxY4bkInUc+llxLQeca7CpySMqXbqqu/8tfqiEXjTeHne6l3LOtSXCpfYoKKQ/lyJTvb6TERthf7zmHunvYE3r8IC8aONHen04T1jEFHqbZQwP5QUrj40dsR3Vz/qJ4ktVK/spG25VpIX60roPBwvafhfh6zAAiXc2DG0no4RDNF4NAC+meyzMYffkhdDcKH8nE+TEkDuANrycDn7Mlt9ZQy7Z/AhNKt7/+P1w0J+btFvBwOEC/uHuS6ypqpMJOa9KC4k18BFcSQvdSu/6lwx4ntWqtnacHSX43Eo1R3JJ++UBFYqKMjR/iTLDSckJy5oXkx7DT5RysNnKr+uQLHGI5ioBB2+PFb5BW2LqxUP3uZZpUCNMfPjwkbzr80eJ285fxViUG8fzg1JvcPtpkgIPFhOYtPx9aHGuN1jh/mC2Cago8CYMYqHyWgPhvaewFNeeR5A6X2oNzICTq9hMHA787nOP+cOHd0rA/bMcNW20dumryT44oD6ZTaoaPdaTuSOz2AZT59aB758tR2JvEdrkElPJ8ZPeTvGNw+omRt3bsgs6tg80MC5QDdioR+7ikyyG25r/MGTybr8lZlbXoRAjBGxrGZNnMrYHjYKrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(6862004)(66476007)(4326008)(66946007)(5660300002)(66556008)(83380400001)(478600001)(8676002)(37006003)(41300700001)(86362001)(8936002)(6506007)(6636002)(38100700002)(6512007)(316002)(26005)(186003)(2616005)(4744005)(66899015)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xdbSIvnqbuqZISjSBp+X3+fGNcKCsxvAcQ0wPwJA/qzqrBogUa1flEE/ygd0?=
 =?us-ascii?Q?5RbWdTdqBTlCoRi14x/uBhfRatEDooqQBV1tKAgx0yIIWQgT0xQWTuscROJa?=
 =?us-ascii?Q?Y62Et5ReMTM77bVbM+BZHUFP9vbg1BFRg4WW6tRTV+bDQn5yy2UEIXyJKN0S?=
 =?us-ascii?Q?TmpyviKSTkg9vx/6i61ctpB/uRgw8nbVncpbk4lpG4yTUow7907Yed5MMAiv?=
 =?us-ascii?Q?CdjstR7UqVpgOKm/gZ/ST7Xa0HkfN4BGcUEkCIPHJGh26ABDKS9JM+oMgAAR?=
 =?us-ascii?Q?MGvaG5IvT88rKesv02Vq94zoCXkdbcJCXumFID2EiEng5y/nxJrU7pUwaeVo?=
 =?us-ascii?Q?Qtdv7a1cQU77eQ0JGvjAGg5C8pocHWsTzdprQiIGObMnjrMqPlqc/ucevASy?=
 =?us-ascii?Q?DOcY2BQ7aL4fZQ+QSby+Qv2Z3U6F8xxXm6JXOq9N1IkEBH/PfODaKFYCdQv7?=
 =?us-ascii?Q?VIh/oAjcRcRJDAf39zRwf433zJxGGXhsOfx6u7omKQ2btkZU9iKYVTfkROOI?=
 =?us-ascii?Q?3+epDuqPBIXmLxgzvjz6u8fzmZD/miZfCcN6NI2YChepPqvy+5PfhbyQ7fBm?=
 =?us-ascii?Q?7LUWLMltcmtZZ2f7kSODjLzbP0gorF89wEzBDYkti7J5l/az7VHWvFF+m+Y+?=
 =?us-ascii?Q?l2CBMnIg5a6dXWwBhOPhpSxz+2IFYnUdpPc7HziZvGFGAgAycr8WuDEg2TO5?=
 =?us-ascii?Q?9pBTDgRJC2/VjtQiJyI4n5FhR9wcgu+niExxXk6LVSNCHM7Jrc6kLP/f9w1C?=
 =?us-ascii?Q?8f6l5+LFnoa3UG57Pc6rMOs/oRKqe23mOeEmFXB2LLX7gJwHKAQcQt1GyHYR?=
 =?us-ascii?Q?OOY8UEE1nD8OTiiBP4aZn7JpvdwRF6vuIZNb1v2LTr1a8vqNsNB7N2jKcv/J?=
 =?us-ascii?Q?kT7WQo9GrD24JG4aWjoSXYvi8O9BR2Xc79455DAwWO8cci00aUrhn3EkfF18?=
 =?us-ascii?Q?thpdApXBRaV3RCDdGRJkIUgsEqTKE0ZYMPfSYB0i60c/q4cQchUboIOJOjKO?=
 =?us-ascii?Q?VOTCkrCHfk9fVvokHOIqJ1gn+m81f+EY4O9YunwcidctFmv1KhW4Nb6uBRlS?=
 =?us-ascii?Q?OZ55RuYKCdJAcgwnjtldIYthezCQI4fNzVKdYn4yEPLLRZrNp6qQqWWLWcRr?=
 =?us-ascii?Q?ZN4tCofpCNvyYkctZnlJS5q87pKLfyvhX9EXhIaGPxpxTxTuadsHSqBAXt9Z?=
 =?us-ascii?Q?f+8leTIR39jugkrrBTq1OjXob6jcIIQxZtj7JSMFmwqBdOB2FfnFZ6jF601G?=
 =?us-ascii?Q?Ye1yiJ4kQUXmJwz4Y6PddaNyVWko8dFdkW1P+RsgGCvEzS3ZDp4039bVRcti?=
 =?us-ascii?Q?1COvPDcO2adeZ+sWoQtHyrjusB5l7aI7hWIQYIfkkcoxlsEHltowykINnpdm?=
 =?us-ascii?Q?N0ovkYDp58dJrul7hdFRrUwUAitR7BMR+kjh5GGFksu6+6jvV3vq2LPnk6iO?=
 =?us-ascii?Q?1srkMPnJWPgdZI6lnrm3Uaf8inVvuPnOwvI9Nbc42Gr2sa1VPH/zwPnr1zF8?=
 =?us-ascii?Q?VFoG9zv7F5ETgn/EH25UX8FZzRxX+xaFRHo+NLATDMh8BpCmKq719rG/lzwQ?=
 =?us-ascii?Q?waXYSiJgrRfsLd/UOX8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c9dac2-b36d-48bf-0ae4-08dac253f95f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:11:55.1925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6zGYbzhXmXob0a+XMTRox9+6eHOWzxOclstNxLYkxbjrdv+Y1BMmtW954JXWEbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:07:13PM -0800, Nicolin Chen wrote:
> The prints for incompatible failures in arm_smmu_attach_dev() might be
> still useful for error diagnosis. As VFIO and IOMMUFD would do testing
> attach() call, having previous dev_err() isn't ideal either.
> 
> Add the prints back using dev_dbg().
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
>  1 file changed, 7 insertions(+)

You should probably include a fixes line

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
