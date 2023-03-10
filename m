Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285D86B559F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjCJX3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCJX3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:29:15 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED381378A3;
        Fri, 10 Mar 2023 15:29:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9K8hJVuAy351oXKwx0YKTl2ulKm71oLe0QDhFClasyN7FmqFy4R7oZV6c/t/MX/zWmppfzJxuEjsvXESieuxqcOD9NPO+ArpDdJaBhRJiBk/0H8Rmt3Q6z/w0s7A++6uv4BTTjPW73dYMmTD6JuirOvfVhkv2oBsxxtsOMhjJbVa6b16cG3+02o7smcRIaC416Bak6V6loWRyP9qnhOOsshr1YNiVUAhK2IARs3P1hrUk+f7ey2PJU8jc89bBb0f/wPG3gXUj1keSnLJbbSiKo0vQE0sh6DPikS0HpgjST+BaaGGBcpmUi6/6Wmo9GRGsWRYrfBE7RrnyJuqAlFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhGCJOcB4n18wOeFPCQG9BccjzfevoRxJmjvK9/36Zw=;
 b=QvT/jw5dZUf5N0KMzdXVsuQ0sHFExTxgCBC+GZQcXonWP5tM3cVbQNPBJBqCvYmvgZ/MRraFmqzr4YfINk3AseT+yk1BzQp5NVlRDnqiHRSsdTrEmSNfgE3OXc4DXklOqPEfCjblRyRQlO/8CZKtzRz2oSJ2V8/WWtZnfxjPCiyylM3/LJ+5ZFaMdMGEh4B62DC5lNwVmPajEhdNEoSpyDF7smulONYAZlpXIY7rXKl++hocbC5mpwFV5heLc+B91qsljsNUGXkyfxdUz01l3zBTjDoESekOOzu3E+nPj6PH7TLIJkXdP1eB5c7sKjEWuuJy+2+n1XKKLzsNxwyYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhGCJOcB4n18wOeFPCQG9BccjzfevoRxJmjvK9/36Zw=;
 b=BJfmPRaXgsA+R9R6reAy6Rkbb+6t12yC29LQKirplPkOgM2/QHjxSH1Hv5EmPOG5Tul/xKRPAHorFE8wcsxq3kG3U0L8o5KQaTtn7ObL3WKFIG4ygNp03QcmrfCwihLJJ5ZyHMg00i5mDAWuIL39YPZ1mXVryuT5BZLG7c9VWa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CH0PR08MB7458.namprd08.prod.outlook.com
 (2603:10b6:610:eb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 23:29:10 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4e0c:f94b:5d28:66e4]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4e0c:f94b:5d28:66e4%6]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 23:29:10 +0000
Date:   Fri, 10 Mar 2023 17:29:07 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] pwm: iqs620a: Explicitly set .polarity in
 .get_state()
Message-ID: <ZAu9Q9gfkJwM3szn@nixie71>
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
 <20230228135508.1798428-4-u.kleine-koenig@pengutronix.de>
 <20230310184815.x5v2ysyeyshnapm5@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310184815.x5v2ysyeyshnapm5@pengutronix.de>
X-ClientProxiedBy: SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19)
 To SN4PR0801MB3774.namprd08.prod.outlook.com (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CH0PR08MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a4dc3d-a4cb-4ad2-2c8d-08db21bf4043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZpo1EOn5UHxFUlGn3vrLfebjkIVTCzGb5P4N02Z8bm+/VAqvD80EU1hrUomhkGQ/bj3hJ5KUvrIjPskFZ2+1l+1ByeetfitHejAgThPvsxnYQJ+QZheqojTkWUVda73eZo2Ttubz8eQxnzNcqrTGrbNx1yB1yTjPcQfdk/D2RTTVsJAL3YmclaCu2XmNdufvvGWcRcWKB/Z/EnElMTNvfD3wz4vRzYHV55TOIXguA/EAmNJ/QDzYEXRy2v7UudXYL5pPL7kCenaYZ9iE/FJfYfTSBSagHtaqivip26ITRRDFkhBWwr2YSWxIq2IH5kfbopZMyHUMhF5yvQWcuzTKEZ/XlsPiFsa4Y1AgBJRz51uyqm/IXjwHpN5ZzzEyFNBeW2nGTPa+2Upap1//6PmpnPziSoHiLvK9kPvGI9pWM9cqAClOCUjBFQ2U4CLv6Nk5IjqYOJHmNobE6es844JSgjR9PpHZxpjyY+5b4NTCwWqM5ioWvFM2lzQgYVS8Z0WMFo9pESq9z4kuT/GJPQzExPjhOUP5zyRZKv/S+r1YAUHH3Ylj/r1Gij/JzXwXqBMg7RO95btXRojBIpdCwFAk7RijXC7xH7L8dqy4xjYWOgeHC7Hrd2hLHpnvTuS20a1tJNSZ1F7US1/g4Kxvf/z10oUvpEQeaoqpllMdvezPd5BqKmM33LH6oGr1QJeGmQj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(136003)(366004)(376002)(346002)(39830400003)(451199018)(2906002)(83380400001)(4744005)(5660300002)(66556008)(8936002)(8676002)(66476007)(316002)(6916009)(478600001)(4326008)(38100700002)(86362001)(54906003)(66946007)(33716001)(26005)(186003)(9686003)(6512007)(6666004)(6486002)(6506007)(966005)(41300700001)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?o42F49OzT7VtMVRW6dELaHEQHzlVWwjLVqBTodvLrhBnz9fnhw13X6tVjH?=
 =?iso-8859-1?Q?DYZdXLB6nGDKhd4EfcpTBdJ9mxFllFFYOBcdB3vGoSe/jp87DLXmcUJGm6?=
 =?iso-8859-1?Q?qKcRiPCV+4lFFEk8VkEsu+Ro+/K3HAJcq+1MsrSHm/y9IttXbql9GbZfrH?=
 =?iso-8859-1?Q?dD9/A6U1qjDrXfrq0mkA7QwNlwYuG4yNlSzUwE3h0oZiQqMxRLzKTQ6+Nv?=
 =?iso-8859-1?Q?9AausVo4U4WNrasWPiUG5dS98XVCGkVuOAeoqkQjBD6z+m9BPPh2vbsA98?=
 =?iso-8859-1?Q?WJLwuL6+5aGb3+QLnAFNlRupIgTSWT6pg4Ed+5CO+IGhwwywaWPMZ4IN02?=
 =?iso-8859-1?Q?/5nTe/ZZqWa1Mqn9hfMKV5xDgiZGXB/M6Yb8N/1x1HkbBRzJ6jbHChm4yu?=
 =?iso-8859-1?Q?JFdFCbO91fUEU7BECm43Q1Q7XrdNkg7lOZ/HI6LNIvsLHd8oG6NnXJ7nSg?=
 =?iso-8859-1?Q?OTGxxcd/SZEQUn2sU2XEVksHi8wSPMWZrOEaX1HzxiJqpz0rgIv0VHGQc8?=
 =?iso-8859-1?Q?I0uC6RS+x5xhvdbCiP3ijLfCDhPch2fsnHh57sBhvYx2coVwlZTOXC/pYg?=
 =?iso-8859-1?Q?kV9y8T7SRBmmwtR1tRn0bASfZaopyuUTQ1Lr4MEoKWvkyQNEP04UmLDU/c?=
 =?iso-8859-1?Q?11LjrrzVhOkqsuT+OWK20FdZUFWVsaV3eWA82RL+7wiGedX9rkDxOq8oCj?=
 =?iso-8859-1?Q?MsRPsjuBQanvJzoBwEHgaSEpLrmL9bQmid/l2mW47E4MQnJ+rVHaPCcoV3?=
 =?iso-8859-1?Q?0HOpA90wf71Y1ZFhHJE7JCIzugbemr2QbEgur/x5B+DL3hWiQN3LVAy20X?=
 =?iso-8859-1?Q?uiGaMDUlBwaKDnYAUMunYxFHYeh4WiOTbaNYytetjLjl8H/gcaXHBeCrFL?=
 =?iso-8859-1?Q?LKta+2uE5Ch5zk9WGcaVl4c+h2ya9R4+gfm7KECQxgCzHlPtBpwIXuPY95?=
 =?iso-8859-1?Q?D4nIzahZahm1LgqPfeNuQ+m1P7aN84CubbW6fqlFVgnT7mDMihzwozDaPC?=
 =?iso-8859-1?Q?i/fo24sXbI+Zir1hc4FLcS4boezHfZsqnQOMxbe10lvRQ15ARHUvfqbtaA?=
 =?iso-8859-1?Q?/PweCBWoLNuG4pjR86QSSwn8fEMifHM1SmbgX5cq7V9kOKDseapdOPKgZj?=
 =?iso-8859-1?Q?iAkbw8qe0emQ9Jy1GxxY7io7AqbGUbJYaCY1f8ib/7xqyoq0fMOJPpv1vY?=
 =?iso-8859-1?Q?iITpq6LzWQtovt9vXuKOltkGs6rZjVm4skVHQ67nURQSXMjkq7jpfgD40Q?=
 =?iso-8859-1?Q?TkasXuBsNpI2rjTelY7DKgNOr6g1c8vDhrEdxBEMLr273wsXuYSr/8OrSz?=
 =?iso-8859-1?Q?cw7ScI3efudR2wrazS4kvHjPhCDEFCLSvhs7PaMooUGAlkjsj8sLJI0zxc?=
 =?iso-8859-1?Q?CGHtJ2t9glq6x0Cfizp/PrhFopjKOVujbx/9QcyUdl0BfGh6fHBxeLA+q7?=
 =?iso-8859-1?Q?YrA1U/DnJr3lq872jGTsEMv6q9IR3d1xTunkPga2LnssmARq802Wxn6C2M?=
 =?iso-8859-1?Q?9HmVkDlpRMMgbqzt1syk7GEc8SlQoSb5vNUaKBBb51rClAXZA1cYttLPSo?=
 =?iso-8859-1?Q?Y4/UZzGkBuJu1PS9YoZEuuklHNklmbOoSmrD6VmgpS18mxS5ko8YH+Lal0?=
 =?iso-8859-1?Q?DGbxg6LmhPSseIfPTQMv9KnyKYVap1hEb7?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a4dc3d-a4cb-4ad2-2c8d-08db21bf4043
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 23:29:10.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/KqHbSmTxhojrGk7EHout3TiyKz0suAP4NR6Xp+wsyuXbdu8LJuF4j2RAnjRbJsvWqR/EjlVpFKLhAFHHERdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB7458
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 07:48:15PM +0100, Uwe Kleine-König wrote:
> [To += Jeff LaBundy]
> 
> On Tue, Feb 28, 2023 at 02:55:07PM +0100, Uwe Kleine-König wrote:
> > The driver only supports normal polarity. Complete the implementation of
> > .get_state() by setting .polarity accordingly.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I think we should apply this patch as a fix to prevent similar failures
> as reported for the meson driver. To justify that:
> 
> Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
