Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00215743CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjF3N1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjF3N05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:26:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6B1FCC;
        Fri, 30 Jun 2023 06:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b24kObuygz7jiZRN84ucDIJ+2Q/EDfR9WkQkuaidQHdE6W7F9LFnjlISf/HyVMRurDl+g2EPmkS1zE/GQxNXyGWt6zzOyqujhqKyTMpPFLBQO4/QCIfPjg7KtcTKHmsBudobIRvHMqPQmcSe5hYmACo8IPxQGrLGTk1bWdv3eBfFCQR7pWvWUqfJJxQjK+X95YLof3ov1CZbvvyrCudgX6iznLf2sTh9aIbB9eKNmzLCJ71nnsZuNevUi6kI+rtTLISmPzwpfGX3NSKpYFg39WUf8sUbFZRZypu8nmbBoHpzKIrE2iyIeerbPMJsD8pKo+cYf7HC+ji2F0ChhDhDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZNJ07vd9B0hyhXzqSFZqfLALYm1Zcg4Oi6v5+SUXPY=;
 b=cmbmc//xwY8N+foY6qav0ybjJ2DjjqR9eCc1X2DlGZkw67lWVOZFF0oWPcWbULtVePMg4F3Yb5CRagWY3/PnzwOQbRse+IqAduO4luDzzB5nf6ybrP7Zi17htitB6LHeRVBuKYHXQ6EzCFe5ZCdqdqyy4Cft+VSfsJNTwpilAb+ZUXYMtoE2e75p2kJevALfhDrc9LtAxOLHYiNlZs7Xn+Ck7tIi0UU/6uk8nAkx5y8/RQjoW3dBBp6JPNIHWN2RPnxzQfHMFbjYVXmbAh82nxTKmG2808KvBhDoCQ8rWCb4dudPKtIwfSqV/z92BWK5lRcqIvJcm9XUPxf27dg7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZNJ07vd9B0hyhXzqSFZqfLALYm1Zcg4Oi6v5+SUXPY=;
 b=eNdI5+OE+LcuIg4NE/bFC8d7eiLVIEx3wI3wR0uNpCwOiXzZBaFyIK8sSJZ6vpx5wvriCwxsQgKBN2WAucgwdsGtF+Dx4r72NnmVKpC2/Bs0hp+qxBwO8rgF7Rp8LSW4VY7NX5zztgsHOe/sb4uTajSt1AQfQ47M2u7Tg+mOVR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB6100.namprd13.prod.outlook.com (2603:10b6:806:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 13:26:54 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:26:54 +0000
Date:   Fri, 30 Jun 2023 15:26:47 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, sgoutham@marvell.com, lcherian@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, sbhatta@marvell.com
Subject: Re: [net Patch 1/4] octeontx2-af: cn10kb: fix interrupt csr addresses
Message-ID: <ZJ7YFxFOKC1NLMwa@corigine.com>
References: <20230630062845.26606-1-hkelam@marvell.com>
 <20230630062845.26606-2-hkelam@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630062845.26606-2-hkelam@marvell.com>
X-ClientProxiedBy: AM0PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:208:136::33) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ebfd83-4309-49c7-44d3-08db796dabb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0TNt0sdHF/1QxqKfj6NFnq4A8wVDdgugIdR48HaVgVrg94Y6JxHrTfab5/7Si+Ik9ex84pmkEPKhb4eoGHrFUvI1Rov/cRAC7d+QRYEh7/feGuLLREXa+hxVLj2EdpU+GKr5tEZX9mHkrBH9tNFiQbzGeItTjk/NpS8NB4TIJLKVBmyghPqzFyPzaqZTs/DcP0Erc/YK8stSnV/Ehp+SZImMoGiBkc9vGKp7lgCVsjjbuTz5f8VBOeUbciPsmGaMuC2Cs8ePG6ZRNWKrU6a7IVaUSZAU5W8NZKTf+ZXZedsMMBCiruIb1sMyclTreDwdVFqDRjTnAxwMCYei1qNa5dHUlXSySloV+71Ne/spVPugKWgiZljO9FSkB0VhJHcrfwh1raBCvkR+uEYSIygf8Rj+XgCmrglyRbpz+YPkmkIvJtSIiiHgwdvhKjHG9nGnJsVqwSQLkX6Q4+ckVws5mvE9W9mp0Req87HGttG/yCcEDJCGrM5hn152OUyQkUEIMvhm2VY36Me2Nr/l447hBcGeCIMkh9DyAkVDXuNw6pO006NLX0hpfahCuE9wtSpjUXYC++djsqaCvkf63A0hKuVwbwm3/42NZ6TNluA6oA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39840400004)(136003)(451199021)(41300700001)(186003)(6512007)(36756003)(6916009)(66556008)(7416002)(66476007)(4326008)(66946007)(86362001)(8676002)(5660300002)(38100700002)(316002)(44832011)(8936002)(6666004)(6506007)(4744005)(2906002)(6486002)(2616005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?335AXMIPEsHXXw4RkRAUXSB1O8/ev/xHlwpU79Wu+ttrGjyNSORfo+ijbgeX?=
 =?us-ascii?Q?kTqW0Ngl9lXMLDHrsdQXID57YvjD58DVqan6qL3NXQF+rcudPfSn2DAOL9uN?=
 =?us-ascii?Q?57iwhsPWcnaesncXGZkjvO5K12Uym1cFDKXuYcrqkXxIk0TxRvnDQ8lCWGkv?=
 =?us-ascii?Q?NkAFU0Qotjp4E/6gPitn/O2P9x8l9B5sitDFxkI1ZqRq/oOfnQ2oWSuCQTGn?=
 =?us-ascii?Q?l2lPS6giiU4b9I5orcEa9/t7wEDEzmL3FY8vx5IzQU5r3XcgWsY0XQhIZKdK?=
 =?us-ascii?Q?jgQbPx6MiPZtgBrSVWLqJ1VWutnVAadn2w4/apVqzyDYbtQGAaCHR/OcyR6Y?=
 =?us-ascii?Q?jtYzYdE5Fy0ulGNZOk25edoUTNAtdsIoVy4QwLA9M56a6B3nYPo+SRcu+rzR?=
 =?us-ascii?Q?f/Gx5u8maee8hbEbS+JoU86XqNQrqCI/L/XuTG4FNByqNhD28O/2e0i4+lwn?=
 =?us-ascii?Q?Lj9qtjI6RzVK6r+eBd3aQRxivJaeAPgx/c0x/h0cwxTBK8KDB5mJR6a/RHEA?=
 =?us-ascii?Q?zfgvdgHYdU+fayzqMlyL1jxCF9z8lwFXIbLAiwo6rCGzej1BmdoUNjxsb96z?=
 =?us-ascii?Q?062peHK9u1DVclTm6qwaTCAB76ZK2uCL60FbAKZL+QzVyAKx0LUw44/EmlAb?=
 =?us-ascii?Q?2zCAbTCsjjyIIu6ziiw6FScBiBtx9xbAbKJ132E10E3ivQcVb7c75BDrmCgA?=
 =?us-ascii?Q?xD5uR99iurA1gM9E6YbyvUIDLYaDSYwVsC0v3Q8UskToTsS4/zYEtK6znmw9?=
 =?us-ascii?Q?wbTgAQRvMhUwpj27+AY/Z0ehmr6oZoX7BBbSSsVvLPYmlqmxpJPWHTHBTHal?=
 =?us-ascii?Q?tFVUR6YTAAVlt10oMeAWFuU0wFBor+ikd0+MGq7pGj8PX2mQQR6zbm5Dtq7K?=
 =?us-ascii?Q?WK1DfRAwenZNzMfnvareX0AlUyQcVmzrFKOX3svAsJUc/yFHZ/5ocq8eovFo?=
 =?us-ascii?Q?L3QQkw8534/KG494L1QiWwVZoY+/GPan2OX7gPvplCRJcHC9Z8bK8D75xuEp?=
 =?us-ascii?Q?cwI8uWaxPrSDL5phIgW5T9+d+f+2xIhvPYG2LCnrCyuyWQgV3P8cYrWnJ7oW?=
 =?us-ascii?Q?Sn/OlFBLcnd/hG0lyGCPjLvnuuS33d0G5u+CnWGhBXUSgcADMrK+ycrzDAfe?=
 =?us-ascii?Q?Hv5YM0Z1sclKWuKof8VHatK+VdhEX+W7Y0F8gcfdIxM1NMRC7Q3Cz6BPMaLt?=
 =?us-ascii?Q?eURDAyfURduhWhdzS+fKmlqPu+kArsJ2LPIwFz/JockorpBOlt226MT9/p72?=
 =?us-ascii?Q?fMAlZO0aOy+cOyl/8Iwa5jCxIG+9u893FDw9dfddR20iUIDaTUO0WY/OpMUJ?=
 =?us-ascii?Q?NqMfTiw4fhbqQzVNvXl/KMJ+fk30lXOBUXCgu1uxJVDcHlg7cRDr54CdMwA8?=
 =?us-ascii?Q?6ZR9FLOkGg0K3VOtQKGQoSsDh6tJyu3jGq4okWYIs8e6WrRwT+Y2M1sFgdAM?=
 =?us-ascii?Q?TeEXxY72QUug1+gKKWchEz/nx9cvCyeCpO6wb2PiGmmDtPfy3lQEzA9BFzBr?=
 =?us-ascii?Q?uCnpGeJxaM+pbhlj1sPbto5ePUaOABtp63TEVjL5VkwoWW33OUQGr+NEW9iM?=
 =?us-ascii?Q?m0qocbZmWi+IG0VK1StxEa0At1VTHhsjwH8B2QoZSKB9FpYHFkmdUUKtI5zQ?=
 =?us-ascii?Q?5AW+Zyl7xqxJRzZaGjuQXLIjDn+BlKIUYUNh7d+p4mN4nJghqlHkuxTjAA/T?=
 =?us-ascii?Q?rBmFNQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ebfd83-4309-49c7-44d3-08db796dabb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:26:54.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAVI8BY8duMg4xLxY068X+msPGsHnfKx6/MqCBdMpAZNZvWYnFip9CQT0Hx3Z99IIG9NjV1eOp6Fal4iERDX/7keXvZCnfUTtq/PEg8WcAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6100
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:58:42AM +0530, Hariprasad Kelam wrote:
> The current design is that, for asynchronous events like link_up and
> link_down firmware raises the interrupt to kernel. The previous patch
> which added RPM_USX driver has a bug where it uses old csr addresses
> for configuring interrupts. Which is resulting in losing interrupts
> from source firmware.
> 
> This patch fixes the issue by correcting csr addresses.
> 
> Fixes: b9d0fedc6234 ("octeontx2-af: cn10kb: Add RPM_USX MAC support")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

