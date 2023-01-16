Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3D766CFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjAPTuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjAPTt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:49:58 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A892C67D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:49:56 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k12so9233671plk.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wZvvACyBelhwyC9g77by0DEIkBqZpn0ZmXIgfmKr4s=;
        b=0oC65SyRHbWDjj7xp6Z5i5H7PKj9V2uYPsPQ3OqlQp+3vN9gFAdP/sq3xkLwsvLRVS
         McB8d3MpJc4v96EUA9wf/iM2TqR0GJ15g374T+k2oOetyyQWWe5sV0KcuuaI0T3DQ1mO
         aPo1gjrVrlEsQNgjfwYbOonw+vgLoONw5oTLv4ZFnSeIM3jDuEFozpyQ+5pp9VxbxTEU
         dIzgulr11qkfeUnYqXz7AVpJZ1KN2zDbCism7+gww5+ygd5mNP3cDh4X7duKjhUMeg4A
         9+k+ruW9Y/N4jDkPQkNzvGey+mDbzzVDdaQJV7geBcMly8kcUZWwPTWhv8f4ZnhHKrtJ
         2IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wZvvACyBelhwyC9g77by0DEIkBqZpn0ZmXIgfmKr4s=;
        b=VTrse50w7uyUnx1L2ynzcaG39pPNhhDY9t0AilGHdI19yW8ipRFBXSxxIksGPFwzd/
         cTGKsVhqajUfQaz1DWT66cRfB7PgM5EMZH983C5LbblQluZ3WSVV+qJ4Fq0WpOEPNy25
         T2W9NqjdWwENtOqa299+hduXCDa4xQGF5WkFnv9xwjmUaa16l3bG0YlAAoINW3czMTKr
         xbiT5xPNTzZbYMjCItw7t4IrPN5rrZ7UxHDUqxCPVwhvkUf8bJogSbh/ZogEUBqi+TTc
         bEDNKMbsxx4fOFTNDIjrwdOpGmCX5APQ5Vd8QJ5ui7Jt80Vtzio3K8x6ofHjXw8xT8Zk
         BTog==
X-Gm-Message-State: AFqh2kqj1MolCFicfQEeFDZTZT9D/wvmxTkObbJNUhUss2QeKz4PzjYL
        78JmwkpZVCxxBve5F3lLwGafNw==
X-Google-Smtp-Source: AMrXdXtpS9tGPFZxJo7zJbNIiuX5+Bt+X5f0IpuEJBuXVCAC2ooHDIHjJz3wEm9Fj9oNuS3cd0YJAA==
X-Received: by 2002:a05:6a20:1710:b0:b8:499d:7c99 with SMTP id bn16-20020a056a20171000b000b8499d7c99mr180334pzb.0.1673898596098;
        Mon, 16 Jan 2023 11:49:56 -0800 (PST)
Received: from smtpclient.apple ([2601:646:c200:522:b469:4533:dab3:1cd4])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902bd0500b0019248880f75sm19686244pls.77.2023.01.16.11.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 11:49:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/4] random: a simple vDSO mechanism for reseeding userspace CSPRNGs
Date:   Mon, 16 Jan 2023 11:49:42 -0800
Message-Id: <15F7D57C-8CC6-4CAE-8B7E-6F480B5F4133@amacapital.net>
References: <585ddb35-adc5-f5cf-4db3-27571f394108@zytor.com>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
In-Reply-To: <585ddb35-adc5-f5cf-4db3-27571f394108@zytor.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: iPhone Mail (20C65)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 13, 2023, at 7:16 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>=20
> =EF=BB=BFOn 1/12/23 11:55, Yann Droneaud wrote:
>> Hi
>> 12 janvier 2023 =C3=A0 18:07 "Jason A. Donenfeld" <Jason@zx2c4.com> a =C3=
=A9crit:
>> =20
>>> Sorry Yann, but I'm not interested in this approach, and I don't think
>>> reviewing the details of it are a good allocation of time. I don't
>>> want to lock the kernel into having specific reseeding semantics that
>>> are a contract with userspace, which is what this approach does.
>> This patch adds a mean for the kernel to tell userspace: between the
>> last time you call us with getrandom(timestamp,, GRND_TIMESTAMP),
>> something happened that trigger an update to the opaque cookie given
>> to getrandom(timestamp, GRND_TIMESTAMP). When such update happen,
>> userspace is advised to discard buffered random data and retry.
>> The meaning of the timestamp cookie is up to the kernel, and can be
>> changed anytime. Userspace is not expected to read the content of this
>> blob. Userspace only acts on the length returned by getrandom(,, GRND_TIM=
ESTAMP):
>>  -1 : not supported
>>   0 : cookie not updated, no need to discard buffered data
>>  >0 : cookie updated, userspace should discard buffered data
>> For the cookie, I've used a single u64, but two u64 could be a better sta=
rt,
>> providing room for implementing improved behavior in future kernel versio=
ns.
>>> Please just let me iterate on my original patchset for a little bit,
>>> without adding more junk to the already overly large conversation.
>> I like the simplicity of my so called "junk". It's streamlined, doesn't
>> require a new syscall, doesn't require a new copy of ChaCha20 code.
>> I'm sorry it doesn't fit your expectations.
>=20
> Why would anything more than a 64-bit counter be ever necessary? It only n=
eeds to be incremented.

This is completely broken with CRIU or, for that matter, with VM forking.

>=20
> Let user space manage keeping track of the cookie matching its own buffers=
. You do NOT want this to be stateful, because that's just begging for multi=
ple libraries to step on each other.
>=20
> Export the cookie from the vdso and voli=C3=A0, a very cheap check around a=
ny user space randomness buffer will work:
>=20
>    static clone_cookie_t last_cookie;
>    clone_cookie_t this_cookie;
>=20
>    this_cookie =3D get_clone_cookie();
>    do {
>        while (this_cookie !=3D last_cookie) {
>            last_cookie =3D this_cookie;
>            reinit_randomness();
>            this_cookie =3D get_clone_cookie();
>        }
>=20
>        extract_randomness_from_buffer();
>        this_cookie =3D get_clone_cookie();
>    } while (this_cookie !=3D last_cookie);
>=20
>    last_cookie =3D this_cookie;
>=20
>    -hpa
