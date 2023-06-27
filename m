Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302B073FFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjF0PnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjF0PnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:43:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB50310D5;
        Tue, 27 Jun 2023 08:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgvW87l+5SG8SNePQm2jhKcI+urpy5xViQDaPUAX62t/CIbziXLoRJUcOG6IIabTkUTCDj/Je1t9RuPZKJVcmVcVRn6WujA2eSu/Zs+bZN3UXHPteDMitkp9+gOdAE08C+4Qsa4Pgl9M7ETowjVhC/OUamWwFtn/1FG0GdD++QsDvzXWok6h3pkIPKjZ7ha5dVOyI8iMl0A5//S399G8nyJgiM1bLoI8Xkg7se68mvngNdY0M1VSFDTVrvuxs22ixedFnpzXhLY/0saGZSDXRC9+yu8bpN0Ij6rDdeosEqSoeQFqbAO8RrmUB+GOgqv9UaFPggJaGsTmS4Fs5XUTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGjLTRjjIvWaOjOgLqE++7jSHEb8Gnz7Y0EbvFAg+lI=;
 b=Xhv+R5tvcSoz/wuY/M1kUJvF+0sF05Tb3SQYDr+F6vYhp9bD2EpZiQrzPZdEvV7Qx0448X9wt02KxGQxos1ID8rPj/m8YZBPCLtQSf1d0nSwBTzxl20y9TD9y62vhLLLK8IbtWLUD/I31mWRGBWpu7wtTcLPGZYsSkIj8JaSCfgrSVHVZvsQsxu/nEnP3pGqCc/rxO7CTOTP6LQ94PSmnEQ2q++nVMJKK3d9jkWwGXu9Ze9tXe+kLl17W6ECXLhc8N7KnRRwOKzR7PILUp7mJ1DWYAFvQCsgWBUdYL9ZGv/LfzJCQmy/rytUqH91C0InxHjjI0An0IsgqF72s+gf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGjLTRjjIvWaOjOgLqE++7jSHEb8Gnz7Y0EbvFAg+lI=;
 b=ipYKXSKbuXXoTxRgJKClm2vJwPhHEFXpRjuqCrbMF8HW2Luk6zKP3nZ7kN9RGnOH2jI4u/ndTQUjhNfNRv+V5N7KyDe9XdrSEHCdiA4YV+WdhNNX6dwkO/0d82dsoX/R5B01gm7B5Bk1Gj2yL6LH1/vugpN6zK/w19L7qg7esD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 15:43:07 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::a2ee:7100:47ad:1476]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::a2ee:7100:47ad:1476%4]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 15:43:07 +0000
Date:   Tue, 27 Jun 2023 10:42:59 -0500
From:   John Allen <john.allen@amd.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v5 00/11] Add dynamic boost control support
Message-ID: <ZJsDg7xl6P8YfaaV@johallen-workstation>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
X-ClientProxiedBy: MN2PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:208:23d::8) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: cb618c1e-3a3a-49ad-b063-08db7725340d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFSx5An+cgKhZl7En7fQ3MK47XOZ7k4n6ztmAx1+yLoYkp8HLficQaGEhlM0xKLF/7CH9ZQMN309U/iQvGhR6uxS4T1T8VYsQ3kKXXhwMYlwKq2xoY8T4RGbIYTN3pNa/SeeZMCVvT6n7sBprCwMb/qdT7h+uNn9yO9YGFpHB1tPYttKKY60P8+4GM0UdcOzHGrN3RMkz1BtcAVEZ5bKuK+Ka1HExOfMxjvu1uDZDfDBM7CvQh+AhMn6qF4xbZTwazbqdQNn4512eDONlNw+qh8s5r26gGcO1Kd4ZVGKfCz/+Hkzuh4xxxyMIkAYSLwGev9M5S4dvEAyN+CGOgd3BC4f8/X+ssWOUbdgrtFnE7UN0XIfG6RdoqUWxG7Rs9+WjnMX4scCjzGzbuJ9o7vjvmO+fW3clW+HqqR1oRzC/75LCyw5Pw5Zu1JZVJZ1iVau2G71IA7+YWTgMTjO6vOzheCBU4vr5tBiYllJvJaH5MQRYFLiIOfOaKfWRuyv6SmA0UUrkc1bROmgDPQFMKWju6XekOJim2GAE9UjmwAXkwgo+CLW9oanCEPmxNY5cJC8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(6666004)(6486002)(478600001)(54906003)(9686003)(6512007)(6506007)(186003)(26005)(2906002)(33716001)(66556008)(66476007)(6636002)(4326008)(316002)(38100700002)(66946007)(44832011)(8936002)(8676002)(6862004)(5660300002)(41300700001)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DLMj5HUQAl7v59ILPKbk9Qz4sUxsEZqKw7C+xJuI7gg6pXnKrNSh2+F3kyoB?=
 =?us-ascii?Q?ZsmDkIn5udunxAKlxMgMzd9u2pkBRBuZKay14zXaHlEVAmK35slacGqFo2UQ?=
 =?us-ascii?Q?rm4mti3yttcGcg0GAI4vnTcjtw7OTUFoUNVCOaOB/C64xKFfeLML6f61I//G?=
 =?us-ascii?Q?cMM/i5k7CyZS9wX4P9v+EFx+NRdrm6tElBeXPXvVXm8OkGoIXPMrxVF4fna0?=
 =?us-ascii?Q?9HIrPpw8br/m519qHzt6bo0TlXkbui11MAb94YxnR5Aym734NRBPAz/skSyo?=
 =?us-ascii?Q?AkZBdYVfqJsI0l7YKGl9yUut49qcYlWiCBA6D+8nhSDTbAo1mvm4x9yfWcVh?=
 =?us-ascii?Q?rf/b+2D4DuvXBjHT2Ry+XVfRv090PxHuvl2nlXDP2bDQcW4zrsyQgDh3k1jr?=
 =?us-ascii?Q?dvpjLwwGMGcFy3EqYrhkkAOlA7TydfGjWdRXaDAyY5Bgnr9t3M9OG7Nu2LAE?=
 =?us-ascii?Q?qAcazttVVMsFXkYa/W32TaG8E41of5SeWmNW3QTlopysNCPq8aXqzY4QQwQA?=
 =?us-ascii?Q?FJaXEJvuUAXsRR/dMpQ+jR3rGAkpaqXIHEBWTA/DZxoBrTGnpYHVwZVTrgmz?=
 =?us-ascii?Q?MTLn6ysASrUDRjtXJtw9dxYYo12heMzR5Qyws065FggxzH6TU16yDTXC5hqU?=
 =?us-ascii?Q?+CyEH5lFh8vls4s1X1Zj5F5eaUDaBg9/lE4+k3TZ+GSddT4+o5F2lcrgbExY?=
 =?us-ascii?Q?IVcPuR++vU7F1iQFRGmVQcNsVuMOP/RELjwj6YhrSPohDJwGtX0Kt6fxz3cH?=
 =?us-ascii?Q?7E2+itbNt4iGytPPZiLTftdVkCoritqZHSBwVRqZPrCxnRid8b45KqULKl0L?=
 =?us-ascii?Q?QdX8/FDuUJIqjYZVuTyTOpdtc/yzb1XgO/ID9hEV02R/MEvyFNr3x+dtxpw2?=
 =?us-ascii?Q?l5UbJHe1ARShsWs1yB4lw2PhM+0utbmiOBJMCkgbE+pzR2KS/dSEiZXSfTER?=
 =?us-ascii?Q?P2xvb5WG9q1WShjh0g3tOZqSwF+9zrt04yECs2t9+uiRGnMPXTAYCxeKVHYO?=
 =?us-ascii?Q?T+QPc/bHiW1z8HvUTs+FWTI3Rexy2gmO4BXEzBKk8LbatzhgJaDFkRmqJnl/?=
 =?us-ascii?Q?7AbSiqvO73md7EgyXYMtWBB2MpPzkioPae8K5tuKtXIZM/e01z50eT4PsDWb?=
 =?us-ascii?Q?F2R1LCbB5bThnIaJ7WQMr5qJQXMemd3PGnm4oQRvU3fOOAd5Y3kwFw8jD639?=
 =?us-ascii?Q?90+HU9S1Lo0KGfrOemjkv6+0H/nfCNg92LiOGvcIeHkhlzFZ513WXskuWGx4?=
 =?us-ascii?Q?YyhToSoOQVQ6e3acmRYC27JnQ7O5q3fC8S4DX8AgGVI5p+0KvZFK2Kbz6k3I?=
 =?us-ascii?Q?JdWVDCoWRb8FL3OFqbANRDrePx+TcpuffazEP0U8y/a1uwxJDj6SYA8ub/Gd?=
 =?us-ascii?Q?7IyDziR2v20+G/Q8WR3o04S6DYZWqIPkcSg7SoVwMOn3DoiUx8ECOd203W81?=
 =?us-ascii?Q?AMvEivLReJFclxOYJmaTP9Zjl+ZqkgbPHsN2ydQ3ljNyBk0Rn+TmVg/V2ibj?=
 =?us-ascii?Q?SFrVRPsoqCFjz0t8i8M5Hba9AQ+71D0tZ8/+gREzZxpVUBi+pB33z1zKVdHD?=
 =?us-ascii?Q?+I62xzFdl7oxwiPSh03gxbUgmB60xxnfW96S7y4W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb618c1e-3a3a-49ad-b063-08db7725340d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 15:43:07.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiGIZkCc0PMTgp1jHNE5mQwCAB6/c0Ow1vMSD/onx6gBCFmlEbBonDsgM7yEYzh46cQA6FhWLPQtBaA6lDqCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 08:49:50AM -0500, Mario Limonciello wrote:
> Dynamic boost control is a feature of some SoCs that allows
> an authenticated entity to send commands to the security processor
> to control certain SOC characteristics with the intention to improve
> performance.
> 
> This is implemented via a mechanism that a userspace application would
> authenticate using a nonce and key exchange over an IOCTL interface.
> 
> After authentication is complete an application can exchange signed
> messages with the security processor and both ends can validate the
> data transmitted.
> 
> This series includes a test suite that can be run on real hardware
> to ensure that the communication works as expected.  This can also be
> used for an application to model the communication path.
> 
> Two sysfs files are introduced for reading the PSP bootloader version
> as well as TEE version which can be useful data points for debugging
> communication problems.

Series looks OK to me.

Acked-by: John Allen <john.allen@amd.com>

> 
> v4->v5:
>  * Pick up tags
>  * Pick up a static fix
>  * Fix a mistake found in dbc_cli
> 
> Mario Limonciello (11):
>   crypto: ccp: Rename macro for security attributes
>   crypto: ccp: Add support for displaying PSP firmware versions
>   crypto: ccp: Add bootloader and TEE version offsets
>   crypto: ccp: move setting PSP master to earlier in the init
>   crypto: ccp: Add support for fetching a nonce for dynamic boost
>     control
>   crypto: ccp: Add support for setting user ID for dynamic boost control
>   crypto: ccp: Add support for getting and setting DBC parameters
>   crypto: ccp: Add a sample library for ioctl use
>   crypto: ccp: Add a sample python script for Dynamic Boost Control
>   crypto: ccp: Add unit tests for dynamic boost control
>   crypto: ccp: Add Mario to MAINTAINERS
> 
>  Documentation/ABI/testing/sysfs-driver-ccp |  18 ++
>  MAINTAINERS                                |  12 +
>  drivers/crypto/ccp/Makefile                |   3 +-
>  drivers/crypto/ccp/dbc.c                   | 250 +++++++++++++++++++
>  drivers/crypto/ccp/dbc.h                   |  56 +++++
>  drivers/crypto/ccp/psp-dev.c               |  19 +-
>  drivers/crypto/ccp/psp-dev.h               |   1 +
>  drivers/crypto/ccp/sp-dev.h                |   7 +
>  drivers/crypto/ccp/sp-pci.c                |  96 +++++++-
>  include/linux/psp-platform-access.h        |   4 +
>  include/uapi/linux/psp-dbc.h               | 147 ++++++++++++
>  tools/crypto/ccp/.gitignore                |   1 +
>  tools/crypto/ccp/Makefile                  |  13 +
>  tools/crypto/ccp/dbc.c                     |  72 ++++++
>  tools/crypto/ccp/dbc.py                    |  64 +++++
>  tools/crypto/ccp/dbc_cli.py                | 134 +++++++++++
>  tools/crypto/ccp/test_dbc.py               | 266 +++++++++++++++++++++
>  17 files changed, 1146 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/crypto/ccp/dbc.c
>  create mode 100644 drivers/crypto/ccp/dbc.h
>  create mode 100644 include/uapi/linux/psp-dbc.h
>  create mode 100644 tools/crypto/ccp/.gitignore
>  create mode 100644 tools/crypto/ccp/Makefile
>  create mode 100644 tools/crypto/ccp/dbc.c
>  create mode 100644 tools/crypto/ccp/dbc.py
>  create mode 100755 tools/crypto/ccp/dbc_cli.py
>  create mode 100755 tools/crypto/ccp/test_dbc.py
> 
> 
> base-commit: b335f258e8ddafec0e8ae2201ca78d29ed8f85eb
> -- 
> 2.34.1
> 
