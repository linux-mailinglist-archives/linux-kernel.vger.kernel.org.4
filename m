Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716BA73DF34
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjFZM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjFZM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:29:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2111.outbound.protection.outlook.com [40.107.237.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD6E74;
        Mon, 26 Jun 2023 05:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8Xpb28UZZsKDRP4iZCPgGAijADIV7BWOkfKeHZ36okHpsBcD6Yr+EGmqZJLQOlvBNzw3KybBy7sIQiRqPfUyEgefchkZ1DES0SW9060FfVGpYwen5ucbtGaGYGGO31oMHxF/uLTnppM5E81tgMzElg7eR5kVkXC+h8xl5lT+PG1ayBJhAOWQNCxgjzmYT9JU4CMDPZU+mEtdFzxU5jV7tiCAQ0egPT94dfz9WWAfCXdyg53X8TUWsoyqDRELRdJFQgRZZDD6V5/d4QyQRmtF/GgeHcmMw4e3LlZSk6dJ6QjvjgrZsk9384V0X4Ro7JI+U8bDauEiKnWn14ZbPa3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfs98W25P9e0AM+z/+jB0GJvVNgLfhFgFxfirOH9+/w=;
 b=YLDhbmD++XFBU4VsUfRiwhvf1gbxZYEJ9ZgmrzMSJZ30jGAQsKkKlzu5PW/2sgAYhciPIEcawELomtWHm6DIX+u+eH9MV8fp5tVNfyG9bij9E/AWDz6usxQS8S6WrPG5XRUZCsePk844Jfdyv/OJb6mWGqn8oI+GYdYzEnbw1WG/Bu+08jWwKTglFPnMC+Iwryey+xeGew4EaZw+K7RWCvj+WwZYTfeGD7cW8/UHiU8cbmkkGAPvFJrFbak2pObmpAi2RyL8mwUTKPAJJNxNNgFkYhJJNPJn6z7C1H7fc3j6uppv2JEB/DXlitCsJ90FLFexCFPtLiLPE2UvQ2RiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfs98W25P9e0AM+z/+jB0GJvVNgLfhFgFxfirOH9+/w=;
 b=q4e/slV0tAiniRd6WEnqrpbXn9Gq5tPFXVGSwN/14SQq3HxIk951ePimT5k3XmNVTsaVPMuVbYrverWqE7GKGKbejal63NW8x7HXwNO1bR6ChOhz+jVZH/cSZHaosEG9UL8jOa+Zt6W8UhHO7b3lQ+KaaxkdMCVF+YtiWE7MNcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB6153.namprd13.prod.outlook.com (2603:10b6:510:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 12:28:58 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:28:58 +0000
Date:   Mon, 26 Jun 2023 14:28:51 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     You Kangren <youkangren@vivo.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "open list:RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] wifi: ray_cs: Replace the ternary conditional operator
 with min()
Message-ID: <ZJmEg5Jw4e9KZVfA@corigine.com>
References: <20230626093504.1325-1-youkangren@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626093504.1325-1-youkangren@vivo.com>
X-ClientProxiedBy: AM0PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:208:154::37) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 8144cd94-786e-439e-e614-08db7640ea10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnbpmBCzng4DGK9DCrCkomsUsz0Iol1N8LXpEFNNoC8Rw8yzuMR5PIgw8W6B6Et832HdejN8vWOVfKL+JWINVNGg5KdhGt+X3C5dfdkyKlEK6Ty24wKgoqlyCCLMJMlNiclAC/atGxQMNzISYcoamXEZzoBOAvEkpL/VZDdYGElGm01+CCE3CyTwKM+eO4rfT037K3ULP/fwZUw8SZMZmSsO3ibdTR1OMS6Xl6XpKo2caCw6JJMVTseKPsrKRYIrTXhB9YpbAHnDyKxipVu8g78m7AksM7dcYdIGKtbxWOL9pYU69VtgIVyG7aKRs7L5GPrlcFOTOf9ddxHUC77kIU9IDiAx+F8jrXmJVikj6ozx7kGRgPyqFQblJzS2OCnKxL9S5SfWUujXTP+yK24J2bgZYWEB/ZqVUHWsQmqEyrtHrGUZmAV6IyDEMJ88fG2dl/uJl67ZoYBM1OuNGPfSwlTCN1BrE6u3sdeD86ojnuSWNGOVfzO4Bzl8F7mIMrsjUoBn9dIqF+plu/JWzCddji6PLAXPPmwz5IEWJ/5gSzotiCOMlES5vU7GZ4c751bXCvqQ2FXHIfgcCuqW7vbeDZsVfDYXP6xc6olWvwOwp6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(366004)(376002)(136003)(346002)(396003)(451199021)(2906002)(6486002)(6666004)(38100700002)(2616005)(83380400001)(6512007)(6506007)(186003)(41300700001)(86362001)(54906003)(478600001)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(8936002)(8676002)(5660300002)(36756003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jExva4blS2zNaO8FRC4GnNm0TMdZsaCp4WLbEtKnSbU7eSP5vS+Wqneir6P?=
 =?us-ascii?Q?7rIGJlKZTUDcUN5Frlpest4kNIQxKAJIvXtk7DwTey0N5OI8aTzJzvz29oO4?=
 =?us-ascii?Q?FQ4x7qHUEdr/Xd6Lcz5Z0PXVDAktBeRMS8TQ/z8M0Boa5W7E/pKWhYgLLnUc?=
 =?us-ascii?Q?EmqEXilFP0Uds8OcE6R44pD9pnpgsEb8vbvW+fWAWRHDzNwnjJmpcoTbQeg1?=
 =?us-ascii?Q?t6Mo9RbcZl9Fz7cCd6W6yWlcHk0D/8xWGVOfOqzxU/bs36hg/DZO2eRUK0ca?=
 =?us-ascii?Q?VF65BG9gNzX/5vLyHNeuhyz3XPDfaNSzSt578tExE5B0w5+2nYjVz3FSG8n3?=
 =?us-ascii?Q?u2MviDG9JLmfgXoXN7veyq5hbN1bp2QVM1n1kcELG0v/WhFOqds3qlKSpeXF?=
 =?us-ascii?Q?veLnojxnAjODHh8I7db71WZnrypUTs76ccsgolgIJfQsoHBQBFY5UIMK8tm9?=
 =?us-ascii?Q?l27AfNcIcIE7vCtEeP2uOp6fBl7EbmM62vIzQBKajsAApI23dT4h83LDgU0n?=
 =?us-ascii?Q?+aqflYw5AoS1jKfEPhCcU5aQC5EDao22qx7eN/w+fpQcsbAW5d5Brl+LJzk0?=
 =?us-ascii?Q?joT1Qb5N+YkNTKKFSTHyMTAloESzav2sa+CSoTsTu5eBamvvSJlH5cSy+hEK?=
 =?us-ascii?Q?GHo2hgVSyCZthOwXQnf1k/mhO4nziyvTFtZT21fDQZRKf+9FZ38fiR7dCLJn?=
 =?us-ascii?Q?ciNdc8KlSOVfvQ7kT96ue727ehtaq7U2KtsyY0A1hG1Dc9+Vfh1TEOOqtedP?=
 =?us-ascii?Q?MZ7uGaZC8D9KkXmXIVA9JzwqO3DErU2/+SVxJdew4WWgJih+D/ZQ4NkuegPd?=
 =?us-ascii?Q?Ls48Oy27QW4ghl8iCY5d13Ao1WJdwO8c2xiR89LUetLYNYme7U8AZTLP9pwO?=
 =?us-ascii?Q?OoS6gLUBPZCl8V9KwHmMWt9VpTbUl+bkDI+MIJsO6oEYnVhGwWlWbbCExwAW?=
 =?us-ascii?Q?ttnN5c7F7LzJ/dxJYtC8UC5yitaPn7z4qfaKngiLJXNmqqlXp4ti2GxTJo0z?=
 =?us-ascii?Q?N/nW2cAe98VouSINQk82wNFwg9TiM1mqxSiEXyFhyb9HuxQOX0UiJe6BfFkB?=
 =?us-ascii?Q?wxFmkdw3iEXeovN0o1fRXBDL9IPRsburNesC6vCRLEQb4xuBgDtCa0jsPIvq?=
 =?us-ascii?Q?EOZ2BRR5k2q473L9+e5xsHAB4hC6ZPK4s5ySIcQA9+83Zzh5NqgItMM+8kYp?=
 =?us-ascii?Q?B/GRqjVT8ANe0Sp7b5cLfhaXyrOGYbKBJtOLttLR2ydfr4mxAlVl5bb6biio?=
 =?us-ascii?Q?zFkfyzJ8COJf0TbjXrifC96brJk9cwVZIcted5kEqUnlzlvC3+INEQq5t4+o?=
 =?us-ascii?Q?uAMhHAe+1Rg76UQPXS5lNLOeSYBmxRuyPBgTH0Y43I3gZwISkcPWELvABX2n?=
 =?us-ascii?Q?fDQdcoafhK/WtdByWVw6ZJlSJtcVtZ3DCTkNSDrr2gvUg8LVE5cTLlBxubUn?=
 =?us-ascii?Q?0/pTI67vviEsLyjrIig8/Yeerkd1XgPvEGmYQad4UWMYUE94/3JECGZ44356?=
 =?us-ascii?Q?0C4XjMGC0OXhW29w0MaawEeVlW5wxeRfl+OPp9esLFre6w1w8XADwo9c2usw?=
 =?us-ascii?Q?A/iXTfrMLahOX/t+Qk0kv0HL+Em9gY4O9rAPlEmsC2C/+ClVZT7oUkHlOmNs?=
 =?us-ascii?Q?MkyyGHchjULRu1jwZ7SU+p8XG1vsj2tc47ob2mCMAHN/Q/HwCRJfRsSjwFgI?=
 =?us-ascii?Q?PMLXgQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8144cd94-786e-439e-e614-08db7640ea10
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:28:58.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJTWvU40mHjsvIfjkTC+gc1dwXW9lOF11+qkUFQSW4OYr4rZ3HPQJX+MwQcjEwm5Ijx2nRrzO4J2SzzPlTvg106j0waQVkF2P6gW3vkDO60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6153
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 05:35:02PM +0800, You Kangren wrote:
> Replace the ternary conditional operator with min() to make the code clean
> 
> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
>  drivers/net/wireless/legacy/ray_cs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
> index 8ace797ce951..96f34d90f601 100644
> --- a/drivers/net/wireless/legacy/ray_cs.c
> +++ b/drivers/net/wireless/legacy/ray_cs.c
> @@ -2086,8 +2086,7 @@ static void ray_rx(struct net_device *dev, ray_dev_t *local,
>                         rx_data(dev, prcs, pkt_addr, rx_len);
> 
>                 copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
> -                                 rx_len < sizeof(struct beacon_rx) ?
> -                                 rx_len : sizeof(struct beacon_rx));
> +                                 min(rx_len, sizeof(struct beacon_rx));

Hi You Kangren,

I like where you are going with this patch.
But unfortunately using min() here causes an x86_64 allmodconfig W=1 build
to fail with both gcc-12 and clang-16.

Perhaps min_t() would be more appropriate?

GCC 12.3.0 says:

In file included from ./include/linux/kernel.h:27,
                 from ./arch/x86/include/asm/percpu.h:27,
                 from ./arch/x86/include/asm/nospec-branch.h:14,
                 from ./arch/x86/include/asm/paravirt_types.h:27,
                 from ./arch/x86/include/asm/ptrace.h:97,
                 from ./arch/x86/include/asm/math_emu.h:5,
                 from ./arch/x86/include/asm/processor.h:13,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/net/wireless/legacy/ray_cs.c:20:
drivers/net/wireless/legacy/ray_cs.c: In function 'ray_rx':
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:67:25: note: in expansion of macro '__careful_cmp'
   67 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
drivers/net/wireless/legacy/ray_cs.c:2089:35: note: in expansion of macro 'min'
 2089 |                                   min(rx_len, sizeof(struct beacon_rx));
      |                                   ^~~
drivers/net/wireless/legacy/ray_cs.c:2089:72: error: expected ')' before ';' token
 2089 |                                   min(rx_len, sizeof(struct beacon_rx));
      |                                                                        ^
drivers/net/wireless/legacy/ray_cs.c:2088:34: note: to match this '('
 2088 |                 copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
      |                                  ^
drivers/net/wireless/legacy/ray_cs.c:2098:23: error: expected ';' before '}' token
 2098 |                 break;
      |                       ^
      |                       ;
 2099 |         }
      |         ~   

