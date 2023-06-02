Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC83720721
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjFBQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbjFBQK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:10:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40763E43
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:10:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so2975310e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685722191; x=1688314191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeFT72TXfXAwhYRh1W0GvqbmonxTxhIBsAfBN2yDsw0=;
        b=Xvi/ClXZ5/5C7Un8m11hnm+n2IRojdqgmlLtynis7i1EXsgEP4GaZ+po4+frH+0Q8w
         fvCRel3QdWYe6SrZLfwR4Jtf1Qov56zTJmITbpnH/gHVNnnOhIrLgwdDC4UffS+Oh8YN
         s2SsLr1Pbi2J79iiXth9Ax/nqsxK8IgbjbkgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722191; x=1688314191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeFT72TXfXAwhYRh1W0GvqbmonxTxhIBsAfBN2yDsw0=;
        b=EwUVOKD2agIUXdrlZTpJTx35z6fLDJTPU2zTngZO4ZAsw8FEmKOSlU6/s9ll4uhRUI
         79vsxSXAbme6+i1M8wzedo1+cSMCq65MwLDORjEOUzIQvK+El0B/ohCK+kMpWjF21VVz
         jCyoWU2EdSE0O8UWiCqingN9ENfSrbi0Oe3PjWBTEQDupbGuHlhoo6hBOcZgp6tDnHII
         i+r4KSKfE9ITW0VuHlwfHDMERPD1NQAYlBTLWbuYM4y93EvQDSjjR/m70edYYrgWCRga
         2i8bHvhzcKgV5L/ZcpYtC2CXKc7f/IGv2P2mkdNpAhoWGBkVfmh/s5+Soqws0FkYya4E
         lsJw==
X-Gm-Message-State: AC+VfDzf0cNA2tZ7pOZODfum+6ZUHqeyZF/J9SF4Twpjlt1P/9aysOGr
        gBf+Uwca1Q9B7msdJM0sdOn5AsbPKSxEHjUj1uP8rGGb
X-Google-Smtp-Source: ACHHUZ6g0wkH4hKy0+/ZIKMm8M4uM2yzx3utavn3ANJIwKd9NvfWw+m8ubmt7YisycfsxcbKnA6EIw==
X-Received: by 2002:a19:a413:0:b0:4ed:c639:54cd with SMTP id q19-20020a19a413000000b004edc63954cdmr2280145lfc.35.1685722190972;
        Fri, 02 Jun 2023 09:09:50 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q7-20020ac25a07000000b004d40e22c1eesm203354lfn.252.2023.06.02.09.09.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:09:50 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so2564667e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:09:49 -0700 (PDT)
X-Received: by 2002:ac2:5d6c:0:b0:4f2:509b:87ba with SMTP id
 h12-20020ac25d6c000000b004f2509b87bamr2034590lft.50.1685722168361; Fri, 02
 Jun 2023 09:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de> <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
 <20230602143912.GI620383@hirez.programming.kicks-ass.net>
In-Reply-To: <20230602143912.GI620383@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 12:09:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj7K3Q9WbBtQHiOXKc04SRjeOF+TRopkwVoQh_CFU+kvg@mail.gmail.com>
Message-ID: <CAHk-=wj7K3Q9WbBtQHiOXKc04SRjeOF+TRopkwVoQh_CFU+kvg@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
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

On Fri, Jun 2, 2023 at 10:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Something like so then?

Ack. I think it would be much cleaner if we would have it as part of
the Kconfig file and architectures could just override some
GCC_MIN_VERSION value, but that's not the universe we currently have,
so your patch looks like the best thing to do.

              Linus
