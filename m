Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07777739137
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjFUU7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFUU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:59:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB99010F2;
        Wed, 21 Jun 2023 13:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGdixf6/PXOjc9rS6Uhe96IuvusGXgEkysAHolYHnh+Ci9W6g5TlCEBV53CHELCmJ1uSXbAGVMOUdtlja0aiuZPywBHALEdFDq8TSn8KhPsLzhI8XkYCHxGfEkT/KuUOWmCILMxIiJ55AV0qOKGsFIAFsq66YsicLxNG+DXVplRPGlHG6a0rxcVVX9uaEfWQT57Swz0A7lm1PYLPYwpKThubCtEbGdSaWjYiaoEUxl4kjojld44isbgV0EZi0XA3LXvdWlVNwuo/GPOgH8/YGFTEeU6i5F/dGZMWawktSg1e2szkRwswoUXJOPOkt0UyWAIfcg7tEVJqCvS7SN0Iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMQ4UsIv0uonMaGo7ADQMJmJDk8v9Im7HugfJc1hesQ=;
 b=a4NUzkw6D7mP108DNXOK7ZBp5NzDFUB7Mq/7jBTQ3ViXSgbZcrnJzZ3+FynNW0MM8wxjjq84oV88nQ7T1bmBuKYm2O9oArLcGmbfx9TtJNUceaGdZt99qaY8pGT3U8bXN+opCEzdapnERk10M3qdfZ8AQkskzR+gljVApV4tdLdoRnlTZ3MUqmJAtbvC68TT5hnNQ6YUaJsSo9PQYpvr6mLHlUawqpE2tsptiQha8Pmgb0NaOWxTiH6lSAixiHcJ9/7y0ZsjJk4+abVAwgMlbIJc6Q05Jp+ueCRgYsh3pLccN7z87Qbp1raPS0I3HM1Glsx5lwgLcYw+tOfqEhDWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMQ4UsIv0uonMaGo7ADQMJmJDk8v9Im7HugfJc1hesQ=;
 b=uvmt/i5qSkpC1KlU8DWL3Gd41g1JXmyC+EZ4rAoqhUMyBngGWEUqcLqBY+SaPmfz59OcO5TU0qaU90Q5kr6SZtXmITD512kztZWEWNQiLeBbqOp+W39BkBTHX0ZyO4A35kwPqh10K3aMIzgL6bSxgBeZGAdxKQS9U3VXQ+QexM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 20:59:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 20:59:30 +0000
Message-ID: <4a507dd3-620b-583e-2420-5bb28a377f6e@amd.com>
Date:   Wed, 21 Jun 2023 15:59:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 00/11] Add dynamic boost control support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20230608111757.32054-1-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230608111757.32054-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0102.namprd05.prod.outlook.com
 (2603:10b6:803:42::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a2229d-c9b8-4933-4dfb-08db729a6830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQE+8a14YXIE1c7wWF0TKcWYssrz8N1P064//pUL8eNW6/jBwOgeDdC45HGNMddE0auzibyS4LyayUCErkYwLpJnd7nBQaYzasfnANv/o3Y/1YRLBNRvUQ4g2uyouhj+i+lRKY96A234+k2ZreytUfUW9YJd5U+A3BqoS+dHS5tNkmjg9rmnIb2kD3z1ELaMsD7Nj6TQmyHiEqcNsIVpGXy7WXBLkwYBqvPFYKRhkXwJAw+sBfmBHgY/lgeZsLtH0eMRrZ+n+tkkz7KPP+zSBXavKfLGdhZhyMYkWNvwuFEgYGkolzpdzfWGxzJJ2kTQeypp3SlwAEGANoWEANuycSQJ92QZaPUXHws/POlY0mBLTbfR8t1idnOH5dwLvruh9sR2IHDurrVhrf2HlfUbDAAtyyo372lG5Zz3kojNNqQLxY3Z4Rynf+EwjMR4s5GaXSr/dv40maoW+0ajqgnuxC5CXiQUGA0JRJaoP11Rv0rQm9jrMmKK5YVAFGRxuXaEEsinxHrRv5x7iPSvG5BEOuDVb1wgzj8nnt5lwzt7Qoav/vI5ml5Zs0cxrLdVWGVJfzkKrcuKEJWz+4K8+132cm7LShVDY/5HyhLnG3Vkl4EkRzNFnFTY8vtu3x0lrPBOTGF756wAMl2RMAvBIidSmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(2616005)(6512007)(83380400001)(6506007)(186003)(53546011)(26005)(38100700002)(110136005)(6486002)(478600001)(31686004)(36756003)(86362001)(31696002)(66556008)(66476007)(66946007)(8676002)(8936002)(4326008)(316002)(2906002)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRHYWFBcFhkVzhYcExtQWQ3UlU5b0ZyK213NlBqbHg1TFdZVEp1TUJCdmF1?=
 =?utf-8?B?b01XWklaeStMTm5UcW03bXdXQXFzOU81QlY5TDhRRUNtQVFkWnNyaW51UlJY?=
 =?utf-8?B?eFRkOHI1bU5zRWg0YzBVcGRRWDFlMWU0ejJvUUkrUzh1RU81YnVaUTZEbm02?=
 =?utf-8?B?ZXpXckl5MVVIMFZOMCtZQ3VjU1Z3SUo3Y3pielVkUkJSQ2JOc011ZjNKYU4x?=
 =?utf-8?B?N0d2anIrenBjMm5qMjkvdlZYdDVMWGUyWkhmOG9kV0lDNmJ0cUJtSjY0dFk5?=
 =?utf-8?B?Z1dBMHJhL3oweHJvRTZKU0JzRmg3cmVLbnZyMUxYZnBXcDlOMVVkU1FMQ2FX?=
 =?utf-8?B?d1lDaGVEOGltSDhobVAzbWIwSXBvN0xCNmc5YU9SOEpRT0VDY09ab2ljRngz?=
 =?utf-8?B?bGdURng1eTZPT3ZJa0JYeWEvWGwycG9ZdU1MdXJaamphUXBCOWk3NFBTeGo0?=
 =?utf-8?B?TUpPY21kdytjS21UdXQ2NHlmZ2RlT1J5bUR4Z2xKcTFLOXNvUUJ4UHllbG5M?=
 =?utf-8?B?aTRhTjJRYmovOFRNU2E5OHc3Sy95dkZmM042T1BWNjVEZE9pY2NYcHB0bnVp?=
 =?utf-8?B?c0hGSzNHZTlzQ1hHejJ2Ni9PTFlVTVZ0Qmp2bi9KUko2U09pZ3hCQXBGMnZP?=
 =?utf-8?B?QzN1bXV6UnhVN2JSZjB0S3lGUHA2TnJMWjJQNURnQ0V0M0V6L2VXelVwa3o3?=
 =?utf-8?B?QXFoZGozb1g1TEJrRnQ3ZE85UnZGQVJRUlBiME9kNzdmM3pqUTRrUzlrck9G?=
 =?utf-8?B?dmdDenhvWUQxNndWOWpwN2MyWUNqT1hNWnpOd0N1N28wKzJWaEFPSzNBMnhC?=
 =?utf-8?B?ejVOWGRBcHFrMFEvR1dpMGFXWXNPcFprOCtGa1dPNjY4cjBWOVVDWGVpVUZJ?=
 =?utf-8?B?eEY5SFhTWHFTSThoc201ZUJ1RWd6OVNOamNYMG90OWhsMCtrT3FSaXVuUkhz?=
 =?utf-8?B?eUUxdmN2RXlrTUVyOTZBZ0kyUEdvTnNsZUxaNXh2dVFkcnk5dkU4d0R1cmV2?=
 =?utf-8?B?aW9LTUtUTnorbUtGdFJBWE5xV0pDQSs0MmFKeUEraWthUHlsQ01RMkFjeStZ?=
 =?utf-8?B?eUNFM2x6ck0xNVlLc09pMy9HQ0xtUzdKVHQ5aVhXdEhwN1BGNVgyVDF6V093?=
 =?utf-8?B?UU5VN0loY1NxdE5ucFlmMmU0d09PQSs4WUxCbFE2OWRDeEZrcnJxUUM4L3B5?=
 =?utf-8?B?ZnlvdUFaN0dDSGd1VnRuQXNmcFNVZksxYW5SUWhFa0NXcXRaajhtMDM0S0c3?=
 =?utf-8?B?aEQ3WTFlUUh1Qm9OeGVQUExOVTgvdHoyS1NlNWhheHU3TkliZjlSSmE2enox?=
 =?utf-8?B?RzJxRmIzYnRoakprQjJrNFlPNnNEUUp5ZHgyMDBmOXN0WmduU1lpM0tOenlq?=
 =?utf-8?B?Z1gwZVNjN0RIM3A3SDA5NUFhOExISkRyV3FpUGhHcnBQeWZ5MDZLeGczQ2ZC?=
 =?utf-8?B?a2F0T1JtMGlra1d3cTlvay9hbktRUE90b1drUFBZSkhFSGZNU3psanJNbDFK?=
 =?utf-8?B?aTFtMnEvU2dWME5HRG9XSXN6V054dnN4K2xER1dsazYxZllsc25tRFVqZHB6?=
 =?utf-8?B?d2VXbmNKS3F4L2pqbHJ0aWZub2cvR3dtSWx1RDBwNEZpTEd6TmhwajdReElr?=
 =?utf-8?B?MGFQdTJxVVZPR0lselhNcWh1em02bzUwam5aNGxScmN3SmdEbUFMV0FPcE43?=
 =?utf-8?B?dDlyczgxdGJlWTRvQlJQeVhHbGdzVlhETDE1RHo1OXZaeFVhY1l5SWNNY055?=
 =?utf-8?B?dDNGOEVpeGJMUHhOUVRDbjhtZ21TY1BtZUxwMkRGREVMNlJ1aElkVnJrRFhv?=
 =?utf-8?B?cjJnTUZwclhJTXdxZjRIS0t0bG9wNHZscEZNajlOZWdaeG5SNUlMdldma29Y?=
 =?utf-8?B?eTZ6UEt0dkVJMTJoWlozTU9QV01ZQWhpV3piUFlEU0xIc2hHT2NHT3lkalVQ?=
 =?utf-8?B?TExOSlNaK1B5MkJYWlB1NVJDQ0dVcEVKbDJaMmVSeDJENG1HTytZM1BhWGps?=
 =?utf-8?B?a200dUttRG1XZlFKL2E5bGduR3Bvd21HNjVqV255elhOd0VkaHphemlvRjNR?=
 =?utf-8?B?Y1ZWNjU0Q3orQ1JtK3JBSmg5S1pldGRPS0JvL08zSDlFOHdlV1V1VVJ0SEN6?=
 =?utf-8?Q?1K2Lwx13YWUkvzYQgOh034FL+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a2229d-c9b8-4933-4dfb-08db729a6830
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 20:59:30.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1ceIyk6q3ZVY3e3Q16HopohjKVkSRHNppcAhGTcCSSTi4BYrfzi2ePZL1AQznQoxwnlwYD+8zHQOUDgRyzHhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 06:17, Mario Limonciello wrote:
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

For the series:

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> ---
> v3->v4:
>   * Pick up tags
>   * Move ioctl calls into a shared library used by python ctypes
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
> base-commit: 134e0dc6b73ab7e99464182356a8b3fa4ea3b499
