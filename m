Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E082569CFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBTOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBTOuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:50:04 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C908D1C7C3;
        Mon, 20 Feb 2023 06:50:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieeyOYBwoUseVJi2HYQ2dmJXzykucfLeD17RrvwPz7DDVastwYsnCxzTup1NpzGgE8tmfOWDH17nrv/uJfXl0mC8WAliuIlmwUf9DVi1/ehLMAEUJ7/Y1UGZvn2wQ+9JPgkA3ZAeHlzyeA9b8iY9XCMAxBnJkiKSLyZHRY+i7TD1DcEhae/aHaPC8cR1o545JaIdJztOkmoLeDp+Gy3vQPCfAZEgZRgI5LvQKGGVgR9UlOnoOBpJ7x0TGHXGrhny5jZOPO8e9DLdnNn/BaNo8l7iOpfaykWQECOVqCz3j0H7Sr2Jx+w8zNm+E4re/TjYOwO2W7qY2i91b3iLZOYqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooFdnt1C/VA9BW6g06M9/VmtxUZs6qAn3R/gtvAHtvM=;
 b=Ropw9F+z03aKOc63M8o8Q0g/4NWB/w9Zgonoxl52lr3yhs51ASQUvnD+DgDG/A/IAI+92KnGEaG4hHnwc1/tHSz2IDqG9lVrS3Y5SZg1sMKrqRfU4uKrHEl0vn9dk8gIpc247s+Rp50hY5a88ypgnmWdNUEr3vMD1fwVr11BZ/Rx9/Dz4Lzs8B6Aj9SXIa3cbJ6EkAOyBPMKJOtYAX23XcMMwBplXc9XnPDb2VnKr4Yzfvcpg40E0NnsHqv04F4QpygF6IKx8m1KzVHH+/zp+77VBWjR2lr+0/xpo4/z/qlt6kqn9VqMTjvAMgbPHUGjyyE/lQnjEie/TRTUspfH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooFdnt1C/VA9BW6g06M9/VmtxUZs6qAn3R/gtvAHtvM=;
 b=TrEePeZmJ9J/dXWH6Kve64v6M90s6sRdTrml63o/F8zd7RlznpaYG6sccNg7kv1OeOZs1u+PDUoIc66mxRFBdQEGvIQ8EBbo62ej3iIgWKdujZaRPVQgcIc4maNKuyD0jcaIsgKJmRjpAG6MrL1+AEKYs3t95A/cjRgXFuv0eLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 14:50:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%6]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 14:50:00 +0000
Message-ID: <f1675b6e-fb57-0331-7c39-ebf14f1d0f16@amd.com>
Date:   Mon, 20 Feb 2023 08:49:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/8] Support ACPI PSP on Hyper-V
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:59::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4fac27-4664-43a8-287e-08db1351bda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bowjyIsTfrfkNu1uenOKsyvdkw+bz2YKoyTyqoLvK1GPgdpN1ZNGpfBYKmHizwyQQK3btOz24SFUdxytx6MJYEk/wgkiqVe1mTuiF0i5esvFTPSvB71i56/tNbDsFE0Dh/Pc2fi7ClL2nJLVs5RrQnkngeds18G0nSta3MiP5Z6KD/7XSchuWzt/DjsjrF1G1MoWLMoV+bQK4d4EEzBunaZcQKUBGpU+l9pvvfR0y7YD7+LZ7Qieg7D8YzTTnS/rP/EWrWH1ZM0rbdRJycPlDW5/kFoz75vNMPJv6oI2oTOkUQhZkCpoRurCr8hWfllCB32TnpXdrIOPp2TctZEzpUOen8Glj7i4emXTIl9c91nVdUo5JdlZlgSfhW5dqtTk5NKBhM44Plv774RF9E7TRaa/0IBy7RG/TE7HzhXpq9AIf6IlPRUXBxXghOX7PKLhfjaS+VHOo3tygsdE+olEc6bVJAQkXjAXJxLwFxLRy/xLUbv670p+3foxkHtfHHj/+USi3zzwv9/+7swWSvs08cBwDA3SWusUR2p30+b7zOuflA48rVwyiTvpUkVNMWaxkYvbMeJYkuf7jE5/7GX2DXJxwPGvpdvNNw4THo784wefQwQ0hWhf97Q98F6W9jgfM0n8G8ewYACyhdyuyVdIZNDTsKm4EdguvDF89bRxW+w1VBixCPunvqa6u+4q0MTVJwpRWQ3zLtv8BRnwWCLUbxxvJ6Rc4jCGEueTQHMj7Dc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199018)(31696002)(6486002)(31686004)(54906003)(316002)(6666004)(86362001)(26005)(66476007)(66556008)(8676002)(66946007)(6506007)(6512007)(478600001)(4326008)(186003)(53546011)(41300700001)(7416002)(8936002)(5660300002)(2616005)(83380400001)(2906002)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFveU9tZ21WaFV5TEExL3lVVDAya0ZOZEZ6d0owZHdZMGsrSjJ2VDJJNGxk?=
 =?utf-8?B?V1RLamUyU0Zyc0pjdkcwSXZqU3ZzdnRJTzR6RlNjajFFUWQwMmZ5Y3RUMVcy?=
 =?utf-8?B?UTFLNTZnVWRKMjhRVHN4cXJkS0h6b1R4RTYvaUNNZlJGRS9KVnJDbjlGaHdL?=
 =?utf-8?B?M0Voa0pqakVvdEdoWm1mb2ptQ2pGMFFPaURxRUxnNHg0enZENUcwaDdhMGl4?=
 =?utf-8?B?dWhxcWEwaXJxVUVMdU9heVRkelZXSGZmcXlObFhvbTY0L0dzVndmRTlRUk04?=
 =?utf-8?B?YUF4MFlxcGtMK0dWRjdETy9uNGpxS0JlS3dRTjNCT2lHYitEbExzS0ZyeFVV?=
 =?utf-8?B?Ymp1Qit3Z2RyYlo3Mm1McVJEcW5XeXZlKy84NGhFejZOZVpDWkZZZW1tbHFl?=
 =?utf-8?B?MG9XRk12ckFDSDF5d2hUYmNsVjNoaDF2aldDUlZRZXN1ZzI3QXdIZWF1LzBM?=
 =?utf-8?B?cWd3MXVWbTdpZGU5RjFOSWM3YmpBOFZyY1NKWkdFMnNUeUZBK1FCMDd1QURq?=
 =?utf-8?B?VE8yb21uRjBraEEyMGtzTzNVV2hpaWZFOXdOTzNKc2RZYXE0RFFTTzFaV1ZN?=
 =?utf-8?B?MThrSm15UVAvZWlyb1l3N1RQT0h4SFJFOVRCbzFhUDF2Mmo4V1RyeUNsa3Vt?=
 =?utf-8?B?cG1kd25uU3hmLzBKV0sxU1NSc3VONXlFcTJDeFVtYUoyOHllbk5Cc2twejZK?=
 =?utf-8?B?cW8yMmNxSUY1enNUbHpDSW13VGlLV0tXVUc2dmhCZlMzbnpJY040ODhxc3Fx?=
 =?utf-8?B?eTVlN3VOdWx3SHRkQ2dXTTJ3eWFMS3FoMDZTR2F4MTB2akdyeE0zdTJSR1pj?=
 =?utf-8?B?QmtRSmtuV2kzc2ZFNGswNU1kZHFySDZwMGNJZE53SlhSKzk0bkY1Z1ZYUkVO?=
 =?utf-8?B?SU8xaHNYdThsOGNkR0JkekRiYk10eXQ4M1hEdGFRbE8zZ0NyMWxaOG1FN21a?=
 =?utf-8?B?dFpDc3ZHQ21Pbm1nMHNaZFlrY3RZR3dLTzJYSDY0RzlsRDluSWVjVjkySC9s?=
 =?utf-8?B?TmVhbkE5eVZITW9GdEJnYWxxZGNNVWxzbHdZUXgzTXpnaHRpWnNIUzVhWjda?=
 =?utf-8?B?Q0xRMjMxTHJMd3VJSXp5V2J6SGp0WVZUNzFrZEVoSXNDa3ZMRTc3T1lJNmJH?=
 =?utf-8?B?Yi8wbDA1L1gxYWdIQWJOQmw5UHZiNks4VDEwZVJmOG5Md2hjc0Q4MjBDbE1X?=
 =?utf-8?B?SjRsTHJnckNxUU5uTTZybkdBZFQwaDR0aGlIOGFVSXFmNGVnRVJSQ1hmckJB?=
 =?utf-8?B?YS90M09uNVR1UGRSQ1Rhc2QyMEhHRzZGaGVtZ1FyWko1aTdzRzRMNVEwNGtM?=
 =?utf-8?B?UWZuWUZnNHZoQmY1cUFzUW5xaklFUWdaV0tnUzMrWUtlcW9QZitPQnJCMFBW?=
 =?utf-8?B?L0dhSVd6WnJpRnhZMW5GYTQ1V01GZWtwN2NsUjcvL0JkRjkwenFCZFRET2hV?=
 =?utf-8?B?NFpMNnpKUHkvcDRuTU83blRpMmhSa3E3NnhEbnN2RDhjZmQ0YzN4c1lPcThU?=
 =?utf-8?B?TVlZT2lDZGltd1orcEoxRGFSWGVuL1VDVFdKbEVxd25sSk5uTTd6SUhoZHN3?=
 =?utf-8?B?Tlh6bTdmU0VVUlVyTS9PVUU5RzBKSGJrSUgxaFh5RjV6Nk1FaTRnZUNZSkt6?=
 =?utf-8?B?cXZHV1NCeC9KRk5ieEp2c1pRTXlacWhYUjNIR09aU0JxZFp5WGtjb2tHcXRz?=
 =?utf-8?B?MGJvOEZOZCtwVEJMYUJ2Q01jSzJKY2p0YTVSaFpaTGE1ejZDMHpoNDUwYVJn?=
 =?utf-8?B?MGRDVEg4YmR3dTRGQ0hkcVZhOEdJTVpITUpUYkJ0NjFIcFNPZmxaQ2l2RVVo?=
 =?utf-8?B?blJSS1lRREJOa2svcUlYSDNhbmxIN2FxY2J4bTVxcm9YZHVKUlJYcmVhM0xK?=
 =?utf-8?B?a0lwRDM3Z0hyWGtRTXFUNTBGYVZldUNjczlJdEhEOHkrU05VTVNRTm1Kei9n?=
 =?utf-8?B?WEx0S2xSbHZzUFJpZkpCaS85M1YrbnIzOXBQNXorQ1B0Uk5pUU5kMFZmNFNm?=
 =?utf-8?B?NkF0ZTgxa0czQkRZVTNnNEtFcnI2RkZnZWorZ1ZOb0lWODJhMG9IOEdUL3FJ?=
 =?utf-8?B?MjdPaldPZjRobWJaS1c2eW1hS1BlTTZ6a0VNOC9VWHNDTk5PVnZsb1VaZm9T?=
 =?utf-8?Q?Nr4KrBWbA0TDFzXZV7BohW/9Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4fac27-4664-43a8-287e-08db1351bda5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:50:00.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFaPAmRMQAYOSQxMiAl3vjJlvT/X2lr/x6NIyHl0AEUiPfhxQ1570oABe3Dvj06wPi3OSPzTXIIciWv87b/Krg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 03:24, Jeremi Piotrowski wrote:
> This patch series introduces support for discovering AMD's PSP from an ACPI
> table and extends the CCP driver to allow binding to that device on x86. This
> method of PSP discovery is used on Hyper-V when SNP isolation support is
> exposed to the guest. There is no ACPI node associated with this PSP, so after
> parsing the ASPT it is registered with the system as a platform_device.
> 
> I thought about putting psp.c in arch/x86/coco, but that directory is meant for
> the (confidential) guest side of CoCo, not the supporting host side code.
> It was kept in arch/x86/kernel because configuring the irq for the PSP through
> the ACPI interface requires poking at bits from the architectural vector
> domain.
> 
> This series is a prerequisite for nested SNP-host support on Hyper-V but is
> independent of the SNP-host support patch set. Hyper-V only supports nested
> SEV-SNP (not SEV or SEV-ES) so the PSP only supports a subset of the full PSP
> command set. Without SNP-host support (which is not upstream yet), the only
> PSP command that will succeed is SEV_PLATFORM_STATUS.
> 

For the series:

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

Probably want Boris to weigh in on whether he wants the new psp.c file 
located in arch/x86/kernel, though.

> Changes since v1:
> * move platform_device_add_data() call to commit that introduces psp device
> * change psp dependency from CONFIG_AMD_MEM_ENCRYPT to CONFIG_KVM_AMD_SEV
> * add blank lines, s/plat/platform/, remove variable initializers before first
>    use, remove masking/shifting where not needed
> * dynamically allocate sev_vdata/psp_vdata structs instead of overwriting static
>    variables
> 
> Jeremi Piotrowski (8):
>    include/acpi: add definition of ASPT table
>    ACPI: ASPT: Add helper to parse table
>    x86/psp: Register PSP platform device when ASP table is present
>    x86/psp: Add IRQ support
>    crypto: cpp - Bind to psp platform device on x86
>    crypto: ccp - Add vdata for platform device
>    crypto: ccp - Skip DMA coherency check for platform psp
>    crypto: ccp - Allow platform device to be psp master device
> 
>   arch/x86/kernel/Makefile          |   1 +
>   arch/x86/kernel/psp.c             | 219 ++++++++++++++++++++++++++++++
>   drivers/acpi/Makefile             |   1 +
>   drivers/acpi/aspt.c               | 104 ++++++++++++++
>   drivers/crypto/ccp/sp-dev.c       |  66 +++++++++
>   drivers/crypto/ccp/sp-dev.h       |   4 +
>   drivers/crypto/ccp/sp-pci.c       |  48 -------
>   drivers/crypto/ccp/sp-platform.c  |  76 ++++++++++-
>   include/acpi/actbl1.h             |  46 +++++++
>   include/linux/platform_data/psp.h |  32 +++++
>   10 files changed, 548 insertions(+), 49 deletions(-)
>   create mode 100644 arch/x86/kernel/psp.c
>   create mode 100644 drivers/acpi/aspt.c
>   create mode 100644 include/linux/platform_data/psp.h
> 
