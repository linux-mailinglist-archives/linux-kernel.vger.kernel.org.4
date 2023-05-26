Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC80B712AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjEZQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEZQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:30:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEF5D3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:30:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96fffe11714so162475466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685118618; x=1687710618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rAOvIEHc+VxLUcDo7/1SZK+gxa4MgVK+c4EuJ+y9RwE=;
        b=YcaPLRWb+kah2atBFobIiRcNatSkDYQ4p7u/K+mjE6SuJDCO43ImUXUhzPv9rc87je
         5W6x61+BRC6F8gwdaTd++X/1WF/h75MEn2taPGGK7P4SNXyxcqKxRT6cKvETYoXjy3zZ
         XADHo00VqKlozV4tn8k7mn4DMxIQDf8GUymO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685118618; x=1687710618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAOvIEHc+VxLUcDo7/1SZK+gxa4MgVK+c4EuJ+y9RwE=;
        b=FIlmKg2iYgUsa0oesnDn5dZudxSU5bBMtxUvOO6H76cfINxCta7LxCUGSGLzwcUUxN
         1MZ45BdJdKUS9sJltVJKUr5gYL2ndQdf7aU9A38J2CQ54wUk7plg2lsFa2LrUY9Q2Lu8
         midl7zGf6nMb5K4R0MUGQFJK0VnU+eZa40nNlMFOfWNcqc7CFZk/NqjD2+kCEPD3PCpF
         rQBKC5sI6MHePypuyNeG79XeuYekbOEEgPnCHk1kEaM4oCfI9GENjze5WH3MXf4p5AoA
         T3lHSRAGyl/pIW02tOWatCRFGsrR0/BtuhWuKSCOCUg+qDERi1rabRGqCXKo89a5n9HK
         /9sQ==
X-Gm-Message-State: AC+VfDyx5rG+UjOme9vzUiuLSYFZKkbBLsmvRfmoDlwko/flwgDHUT+7
        IaiVvtR3eurokQQLFQ3ymT9Xl5j1MaaAdX5/koQ+vmUL
X-Google-Smtp-Source: ACHHUZ6BD8MU/1Lbq3NHlhLptaR1z7E1RptevhFOZxBMzNcDmHhiSXxf5BaS5yNtFQCFK71A80eBMg==
X-Received: by 2002:a17:906:fd8d:b0:96f:5f44:ea02 with SMTP id xa13-20020a170906fd8d00b0096f5f44ea02mr2729098ejb.8.1685118618368;
        Fri, 26 May 2023 09:30:18 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id l16-20020a056402125000b0050e01a965a3sm125214edw.5.2023.05.26.09.30.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 09:30:17 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-96f50e26b8bso160104966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:30:17 -0700 (PDT)
X-Received: by 2002:a17:906:fd8d:b0:96f:5f44:ea02 with SMTP id
 xa13-20020a170906fd8d00b0096f5f44ea02mr2729037ejb.8.1685118617396; Fri, 26
 May 2023 09:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
In-Reply-To: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 09:29:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
Message-ID: <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
Subject: Re: x86 copy performance regression
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000987cc805fc9b40ca"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000987cc805fc9b40ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 8:00=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> We can see rep_movs_alternative() using more cycles in kernel profiles
> than the previous variant (copy_user_enhanced_fast_string, which was
> simply using "rep  movsb"), and we can not reach line rate (as we
> could before the series)

Hmm. I assume the attached patch ends up fixing the regression?

That hack to generate the two-byte 'jae' instruction even for the
alternative is admittedly not pretty, but I just couldn't deal with
the alternative that generated pointlessly bad code.

We could make the constant in the comparison depend on whether it is
for the unrolled or for the erms case too, I guess, but I think erms
is probably "good enough" with 64-byte copies.

I was really hoping we could avoid this, but hey, a regression is a regress=
ion.

Can you verify this patch fixes things for you?

                  Linus

--000000000000987cc805fc9b40ca
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_li4s3rll0>
X-Attachment-Id: f_li4s3rll0

IGFyY2gveDg2L2xpYi9jb3B5X3VzZXJfNjQuUyB8IDE2ICsrKysrKysrKysrKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvbGliL2NvcHlfdXNlcl82NC5TIGIvYXJjaC94ODYvbGliL2NvcHlfdXNlcl82NC5T
CmluZGV4IDRmYzVjMmRlMmRlNC4uMjFmMTFiZDM2Y2RjIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9s
aWIvY29weV91c2VyXzY0LlMKKysrIGIvYXJjaC94ODYvbGliL2NvcHlfdXNlcl82NC5TCkBAIC03
LDkgKzcsMTcgQEAKICAqLwogCiAjaW5jbHVkZSA8bGludXgvbGlua2FnZS5oPgorI2luY2x1ZGUg
PGFzbS9hbHRlcm5hdGl2ZS5oPgogI2luY2x1ZGUgPGFzbS9hc20uaD4KICNpbmNsdWRlIDxhc20v
ZXhwb3J0Lmg+CiAKKy8qCisgKiBEaXNndXN0aW5nIGhhY2sgdG8gZ2VuZXJhdGUgYSB0d28tYnl0
ZSAnamFlJyBpbnN0cnVjdGlvbgorICogZm9yICdhbHRlcm5hdGl2ZXMnIHRoYXQgd291bGQgb3Ro
ZXJ3aXNlIGdlbmVyYXRlIGEgcmVsb2NhdGlvbgorICogYW5kIGEgYmlnIGp1bXAuCisgKi8KKyNk
ZWZpbmUgSkFFKHgpICIuYnl0ZSAweDczLCIgI3ggIi0wYi0yIgorCiAvKgogICogcmVwX21vdnNf
YWx0ZXJuYXRpdmUgLSBtZW1vcnkgY29weSB3aXRoIGV4Y2VwdGlvbiBoYW5kbGluZy4KICAqIFRo
aXMgdmVyc2lvbiBpcyBmb3IgQ1BVcyB0aGF0IGRvbid0IGhhdmUgRlNSTSAoRmFzdCBTaG9ydCBS
ZXAgTW92cykKQEAgLTI5LDcgKzM3LDcgQEAKICAqLwogU1lNX0ZVTkNfU1RBUlQocmVwX21vdnNf
YWx0ZXJuYXRpdmUpCiAJY21wcSAkNjQsJXJjeAotCWphZSAuTHVucm9sbGVkCiswOglhbHRlcm5h
dGl2ZSBKQUUoLkx1bnJvbGxlZCksIEpBRSguTGxhcmdlKSwgWDg2X0ZFQVRVUkVfRVJNUwogCiAJ
Y21wICQ4LCVlY3gKIAlqYWUgLkx3b3JkCkBAIC02NSw2ICs3MywxMiBAQCBTWU1fRlVOQ19TVEFS
VChyZXBfbW92c19hbHRlcm5hdGl2ZSkKIAlfQVNNX0VYVEFCTEVfVUEoIDJiLCAuTGNvcHlfdXNl
cl90YWlsKQogCV9BU01fRVhUQUJMRV9VQSggM2IsIC5MY29weV91c2VyX3RhaWwpCiAKKy5MbGFy
Z2U6CiswOglyZXAgbW92c2IKKzE6CVJFVAorCisgICAgICAgIF9BU01fRVhUQUJMRV9VQSggMGIs
IDFiKQorCiAJLnAyYWxpZ24gNAogLkx1bnJvbGxlZDoKIDEwOgltb3ZxICglcnNpKSwlcjgK
--000000000000987cc805fc9b40ca--
