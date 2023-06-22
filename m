Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC273A318
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFVOcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjFVOcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:32:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E2319BE;
        Thu, 22 Jun 2023 07:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+zoj/l1byT4umdYEAwwo/5TlwaqTreHi7odC+Z5FBS+JQgE2URQYtZT1cfi+5mf+YA0zrFdTkcjkL+v1/Y+EkxVk0EXiyUktwsNjRp4c0xfu+JFtqR3E9zLm3ko6JKa/Db+VKc30DzbSGxgcprVuEKDiyN+B/325zQSZNL4D8ERCbOiBZWK9wM/qvx9iJBx8vzc8l6Iwj4qNpBWbA6JwlNvskQB3O7yC3RfEiutDxj7RACpRw5uPqvSfNU1CAbgPFeUvNDgQ2bp+mZxtDYxKdrQ2SK9jBgzjvt07K2FfbKJ3qu/iB2dOanLxMEZSvQ8obOW9JhGRdl9fScM9lPmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lyC5XP60I1pfW6xw8TswS5IWf2B55Z/R5/DINLRNLA=;
 b=Rt47t/J0lHXVjjMKV8IkDfaB8/J9G5M1DhT7q/AJmIf0T2FNTMq56k8N42GvYcUB81q5J6lUirpXg9RjCRSHUgjYSgrgfCThwrNgckCjqcNtvWihGk/U04WLwfTOsN/RtOWhY/yIkoOFhiIWGQvFByW1Rtklmvkc1qx5BLBnaGwYCE74Sytm95UmTQc1tyiZQlD1dWMZjZpLzj7H1TJS5zBJeWXY0Xvej+yK8uNk9pagl7LOkUrOSK4OGu8n7iWeTqy4Y3I1C2gYDbsPhmekL2sx4DWP7sZJetkHChlH7BhhI9OOwJ98HNC7KOZOjEr2wn7XmWTBiXFBC+gWpXOXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lyC5XP60I1pfW6xw8TswS5IWf2B55Z/R5/DINLRNLA=;
 b=30oH3GutF+EuXmDuuzNHOWjDhnE4v3G/NXXpf4p1EkHi4nmSzdDVfL73pbRnK1BbD2yBqepOfV5e8pAJVaXRQTh1iXv1RHsaNtKeVmzjTnkdJetvS0Zh5CDlpo5nxTJpuBHt7zRpYDKojCjFjmmsgGWP6uDNXi5XpOfAUpKxWG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1SPRMB0007.namprd12.prod.outlook.com (2603:10b6:208:39e::8)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 14:32:36 +0000
Received: from BL1SPRMB0007.namprd12.prod.outlook.com
 ([fe80::3404:aab:eb6f:8754]) by BL1SPRMB0007.namprd12.prod.outlook.com
 ([fe80::3404:aab:eb6f:8754%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 14:32:35 +0000
Message-ID: <4f84f895-a733-df1d-552a-862a2f60933c@amd.com>
Date:   Thu, 22 Jun 2023 09:32:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Content-Language: en-US
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, kraxel@redhat.com, dovmurik@linux.ibm.com,
        elena.reshetova@intel.com, dave.hansen@linux.intel.com,
        Dhaval.Giani@amd.com, michael.day@amd.com,
        pavankumar.paluri@amd.com, David.Kaplan@amd.com,
        Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com,
        gregkh@linuxfoundation.org, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230612164727.3935657-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0193.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::18) To BL1SPRMB0007.namprd12.prod.outlook.com
 (2603:10b6:208:39e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1SPRMB0007:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: a6875df5-568b-424a-932b-08db732d85b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNTALVG6yyBlUcgGsnb9zNqfEWIuMumj4XbSdvagFsoEUBqS5TYO91TVWlxSVnZJF0QWOsPfrui/UpIb4jt9bWHjgMRSCKuXAAhbaAwY5L2r8FiG34aKoO6jMRX+KzfwnUGazSS+cMjWvYZtuYA5UejV/ljJYv6qhl3knu0dEbM3Y2WyxvIw3stlI6/hEeF86N3C3VQ/MWigrK3f+YbYCUZMiSL842kCrNB2JBILRrwjVDkW9lNv0BZHZ9SRBMiPD50EBscCuX5rN2kmcVpgWTrODiLmDcmf8HisSK73Ia9iVcsn//mu99MkJbWn5dT3vosT6RXdl6TLJI2jZ+JqfXxAkwWHDHdWUpR61c8wnArAAK1sEav6UyBC7ygdy9++i0Dh/BNP3xgKbPoA8gfw150wZziK7AiYE6VeUMbnin0wdGcIdAjqCnERbbUOgd91Jjv2lF22f03/aoRM9ukX4aEBfBEplHr/PLa4qj24PjHov/ZAjPEQICkQaatjar2x7KxVZxbEBqld+kFNoLZmDS6mHVjPsjCllZIpNhxAwNH155Jxn5/1CkJELMR6LgE85ITtfkCqc/eHqpPE75tkdSpHuxnFCwkVLS4uYxjtUFy0JNuGJdTG7tkU9GiGVHv20YmPDwl4cW6ZXPzd2L6pZJL+HW/DLK2SiGXRNfdws08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1SPRMB0007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(6512007)(4326008)(6666004)(966005)(26005)(186003)(36756003)(2906002)(31686004)(31696002)(86362001)(2616005)(316002)(44832011)(8936002)(66946007)(6916009)(66476007)(66556008)(5660300002)(478600001)(53546011)(6486002)(7406005)(6506007)(30864003)(15650500001)(7416002)(83380400001)(41300700001)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG8xbGorWmVBVUV0dmZsUWF2VUJhMEQwMjREb21WdERsTndOakEvRG80ejhq?=
 =?utf-8?B?M0w5VDd4WmVFSVc5OENla2w1RnFVYUVUZm9CVFZqalFBaW91UUdlQkN1dnFv?=
 =?utf-8?B?dUVuNGNRVWQ1anA2WFZTTjV4ZW92NHNTajFnN09tWDJranU4OStFM2xLZXB0?=
 =?utf-8?B?aGQzOXhaY0RXNnMxYkdyMEhlU3gydjhFb2xkVlJtNzV2Y0ZXRlVsTWIxUXh1?=
 =?utf-8?B?cG5YbmtXbjQrWXhDOWE5MXRQWkk0eVJvaXQxMEdvVW5mTEtrdFF0aHc0dUUy?=
 =?utf-8?B?M1JOWVcyTEJLTGJDaVlsZld5TkE5R0tMM3VacVF1bGpxdDBjU1BnWWNaUWdt?=
 =?utf-8?B?SC92UGN3NnVWalovckdhaW1ydityUktaM01kSXc5RzE5RENSZ1lNYTdnRjhX?=
 =?utf-8?B?T1ZwRFY3d2ppMVQ2RW9STGhSMU1LWE9uM2tUSVhJR2l2MW9xa01XVVozazFy?=
 =?utf-8?B?SXluQmRiemdGTlJFb3JqdHE4WDhxNlFBVGkxbGpxcGJvTi9lUktqaFV0ekdU?=
 =?utf-8?B?Z3dDNWk4bFpnaWRNRUl0dnhlenR3RWl0bmtkUkZzcVh5bkdpc0lFSUYyNlVD?=
 =?utf-8?B?ZldBS3JBNitTOVpydm9IS25nRVFQZEd3WjFiOTdnTVZwWXV4UExQTzhlSEN1?=
 =?utf-8?B?WG11WkdaV2YvTEZuVW9zZDFoNG8rblBFaXhMRWZ2bDdQTmdORHlhd0VBSWNM?=
 =?utf-8?B?czFhMkFUYm5JS1FoeDBTMGUvTVhFRFBpSXg0dDhaUUt3YkhzWTNRSEZFaFUr?=
 =?utf-8?B?algrVExlbjByWWFZaEoxaXRtbXN2aDQ0VGxRZ1YrUXBBYXFVWXA3aWZBY0RH?=
 =?utf-8?B?SjViWnhYMkc4UlhlKyszQTRwSU9jZVRHSkd5UTA0VFdVNWJ0NVU1a3JZVGhh?=
 =?utf-8?B?U3VCZWNvdFlJWmkrczdoejZtUngyMWRyZjExTEEvZTJoRVJFeHJmYkMvQ1Z2?=
 =?utf-8?B?RVVUVy9iUEVTeHpMa1h6LzlUQ1ZvQmVFb1dEK3ZUenh6bXhVbG1wcFdoUk9E?=
 =?utf-8?B?aVF4cEpNSnNtU1lTS3Nhbyt3WWNoc0d2YVJLU25yTEZOSTVxUkFmMVhTUGlI?=
 =?utf-8?B?ODBhbVhoNllpT0RHUS95aitvbzBDbDA2Tm1NNXhPdmZMZlEyVDArSU9oUUE5?=
 =?utf-8?B?VGZ6UjJNbTdnRmRjTzNZZW5aZitxQ2NCMDdycmp0TzZpTDBmSFFxZU1Ld1B0?=
 =?utf-8?B?VHkwek1Jc2ZPYW1UUUZnczFDWnBBUGljem9pRFp2MkpNMDdqMGM3dXkyWEw2?=
 =?utf-8?B?U0laRnhTc2IxQ2hpMmVGNzBkalduVWV2QldBYzRUVnd3QzZNVEJKV29MZEFl?=
 =?utf-8?B?SVptSFI0RjFMRU5lR3RQRkc2MUMrZjJ5WXJmdnltNTFEbTNGZU0wVlAvNmtK?=
 =?utf-8?B?ZVlZTFpMcHF4WjFYWTNEM2tPL1h5a2x0OC9lZkgwZWY4SDZweExMeEowZkZZ?=
 =?utf-8?B?OFh2T3lWbjNHSFRKTmkveVcvYXJXMkxEaXZNWjE3QjRMc3BoL1IyWVpMd3pL?=
 =?utf-8?B?NnNYZ1pWY3UyaU9UM2p1TGYvbjhPUnJReFNFL3lBZmljNVVzR3dydFBQak40?=
 =?utf-8?B?R1Jtd3NkMXdlV29WTno5QVB3RjhzbTExRHN4T0N5bE51SkR4cDB5a3JpTlh2?=
 =?utf-8?B?MWdpcFlYdVovTTQyRVRZV3d2eUZkeE9RYVdYd3BPSlNkYXc4UHVWWU0xcDJL?=
 =?utf-8?B?L1dLM0s2NUlrd2hwdDBJNE9NdGp5emJaS0xNVkNIUzJrdEljTzcyQTBJZFhn?=
 =?utf-8?B?aUc3WUlqSjBRUmZnUDNQTzdTQUVPZzZyMHY5V0tYMllpTmZSb2Jaek1RMUxH?=
 =?utf-8?B?Tkozc1g0OW5OQXNrT1BpSXFDYnJoaGtQZWhwUlFYL1V1UVQxalJyK3c4aXls?=
 =?utf-8?B?TTlBUUlJeS9NTTU0cDFHZDJ6amlUeEVtRFVZazNIVWZTQkt3Z1F6by85aDlr?=
 =?utf-8?B?SEsxekp4Q3RwUzJiZTRpbVlRelZacWF2TENLWjdnMWlwSXpxRzlwZzhKOTBZ?=
 =?utf-8?B?N2d1bHRXakFaMHgwdFFLMUd3bEVndXpCNUg5eWJhWkNXdnhZYW0yQVBKVC9j?=
 =?utf-8?B?aC9qNFNiSWpJVzE0eTY3NklIQm40TjZNcDNuUW9GbXdHZU84QjlieldlZDJv?=
 =?utf-8?Q?pJfSHb+kbrxCM2Jhh6dHo0xm8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6875df5-568b-424a-932b-08db732d85b7
X-MS-Exchange-CrossTenant-AuthSource: BL1SPRMB0007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:32:35.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHJ0xyERU3syaxcfjc4HkcvT6uwB91CRC/oV7DgHRcp70vdYPSnpDThuvBWdMsoZ8IStTaUpqo7AhvIPoQcOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 11:47, Carlos Bilbao wrote:
> Kernel developers working on confidential computing for virtualized
> environments in x86 operate under a set of assumptions regarding the Linux
> kernel threat model that differs from the traditional view. Historically,
> the Linux threat model acknowledges attackers residing in userspace, as
> well as a limited set of external attackers that are able to interact with
> the kernel through networking or limited HW-specific exposed interfaces
> (e.g. USB, thunderbolt). The goal of this document is to explain additional
> attack vectors that arise in the virtualized confidential computing space
> and discuss the proposed protection mechanisms for the Linux kernel.

To expedite things, I'm going to outline the changes to make for v3 based
on the given feedback. Please, take a look and let me know if I'm missing
something. Changes for v3:

- Remove pKVM from the document. Although there are clear overlaps in the
   threat models (as the discussions have shown), it might be good to omit
   pKVM for now to avoid further complexity. In the future, when pKVM is
   more mature, we can revisit and discuss its inclusion.

- Change file name to "snp-tdx-threat-model.rst".

- Replace hyphens (dashes) for parenthesis in a parenthetical sentence.

- Change "technology specific" for "technology-specific".

> 
> Reviewed-by: Larry Dewey <larry.dewey@amd.com>
> Reviewed-by: David Kaplan <david.kaplan@amd.com>
> Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
> 
> V1 can be found in:
>   https://lore.kernel.org/lkml/20230327141816.2648615-1-carlos.bilbao@amd.com/
> Changes since v1:
> 
> - Apply feedback from first version of the patch
> - Clarify that the document applies only to a particular angle of
>    confidential computing, namely confidential computing for virtualized
>    environments. Also, state that the document is specific to x86 and
>    that the main goal is to discuss the emerging threats.
> - Change commit message and file name accordingly
> - Replace AMD's link to AMD SEV SNP white paper
> - Minor tweaking and clarifications
> 
> ---
>   Documentation/security/index.rst              |   1 +
>   .../security/x86-confidential-computing.rst   | 298 ++++++++++++++++++
>   MAINTAINERS                                   |   6 +
>   3 files changed, 305 insertions(+)
>   create mode 100644 Documentation/security/x86-confidential-computing.rst
> 
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index 6ed8d2fa6f9e..bda919aecb37 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -6,6 +6,7 @@ Security Documentation
>      :maxdepth: 1
>   
>      credentials
> +   x86-confidential-computing
>      IMA-templates
>      keys/index
>      lsm
> diff --git a/Documentation/security/x86-confidential-computing.rst b/Documentation/security/x86-confidential-computing.rst
> new file mode 100644
> index 000000000000..5c52b8888089
> --- /dev/null
> +++ b/Documentation/security/x86-confidential-computing.rst
> @@ -0,0 +1,298 @@
> +======================================================
> +Confidential Computing in Linux for x86 virtualization
> +======================================================
> +
> +.. contents:: :local:
> +
> +By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao@amd.com>
> +
> +Motivation
> +==========
> +
> +Kernel developers working on confidential computing for virtualized
> +environments in x86 operate under a set of assumptions regarding the Linux
> +kernel threat model that differ from the traditional view. Historically,
> +the Linux threat model acknowledges attackers residing in userspace, as
> +well as a limited set of external attackers that are able to interact with
> +the kernel through various networking or limited HW-specific exposed
> +interfaces (USB, thunderbolt). The goal of this document is to explain
> +additional attack vectors that arise in the confidential computing space
> +and discuss the proposed protection mechanisms for the Linux kernel.
> +
> +Overview and terminology
> +========================
> +
> +Confidential Computing (CoCo) is a broad term covering a wide range of
> +security technologies that aim to protect the confidentiality and integrity
> +of data in use (vs. data at rest or data in transit). At its core, CoCo
> +solutions provide a Trusted Execution Environment (TEE), where secure data
> +processing can be performed and, as a result, they are typically further
> +classified into different subtypes depending on the SW that is intended
> +to be run in TEE. This document focuses on a subclass of CoCo technologies
> +that are targeting virtualized environments and allow running Virtual
> +Machines (VM) inside TEE. From now on in this document will be referring
> +to this subclass of CoCo as 'Confidential Computing (CoCo) for the
> +virtualized environments (VE)'.
> +
> +CoCo, in the virtualization context, refers to a set of HW and/or SW
> +technologies that allow for stronger security guarantees for the SW running
> +inside a CoCo VM. Namely, confidential computing allows its users to
> +confirm the trustworthiness of all SW pieces to include in its reduced
> +Trusted Computing Base (TCB) given its ability to attest the state of these
> +trusted components.
> +
> +While the concrete implementation details differ between technologies, all
> +available mechanisms aim to provide increased confidentiality and
> +integrity for the VM's guest memory and execution state (vCPU registers),
> +more tightly controlled guest interrupt injection, as well as some
> +additional mechanisms to control guest-host page mapping. More details on
> +the x86-specific solutions can be found in
> +:doc:`Intel Trust Domain Extensions (TDX) </arch/x86/tdx>` and
> +`AMD Memory Encryption <https://www.amd.com/system/files/techdocs/sev-snp-strengthening-vm-isolation-with-integrity-protection-and-more.pdf>`_.
> +
> +The basic CoCo guest layout includes the host, guest, the interfaces that
> +communicate guest and host, a platform capable of supporting CoCo VMs, and
> +a trusted intermediary between the guest VM and the underlying platform
> +that acts as a security manager. The host-side virtual machine monitor
> +(VMM) typically consists of a subset of traditional VMM features and
> +is still in charge of the guest lifecycle, i.e. create or destroy a CoCo
> +VM, manage its access to system resources, etc. However, since it
> +typically stays out of CoCo VM TCB, its access is limited to preserve the
> +security objectives.
> +
> +In the following diagram, the "<--->" lines represent bi-directional
> +communication channels or interfaces between the CoCo security manager and
> +the rest of the components (data flow for guest, host, hardware) ::
> +
> +    +-------------------+      +-----------------------+
> +    | CoCo guest VM     |<---->|                       |
> +    +-------------------+      |                       |
> +      | Interfaces |           | CoCo security manager |
> +    +-------------------+      |                       |
> +    | Host VMM          |<---->|                       |
> +    +-------------------+      |                       |
> +                               |                       |
> +    +--------------------+     |                       |
> +    | CoCo platform      |<--->|                       |
> +    +--------------------+     +-----------------------+
> +
> +The specific details of the CoCo security manager vastly diverge between
> +technologies. For example, in some cases, it will be implemented in HW
> +while in others it may be pure SW. In some cases, such as for the
> +`Protected kernel-based virtual machine (pKVM) <https://github.com/intel-staging/pKVM-IA>`,
> +the CoCo security manager is a small, isolated and highly privileged
> +(compared to the rest of SW running on the host) part of a traditional
> +VMM.
> +
> +Existing Linux kernel threat model
> +==================================
> +
> +The overall components of the current Linux kernel threat model are::
> +
> +     +-----------------------+      +-------------------+
> +     |                       |<---->| Userspace         |
> +     |                       |      +-------------------+
> +     |   External attack     |         | Interfaces |
> +     |       vectors         |      +-------------------+
> +     |                       |<---->| Linux Kernel      |
> +     |                       |      +-------------------+
> +     +-----------------------+      +-------------------+
> +                                    | Bootloader/BIOS   |
> +                                    +-------------------+
> +                                    +-------------------+
> +                                    | HW platform       |
> +                                    +-------------------+
> +
> +There is also communication between the bootloader and the kernel during
> +the boot process, but this diagram does not represent it explicitly. The
> +"Interfaces" box represents the various interfaces that allow
> +communication between kernel and userspace. This includes system calls,
> +kernel APIs, device drivers, etc.
> +
> +The existing Linux kernel threat model typically assumes execution on a
> +trusted HW platform with all of the firmware and bootloaders included on
> +its TCB. The primary attacker resides in the userspace, and all of the data
> +coming from there is generally considered untrusted, unless userspace is
> +privileged enough to perform trusted actions. In addition, external
> +attackers are typically considered, including those with access to enabled
> +external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
> +interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
> +of disks offline.
> +
> +Regarding external attack vectors, it is interesting to note that in most
> +cases external attackers will try to exploit vulnerabilities in userspace
> +first, but that it is possible for an attacker to directly target the
> +kernel; particularly if the host has physical access. Examples of direct
> +kernel attacks include the vulnerabilities CVE-2019-19524, CVE-2022-0435
> +and CVE-2020-24490.
> +
> +Confidential Computing threat model and its security objectives
> +===============================================================
> +
> +Confidential Computing adds a new type of attacker to the above list: a
> +potentially misbehaving host (which can also include some part of a
> +traditional VMM or all of it), which is typically placed outside of the
> +CoCo VM TCB due to its large SW attack surface. It is important to note
> +that this doesn’t imply that the host or VMM are intentionally
> +malicious, but that there exists a security value in having a small CoCo
> +VM TCB. This new type of adversary may be viewed as a more powerful type
> +of external attacker, as it resides locally on the same physical machine
> +-in contrast to a remote network attacker- and has control over the guest
> +kernel communication with most of the HW::
> +
> +                                 +------------------------+
> +                                 |    CoCo guest VM       |
> +   +-----------------------+     |  +-------------------+ |
> +   |                       |<--->|  | Userspace         | |
> +   |                       |     |  +-------------------+ |
> +   |   External attack     |     |     | Interfaces |     |
> +   |       vectors         |     |  +-------------------+ |
> +   |                       |<--->|  | Linux Kernel      | |
> +   |                       |     |  +-------------------+ |
> +   +-----------------------+     |  +-------------------+ |
> +                                 |  | Bootloader/BIOS   | |
> +   +-----------------------+     |  +-------------------+ |
> +   |                       |<--->+------------------------+
> +   |                       |          | Interfaces |
> +   |                       |     +------------------------+
> +   |     CoCo security     |<--->| Host/Host-side VMM |
> +   |      manager          |     +------------------------+
> +   |                       |     +------------------------+
> +   |                       |<--->|   CoCo platform        |
> +   +-----------------------+     +------------------------+
> +
> +While traditionally the host has unlimited access to guest data and can
> +leverage this access to attack the guest, the CoCo systems mitigate such
> +attacks by adding security features like guest data confidentiality and
> +integrity protection. This threat model assumes that those features are
> +available and intact.
> +
> +The **Linux kernel CoCo VM security objectives** can be summarized as follows:
> +
> +1. Preserve the confidentiality and integrity of CoCo guest's private
> +memory and registers.
> +
> +2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
> +While it is true that the host (and host-side VMM) requires some level of
> +privilege to create, destroy, or pause the guest, part of the goal of
> +preventing privileged escalation is to ensure that these operations do not
> +provide a pathway for attackers to gain access to the guest's kernel.
> +
> +The above security objectives result in two primary **Linux kernel CoCo
> +VM assets**:
> +
> +1. Guest kernel execution context.
> +2. Guest kernel private memory.
> +
> +The host retains full control over the CoCo guest resources, and can deny
> +access to them at any time. Examples of resources include CPU time, memory
> +that the guest can consume, network bandwidth, etc. Because of this, the
> +host Denial of Service (DoS) attacks against CoCo guests are beyond the
> +scope of this threat model.
> +
> +The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
> +guest Linux kernel towards an untrusted host that is not covered by the
> +CoCo technology SW/HW protection. This includes any possible
> +side-channels, as well as transient execution side channels. Examples of
> +explicit (not side-channel) interfaces include accesses to port I/O, MMIO
> +and DMA interfaces, access to PCI configuration space, VMM-specific
> +hypercalls (towards Host-side VMM), access to shared memory pages,
> +interrupts allowed to be injected into the guest kernel by the host, as
> +well as CoCo technology specific hypercalls, if present. Additionally, the
> +host in a CoCo system typically controls the process of creating a CoCo
> +guest: it has a method to load into a guest the firmware and bootloader
> +images, the kernel image together with the kernel command line. All of this
> +data should also be considered untrusted until its integrity and
> +authenticity is established via attestation.
> +
> +The table below shows a threat matrix for the CoCo guest Linux kernel with
> +the potential mitigation strategies. The matrix refers to CoCo-specific
> +versions of the guest, host and platform.
> +
> +.. list-table:: CoCo Linux guest kernel threat matrix
> +   :widths: auto
> +   :align: center
> +   :header-rows: 1
> +
> +   * - Threat name
> +     - Threat description
> +     - Mitigation strategies
> +
> +   * - Guest malicious configuration
> +     - A misbehaving host modifies one of the following guest's
> +       configuration:
> +
> +       1. Guest firmware or bootloader
> +
> +       2. Guest kernel or module binaries
> +
> +       3. Guest command line parameters
> +
> +       This allows the host to break the integrity of the code running
> +       inside a CoCo guest, and violates the CoCo security objectives.
> +     - The integrity of the guest's configuration passed via untrusted host
> +       must be ensured by methods such as remote attestation and signing.
> +       This should be largely transparent to the guest kernel, and would
> +       allow it to assume a trusted state at the time of boot.
> +
> +   * - CoCo guest data attacks
> +     - A misbehaving host retains full control of the CoCo guest's data
> +       in-transit between the guest and the host-managed physical or
> +       virtual devices. This allows any attack against confidentiality,
> +       integrity or freshness of such data.
> +     - The CoCo guest is responsible for ensuring the confidentiality,
> +       integrity and freshness of such data using well-established
> +       security mechanisms. For example, for any guest external network
> +       communications passed via the untrusted host, an end-to-end
> +       secure session must be established between a guest and a trusted
> +       remote endpoint using well-known protocols such as TLS.
> +       This requirement also applies to protection of the guest's disk
> +       image.
> +
> +   * - Malformed runtime input
> +     - A misbehaving host injects malformed input via any communication
> +       interface used by the guest's kernel code. If the code is not
> +       prepared to handle this input correctly, this can result in a host
> +       --> guest kernel privilege escalation. This includes traditional
> +       side-channel and/or transient execution attack vectors.
> +     - The attestation or signing process cannot help to mitigate this
> +       threat since this input is highly dynamic. Instead, a different set
> +       of mechanisms is required:
> +
> +       1. *Limit the exposed attack surface*. Whenever possible, disable
> +       complex kernel features and device drivers (not required for guest
> +       operation) that actively use the communication interfaces between
> +       the untrusted host and the guest. This is not a new concept for the
> +       Linux kernel, since it already has mechanisms to disable external
> +       interfaces, such as attacker's access via USB/Thunderbolt subsystem.
> +
> +       2. *Harden the exposed attack surface*. Any code that uses such
> +       interfaces must treat the input from the untrusted host as malicious,
> +       and do sanity checks before processing it. This can be ensured by
> +       performing a code audit of such device drivers as well as employing
> +       other standard techniques for testing the code robustness, such as
> +       fuzzing. This is again a well-known concept for the Linux kernel,
> +       since all its networking code has been previously analyzed under
> +       presumption of processing malformed input from a network attacker.
> +
> +   * - Malicious runtime input
> +     - A misbehaving host injects a specific input value via any
> +       communication interface used by the guest's kernel code. The
> +       difference with the previous attack vector (malformed runtime input)
> +       is that this input is not malformed, but its value is crafted to
> +       impact the guest's kernel security. Examples of such inputs include
> +       providing a malicious time to the guest or the entropy to the guest
> +       random number generator. Additionally, the timing of such events can
> +       be an attack vector on its own, if it results in a particular guest
> +       kernel action (i.e. processing of a host-injected interrupt).
> +     - Similarly, as with the previous attack vector, it is not possible to
> +       use attestation mechanisms to address this threat. Instead, such
> +       attack vectors (i.e. interfaces) must be either disabled or made
> +       resistant to supplied host input.
> +
> +As can be seen from the above table, the potential mitigation strategies
> +to secure the CoCo Linux guest kernel vary, but can be roughly split into
> +mechanisms that either require or do not require changes to the existing
> +Linux kernel code. One main goal of the CoCo security architecture is to
> +minimize changes to the Linux kernel code, while also providing usable
> +and scalable means to facilitate the security of a CoCo guest kernel.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a73486c4aa6e..1d4ae60cdee9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5197,6 +5197,12 @@ S:	Orphan
>   W:	http://accessrunner.sourceforge.net/
>   F:	drivers/usb/atm/cxacru.c
>   
> +CONFIDENTIAL COMPUTING THREAT MODEL FOR X86 VIRTUALIZATION
> +M:    Elena Reshetova <elena.reshetova@intel.com>
> +M:    Carlos Bilbao <carlos.bilbao@amd.com>
> +S:    Maintained
> +F:    Documentation/security/x86-confidential-computing.rst
> +
>   CONFIGFS
>   M:	Joel Becker <jlbec@evilplan.org>
>   M:	Christoph Hellwig <hch@lst.de>

Thanks,
Carlos
