Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9CE6F82DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjEEMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjEEMZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:25:04 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBBC1C0E3;
        Fri,  5 May 2023 05:25:01 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-61b6a4233a1so15571136d6.1;
        Fri, 05 May 2023 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683289501; x=1685881501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sr2amg9WCR/q2N5ln0gsUi9dm0nPC6/6t0wPKjMTO5w=;
        b=XXaxdJAVMvXCF7Ra1pKYJliuqnpFLTzCV4DXuvx2OatrmmPK6N24uFJ+sIvJ0WCRTa
         IjnaSK4KE587lmG+i9fVgCJrw4c9WhuEhGXjeHUeII5oZcsoVr8ortNYOzR6RV7j/pcO
         WUdWJDyXNqvB5kM9H2NLbNN0zdHLGWOLoEjYStbE+QzM+h78wvGl5R9CKBcUWs8f4WCI
         1yay3jJwSdw2aJE8rjKmPZ6jri1fROxzcM3CMu6um2DFxcmYW5psjuhabEJ/17kY3MGs
         BUB4bKkgvTQsNkYO3V+FyuT5dv4LHVZ6nDF6W8yyyXEJNZMFtZ99XYrIOnAXw7Wy1a9d
         AYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683289501; x=1685881501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sr2amg9WCR/q2N5ln0gsUi9dm0nPC6/6t0wPKjMTO5w=;
        b=XS4zaSIjdAROX2ZV5bivneHUgJpIrJ0Taimg5TX4FPM7CNaaKF6Hg+8SWrZn8n5sym
         Q0vWpckqgBRJFDxYmE9ON4O0BdZb2c2AmPTEBnKp3tJCr5EjgO5QMQ6wQdKnV0KgCSHg
         xelVoWsNoxSWT94EHBtu1E5WEMRXsJsFaWskZ+Pl9JkzCRsKb6rYz64PUU0hYzwS6mxk
         PklBbB/yAqX9CeaJoxIh6p5bSTi00UCDmlSujKMDRgnhQWdORcwumDq+RM6rpbXIeRxE
         CdY08u6WdSGxtPoC5o/fDhPI3biny29UG7DdjkJOqYaBXhLMb4HcOtl76EViZMM9DAYk
         6ywg==
X-Gm-Message-State: AC+VfDxYGSRqEpBVd5Gdn+tsDr2yuuj05NvRAca8CNHJFc7xwbLJQ/ng
        GLOY+Ar55F83aNaCsRiTJlg=
X-Google-Smtp-Source: ACHHUZ5hcZaDftVEVtrbYrw6lf2HrwympBsFsP+bT4tUCN6N+8RhkGsc1EUWxF2c75fgBbR9VBEHug==
X-Received: by 2002:a05:6214:c22:b0:5d9:a36d:3ed2 with SMTP id a2-20020a0562140c2200b005d9a36d3ed2mr1556251qvd.45.1683289500881;
        Fri, 05 May 2023 05:25:00 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o8-20020a0cf4c8000000b0061b73e331b2sm543988qvm.30.2023.05.05.05.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 05:25:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id B42CB27C0054;
        Fri,  5 May 2023 08:24:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 05 May 2023 08:24:59 -0400
X-ME-Sender: <xms:mvVUZBrfPbf5W1PJlbr8hHUt9d-OCEyKtKYYIU39QIj7UgyvergKYg>
    <xme:mvVUZDp2txseR8sCYC2HEHM4ZGEQRvwo70MBLFjy1rgTxnPHoOSoE5jFUUpM0XLmE
    gEtc9NP4P21HP4MlQ>
X-ME-Received: <xmr:mvVUZOPKLeKniDrdgszttp3vG3Pjt8irL3zHrhd4hWfLGSg9eQNo4BdQ6Bpg8GE3oGaSJZb_YnUnKE6pjkfodGKLsb5JNv7v5L4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:mvVUZM7A7pnlSvMFvYpbRFsn61P08-gdI03hA-gvFnQizdiceMD_gw>
    <xmx:mvVUZA7wDKopzvK8vZcWgnfATNZAuwlu_Fj10c8uDdVvTffdubULFQ>
    <xmx:mvVUZEhm_fgGGPbzD-BXy372GTCefeL0-iir4VWIihfkR3I8RNyi0g>
    <xmx:m_VUZG5-99NADp3zTLp-irnJnPnBtGsOcZH-f5S979IThVQLJY8xQA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 08:24:57 -0400 (EDT)
Date:   Fri, 5 May 2023 05:24:56 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Message-ID: <ZFT1mOQq0YllZl7V@Boquns-Mac-mini.local>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
 <80ed2c0e-54db-777a-175b-1aa3ff776724@kernel.dk>
 <CANiq72=3kGRy-3Lq5oxUEhu5d-377QrhuzhvoKRL+_QvbnJE7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=3kGRy-3Lq5oxUEhu5d-377QrhuzhvoKRL+_QvbnJE7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 12:53:41PM +0200, Miguel Ojeda wrote:
> On Thu, May 4, 2023 at 10:22 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > Right, but that doesn't really solve the problem when the rust bindings
> > get in the way of changes that you are currently making. Or if you break
> > them inadvertently. I do see benefits to that approach, but it's no
> > panacea.

One thing I want to point out is: not having a block layer Rust API
doesn't keep the block layer away from Rust ;-) Rust will get in the way
as long as block layer is used, directly or indirectly, in any Rust code
in kernel.

Take the M1 GPU driver for example, it can totally be done without a drm
Rust API: Lina will have to directly call C funciton in her GPU driver,
but it's possible or she can have her own drm Rust binding which is not
blessed by the drm maintainers. But as long as drm is used in a Rust
driver, a refactoring/improvement of drm will need to take the usage of
Rust side into consideration. Unless of course, some one is willing to
write a C driver for M1 GPU.

The Rust bindings are actually the way of communication between
subsystem mantainers and Rust driver writers, and can help reduce the
amount of work: You can have the abstraction the way you like.

Of course, there is always "don't do it until there are actually users",
and I totally agree with that. But what is a better way to design the
Rust binding for a subsystem?

*	Sit down and use the wisdom of maintainers and active
	developers, and really spend time on it right now? Or

*	Let one future user drag the API/binding design to insaneness?

I'd rather prefer the first approach. Time spent is time saved.

Personally, my biggest fear is: RCU stalls/lockdep warnings in the Rust
code (or they don't happen because incorrect bindings), and who is going
to fix them ;-) So I have to spend my time on making sure these bindings
in good shapes, which is not always a pleasant experience: the more you
use something, the more you hate it ;-) But I think it's worth.

Of course, by no means I want to force anyone to learn Rust, I totally
understand people who want to see zero Rust. Just want to say the
maintain burden may exist any way, and the Rust binding is actually the
thing to help here.

Regards,
Boqun

> >
> > This seems to assume that time is plentiful and we can just add more to
> > our plate, which isn't always true. While I'd love to do more rust and
> > get more familiar with it, the time still has to be there for that. I'm
> > actually typing this on a laptop with a rust gpu driver :-)
> >
> > And this isn't just on me, there are other regular contributors and
> > reviewers that would need to be onboard with this.
> 
> Indeed -- I didn't mean to imply it wouldn't be time consuming, only
> that it might be an alternative approach compared to having existing
> maintainers do it. Of course, it depends on the dynamics of the
> subsystem, how busy the subsystem is, whether there is good rapport,
> etc.
> 
> > Each case is different though, different people and different schedules
> > and priorities. So while the above is promising, it's also just
> > annecdotal and doesn't necessarily apply to our case.
> 
> Definitely, in the end subsystems know best if there is enough time
> available (from everybody) to pull it off. I only meant to say that
> the security angle is not the only benefit.
> 
> For instance, like you said, the error handling, plus a bunch more
> that people usually enjoy: stricter typing, more information on
> signatures, sum types, pattern matching, privacy, closures, generics,
> etc.
> 
> Cheers,
> Miguel
