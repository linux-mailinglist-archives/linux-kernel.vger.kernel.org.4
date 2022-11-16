Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B562C6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiKPRpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiKPRp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:45:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533175EF85;
        Wed, 16 Nov 2022 09:45:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3fOYA3EOsEGRmsZrvmMN6SS8eDgcncB5WEs6ni/1XleaUM4cnlTOvyrP/LoVceKWSLLei9C2dGM6yhgHL07YJFAAPG91Wsji2wnIaJ4DISd8iVh/yMYAeBIGXOk8hE2aXmYWpzpALR6gbyjCEyYyCO/fBiXC4x0XpFRFjzud/wtr12cvCwJaRNjjJyhEYCUjZwGF+v2fvrxwR0ZlY3KWqsFMBcNVWJkiz3lFA7M3de+6M6ORQ2Oso4Sv2iu7+mlcyeB8pcLoRSYrQQejBHWphOA5nyHCuA6LVu4ncKb24PPu6UlH+ZkEmeNSkKxot5Zzowz7eAIuUNw3MAbXTvuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FThCLDuf4bZcjs1K62A6tC4aXQl1m39/6v61kDp3I2M=;
 b=W4WXBBQ7dj0IuqgX0LUaXlsfFA9OkzBiTQe/J1Yt/uIJDNEZHc6XbQtvpa4TaxdILlZ8izL5JRnNMU+ntgU//5HLpicj8rMAosBGGtDvLfvVaLvqxvFb4KNkDS3yRUCmnPtRKxZNamYEtIyBoyMiWFm4qMvUXyablqkStzHzHr2WUqqn8D1Hjz2uyWzH6ndwgEe8wLP9Mq+FlTDLsUOO1ZDS/wcs1BskhBrwJOJ8PrPn2JwUOERryl0cUQoWyNZ0RVI/di7NbE9pBwoNguF6IDrgQQJBShYZOqk1zUeXEKZkQ06OdXSRcsSBx1+V2qWVw5QFTRH0Opo2assF0PRYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FThCLDuf4bZcjs1K62A6tC4aXQl1m39/6v61kDp3I2M=;
 b=FPWjy9XF6mwnIe7+q2mUBzQe09mO/Pt5XbHQ2o/wfrVNZMsZMZMv81h6gRFOVo1sLkjb4B+8GHJpwEwYovfJ0cZq4ieAyF0GWfcBXvld/zp0g1imftuJHlw9NPEnl7ke/gDR85/d0KmwbaX2cPW6Fi/lHfNXVJp15oXTQez3q0rl0ysOHQvz9QgKxRCNyyw2ATeJCoTGlHY57tc9EabHUXZVmkq0kD9qiKv2BrTe1bypqE9OUhnNysSN39NEIqzR9zT4TwzRMeVKyvSoglDhnBmItQb7KRqE6SyjQ7E9+vPNEEM5dntBsN5XfYOcRsMe/Gs8BqvNdOs9qk8z+Oa7uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 17:45:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:45:26 +0000
Date:   Wed, 16 Nov 2022 13:45:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 09/39] powerpc/pseries/msi: Use
 msi_domain_ops::msi_post_free()
Message-ID: <Y3UhtIEpiQUZi5NF@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122014.120489922@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.120489922@linutronix.de>
X-ClientProxiedBy: CH0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:610:cd::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf107a2-4c46-4afa-43c8-08dac7fa584a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p48AXycRitWQB4tW1Lu5u/osYvIpSrq4vLr8BtURnAvYAKZ1z5i/qcQLOr64i0/yMliUfI+w1bx9r2DCZvLI6UMVhfCboivxS30ExNsz+CAIYzFbwTUy5lcWeXozS1+y3N6NFfYOSOAXzRNjcP+tdE0V59emsRzLAu/AlpaRhyMMaPmQPaLVCw09mV+7RZXQ4NhUZfFozd6QmE/FDnNtwAHt45I4uC4n25Fqa/EgSlpiGrQSaksJB9CRYwqrzr8tL3gMNVSTS8q/HasNfMLO5UOf2FuIw1tL70oeSMd5MYCtCKJu5bN7ksezEBSt6bdVJJrtLCtOLduS3s9+PlYN5fuQcco/07MpcU5goHdqARqbmQS+lygAhQI/7PEqHCTPlq8mswQL3DF0pjQnNcjhoIHWCHPZsXYlVQgvBJUJ3cwXogIhKfgbfkFzL2CqSRmvgUpoeJ4zqyXAxTgKzoIzKilU+8AaRnZqTxVqidPevrdi1YDVbmqri8YAY7ndQYoaCQfGnCfMrXHBHVpfDFCTK8LkW16/Nnv0sNLoV8FAeENdDU30E1sCWhKxgyqa8edgnSR86aYuvq6msBaTqdwfN9ahrRl3y3alBLFdLgd3B7TXpjdt0kjjio/L7IHrBskXzBZdnVkXkL4muKSF5Eqhbf56B9yvtfBNVYqT3r3PaEBIl/ze6jyU9YTlFjxtcBqJcACkG476/CHmrCoKnNS78g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(86362001)(36756003)(2906002)(8936002)(38100700002)(4744005)(7416002)(83380400001)(54906003)(2616005)(6916009)(316002)(6506007)(5660300002)(478600001)(186003)(6486002)(66476007)(4326008)(66946007)(8676002)(26005)(6512007)(41300700001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sxSC7MKZrlDG6Tk0mulWSSAoeb2f0GMUO4UHJXhYkXsHT74mlgCL7XSYa9mB?=
 =?us-ascii?Q?+wzXaaebay/tRFlin69dD7A9pc2/adaIVkmcHZxy0vnKZaRJdIhG25gSUCiC?=
 =?us-ascii?Q?j6WbF2iGC0zr3wjvBsyNPSRLuOhgQA1XObMNaUik0UvyJXtBzdbSN74B9eQM?=
 =?us-ascii?Q?AyU/aJ1EaNTpHjXNL2jen0T273HuxQgMwwQGZVy1+0rm+MIAY+iM7+uKm3Us?=
 =?us-ascii?Q?CxDbddqsAbfmFnl8X1knMPnIJle4Rq/3DRsr6Cw5na3Snt3IClTT4/LRlOl4?=
 =?us-ascii?Q?cg4a9WoKef04Vw5VvN7jAgWEcW/P3Hf+OimDOKsMQF7uNoaxxW43CTYIiynQ?=
 =?us-ascii?Q?Kr76bh5p3yTtL+2Fqe4tw793jwGAiH/f7s4E9G9TiWVvWcvy2J7NGZ09iIFR?=
 =?us-ascii?Q?A1IHDo3IVCsBARTBHeBXzlpeQUu5JhTnF6elrdtsvtKsAJAGPZxbejtnsaFI?=
 =?us-ascii?Q?7LS1eDcloQjDwSwV9P2iH4MBJn2MUTETidqewhczQjMVTNVRGGSwN00U6vG9?=
 =?us-ascii?Q?mJPMYVUZBi+fQM7Ym22FtxadoJOMI5d5pE/UHClA1ODhHKpaSiyPaSdqYmuu?=
 =?us-ascii?Q?WEOqbVY50T5l33+hCf2TJZihuvi29dXwXdX/HWvKfIcotVxDP5N7LvJSwZky?=
 =?us-ascii?Q?FrmTUFvyXlB9XI/r2l+VaK1OeILEaGnNSWO+ZqNCLju0v32PSeq94TkNOF3f?=
 =?us-ascii?Q?nMPZxAppIl5n2Y7c+hlHyOKf9Gls2+t1tpV/L8467QXJ/LFRW92768WOLceE?=
 =?us-ascii?Q?vYiWDRMPcTn7JQfkufL1eKdyrI32eQYCihs5aGz82GGqLl4+N0J7RmpaRbSE?=
 =?us-ascii?Q?r6bcaB9t5McR2x9tHygCWtk/STVmOWZih07NzZeVlxSyb2NOyYcbk2kMHZK/?=
 =?us-ascii?Q?4N6URIYw93lgUAvZ/u0cPXl4HaEpFh05BjOYXXTfqmRS8JHl10KsiCJl+HDG?=
 =?us-ascii?Q?vp/oy3tYjeieY8oFbRSltJvJL+pn5KjLDmfwR2fejyfSeWke+djKC16LYC0d?=
 =?us-ascii?Q?gTeMmVv2v/q9VQPrv5aCmgcGgt31N0W/uG1wGQ6vKzvIfirqWpeN+LskWHIu?=
 =?us-ascii?Q?2ye6Up3WumYViUflZUkvA4kO4lVLvJU8S5cqujmFcyQ3EzWlxZDKXUBo1fLI?=
 =?us-ascii?Q?Ay/HfMzeksecHvs/+2xFqIYmJOZl/AaWtKNmswXCtkkBaxoffbacwGRnQmGt?=
 =?us-ascii?Q?3aOU1iVtzzJcdVR1Uh9K/UbfXiTqvu4gmamV+lnHqzSA/apJNOE9rZHpMnKM?=
 =?us-ascii?Q?XiSCpdMTJG5fkNtTIejCGueQrgYwTpcAuN8gRSBgJcErkBOWDIwIoNYikhB0?=
 =?us-ascii?Q?aFaAkM62U4HXczFqD9u/xuLFuksJCzvfJssSh8NOVGLxVH4DTaCWalF8vCR/?=
 =?us-ascii?Q?IVl9gNlwhR8kopdPMOSdueXv6lZiemkBT1tN5o5RwCIDMw57CXlOb7y64enz?=
 =?us-ascii?Q?VErCOvv/IXLpK95/jq0i2mVDbiFsK5SJ0bBz2XLgB4d5eH0TsiDSvcaPTfYn?=
 =?us-ascii?Q?v50tWzai2jI90mFH55BdGgSgePbUgpygL5DWlHDskqncir6NGbQqAqO2pMxF?=
 =?us-ascii?Q?bll7/uUGS4Dd2sroNkMGKnS6roS5HgAcE7wwUGkG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf107a2-4c46-4afa-43c8-08dac7fa584a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:45:26.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLAlHKUYCz0jz1HQAsk4opjtF+69qzA6XYbVFPWiAEGi+eHMQyMcOZzmIRMh8pRM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:28PM +0100, Thomas Gleixner wrote:
> Use the new msi_post_free() callback which is invoked after the interrupts
> have been freed to tell the hypervisor about the shutdown.
> 
> This allows to remove the exposure of __msi_domain_free_irqs().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/platforms/pseries/msi.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
