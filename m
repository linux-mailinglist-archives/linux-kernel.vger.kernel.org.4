Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBFA739DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjFVKDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFVKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:03:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D84A2;
        Thu, 22 Jun 2023 03:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3oIjmiM1sUKhhPCMZh6KM12aQDUOFAyUfhtRXa3XQGhTbauJkdh2vUM6StVzIwRQVXX+NJDyXw0lwtvOVuKvbVGLOTcTVy8geJeLmrDZTVe4r8JXWZw0IAlTWeQcvgNE42jHQITLqeQezyEsfYgJAdtVFpWSf2+zjHG5Ez9nRGBNMcTpyd0+Cj3eyVFICeZOvKtlf0Rn49EeRRPpsjY0Qns9N/rNZt3I+FcViC1U1hM/cZeRXqfz5CQ/bETqRulohG5qyRuGf1QVDiqbDZJnI7A9krl0pqtO3YxeZgHyV4d4Qyf3bNFsfe9TJhMQMePM04fy3M0tCk3d1S3QrtLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ay7t9VNHirwR/hjKIfC+7ayPSSNup2/i2VFcVan8IBs=;
 b=iXHPM243fwJpO2UyIO4piL4RwrHJ2VmTIPXko8A/4/9BBMcPt7bHFWrfy1co9AHNTW+Z8MSF+57Fk9ljfnReJPZzFV218dlmQEjKMlWXKD4FNLbTKVPE2PFR1iXT8N3lr0n9bF+HA4pZd85Y88G15pShZMCEdU9myl3d6j/eSAMbt5NXWGBi+6Ap9yPP/qskOD4CvZittDXLc+3GMmreZFgT0HpyGrkkL/NENA5rBniYwMfDrzRLsc6tAMk8z6ucMF34nWMkDICQ29fnWMLpF1D54/Ua0hCT6mvYwS1nq7E5RK4TYBsYvUhwc6XMbv6/7n/sE3MHlS5y2dyzhFUYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay7t9VNHirwR/hjKIfC+7ayPSSNup2/i2VFcVan8IBs=;
 b=yeNT4OZ+hivZVOm81rp6PO3R1R0vEug7NPdrdombUueyMS8MKQamVREZRa+Ih0vWEKbN2RfqgpHWUTVLNm91nkChZobdGr5KYDoP/F77oDfxVWLTb95D/UEW9/avtPThytb/WOzOm1k0F7eiRIiu+1kLogFRbJno+jOQlqd0Xl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 22 Jun
 2023 10:03:14 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9f62:7548:e693:1d3b]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9f62:7548:e693:1d3b%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 10:03:14 +0000
Date:   Thu, 22 Jun 2023 12:03:07 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v6 03/27] cxl: Updates for CXL Test to work with RCH
Message-ID: <ZJQcW8UJsA80Wkva@rric.localdomain>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-4-terry.bowman@amd.com>
 <20230622105326.00006302@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622105326.00006302@Huawei.com>
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 568bc7e8-c810-4161-4c6c-08db7307e488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHDFXhifnrUMVV7NLhLCPKYBR75/da1mxDBn+MQw4cSGNqzVTQg/oQhG/WSoZSNJAMnwbYcQDBMpy83gNK7z6HhEc2UOaY9yJBjRfcnN3+Duj14TshQdjv2xgfCufIQzIh+qVM9uow5uUJaWJz8i4TrXheJzKOFPOvVzA26YSPKSPjZNHTY/LDWj6SjdFNMc0nGaKb3+d20BcSxemLz04sPoKGVo4qOF98l6uId3fsCXKvhbiTz8nb1q1W/NJTpA4jAPLzNSb0Uhsbu1Mf8A/9njavy1mbD4ZRA0+CHpG0lfd7JgHWybN6FwHE9HhkMFNEoUoaiQPInJ2V7PyDQpImDLaKOwJAG/RS/0yOA+n2PMAyUYZQnRrYCm2sCSH6VCT4O9u2Bkfyf+VAoeEoMBpQqi3+AhwjTK2/pglloi3Yt/PgqAgzTYBp9S5MQ4Tzhmw0KIJxIHLbO1Wyq779ZYWHvYj8nofBArADNIHE1lklp57bQrKzlmIAg0UPEIhOXBrvIur3CxMgeykUa+3R7RsKta2uRPqUtzj6LQyvSe6J1hM08XUYKxWuKSJUotaRW1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(7416002)(4744005)(15650500001)(83380400001)(2906002)(5660300002)(4326008)(66946007)(66556008)(186003)(8676002)(8936002)(66476007)(26005)(478600001)(41300700001)(6916009)(6512007)(53546011)(9686003)(6506007)(38100700002)(316002)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v//DNzJQHruu+jaxkV+R7gEG28j3Ss7xa6azmsWXEWZnm/GNqowMBN+c5vsv?=
 =?us-ascii?Q?/OCJ298twexwNKsvpDgyVYPKm5vIkU6jTLymqqIvxFJ7WWfzUyr+bsTqCbK9?=
 =?us-ascii?Q?BJyoHAGUWhwcTrIOMszsULXguME+7IaW9AOzgL+hFZRNlvibIljOm4y3VFwB?=
 =?us-ascii?Q?d2cZM6dSp8ZF8d3QJoHF4nUJsS94QG683uHypvtOlmRQ7Q0kuONqtEgqMYse?=
 =?us-ascii?Q?1Au4hZT1njkqCDq3us9O4tPpw50C5uwt8No0veCA1TwdJ4Z5NRLTpiu/0+nw?=
 =?us-ascii?Q?BbSHHDJOl6tgGE2fnj+aPlTgQHEHG/JriWmWj/D30h2gY61Y4CeNytjc1LN8?=
 =?us-ascii?Q?hfieEXQayaC058glMhEWvw036dhQBhs3LGWmgDgxZmGSsqtdwemALVzyq9Ox?=
 =?us-ascii?Q?ewuMQXIbiA2uPs43yANd9ChbPkwKgEcvi/OZyA3vPVeO2zPBFltE5KzkvTTI?=
 =?us-ascii?Q?lkPi4xGcl10tKx04N8lOGU4DRoy7jHZMyYUfN2qJN4HtBUKvZSx8Q49ma7TT?=
 =?us-ascii?Q?duHpBCcErsA/275W9Pq/zi7N3n5mIuUgXrY5IuhdN5Hrjjx+z1aFKEHNTPe2?=
 =?us-ascii?Q?1/QRva3bgBlHrprXR+RFX+AI1ODwF3ac308auTzD6SnxNAg/uApj+D/F3JBX?=
 =?us-ascii?Q?Jq5ZYNHNlcE0x3eH9rJqX6Tl3ntvOJWtIW9XOtEo7dD2smzb1JDJbkG2V8Z6?=
 =?us-ascii?Q?KvsLRAUUNLdyzNpM/0OmhJ0ieYaxi09fpxwNZEOPGtfarMqFcmZzNxpDFLvc?=
 =?us-ascii?Q?LluD1CozJpyERLHj+xzg9ZD2jzunuucnfj5t0E5vpMZzrz27vT2z/qVK4wFq?=
 =?us-ascii?Q?/kPpcUyZcPK3f6QyN0gTtWzjvMkM04hBdlIxOFKn+YqhCwxO0USLnRpFUC+p?=
 =?us-ascii?Q?AqkS64qnZ4KqnC4u0EXj7TqMvlJUT+5oXuzc2Iyii5zqAy+Qg6azAk2tOgE2?=
 =?us-ascii?Q?azQ/mkCHel6pGXqyj/8HWzM1Ve8HBd40/jbiFrDUa1tfACGVVDyWI1r5oQ5W?=
 =?us-ascii?Q?LbQgobPb2I9q1Yckffom2YMTlILToCF9mGrag49aVstciYyoBRao1EKSotjC?=
 =?us-ascii?Q?IXjGEVJoVKAxERdD4Xk/amm7lz9fP5ZgiL6ydZXgNZ/5C14aDu7SgM+mdBNI?=
 =?us-ascii?Q?FIVBPm64LpIbrw4PH9ek9J73Hgei1Ws7lJWoQ5DzrlKXIftkfagLqeLPxJVK?=
 =?us-ascii?Q?BwMND4BG4xtT372CXxYUmlR9QIQs5mh0+W0p8NbUOIm9bdZJxhWM4YQxLcu4?=
 =?us-ascii?Q?SaMEubrWNmOYUdQZ8tKSpm1dx0ni+CPo968fAcgCeQrlN8YohcfBIftYD9aR?=
 =?us-ascii?Q?CpjyIYbDVcHkjWK9MeVmYSmRlhnBsC0cRmLaRJA40VjKTvliltlxzbMaM32b?=
 =?us-ascii?Q?kChzluqXERbqHae6cBUnCRS+Bg59atQApuuEH8mO41HDgR52xLQyRZq3iGH4?=
 =?us-ascii?Q?+wlTWM6e96+dmrTDKLcrrL4TLa62hNPs+hVcCaSqAEFbHf/Giu/gAhcrB7pW?=
 =?us-ascii?Q?QFOwsk3fc43p7iy9BQqnHsvdFjZHMHFembsA21bmfUd+S8cO17LR2nF2N9nA?=
 =?us-ascii?Q?DGWBMkC8mJJ+rKO5CIpir0eTQcs9BWI0kr6rsFk8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568bc7e8-c810-4161-4c6c-08db7307e488
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 10:03:14.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpL5IaOe358ytJ+iXCLZMMVTQ+KujPd1kdk3Oyc68nGBZGiSo2XY2l+Z+CaJF3M7X2hY4S5cs49U+6Hb1S2JgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.23 10:53:26, Jonathan Cameron wrote:
> On Wed, 21 Jun 2023 22:51:02 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > CXL test needs to be updated to work with latest RCH changes.
> > Add CXL test support for devm_cxl_add_rch_dport and
> > cxl_rcd_component_reg_phys functions.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> This chain is getting confusing.

My sob was accidentially added while working on the patches
internally. I have merged some reverting hunks with the previous
patch. The sob order can be changed or my sob can even be dropped. I
am fine with both.

Thanks,

-Robert
