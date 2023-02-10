Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2269263E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjBJTZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjBJTZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:25:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242C7D88E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676057114;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=xmO9YKHMKKTJQMjPUu1RtooVQTRNP/W/wxyjD2+hujQ=;
        b=dK77NdivkL0f1ZsnGEibtpw4jGez+9h1nq58nFxWzDmRvUnbc42Eil0ND/1OwTEL3VBOPt
        SVuOG8A18MiNAtFvKXYV8TWWbn9+TYJjwrQvJ7irE7MoS6sN70xjoinA6HUQn7Cj0HDPen
        o/olgX5TArpNA0o16AOm5z0XTBcoqRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-R_x943JFOkGWZaQUcdRCzA-1; Fri, 10 Feb 2023 14:25:10 -0500
X-MC-Unique: R_x943JFOkGWZaQUcdRCzA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDA48971084;
        Fri, 10 Feb 2023 19:25:09 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.192.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34406492C3F;
        Fri, 10 Feb 2023 19:25:08 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 31AJP41Q1777405
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 20:25:04 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 31AJP1BB1777404;
        Fri, 10 Feb 2023 20:25:01 +0100
Date:   Fri, 10 Feb 2023 20:25:00 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH -tip] kasan: Emit different calls for instrumentable
 memintrinsics
Message-ID: <Y+aaDP32wrsd8GZq@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20230208184203.2260394-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208184203.2260394-1-elver@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:42:03PM +0100, Marco Elver wrote:
> Clang 15 will provide an option to prefix calls to memcpy/memset/memmove
> with __asan_ in instrumented functions: https://reviews.llvm.org/D122724
> 
> GCC does not yet have similar support.

GCC has support to rename memcpy/memset etc. for years, say on
following compiled with
-fsanitize=kernel-address -O2 -mstringop-strategy=libcall
(the last option just to make sure the compiler doesn't prefer to emit
rep mov*/stos* or loop or something similar, of course kernel can keep
whatever it uses) you'll get just __asan_memcpy/__asan_memset calls,
no memcpy/memset, while without -fsanitize=kernel-address you get
normally memcpy/memset.
Or do you need the __asan_* functions only in asan instrumented functions
and normal ones in non-instrumented functions in the same TU?

#ifdef __SANITIZE_ADDRESS__
extern __typeof (__builtin_memcpy) memcpy __asm ("__asan_memcpy");
extern __typeof (__builtin_memset) memset __asm ("__asan_memset");
#endif
struct S { char a[2048]; } a, b;

void
foo (void)
{
  a = b;
  b = (struct S) {};
}

void
bar (void *p, void *q, int s)
{
  memcpy (p, q, s);
}

void
baz (void *p, int c, int s)
{
  memset (p, c, s);
}

void
qux (void *p, void *q, int s)
{
  __builtin_memcpy (p, q, s);
}

void
quux (void *p, int c, int s)
{
  __builtin_memset (p, c, s);
}

	Jakub

