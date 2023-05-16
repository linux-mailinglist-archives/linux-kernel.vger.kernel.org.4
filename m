Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BC270558A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjEPR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEPR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:58:11 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7AE2681
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:58:09 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 34GHvGEX077709
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 16 May 2023 10:57:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 34GHvGEX077709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023051001; t=1684259838;
        bh=MlQIRvBUZu+20w4pBgcy4jmrkW+wknPeqYsouEfucr4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=SscM8/rXyD3ROCL80fvlH6Rw6VhuYagdyhfiB1hSLm2t7Mdd4oKSNAIYqVFg2SmPD
         JZUmleDXAupvrRq1/sQiKls+UUHmyetLDxcAYhM00FW1kjPoFO8jtEtesnriHaBn49
         BNS1xDmxyVS/w89Bhe8xLZ7bQStajlg9PJ7yFmLbTbLAtQDWfcSV8DQqHy2rXa+Uul
         Ey8ti5lUhx7P/OAbHhQAT12LVEEOiYNXF4SBfsn2uHXEjJbapvfuoKPvdpFqFl23Rt
         KYLSAkrpFDXNAOWJyxtwDHEN+3SVssZhoKGV0aqVEy0Ucipk3vZ8txOQBuxdZGcR9G
         cmUnMVHYMhSoQ==
Date:   Tue, 16 May 2023 10:57:13 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Dave Hansen <dave.hansen@intel.com>, Rong Tao <rtoax@foxmail.com>,
        tglx@linutronix.de
CC:     Rong Tao <rongtao@cestc.cn>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/vdso: Use non-serializing instruction rdtsc
User-Agent: K-9 Mail for Android
In-Reply-To: <56ea846e-bce8-2508-e485-1dada8c39643@intel.com>
References: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com> <56ea846e-bce8-2508-e485-1dada8c39643@intel.com>
Message-ID: <4959DDEE-58DC-45E7-BE00-019A45A97D2B@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 16, 2023 7:12:34 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> wro=
te:
>On 5/15/23 23:52, Rong Tao wrote:
>> Replacing rdtscp or 'lfence;rdtsc' with the non-serializable instructio=
n
>> rdtsc can achieve a 40% performance improvement with only a small loss =
of
>> precision=2E
>
>I think the minimum that can be done in a changelog like this is to
>figure out _why_ a RDTSCP was in use=2E  There are a ton of things that
>can make the kernel go faster, but not all of them are a good idea=2E
>
>I assume that the folks that wrote this had good reason for not using
>plain RSTSC=2E  What were those reasons?

I believe the motivation is that it is atomic with reading the CPU number=
=2E
