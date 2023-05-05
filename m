Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D456F6F8257
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjEEL4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjEEL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:56:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC81492F
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:56:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QCTgG04Kbz4x3k;
        Fri,  5 May 2023 21:56:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1683287802;
        bh=wL0ut7KPgA2OC3Dll+ns1sPtjzsQDnTnwgItU5roP2g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pAnBmTvp2iT6sEDsOS3XkU3XM/V1lGsw9QC2wCL8EmIE9d0cEUAwxoibwuvYo/6Cs
         BbXtw4WRlWj1hdo4z6MV1fxNWNIpN0w8YVqJBpoGofE05Bs4wpvsM108zY+XJsHu1n
         rObjiNrn/fjQRwK2NQ9KwrdPQ/NE6EcZwUgh1j0uX7JqgUiYAiZ/K348c4FM4qoZ/j
         H0i3KKVzdi+3D6u1M+3FDapoVJCy2C1r11M23k7XKnDVjh17qBledtTGpPxTrIaSH3
         IUrCmu+2us/uZTtygzUq5yv6gPMf8Iplw9akcH6uM+qiFLpwClsixZUEipR7XYJGVU
         dqpTxyBv+iOGA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] mm: kfence: Fix false positives on big endian
In-Reply-To: <CANpmjNOmtTU=__W7=pKVibVZ3OnfgSsXeSsqHA7y=e3D-G026Q@mail.gmail.com>
References: <20230505035127.195387-1-mpe@ellerman.id.au>
 <CANpmjNOmtTU=__W7=pKVibVZ3OnfgSsXeSsqHA7y=e3D-G026Q@mail.gmail.com>
Date:   Fri, 05 May 2023 21:56:40 +1000
Message-ID: <87zg6j56vb.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:
> On Fri, 5 May 2023 at 05:51, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Since commit 1ba3cbf3ec3b ("mm: kfence: improve the performance of
>> __kfence_alloc() and __kfence_free()"), kfence reports failures in
>> random places at boot on big endian machines.
>>
>> The problem is that the new KFENCE_CANARY_PATTERN_U64 encodes the
>> address of each byte in its value, so it needs to be byte swapped on big
>> endian machines.
>>
>> The compiler is smart enough to do the le64_to_cpu() at compile time, so
>> there is no runtime overhead.
>>
>> Fixes: 1ba3cbf3ec3b ("mm: kfence: improve the performance of __kfence_alloc() and __kfence_free()")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Reviewed-by: Marco Elver <elver@google.com>

Thanks.

> Andrew, is the Fixes enough to make it to stable as well or do we also
> need Cc: stable?

That commit is not in any releases yet (or even an rc), so as long as it
gets picked up before v6.4 then it won't need to go to stable.

cheers
