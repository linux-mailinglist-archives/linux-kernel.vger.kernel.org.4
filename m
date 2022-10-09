Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C6A5F89E2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJIHKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIHKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:10:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60123.outbound.protection.outlook.com [40.107.6.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2CE012;
        Sun,  9 Oct 2022 00:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KONSHRUhEjQXPPRoXZ3yr+IvGSSFxvrbFfVQKURhBgbbE6CxzToYSASpkpBTGo+4vdMMt33CeoXLX7S5uyIMMO+rS24a7ThKsmzALsEsZPm/qSwQ5hs8hpUrUfKQVwU/+Lzo0On4UvgLrPu4oYWSyWDrF73YmQAagHj3M83VZRtrAuQn9dIiSymWdJfYOREQfgp/U+psKorv/AvQvyKKhwtWYTGyaNZDNZ3K2Ndxb3WiRRzuilLQBfRhS6bHT/WNtMIsJ2hVRLkuahKgtskZXGpiF3lfOCkHpUdjuxsfGpwu1VKY4UaP13f+5ttQLn68rsZYQfteTWgBY5OzUbohsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2539CxAR2IL3/3hUPmE/uOaHi0hPoYMk9TtVL2+BZA=;
 b=VDApId7lwahI/eUGt81HHmbtWZovvemxYvo3e05zyxqeaWXBKONPEQH0GBXcWBmxl2eRnjHwTVI7JAwTK9QXB8Eo02sKfJVmzspHf7QLeEtjP+c4PIei62vyuARpZRdc4g9JHWDC25YFtuD370VTxn71El9YAEtLP1fj5e3Pge29IPW471CbyocetJ3J9gij2ZtGPxuKSSoLmqXyD5ucgPE80SxIiFXueibNABMDMSOqu9XfiH23LE/FcqW6xtyQ30CQQN3MAUxpRmO0/U45x6bVAt/KGonqbxyAhPeMwfx21awns3Bww4hp4kEc+VIPlmLqKvQC16JqLXCn+Ql88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2539CxAR2IL3/3hUPmE/uOaHi0hPoYMk9TtVL2+BZA=;
 b=fjHm870PgRFoe812wnBJBxlkMszQb3CU/2DtNRbq5YI+Qgd1VB/57u70eN+wdOxkSWcD+LRu4mcRtLPmAFM5sjgtwxuiZcbp5JnTnTXaAjiOUUTndjdLOhcw7gcnseNO/Ie9cfF0QAtrZtf2t258dVj/wwXFeUqkPoEWZ5mMVsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PAXP190MB1743.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Sun, 9 Oct
 2022 07:10:25 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404%3]) with mapi id 15.20.5709.015; Sun, 9 Oct 2022
 07:10:25 +0000
Date:   Sun, 09 Oct 2022 10:10:22 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH] usb: ehci-orion: Extend DMA mask to 64 bit for AC5
 platform
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Elad Nachman <enachman@marvell.com>,
        Yuval Shaia <yshaia@marvell.com>
In-Reply-To: <Yz8r8w54FDGD4DaF@kroah.com>
References: <20221006095257.6934-1-vadym.kochan@plvision.eu>
        <Yz8r8w54FDGD4DaF@kroah.com>
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
Message-ID: <VI1P190MB0317953071A57D17773267B295219@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PAXP190MB1743:EE_
X-MS-Office365-Filtering-Correlation-Id: eb840bca-fd9d-4a15-2dce-08daa9c55635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /erAhMTpmqem8ucTx+Ngjh2OYqz+meQj8Sb+H3v9alQB4gQWzcypEVEYo4NpWs/1YPR5KGgQIiFsklZ3E1LgBAy9shRggnZiwJKkZgJWIvmOuYrQBu+e37+hkM+MRKaD8mCm1BY0EnlMxrArKccNUp5FQrneHv08j2eTVh+pGJE+VSqV3P4YjMQbSEFbCZtbEGVxRLRrQvDX2TUrSUT+5WXx/RQXV2U0NOPYWt5RiCziOUf0SKmh1ZYFdXmOHarn7M+6upNUMY0pznxKSfDQUv2RgurjRALSCaqokwtU8ZVvthRv+grejaHa9WkPPV+C1+/WgdxvRe1WWxvvm5NQRc8qzukD/H+Pvvz5+D6XjsSBn8a5LA12uHXH1HxzKutmhIsagMXUvKy39iGtFRkVfpVhpXJL2N5uqX03g2Mjt+2Anj+S6XWC9/gbpUHtB0XY5pmwXtlKuTTjPQfGtVjWIwep/Kx7BEX4tb4o7eLO72bzzzejbbhitUkJ1e0BwCoONTx0E1WdqdJAeLmminQPBo1Unu3i4z1bZ/H0fIORjGuxtf4jss/zlEzsLKkgbcjBp3hHel0wNhgzhvpihXvG3vDYmSDeoBxUNQ7zP1QveawDtMaMSZXJYtsYBEsdBsO7J8dqT28r1wygQDnl0kE9wTyAFbT6Cmayrux1tpqICdi7Ry+QwLVMiHCsLxT1cBHDK6AyHSIbKqzOs+ncjBRaZEFIK6qn4NNx5+0Zhq4k6PChGK+6IrkSRTNLlkJvyuOuV7HiXUi3cLKnVnat4Nf5yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(396003)(39830400003)(451199015)(66946007)(33656002)(316002)(86362001)(2906002)(41300700001)(66476007)(6916009)(54906003)(26005)(66556008)(38350700002)(186003)(55016003)(4326008)(6666004)(52116002)(38100700002)(6506007)(8676002)(478600001)(52536014)(9686003)(4744005)(5660300002)(8936002)(7696005)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TLEXYE1jpuZenPZ5zbO4vknnvzS7d7hW1A10ZAR8d4cUbRCyP83Jgocq/LRF?=
 =?us-ascii?Q?88Lzdaw8wHv+VJl84dMh0P8c1ftyO8tZGH3dgzqFROINe56gZNpr3+cnOIRQ?=
 =?us-ascii?Q?GPDtAhWF24KPFfJB0HIsf/HLmeWx3wNrvxxXJBHkFUKU5fqiE8sw5t4myZhk?=
 =?us-ascii?Q?KazAth3ZcpGzZ+qufX3zu+M1+Kr+wOaiRtJ3aymZGeqBAJZkyu7Wat6YGjkP?=
 =?us-ascii?Q?QaYfb5pOOMIWauGtIv4LeOeYb3f9zLhg92HjW4mGUDsM5iP7FopXlQvMYdwR?=
 =?us-ascii?Q?2lt5X5/S8RYU3ndjWavZFL64UVExt2Sb185cB184E1oVlBCCnGrJyJ+sAO21?=
 =?us-ascii?Q?HKuzgkC91Swjr3Z5FN7btuoF23u9eRG0GVUKxN0aAbt4NKQNXmXnVNkA28Yh?=
 =?us-ascii?Q?r5nnYpun0aGqJ8B/0R+EbpEPCCmbXJ//y4a3+xOISC9Q0hVk53RCn7Yx728t?=
 =?us-ascii?Q?yhamhum9b8kyRfzKbrF711Ab9QWvZa9ngJuZxaFuhbZCyofDC+dxe1KlCFfN?=
 =?us-ascii?Q?V9ZsesYY6hDXfKHS/5YmRuhXGOD1aVwrte8FPN5lwdMOhAddM4We23aSkkuL?=
 =?us-ascii?Q?Oly9nccmXSxGeOsl/9+9mnHayehe3rJTrwACZQNRU1v9PM9fKUZA3TqE+la1?=
 =?us-ascii?Q?zoHTpLkUQE1QQWWlHAwsuMGubDvNNj4xd4F4ATJb1558TiTlHqaqUTQCx9jQ?=
 =?us-ascii?Q?4DZtWdjqqPEWp/LL6xqrIsMXq1te2gTT0jWzDHzYSDJqdP/bLrmW5HGF6CGL?=
 =?us-ascii?Q?kxeso/2mRDxtZ2PXhkCJz6sNRcyWPN505P47bG9bcAMb8CDlLGtWZr5F/Cv5?=
 =?us-ascii?Q?T5uryfyAoJ00Wt2pazjyDWuxRXYTKRwkKVizcTi3DwxJ+2hLGbv+o2pvymQG?=
 =?us-ascii?Q?5BQY4LWu+0fFDrz2lsWr4jSPyenIRSJQxv5SnOZk3Vl4MUJP3WJSASinOc8f?=
 =?us-ascii?Q?TVlP7XKPAVuAmfzqjqu1PBGc92BgJ7jcv/hLQnAdvS+clyItQ2Tv/V5BkXtV?=
 =?us-ascii?Q?kXvsYUcksqHb6RFZtiI4Pdk6An6lQd4KbhTQUVj4GbXq3ZB6PSV3M/ynECk7?=
 =?us-ascii?Q?Y6Jgn5QhwTnkDUhkG8i4MF5qt00XMWM0WSkskCw6hb1TL4Rgggq7MaGETMeN?=
 =?us-ascii?Q?EjqXK4k1HbpdVcUWDwh6gcAq3Na8SB37D8Mzw9d3kAN67amZ4oAsxdn0fLPX?=
 =?us-ascii?Q?5DAVlgSb8ovx194AX8tiu43nPQEUZKvFcf6aIP31UwQG9bR2dLqdMoeX5QA4?=
 =?us-ascii?Q?4IMQWZNyZQJQh8DTiPoPZo8p0ER1TiqDbp2IV2Es7VGQRJ3bsKYiobBDHMZU?=
 =?us-ascii?Q?BLG+x2wA5uPHE71e1IVXDA5OhCnxwOt1RPzKAihLq1lvcV8pyDmufOy+G9iI?=
 =?us-ascii?Q?Qmc0cCHUDDT2eDF22OO59Oa67pE+6KroMEhiFlLiG6Qgx0IJGA6DAkCqmO5P?=
 =?us-ascii?Q?n1JxZBiibMRgFzdC0HCjHWrJDcntHaNqhISswy+bwwmdO3/kBINWcskxC2iH?=
 =?us-ascii?Q?uVw1myadCxJQN9JUNNOXa7OmwbwxRxctjox+3z7DDAh+d0U7LBno0AxNmFDU?=
 =?us-ascii?Q?L3HMuGVF0dQm6duINXk+n4mkVgBjKZpmKORuzpVpbcJKwGG9pHHJFBdTM20O?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb840bca-fd9d-4a15-2dce-08daa9c55635
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:10:24.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhU5cFM1Dz8pABCTE45gRoByA1+Ih51LTuSgSMd3w79Vh4EUcLp5x3TvSJGkkAO/t8zw5EXX4VTmvA/xkGbyk7q5YOAdgEwwRTsbhXS7nZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1743
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Greg,

On Thu, 6 Oct 2022 21:26:43 +0200, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Thu, Oct 06, 2022 at 12:52:57PM +0300, Vadym Kochan wrote:
> > From: Elad Nachman <enachman@marvell.com>
> > 
> > Signed-off-by: Elad Nachman <enachman@marvell.com>
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> 
> For obvious reasons, I can't take patches without any changelog text.
> Nor would you want me to do so.  Please read the documentation for how
> to write a good changelog text.

Sorry for that.

> 
> thanks,
> 
> greg k-h

The AC5 is a 64-bit SoC, from my understanding  - for 32-bit
system the 64-bit mask should be truncated to 32-bit.

Regards,
Vadym
