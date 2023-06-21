Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1F73882A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjFUO5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjFUO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:57:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::71d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E15193;
        Wed, 21 Jun 2023 07:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il0QNBZMbzbnPpF+NF4fe0qErmEWRANYmTGS2T+l5yaHfph4Srw2cHfyWn56MQsgVxvG9hBA18Cg0Z4+nFFY2yKCkK+Y7qthGE+TayxUBoTEvXtE/PTU9gYY4HKmZd4oV0Rj6Mvq2PqSiLkeEeSNFI4pRlgm1B3gFi3uEa6z89Q1bYJz+va/6WnWNU62zsf29OSbWcokEsY4xpZaGu6SxrYszKT+J2yxJyAxU2HJulOEKbEc7hqwU+HFpA9/Mat7IqhknFMMpQ/zaJNEnnovbHb7n8M6Q0xcLxgO8XjlsiM67AG7i6Xsa8GSXBq8nO1bL0P7TtNb2IIa5A1rvO01gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o8z9/jDb92KQ1+/FU/acDwSNC/MfTbZf15wto/2JR0=;
 b=NXlsgWBU03771KTB6Krf8h38kl5nzGVyyndF814TJuN9p2qJ7HjnbAStlgJlY0Ls20iILEDBntBHjTSLFeEf2efhkH4Htl77q0Pwk4kbocwSndfMNu87Ek+OvzeuSjZ9qqwceNGzK6Qi9O7IFzLt4dphDBA2ZzJjfWYs01gzZcqxRqwQMZTjf8gz9RUUyUOPFnb3GoQnP5T7MXVmuVsqNf8Lwx6zJ8GVMcWLG0Aml2CyFw/E9sVPmsWCq+2zgVXvEW7N8y21oGFhsTbX+tS0ZeGz1aOYzQh6laCFBe9NwrartHBDHUFh3mwEt2r62CZ1eJgxwbDaNM2WzaseC6rj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o8z9/jDb92KQ1+/FU/acDwSNC/MfTbZf15wto/2JR0=;
 b=Hb2saJ1YmMzHAESLltNT7gEXaqpVueAlOw24+Uojn6UcNtRJeuUMdEH6te2QRhGlmCT7ah8wX0Vi/jSBDwhSJTOYM192i1covDIBj1O5fie59yi+4zq+E0Q5Th1pB3XrzdWJq7Gb27+ZY43elWvv3IbRpAnJnH7hYgS0dtvK8VM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5888.namprd13.prod.outlook.com (2603:10b6:303:1b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:50:06 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:50:06 +0000
Date:   Wed, 21 Jun 2023 16:49:58 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     M Chetan Kumar <m.chetan.kumar@intel.com>,
        Florian Klink <flokli@flokli.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: wwan: iosm: Convert single instance struct member
 to flexible array
Message-ID: <ZJMOFnpONApGxOKi@corigine.com>
References: <20230620194234.never.023-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620194234.never.023-kees@kernel.org>
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d3916a-1053-4c7f-9071-08db7266cd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3ABjdjkleM+qB614U0Lt2lwLXmUvz8aqBiKtWdl6EPc29kVE1Yl0FBrow526RMN5/xtYT+l5d0nw17CbZGtGlpI4raSN0EkAU9CgSG9RCMHBg21/ilwmIhNhymRXl/R77x+wg95zGdAqoqqiOULhSTMnTM0BJelS6VEUTKtFJ2x4XpsYsh5NbsUSQtFLxMU+sleMzVPyCT/rBrB/PEuZFoxVL/fm4EYwZlOltw8E64f0Albd2clxWxukhnhZxDEVo/c9evBaG78uJ2jLUXotUiSMSPkVJtHAsbQBBEQLin+Vrdn5fwVPrn5pn3wNRqdYAqhkwgr1s0/QntsWPiqwb9ie06VEL77tMuqmHfu+xM/nhAp3C1TWk/YLGDcaHMpH6VUmcZK4HYhe1165BOiSnpYD+kqP/l6qXVh1YBBFfDkpVAA3Dt8mQVfe9gbkbzswmIWDv53mZaaA1uKaSnITAIBSAiCvWTvObwKw43JM5K7QiM/JthTfXCTGlE6+Mrta0dysi2fHnl/5ctm2RE8jD2UPggnd8gWaHlh5730tWA6/6HWajSxxy5qQ2kbG8XHN2FV4GNMklOLl9e+JWMF4XxGUnSXAaB7CwvZI3NNC7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(396003)(346002)(366004)(136003)(451199021)(4326008)(2906002)(478600001)(54906003)(86362001)(6486002)(38100700002)(966005)(6666004)(41300700001)(83380400001)(316002)(36756003)(6916009)(66946007)(66556008)(66476007)(2616005)(6512007)(6506007)(8676002)(8936002)(7416002)(44832011)(186003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wWXByJ4jNgXSv+x61NKyU28QiIAj7frIlLkxDiTLkEOi4v59fM3oVvTRaQJm?=
 =?us-ascii?Q?fRDq9+4CGFAHeT+/iibd+ZNNxW5ABL/99zE8161g8c5BohMaBtY5aBMoz0tw?=
 =?us-ascii?Q?L3Xr/KBC7P1NZZfUgClKQSmrdEEo2xzsj0xzazmTNuPwbtPNdIg7TNehNsuG?=
 =?us-ascii?Q?IFXzsAdI97CPVugE6MQclnNcji57ihBjvR5JD08rqWaRDJdWZTcZMZpDZwAg?=
 =?us-ascii?Q?DUs8zf8xz1zWthl0S8zZZBsZTojipXusI6qLCAuQ2w7Mimsdf75P4penUFY4?=
 =?us-ascii?Q?3x4XB6Y1vjT3HZfoAk+40czo+yKL2OmCOr3iTmv/pS9BoKJXe1vrRltTaOm9?=
 =?us-ascii?Q?2F4tma5KB/wrA/JYMFdxmI9jMx8NrLpIRhSU36F17fPJoza93FZ5lKGSutjT?=
 =?us-ascii?Q?PD9IYioYJD53WXaMPbu/Mue+q77YoFbEqgeR1teptmu6rrSjmtRvLht9vYU5?=
 =?us-ascii?Q?kx1W41j0zbR5xwm+FVm8eaz6rSAxNSsfqn+vnkDXD33RJLWKT8n4t+V0kKJi?=
 =?us-ascii?Q?dRZWXY0a4jYsIlO6nEbJSG0LsbK2RI7hjFhhGPelLYLEphg+OXS5lmr/Za/T?=
 =?us-ascii?Q?bZi+zKY+Bd2WInq0cVn/vqRRYNW9IeHv6lsNH2xSyk8KCwWoI8qNNPBB+HsH?=
 =?us-ascii?Q?kBDJEwfL+vGqT5T4hDMzqKaf6sa7M1JbB2kvEK39Fa/7fL00IQkspC9TIaJG?=
 =?us-ascii?Q?dk+VelmdRv2Q64pipGr/CCzYt5/ieAiFx8TGx/lksfiG5ZkAKm+pGO5bBe75?=
 =?us-ascii?Q?ssVWla4yRKjh5X33GyF3SIbACeX6m0/OmR+E8TENgJds8RmjpcsFM9X6Adbm?=
 =?us-ascii?Q?DN4iLJNZRDVA16TN2ZO9zRzNQ6d0qWQOoY8Do/7djP8ofOHe280rHlrt4pe6?=
 =?us-ascii?Q?GJBTswGwYlOM+pcVleKgOydDDx52ZSJmR/bhA+G6ZvR11Wysb2mVSLAJmnF7?=
 =?us-ascii?Q?7Bf4unca/QciNge26dnbcQVzB9Exn6987FIh3O2wDVJOY3WUnwpxCh88stEX?=
 =?us-ascii?Q?O6/riRKewwZsgZamwSPsFS1VqQoIXGyIj+Ns3FYvClz3XhoqgvCORUfWyh/d?=
 =?us-ascii?Q?o2Ot+ocLqrstftWoMi4j311mQMFtfuM0zASiJk6e8xE3QeeCxzfaK41ThR9d?=
 =?us-ascii?Q?F1I8G7Js9yEfk7ERct93KIh2maQ85XFmGm14VP5TEADazHUF+g7EIbscfR0A?=
 =?us-ascii?Q?tCNreDuaLB+fbCGUVa5atdkyxh9bBXIJdI6pQzITM08c8iT1+HgV39GZlV99?=
 =?us-ascii?Q?hKw7ltq7bC7VLH+cmBlxZYiIVOr0TIRpqV3E7ZqP96j30tjSOstslEDFKYzn?=
 =?us-ascii?Q?6HqdobleATVeBgeidqNt0QNmLzmJVK63qEPcQ0wQ4bzyDbai/z2dg9BBYGZi?=
 =?us-ascii?Q?CwZ18zfgqxKhzPWKPvVicerSmFVAxs5LkzAN3li0RmpYxcRkn18bAoHv12C0?=
 =?us-ascii?Q?r3gUqBpiXB+hMstMBGBgxPpcSJKGBffRxNL2vr1pqhgodufA7t4C5TwX/Vev?=
 =?us-ascii?Q?LGYgKDvadEePdYOtiMiVsQd1L1+pk/IhBscuTcTgUlaXHWKIqGc8o5AggJP7?=
 =?us-ascii?Q?2b/Tctb0efMWko4u49N8fXEd54H9JblJrbJ8Pwds/USsgHMe/TaPHJTE3m6e?=
 =?us-ascii?Q?Arc2L46FaWaUW06is+8qOodUQe3iXgufoM7CYZNklwcbXHNrAQl0Fi/423NO?=
 =?us-ascii?Q?FL9cVA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d3916a-1053-4c7f-9071-08db7266cd2b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:50:05.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlGlPr5oYv+H4y0D9p0J9hevYNQ/oykr/WtopF+lOwpcCjF3JRANHpot10HAdg7CQrnGueOVbT7XnYeyrdw82OJXz+xYA/iOtJKeKtuWrDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5888
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:42:38PM -0700, Kees Cook wrote:
> struct mux_adth actually ends with multiple struct mux_adth_dg members.
> This is seen both in the comments about the member:
> 
> /**
>  * struct mux_adth - Structure of the Aggregated Datagram Table Header.
>  ...
>  * @dg:		datagramm table with variable length
>  */
> 
> and in the preparation for populating it:
> 
>                         adth_dg_size = offsetof(struct mux_adth, dg) +
>                                         ul_adb->dg_count[i] * sizeof(*dg);
> 			...
>                         adth_dg_size -= offsetof(struct mux_adth, dg);
>                         memcpy(&adth->dg, ul_adb->dg[i], adth_dg_size);
> 
> This was reported as a run-time false positive warning:
> 
> memcpy: detected field-spanning write (size 16) of single field "&adth->dg" at drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:852 (size 8)
> 
> Adjust the struct mux_adth definition and associated sizeof() math; no binary
> output differences are observed in the resulting object file.
> 
> Reported-by: Florian Klink <flokli@flokli.de>
> Closes: https://lore.kernel.org/lkml/dbfa25f5-64c8-5574-4f5d-0151ba95d232@gmail.com/
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
> Cc: M Chetan Kumar <m.chetan.kumar@intel.com>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Intel Corporation <linuxwwan@intel.com>
> Cc: Loic Poulain <loic.poulain@linaro.org>
> Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 15 ++++++---------
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.h |  2 +-
>  2 files changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Simon Horman <simon.horman@corigine.com>

