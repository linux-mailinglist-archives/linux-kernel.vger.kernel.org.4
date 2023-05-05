Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDDA6F8B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjEEVrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjEEVrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:47:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE1B5FCD;
        Fri,  5 May 2023 14:47:27 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-55a14807e4cso41183697b3.1;
        Fri, 05 May 2023 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683323246; x=1685915246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvdowzOHeTXQwWFXBaRl5zQyQlspUjEq1JSPOTsC1Wc=;
        b=c/9ssS17ygEIXrjB8ms2tCiAauSNkrwY3FrgLn0D4OGpJl3juPuZJhnyb0JmoBmYni
         ETFaF7dTfqcXfSqQu0ubAWwUgEOHVpTrEkyKZkvwt79nUSdjGp3pWnOCs7wm6TLhWmGe
         PRSs7yqpoLqTURBcqejEOQEPBkthVBfDd1h6Lx3f6OaNcc8IySO1QrIeC4aq4UoyAZj2
         WLslZ7g5pGxZQxY8KDWw1GhuzL7CJHM71gcTLGvw88r+Ln+i7VCIlwpwwgFBaGxK8vQP
         GdPRs4Jgccsra0RD96j+c3O/Jz0FA0Sf48OdKtkQTynk8oBps/WjadB0bHc8GLSMHi2c
         azAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323246; x=1685915246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvdowzOHeTXQwWFXBaRl5zQyQlspUjEq1JSPOTsC1Wc=;
        b=U0knbndYk8I4xS3F9sBUu1E2JDK8vG+9boaenyRD8DMTPxZQuD3K6lqcd2G1si7/Sb
         5ATqzJGSQ3zgTBcLQxi+lkLs5IymLGyvcnC3G6710fzUgqFLo2t/Rfwc3a2WkbZqSZdH
         H5EuZjTZF+HlzEOISXPc7KoUBtbtdULOecw/qZXIHgcMSks9VntaTprq7QF9IRT74kOt
         U9pcXoE1bu4+FO0ywdK0KphNNWcOeInXWkE6aBy2QNTf+p5gIQop/69QbzHIsLHQMKAt
         XibW7Y0MLFZvSfRdBbAr/Hoa1YyahFu9z+qKE1uaZfPHEwK7yk1cSCMhCcynDQjJ4zTh
         +69Q==
X-Gm-Message-State: AC+VfDwyPTtWBFrnDivG0IDQTwE13/J6v2etECB4h+Cg4b6aX/nb0vxm
        aig9zQXvuQ5ZaVHcXNdix0Bb3eWn6io=
X-Google-Smtp-Source: ACHHUZ66ftSX4i7hbbPSR3DK3+7rOK5fIi/dVvwoFHwbdOXcz+DBdCps2CahNWCWdvpN3vQUAJJkPw==
X-Received: by 2002:ad4:5b84:0:b0:5ea:922:bea9 with SMTP id 4-20020ad45b84000000b005ea0922bea9mr3890271qvp.14.1683323225820;
        Fri, 05 May 2023 14:47:05 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t17-20020a0cde11000000b0061b698e2acesm902736qvk.18.2023.05.05.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:47:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8CFE427C005A;
        Fri,  5 May 2023 17:47:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 17:47:04 -0400
X-ME-Sender: <xms:V3lVZJ9EaSeFMeC4hvnPgsdMB1bmqJnnwbBZm92tK-RVC6HFpmOalA>
    <xme:V3lVZNstA8h5kNOOjiLW5IzUbk5AKCHVPd6MBuT_004NZHWge5HUUDbVTm58DtHXe
    cduZUFO-tTgIiEsLQ>
X-ME-Received: <xmr:V3lVZHCg0SsdbD248LS8GYMDYHEcsbj8FgQFML9mQjg7pABuBaKn8LNarr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:V3lVZNdbiUqEBK1U70KWkAYCgpEnQIj6hJDc_zxU3swojKVfs5dNuA>
    <xmx:V3lVZOMId30i86Lv_VOwQu8DjAmqNDLLrKVD3pfx-C2X-n9vDiLloA>
    <xmx:V3lVZPlW1emwRpkFQ5_pB6ub8LXhknrD6Tq84JA570W0Dg3tIaddnA>
    <xmx:WHlVZKvnzdGWwdD9NTDR2GlJbVsrXA9WuxCpml6FnPcqGBzLSvobOg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 17:47:02 -0400 (EDT)
Date:   Fri, 5 May 2023 14:46:58 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <ZFV5UicPNkNE4g3I@boqun-archlinux>
References: <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
 <80ed2c0e-54db-777a-175b-1aa3ff776724@kernel.dk>
 <CANiq72=3kGRy-3Lq5oxUEhu5d-377QrhuzhvoKRL+_QvbnJE7A@mail.gmail.com>
 <ZFT1mOQq0YllZl7V@Boquns-Mac-mini.local>
 <ZFVcMtRFoaEK/PqY@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFVcMtRFoaEK/PqY@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 01:42:42PM -0600, Keith Busch wrote:
> On Fri, May 05, 2023 at 05:24:56AM -0700, Boqun Feng wrote:
> > 
> > The Rust bindings are actually the way of communication between
> > subsystem mantainers and Rust driver writers, and can help reduce the
> > amount of work: You can have the abstraction the way you like.
> 
> We don't have stable APIs or structures here, so let's be clear-eyed

Of course, but every API change need to cover all in-tree users, right?

> about the maintenance burden these bindings create for linux-block
> contributors. Not a hard "no" from me, but this isn't something to
> handwave over.

Not tried to handwave over anything ;-) The fact IIUC is simply that Rust
drivers can call C function, so say a in-tree Rust driver does something
as follow:

	struct Foo {
		ptr: *mut bio; // A pointer to bio.
		...
	}

	impl Foo {
		pub fn bar(&self) {
			unsafe {
				// calling a C function "do_sth_to_bio".
				// void do_sth_to_bio(struct bio *bio);
				bindings::do_sth_to_bio(self.ptr);
			}
		}
	}

That's an user of the block layer, and that user could exist even
without Bio abstraction. And whenever a linux-block developer wants to
refactor the "do_sth_to_bio" with a slightly different semantics, that
user will need to be taken into consideration, meaning reading the Rust
code of Foo to understand the usage.

Now with a Bio abstraction, the immediate effect would be there should
be no Rust code is allowed to directly calls block layer functions
without using Bio abstraction. And hopefully Bio abstraction along with
other bindings is a place good enough to reasoning about semanitcs
changes or refactoring, so no need to read the code of Foo to understand
the usage. Of course, some C side changes may result into changes in
Rust bindings as well, but that doesn't make things worse. (Need to
understand Foo in that case if there is no Rust bindings).

Of course, this is just my 2 cents. I could be completely wrong.
(Put the Rust-for-Linux hat on) Needless to say with or without the Rust
bindings for the block layer, we are (at least I'm) happy to help on any
Rust related questions/bugs/issues for linux-block ;-)

Regards,
Boqun
