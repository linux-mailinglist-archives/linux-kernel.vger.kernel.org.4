Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6420574DD50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGJS0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJS0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:26:49 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2BAB;
        Mon, 10 Jul 2023 11:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnJnEJxMhRWt7XuxEpHU1sXM4P0qFKx/czul1Wb1xhMSSzandU97Ark8vGRrjHkWEh9o/wVqPN9QOkF1bdsrOBSK7005fa+cuwe0xmHcT6OhY78kM6hIYmIUiokbNUS2YqJvg1QnSWkZyRoiW5cp39gVSwz2TbmG3h5T81AMwrQEP+08Vm0ALKDaiFiDXMHfYEpsIKMRrMW2YOsTkFrWUmsqq76kRTxCEELOQEuwajCQJuurVYO/5IVlUHVc0H2weCR6RlUn4MRNDnsDKTMBV3IK45idgFXAGEaFHm52wiuav9UAXhtXgMhNVATSUG3NfDa+DTauDrFhug+R9onzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FWsILRdPotKQYzhlsXC8KcjHd0YWNrZi1b71MoUum8=;
 b=lM1EIkkIpmWb/3iuxgNmDEx1q2Ix90CGmuaCrZdLbpzLFAA+AQvykAVmTDg6wIBt+AJo7evhJp8F2bihEnLuUlpj4yR9ioh0YXX52Kx3DzX0NPBev05XIZLdotYx5pBC9bz5035FUgXAeRO1/1jWdzRvMDALdk1Ds+zUhyGyg+2IpycAwG4G9NnLeo/Esm3R1zKOVg08JR0FO1iNnAAMCW7DEemfDMLbAz6AkU9lLeFKGRzcborNQzHWvRreiA2kDBkqdlm6mOE2b09gED3DbODnagc0GKK8ttjTG5tSaL6Wo2LDk4JzAGzwR004U4bHUjRW+AmoBEPGeN/C+rllGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FWsILRdPotKQYzhlsXC8KcjHd0YWNrZi1b71MoUum8=;
 b=MsbHauKgM/qQB3hI43e7LT/4j/p8KxRVzHmnG6PdTgv4XBRz3DLW+liecmuVnZrw/oT3WFVE35iadWqNs71i4ESLZspodUwBEQ6HHriyn46AbfU6fI4JothH52kWjmKausW3d5cK7aNB1UBv4ngUr7Ews8GCNr4eoiI+n+fI3Fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 18:26:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 18:26:44 +0000
Message-ID: <580858e8-27c8-ca3c-cb3d-61041298eb44@amd.com>
Date:   Mon, 10 Jul 2023 13:26:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 00/11] Add dynamic boost control support
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        John Allen <john.allen@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:8:2b::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 346d9fea-a6b6-4f9b-98a1-08db8173368a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urASjH7dGx3CheY18ky6xUkNHheKA6yDPCgZIi1mo1ZxDGvvnNOdcTahdwaStTEm5jQ3kAWMC0PzkQgjCddswooATtHM48lsCphqKf923krXK5kW4r8zqbWTyJCLnEralZB5ES7LBVxRk9cDJDyIX9rW+/fXXXB+MhUSHf5cLez3PmMTQh8QPf1RIrYTXNbMUGR+dyNZTDrb4F/r+QHD9uNCZeVuphFyhD7HX/1fjFznj4H9pk9Rw2r9D3WMIF8J36qddJ2Jo1UjE59TqAqlWhal/zNyTnztfuLtMNxG2uaqi/+e4ctqElhSAyVx7eV7aM9+vxwixO7x2a3Zrw0PyOW8dDOPv1dhnjueaiy4rtyuHnRjk+i91vLcUQuL2OOE3/Xpf3fkiZ4g9GscEiZNycLIBh4DhT9rmBA0FNwGIuCRp9nANdQUyM2bk/lAvBqgIWGJQdK/NAKarzsgWrsiIz1TEBkG5PGfyfKrNSxdr9ycbWIAt+rEz08aHDDKUZlFScFkHDaJH1vKF0QKdZrogA0XY7kjKojcJ1++dfQJ+HwmBTp0o6jOi8ne1mgmM5SaX6y5KciJbPo1IyW+RSHIZHCL6lbu1zNdOsehXZdM1ENdChn7+nFQ6qVvvG5RUqt+bAl99wx7r5WPOLzAI6PfVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(36756003)(86362001)(31696002)(38100700002)(478600001)(6666004)(54906003)(6486002)(6512007)(8676002)(8936002)(316002)(5660300002)(2906002)(4326008)(66476007)(6916009)(66556008)(66946007)(31686004)(41300700001)(2616005)(26005)(6506007)(53546011)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC8rRjl3TDB5Ky9mMEJqWGYyOU8rUE04SVAyMy9VOWVDYXN3R2Z2VCtiajRz?=
 =?utf-8?B?VSs3SWhMUmZORVp0MTNXWmd1OE9xcWVXUkdTZXRDTm4xOGhlYVFsalVVN3Ri?=
 =?utf-8?B?T0I4bWo1a1piR0VCSER1U2xOZmZnUTh0azExTTBpRjZUbWpjTHBoQm5XREQ3?=
 =?utf-8?B?Q0ZZRnZVY2ZXUURjTjUzYzB6UW9nbXFxLzFtdUNFeGlTTHBjL3UzTXI0NjIw?=
 =?utf-8?B?cm4rVkVsOFUyc3hub28xeUd2alN0SjNranRyQXJ5UUw5MHhtMTlTR0RaSG9a?=
 =?utf-8?B?YUZob3ZiM0dHZnFaRi90bEFBaTYyVG90SHY0WFQ2U1JtcWt1dm4ycWk5NS9j?=
 =?utf-8?B?QzgrTmd0VVhNb2Z0N204Tzl1MkpCNDBOYmRvalVLejBDczVZeXpjTDFQaXNB?=
 =?utf-8?B?OEk4TWFydUdDTW55ckY2TDZyZjlZMStEM3ZJKzl3OEowVXFOVDB4cXA5Qzhh?=
 =?utf-8?B?Q00ydXd1dWtYZ1lWUmZsMys2aEg2SmorTkhaSWRoSnpWMUNtU0YwQXdGOXlD?=
 =?utf-8?B?RTdxN24xeGhxenEySk1jRUFkamZaRGxKVm1xaU1hSm4vSUlCTm1vQXQ5WlZI?=
 =?utf-8?B?SmpPd0tqcElHZUVIYzM5UmFtT1NBako0VUdMUmVpTFNIeUlXWmFjWXJSeGFD?=
 =?utf-8?B?MVA2ZmRNTVRyblZJS3pxVWk4Vy8xMG0vYXhyR1I3RVZlZGRaVTE4REVhSnZU?=
 =?utf-8?B?QzlWZDN5S21yTXJCVStQdERPRlVqdDdlc1NIbDJVUUFxaVgzUEtnd0RVbVd4?=
 =?utf-8?B?ZzU4MkFQNEUyN0dPemU0eGxnUnBGOVIzeWhyMmlaa1pwUGRrNFJFdFZXempE?=
 =?utf-8?B?dGlXaFg3RnNld1Rka0VPeHpQKzUxWndJMTJXT2EyQzlEblB5Qm9hS0E2d21w?=
 =?utf-8?B?MXd1d1pBcTdZcEhoNEZVV2JuSG4rL3BnY1FRaDcrM3VDTWdtY1JoemgrNE9i?=
 =?utf-8?B?Y3ZzeUxSWTZZYklvUmtRckFXeTRBSkU5ZU4yRDU0SmZPOElWOW0xQVJ1akVE?=
 =?utf-8?B?YkRzUkRnN2VOTkN3T3czYWFyVC9XOVlEUThDLzVqV2JaR0R2RjFOM25vdXc0?=
 =?utf-8?B?cFNYN0Z2SGtpYkxOZ01BNVhGV0Flak1WMnUxcFdFREFVOWppUERYOXV0aSty?=
 =?utf-8?B?eERGcWtWc1VXSisvaDBacnNmY1pvS1NrNjJuTVB5eUhlUGRjK3FtT2ZUUFMy?=
 =?utf-8?B?WXdEdEdhQktLbU1RN3dkcS92VHVEcElZd0hpRko2TDJMcjNmd3MwWDJMWmJw?=
 =?utf-8?B?VlB2VEhTSDFqQ3FUenArczA2TjZvcWYyc0Y1R3VGRnJBMG1oU2ZKeFdlMDhl?=
 =?utf-8?B?ZzF4VktTNERtRk9vTm1PVGhzY1U2b2hTa0poLzZZZURwOFJYU3BjYUM0ZTFw?=
 =?utf-8?B?ZGE2c0FkUk9TNHFzaEdEaVRnMEtGVnF3OWZDZ1RwUXh6aG1iQ1pVSmVJdUlk?=
 =?utf-8?B?dU83bi9sWDZSZzRtVFNqUVdtRWNGbU5NUEJwOEhZS29DWUdtMW5vOTY4SDlw?=
 =?utf-8?B?anRtME1uYTBZVW42bnlmZkx6dFpvSWxYejZaMzBpbkFHVnhkS3o4YWdxaGJ6?=
 =?utf-8?B?SHNnUHAxbmFvZTBRMnViRUZnZU5rbzR1cWNGSFNpd2ZqY3JVc0lkM1ptd3dG?=
 =?utf-8?B?eE5FT2tEeExmVU1INHVVZEhtVGl3ZllVaGtmTFJrNURnZUdjSVNYYlh3VG1t?=
 =?utf-8?B?Nnc5UWJLT0Y1aHpId2JMaHo0SlN3WGhEQnpNWlV6SFQvTEdJdTl3eGJmc1pM?=
 =?utf-8?B?TFRNV0NoQmFiS3AzT09HV01DOG9WWXNzTXl4ZmZydi9GQTlsVGkrQzFtZ1dH?=
 =?utf-8?B?SWw4Z0FFbEN6WjFPWENLalhwUGpnU1p0eWliejc4MzdLd01JRUJpTWtNdDBC?=
 =?utf-8?B?VmtxSGN5aEJPenVFR0IvUUJOTlZoek1hYjkyZkRRVEVRekkvMHNVcTVOR1hn?=
 =?utf-8?B?cDVJOXZKSk03WHRMem1Uam1qaTBTUFlxZlVONW04NU1rTVJ1Ump5ZVQvSy9J?=
 =?utf-8?B?TG5uZzZpM0FEN0hkMEdvT3d2bmRINFczckxtbmVsSkJxYk1MVmxTZjNrcDVV?=
 =?utf-8?B?enhYZFJVeTBDc0RmbWNGYVR1ZE1IUEduUHhRTUprWWlKUlUvcy93VGlqY0FW?=
 =?utf-8?Q?uQ1+mEZnCsdWxAesmtr5UxwiY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346d9fea-a6b6-4f9b-98a1-08db8173368a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 18:26:44.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhpjDEQhuQTDNkNMR1j/UpKKSvM+p9pXZsrgTS/wsldhsh5bb+aPKHuwWYA6S6gZrT8Qli8XApg3vicdTjOf8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/2023 08:49, Mario Limonciello wrote:
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
> 
> v4->v5:
>   * Pick up tags
>   * Pick up a static fix
>   * Fix a mistake found in dbc_cli
> 
> Mario Limonciello (11):
>    crypto: ccp: Rename macro for security attributes
>    crypto: ccp: Add support for displaying PSP firmware versions
>    crypto: ccp: Add bootloader and TEE version offsets
>    crypto: ccp: move setting PSP master to earlier in the init
>    crypto: ccp: Add support for fetching a nonce for dynamic boost
>      control
>    crypto: ccp: Add support for setting user ID for dynamic boost control
>    crypto: ccp: Add support for getting and setting DBC parameters
>    crypto: ccp: Add a sample library for ioctl use
>    crypto: ccp: Add a sample python script for Dynamic Boost Control
>    crypto: ccp: Add unit tests for dynamic boost control
>    crypto: ccp: Add Mario to MAINTAINERS
> 
>   Documentation/ABI/testing/sysfs-driver-ccp |  18 ++
>   MAINTAINERS                                |  12 +
>   drivers/crypto/ccp/Makefile                |   3 +-
>   drivers/crypto/ccp/dbc.c                   | 250 +++++++++++++++++++
>   drivers/crypto/ccp/dbc.h                   |  56 +++++
>   drivers/crypto/ccp/psp-dev.c               |  19 +-
>   drivers/crypto/ccp/psp-dev.h               |   1 +
>   drivers/crypto/ccp/sp-dev.h                |   7 +
>   drivers/crypto/ccp/sp-pci.c                |  96 +++++++-
>   include/linux/psp-platform-access.h        |   4 +
>   include/uapi/linux/psp-dbc.h               | 147 ++++++++++++
>   tools/crypto/ccp/.gitignore                |   1 +
>   tools/crypto/ccp/Makefile                  |  13 +
>   tools/crypto/ccp/dbc.c                     |  72 ++++++
>   tools/crypto/ccp/dbc.py                    |  64 +++++
>   tools/crypto/ccp/dbc_cli.py                | 134 +++++++++++
>   tools/crypto/ccp/test_dbc.py               | 266 +++++++++++++++++++++
>   17 files changed, 1146 insertions(+), 17 deletions(-)
>   create mode 100644 drivers/crypto/ccp/dbc.c
>   create mode 100644 drivers/crypto/ccp/dbc.h
>   create mode 100644 include/uapi/linux/psp-dbc.h
>   create mode 100644 tools/crypto/ccp/.gitignore
>   create mode 100644 tools/crypto/ccp/Makefile
>   create mode 100644 tools/crypto/ccp/dbc.c
>   create mode 100644 tools/crypto/ccp/dbc.py
>   create mode 100755 tools/crypto/ccp/dbc_cli.py
>   create mode 100755 tools/crypto/ccp/test_dbc.py
> 
> 
> base-commit: b335f258e8ddafec0e8ae2201ca78d29ed8f85eb

Herbert,

Any other concerns on this series?  It has acks from Tom and John both now.

Do you want me to rebase on 6.5-rc1?

Thanks,
