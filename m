Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0FA6AD978
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCGIo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCGIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:44:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD7C2820F;
        Tue,  7 Mar 2023 00:44:25 -0800 (PST)
Message-ID: <a92721ac-4b8a-10a8-fc12-1618dbf69653@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678178662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8fhns1/t0qPYmlpXG0YGly9EViYHyRd3uo6neBHqUA=;
        b=pO3XOyV0NFVCI9vlN9vZdapa+Fe2Dh1dc0v7gFENMBuWGVucyvCH5VtVefCGeKRbR6KfV2
        Rj6gPNW5IadrJzvPimzX6cAqIWjTqMVjklYfhRu2UCSkxI3pf5YU0fiUInJF1CaxXTLRhB
        Bb3MEwABJ4KW52U1yBXhBxuwSdaB0JT0TB0WH5LM3m3bwsv6zNsZpHo0SOMCKfyx/evHdL
        u6mOLmiHZMNag0gRGCcone6ydWu/YJxown0K8HudDVMyyEuoQCtivPC2kR/Pc5cegiwPqo
        1GIff/VuJdzV5JRgv2rTXvT+R5j5Jw4o5booTvaKo57TicEIH4Q6glIYOEOW/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678178662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8fhns1/t0qPYmlpXG0YGly9EViYHyRd3uo6neBHqUA=;
        b=TJ2Aktf3Jv5bP18GzTk65SkpOQhTIZNdf3/2J2rLEjGnbnIqfhFwPVxNjwXbpBjN4P/MBH
        xJplTzznHM4FrBAQ==
Date:   Tue, 7 Mar 2023 09:44:21 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: default dpkg-buildpackage --build
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230305232536.19528-1-bage@linutronix.de>
 <20230305232536.19528-2-bage@linutronix.de>
 <CAK7LNARnkOyusNFZsE9Hj9cg=TWJtv1By8e4UPCso92Wn=jgEQ@mail.gmail.com>
Content-Language: de-DE-frami
From:   Bastian Germann <bage@linutronix.de>
In-Reply-To: <CAK7LNARnkOyusNFZsE9Hj9cg=TWJtv1By8e4UPCso92Wn=jgEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.03.23 um 04:21 schrieb Masahiro Yamada:
> On Mon, Mar 6, 2023 at 8:25 AM Bastian Germann <bage@linutronix.de> wrote:
>>
>> deb-pkg's dpkg-buildpackage invocation was added --build=source,binary
>> recently. Before, it relied on the default, which is
>> --build=source,binary,all and makes no difference for the built packages
>> as there is no "Arch: all" package.
> 
> 
> Is this paragraph true?
> 
> --build=source,binary,all sounds strange because
> 'all' is contained in 'binary'.
> 
> 
> 
> According to dpkb-buildpackage(1),
> 
>   binary = any,all
> 
>   full = source,binary = source,any,all  (default)
> 
> 
> --build=source,binary would build everything
> even if there were 'Arch: all'.

You are right. The point was that it does not change the output.

> 
> The code change is fine.
> My plan was to use --build=source,binary later,
> but I could not finish the entire work in the last cycle.
> 
> 
> 
> 
>> However, the explicit --build eliminates overriding it via DPKG_FLAGS,
>> which used to fill the gap of generating only a source package without
>> building it.
>>
>> Recover the old, default behavior.
>>
>> Fixes: 7bf4582d7aad ("kbuild: deb-pkg: create source package without cleaning")
>> Signed-off-by: Bastian Germann <bage@linutronix.de>
>> ---
>>   scripts/Makefile.package | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
>> index b941e6341b36..fe1721915a59 100644
>> --- a/scripts/Makefile.package
>> +++ b/scripts/Makefile.package
>> @@ -120,7 +120,7 @@ debian-orig: linux.tar.gz debian
>>   PHONY += deb-pkg
>>   deb-pkg: debian-orig
>>          +dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
>> -               --build=source,binary -nc -us -uc
>> +               -nc -us -uc
>>
>>   PHONY += bindeb-pkg
>>   bindeb-pkg: debian
>> --
>> 2.39.2
>>
> 
> 
