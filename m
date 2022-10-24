Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C364160B58A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJXSbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiJXSaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:30:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD7B56D0;
        Mon, 24 Oct 2022 10:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2+NmUTWFxgAGCbL6HMLNEF361RQo3qQcy/MoblDyQEPXllGDUO7vk0HFc5L71M+RoXYT4UcTzApIRhSjz53LCzm7poa9xrxeRrf7v7o4g6hWSw6c4ZuVsFHDUmElsG6Fa70+0UOurOIME20oNfOLs1InkfcdeQ8rhDp+gVYZ4S11cw6peK/YoDT81jfbh8i48+ouULf/wlY79rvRzaMsYymrj9pf8WDazsUKdcDN7dNYLxfC9SuiNiTf+Q5yim6YjycwpYswdJVNeowhyn1m7np1kVWPyYLSy5w7ZvSEYOTOPJ7I8Xh/LVdV99qJcnACVgcePDV3Y0tq+cWUbPMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9hUXXs2kYDNQaRMZkmzF74hqv9ME8boanGvCHSki/U=;
 b=YXoHOiMg5otJ/BNgBcVN4Xiv793FTm4Ek/8LziPZqjJeCzrDmnrUCbmAptMXTlWEHGVUgzgbgScDArdTkQWORfPRXY1qPhZm4plKlkGQkWpyTBId6/6L2sPQ7FJPJm9uQ7fhMauvMHOu7uh/ckPnux7bm0BHtELGi9di68hlLh/ucVeT5d8+fO0UBcVW+d6kp6Pwr7qXorhoqvwLNW+spl/KvQmkqSmPMtVvVjBVWw2rmr0G6xJy98qN9uuUApfFYO/wEkJdAWnXwZhXQD5ZdC5ELoaMxSwQI/WkTEygAW58mImEpn+bGIG09RsByGzz9pqShNkiQdRXxen+Bj5OmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9hUXXs2kYDNQaRMZkmzF74hqv9ME8boanGvCHSki/U=;
 b=hlkhswsn50uLIIyU996xiVXW2wN2x7Oyk8OANIDes+w07gmghmSwjUrVQ7Fo/cZHbzph+MoqNYkbAZ5tOUhOj+lreT9sjtETEeIl8LbvOGjQSmbIfG5GxIyb7ZK4cxCh/XsszAl7F77hTtQ7dgpyymCQ2FmgaFEcavyWJ5RVvMRlw0Z6su0r/Tq0gFAUx48MbMRTT98em0Vnm/+oKpu1eSoF6MkdvADcX3lqKbT7SJLPbkZPQkveu+EY5OjBXlSd/EStzifjSG8kMVvIfbSQr8JLr0jXGgAHGFdWhMeCSQKng0BkjU+f/k8ofqaIEK0k++ropy0ZzHJQ7ve1FDUzmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 16:53:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 16:53:36 +0000
Date:   Mon, 24 Oct 2022 13:53:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] iommu/s390: Fix potential s390_domain aperture
 shrinking
Message-ID: <Y1bDEOar1GacgfkU@nvidia.com>
References: <20221017124558.1386337-1-schnelle@linux.ibm.com>
 <20221017124558.1386337-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017124558.1386337-4-schnelle@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:208:2be::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c05bd49-219c-4b13-925a-08dab5e04b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jYBTSMRGNNyBUmJSEKr5BA/037eJhtZj5Sl0eZMiuAUMtqaL26IRLN1j7lmfDf5rNnXRcgzv5CKnGg8wZcW+CHg5zTTkHUTili/l0n7URtRQIkXUFoMdCJGNw5H9eW7sCf2iwVrMDelNwUVkI0KSTnzyZXsxjYvGYKaD6TxNSHpugKhm60beaU5LN4CaKYrYpQHITyHK1Fcna3bjGAcI6kVKAGbKG4w6CsWMpnXh+XCPGK/5Ajq3SLrhSXtvnSmxRcZ+Vd5y9ioTyJu+pOCegSDLg3sxwH0PgpeIdClOZ3Ahw9JaHn0JSgsSNK7UXiUFcf9t0KhDVS8nWohj0/B+uVRWZlYkkcwA52WH9cPX+3rwsX23dLUeNRgHlvzmxveaYi0xc+30kZxiywxjduIeLEl0u/zBNHc7zUGB250sfmj6Z6uLwr+18QDxgTXEsyQA3B0+l5a6MUC0TZy4jrlVC0kAEG2vuLu/6Ax9BNPCFnExYrvJhORZjy8J9Wzzu5ge1I4F0bDgqsB8Qbb2jnIkiUaGbN93A1B5qFHf2RKGN/ZXjG8tN+MLqIvgqYiKB4z2sDwOB1lIuRrTDdkNSSnTviGF87vFDnviZLG1lokSv3kGKSJRHIiomHMawJ9xgamqVhgEP+jV9XieXIB/wwGrF8xHxE7CtOTHP7IOtdJoWrNuneO5i5OlcUWTbbhls2Dmk/TV5Q4YYU8F4pRsqJ+uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(36756003)(66899015)(5660300002)(66476007)(66556008)(66946007)(7416002)(38100700002)(8936002)(83380400001)(86362001)(6916009)(54906003)(2616005)(26005)(186003)(6512007)(6486002)(316002)(478600001)(2906002)(8676002)(41300700001)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HevA27V3Gn4dpyzG4+cp9nvl3Gsck1+TlMOvJK10W45J2HTmR1hHkDskQL15?=
 =?us-ascii?Q?OQnj1nLagLCVqECv+lEgsaf2TAh2LDpGec7vRcW5xP7fyWZlHfcNuA1OpnLi?=
 =?us-ascii?Q?7WxEpE5nCTWtjf0dPX71gAA/5Iy0sMCPF9BMviqLrTh85+yqTT7KB9idbIpZ?=
 =?us-ascii?Q?JsnzOkS1yJl+jNnaCTDQP6otSqVQkyLNcAPfrHGpAv3Jb/p0P0yfW0xtIBQ4?=
 =?us-ascii?Q?f+jOA27UeCusAdzv6vOlxoHr0sj5Q9vqSWvWnJjkfPXyCvBYRXCB5hPuqaYS?=
 =?us-ascii?Q?Nvhpd8V4iVMLN7YQoOAT6VwzFDXXgLY71AcsCktZp2Bnb3Azajerozt3cfTF?=
 =?us-ascii?Q?SltZC+DeukN2fcw0uUKFTlIBvg9zfo5vFLY8Sp03O/0ZimXK3g/MaIYFbVDy?=
 =?us-ascii?Q?VHNX3ysMzDpu6puyCCDwj3wd3qcw01t8Ry3MsiU6Ao3vvgfLz/UdhTGyuBCT?=
 =?us-ascii?Q?J1Nj9yJ1YnouXE+901BgfgJxF4q7kz1n4U2sx/VdG4reTMrbYdeC/eJwzpYp?=
 =?us-ascii?Q?GjJQIk0EPLqECzGuaVsrXFxkhyxMLOt1lCyIJCnlxXrxwYzZDrqwVvFjT0p1?=
 =?us-ascii?Q?rD1IFiaZ+59o/9jhhchW4WatFgG/vjlQMUu+qm19W3dYMWwMO75Y9LvQPFkV?=
 =?us-ascii?Q?oq44OnEb3wE49e+RbT0n3pxOrN+y02RHT5XuSQk7V7RTLbMWfeKOXELHae1y?=
 =?us-ascii?Q?zavIVOtrJ6yD3uI/ne9Wd2utDqILWpUue4fqEDtTJsdp7vthcTEzkye/pPPc?=
 =?us-ascii?Q?QC+LReM2MB+hw24h7UgVaUNu5pivQzGExFIleS0XzVNruTk4LIb7SMeTTdfC?=
 =?us-ascii?Q?oqNrh6OYyRi7J3Z5akWxgNfhI8xfj0C/7laVJ9P/23extNdU1AHPJHtjIxTz?=
 =?us-ascii?Q?ffnDvEWz2cq0HkLivjZb6lkGNsfKMsGOm70XkvmMlCyk6hbndC+RgPla47B1?=
 =?us-ascii?Q?ZMKJVLI6yGiSsc+Ifv1dTpFuJRSQwMv5W6WA8W0GKTO4lYUJbFmZqR2yc7KJ?=
 =?us-ascii?Q?kTu2ZoVdsKUufZkEATlSwrdQaKtRfDk0oEHgsqeuByfYpsx8DkfyMx1wvf+h?=
 =?us-ascii?Q?Oe3aqPJiyF499i2DSQJGbBq6hHV38X6lPavsP/W+PXhjIeKFfsivBC2Ezx/O?=
 =?us-ascii?Q?OeN43iOgsWpgCGv/8DEubuhX9FUQoDwGKKQoXzykrk84v8F7YwUo/mYtZ0tw?=
 =?us-ascii?Q?k3u3riNCxH/z81tGeN53ljFhQjBh9Lgq+auoGyJROKL3skB+46/h9Psc/9KC?=
 =?us-ascii?Q?OjfOgGdZqkZ4ClE8OkyADAZlMQAEBGwOwdxQ5jyUzulSFCIY2HA/4se4WHLd?=
 =?us-ascii?Q?YaK8cS+HD9Qniqito/+QYssuKwGnRfbc1l33nL5YObEh+ECEY6bOO+bJjtnF?=
 =?us-ascii?Q?aEiAVk+J03ulcby06M5/MDrzqr4rqNpVfrGvdD8WlbSSffqI+HW3JbJ0RToX?=
 =?us-ascii?Q?QnohIWvjZJ+GaEEo2Pdk6RFJ1ehX+/3TC/95fPD00DpNZ5F+HF6Y5hWe/GEw?=
 =?us-ascii?Q?hMYRucBZf8092fQ2mwZuEvkTCL9JXMC/9tIgnTKsMJxiNbVtlooUz56DbUvy?=
 =?us-ascii?Q?i81JqRTfdauZs3QV8j+kdpwMj0bWdHcU/s/8HeNs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c05bd49-219c-4b13-925a-08dab5e04b4d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:53:36.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYowGUeZvqZEnFtK4nf8mwnLFl/AdB6FP1zgi3bqAnZ4iIpXV+snKjYdCvWPQG7/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:45:55PM +0200, Niklas Schnelle wrote:
> The s390 IOMMU driver currently sets the IOMMU domain's aperture to
> match the device specific DMA address range of the device that is first
> attached. This is not ideal. For one if the domain has no device
> attached in the meantime the aperture could be shrunk allowing
> translations outside the aperture to exist in the translation tables.
> Also this is a bit of a misuse of the aperture which really should
> describe what addresses can be translated and not some device specific
> limitations.
> 
> Instead of misusing the aperture like this we can instead create
> reserved ranges for the ranges inaccessible to the attached devices
> allowing devices with overlapping ranges to still share an IOMMU domain.
> This also significantly simplifies s390_iommu_attach_device() allowing
> us to move the aperture check to the beginning of the function and
> removing the need to hold the device list's lock to check the aperture.
> 
> As we then use the same aperture for all domains and it only depends on
> the table properties we can already check zdev->start_dma/end_dma at
> probe time and turn the check on attach into a WARN_ON().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v5->v6:
> - Return -EINVAL after WARN_ON() in attach
> v4->v5:
> - Make aperture check in attach a WARN_ON() and fail in probe if
>   zdev->start_dma/end_dma doesn't git in aperture  (Jason)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
