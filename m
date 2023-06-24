Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DEC73CBAF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjFXPsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjFXPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:48:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2092.outbound.protection.outlook.com [40.107.94.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B4B0;
        Sat, 24 Jun 2023 08:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqR7ZQ63xiMCot8yODB/S88TyQ0u4qUcys0/ckPmipP6SunyF/BWkDy7N0Xz6Af2/6t/KH5/nkJ+cHf+D+j5zeAGXmndZiBVujQLk7if85fufGJUTUfRTsyewAqkASaDR2VEWX5SvEYWhYseJtYpqKH85QCHQ7C2qSzguxvarMAlGUPN+vMeSO/R6KEDFO2xmzA/F/B6MSFUDv7iTTiD8jHx63U90+mxjrRnIvwXa9PNEvF1nQy087AtnalM8gI23CdC3IFTSw0kLkuk/Tj4ZGf9X+DrFRejoTL99ltRC8IX2zFLZqnQB6FtN9PIt/88lFwD7bEqrulluMR1ftJIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l11Da1uZTOX3jn141X7Dg74px+ORSw4UaE+XmbfSIYw=;
 b=ItMXmikCluHFLCBSoLJkIDKNBaJV23WFyXs8SaABLcKnPIxhqbOFS6rNRc5y8XBlW/Ypo5WXkxu4SBuXtHmZ365YY4RPGvcoM8FMLo2kHIxQYIu9Ga0Ips1Hf85RIaqeLgjf183aNQDNhTTUkJ/h8TeB8gNJNeiOMiTho8oDTFXIy9OM2rqFw8Hcy8T09Btnt/6K/49msP2jMT4Uf1rAHFXqNcYUCDMiEQPEVn+ubRjQcaXqhPe7HHkgWMPqJkNbDaAEDNmzmMX7/aAOjttdsDg6GP5EXMRIwCANU6TuvqqLtbyCWTKI/GaYK/a6XiV63nZEbUbS9+5hMxGHIDbZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l11Da1uZTOX3jn141X7Dg74px+ORSw4UaE+XmbfSIYw=;
 b=h9W1laU+V/chyZVdW8rXZGL1hcXnmfistKrjDo8t9t4ykp2Lw5M0DfPerowWnaDyWRyKLrYgB4DXA5VnVImPrc6CDy18SU4toXGysn3zraOoXkpjolwGAiu6wzdq4A0+AT8sBWXzXKv1OAmezHHp+mfjiUC2VYGmdFW5wGwGybQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4895.namprd13.prod.outlook.com (2603:10b6:806:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 15:48:00 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sat, 24 Jun 2023
 15:48:00 +0000
Date:   Sat, 24 Jun 2023 17:47:54 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Shannon Nelson <shannon.nelson@amd.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/26] ionic: use array_size
Message-ID: <ZJcQKl5Jccz14UCh@corigine.com>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-12-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623211457.102544-12-Julia.Lawall@inria.fr>
X-ClientProxiedBy: AS4P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: c2773497-3f98-4243-9e46-08db74ca6377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFFU+PQdb0O1aEVPw0Fw/tPm/b3nnY0hoH2vN4hI/50gU5zmYQuGPuGLQM6BoRjNh1Cx5M7rr/3R50OiNwdCD/tkGiyR52gwkmeS2iH8en05P01eTC/GEzDL1f/lX8lSxMzT0iLis9X6KymBV5W7dwrceDBz5FRrJ/IgIsVHv9hvrn9lszYKcK3nT8/Opt3Y+qypSiRx0NfjaF/fSc26haiRdK7LZXorOu164SxLQsmOL+aJt+TXGe1KbkzU6Iwh/k3YiR4YOqdjs5oEMx+Mw0x2wMMSrok4OWirO1k99w5f78/xKCH17W+N9lWxSN4WeGInNNSCz0mxHOAyIv8vmmqO5eZETrlzn3BYtIDXLZf8VpeKRFRt1NszEaMoDeXuXV1PqK3WM+katnBHK9B4aEXwFOxOoY9SO/5B6JtMMdgVnbHehaUB0Rmx1idFPMZ+2xO/GRoOVnM3JHarhna+lD1PlKbfEnnHYNiAXhlxrMdLS4bTHU4CZ/wZMi3dMbO3P2krEMi8GzqOc9qwcM6/mafuER9Ip7U3jhfo7F/KA0VO96nWW3xKqM+1+s7lyZBpDLK9hT67v5XgvmjWOEp56HJtKS14UBSnfhn38MWOrVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39830400003)(136003)(451199021)(36756003)(5660300002)(44832011)(7416002)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(6486002)(6512007)(6506007)(4744005)(2906002)(186003)(478600001)(54906003)(6666004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h6eeFWgcSxr3Q2YXtxpEor49G3gwSAxkSEcEdbILcR6R5rfvqDLPGZrr+2Bm?=
 =?us-ascii?Q?qn1Xfx+IyimedOeI8NdYeyF3ZBNGKcdn3S0TOyndMWh1PAhJ54D9bbfjoZsE?=
 =?us-ascii?Q?RRdDo8YboT/vYdRRWSNfhU49ROlMQozDtjPgWpy74w4RAqIDrv3Fa7yB+dl2?=
 =?us-ascii?Q?OqoVtDnc05hlEI9bsuey6LEXfbt9kPea8hW0ZmsTSVTe9ZQssYntHDhtOQAy?=
 =?us-ascii?Q?RYHN/VdBeY+MguH0XhoagOTw9pOnb77sXHRQ3SnuIisVqB+p3nPhgBMrkOr+?=
 =?us-ascii?Q?/ZcjyIaCEtTukvLc7XClq/kHBZvj6OeDxjL2dt+AKBZEf+FB6IEOlLGxVPMb?=
 =?us-ascii?Q?utxlRfmwPDr4OgvYG/+Sf/nxOAXsNlLmhWPyF2yiEzbktdMu5dI6EENhSONI?=
 =?us-ascii?Q?VGsBH5llVxjm38Xfxv9akrYWvwyU8phW4zYojELN0CeT57img8K05dK4WzHg?=
 =?us-ascii?Q?2P8NPM7/Zqjy3OlNrVMlmGvo/qnsohVo/nFkOgW+HrsAIiIWHHvwFd3jVmV8?=
 =?us-ascii?Q?5aehGFIl5Pwj+wjMMtrVFXlAX8b18nMGyGdFwQhHrDI3/iv15C7L5s/7T/by?=
 =?us-ascii?Q?RrdG/F0d7WPawDissHblcr/WMXAKjptbf+PdGTEzGe3RP3dGMFT+ZCARUXQd?=
 =?us-ascii?Q?+QKLI5HHuuTXHHodBr8O2TKpo9alyS9Mi7nnL/q4vj8lp4hT0O3ibUZdOPFT?=
 =?us-ascii?Q?6D+M8JCQFUWiDFipbuczPed5AMlCe4phJhERSa5IqvbX2EH3aO+wDrKul6+g?=
 =?us-ascii?Q?jx9/U8AF+8NlS1cDw9qiiEEzWc8+jd1c9NF/3vCpEyZBZXLXyaetlBSXRaRO?=
 =?us-ascii?Q?xCSn9RBgLD5uhJOXkTew6kADhh+k4HLo+hTqq17uodR7dKoO+TjpmI/p2q88?=
 =?us-ascii?Q?44end9Xcr6o/m4+JjbiUstqbyBqJ8WmFzW7MKIv/SnTC9/mVrScf/gHjJ86I?=
 =?us-ascii?Q?o2CZmt+TboFU31s3qc93O8qBbGJZtYvwR70wtYq1WeXa8ttzQr5iW1UhoaOn?=
 =?us-ascii?Q?ugrsa3bhGPan+01cz1BWZOvpoKAHGZ7VrGSTrfAgBxL/v0OPPKm2YnJIbUwv?=
 =?us-ascii?Q?y5fHCdI0Zo4A80oOqif4do1TZUKI1PUkNk5YtL3XaOcpm/pLYKGhWLaOOnPD?=
 =?us-ascii?Q?ZZ7iVcYYh0WXoM/qZ5kO9Xpm8CCZp+sgmkEFnyY6T2GOGr82liZWii+ayrBe?=
 =?us-ascii?Q?8sd3hNoKhmFM1Lm0kf3EdebCbSv2/AHNHii0NKRg5D6BU1qDWuUmSviocEEF?=
 =?us-ascii?Q?6vXNvM8sB2cjdlG4MQMYFWGJvUuk0yXGYvljJPmQ7A0j6VBdLGWge01tZHoC?=
 =?us-ascii?Q?Bm44FvSSeESThzykOU1dmvIKfZfVmoJim+ecKE3bgrmg4Z/eXS8LLkIbRnai?=
 =?us-ascii?Q?P5nGFFpbvW9A/YFySn+/kOOT/OgpA55R1MnrseaA4Iwv6tftC9lWhpg0EuXx?=
 =?us-ascii?Q?qGfP+3Wh3LOG+li3AmjRFqw//WXYm1ExBbtc6s1VROacTRBUobqhwrfYwCZW?=
 =?us-ascii?Q?s5Ezewx6v8K+V3giZrxgoUXub1iY9SoP7rbZGbSphRMLKk1ZdP218haxOtwC?=
 =?us-ascii?Q?bqYq4m1f5NIEzJKrzSwyJyd5CB6kJ9rxr3tShPQnPLnEUg95OnHZzR2hfrrQ?=
 =?us-ascii?Q?cI5GwmABD/uwdqM3Z7R0fX0IoXSBEFzE//FhhtZ1kCCgySlIz0S+g8csW9uy?=
 =?us-ascii?Q?CuKbUQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2773497-3f98-4243-9e46-08db74ca6377
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 15:48:00.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eBGhV8Q7nFO4+UhRCUIHWQKlMxci5/IZ27+/0su4DxbrHvFxH9w8fVnYM0VTkSSs0Eq0bjO0wqVaKPsbAqv3kAXKUb/Th/shBTpO1wMK5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4895
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:14:42PM +0200, Julia Lawall wrote:
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

