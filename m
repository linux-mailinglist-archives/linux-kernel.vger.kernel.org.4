Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0522D65A687
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 21:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbiLaUBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 15:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLaUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 15:01:23 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2091.outbound.protection.outlook.com [40.107.10.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B563BE;
        Sat, 31 Dec 2022 12:01:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnbmcqx8avem+0RyARd3aW0o30oVzYiIeh/k7vpkQnp+VyUlpFgcjPdr+tQijV7MUp97srGD1FOx5spVH5qskZ/g92LFyBh1NFJwrZU5V5gMZGjE4E1OppCVItg9LV1l/3S0z6Nt7oVXTzU6h+/owYqNxzlfRrY0xmiG6ZQeQ0WYKw+/q6oxCzyx4siPb3hyojbfnnyKmgrkDpxVK5A0v4if2ATxAWumqEXrCrEuDQSy4lnt9lbHlPunPzX6ZAspE5KoHqeZubfydADfsvsC9Z9qZ4BfgGkUR8kNYDtO7coxrqOCWsmMvNqhZGODttBj16aAqn2kX4QV+Zpgr+flvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZWpisZcCCJaQKmScbrtlwAxjyQV5Ndgw8wGrrgDSGM=;
 b=Uj4VAZHqnOb8OVQMLQlWc0ixucuIuyOUSfoykQtVlJIS2kKx8I0GxNI5w7SKOBCipOUzc8gBHUhvTr0hvh5CkJKPFmFX0rqWkGEg0tmzyjTJPKx8XaQ149WKp/U3vF33iW+YBksAVAfcnyewZnIsnNa5kQGUeGruSfgiQxaYA5g02B0NHsDFLX2If4119ykdjpX/SHraVo+4Y59QMUUQb5FsKU5tOAoQ2ZfApKrhyfsUHr+QfPUv29aIuY4f6c8tGiiQxUtlXIZ2H6YWjJmEXBxuj70OfuKHpGi1qMhin1CLT6H9ja59buIZV2nxtbhw3saAe1JGQcIHaEwnAWAsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZWpisZcCCJaQKmScbrtlwAxjyQV5Ndgw8wGrrgDSGM=;
 b=gOOZa8bQ+6bJ3nxkk1JKAwaSlKdVWu2hH/QXZIxtMUf+ePJMIOCAsrR5qTKsgDDAknff9G6JdARMmMo37F43y4wdoUEcXtYRs0/jfYyhFeZHgozUR1+W4h+ZFztzGU4BymFNIOBImYq9TrAOD3L7+N+PAFoLEV1O3QGhLuzHzWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2545.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 20:01:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 20:01:20 +0000
Date:   Sat, 31 Dec 2022 20:01:19 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?B?Qmo=?= =?UTF-8?B?w7Zybg==?= Roy Baron 
        <bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] kbuild: specify output names separately for each
 emission type from rustc
Message-ID: <20221231200119.227f622d.gary@garyguo.net>
In-Reply-To: <20221231064203.1623793-2-masahiroy@kernel.org>
References: <20221231064203.1623793-1-masahiroy@kernel.org>
        <20221231064203.1623793-2-masahiroy@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0681.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2545:EE_
X-MS-Office365-Filtering-Correlation-Id: 25576835-f255-47f2-2333-08daeb69c949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dpvgMDPlOiqdky8ruZYDe5duSlqFWwgDGpThPLsuYkkwkMgNDF4l8VbzKI9XMeipK8t8Ok7vuQiKgpBohPPYAje+FBFFZHKZSfRCRv5frXNzmOkZ3WbjhdMIp/o6tveR0EEQEjDD7nIQnNw99oXyGTuOwj0XTF+9vRTzG0UjAfUyX5B5sNev5ZBfY0PJ4nDTHXyd6X3+xh3lfqD7o51R8f+nZvvKaPMMJO1iU+n/7ogCWxrywoExkjS0H6IBQJRWJMSe8YnXTNnclHeaVMioQIQKyyyr0jMpZxSahhYw+gDTiOGSzmMCqBLswbJtCvgfSfGZb9kTHj6mbQ8bIj4XH+r9w9On0xEir8AWhG/RWWofhYGdEL9V6wsxl/0yj3IIzgXx/FVRcQ6ozVgVuSlevKSpE/XqDspTWz14r25iL/EfF6v7DskjLofErpn/U9cWMHbSmhAM3bUb0qKjNIiqG1vstFfVTvgw3Mk/Ua+w/qgqFS1trQPsGbHzsKooqJeuFDZqs8v7LeJuoqNvUwhn1QbBYquA5HlIhjuXrsAwUW6f9un3rZel/ftsNvwgdZC33b5MsdxRu0Yhc6pxAJXoXtPpgTmwyqntzFmF8vyvjaUVt4RB7oqPP1CkjSw3iJ4i3zEXpHG3VPJuYUa/HvJgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(39830400003)(136003)(376002)(396003)(366004)(451199015)(41300700001)(66556008)(66476007)(66946007)(5660300002)(7416002)(2906002)(6916009)(8676002)(8936002)(4326008)(54906003)(6486002)(478600001)(26005)(186003)(55236004)(6512007)(6506007)(2616005)(1076003)(38100700002)(316002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jbbuHtAkkmluhmZDVFxSPHLzd+3N3mBBvJD+aGLpzLHjTrXRjQwLl+zpMzoT?=
 =?us-ascii?Q?U88f/vpVxmW9dOc9o84qw4jQZLwRRlroqDOdGZMG+WMQT8OMS/gUP6BRBH2Y?=
 =?us-ascii?Q?0u/iaU+b1c+0hkpn4arQbbnlVT9z/YjfkAgFOjxnoU5egKstQWUZmVBo9tkX?=
 =?us-ascii?Q?sSuO71B1LMJrXbcENR20YfGUzaNmoc3ifCM5LtIk4gywyY+xuVxfEUYi3T18?=
 =?us-ascii?Q?Z6ovCPv47PNVPig6/nxcCFXxrhKWbsprj26TIlVptQce51dIaJque6QXBH6E?=
 =?us-ascii?Q?47iS+cmtoRofFvejvA3qetezYaIUcx2UBbP1HHnbnNzrn8ttO/0+QNEuXiJs?=
 =?us-ascii?Q?bXtnRfDZk84jJ2btqq+5mApsHN0y3tWce/QIhwL9/u0vzkCkfPKnJ593EX1+?=
 =?us-ascii?Q?GZh8rE48cr982bAJaZonEw+tG/dY/XavxGn8u1qSWpEOkJ4DIJ6Tt0u8F+be?=
 =?us-ascii?Q?z9LgYbqEQ49UGNHR/gzgL4KIgJyMb5Yfc4N7/l8oVJ+6yt5TLJGQeThdMCvG?=
 =?us-ascii?Q?j3ZwOAz8WorR/3lgXTwHM8QKo+K39nAIc7DuX0gHF9FMt5j4m0pm23SQcW8K?=
 =?us-ascii?Q?wkCyeIyuTvSr5hopqAwriRuttBNRsn3rJS2NNGwqWn3ceqKk1XUm1sFIC7jX?=
 =?us-ascii?Q?8jqScPRvPfksAzu6zMtM9e/FNDMfKBZDcikKbMYTOr2Q0eVkbYTwmmqNNUfk?=
 =?us-ascii?Q?xU+eoxmoTi+3aYhV7r297qxMfy66aEfCKiyP9LKq+7xFsPZu97jOE8oxvIcN?=
 =?us-ascii?Q?sQieO2ZMA6BzydtJrfkWWOlVaNxETo2V+ypgNAbODrAVN9klpXd8ofPhOnKo?=
 =?us-ascii?Q?xMCwSU1wfSILNMxuBbuh6vqLqvOqUKbxyecuzm5EjqFEOiwZZLatimtA9Soy?=
 =?us-ascii?Q?i31hP6L9uNaVz5emEzZKBDJ7dTs6tuUM8QeIwAwRwe0uB6Yd4MENCUhxW+EN?=
 =?us-ascii?Q?ip57/Lz90yYzYdmg6SPjdR89T0Lgf6td7l1XLMU4AVxXoVrAQC4K0F7ddeEw?=
 =?us-ascii?Q?7f62+dSznCPhedjecJdY5lAEsOmp8+KYGX8TdH0XzSJ0hZaD9935l4oGU65w?=
 =?us-ascii?Q?iqtrxw32bmYinRAoHx2Q7KfuFMk8iOif/uOqDydJdu5nHINES9XU+v9fRQaW?=
 =?us-ascii?Q?12eqWev2W7lOblyklTxG/R//+cY4wVK7S8RxKva7fr6AB4XQZrNy/GJxhosU?=
 =?us-ascii?Q?yj7Ui3pq6qxdjO06AliOiTG3rwaVxe+Vugm+pXNH2EjvYm8EgyZJLtRc09pb?=
 =?us-ascii?Q?t3rPajqcYUrAJxnbYj5Jaghwi3NNizYGC0o/LFbJRFIoklcrrO6SJStz47D2?=
 =?us-ascii?Q?2IKOO0r8+vyOw+Gvjn0Pgxa60QmKLT8y5fJA9jk46ORsZkhWhkn7SU9kue+i?=
 =?us-ascii?Q?N/WbdKEvZhrhbPNepTu72tMxZEnMhKgOVKsXgl3rWpTtpUaCVRub2d/H7Bc+?=
 =?us-ascii?Q?QtodAYWHMrfPI5YadPdUtexyBOi6eb0ZA0chwYbkjfF4I7tCPvjopqgDF9vS?=
 =?us-ascii?Q?AGwJEBGP8xEf9kWDqgS7jgTHkHh6+Rw9E/0dNupGt3WztRtFaGAcZo+hOdWo?=
 =?us-ascii?Q?PNfpBKwrIiz9/QqhbfNXRqLDGakTLsI0/umitUuc?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 25576835-f255-47f2-2333-08daeb69c949
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 20:01:20.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXZcwZAgBrk1VzVztbVIa2K+ZGXdgsBd6YZNkmMTaUlJKGgl28bY/G+Zv3wH2fKrXmcF1sczOTbrPlkPqz4eOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2545
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2022 15:41:58 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index da133780b751..4434cdbf7b8e 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -84,8 +84,8 @@ _hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
>                   $(HOSTCFLAGS_$(target-stem).o)
>  _hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
>                   $(HOSTCXXFLAGS_$(target-stem).o)
> -_hostrust_flags = $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
> -                  $(HOSTRUSTFLAGS_$(target-stem))
> +hostrust_flags = $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
> +                  $(HOSTRUSTFLAGS_$(target-stem)) --emit=dep-info=$(depfile)
>  
>  # $(objtree)/$(obj) for including generated headers from checkin source files
>  ifeq ($(KBUILD_EXTMOD),)
> @@ -97,7 +97,6 @@ endif
>  
>  hostc_flags    = -Wp,-MMD,$(depfile) $(_hostc_flags)
>  hostcxx_flags  = -Wp,-MMD,$(depfile) $(_hostcxx_flags)
> -hostrust_flags = $(_hostrust_flags)

Would it be better to have `--emit=dep-info=$(depfile)` added here
instead so that it mimics c/cxx flags?

>  
>  #####
>  # Compile programs on the host
> @@ -149,9 +148,7 @@ $(host-cxxobjs): $(obj)/%.o: $(src)/%.cc FORCE
>  # host-rust -> Executable
>  quiet_cmd_host-rust	= HOSTRUSTC $@
>        cmd_host-rust	= \
> -	$(HOSTRUSTC) $(hostrust_flags) --emit=dep-info,link \
> -		--out-dir=$(obj)/ $<; \
> -	mv $(obj)/$(target-stem).d $(depfile); \
> +	$(HOSTRUSTC) $(hostrust_flags) --emit=link=$@ $<; \
>  	sed -i '/^\#/d' $(depfile)
>  $(host-rust): $(obj)/%: $(src)/%.rs FORCE
>  	$(call if_changed_dep,host-rust)

Best,
Gary

