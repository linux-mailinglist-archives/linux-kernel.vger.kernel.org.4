Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D383743106
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF2XXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:23:23 -0400
Received: from mail-os0jpn01on2129.outbound.protection.outlook.com ([40.107.113.129]:10045
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231177AbjF2XXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:23:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww1SaqG0Tq8K7Ezm0QOaokpHO3/Dm/rK6FIfsnW3Ko+Dvi43n+BP60Rq6/2jk+k8JEz/m6x6GNDu39j9l5FqePd/SNec1zYge4/zZKVmjueNsUBt+GcmzQbOo1SuR1dkcwC13oJKZabMnlciiQ3w59ZX8nUOIAXlNO6MBIgvl09+cP0BIWqPZmmWUPfImZntqGsYNu4glRVJYyk+1Vs8WGMtJl0bqOp9E4Mv/V68oCCk8w1UIc37aAB9G14EgPmRnzzTfw+9B7KceP6uubzkcIJeX8+HZ2Lb6GMI7d333j3AdUR6cJlN17+4girQcyHCFQDvOPoSIQdCNV/IpZpafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mUuRlFeocf5G48icTDk9vu7Fkb8qTu9FnuUFqfz1so=;
 b=OxGFzI+5NmQ3DRZUp07liSM/OrF/R5yhXAQ4nzjRepqwfoRjwazRX8lyX+zpHJfA1PAfQ/xiApk+/YjYeRldxh7CyXt4ffSK83xQ0UJQ82+k/S1yXbWf6+5gEuLQn9AcEl5KmtPEC1eTrNFDcK14LpVZuJ/GjH1V3GROIWfaQo8bGo/NV3uN4gobswnr6O/ZvoizJPh9dnykyfTIMB79OsZqk75cYip0TxLY47sBlgFtOIDKVYZ9Ve8fQdo+7VEEqH7GAsd+lhuQ7XRaUScjmoiHXjuPdb1Tve3qzJ4mFtd4zNug4Xbu12CO0QhgFgMAuCIgKO4dP7Dxm+4o2eqO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mUuRlFeocf5G48icTDk9vu7Fkb8qTu9FnuUFqfz1so=;
 b=YCyU7bW6wQrxHNxzdEyvXGN9ne7Adn9bk3/itde1LViwIQQJUCMW8KEWXC5pMIW0h1ZVK/IG1Q6PX6Wz9zWCbOQayhWvh931vIohexoGNRUZ8lT9I8gj7+M06BLdLqhsy8hMRoLHBtkLRFKjjqbKVt+HboJYBqh6+3Ox6s/J1a0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by OS3PR01MB8603.jpnprd01.prod.outlook.com (2603:1096:604:19b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 23:23:15 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::3ac7:b366:51f:3e26]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::3ac7:b366:51f:3e26%6]) with mapi id 15.20.6544.019; Thu, 29 Jun 2023
 23:23:15 +0000
Date:   Fri, 30 Jun 2023 08:23:06 +0900
Message-ID: <87a5whkg4l.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: core: Always store of_node when getting DAI link component
In-Reply-To: <1d74d2ed-0c4d-4fce-849d-5f2288394569@sirena.org.uk>
References: <1d74d2ed-0c4d-4fce-849d-5f2288394569@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: TY2PR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:404:f6::36) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|OS3PR01MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: f413f472-c38b-4588-8a57-08db78f7d049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UO4SYnDa6LBjlSyv+SE0jUoYs0nN5O1IcB9W6yCyeSPnjVJiKVT512c7lRs8a9tRbmZn4htLvMtXhmHTOSUPASyYWpnNLeWrIC5KMbJTltbDbC+Fi/rZtBvzrO4/d0boUZF8PzNf1+YZFYak5ia9rdPZoNlMati8yFZmP0QZ91BqSVg6wYJ4GfHxafm/pzyAnYr8P8ktywL+FSMcrmApss0CxJltQAIJeM2EVsZjdhbUU0QS/z1MmMTqW3yvPVLfXvWD8nrLEMGqCcKyYyYdfQPVjYwgTL6FnckP41ysG54FcVDcVs7ni5pdKOI81YMtc7UhYowAK2hhPzqeywoPqFFOO6je890QnSznpsglOFFPKbtjeQxCmEjO1AhzVS6BGlMSpZmCUSW9CD1t6IF4cZsc5errnXr2s6deo+WxfTGso9ox6eRoQmlQ6XhrsP/Me+SDDaVgDU4z1EP5BBehIhyXqeZOIDYM+0/uFqQqp7SwLmYwPprCwUZsxPLgG3kZ5NIq8eF6EXcOoMLcJuiaOzw4Pdy/2VT6JzocivBWgVkifOVVukn4FN0vcRg8pMungIpFM7yw6/hJftcI9i8ZXmlevD64P433KgRbkCrcSJEsFPjScRAHlvIycDR762Br
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(8936002)(8676002)(5660300002)(26005)(6506007)(6486002)(52116002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(66899021)(186003)(2616005)(2906002)(4744005)(83380400001)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vv/Ixyt+Y52uLzWPRnUOTrub1riD3AnsXR29nzqJuxdaI7EU92ZWzhQTaGpx?=
 =?us-ascii?Q?nP1ulLrjmr9d119ixGGNLb4YZVTGbjBk8PBW2dZZHe4tubtnAxdinJp+gDES?=
 =?us-ascii?Q?mjpJzbOTye6N0wNNyzhSwe+rfpxFupRw9xAvTdkA/cfe7kKciz1Mv2bka4vt?=
 =?us-ascii?Q?mu/4excR9YtQi0ipso1d78gdQgGYQsQwgAoB+IAegCovteR7mr3+0pltrRO0?=
 =?us-ascii?Q?obKq4XblG4vl7Od6/7RP1hNMpj/XldPkpWfCQjNkQlhG5tD+Vz1JWtnxGPdb?=
 =?us-ascii?Q?+/rVDac61KKXtSkTOTccZrAQkBg85YMv63CoAZsgCNd1t/CZ110AhBT0SB6q?=
 =?us-ascii?Q?r2kEXAnkXNJaY4ngozIq+Yurwk9Ds8QHrhqtsPkbEO+vp+yAYENBpBNPw0nK?=
 =?us-ascii?Q?JVpbCmPbYt0MRuNpsJptyXHOAH6RzEGrJhODCsp0j63gyqjKcSpmoqVq6gYQ?=
 =?us-ascii?Q?6PEkGKmFYzPZPoAx2GyNqpJbWbKWfLGU0nvpt+ZUGpruMsajKgxaXmHV8E30?=
 =?us-ascii?Q?rT/J4mqg2oUwBwB9kDNEbmL1jIrrtlMUbkF0r9w4EqWVfkquRyQcg1H/MpkD?=
 =?us-ascii?Q?zMq4pxg59lxBKYe3p5vnPPyCdsr2K9eyz4dcZz4TKJ/C5vBHHvpNJ//Drqil?=
 =?us-ascii?Q?8gXwgT/7VQmlbS7zZ7nYNX2s6JaSSIriB8+1T15PSaLWDbvNlQPWEb75IKgM?=
 =?us-ascii?Q?gCGLnbHf4lRqcELUqgQZyvWMUOH9ugI5ICJqW9VIdSYYB0Heq6x21xoDJble?=
 =?us-ascii?Q?jieLeicHGr/Wx4DxIkfKpI/V9HARD0ZhTy91MuvT1IyaGp1Pd4gnpmHrg1YZ?=
 =?us-ascii?Q?1hXdSAd/lDwOAnVEtqXm0Latlpec/ElnUKt9gscLZSMFc9KYlo3dT7A6NjHl?=
 =?us-ascii?Q?ceY+/D27jxAp428/x0MEKPUR99CMdnBJyftRlszReOu2lcyyL6oupJ3jiWt+?=
 =?us-ascii?Q?+S9miBIZq0vgsJM4MbEfODh4g0XxfMmdSlVhlgbKe2TGN3HYORjQJFv9F5jJ?=
 =?us-ascii?Q?dC39NP2PYxAQdHcXI0kDrMnOsM4/TO5NlGsIn7rrzcotIFxfRfpW+4e0ImrL?=
 =?us-ascii?Q?kF2MKWRhDy8inJryGz+C+sPABAeYkfJPU9c7JgEcpNpG2AROLD9abu6+NEgY?=
 =?us-ascii?Q?9zgr/s+Mhuv5DYgfYEZVs5I8QcTO8E95tLmr1OQ3mr57qw8uXs0Qvsfc60Ta?=
 =?us-ascii?Q?12KnpiCr239fpCXtqCQrup3O+LixjkcvKJbhTB3ww1CWOjuP0I1qixSTRH0o?=
 =?us-ascii?Q?6ZBj8Be5r+aP1H9t+fTGv67Osa/oPV2D09243UrCWPePFolPsoQ/XTKBq8tP?=
 =?us-ascii?Q?tH+8h6cKbtx1NTqLNvVzboGNyl9tTgw5e5c3kgInIC7mmzAQjv1QLRAJjEHR?=
 =?us-ascii?Q?Fvpz7A9oPiFWYzK8nEqlwoFS/k3dM6m+woMmXuKvtQiDgJns88/1coCakNNV?=
 =?us-ascii?Q?T159izjApy21R78P9awno0+GcOwJfDIFfhuru/Rq6CSRHB52bOLWFSPQbE20?=
 =?us-ascii?Q?PMP0/fopEQ/x+SSxVMACgS1cTHOiKVp9felYzKHxxEHJNj5+wSZNio9L83Rp?=
 =?us-ascii?Q?ORRX/f3NpiE1NiuJ6fIsKswCtzyuGaS7CCmBSYO4YAdGUJZ5/E0StsfT4tCX?=
 =?us-ascii?Q?+opH3d5o493PQn6FJkEqgwY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f413f472-c38b-4588-8a57-08db78f7d049
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:23:15.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bRFQpYgFaGRHld4JaI3Ll69HSr1WqzvqwLgosesoUpcPiUGN5SCRXcE3QnuEpT7oxjv7uTHxRhG1g11EKHWO9XY4ni1YxKRG9M4zEtFYtAvs3R4YvqHrJiKpoZSZMt3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8603
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark

Thank you for the mail

> > > But I think we want to set it under lock and if ret was no error case ?
> > 
> > It doesn't really matter - there's only one possible result, and nothing
> > should be looking at the dlc unless we return success, but yes that'd
> > probably be a little cleaner providing we don't ever return early.
> 
> BTW that's not to say don't submit this as a patch, just that it doesn't
> need to get applied as a fix.

Thanks. I thought it is not a big deal.
But yes, will post a patch.


Thank you for your help !!

Best regards
---
Kuninori Morimoto
