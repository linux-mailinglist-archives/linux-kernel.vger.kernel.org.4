Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC646F47DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjEBQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjEBQA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:00:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C7C30F5
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:00:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so5730741a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683043225; x=1685635225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4StunhIfVGG09XAY12DZV9Q+WSw3HvDD5jZ9fqE8opo=;
        b=KbV7ljsEHPUtaLe+yaVHKpFHTeqKAG9rPmSIODIqXYaShdrCS3VOCb4EtE2fVEsskm
         LE+QmSvCy9SEtV3H7QGlTVeS4V66VdC1+R98ZKjc+Q3yU/+9osy8u6UJe3ZRIH+nZKrd
         65D8bAXf3vZk7z9qizaXc26zwIDY8rrqMBYiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043225; x=1685635225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4StunhIfVGG09XAY12DZV9Q+WSw3HvDD5jZ9fqE8opo=;
        b=Lb65wFrnM/SSzi1BjOFSueY7hnGduT5Re12zrcDV05WnqlaGX+iAuxnb2SvK8OmWas
         TP/x9y2mV3ysxrtml5TMjGOYzItPKElmMWXd7oPPVAhXwHcLdU/vS7Pr6TeZpVpJc57q
         H5bbiTktgp7pciHHrRJ03KW9uO9XTB/sGocAkXRR7675ZThCMXCzh84Q8IlOoLxUY5sQ
         dUCyndcwLD5UtMztWGQ7LC0flOUJ/AoOu/Mkr/srFqrXBZiLYILBtYhbcM034QapPC6X
         PVooVv21c2kFnC8bm6QdKUcGd43htUtWZT+Hu7aTB/fbsi4M5HPZZlJvPCZWCPKtRfIc
         w/AQ==
X-Gm-Message-State: AC+VfDwU50dY6c/uaYRaNvcGKGDHX8vo9w21G96yQHdpWh2wAPe3hHGC
        mf/uQF+WfQ0426TAP+BBGjbqnbRR7Jl4RCBMgSgloQ==
X-Google-Smtp-Source: ACHHUZ6n3EOihbEE3JbQ5szPZeF5gs4D1w5Rr/2NeCBJ5C8Iq3+KrGqPNhZo0CBLB3lIr9S5D46KxA==
X-Received: by 2002:aa7:cd87:0:b0:50b:de1f:8786 with SMTP id x7-20020aa7cd87000000b0050bde1f8786mr423308edv.16.1683043224730;
        Tue, 02 May 2023 09:00:24 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id r19-20020a056402019300b0050bc5acfcc0sm2302850edv.24.2023.05.02.09.00.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 09:00:23 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-95678d891d6so823471466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 09:00:23 -0700 (PDT)
X-Received: by 2002:a17:907:a40b:b0:94e:5708:1564 with SMTP id
 sg11-20020a170907a40b00b0094e57081564mr442854ejc.22.1683043223131; Tue, 02
 May 2023 09:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
In-Reply-To: <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 May 2023 09:00:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
Message-ID: <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 8:42=E2=80=AFAM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> Have anyone seen any actual code generation difference between:
>
>         return (long)ptr >=3D 0;
>
> and
>
>         return !((unsigned long)ptr & (1UL<<(BITS_PER_LONG-1)));

No, as far as I know, they both generate the same code.

> It's longer, but I'd rather read the explicit "check bit 63" than the
> positive/negative address space thing.  I certainly grok both, but have
> to think through the "(long)ptr >=3D 0" check every time.

I'm very much the other way. I think it's much clearer to say "check
the sign bit".

Doing the explicit bit check means that I have to look at what the bit
number is, and that is a much more complex expression.

In fact, I'd find it easier to read

       return !((unsigned long)ptr & (1UL<< 63));

just because then you go "Oh, checking bit 63" without having to parse
the expression.

But even then I find the '!' is easy to miss, so you really have to parse i=
t.

But:

> I guess it also wouldn't matter as much either if we hid it in a helper
> like the attached patch and I didn't have to read it twice. ;)

Yeah, I think that's a good solution.

                 Linus
