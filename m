Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD9716C96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjE3SeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjE3SeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:34:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1072BA7;
        Tue, 30 May 2023 11:34:20 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75b0f2ce4b7so291868385a.2;
        Tue, 30 May 2023 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685471659; x=1688063659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qa4jF8gD6T+NNa38IsN1JmAQxYqAomPe7DPAunUL4o=;
        b=ql+wQatGPF7LcqX0jFlH7s6anMdcyWo3DNZ06HzqoG4hJqDai7x1JxHWNCP3Bjrjfx
         d6bx/isWdm/oHQWGaq/tNfrWg1RHb3RLeaZg7WGSvA83gFAH7tzWq/n9zGByh/FvKKTe
         mHb6Xv1TiwzYFRGbCNtkSHQWGCCATm2O+hnGCKIFjYSY2QEzBiuGhSkzyEi/cPj3ggmd
         j36Nxcwjg7VZbc1fZ6J8eiO5UEeiGz57tzEJ05HxdWD9uKj3xUpKpadNG0WDCFB7t6sW
         KKyI8620eYRrKdaAsV0MeaUbGBap+KHx+dNL0gH6mhoQKCNXC0gE+czid373JmQbVAZi
         2Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685471659; x=1688063659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qa4jF8gD6T+NNa38IsN1JmAQxYqAomPe7DPAunUL4o=;
        b=OXrixCW4KDJFeG0IuVMEKZnL861ioL+NJh5i2Ud8ZlEsGnqt8tG6zpVei20kuhaV96
         HyCZf4LaaMTRrEhDdnmrfRSNJd6lECuJ0KXFyq2bh6DcXN0OJGrbbmJUG1tMKJY2V/YR
         s/c/AZGfOxi5rLJb9l7Q7iF8x7t45pegcvx38EeGckG1dzq1L31JbtN8GRc311J7BbFI
         IDBMpvdFb+EX6Y869p9Hv6zlG0WeVsW/LWhmCd0Ql2yZKOjHqHgJPXBdQe467NY5hBWq
         ks6K4pYjOpj+6d4RnuUouAcHNdBEHSY7eH6D+mEblqFjQztT0P+tVH8JcSWCQWxsKPPx
         1Zvg==
X-Gm-Message-State: AC+VfDy1DJ8eXWJx/5e5NQ37ZXxzd8SqMxngfBQqOU1y/D8dBjzf4chq
        vsMY+vOZu4Sx3W6vUd7S2z3DjMwHlVg=
X-Google-Smtp-Source: ACHHUZ6mH3YlDO4oKm7DbuCAoFQvZ0xAXEPjY6kImN8z9ZYZFKNBecPNW7FWMvgWtmvK3VnEZsqQ8Q==
X-Received: by 2002:a05:620a:480c:b0:75b:23a0:d9c1 with SMTP id eb12-20020a05620a480c00b0075b23a0d9c1mr3610605qkb.23.1685471659106;
        Tue, 30 May 2023 11:34:19 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a119300b00751517fd46esm4291420qkk.26.2023.05.30.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:34:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id D172D27C005A;
        Tue, 30 May 2023 14:34:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 30 May 2023 14:34:17 -0400
X-ME-Sender: <xms:qEF2ZA71774VKuqBqfXTSRrviBDgvr74wMcmZ-4y99LG_WAdetr0OQ>
    <xme:qEF2ZB4HNDfaloBrBjsoiD5CLtLxAiHok2MiTq0nwwkK3_syoHAUt6tGWBUJE_ioE
    McvR_K1CHVfhRDmow>
X-ME-Received: <xmr:qEF2ZPdTlMruQKR4OaIfk7B5CHa7iPAQbTuyRieQss5JWIvtz5886FUf-S4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:qEF2ZFIWL2Os_JrodusIf9PafYBpvwGVig9UXFhuH6_d1IgFQgWxVg>
    <xmx:qEF2ZELx9XQPaLrPCHAkzkcw8IZdcBuMI5ExeWdvGxG-Ys-bUF9K1Q>
    <xmx:qEF2ZGyhN-kvhq7hux4B-JgQmGfrti16cBUL3eemvGFG3wTQQhiitg>
    <xmx:qUF2ZB6iywnjM1LRZeA_PyyivZiq37nigJqOMKKy-8IARS0mjPqwOg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 14:34:16 -0400 (EDT)
Date:   Tue, 30 May 2023 11:33:13 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Viktor Garske <viktor@v-gar.de>, Finn Behrens <me@kloenk.dev>,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] samples: rust: add `SgTable` and `ScatterList`
 selftests
Message-ID: <ZHZBacreRpd0D/FV@boqun-archlinux>
References: <20230530064821.1222290-1-changxian.cqs@antgroup.com>
 <20230530064821.1222290-3-changxian.cqs@antgroup.com>
 <2023053003-antitoxic-popcorn-b1ab@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023053003-antitoxic-popcorn-b1ab@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 08:31:26AM +0100, Greg KH wrote:
> On Tue, May 30, 2023 at 02:48:21PM +0800, Qingsong Chen wrote:
> > Add a selftest module to provide a temporary place to put "pure tests"
> > for Rust funtionality and wrappers.
> 
> Is this for in-kernel tests, or userspace tests?  If userspace, you
> should follow the proper test reporting protocol the rest of the kernel
> uses.  If in-kernel, it should follow the format that the in-kernel test
> currently has to be consistent.  From what I could tell here, you aren't
> following either, but I might be totally wrong.
> 

It is for in-kernel tests, and you're right, we should follow the other
in-kernel test format.

Some explanation about the background: when I was working on this little
"test framework", the Github CI of Rust-for-Linux (ab)used sample/rust/
for testing, that's why it was put there.

Now my understanding is that Rust KUnit support is coming, so we should
use kunit tests if possible.

Despite where the tests are put, I'm personally happy that this patchset
comes up with some tests, which help the review ;-)

Regards,
Boqun

> thanks,
> 
> greg k-h
