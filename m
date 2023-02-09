Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4F6914D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBIXn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBIXnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:43:45 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A3B1DB86;
        Thu,  9 Feb 2023 15:43:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJeHyra9lYcfEFoRHVtVDeii5DhUabFo2P59zpJkU5h/x6NAMr1g/9Z5bVm99HKArngeNjN7teKa3uNKK7Lp5wSEAdAflom04ndYlwc/PRct7mBgdHkUbXbCkjcbK9KIryliulAba7lTYCpk4lwPDe1tUNeUoddXCzRPP/LhFWX/WUY8VvxAzFhmSi/iDXaKsYZYpuBvP5P6CCAd9OksyKI6gSEG2+exezYfcVYtd8gb0oO1Z7PgYqGHm500fm1fTcseinWDZ7HHCVO9G59iwUSmwKlOdX6p9X/UAQ/7bidEHnQqQMUp/aFmxwS7u8T1RbnvE7b7fCIgzYk7x+qDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TYrGejPWABBHH+WJop3K0UUYDXDF91uLLGiZBdn+Qw=;
 b=ApQ+Bz4BZnwwDNKdgcVK9m0oTU/NqdECfRNH20cz1YJ2vUMFnvNAfwVVrHZgQdq74jQZzBF0NDeLKceJJHeVFMI6MyLkyPg/lw5Sn1Nsxa9kjBxcMb0YhFRCf1LUr8A8/0cNl3wZKDNv+TOASkn8Ad94EtcHXkSLZhZMintMCocoIPuBpdZdVRvJYhxMoT6uALc6uyvy505GezAVr1eu+NEU1XFvYCFSMVISNyNEDSsxJYnXZgtl6r71UNupJQJy8cIJ0+1BtDcp5tkxuZZ9539m6uhIdvMFsb82j0RNVTLJ67evLaPQVOgPUacZQy9QwNKmTyAyG9jF0Xzv5BurRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TYrGejPWABBHH+WJop3K0UUYDXDF91uLLGiZBdn+Qw=;
 b=Mg7IY9L2LNFOrk/oczrscA6IzkZUBm53RfKkWqxCXpBLRvHVEqWWQ8vA+45X07ksuiU/A8gQVkRm7ca9d5lR/+EmUne2FMUb5LhIxWNkmNwUupVL27YMtxKfloxol8OD2NCSyGlzrE7sjNNm3kS6evxMFw8TGRPawsIsQ1MXj3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by OS3PR01MB8350.jpnprd01.prod.outlook.com (2603:1096:604:191::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 23:42:59 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::4b75:8d8e:d89a:7860]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::4b75:8d8e:d89a:7860%9]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 23:42:59 +0000
Message-ID: <87lel61k3h.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <oder_chiou@realtek.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/2] ASoC: rt5640: Update MCLK rate in set_sysclk()
In-Reply-To: <1675953417-8686-2-git-send-email-spujar@nvidia.com>
References: <1675953417-8686-1-git-send-email-spujar@nvidia.com>
        <1675953417-8686-2-git-send-email-spujar@nvidia.com>
User-Agent: Wanderlust/2.15.9 Emacs/26.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Thu, 9 Feb 2023 23:42:59 +0000
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|OS3PR01MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 039dd2f7-d5fd-44f2-305b-08db0af7608a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjUeJVkYf/ZGIjQqV7PlIPJwt0d7rhmtdoL3iXQuO6T7bwjnfMTZZR9m8PkgNcn72XE07O3uhkl43RViTY5KGsFCy7kfhwFjkIMEPGa2EbG1q2edmsGoj6z9WIo+cDoqqx/2L8JF8LGYD/trtwAbLhuFr3OFJfwzigjrwZN0tpQGdla0rQsrL6+0T98dBlDDso5p892mu6CoJmNRWKOvDcGlZ3yj4KxyG1s3ceIP7+nYC4ol/1iMoBNZKzwQ9jlXSnyuNbYPFohkCN4X/S+18svYX83NqEceF8xjB233LCU/i8RxV3Cr7j+/VjkQ8DbeAlLp+FGKKEZD5O2CgXcKctkmjyE1o5znG43oR+R4AY9fW+CExVOX4WfXFvHNJy/6J2y9SyZGWrcUkV3YqBucopOErBRplgWFqwPJLbAtc+D43Z/NLx7ltXhdQd8megl1YTA/b2jB+EhryA7bc4tpCFKBrdxWQXDA+Sx8kNqTCk1OaCiai2vDA1X24U5oiU+uknWL9i3saBg5bRvFVTeN18a3ycBvWYHq7hWyJUgCXkNv6hlJqC5eW5/9vvOY9pelSlPSxZU+TtE+YV/8mA9Nrht85oBRgFRPlzTcSVORvWkyvea1BpHCVjiPRK39qdViShflF9nzOFMuIVfcr5bq5/OYuLg5PRWGftPTNyjRiPgXURPcH1TF6HiJXw+2n9I8QzBHOGqikMXf+yzqxK69Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(66476007)(83380400001)(36756003)(4744005)(5660300002)(7416002)(2906002)(186003)(6506007)(6512007)(41300700001)(8936002)(66556008)(316002)(26005)(52116002)(478600001)(6486002)(86362001)(38350700002)(38100700002)(2616005)(6916009)(54906003)(66946007)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l+gB1mAxq645SEGxPG5wQ2TandOFel1KVS2sUWjC/31NxxnkSdzVx8hUOJ6H?=
 =?us-ascii?Q?o9H2c7Bi8beh0rsL3ayFWshx9RaKnHtWpMLi3ZXexQx9pAxCWi0Cbo685jJV?=
 =?us-ascii?Q?0XMpIEp9ac5djVdA45dV+qvmWSUlj30K+KlHJ5xaKYZH+wxHbT6ESY1re8Ii?=
 =?us-ascii?Q?mWa8VaRfdYVHM9d77+YaTBQEdL0uPPd9O5LwTFebKz3leB6waC7U67od9MQB?=
 =?us-ascii?Q?UzTxkXFwB7jxQJl5e/4b3A4+rbt6oggCAJgTPYG32PW7UWTG4z5ipuLXhmnu?=
 =?us-ascii?Q?9uq6NnBoisGtO9IzMQ+6bqX0p6r0pTGhf4XKgvQ75Gne5mpCL28LVXx6g2Ae?=
 =?us-ascii?Q?JaJ5HtMfMJEe9h7hPXvdXXlP2yUkGJLeySaMFRGotj5eV+esyLqX3WERfCa9?=
 =?us-ascii?Q?dfb3GLsYbMNfnhY6mUr4YjA+G+psz7lxMCyYFip8u1mWe/53FxtrucVVpqja?=
 =?us-ascii?Q?CM9k16jivepv0OU1F4RvGWf29QEPwSVTCq1fSXoQ10gpbRV4dC4HCYGn4j1b?=
 =?us-ascii?Q?kEc7/BhJlE3HhxsMKgHwQ/3DxLIeDNDIiTpwTqRLppYwQGSsEPqFWLLWyaI3?=
 =?us-ascii?Q?Yul7/hcFGwfTsSWAlzOWX9PA8+XyBIAC0HoV6/f82/kWfiY4XgrXHsMsS/Sr?=
 =?us-ascii?Q?FosBRlEf4NSvY16ghrZOm/i2tuD34ybXDWr5h+a4Gh9aya2qzSx1wWNVoVL5?=
 =?us-ascii?Q?ULxeahCSdCe/JLgjiSPCsyD6otRUqIor6RZGHGpLCMri7Y4gOwCohp2d0fLV?=
 =?us-ascii?Q?QmUmlZ+sIrT713lImnr1MxuRdOqB0lysohx1gUQpDdlIGF8HFBg1ptGX2L+U?=
 =?us-ascii?Q?+Tn3brV9XAafft8VadzydlJjTfqgLr2j50PDlH9kU7Q7kN3gD35xlBV8Azil?=
 =?us-ascii?Q?ra42cC3pplECZQNZ/37BxEf1B8guvasKMUFZRCsRWJMYYX9k0DrZyYqRqjUS?=
 =?us-ascii?Q?O76KMR1/ujOFcTfh7AM9vuC0hFBn1O8ZYMZkqunXwia926VVawliZ6/JyIVH?=
 =?us-ascii?Q?id/YMt82IN47YIBq5Wm0mhGSeWoLGVY3RgdMGAB+rubbpOtqyJNpFBefhFI3?=
 =?us-ascii?Q?5OJt3k9X/HL94pqf14HNAZMerfoTmiEllrzx8B8wCzdIxCPJ0BPKNgR+VRdm?=
 =?us-ascii?Q?j8hJzDm/jkZ0ElNPby/s0Q3aSR92fUdeQSI1oKLORt35S1L/dmBlFz/1nqsf?=
 =?us-ascii?Q?Zxf5Ntga/IOYuDbuGZ23x3AEj1chV1iAjgsRUw0otiyRKKKqj7yCgCkel/cc?=
 =?us-ascii?Q?YY5XsJRLqL3w+tPCZywh+yIe26GgXQQIqq9ztlKND0nL0NtnJ9yF9mV58vfL?=
 =?us-ascii?Q?ndd27yh8qypJ0PLgLuYsc7/mmoblir4ibKU7VWJgoeKQaUbQebT8+AYnif3E?=
 =?us-ascii?Q?AHXdTJsk8Y06YYPxBAC1GS8Am2pc47acQPtq8ex7FYqrjDjdHv0m8Se+ExeB?=
 =?us-ascii?Q?YLRTQHYB4oOkjS5YeqzjxLs/Lv1BGM4ZC5unQ3DBC5mS5h9yVTL4E9Tayz4r?=
 =?us-ascii?Q?ZsobdVzJprfDT4Xdmh1kGi+ylgs8HuE+Hd9+q22Z5wG4RNxom8tprKGGVmUA?=
 =?us-ascii?Q?rBvgBVeSJgrIpNnNFuN1MLyUmb/KbNBj+9Fi0p0DM5lJmId5bh9p+IgU1v+r?=
 =?us-ascii?Q?eka3UBJYq7zrx76x8gIbzOU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039dd2f7-d5fd-44f2-305b-08db0af7608a
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 23:42:59.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vR6wgFiW0CYxEnJ1qhXbBQ4Zy4sCFhEP9yBJV0LlcGKYARcLu5iZoh7ATauM/EDnkPVc5Y1sI7HyKErliPO3pPB8g3tBoEmi97fp3Az/tjRm0FJqoHe3Uc89EkqMIaGQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sameer

> Simple-card/audio-graph-card drivers do not handle MCLK clock when it
> is specified in the codec device node. The expectation here is that,
> the codec should actually own up the MCLK clock and do necessary setup
> in the driver.

I have no objection about this patch, but have interesting about this comment.

Simple-card/audio-graph-card both are using asoc_simple_hw_params,
and it calls clk_set_rate() for Codec/CPU if it has mclk.
But am I misunderstanding ?
If it was simple-card-utils side miss, I'm happy to fix it.

Thank you for your help !!

Best regards
---
Kuninori Morimoto
