Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4F72087F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbjFBRiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbjFBRis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:38:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53481BB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:38:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96fab30d1e1so505912166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685727525; x=1688319525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPpIUifsrj3WhrOLcjmDKG+n28eYiyTfgghRaS6XkRs=;
        b=IKRPxJ3A0yf2tZl1cV/0w2dtc7OEvW1uj1qqlfdLfH6hbUUfGsHB0M83XAWUkuZEXI
         rWQypeGHOLw7lhGuspNtOMw+mlk1AUWdqj9drpaGt/SxaZqMXLcZmWXcx7uu71+974KQ
         YfOQSvOhd6kPyAndsrGpN35sfO/7fnRVnWxG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685727525; x=1688319525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPpIUifsrj3WhrOLcjmDKG+n28eYiyTfgghRaS6XkRs=;
        b=MaMv26ZUXVPh1ve4rJ6vi14Do7uijmvIKo48fUEy9glMEaMgGB6paRfUgr2J3uIy73
         4G9Akz6fUzxPsTMUAv1pP3/4WFi6uYrol/2CNldcKbwYhJ/dRTF6krURkx+pp5TjuIi9
         pplER+2MlYHhu7kDEPcr8812lWgqCQ/HMkhGwldXsHt0TmsgqcyvZ3V10/r0x7JX7qDD
         HwaArFWWhb78McEbHI6KQkHNzJO281KzInb5dhxCiW5Fh6PEFnwhKTewj8ymRislKP5C
         zGVH3GXIBSirS7FWMIWzngOveJgY+cmeBisMj4Ay/XA6QwAk3f1Duhof+i78tSn1IEe/
         YZ0A==
X-Gm-Message-State: AC+VfDxe1xY1G04NoSxomawIF5/bPIELPUE0sPVHebSZ5P8YtWh40xZj
        TodRRDZtIlIcgxzmjD53f4WsX64HGJibl05ezTreZDxl
X-Google-Smtp-Source: ACHHUZ6qhfdG2fZhdGHsml/SlY1/gE0nLZDDgPGOp1D4nkrUU/a7mwgvShXfR0D8Lozp/i2DjVdefw==
X-Received: by 2002:a17:907:6d88:b0:973:ddfe:e074 with SMTP id sb8-20020a1709076d8800b00973ddfee074mr5519077ejc.2.1685727525176;
        Fri, 02 Jun 2023 10:38:45 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b0096a742beb68sm983013ejd.201.2023.06.02.10.38.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 10:38:44 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so7494333a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:38:43 -0700 (PDT)
X-Received: by 2002:a05:6402:202e:b0:505:d16:9374 with SMTP id
 ay14-20020a056402202e00b005050d169374mr3588912edb.9.1685727523436; Fri, 02
 Jun 2023 10:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
In-Reply-To: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 13:38:26 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
Message-ID: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 10:41=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> sorry for this unusual procedure of me requesting a patch to be pulled.
> I asked for several months the maintainers (David: asymmetric keys,
> Jarkko: key subsystem) to pick my patch but without any luck.

Hmm.

The patch behind that tag looks sane to me, but this is not code I am
hugely familiar with.

Who is the caller that passes in the public_key_signature data on the
stack to public_key_verify_signature()? This may well be the right
point to move it away from the stack in order to have a valid sg-list,
but even if this patch is all good, it would be nice to have the call
chain documented as part of the commit message.

> I signed the tag, but probably it would not matter, since my key is not
> among your trusted keys.

It does matter - I do pull from people even without full chains, I
just end up being a lot more careful, and I still want to see the
signature for any future reference...

DavidH, Herbert, please comment:

>   https://github.com/robertosassu/linux.git tags/asym-keys-fix-for-linus-=
v6.4-rc5

basically public_key_verify_signature() is passed that

     const struct public_key_signature *sig

as an argument, and currently does

        sg_init_table(src_sg, 2);
        sg_set_buf(&src_sg[0], sig->s, sig->s_size);
        sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);


on it which is *not* ok if the s->s and s->digest points to stack data
that ends up not dma'able because of a virtually mapped stack.

The patch re-uses the allocation it already does for the key data, and
it seems sane.

But again, this is not code I look at normally, so...

               Linus
