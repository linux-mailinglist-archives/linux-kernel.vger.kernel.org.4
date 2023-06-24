Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD61973CBB0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjFXPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjFXPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:48:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2096.outbound.protection.outlook.com [40.107.244.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8626B5;
        Sat, 24 Jun 2023 08:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpHW8J0FODl10Me9COUsAKEGu/qPJx7IbIwqYhmNh83DklO3KhA4ZtQ5fjo3ibUCja3YBOKPUL7HuWoLEg6mz7QrQG4UXnuo48XGim64L0xX0GP9juYOc8mPsLTWWxaophxGbE1jatPbopFsuLGxbId1WxnTc7sqh7fR7JtSZsMMZwHUufeTMQUSMgD5/r3KEhx/xtq9DD3TLYN7da4cPBIg9ztQTylvDHEVM8ifGkFC5iGTTDL0IRvxk+6fqmeU/net65HwQIoK3tUU51b9RrvgxLxAIcAfZdSA1IqEPGzgJnvm+RLJVbkm9/yE3uxZbm7+o+r9QZ2Lh7v5G/8gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrzoa8Po3fOdarDAV9jXDDmmZA9l98WO5Dx18koznpU=;
 b=holw/jsOydNBjBM1Ul3rhkUYp6zKpDLJK6tOtarHwimWT84mGqQkpFxub/KIsN/i3sgairWccVPspz+OhFfUSLEzwclGkl4MR1FPPF9nDQLw1UR3bVu1XEina1jV/K9A56J/eq4vaMUPxoj+dogVB5UoLf8OBleYWJ43vNLoRHsLlgMXlnj3I8FOu5Xkpt4fvK8P5JM0umtjRVgzNuguzHnoONoVZvidCBihbI0zR39OVq83zGOhch+ShVU0NgnrLYRiBWxv3Ud2NoOAsyfqNLZm0g6SF/cihnlQUUFNLFF+A8xY/uviG9GHRhJsnEQSWfuljYsJNo1qhkBblzDFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrzoa8Po3fOdarDAV9jXDDmmZA9l98WO5Dx18koznpU=;
 b=NIuATxFWWhunwS6EyKip4q26EULXuF7wYl0bMgFxOMbeNHFxf8KPKxgt3NA9+310rqZe8u5ah52sTDYIAdDqA6b82rCQcG+qKIXPr+hOrbEyKNrp2P2ec/byo2sV8rPm5aKv6eb5i5O1gtz7ZsxkiBoB7Ilsv9IomUfSVxHYSws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4895.namprd13.prod.outlook.com (2603:10b6:806:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 15:48:23 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sat, 24 Jun 2023
 15:48:23 +0000
Date:   Sat, 24 Jun 2023 17:48:17 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Claudiu Manoil <claudiu.manoil@nxp.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/26] net: enetc: use array_size
Message-ID: <ZJcQQU9/9fGJWmwT@corigine.com>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-19-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623211457.102544-19-Julia.Lawall@inria.fr>
X-ClientProxiedBy: AM0PR03CA0094.eurprd03.prod.outlook.com
 (2603:10a6:208:69::35) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b65993-30b0-4f97-dd68-08db74ca714d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLWcfHh6vVMtZVeIMTNPb1KWCrQCMP66Q2ZRnOy0mbww4kcPN7/hcMRjMy+KC4XIcgU4Ir82INEcEQ3fppn2TNALldzt7rT4sULsPdpjSHQJfQBwEM1jbrAfpQ6mvXMAVEULvrz4wMfhLzVYFegoeUOlk6vljqqzw6wXQQod5HvLayGpOf4VkWdZWQ8osG8PuNbGBXlzMGq8vqiAffP5BrGQ/qbT0K7GMV/vhxeWmq98RRbyyQstx32ieHp1e+HGzqLqkn0ciHmjqHKnitLpSpErqcaO3+8MaY7jfPtLmUyvAuupLLE+a+Ytezy8ACVeMkrTfvIW7xom/VQr1f3ZbIop8bmUHwsFnD+d9vEM83aSJGesiny726HPxb9kocWybCKCzKQZalwOAdjtCu+bxWLm7s1Q8wPedi49dTQ9aiFy3KhQHKrzXUPAKedJLjnBN0vHh9TGzLbUFk3ak4nsecb3Oqw87EyZyyfALtiQjms2k5YmSiBrtO/097kdFBSJuvWLewM/UOeacx1XVgOTWHqvxpn45OkAPU2tMF5oLO4Rfi0tMw7IDOcHsXGYnwR3mheiurKq5S4ado+zTJhSPDAshpYscSLojPxjYjY5YwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39830400003)(136003)(451199021)(36756003)(5660300002)(44832011)(7416002)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(6486002)(6512007)(6506007)(4744005)(2906002)(186003)(478600001)(54906003)(6666004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NV/ft4vVPmPhCgs1ui/gfFjMKWwyM9ahbixEQLEuCMpTV7oCWfbuTi4n5Me4?=
 =?us-ascii?Q?DLGC5J1MGq7nauqKwhURUXLHmrfGl2f/YNcu18yBzQYpOYDMc3makHhjI7iq?=
 =?us-ascii?Q?oAP+f0czYY5KoQEanM1ybz6fJT39DZb5n8NMeiNrsZZCducAlyB6ikY2l9dV?=
 =?us-ascii?Q?i5s+f6c4Y151UfVaQz/N8tTXiV8kaf4/Oikdf8gmRUz0MdKf32hNu07zaPHb?=
 =?us-ascii?Q?j5IRCsy4l0efVM8nT4nMCv6cwCi9Tx3aAj0tw97Gq9OLwImpX2I9DwpULiN6?=
 =?us-ascii?Q?Wb/h4l3fuEnpV6i0j1aei23F7kJPpeRbX0U71rNVv9rYXqo8YCOMTspUe7o/?=
 =?us-ascii?Q?60RqQgEKZy95i0j1PRv+FhGKSSCNl6fscZ3Jg1nNFqZtZQMHPSFpVBkvcV4Z?=
 =?us-ascii?Q?eTHClX/pJQxbiL8YTNY9Rk2FhxJUR3AEBRN4pGicVEhpobw4VbBnnvZNMNeE?=
 =?us-ascii?Q?27Nq7U5NZMxdzES7U3HTfSc6YE5oPSczjnxo9lrEnF1fYGbIxrKuEYxpVY+R?=
 =?us-ascii?Q?yJaYEjAMoUR0n3EtW6x0VnnMM2aVjkRdR+iFb1iUgVttx7PcHbbzGIXyzxdX?=
 =?us-ascii?Q?3qgTwR2AjEfJwo/ZwyZ8Z6gw0/QIkUUFSfPVGHDUg394ckQWRjEVpVzifWsf?=
 =?us-ascii?Q?N+bRlF1+bJH6vZ4EHcNMBOJun0xAGMrW5eq2fX6RVBWblFW0mpraM9RrDfte?=
 =?us-ascii?Q?92n/01VPUccPeX/0VaCl3Z6zPoLM1lOwsCgVe7MmHbvgizURAUcRFMP8JAPx?=
 =?us-ascii?Q?tGP0oAmgBcZzJxLbyk15RiYO9ECpSViSDmBD6FGEjAtmqTtVNT2aQNoB0jK/?=
 =?us-ascii?Q?sfOFPDbDHxmRAxyyopq8mrEUKDdpQFrIM8S1LmDOL6Osjz0ZtZR34e2mFdrI?=
 =?us-ascii?Q?MZLLy5VA14+4Ki74XqLDBvfdMO1xNqnfYoQTjYerpNwXddcYgAbMzJGAcAAf?=
 =?us-ascii?Q?1sj8yqEauwQawwuYZFvLePxDNexoW4Y+afKSH+5/bri29egSt3dewO05iBh4?=
 =?us-ascii?Q?DhJwMBVM/SEzyxx3MI34gSx/slquDTw/Q0sogjiLL1qS17JIXTiDftal/OZL?=
 =?us-ascii?Q?jjaRSU7K4pnBEHepWrqmriGsJOr8XXu0vqpz6cdmdA4sEuO2r9TBB/cb0yhF?=
 =?us-ascii?Q?ZsWI8IU1JWK7kbGN2SDvJR4deAEZyGzH/fz+Y/bi4TpfPqoROvmHbttaphFX?=
 =?us-ascii?Q?cOuzCbbhPv473OOcDIhcOai5Fbvu8oVLihSQoILWM8aLkBa6q6MWWYCWnSPK?=
 =?us-ascii?Q?mw9Pu4obGvnRz7pCAe/390tbfoIQEutGF3/zsut3pWO0Ny59WtjN3yF/Cac1?=
 =?us-ascii?Q?umJWszJWMQMxUbZYxscONdeIkzwZVUM8q3X4IC2vGqXL6uLK4zk1zEfnS+pv?=
 =?us-ascii?Q?3Kv8xT09c09HmVh2tHYscIeXjb3Vdy3L+uUNcEkRDxTqWpZPreSmxLRumLip?=
 =?us-ascii?Q?mLkSBp8htvIeZ6OdN5hA0nDMTHR+sU8YQJXMCtl8ptmk0BLRwx+wrJyO5jzR?=
 =?us-ascii?Q?51W7r+FLSrSkuNR0BSaZbj8ydzR+apDAxtazh17Q09umEr+O3bDqGNOi0Q/0?=
 =?us-ascii?Q?qdAhYFl2sTFWq4tZ46xdy0S9R75zXzs0QYaY7FkmzRKxMuK21rZJvLz0fcvF?=
 =?us-ascii?Q?d3Ln0EKaniEg/BWFa36EY+nO28NwwgXX52nKvewk4O+JB8F00Mp840Va7j5k?=
 =?us-ascii?Q?qhOIiQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b65993-30b0-4f97-dd68-08db74ca714d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 15:48:23.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zuzg93Aldh0az2qv9vZLMTOu7zjEUnEAyqxoA1ztSNogfRq3M5vu9hCzFIvC2YCY1nBnCO9sOdd067kPUKTdatpKes8L6ALQ9brmPK54VLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4895
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:14:49PM +0200, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>     
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

