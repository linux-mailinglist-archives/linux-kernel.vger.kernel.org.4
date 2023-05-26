Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02F371293F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243920AbjEZPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243956AbjEZPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:18:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76700189;
        Fri, 26 May 2023 08:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhikdtjRZq2QPR3uo4nPh4vuQM0Th8jvosdx8OcdyVCx0YNzNQHQr7jrs2zn6+UgvvI4O9JF30a7G9GwClmXOGDPdxgAS55gM2v+qxDrln3EhiN+rd0JtFhDf7KbUX2kHKSjfD09XpsP+AQDbdlNKk3Yq5cIIdPAdSMkgWRga8xJ7gLfHMHZWiRQWCkyNvaZro+3vleYSHXb6ootVoM4NnVMsuPQvMb496O7NY2VjBwDteSyjgocZ8qaaBBEhqQOedmZoJk2AoYzXCKyYTjiUOOty3nnHVZ2n6Emq4Ubkue8ZbPw04G7UKGnJxsxZD5RblBP559mSssZAV/ixyEahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiI/HWKXnaOx8H9kMjTBdFgt8b76HgkLrN6/Tc82JK8=;
 b=A72MuD1OrQ//qCQXMPRlxOptthh43/8qDJrm8yU7bN9XhHV/2amehSEyHYkI2nn8prb7RdWlQLzex6UgI50j3hWOQJYP2QKxxMg7GfY3VZ3E5Zg8uiftg1RCcVyPoKn1Xwl425cwC98yPS6GNaO2KZVfz41QsqUij+poyyx8gk4zFKC1o0CFiMQXJVk17CkUYt1INbtQWTifa5fHjtGqPTXKcVK3oauC3hxR4phIgqMCpYtNYR20iOkRdoMKAliYxV2g7x3gPiCRAdM8Hsgr7GGg1fYY1J7ytG8iSZe8DSaYJraDdRUG9jX4QKDzcUXb2tf28mowkFsjOki007z5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiI/HWKXnaOx8H9kMjTBdFgt8b76HgkLrN6/Tc82JK8=;
 b=WSS3iyIXqM36uBOL2OYySEvnbtjMXKnK4D/ceuNkptwYUDFReczQ1DXbi8iYRJyLCGhtoZgpnF0aMOWERheBh5WTB3+Gn42GwKqyX/zu7w38KNlO0MuosCe3UsbKSaXrHW/2XfT8DN7n7oJIxun4e2hiuh+vz3pbrD6pio9nE3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by DU2PR03MB7863.eurprd03.prod.outlook.com (2603:10a6:10:2d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 15:18:47 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934%6]) with mapi id 15.20.6433.016; Fri, 26 May 2023
 15:18:47 +0000
Date:   Fri, 26 May 2023 17:18:45 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
Message-ID: <20230526171845.698656a5@nowhere>
In-Reply-To: <CAO7JXPhDCzJOvanKG=04wU3Q=C6GRW=+t2Zq6GmuQvfutjE8PA@mail.gmail.com>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
        <20230515025716.316888-3-vineeth@bitbyteword.org>
        <20230515100616.33ba5dd9@luca64>
        <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
        <20230516093729.0771938c@luca64>
        <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
        <20230519115621.2b3f75e2@luca64>
        <20230519121804.6c85a3ed@luca64>
        <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com>
        <20230520115857.3838a7ea@nowhere>
        <CAO7JXPgXi8q02HBeBR_RLWmODd9uQBH_UMCYgVQwbf+FX=Qxkg@mail.gmail.com>
        <20230523225831.60d75b38@nowhere>
        <CAO7JXPihFGX5Dop=ox3YDQ=8aQbzZ-ka_1h3hT1G46vsbxpzNw@mail.gmail.com>
        <CAO7JXPhDCzJOvanKG=04wU3Q=C6GRW=+t2Zq6GmuQvfutjE8PA@mail.gmail.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|DU2PR03MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b2105c-4226-413c-32b6-08db5dfc80bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gd71YbXu+XK/BcM0XQvpVxgOVPwCq6mOZPYTD8/jnQGIdgpfiay1Kh9I0DoQQw9+9H5u6DZI+vWpTL6fjpFTctahbvqUOSTss00ku/1wfklHs18F61BhLs3A5SoC7wuwCaW6pdi6Dbb+xetXBoMmYZuCv0Ma4QGfm5sQWqr8y0hfQZlhqX2VkUW/IMbVBlcI+yq81WguC1do72mGQbss/NdL2xkai3WORzitXONLh78b9bsRhtQJ1+Kgjz360c+lmodk8UVUvUHVraLeYRWtTZ7c+81gmmSlSb8W7iJ3PCK/kDDu1kUoTzQIAXM6B78QT6zDhoW07s5zLIyGr7bQGF5mfi5aUTzdGjxiG/5MpzJe4spemLIPtt1XCFM7AA21wOyV4P0UQmpPkwFBh1XaiNYxlJ5OlpNRgT2p1Onzr22eFrUZq4vvoP02NFhbrbujLf/ZIveBpU4cMwFftk5CGxYCZJfrucKxqUOW4nE4GI3XaqqEc9nnGu7TmQ07cbNLSmTx1KKrksrzYGM5pv9eWiIo16Zd4OuclRmu3e52JXLNCjoxzJCBSnb45aFIMjOB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(376002)(396003)(346002)(366004)(39850400004)(451199021)(38100700002)(7416002)(33716001)(8676002)(8936002)(5660300002)(478600001)(54906003)(41320700001)(6486002)(316002)(786003)(41300700001)(36916002)(83380400001)(6916009)(4326008)(66946007)(66476007)(66556008)(2906002)(4744005)(186003)(86362001)(26005)(1076003)(9686003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D3eYBKJXRUq+Bue1ncpugsP5jYD9l4jspLlcUDTdAJfrO9uHNOOlHVIM4/U7?=
 =?us-ascii?Q?RUSJM/OENKADVzyG5OaQJ90RXMLQb+wvLv1WJYBtKnnOBz//y9RJEhDS5Bnh?=
 =?us-ascii?Q?juTLTgMtQBIy2aJe0M8iBNsmILikd47zOiLmbq6p6xVBs+m8dYFRi7O1Qb8O?=
 =?us-ascii?Q?Xj27s8jP2zoPlRrK+PHXWT0hP6p6A/I5vFtecwIBh5HLs9qpbBaI4mOHsigD?=
 =?us-ascii?Q?jAyppl3uJUjuhnWteEh9fdq0YUVrbOv/N8/rVE1iZdzKyVGhfhH+6lOi3Lda?=
 =?us-ascii?Q?bAj2coe5AYv31V8sqxoMUmVNm4zh+6cU86B65vKKshurfH13haAXjF6JiQsE?=
 =?us-ascii?Q?FCcnhCGi93GaSLpJhdbYQwF8OvABDOJpkrfunNhb7KvYu0dCzDgz/y38c8Nf?=
 =?us-ascii?Q?ex6ysXSrZWjIijl0GL0UrxIbkegbGVSn0o+u+2tDkChtUkg6HP8G8Agr2Uyb?=
 =?us-ascii?Q?lOJmpyd/PUgVJqhH2bc5/X+QHkp3Tg4XYLkdJ7sL9ymOijBkUdEPBXkyfMzH?=
 =?us-ascii?Q?VEvd5qlKAX7x/N2N1cGXcOLwGbjeUzIN7T5RwQ1jvUKX4pJWqyz1Mt/2DT9b?=
 =?us-ascii?Q?pY+Flsrp76EZGzyu/LNMbj8QWUSZH93wzeCXGdHXP2uFOIdG5CcBAvFc0ksh?=
 =?us-ascii?Q?Y5knK+oFwrzTiv5y+rmjIiVQOWUbCVpw3mLHavK7zQtzWmhKSax9+9OTZpQB?=
 =?us-ascii?Q?MbDAYA61JiR61ULqQUvI26ivbnNdyFPNCb0K08DgDhO2iuqyG4tJbKBplw47?=
 =?us-ascii?Q?6M0xBYfd8sW/XICePYfsc3VFG4SI0zDQD9iiqj5E12YeKUYNveD/JD83VpNF?=
 =?us-ascii?Q?b15Lp4Ayaj3fSuYJ4A7Ldnzr4SY+PcLNsc+mvkEqAp7Pn2P7nJOJQuLNK1mE?=
 =?us-ascii?Q?u6e/Z+ocU2X/sYskUwNgaqWNCoDwokW7LUEjAjzS/jfKgZRGmzxXijWBjYvs?=
 =?us-ascii?Q?uxzfD/O0p/Y1g0rWgO6McbPmsVzx8zYtu5JS+2BItK0XdWpTsZVdfdk8u91l?=
 =?us-ascii?Q?PDWhbH6FbJeQaLS0DlXHKheWF9XqY600QnK9jiZTP7I8rU9B/DlyZdRZcE33?=
 =?us-ascii?Q?CkDEBfl9xb8jOZHX92L3CchRRJep37Eh2/DYtqiCkpkP42N5l12nekDoOivo?=
 =?us-ascii?Q?DEQO5fhcgTYdifgvPhuZlmCIj6MIxxeaFcsxraT7vdPMNFCD+X5Crq00YH1w?=
 =?us-ascii?Q?LU5s4ctqaD82GLO7kp4RdI+xDzGyNkJk1r83JrUfegGzOYJZjz/TLPTpB4R0?=
 =?us-ascii?Q?+AGS70KQXigDruoCK/PKLFpDV/xnqV7UJhJosejZgI/nefAzUz6uzaq0a3aj?=
 =?us-ascii?Q?HIuxu+1yg1ujHvr1RE5Lg2HWMTS2T0aG+TOPsPsLPLoGVibmQWTdLXrgkID2?=
 =?us-ascii?Q?nge2LgBPENarLVrCBfwh9I1hNH/hlhh9oT/AbsM/X7Bul+9iQ2yoUPZf1t76?=
 =?us-ascii?Q?VzCUejQKoBsiQu7gCASxcAZMrkPJmHZ1Z/m3tXXbS7qty7Xa96h5mVt4NtLu?=
 =?us-ascii?Q?cZmmyF2g+vedSF9kZ/B8BbnrPeSqHcR9KMJ3iRC3ggSxRg9JQOnVhnpIhoes?=
 =?us-ascii?Q?hw+TKsFDT4NB+w8P6F9Pnw2IKM7gTwlp5Yfv9sYvsNaP+/5BvFCTaW8J0Zqu?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b2105c-4226-413c-32b6-08db5dfc80bf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 15:18:47.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyIMAJ75yZ3f8+GqBiW3izhg0V9Ih2zuLsLqW/wx77L5lanvBRhjrCsWNQllNmlg504C7m145cOh5LE/YzgmGfh+Kr9epJOVz2qBzatNFSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 10:54:09 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
[...]
> Sorry for the delay. I was trying to fix the inaccuracy when normal
> and SCHED_FLAG_RECLAIM tasks are present. Its a bit complicated than
> I initially thought as Umax_reclaim and Uextra needs to be computed
> at the root domain level and this would mean more locking. I have a
> patch ready but I think I need to do more testing to understand the
> performance implications and it is better to batch it as a separate
> series.
> 
> So, I am just sending out the GRUB equation fix which is tested well
> and I am confident about. Will send out rest of the fixes later as
> a separate series.

Looks good to me. And... Thanks again for taking care of this issue!


			Luca
