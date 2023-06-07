Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47789726712
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjFGRUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjFGRT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:19:58 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129AE1725;
        Wed,  7 Jun 2023 10:19:57 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f9b1f43bd0so23579121cf.0;
        Wed, 07 Jun 2023 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686158396; x=1688750396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH5f7Jv4iQPlTMfbAHE6RS0udww2Ru879vIYjDJbT6k=;
        b=KaeC7xfEiotvSfP14IjbqKALm4pzt+sOY5LxGSvKV340X2pC+Uvi65yAyA3tbtPNgx
         lTmBCmR/Isgs9msWDwav63X1YQtA63Vdn1X6K/iJoLynZhFF4PdV1Wylh/F+IGlomIHv
         rO9m69N3ASYqZa3IDYy+NKzIYVFcCXAYpdHRz9BMh/83oLQxKzqX+8pyLVbGn3sdI2WS
         XCby6EncINE1NktAmvOsBHU41ff6uUsnmQqr1PCOo+Ntit4TnEAg+F9Welo3cPCJ23/3
         2XWdbiscWeTHsPXymsHMu1Kx4hymxZ4VzcWArlAZblm+ibSPUSbi5Tbqk5LybgWi6Cws
         NkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158396; x=1688750396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH5f7Jv4iQPlTMfbAHE6RS0udww2Ru879vIYjDJbT6k=;
        b=Eu30+kIFbF0NrAVjsPxcigKX57VrWNDXgb+uVAOruKyVw8lWK/4075ISrHmSG4FjJU
         zWUUf4EC5jtIJH9judnKYZvrWzoNwNh1A/Jx5nMXAIUeT4zaSrdLfS9qDxGg78J5RtJF
         Beq5NdTe2bnN7ms/yVrIVWpiRP1KtWpAZRzHcVAWDxP5CbVrYUQ2D1TN824buTiy9dXB
         WUS9H3uIZWZJBfdEVxKBI4COEeTMczQUsQbozYdPx8AIrdcsgnjCYx7yFo0zVBW2gobC
         iNEbFlnj3QjQwwh9uE4lhxv9+8mqconoy+1fbHWtJQR4JPRmLm56jFpdEl05fQx+UFlQ
         h0uw==
X-Gm-Message-State: AC+VfDx7TRr/1ILot6j+joot0Q8Bu2nVu28jxn4h/x1C4bAOwt9JYT2F
        7dFNvf17t5R3Rh+wF3IzBNA=
X-Google-Smtp-Source: ACHHUZ7QBsFQkmnN1qHD5DnM1JWPMxx2OuD7EZ/HmWXsKgjVYOhfWHqBAwdQM0JbS7gVhMUBFwyVpw==
X-Received: by 2002:a05:622a:178e:b0:3ec:490b:ce6e with SMTP id s14-20020a05622a178e00b003ec490bce6emr5055623qtk.48.1686158395951;
        Wed, 07 Jun 2023 10:19:55 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id cj22-20020a05622a259600b003f3937c16c4sm72933qtb.5.2023.06.07.10.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:19:55 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 83F0627C0054;
        Wed,  7 Jun 2023 13:19:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 07 Jun 2023 13:19:54 -0400
X-ME-Sender: <xms:ObyAZFZxbEAWWuKpXL6AqInOQtX_dF2xR0wmWgC4o0D2NbLr1j5zEg>
    <xme:ObyAZMahPTMGffmB5TkLV0nyr87J0dh4YZPD4zkwyIfUKEA8qUx366GmtOUMoSHMN
    nXTSEb3IH7LnE1asA>
X-ME-Received: <xmr:ObyAZH8dfv5V1Y28F-OmM__UpvXwBF81eHx1r38XAwDeCXJpE4uYMjvh5Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdt
    keeihedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ObyAZDoVKkIVG33XXLk2iizFciTW0-cbG4iSqPFTwHZAEt5CrWc-hQ>
    <xmx:ObyAZArquBRtlIgE6F34ECyQJKvpbbUe-AhWyIEO1VQnKnwQI-19iQ>
    <xmx:ObyAZJQ-H-PgJSXmjXuy7K_4hm8rnIZp9SfzwUGMF9y5qnqPzQOFJg>
    <xmx:OryAZGjlMEz41Bibcn1JqrsmgKtSM42oGgWnPAvPZgJhb-b0cGUfUA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 13:19:52 -0400 (EDT)
Date:   Wed, 7 Jun 2023 10:18:26 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: kernel: add ScatterList abstraction
Message-ID: <ZIC74gLDC1pLIx+Z@boqun-archlinux>
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
 <20230602101819.2134194-2-changxian.cqs@antgroup.com>
 <ZH3+jARBbn2iG1dW@Boquns-Mac-mini.local>
 <fe4744bb-17db-6f60-4b8c-1453009ef11a@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4744bb-17db-6f60-4b8c-1453009ef11a@antgroup.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:01:30PM +0800, Qingsong Chen wrote:
> On 6/5/23 11:26 PM, Boqun Feng wrote:
> > On Fri, Jun 02, 2023 at 06:18:17PM +0800, Qingsong Chen wrote:
> > [...]
> > > +impl<'a> ScatterList<'a> {
> > > +    /// Construct a new initializer.
> > > +    pub fn new(buf: &'a Pin<&mut [u8]>) -> impl PinInit<ScatterList<'a>> {
> > > +        // SAFETY: `slot` is valid while the closure is called, the memory
> > > +        // buffer is pinned and valid.
> > > +        unsafe {
> > > +            init::pin_init_from_closure(move |slot: *mut Self| {
> > > +                (*slot).set_buf(buf);
> > > +                (*slot).mark_end();
> > 
> > Benno can provide more information, but you cannot dereference or create
> > a reference to `*slot`, since `slot` points to an uninitialized object
> > (see `try_pin_init` implementations), and referencing uninitialized
> > objects is UB (or may cause UB).
> 
> I understand that `reading` from uninitialized objects is UB, either
> via references or raw pointers. But in this unsafe closure, we just do
> the `writing` job to `slot` for initializing. This makes me a little
> confused, why is there a difference between reference and raw pointer?

References (or the existence of the references) mean the underlying
objects are valid:

	https://doc.rust-lang.org/std/primitive.reference.html

, so creating a reference (even a temporary one) to an uninitialized is
an UB, that being said..

> Is there any compiler magic on reference which may cause UB? Still, I

I'm not creative enough to come up with a compiler optimization that
will (ab)use this UB to do evil if you can be sure that set_buf() and
mark_end() are purely writes. So your confusion looks reasonable to me
;-) But still it's an UB. And I guess you don't want to be suprised by
any future compiler optimization, right? ;-)

Regards,
Boqun

> would fix this by `addr_of`. Thanks.
