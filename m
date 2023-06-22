Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEA739803
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjFVHRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFVHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:17:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF911BD2;
        Thu, 22 Jun 2023 00:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYZ6fJkdUlyMR/NpFXvY4Bw5N5tnPWuslLcMcyJcqKiOLp2F+5FCy09p4DG7e7ELSafxI40qSYJKxq3P4Ow1of02SCdP0NSmLCOV7CDj/zC75glE1wKB9QRcRmEVpzEJ/N22lvJaTjIMNffq1d3C/RaygOa+FYf7CRh9ALHWjqeBu4NrolNK0fXJsvPv8zmiMSisSfMxBcP8MU2MEWmAioAycu4sHHXB4awx7aUIF7r7FjCAuPzTxmfkHmmvCbbyrhR56moYjRpNWkVJ0iiXFVm5Gqo2nPEy/PGAJ4t9i22+yQ6ynCep9wyERTDLMgY7SCyK8C/AWVJ17cLRp8tVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbJO5dl/Q+Hl7eeacoSwO1WE3IME60RqXIwjY0eMBNs=;
 b=VDinrAVccSVT+Oc36jSWhlJC+6HRGKmUjMXNEToJVwFTTw28zbRGfz49gnRkeADx0fPY0/gMy921Wb5ADORtZkjwsd9NGwoaviFOVox+/5hhavEA37X8ZICCbIiBN7QZu2IMXabooy7oKJ6z0c3JP/TrF9FG/a7QiYMw352ZYasyrAGByLOM/XF6KGd+2hiRGPj/r6mEjZQmARHGsU2c51gt8toRtwCSoGpZt7jNerjXC549D7j4IKkWnmSmHSHYH2tVC4XNZBqTo4XNgUezyaS/HjDW3oTmQknxSis9pohShpK2MYWrxUk4JBcbtgUmwnk0gkNZlNwEfz1bmeEhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbJO5dl/Q+Hl7eeacoSwO1WE3IME60RqXIwjY0eMBNs=;
 b=u6063rYbtqXYT/idVjPAjJ211ndpPgpXPDjihtIXUcUBXVjCdFGENNwvku8xP/n/nGUiJ3s0pDPa0eLpTXKHWNZyiUIUbdobp9ftCGlbr+3fWimSLPy088cY5LYgUlnuOlzri0ofOmY7wGzhGyF2v0Pdt+E5NDQduq8RX+vJBgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 07:17:28 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9f62:7548:e693:1d3b]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9f62:7548:e693:1d3b%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 07:17:27 +0000
Date:   Thu, 22 Jun 2023 09:17:19 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v6 01/27] cxl/port: Fix NULL pointer access in
 devm_cxl_add_port()
Message-ID: <ZJP1f0XboCKhhR6F@rric.localdomain>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622035126.4130151-2-terry.bowman@amd.com>
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|CO6PR12MB5444:EE_
X-MS-Office365-Filtering-Correlation-Id: 150d90af-7bbf-4b95-583e-08db72f0bb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JsDfJIl2P07Qtwl6LO0/QfgXiibFpHwW5SIIM+HxmN7zyrQJ7rJQA8xFdlPddi3EjerD8PG1TyR0NTXARcjEUe0BeUSeitYh4/HtXeVob4Us4E3yMcPJPUl8joPFNdjlLD9uUT0X3N76yB1JFWxT4MvmP6YSVvenPCuam4jYuG20JixPD/GlvJ1+bjuKRx4FCyQRhcbxQiJLvoG9uty1bRMnsTRObyoMKeaC6PWqfu0mViQnC33NfdO7mgWFjzMV8Pm29WEC1lV+mHOtI0fi8AlzDgTz2rvc11tcXgz+7zt8Ia5N7arJlAcQR/DsqbwqefxQoTd7VWVOQ9PH2nku8pVjzif2W2RF6lMYmm3q1s5F1FygbHEGYQayiTcz85l4wVQ4JhkNfXmD7wVI8F+RkuTNyrcabtLoRmjk0YDd86TqnMY2kutlhe1RNcxzqTroD3nbRo+R0i9dpE3oqAh7yawSL6pm8oilK1ptCGkec4M/2WiEai6ShguYrB8pMH/bne8lPbST3YT6fAMy6UUwxpHlJlzAGFz601TR656X7aA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(6666004)(2906002)(186003)(4744005)(66556008)(9686003)(66476007)(6512007)(83380400001)(66946007)(6636002)(316002)(7416002)(5660300002)(8936002)(26005)(478600001)(53546011)(6506007)(6486002)(41300700001)(8676002)(6862004)(966005)(38100700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?txDZzIOPqMJx9uPS2WE0+gO5HqYSM9g/CwXet+ji7vwUyUlS6h0nDPCtxWkl?=
 =?us-ascii?Q?nB7M0p9DMgV+jcF+e+TcIlS6HpkPwyu+uEq6U1LY2BOMBFZC/uDwIYLvkQKG?=
 =?us-ascii?Q?xh2xefggrJtW2BUlXH9f95h1nmDJuC9Q7fTXE18YxCGoIY5fBB47jG7vQd/0?=
 =?us-ascii?Q?EvAvgZxDuKc7RO3s4YvnhVxnMvUMpt61Mvgv1ZpaIZE9xF+hPur1KyA8hJR8?=
 =?us-ascii?Q?b3iKKL8vAXFaCqgMCKjZW1oxfwCaOXgzRa4xgmaACGMBPyH/7pzPr0Es8ap1?=
 =?us-ascii?Q?+EK6/ypArj0l6H7xVdO5Q3Hzn33d201yeGgAyXmX44IZp2yFNePZJ1W0Vp79?=
 =?us-ascii?Q?oPF0Rc7xtkoi9ziDvae5xbjm1aMB3puoVsuiwBmmvaoLRWkZBtqRjFWrQRTs?=
 =?us-ascii?Q?g4jox1ojV9jUQfZb8CMdp9WUG5vWDRxurBQLUoQdRY+qrw9CmguC3G0J4ZL4?=
 =?us-ascii?Q?noBXzgVkTL9UUceDqAG1bju6g/dNSvNagPTKnW7A5x0G4hSrNbrgbnmiqV8T?=
 =?us-ascii?Q?cmIK1BaCJkoSmhjuXF1GODq5gCcqEPO3JcQ3D3jaQMLg+Ly38+cYq7i5m9bv?=
 =?us-ascii?Q?6MVAlH4naIMWglvqGSFlTYmjoP2L5guIfx3AFbY3v3UA+eByzn0PQyXtHyVs?=
 =?us-ascii?Q?PUHJOWSbKerHS9OZKuM72WB6hlZgTN20zUelqJ9ZT9Nu5tC8ZaxXh/xmNUj2?=
 =?us-ascii?Q?kmusGcV8K9CBtEVNnVk29s4ns1diY5gq99sxbkHkH1UIbu5zGzmfiITTRtGi?=
 =?us-ascii?Q?zaLEGll1qLHX2UCv2aeNZbn6FtkVL7L9VXAv8aE8SC4fNv/F0HHSgg0wKs4l?=
 =?us-ascii?Q?vAvjbTWhrXYcxyrVqex01XVkW7OpSgl1bx4yumF5KoIjSKK9IJLlKknMI92D?=
 =?us-ascii?Q?KAhzswJtN6lim2nH9nPfQ/og/CUsf8UpWzVV65HUuxvTK3zziMXlg7sDNW/x?=
 =?us-ascii?Q?4UwJ7/4wUKbCQCbvvZ5TCILCdoOQR51akXArbsqg1BvYxUkfIRFOTSx4FhCU?=
 =?us-ascii?Q?1b/bO6vc5NxWIuudpeZOrEJOh/lHUnutrpQDDMVvk2cJFeuQwp4UZx2B3om4?=
 =?us-ascii?Q?+Yt3n8LZ1/UCOvl1RP4VUBDSp8Cc7AWklvFoKEbKllLa2BcDe4ENdsQwwQvS?=
 =?us-ascii?Q?WKWXsmprvnqLF5V+LPwvw04OEJw76HgxIj8WBuyuPbYRE6KzY+nOrcK25h0U?=
 =?us-ascii?Q?2YPpxFWqhcs3tcIpUgBCwfZaquR89ZEfEnokUCuaPsxIz/bnlJ0Q4Wz/7ogQ?=
 =?us-ascii?Q?SX8H7j3R87gnvKAfwtXjRGLK5K8OR85B8LYEvG9LlKZlJukJjot/W95pfu+3?=
 =?us-ascii?Q?EytuW2FNR31p5Cn45TraeGTWJDxo3fmwj0GQJVVgAWWHw7pwIEGga6Ec7SDY?=
 =?us-ascii?Q?4ij41XZUlR9bglf1t7kHep1MAIQhBvVw1Y0wSor6ciKVm0TsSIG5WBIBwnjS?=
 =?us-ascii?Q?03W7peG1Wp7imH6xAptpr3dDDS/iRaQZMCGTVcg8UjVKEPiPgBfFQT8a8rRo?=
 =?us-ascii?Q?ajeu9DBiakJYdC3cZjvQvrbQyxo83iHhT5DdlT6/lzDEif8n2hgA+gi6taFe?=
 =?us-ascii?Q?BKLLCFmSleK1tPpoWsQGLAgAOeHteDzutJfn6I+A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150d90af-7bbf-4b95-583e-08db72f0bb7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:17:26.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bCKaJRbOJXIU7q/54xtjD0IJky1Q3y2Ijy1+Vk+0YxJ1xVFuJzCO/m7lOOjo4LqePMkAUkNftoNJsDLaZN5zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.23 22:51:00, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> In devm_cxl_add_port() the port creation may fail and its associated
> pointer does not contain a valid address. During error message
> generation this invalid port address is used. Fix that wrong address
> access.
> 
> Fixes: f3cd264c4ec1 ("cxl: Unify debug messages when calling devm_cxl_add_port()")
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Link: https://lore.kernel.org/r/20230519215436.3394532-1-rrichter@amd.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/port.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

This patch can be dropped as it is already upstream:

 a70fc4ed20a6 cxl/port: Fix NULL pointer access in devm_cxl_add_port()

Instead, this is the base commit for the remaining patches of the
series.

-Robert
