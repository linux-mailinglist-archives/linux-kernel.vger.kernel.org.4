Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C16B6F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCMGQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMGP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:15:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446B43912
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRVgNiqcAdU7ShaauoAq6nXt6YLy7D+e8jm/uv9amEDgeVlPxo4rlrzF4rgMAp9sn4mhlf9veC3XLY2lN+CS5pSyFtBYgRHxmgsWhM1MuHHhxuYsmgf6v8H+964v27mEjxOpoE1o//8NpDr5+/7JCm6fIfY2ECQSmtPnln8qVTVikeJ14RfKY1E7Ja9VIpHcx1iTSbsnRb3RHHqt9yMY0u19gDSXKS9S7VUvx3q5nXdNdFkmPMlZFBz0wV2xfpHfD6yTS+9W4zQbg1qCcpFDoZnDskrHGnmXQsg53ln42tZcJbO+5P1oUh/cIgwVZk1sgMnzJPdjI/vgaFRETyYxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4JlwXGcKv920Cu5T/OU1xkkKcbw2uKcKGBF+/CoPio=;
 b=XjODUmhNjAeRgKWm34uKpp3JruVqxPyHSMrdwlgi/fMRD55zsK/sbIDvlOYh/aoIUj6zjHVA/nmRnvKE7Xq0617HTwtfp6p8+xCUL0x9WgIrPNc2H4HwoAINcYu7MoiKY/aQSpfDnbXr5V4mAwJEo4aia6r2YmUxwnmXMdZoIK+iFD7Mlt9H2ugBjzQ2Lu0oaR0xkTnhp2MFG2fHwvKZKYY2IVofjQyd5M7S/XnNXJsUsWxTqCuWwnZFRiPHwL+IysVw9G7Ml8QstTPYIgXFgE5600NdsEHgacrVgnJzdXBWnnXlaoLH5b2EqkU1mR1ydViUehb/Ue09J/Ho7MR0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4JlwXGcKv920Cu5T/OU1xkkKcbw2uKcKGBF+/CoPio=;
 b=PV/qtXeDHi92s1PWtrKRH/QLI7K2KGSNZND+kM332U3Fiazy+cBX4UHnTmPYBWg4skoYB/BIAvrxOXvC9QHxeC9V3DuP+brzaXETM0n6EMpzTLSQJeaZs9uD11xGDP78B4YgEC2tF9Ei+G0EDhX55RbdqxLsHIOGE5hsMwl2NnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by TYYPR01MB8231.jpnprd01.prod.outlook.com (2603:1096:400:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 06:15:55 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::e03e:1938:695b:f472]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::e03e:1938:695b:f472%8]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 06:15:55 +0000
Message-ID: <87r0ttdvmt.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-pcm: fix hw->formats cleared by soc_pcm_hw_init() for dpcm
In-Reply-To: <CAA+D8AOztY7Qp3hs3OOhKuhCDFzqWjSrk240S0CzLR7cg94GLA@mail.gmail.com>
References: <1678346017-3660-1-git-send-email-shengjiu.wang@nxp.com>
        <875yb5frnl.wl-kuninori.morimoto.gx@renesas.com>
        <CAA+D8AOztY7Qp3hs3OOhKuhCDFzqWjSrk240S0CzLR7cg94GLA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/26.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Mon, 13 Mar 2023 06:15:54 +0000
X-ClientProxiedBy: TYCP286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::7) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|TYYPR01MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e87e727-7313-4d06-0f0c-08db238a673a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIojG/QWKU8IWdNHJdN00DxD9QL+hpzxzKv0y3w2kxGJ74Hxj7Rznmq8jHLwdCnB53UO+RkPkOSMtcTRkaAtGeApRcltMfw1rjugLCk6KCa9ntffWFH+BRnAXEloeyxao3fz2hwHj/5Q0Cfsc89s02J0EdScQssB0ociYndkAPUYOO/B9W72R+sHq7tEoO2+0jd5JlrnzNebj+lThYhvKfWgNqmJbPEJhDVU4rmTTAb+/QSv9fH/rQbYgwHoygJzZZSC7J0i+pdE7thGgFDfyhp2zvOEE2ZT9z94UgOUdErsuejYzozUh8Yc90Xg4gw99Hsg9jhnwwF573KRMHp7z++c87D9BTmtB7hJ0k+B7rCXvR19d0M1MmdRTCDiayRhhCuj2HZGlxNWmV5yGsYK0YTrwzQmmsr71Lozr/J4o+EzIjA2LHcA9NoIWoc9lO+yrCwWoJjGwrzrFD6gCDubFsTEXhgZaN4GzA+JQO5r0h1wE/6lWRbeJQSl1uG2nlBYdy6cvgt+m28r4/bEhVx2bSOQPcbeeU2c+Qcy4jyvYOJlJblokgY6anWeT38hK8kdT6aemX8vXZs6HdM0+xlhBIVM0gnHwp/yKCxVkUY3xsQlscW1SHwz3uiUIYyWL+J71TYQwu9uAh4PVp0zxLYO3/ub8krFGQ1yl8QtzP2pqrLM6c+qYb3xC4g9/nAVJjgn92yMNPdzJyoPhUx7t/QQMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(66476007)(6916009)(41300700001)(66946007)(8676002)(66556008)(4326008)(5660300002)(4744005)(26005)(8936002)(186003)(6486002)(6506007)(6512007)(316002)(478600001)(52116002)(2616005)(36756003)(86362001)(2906002)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLpz86Zp+9EDJXWZZYE48lW80uC0040E8Mq11qfb7n+Aavs5XhTd2hi/FJUj?=
 =?us-ascii?Q?taHXCY9OhuIdZcdkPvrEgSc9ISKTGSnWaOBh5QgFQ/+qvQffUolGrN9ghBrS?=
 =?us-ascii?Q?rnBJn67aM0oeyVOgOufweVZbEP/EICB5+rOP6kbvGxo5CrsN91b8T8R9daDb?=
 =?us-ascii?Q?/0CqU/dVNy8ud11Gs4d5uPBIksnhYGvpcsxTYWmipl0dwKguq+pChIsrsvXQ?=
 =?us-ascii?Q?nU0eN7LXTGo2B5mCEg8hhoJHOdp8+fIBq1p+GWU3ZrnNyJ4XSNsx8D7+d3ca?=
 =?us-ascii?Q?RV5Yky1fGjYJzJ8xow1uc7frkidUsGPRKOVroiapuYmxJCfbDgq2OJl/lAFl?=
 =?us-ascii?Q?cCI4bba+PQBhmbxU1YUaSE4fC4EoNq05n2z+JZhDD3i/iRaTtWVxsQv48u8/?=
 =?us-ascii?Q?nTErj5bMpC6HY1Lod9zjGX6aJK1gBHo5NaQCXBqif/csRHH86MdKREC4c/tM?=
 =?us-ascii?Q?LOrTYHPoIUmguQOvO8gjsqCtx0qfqWKCNq5vSZnqK6GcSqCERELAj87Zj78R?=
 =?us-ascii?Q?k6fpYlh2+vJT4aQa6cjfS2zMy8a8BUPHfbKvYG2x9svoU41Cxe5GNX7zJLEG?=
 =?us-ascii?Q?sOmvRIC6Gb5HeJdP7noJO2XiHBKMxH3LcEBa2wNyTi1kKMC9mp0UZ0vjqeWJ?=
 =?us-ascii?Q?XqF73hnPfnlxS0eUt1uwskxbmiCbeLqXpXhqMFS1qMpjAsqsROwmmVi8I0o1?=
 =?us-ascii?Q?TY/IQvKWYlm4VeMaXj28h19GX6+iKgl/vrdV2jho5diewHu39Pzkd90LKefk?=
 =?us-ascii?Q?6X6T1hUgy6IU1JIhHaNyi4uMR1zB7AXXWMjRj/gFmVH1uYQ2E4t3i8Ntg655?=
 =?us-ascii?Q?z1v4A/6qk+Inxk2PHoyIEjFluc+2Fb4fNrG6AjpIHS2Gdw3ngmOxHD08ttUH?=
 =?us-ascii?Q?b9PIGri206CXL3WHI1LMXUuc0CGuPaPw8VqLri3YV0xmoGiWEvRomZbMChv6?=
 =?us-ascii?Q?qwInveqTCycNWc2j/yoOfexUqT8HOKQuM3OjXWzm3L7OjPmJxYwI9DA0m5xw?=
 =?us-ascii?Q?YIKWeelRY+WzQD+W+jUr7K26W/l90e7uquAL6PCmkVouOmdzB4IdftrJ5dJC?=
 =?us-ascii?Q?0LNf/ET1vKBS/d4XmC+43MDo9MpPUiOz7fsmYfWPHiGt9rLf4RbZkEOPhGM2?=
 =?us-ascii?Q?9otQ78QEK/sv97VYXekVwe5tkd9m73qKfZwXDvW0J7fNiyLMq07QwTmPsdio?=
 =?us-ascii?Q?AZgjvBwO5EXciFqmhzWROieGI2iGx3WKYvQ0jpwGwQ1+yIPr4bIP5hs/pLnD?=
 =?us-ascii?Q?ZNcNXuIdu2+VJ67vjT2K4t2Hb2oudH2maS9rD/zRFXeMTn0eIYdCDD2tY3Ip?=
 =?us-ascii?Q?2x38nXOO0i3mIoooKbm80TRz/yMTGyOsbOQ7FJ4esFScl0xQ5UuLjeLxw2TD?=
 =?us-ascii?Q?sQCPVa3E0gASixGYnG+MpjCRJbwaGUsu8uUXRRTLGBcA60pmWHwUoWil+1ip?=
 =?us-ascii?Q?amxV/O2Ft7I4IB5FQXTZ5vl3vKmyev/xvwKs7QIe9ZoLKaARevOXvg/EZGSx?=
 =?us-ascii?Q?R0FKYRpDem88PdgWWav3Ij8A6dHDI+vLtPNwpDAgg2PNNiM2LKtitpDGG+4l?=
 =?us-ascii?Q?NPbvNQmHOtBxJD/tlCR7BYyd5/sVjqMMb2jYYLxdVdPT30oMfnHz3chxJWpf?=
 =?us-ascii?Q?W5dKhoHnqIznfp8YJSAN0QQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e87e727-7313-4d06-0f0c-08db238a673a
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 06:15:54.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z23IG6eNC1TC1jGI1YXYtJWZ2xBZAno8Pb4mzEMTvQdMJvi7x1gNTco/DmHpAVbIWZEPvF6AXH9RJfqzWJmQtWarZHqJbUd7cnQjTyOabNkeT38NebUA4MoXXCzSl0B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8231
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Shengjiu

>     But, it is doing same things under (A), too.
>     Do we need to initialize hw many times ? I'm not sure.
>     Can we simply remove soc_pcm_hw_init() from dpcm_runtime_setup_fe() ?
(snip)
> which only calls soc_pcm_init_runtime_hw() for non dpcm case.
> 
> So the initialization of hw is not many times.
>  
> For dpcm the code here will be skipped. The initialization happens
> only in dpcm_runtime_setup_fe().

Oh I see.
Thank you for clarify it.

Best regards
---
Kuninori Morimoto
