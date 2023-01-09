Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F866235C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbjAIKmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbjAIKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:41:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A698186F6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673260459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gp01bbHImBb9jQ++aTa7ksC+hJELx0J0kuwwfn5XG7k=;
        b=NyGhmXFoq1ORzElfW5Knca5mQfU1BnRUyZ+6JCPY5q8uBQqa505DVpxoWWx0ZbEI+0nmAF
        uam13VzmRsHbGG4S054Gjo54BTAtlKwfYymPGdy3StwJXlcxyVsgU/TYx3R04hXdfVVdk+
        kYhO+44w6hoA1c3U9WfAF0pc7bsM0M8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-6lJLLzdVMhu3P5ythx0hnw-1; Mon, 09 Jan 2023 05:34:14 -0500
X-MC-Unique: 6lJLLzdVMhu3P5ythx0hnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9F9E1C09044;
        Mon,  9 Jan 2023 10:34:13 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08EA240C2064;
        Mon,  9 Jan 2023 10:34:10 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        mlichvar@redhat.com
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
References: <20230101162910.710293-1-Jason@zx2c4.com>
        <20230101162910.710293-3-Jason@zx2c4.com> <Y7QIg/hAIk7eZE42@gmail.com>
        <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
        <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
        <Y7SDgtXayQCy6xT6@zx2c4.com>
        <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
Date:   Mon, 09 Jan 2023 11:34:09 +0100
In-Reply-To: <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 3 Jan 2023 11:54:35 -0800")
Message-ID: <874jt0kndq.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> On Tue, Jan 3, 2023 at 11:35 AM Jason A. Donenfeld <Jason@zx2c4.com> wrot=
e:
>>
>> I don't think this is about micro-optimization. Rather, userspace RNGs
>> aren't really possible in a safe way at the moment.
>
> "Bah, humbug", to quote a modern-time philosopher.
>
> It's humbug simply because it makes two assumptions that aren't even vali=
d:
>
>  (a) that you have to do it in user space in the first place
>
>  (b) that you care about the particular semantics that you are looking for
>
> The thing is, you can just do getrandom(). It's what people already
> do. Problem solved.

We are currently doing this in glibc for our arc4random implementation,
after Jason opposed userspace buffering.  If chrony is recompiled
against the glibc version of arc4random (instead of its OpenBSD compat
version, which uses userspace buffering), the result is a 25% drop in
NTP packet response rate:

| The new arc4random using getrandom() seems to have a significant
| impact on performance of chronyd operating as an NTP server. On an
| Intel E3-1220 CPU, I see that the maximum number of requests per
| second dropped by about 25%. That would be an issue for some public
| NTP servers.

arc4random is too slow
<https://sourceware.org/bugzilla/show_bug.cgi?id=3D29437>

This is *not* =E2=80=9Carc4random is 25% slower=E2=80=9D, it is the measure=
d overall
impact on server performance.

Historically, the solution space for getrandom and arc4random are
slightly different.  The backronym is =E2=80=9CA Replacement Call For rando=
m=E2=80=9D,
i.e., you should be able to use arc4random without worrying about
performance.  I don't expect cryptographic libraries to turn to
arc4random to implement their random number generators, and that
programmers that use low-level OpenSSL primitives (for example) keep
calling RAND_bytes instead of arc4random because it is available to
them.

We did these changes on the glibc side because Jason sounded very
confident that he's able to deliver vDSO acceleration for getrandom.  If
that fails to materialize, we'll just have to add back userspace
buffering in glibc.  At least we can get process fork protection via
MADV_WIPEONFORK, solving a real problem with the usual arc4random compat
implementation.  (The OpenBSD mechanism for this is slightly different.)
We won't get VM fork protection or forward secrecy against ptrace.  But
the latter is rather speculative anyway because if you can do ptrace
once, you can likely do ptrace twice, the first time patching the
process to remove forward secrecy.  There is a real gap for VM forks,
but I'm not sure how much that matters in practice.  Live migration has
to be implemented in such a way that this isn't observable (otherwise
TCP connections etc. would break), and long-term keys probably shouldn't
be generated under virtualization anyway.

Thanks,
Florian

