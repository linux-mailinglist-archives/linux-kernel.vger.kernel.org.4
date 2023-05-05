Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3606F8463
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjEENwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjEENwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:52:47 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E91A1;
        Fri,  5 May 2023 06:52:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f0596e2c00so7923391cf.3;
        Fri, 05 May 2023 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683294765; x=1685886765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FTALdX7Nnkocp+5SvXFDtr8E2n6vXaCaD3KmFZlzozk=;
        b=otKHgs1yXH9x6N/ntVsRRGrxF4wWyvAoWirL7W3UJ14FDyQslWs9wBupHxpqaaQhX/
         cU3fKe0hl7ytHioZ9Sx503LZnHGxge+2F2/defejthZmWM0nZmInDT8wBV6537i2a3Lc
         ylWu6nEvmR77CijZxRXS7WHP9G++Dd4F0TKhhVwhLUbUtHo2rtpuT/YoISsw0ni0eh0c
         AHA0932uMphEVKbTlPjWFei0hHnKcWAOygamnccbnshzSSIamFHA2lsb1Z/YDT8sxgwO
         g09SJGmYeHvxGUwC78UieNSC+57bI3jQhZmRWZbJiJXEPC0mfS96u5rS1m6mpIsP/uHh
         rCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683294765; x=1685886765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTALdX7Nnkocp+5SvXFDtr8E2n6vXaCaD3KmFZlzozk=;
        b=LCoUJTN4b588RpZO+QXLBsXqX7q4130L8RJdt+pAfgGXTWVojwGJ7+2pmx6deryLq5
         DRlMgHHNoIwArX5HMVZ1NBa6kMdYPJJCze3QXk8NbumolEPAtshJGqlgUxOJT4ijj7FN
         O5gneminO1vCjHof7JCh5TC6uy0Ro1TbqA34twz/7dtC0I+0Tl++q5yNLLNg6sAtPv6e
         WcIqzaXWIFFmn+AWM/DS2bZc/KjfcTRYxlitwNFb1Uk9lQIrSG1w6IfKHvFREvouJs0V
         I4H2jnjKpyUdD5X6gXSWQiamHfKda4a4Zq9EG7PLP+c1dVHFSkWj+/lvM9QG5Hv3uAjw
         fZLw==
X-Gm-Message-State: AC+VfDxDPR7P5z+NF2rVNgwF4NFRGLog99UPyYn7ZGmX0mp4wiCYkIp1
        BMRYnQrrvratDHFQ/25SBfE=
X-Google-Smtp-Source: ACHHUZ7cFbFHP7ifa8CiSQ3/SWaEQhllmp6AhRaFa+sZN4TY0Ibf3gyyOyazvQmklSS9o9xn2e4Umw==
X-Received: by 2002:a05:622a:100b:b0:3f1:b61f:bccd with SMTP id d11-20020a05622a100b00b003f1b61fbccdmr2808541qte.2.1683294765158;
        Fri, 05 May 2023 06:52:45 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d6-20020ac86146000000b003ee2fb84d0dsm635833qtm.11.2023.05.05.06.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 06:52:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0D9C827C0054;
        Fri,  5 May 2023 09:52:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 May 2023 09:52:44 -0400
X-ME-Sender: <xms:KgpVZEiDafBJz-w5hhTMphbdCbUbFpdj2zBFJM2aBdCnl0iKMqLJwg>
    <xme:KgpVZNCxNecpJp3MHfZzbSJaM0h616tK1JsC82UOA77k0RLrtEkPaZbG8KRjdlkld
    -F1rZGWOtnt4BuLAQ>
X-ME-Received: <xmr:KgpVZMHtvfKaR1RdDvMNTwR6Ct58Ulb3SAH-a7ILBgfXGwotT9L1TZGzvSRu2JHeC9_TMgKBXKFEylT_3BECJ4XaoTirXRvcTWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:KgpVZFQNSc9Y65-TChXhrfCTY5qe_Qb3aXI0z0nwdBA8AsugaIEAZQ>
    <xmx:KgpVZBzpx0FRF-DSF86aH-VLcpE45HtB-kW3fetfgKvJVvM7HzM0ew>
    <xmx:KgpVZD4FRExPJ2LMJ1Q6WZthRCY6oDQFKsudEResCO5di-R-OEnV3A>
    <xmx:KwpVZGymZkrRUeMnYbkJAgvUIqKqmh0k_2lAheTLG1Cf9TjzT030jw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 09:52:41 -0400 (EDT)
Date:   Fri, 5 May 2023 06:52:40 -0700
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
Message-ID: <ZFUKKMMmdBnDkE4S@Boquns-Mac-mini.local>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
 <80ed2c0e-54db-777a-175b-1aa3ff776724@kernel.dk>
 <CANiq72=3kGRy-3Lq5oxUEhu5d-377QrhuzhvoKRL+_QvbnJE7A@mail.gmail.com>
 <ZFT1mOQq0YllZl7V@Boquns-Mac-mini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFT1mOQq0YllZl7V@Boquns-Mac-mini.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 05:24:56AM -0700, Boqun Feng wrote:
> On Fri, May 05, 2023 at 12:53:41PM +0200, Miguel Ojeda wrote:
> > On Thu, May 4, 2023 at 10:22 PM Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > Right, but that doesn't really solve the problem when the rust bindings
> > > get in the way of changes that you are currently making. Or if you break
> > > them inadvertently. I do see benefits to that approach, but it's no
> > > panacea.
> 
> One thing I want to point out is: not having a block layer Rust API
> doesn't keep the block layer away from Rust ;-) Rust will get in the way
> as long as block layer is used, directly or indirectly, in any Rust code
> in kernel.
> 
> Take the M1 GPU driver for example, it can totally be done without a drm
> Rust API: Lina will have to directly call C funciton in her GPU driver,
> but it's possible or she can have her own drm Rust binding which is not
> blessed by the drm maintainers. But as long as drm is used in a Rust
> driver, a refactoring/improvement of drm will need to take the usage of
> Rust side into consideration. Unless of course, some one is willing to
> write a C driver for M1 GPU.
> 
> The Rust bindings are actually the way of communication between
> subsystem mantainers and Rust driver writers, and can help reduce the
> amount of work: You can have the abstraction the way you like.
> 
> Of course, there is always "don't do it until there are actually users",
> and I totally agree with that. But what is a better way to design the
> Rust binding for a subsystem?
> 
> *	Sit down and use the wisdom of maintainers and active
> 	developers, and really spend time on it right now? Or
> 
> *	Let one future user drag the API/binding design to insaneness?
> 

Ah, of course, I should add: this is not the usual case, most of the
time, users (e.g. a real driver) can help the design, I was just trying
to say: without the wisdom of maintainers and active developers, a Rust
binding solely designed by one user could have some design issues. In
other words, the experience of maintaining C side API is very valuable
to design Rust bindings.

Regards,
Boqun

> I'd rather prefer the first approach. Time spent is time saved.
> 
> Personally, my biggest fear is: RCU stalls/lockdep warnings in the Rust
> code (or they don't happen because incorrect bindings), and who is going
> to fix them ;-) So I have to spend my time on making sure these bindings
> in good shapes, which is not always a pleasant experience: the more you
> use something, the more you hate it ;-) But I think it's worth.
> 
> Of course, by no means I want to force anyone to learn Rust, I totally
> understand people who want to see zero Rust. Just want to say the
> maintain burden may exist any way, and the Rust binding is actually the
> thing to help here.
> 
> Regards,
> Boqun
> 
> > >
> > > This seems to assume that time is plentiful and we can just add more to
> > > our plate, which isn't always true. While I'd love to do more rust and
> > > get more familiar with it, the time still has to be there for that. I'm
> > > actually typing this on a laptop with a rust gpu driver :-)
> > >
> > > And this isn't just on me, there are other regular contributors and
> > > reviewers that would need to be onboard with this.
> > 
> > Indeed -- I didn't mean to imply it wouldn't be time consuming, only
> > that it might be an alternative approach compared to having existing
> > maintainers do it. Of course, it depends on the dynamics of the
> > subsystem, how busy the subsystem is, whether there is good rapport,
> > etc.
> > 
> > > Each case is different though, different people and different schedules
> > > and priorities. So while the above is promising, it's also just
> > > annecdotal and doesn't necessarily apply to our case.
> > 
> > Definitely, in the end subsystems know best if there is enough time
> > available (from everybody) to pull it off. I only meant to say that
> > the security angle is not the only benefit.
> > 
> > For instance, like you said, the error handling, plus a bunch more
> > that people usually enjoy: stricter typing, more information on
> > signatures, sum types, pattern matching, privacy, closures, generics,
> > etc.
> > 
> > Cheers,
> > Miguel
