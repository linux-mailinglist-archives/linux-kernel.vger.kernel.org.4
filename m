Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB26DFE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDLTOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDLTOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:14:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E55FCF;
        Wed, 12 Apr 2023 12:14:49 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id fv6so293518qtb.9;
        Wed, 12 Apr 2023 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681326888; x=1683918888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWnu6RVyhi4uzC7Ry2QjeXJ1CWSfmQfPfbgbdIGcaFA=;
        b=kh5JKCDo9SPvWTnKK2hPJ25n8o1kiO7ZCmp7IglmcT9z29vxB/VwDDRKYAF7rsAbFz
         d1ttDHBhehAPT1cY8kSR4csY5PpIfm/42SgmXtzDSFAN0TfyxSgGAdHFRHuMczL2qucH
         K4QAEbRyX6DOLUQdINZFf9tOcYVnxAsR3nAfpinH599MSXcqvW2bLHW62Tv/K87WOCer
         1n+2LDs/RP34oOlmw0zBLgPECiubajQqlZn6SlnYSZ2Ol0sSECCW0dPxRZttlsF+QNTG
         R6vHl7hfZOqzBHkeIsNjlfqnVcDLVQz04whuospxr3uTz5oUblOXtiv0GPYmouPhnvuq
         yu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681326888; x=1683918888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWnu6RVyhi4uzC7Ry2QjeXJ1CWSfmQfPfbgbdIGcaFA=;
        b=exlerfFlGdwdAon3vXIgkjP7MtuBRN+YCL3r+eVGj/BKLoWkN1wZAyRti+MjQGkN/c
         0davhkmpA2AosHM2zAbhsUlbcmOycwI+vRKFmHfczAhl+yoKn3kiBBUjO7cG6purvLPR
         aYK+BfKacT/GYkyTwl1l5rR7RgpirAoEzRtKDy3w9eQlDH9F/NhPKVfFijKYMO+oshCv
         Yd4y0gHsiIJ+EjutEkutRRVmHH6YIdKH0Zmn8vCGxo9qjaMDHggaUvWv5E8WtzuidInj
         bh6UagGOFGqe4t3gn8KRivFRQ0jJEFMnQnUZYt+S6CKjeeL80r028tBTDYgw0tIEWrec
         dJ7Q==
X-Gm-Message-State: AAQBX9dtOwuHHVhSmIoD9/nvSHm5nYZkfaNTGvB4OMSUyov0yZgGeUUI
        d/9ksieU5xsMTLsVRnnudBTsWeSkZP0=
X-Google-Smtp-Source: AKy350ZVLQ44IG1f4rg4LVxAu2yzZPrUV+qRRm01OWAVrErTfgleOHgyvR3VdeBTIueBQA508uxBWA==
X-Received: by 2002:a05:622a:88:b0:3e8:8f:3140 with SMTP id o8-20020a05622a008800b003e8008f3140mr7799511qtw.24.1681326888132;
        Wed, 12 Apr 2023 12:14:48 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o5-20020ac872c5000000b003c033b23a9asm4398905qtp.12.2023.04.12.12.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:14:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id C673F27C0054;
        Wed, 12 Apr 2023 15:14:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Apr 2023 15:14:46 -0400
X-ME-Sender: <xms:JgM3ZBdBPwa1GuuV-wzKK07S-qzaWy5f1XluchjD7yb2RFizR1UbRg>
    <xme:JgM3ZPN8k7jp6Uk4f_ZzNzOZ9mvmpx_ysKV8stXlZURiF32psyW7QAekxJBpW1piX
    6iexbw825m2gMU11g>
X-ME-Received: <xmr:JgM3ZKjdcvqlITLXh5Q3tp7YouNMi60vMnDyEt8J-jnphZrFRF9Fr5zlAxvMOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:JgM3ZK-80CEJzK3qJSFfa3L_5-5EGp9hZGDpSPtWGfQII9a4vfUHeA>
    <xmx:JgM3ZNtU_d5IKGewScMoYMweHq_cIsH5W9Nf3pcIHxIBr1TXymOVBA>
    <xmx:JgM3ZJF_5DDkWNLILnJDSvbMLK-iS3iu275v5irHr0IIspXE70zw_A>
    <xmx:JgM3ZGG_ktda9njN0jQo2DkEm0n_leFjhdqFMPJ4QJ5uO1RsHwMKBw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 15:14:46 -0400 (EDT)
Date:   Wed, 12 Apr 2023 12:14:44 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 04/13] locking/spinlock: introduce
 spin_lock_init_with_key
Message-ID: <ZDcDJKgi4f3OF05d@boqun-archlinux>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
 <20230411054543.21278-4-wedsonaf@gmail.com>
 <CANeycqqM5o_4gj2rT=8yV0NGTRWY=jTA6HT4F2Esho-WAJCPOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqqM5o_4gj2rT=8yV0NGTRWY=jTA6HT4F2Esho-WAJCPOQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:05:07PM -0300, Wedson Almeida Filho wrote:
> On Tue, 11 Apr 2023 at 02:46, Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> >
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > Rust cannot call C macros, so it has its own macro to create a new lock
> > class when a spin lock is initialised. This new function allows Rust
> > code to pass the lock class it generates to the C implementation.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

> > ---
> > v1 -> v2: No changes
> > v2 -> v3: No changes
> > v3 -> v4: No changes
> >
> >  include/linux/spinlock.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> > index be48f1cb1878..cdc92d095133 100644
> > --- a/include/linux/spinlock.h
> > +++ b/include/linux/spinlock.h
> > @@ -327,12 +327,17 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
> >
> >  #ifdef CONFIG_DEBUG_SPINLOCK
> >
> > +static inline void spin_lock_init_with_key(spinlock_t *lock, const char *name,
> > +                                          struct lock_class_key *key)
> > +{
> > +       __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> > +}
> > +
> >  # define spin_lock_init(lock)                                  \
> >  do {                                                           \
> >         static struct lock_class_key __key;                     \
> >                                                                 \
> > -       __raw_spin_lock_init(spinlock_check(lock),              \
> > -                            #lock, &__key, LD_WAIT_CONFIG);    \
> > +       spin_lock_init_with_key(lock, #lock, &__key);           \
> >  } while (0)
> 
> Peter, the code above is just factoring out spin lock init when
> lockdep is enabled to take a lock class key.
> 
> Would you be able to review it?
> 
> If it's ok with you, we'd like to carry it through the rust tree
> because we have code that depends on it.

Same ask here ;-) Peter, do you think it's Ok to take it via rust tree?
Thanks!

Regards,
Boqun

> 
> Thanks,
> -Wedson
> 
> >
> >  #else
> > --
> > 2.34.1
> >
