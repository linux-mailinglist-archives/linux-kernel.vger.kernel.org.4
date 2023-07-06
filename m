Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F2174A677
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGFWAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFWAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:00:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41211E72
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW1+eiedKBgEOlNSueTSni0PyyADG8SjcAAI48a8MmN/0M22N2kmVAf+woierDGVrw7CipOtRCVrR3hfNwoOBCd4hzQjfu9ssDORJ+/sJ4AWZKS+BoxKZGLkqLuYUc9by7Nc+OC91ONp5ZvjmNYUIr+BZkbldOwhEEyIidAAymz/9/vYjEHz7OJTbOvdh3YEziKL29UuSyf7yxJG59qPl5KdWzPTlJoLKctmV+yEUySYgDsVF6d8a0KySbDIOUsEgu9Yk7S7RblPB71htbEufPlmpoEP4UyX5qdaASPLPFUtyeAtw9BueN0gPYWDBa5RzPUfjVAu9Z+6BOH8vgTBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ4HOpxiAU2vk/b5IRz3riaxt96cIIuMq/4gpvN+31Y=;
 b=ZB31GLSi7/voTYkV0HK51rvQNspb5DdP/Fz/HAQsz/mhr2Nuubg/vYAFdtL8ibAT8yFDq1orzwOD/JFKuEy1VJhyEXpJG70hh89IH085GH2jHFfF6Om/SQbUdJrpkNWMoaanh4HGmMlqWsrL+DL6eh/5Zjs3GClPdkkn9dN11OvLC9dx1bwoJsCvbAPcgC8OkJJKnVmFdCPrV+GIe+y+9BHOxmvVp4tNV5aUKkLkSQKdsjgh1U+6V0fDv4DQJjvyvRCsBQUEXcp2N560uQszOjpih7jMCbqfDxdX7zir+dd11FlQjiBH5+SOBHgXNEWEu9m3Z020VDN7mIBRj5NZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ4HOpxiAU2vk/b5IRz3riaxt96cIIuMq/4gpvN+31Y=;
 b=dNKA3ZzNz5aSGx0o2g+7a5aNJRY5j3hM66Wm6/AekgCzwNjz+PhV3zYFKRylRHBzCSc3Va+8mdSY0hg/fRnSlPJ2eFiXUtFJhO3NB7oV9WGfSBAd96VQcpwOb9NTrruR8kIV/UxlX9kcjtZSj/m7K4U0rQW8KD0S90d+96jFNCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 DM8PR01MB7095.prod.exchangelabs.com (2603:10b6:8:3::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 22:00:32 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476%2]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 22:00:32 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: [PATCH v6] arm64: sdei: abort running SDEI handlers during crash
In-Reply-To: <20230627002939.2758-1-scott@os.amperecomputing.com>
References: <20230627002939.2758-1-scott@os.amperecomputing.com>
Date:   Thu, 06 Jul 2023 15:00:22 -0700
Message-ID: <86pm54wvih.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:610:38::35) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|DM8PR01MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f6b6da-dcb0-4276-dc89-08db7e6c6819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/8U/aM00ea7pwxVTJbtDtog9+wdq6JvOM7k1seU6pjnINpNuALI/+8mNzmsysfk388lyB0tajndtIb0OX22tX20XxNbHCiLFldnxNdXWFItzBAOfJr7wrMqcLo1oIaoPDvmkahj0diuZL/P9IJOgYoFcjcUwxObgh54PVbi+rfbIdL5b13wR5CRrIdWPbpPcxwEqc0QxIxPNgobJ4I6NQgoGMcaVVrL48YvIxYRwjRdZSvaaTcoQBGgaKgVWZ7IIfAxoKQoApAzJAottlnfssp5HdOCABpjnrqIDWXhhdi4Jgyu7jnqdvC4HnIyibl2hyGpJ9qkOYshqSU7VhojUarBWtTsmJg0GQED9Bga3mBRBVPCI3k5kqGXb1j+aewIjldmn/em4DwEfwYveOwUqebTRGRo5o3G81V7Xn8EA6UPmBxVecn01gbIvdgRbhtnqPUCHb/T3TfyLSbamDu4dISV0lLy32dlS+H0q1Hyg2B4JAw/NMM50AYC9icjRA5msYPAoLFmKCrBBOHhUfZ6zPpEhAA8W78KwOVOZUcmhBsdgf17VhNA83lt2Xs/R8Hov0R7KWEluwvtBRX5KFSgT+01D1xtyJmiZa9F/2GdGMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(451199021)(52116002)(478600001)(6486002)(6666004)(54906003)(9686003)(6506007)(26005)(186003)(966005)(6512007)(107886003)(66946007)(2906002)(316002)(4326008)(5660300002)(66556008)(41300700001)(66476007)(8936002)(8676002)(38350700002)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aidAraIFi/TON5M01BpxzktM6GRKG9lSZ3wnJGF8P39Ez8Opmqi0h8A/G2vH?=
 =?us-ascii?Q?9AQpdNMNVj7Tk7oLr13HS1nYiZJaPJiU8v0jljvXBvI+AQ+TqP9Sp6BF/mgg?=
 =?us-ascii?Q?1TQvKb9bh3k7oAgTGF9liBLDI+PLaQvOa14fHcjrTvukweQ49PL9sIGtkxCb?=
 =?us-ascii?Q?XzoUmPNE2PknP457XKS/oUHGIPrkZWczsZWRAKUtjGH78D6GZbbk2MAh9Wyl?=
 =?us-ascii?Q?Xcr9aorLmKuha6thjsQAw1nFNuKdV4Jw7fatB2LFvMPLVn2SagiErYSCW/v0?=
 =?us-ascii?Q?Vhg/cZ1MIHHjVXyHWLH2lCuZxpAeF6kOWdJjyM4mEMDYuy1xgDQt+d4mG2Q4?=
 =?us-ascii?Q?gXhHIXAkt6WWcs/vd8j7V30DzWteg82i2Mtyw2PK17c8EU1p/Amd0tnjGI6i?=
 =?us-ascii?Q?Zos+Pm0/t1Cres2Pf1yYujRfb7+0h0rHXf+fLFDUgTJnKLb5lgHoEtSsYTcD?=
 =?us-ascii?Q?0p+8MbToOstC8aHCaLQ9epkp7KlDeUfo3FPT5VQHsHYY780pwFYH2uSaTNa2?=
 =?us-ascii?Q?WHug3Y8JeqU+4mBnJQSjBHSdQxeo+xTtI1fT+qbIIYOBKYimjk+tbneCTXTa?=
 =?us-ascii?Q?OoHBWH5IKhHZ7CNpSb75Tgqh827+SYpVV0Mt/NCoy4/ujub7kAeelIbTiJOm?=
 =?us-ascii?Q?vp8lTyOguT/xQXi1MQtTpceTFdArHacSDnFSVsV1/QOaulZY7VPlMrc3A/TQ?=
 =?us-ascii?Q?y7bMWG3AJlg1wugjlZdWHX6TjpcZ6jF9UKVJ2MUvS4zN9eKN7InUWv6wn3Sz?=
 =?us-ascii?Q?7b9NkdsSqDgbbNWBSo7UiCHDDzzdOWzsqtuuyU+95xrZYNaqJsmPwcP0m1PD?=
 =?us-ascii?Q?+xxRHRGOvDGJXqpfpFKSPlRPqc6VVYJ/MSxBLY6gvAH8usrVj1QnxfnX3omq?=
 =?us-ascii?Q?sutaJsyxleWuemIw/STQxeckWfWwM13vKP6t1wbFtHYIIY3eF9Pk+D3Kh8hP?=
 =?us-ascii?Q?ihalfshDFuF072k4Y000heKlB0T89xXv1k+t9AsfCW7KlXX7K7P7nRgZYw9r?=
 =?us-ascii?Q?Dt6i05IbVL3Jf5CbBsFZyWOwQzjGumRU2v7ZN2ABK67ezhPWAPF3CMbt9uhh?=
 =?us-ascii?Q?bjcxVOCPgNpl0DUbhFVRO9zdz+Kpu5rmo51+Yu6zBxOUjjin4U4C4iHwwJ5b?=
 =?us-ascii?Q?Y8/ysA//NyAmTlxkH0d5GUg2q5nXdW51rtNNQeZj1y0LaZ0LTIYt5ajcLvjI?=
 =?us-ascii?Q?WasRtFho8iCxPShFoH/k1vNsGnprMKMFDhdAGZyYVZAKgoXh0fY0VaphfpOU?=
 =?us-ascii?Q?4OwNE0DzKW7qYKRiuGQNCyy2VpIE1ktxtEnaaFB2vjJAuuTIUSUclPQ5h1Jt?=
 =?us-ascii?Q?alXvI8h7OawvxPVAjEMYjVVCYaqQ0wC8RDsWDNLxIvdaykUJ34QnDBKYF5cp?=
 =?us-ascii?Q?56tmB/yB1IjKBqaHa+kdlGkDEpFh7dXYoU5AURqlTX0FWC4UMrndui3xK0Zc?=
 =?us-ascii?Q?8j7vCKfhq3K4LfbMyzlYnBJWA2AGd09btVXTx+su4Xne3jakjYk1x7Iwpa7B?=
 =?us-ascii?Q?S4Fz5cQVbXcMV1qz83kIoDYkHrbwmjziDDxrlsMC71r7H8SE5HALiYkKCLZM?=
 =?us-ascii?Q?psRHNPW7HHg4aeqTsAD2mTACtPyEMUl4M82F3EqJu89g1ExlZsslCovaaAIs?=
 =?us-ascii?Q?JB9JPxbdW3r6cQD/EKsNi2I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f6b6da-dcb0-4276-dc89-08db7e6c6819
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 22:00:32.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2IUu/xCGSGfPKLAOii8/+PgJtuChonC+ADy6ZXv8AYzIFnkunxy0hMlbosyzFDE/8w3Pyu+hCcR/WQkc8jnY5O55Y0UM2FK+G7euuOAoh6F9XqPfV2NH3Ak0qWMSC/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D Scott Phillips <scott@os.amperecomputing.com> writes:

> Interrupts are blocked in SDEI context, per the SDEI spec: "The client
> interrupts cannot preempt the event handler." If we crashed in the SDEI
> handler-running context (as with ACPI's AGDI) then we need to clean up the
> SDEI state before proceeding to the crash kernel so that the crash kernel
> can have working interrupts.
>
> Track the active SDEI handler per-cpu so that we can COMPLETE_AND_RESUME
> the handler, discarding the interrupted context.
>
> Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry code and CPU masking")
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> Cc: stable@vger.kernel.org
> ---
>  Changes since v5:
>  - move sdei_handler_abort() to drivers/firmware/arm_sdei.c so that header
>    changes don't break x86.
>  v5 Link: https://lore.kernel.org/linux-arm-kernel/20230626074748.2785-1-scott@os.amperecomputing.com/

Hi James, sorry for the thrash on this, mea culpa. Would you mind taking
another look at the patch with the code moved around to fix my build
breakage?
