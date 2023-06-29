Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1157424E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjF2LUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:20:14 -0400
Received: from mail-dm6nam10on2116.outbound.protection.outlook.com ([40.107.93.116]:6945
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232177AbjF2LUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:20:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTLsrD8xGeHmkvn/kR/45tig0Cr51qsVKXZIM+3ZJhcAYJk8Bkz43m7jdIAdcvkwuRDMPH4dhycbe3t/yCnpvqtyVTDmWU1wV4YbNu4Xj/J8R9xTpr6ZZ/X7rYzjKvuOQRl1r6Ohs3m9DbYzYblaIpeFnv5cRUUiMYvQwWFzx+iUqfx1sJMBu1sMZz5RaFQzw6URwcpubTDrIoC3lW2h6jKH9AZDX+aqZuvOoc7e1XgqFLjXBF4gGusrnZygcEebErdvoBAueKbO3DQdnwITM9ouqjOHWKfzBb1OcvHAgslZiISfxHkRT0WqGsvJF2JLHvtXg3Zs5CqUUV9UC+MDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SUt+r4uAzCxKh0nbKz1EGi1TfVwgFDkNMsRtVbFxCM=;
 b=Fm65Nq76vjHUH4MLiXxIG9nD8C88sU6wSGX5FV1ZTz0lcWmlLdvdOi6ZGQuhlWlUNeRnP7gegaOTYpv1y8ORxJqB20lyPre8dkOGU7meckqreteyoUaa2sC4PWMh2o0UDj5Kx8WE56vncoKQ5PQe1V7mI15raYKAJbI/rEhsBEGk0FZs2953Lm891C21FlzYLC1/lp3WyKn0IDuu40JXFODEGlfr3qF8ifYAcXR/mhJPjrT4GXlwNWHpLys01U15FE9jd3Mjzii0nVQHqlsEp2JNvFRKQucFcKb+7JjnwPu1nMP7D94nxp8sYgApTX3Tef1/YkhbC/Dmcw4lKhyhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SUt+r4uAzCxKh0nbKz1EGi1TfVwgFDkNMsRtVbFxCM=;
 b=s2m6ic19IBmPyfCuf+7nKmWuU5ltIZhJm6x6WY/RTr++1bRJmim80LUiIaErxRFExWTaYasUD7sMQ8bH9eHWNdaK3gAuEGMpZBOKb4VwceJAOMomdRxID+d3PoHUNp0fb/shrteaXtT4zdLvEgxNT4/8wG24BlOkWXPfNibYGyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB4139.namprd13.prod.outlook.com (2603:10b6:303:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 11:20:05 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 11:20:04 +0000
Date:   Thu, 29 Jun 2023 13:19:51 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Sathesh Edara <sedara@marvell.com>
Cc:     linux-kernel@vger.kernel.org, sburla@marvell.com,
        vburru@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        hgani@marvell.com
Subject: Re: [net-next PATCH] octeon_ep: Add control plane host and firmware
 versions.
Message-ID: <ZJ1obqExufmgq4k1@corigine.com>
References: <20230629084227.98848-1-sedara@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629084227.98848-1-sedara@marvell.com>
X-ClientProxiedBy: AM0PR02CA0205.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::12) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3c4efc-80ec-4e76-018c-08db7892c94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+KN+2Fked0E/u3bvquXxYHj+0k7O3H5F4g6v/FK/kHtmnYf9aYiOi6mulu+Ojg6ybZDGgNL3SRxTZvOYMo/J7SPiSLW37ApA2kc0+h6zfA3Gm9fgmdJQqFE6zn2g1o/cRo1mQKBimMGqWRoGEAqdQ5012l6TY/IRuPdy3az4UyT6EG8ua19PqZmfgKFmh33SKb0WBPzc61X/7GLPRpyN2Bze3rI7OeuB3w7gX3e5IHTfQNBzdmIx7GEGYlRLHscpI5zQTsads1y7rPsezmys8NC281k+YpyjIU/RFJ1Fivv6+ggBR6K6o8c9fnbcnoGbPtcvnhSMJ1KGSXTG805PCa4cody6vLmHn7bD8RcJ6VUw6MvFQXHKg3okcY8QedT+8Zya+WPtP+ZdOTPRmrBN06+PlwB0Ax51TrDQ1OWmPsL8+I1ThO7vwhER7lGKmoA4xxsPdGXzfAGIhkrYeSQ4LgBNkMBPPSZrMCArjvH66YJu6of+r1GNxUCU26seQIlYNby2sbazAf3j9+X/cu0IDvmi4Gzhdm9Pk2XKaZWTppT8nYQzgT7lTpHL83h6Vw3fm6eB9QwZIwbK3O0cg+g74Subac7x476eY5D4MhhsPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39840400004)(366004)(136003)(451199021)(66476007)(66946007)(66556008)(478600001)(6916009)(36756003)(4326008)(83380400001)(38100700002)(2616005)(86362001)(8936002)(41300700001)(4744005)(2906002)(8676002)(6666004)(6512007)(186003)(966005)(316002)(5660300002)(6506007)(44832011)(6486002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Lb+NVRXuiNZRfaqypdU7tQlywjOOJfrVGik2QMnvwmt+QPeFqOVhrBMZsym?=
 =?us-ascii?Q?S2cYCLFa8+GjQ/l0MEeSaS33mpIkqYMkJBOu0KJbq9h7Zin9gf3TMNksullT?=
 =?us-ascii?Q?7KE3QJjC3K568MMiWB6k1RJonlmXRpXBlZdAUDO0xvj7s8KcMpGM27zrq2Av?=
 =?us-ascii?Q?87dLs6SOOAs0cE+sXlciNUaHNMWrywQRmlYS/hIfNnQk0mjhVorX2Xq99neN?=
 =?us-ascii?Q?teE2oOju60dEGwEctBGvDMnSOTbLeeUdMy2oRIhcdOejEpEDctFjrSrrK9X+?=
 =?us-ascii?Q?bsWfG9uWDpnw9/Noiptc1ktc3W4IbFYqJYVKqYgdXQGTifIhxTcEhlsBhR4m?=
 =?us-ascii?Q?B7yYgkRIyQJFFSIzJcPSCKiGGapzQMJqPTJIQiA+rRm6Qbq7xFm4Fcva/pOD?=
 =?us-ascii?Q?v32zvhF+cvk9t8Db4qgR0I+fbfDmNMgDlfXVT/HAV1wJGHNByJYcGxECGCmk?=
 =?us-ascii?Q?ApyV1MmCQt4s6Ymc8wzpI/YqO4/QzAmzN9PpwQ1cJs26gk485QYaf5CWGK4Z?=
 =?us-ascii?Q?GI7Hx9Rvo7646BwKO55wDKTKHz3lXo+6Xoljlo2b4/OXX4rCftnHJEk9WqRW?=
 =?us-ascii?Q?yrbKrogCWO8cJD0xTIXhEoTLNG6ygRDGt3eKF8luSxPLC3dhP8vdq61dnYny?=
 =?us-ascii?Q?s/MK5tlqNtDDzHtT/MuesBdX4S0yAux02O30Bkbg1iy3JDWwm9/DZG5lZbmq?=
 =?us-ascii?Q?DrFXnleTTrKljcnwRF8/JkFO216Bh1PcEykpKyiuxUinZoga9akSq5GnkTPk?=
 =?us-ascii?Q?zKobsZ56jaeB0NGbT162u5Kd8wn87qcKuz/X+f4RDQ7UeDgIZwncl9V8KfQT?=
 =?us-ascii?Q?6vpcCkpx54lhdu3sDz3P3X8/vpn0zxUuo7bhybLB8rri9Viacsf682Nd/rKn?=
 =?us-ascii?Q?2SWxtnqwRWV7aJnOgZ6KHV7fFpm42sbysM0T8Mc0tO+oi7T5sgBbp2/Jnt9H?=
 =?us-ascii?Q?kRNn640q+5625G40T25VnK224UgHp3UBd8A1PMYgj3gQg5yDERuoQkuD6LmT?=
 =?us-ascii?Q?41aUmu6HZcdSJwYXBnrlrXzA59AWlNktFWtwOwkKjAV3xgifGmXCN5uv5+0n?=
 =?us-ascii?Q?E+gF1iBYpxZ1gi2Gl0aPfkTDytx/o0PvY7zWahTxvXtjMXTHS0/H3oJsAuCC?=
 =?us-ascii?Q?8B2gQzUQNzhRsfp7WtzNlEMbAPqaxZGykuNfNshfKq5BVl/2e0ib2azXjpLY?=
 =?us-ascii?Q?IRFhthqdZK6REDpkaN2plnPcmIbv+SU8kL2NYw6zl2mylEtcgJqe6ODYNkyO?=
 =?us-ascii?Q?iQ4OHkHxGLov8GH/VE2jLwL+G9WURrQGFpCluIalwBjmZwmXdAY55tZTMLfH?=
 =?us-ascii?Q?/1arC9U5OhCOH6243LA8SOevkXACk/4fyQIKGP9uGKqeeH02R+kEWPtjMUa2?=
 =?us-ascii?Q?SwhqIiKUCc2bHNE/Phby2SUTg8kzDBUXryMegeb9UlNfRLCoaX20/HKp2wi3?=
 =?us-ascii?Q?Tijh4ccUJaf1kewzXmp3gZe1E8YajHGGmBeGGiKQQKeN9xipdWn2qZpVHjXY?=
 =?us-ascii?Q?E7HDcznIprSSDdtFJIWjSPVv+jRpV9gKQ6p3FX8Gp5eR4qvEes8eFsQn0Y3O?=
 =?us-ascii?Q?pzG7sYKb0XKFELkm5Q00nEI3KKcZF75qWq7+W1bz795lh6R6vlJuGuh1xfF7?=
 =?us-ascii?Q?S5aX+CVYbSmBLgLbJ6W3d9ulfQuvLTPISLj+7RQxtZXK/m+Rmn0EfrCEw2sF?=
 =?us-ascii?Q?qpJPRQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3c4efc-80ec-4e76-018c-08db7892c94c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 11:20:04.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHPCcahmwyv9fxnv4wJEomFcG7SpQROYaeRNJQeTChsTFubP9dFPHHgWCC/aqEmhVj/kBon1yBLcVXfFEhNX+Qg66PMiDPSx0n30nwuq5x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 01:42:27AM -0700, Sathesh Edara wrote:

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
> index 37880dd79116..dd4f055fa8da 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
> @@ -7,6 +7,8 @@
>  #ifndef __OCTEP_CTRL_NET_H__
>  #define __OCTEP_CTRL_NET_H__
>  
> +#include "octep_cp_version.h"
> +

...

Hi Sathesh,

octep_cp_version.h does not seem to be present in net-next,
nor is it provided by this patch. Perhaps a git add was forgotten.

net-next is currently closed.
Please consider reposting when net-next reopens after July 10th.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer
