Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9686E2A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDNSyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDNSyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:54:22 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625FB464;
        Fri, 14 Apr 2023 11:54:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C84B8320024A;
        Fri, 14 Apr 2023 14:54:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 14 Apr 2023 14:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681498451; x=1681584851; bh=f+
        eksfp3DfnIrZxYIuunG6lmnjTIyE/skvW2EyyiYuk=; b=GoP8TIfVSmXokDxMo4
        cYY3zqDJJsl1XrTa/7T1atRYC435KTOUvfYdp602uYPD+OIL3WKq6rqVUgv1XPqZ
        71p+bGaMVBQVSAQw73O9ogC+tQfektGhjjD82nr/xj5tK/NeXfe/Q8iyt6MA038U
        5cK71d9n3Wa8POdIZ9faueMUo1r/oo+3YeUeEWeq0hmrhe+PHyx78Ul9McINAEkH
        H6H6w18rIFxDKBkXnVYItcubtZLWl0tXYqL67Q5EmWYXD9Y7E1csJUU1X4eXKDqp
        FoLo3TzeFEagrDqnleY2b4Mj1/bJBKzAr437C75Tdr6A5VQumYi0dZE4cWCuyKm/
        eT5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681498451; x=1681584851; bh=f+eksfp3DfnIr
        ZxYIuunG6lmnjTIyE/skvW2EyyiYuk=; b=D97nFEMzohb+6lQUUS+kLHb62Qyqr
        FQw+7YLZ4BFYNVnZu+RRQMXAa3NU8JsQPf1FLTkg/MlOoh9Rn4bDe40fxD7LDw9R
        2IMxsC8ps2HzSuTvxF/1o+XGGbuOD+G8A74UFxqbsPogPcmeZ/d3Yr/132wcN9hV
        8458WH/xizR4ipnuFa5PeFPUZ28eKb6Qj/3eD7q6r+k9UjTqXPuzZ4pY1fGlC+GL
        pEXc6MYT8Ft6Y5E4ceo1sU7RNvQ9makCxmTt11B7jksVnJTRI55UBYWWAT7Da7K5
        MiqkJKokucsJsmk4jQD1fiyE79CfwaSoWK9BoFE1bbQ6qEmBBitHRGKRw==
X-ME-Sender: <xms:UqE5ZM__ZM91pQUfchkfPFVBlwBP1q_lOJcVa0UcAhN9JZMyMMZpzw>
    <xme:UqE5ZEsBn6hw5AePBTVzDhY3vZATfmz9OFUeI8AOlMUozilo0W95gaaBU1d2PCEFI
    PO-lk1PH1kItduvGWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:UqE5ZCBHYdlqxoP2L9VqXZxjYMr5fIiUa8GckvwDxOU6kGOodErs8g>
    <xmx:UqE5ZMd0tYqgyVklMk7XfHZTyK0gdE4t2WvX8fgjgNbdCadAV2bR5Q>
    <xmx:UqE5ZBNH5YvyjNTeh-BYsHW-iB9fEFjIpQnLuxZ4XesS4dcmZNqdXQ>
    <xmx:U6E5ZOfu9quh-s0aPVkxQW75nFfADwQ7etQbil9I0sBAixItgrqMTQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 77353B60086; Fri, 14 Apr 2023 14:54:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <24ebf857-b70d-4d94-8870-e41b91649dd1@app.fastmail.com>
In-Reply-To: <20230414162605.GA2161385@dev-arch.thelio-3990X>
References: <20230414082943.1341757-1-arnd@kernel.org>
 <20230414162605.GA2161385@dev-arch.thelio-3990X>
Date:   Fri, 14 Apr 2023 20:53:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nathan Chancellor" <nathan@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Marco Elver" <elver@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Tom Rix" <trix@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Peter Zijlstra" <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kasan: remove hwasan-kernel-mem-intrinsic-prefix=1 for clang-14
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023, at 18:26, Nathan Chancellor wrote:
> On Fri, Apr 14, 2023 at 10:29:27AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Unknown -mllvm options don't cause an error to be returned by clang, so
>> the cc-option helper adds the unknown hwasan-kernel-mem-intrinsic-prefix=1
>> flag to CFLAGS with compilers that are new enough for hwasan but too
>
> Hmmm, how did a change like commit 0e1aa5b62160 ("kcsan: Restrict
> supported compilers") work if cc-option does not work with unknown
> '-mllvm' flags (or did it)? That definitely seems like a problem, as I
> see a few different places where '-mllvm' options are used with
> cc-option. I guess I will leave that up to the sanitizer folks to
> comment on that further, one small comment below.

That one adds both "-fsanitize=thread" and "-mllvm
-tsan-distinguish-volatile=1". If the first one is missing in the
compiler, neither will be set. If only the second one fails, I assume
you'd get the same result I see with hwasan-kernel-mem-intrinsic-prefix=1.

>>  # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
>> +ifeq ($(call clang-min-version, 150000),y)
>>  CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>> +endif
>> +ifeq ($(call gcc-min-version, 130000),y)
>> +CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>> +endif
>
> I do not think you need to duplicate this block, I think
>
>   ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
>   CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>   endif
>
> would work, as only one of those conditions can be true at a time.

Are you sure that clang-min-version evaluates to an empty string
rather than "n" or something else? I haven't found a documentation
that says anything about it other than it returning "y" if the condition
is true.

      Arnd
