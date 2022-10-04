Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5755F4371
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJDMqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJDMqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:46:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19117A97;
        Tue,  4 Oct 2022 05:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGEXz9TUO0i/LktcKZe6y6QjaClP5bW3ViZnQl8AwxDWdokqln5LDFjTL4mEy45NCcK5sObybU3cp0vyjcLj+b7GGRrSAn0pM2JzuVNgnPDsJx6eO05VG/lDWzNPxo73BazsGmR26NVw1esyDCrpiIiuj5H0W2BiCLQUUwNgdCRHZM3SBIB+6+ZIv0Hyeot7zu/4GdBGkKHxTcOoBqzol2biCOY0vWZuHAt1lPc0wMmc+eRsjgBO54m/GMZuY9zHXKQKE2OKyHQSoDZIsHQZxgGqyUIAKW3gDLx9cAYxkipK7xOrvKLo5c0oIvgisxvzwcmO/GLRLPW+YNDe9ijA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT+1nvZyFSWVtJDbuLPbESfO2MkshVQLXdPAv2/mAt8=;
 b=GyKdEbwpovEKheOUyvyB+OlzZeybYZ+Z9ejrGW3ONQ68aNF/pWFWbSJ1qxDh+f3DzIjkcayF+M6X81fDOaqkBxT+HmX6iPI8Cc2nBn9Qf3aVf1BcGKZhgmnU8OBQTMVWr4d0P0cA3NJcnjJrqkihM8PON6IRqLqQhq15p+18CRCS3fPcHyVM7ViU2T7glWaI8IWFnTAE1e4PPZHtfKrC1zbi3cRQPTVPLF+ukKgmEiQYrr726l1BCqSv7rEhNdBdfrjoYp3/MomT8SNTxCj6V2G7xm82V4VYGzCZkSupMGQMfI1PjxvRxF9x3YyrL+TbjZrnAYU1Z0l9xbmuPYmWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT+1nvZyFSWVtJDbuLPbESfO2MkshVQLXdPAv2/mAt8=;
 b=H53xdLMD1gFISGEGvFNby5ac0x6M0+OAPvOuPKd2gVz1YyXP0HUHDgqYi3zG4qUvUAiAABNrNP7oArRRFJIEaCetCiadxuqSexrPGz0/yUDyqOQdMWEMLXTZ41KN+jMx6+oM/bcHdOB/1wFSYt9gov8xMIF1XmPJ3NBInq9staTMpS5dxrs9D80BhevH0Y+GvhHE+htGGj0e8k1Xtak5a++Eve3aF6QEIqT51jlWmbijSWOagnn0lc4pRvLIHl3s2hy2xKHgBq7lT9nsdeD5fsz9wvgxrvwgAu0ermGfpYdE2lk6NT8wBcvdsnrxvAebrKeKbyasExIsGhDomjGbuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Tue, 4 Oct
 2022 12:43:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::8557:6d56:cba9:dbba]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::8557:6d56:cba9:dbba%5]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 12:43:40 +0000
Date:   Tue, 4 Oct 2022 09:43:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] iommu/s390: Fix duplicate domain attachments
Message-ID: <YzwqesQTmkjwoNbj@nvidia.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
 <20221004120706.2957492-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004120706.2957492-2-schnelle@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 39074925-b1d4-4f29-e799-08daa6060fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skeaa3lEcFOIa4DUJheLfaXAu8pxKqIBJywwVqlHHET7u+bpSgDkBmhgws1w7UHjNCc7Wkb/y5ZiqfWJTjBIHZga0uYU4m0mef2LiKiPBtzp2DM4P4XjF0sIIIKH+zUgJG+3PwUDdwh7Qi5jGJMz+54gtNgP69VGz/eOK2zRhQ4JeJ5rVGgedQ1WBz/aH2nzc3LURz3R4Rvq8vcoi7uOvdfGnw/u5moFpJH7YbYwhLmxe5HTn6KdLhew2aZMKKp73hth5jcyylkovc4Ye4NqyWAIOSSRwwl4erMpL59VB8mIbGQd1Q7YWpP0+z1IGYWTA9G261qLj9RzStCMwmCTvWM3HPOVawM6xmUJWFye5xmCDF12pAMki5CxhqECUn5/yXapBYhqxRps4xNwvCjeTRBGbxQR0xbcMaj6nUH7w9QQ+oC26KEWEYROtzwyOR4t32WpPZ2QSIT0xyP3u4HGqLkjeW3dBx7t8iEOQJqV39yVDllVMgDuh/12SSEagTO2wUsEgQXga1PkUIlSuSXZIKqSAyNP0bQ2oAJgMCul02uWyS04IBk2KQAgxR6p0/p2JZwcDlAU1HMSRw3AzJbDviUtQrN7nMvnzHIZjBr2QHgCll9FRYhCP/R2yhipglxCMV9izLnN+q2tXY4eQUXjUQURx3KfnnaUtWgArmnfJ80XT7cwFDqvz1eYGANHdHduR12bEnPnuxU0O1CH/OlipA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(26005)(41300700001)(4326008)(6512007)(8676002)(6486002)(66476007)(6506007)(5660300002)(7416002)(8936002)(66946007)(66556008)(86362001)(478600001)(316002)(6916009)(54906003)(38100700002)(2616005)(2906002)(186003)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?seWGz09AGmtVaOK4KDL7/D6bRfbG6MEKgRTHpHSvXE45iQuLM4j4GFDK7sQH?=
 =?us-ascii?Q?tILqGu9GwCigp0u14+eddb/ngrVYZ6rHw4rm6/Y3ZffTCvrUqsKGCod6EZTK?=
 =?us-ascii?Q?C8YE8KyNZQ3jXC4VF5xR3eJhae+nRM/XVub6DfSXcMAcluZaEjKZP5+QZCAU?=
 =?us-ascii?Q?UEFiLqQbXojgs24pUPtQtufHXeKavuT5kCWH3R93QvddfTgG0IIVz0ad3HkC?=
 =?us-ascii?Q?eG0qnwqLJ4dmaixWQstS9BTAeHELTUFVeh4Fs62CPm6tHmuCNo830ZcvBTvs?=
 =?us-ascii?Q?8aI3ucxiouI59u24qPvRfUrvkbXcx+r3TXnAB416ylSBQf/cvqbmDpZTZJCJ?=
 =?us-ascii?Q?k9BM2X86v85tzEtd2yF/qnD6kiBplg3HY3FO/zVpwZ/37txqmkbyJK7QfxNN?=
 =?us-ascii?Q?MUoetqMgOMcEXaQU3rDZb0uX6RPv/GIPZ4Bu0KeML3v7nFUFJk5JmtQuoSg7?=
 =?us-ascii?Q?DE/4wk2P+Fyjt8/EX+WDaMm4AbvqhAUUZ+Js5RZECx5lGUV5Tlbb0Zii3O2Q?=
 =?us-ascii?Q?cv6T+MhaO4GbXWmYia0C2OoQB/lh9GpaEYcYQC07uE7fwUY3yTC1xJpK3Wtb?=
 =?us-ascii?Q?qn5+M5diKeRYG6o+5MSp/V8WhGbMrVAjpnV+GNhP4aL368LWF+vGFnE4jd4T?=
 =?us-ascii?Q?/WesBSEkKnVq/jivAsMLxk6LZA2BjpjWV1Io2vlYWrRrOWOypaDm8s/EsruF?=
 =?us-ascii?Q?kcJ2GMmfMJHB41rPeyolqS68BO98j19TAY6kKUu1qg3EJCo2cACEJHqnkijx?=
 =?us-ascii?Q?z3kRgsX2hBV3giL8h1ebdOrjhWHeUPmb5VabSLxEZn+c6aTOndSxvl14qCCX?=
 =?us-ascii?Q?ZVTWslaYXRfTBJ19r7er+fVuPA20Mxrf7sg+W9HKGw1sMxSI8JrDat+cdMKb?=
 =?us-ascii?Q?Abon5eMKTb6Cdt1qApkhLDwKovfJJy/D5IwE1s2SlJ/6gIG5LYVeyg3rvZ7q?=
 =?us-ascii?Q?0tI7r5hFkbS/pn+i9h6KhFIKliSF2O1cXulWD5+a6Y3jakC+V1Z8RYKY6TYf?=
 =?us-ascii?Q?V/GS8VIcKSdiTnnTkbub1YMQQ0CUuE1mUC9OmTlIHcuAYUbvqGxvXsVJBd0n?=
 =?us-ascii?Q?1ddVuadxd/8AsCZ/1DMgnI0+k+oNj7a9Iuzy/hs/q1dPrV9H5vOHwOJFm5Ga?=
 =?us-ascii?Q?khWm9dLcWZ9n4cdtxq59+BpuqtrovHEW8Ri3iqc5O7AM5fpGIvqoCZzsp1io?=
 =?us-ascii?Q?PJ4EDwiNKm+t/nnd6586xKMN7YPnBkdTyIBjp9Wt4/DU14aJ4YPmvrIoNph6?=
 =?us-ascii?Q?w8nT5vxDNz1v5NSgdTi0uBvktYRhP1WCqoDRAy6OEF0+yUZ7eQ7fwUpBhfnI?=
 =?us-ascii?Q?mxEYI7EFa8rWI0QmxiZl54stZiG+ex5X7ZgA2VTy5OmrSawLUu9b3ZaKIq+U?=
 =?us-ascii?Q?ytk8TGuDbor+xXQzBMBoMk73iJlSxOjOk3OPcW6CWwCsqBOGPfXpL1uYXrFo?=
 =?us-ascii?Q?KbBIA69zt6o12eMASV4O3sGO++HUcRRtVR25rniD78f0vYjcKoYJifiHbINj?=
 =?us-ascii?Q?lMYM41GQ9YmJPLutgeoVmgwjE6Js+3QbNJrEfC5VBeSAFunLdBjhDntpa2Ne?=
 =?us-ascii?Q?B7wrVZV3sW836Br6cHs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39074925-b1d4-4f29-e799-08daa6060fd5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 12:43:40.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9gYga1b+9tsb+G+CD9sxCDhaqo9ORV6bRBnZAolTQYAtuYLcSvSdJ0JNIBsdCLX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:07:02PM +0200, Niklas Schnelle wrote:
> Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> calls") we can end up with duplicates in the list of devices attached to
> a domain. This is inefficient and confusing since only one domain can
> actually be in control of the IOMMU translations for a device. Fix this
> by detaching the device from the previous domain, if any, on attach.
> Add a WARN_ON() in case we still have attached devices on freeing the
> domain. While here remove the re-attach on failure dance as it was
> determined to be unlikely to help and may confuse debug and recovery.
> 
> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v3 -> v4:
> - Drop s390_domain from __s390_iommu_detach_device() (Jason)
> - WARN_ON() mismatched domain in s390_iommu_detach_device() (Jason)
> - Use __s390_iommu_detach_device() in s390_iommu_release_device() (Jason)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
