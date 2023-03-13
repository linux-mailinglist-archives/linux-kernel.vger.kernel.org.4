Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E710C6B7FED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCMSGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:06:23 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E16A303EE;
        Mon, 13 Mar 2023 11:06:22 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d7so14066262qtr.12;
        Mon, 13 Mar 2023 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678730781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBPezHniAB5CPc6kCyPETjZBNEEImPV7AJtKEga0h/M=;
        b=Y30uN0HT5bcXZ8ePBOstL9ELHoJvu+5CvU7UU7H5yxUR+4l/5p0Wq23Y4iMMsDtiJz
         DRioR8krhgAOE2DxsISBEkeJsA8F4DJLwU0WV510bOFiRu5z/LFHGEeStZWTsVIbe9Q+
         vKb0J5EHPIczPwqJDDMVBPQgZnkNtzDZJevxuXqA+TOa3ekpdFf2EC6NWjahVkyA0CZk
         aX1oHd9ZKnKNj0lnGXZJ3UiVxlTmhzOdDCDsXvrfSiHzmpKqqq+S2+XokRBZd8Ce+mmB
         r+cNUACcYlFN7QcnELHOZ6c43pCQszfAguRjkGX5hHZXoIgeUV6XzA/GNYDk1IGfk64v
         Qv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678730781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBPezHniAB5CPc6kCyPETjZBNEEImPV7AJtKEga0h/M=;
        b=x5TdSYnLhexJaBfM738b0GfIGJo1rlqim6JcT+xrSEkqV6NXfeZr3y6S8y1TTTlMFu
         dXZtpUrp18UVqhF5PL7FXEhOJqpAaY3PEs/83nrV0JGDLRVYNab7tG3izPPv/0ByaxH2
         2fQuEpZyZjf0S1i9eh9q5a49o+qTxkbyPHOc8rUh4Jb28rE7tKq2KwDcg+pGjDvysRds
         /NeJXJbjHX7vEzPj64dgHz11s3eLaj7BD2PlG0qB8ZiYi4HgfFk3kdfR9jTv2jRwimwq
         jCCFRmfPu/IaxSC5SrYl8uewlpaXEke7TLyCFkbrKUk9kKxY6jVF2gT1uavFWgnzOikk
         nnFw==
X-Gm-Message-State: AO0yUKXhCad5E6+9LiBU1LlIlU0LigQaO8odM2VR8ddL6bEX1sW+gxhg
        e5KkUw4Q8XgessBRAuMg698=
X-Google-Smtp-Source: AK7set/d2VSdo2tDZCtTxqBG2QOV+vJvY7KS/FUBsg2RfeyrvWr5f4Lis1spEwcqJVnCzM3MTIaGKQ==
X-Received: by 2002:a05:622a:1a01:b0:3bd:1a8a:8015 with SMTP id f1-20020a05622a1a0100b003bd1a8a8015mr57765677qtb.16.1678730781684;
        Mon, 13 Mar 2023 11:06:21 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f3-20020a37d203000000b0073b4a55a2d1sm128091qkj.124.2023.03.13.11.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:06:21 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A72A227C0054;
        Mon, 13 Mar 2023 14:06:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 13 Mar 2023 14:06:20 -0400
X-ME-Sender: <xms:GmYPZLVLDdvoPalmbHhjU7DAUSycTgdiRxoJPz6rDQr5shVHGfmAww>
    <xme:GmYPZDn2fz-z9m-20ST9wDZEYk0VWh7LhZwHYWnzryH8tWY7j9f1bj4vu_0HumEZe
    ty0cw7seloFlSN0Tw>
X-ME-Received: <xmr:GmYPZHZkn2KvXeIZWDJik9jgdeIIJB-SbSBM6oSgaKRN-27UfEoNSyX_XZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:GmYPZGU2y2ebUk1w8a8OqwvPjHQL2jralnaZ-N8O86srZcCUaMfXgQ>
    <xmx:GmYPZFmrxLvNS-0TdjxrLFFYHkUY1fwbNr0aU5fo1jwmEpCM7ca_NA>
    <xmx:GmYPZDeHoUnXAhjCOwcy2kEDqc0iC6vYpvTVM5JnbwU44wjWt6XQDA>
    <xmx:G2YPZEftKxq6Pi30Wji_FgJX3YqSgDDaH60inewR8SF2I-pme7lL5g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Mar 2023 14:06:17 -0400 (EDT)
Date:   Mon, 13 Mar 2023 11:05:04 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
Message-ID: <ZA9l0EHCRRr/myoq@boqun-archlinux>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <20230313175202.300bb1f4.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313175202.300bb1f4.gary@garyguo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 05:52:02PM +0000, Gary Guo wrote:
[...]
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 9be021e393ca..e57da622d817 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -4,7 +4,7 @@
> >  //!
> >  //! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
> >  
> > -use crate::bindings;
> > +use crate::{bindings, str::CStr};
> >  
> >  /// A raw device.
> >  ///
> > @@ -20,4 +20,78 @@ use crate::bindings;
> >  pub unsafe trait RawDevice {
> >      /// Returns the raw `struct device` related to `self`.
> >      fn raw_device(&self) -> *mut bindings::device;
> > +
> > +    /// Returns the name of the device.
> > +    fn name(&self) -> &CStr {
> > +        let ptr = self.raw_device();
> > +
> > +        // SAFETY: `ptr` is valid because `self` keeps it alive.
> > +        let name = unsafe { bindings::dev_name(ptr) };
> > +
> > +        // SAFETY: The name of the device remains valid while it is alive (because the device is
> > +        // never renamed, per the safety requirement of this trait). This is guaranteed to be the
> > +        // case because the reference to `self` outlives the one of the returned `CStr` (enforced
> > +        // by the compiler because of their lifetimes).
> > +        unsafe { CStr::from_char_ptr(name) }
> > +    }
> > +}
> > +
> > +/// A ref-counted device.
> > +///
> > +/// # Invariants
> > +///
> > +/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
> > +/// `self`, and will be decremented when `self` is dropped.
> > +pub struct Device {
> > +    pub(crate) ptr: *mut bindings::device,
> > +}
> > +
> 
> Shouldn't this be
> 
> #[repr(transparent)]
> pub struct Device(Opaque<bindings::device>);
> 
> ?

I have the same feeling, for `task_struct`, we have

	#[repr(transparent)]
	pub struct Task(pub(crate) UnsafeCell<bindings::task_struct>);

and
	
	pub struct TaskRef<'a> {
	    task: &'a Task,
	    _not_send: PhantomData<*mut ()>,
	}

I wonder whether we should do the similar for `Device`, meaning `Device`
is just a tranparent representation for `struct device` and another
type (say, `DeviceRef`) is introduced as the reference type, or we can
just use `ARef`.

Regards,
Boqun



> 
> Best,
> Gary
