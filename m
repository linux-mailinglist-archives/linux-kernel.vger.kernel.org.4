Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2673E55C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFZQjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFZQjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:39:24 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758A412B;
        Mon, 26 Jun 2023 09:39:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so8225667a12.1;
        Mon, 26 Jun 2023 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687797562; x=1690389562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0YJn0nHiYyufMIyUTdFjE9mnzWA8s9uE9k4SjNMK5s=;
        b=GZeizG6Y4PaChSHpvyiDYh3iTPUXokimKII0T07Fur1zyhiQSfhWhHxMh5ivPLEXyh
         sxXLs62NU1jalfM3KweVDlbLrD/BdGsrn9juk0+DKDKwZJZbXY4cYprCIbRgq8VI3knM
         lMRNTD6R8+j8aOUmhrqtIPNGxRDKqbQtGsMWvHYRZNIEXg2FUXH6ijYQW91JZIDE89QJ
         Ca9fFrCarTkJwPKS7iYHcC0F0rgNu/Dsz5RYyU78ocmeDeHksxI5Uq0KAqhQAt/c8/dk
         lD+Ckkx8M7UilUv0LxdbReBAqLioQAXP9V/8gO3EqkUJ4VfTbGFxPPeeBvHdXe76JpdA
         r9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797562; x=1690389562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0YJn0nHiYyufMIyUTdFjE9mnzWA8s9uE9k4SjNMK5s=;
        b=FlqpCbfdkJK8jyS81nQPjKQmwwECH3yhIlbTZ6j5ImKT6vXoFdfr+fqEhpVbzbC1nt
         Paqm4kUCi2lNvjJs9q5VPjpocwyc7mq7/ykeKHOtAZEty9VDn8LjF7wYmeL/ST9QkqR8
         qxZTXwYi4b6/a6LOoa1sM2UXLPDcIPhuIku/8f6KN7qLVgIjZ6JDNWljGbQhzBdqg0VR
         15aDrB0EN8rWRFb5OpB7XUedZWZ9CESC/o10suGoOc6PAwXHiEogCso44qmj66tyN5qh
         rsvf4cliLPz2tCIJ7wHnODIY8plnPKZInv78jxhQR7AHqfd91lWJKu2Ak6V2kv+RoVIs
         VdWA==
X-Gm-Message-State: AC+VfDx7XJLEwj6ta9jmdup+KqiFqi5Lkr3LeT9XdjLXotHReFDdAUES
        5SkpBQCLC0Q2nGb5macuqQ0=
X-Google-Smtp-Source: ACHHUZ65FFaYZOMnb2NYEdhtimMGXfw91PZindVZLIjmgybiR9JefPGCDY+RV9uFwfDZqd3ZieDw0g==
X-Received: by 2002:a05:6402:270d:b0:51a:4451:564d with SMTP id y13-20020a056402270d00b0051a4451564dmr25044141edd.18.1687797561651;
        Mon, 26 Jun 2023 09:39:21 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id ba30-20020a0564021ade00b0050a276e7ba8sm2953327edb.36.2023.06.26.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:39:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5FE7627C005A;
        Mon, 26 Jun 2023 12:39:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Jun 2023 12:39:18 -0400
X-ME-Sender: <xms:Nb-ZZL4cxwuLPB28WdMRhXyN53-nCpzZfdLhy0_FVECm2cpmlrLCNA>
    <xme:Nb-ZZA4NuHJKkJsaKGnZzZiIxxT_GyrMsfMFrjaQNfbgYthKe3sn_qPP_SXKyJdp0
    Yh8_ow9BkqjlSvRhA>
X-ME-Received: <xmr:Nb-ZZCd7YFh9b9NXR7HdhnBF_SbCg5u4pDb5mSIFOAB_M5EEntf_RPWrnrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehfedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Nb-ZZMLlkO7Lvey32xt8ybJLJygn0khKdROc9886KocXLOvjB1jmnw>
    <xmx:Nb-ZZPLjOQnGQR-0lu88oGXvVXYsY8yUFKTJEc-xcowStd3v6xg5_g>
    <xmx:Nb-ZZFwWcHC04-RFR2BsVJgV7zj0dMSWrlXNARJIciBzcWWmL1lfhw>
    <xmx:Nb-ZZBimgrgAUW4qmT5bB5__sto9yvkt54t70oe6zr76EF_qDC3Z_Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 12:39:16 -0400 (EDT)
Date:   Mon, 26 Jun 2023 09:39:01 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] rust: kernel: add basic abstractions for
 device-mapper
Message-ID: <ZJm/JfIPMrgXkYpp@boqun-archlinux>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
 <20230625121657.3631109-2-changxian.cqs@antgroup.com>
 <2023062544-speech-impish-9308@gregkh>
 <c720663e-8743-956d-2ece-c9ca23f94d3a@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c720663e-8743-956d-2ece-c9ca23f94d3a@antgroup.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:26:12AM +0800, Qingsong Chen wrote:
> On 6/25/23 8:25 PM, Greg KH wrote:
> > Shouldn't this be all different commits, and different files?  A bio
> > shouldn't be defined in the device_mapper.rs file, as that would prevent
> > anyone else from accessing it.
> 
> Yes, you're right. Since we noticed that some block layer patches[1]
> are under review, we don't put much effort into that. Actually, we
> don't want to include all the `bio` implementation in this patchset,
> so it just some dummy codes.
> 
> If necessary, a seperate commit could be splited, including things
> that do not belong to the device mapper.
> 

Maybe you can just base on one or all the patches from Andreas' series
(and mention the dependency in the cover letter)?

Regards,
Boqun

> [1]: https://lore.kernel.org/rust-for-linux/20230503090708.2524310-5-nmi@metaspace.dk/
> 
> Thanks,
> Qingsong Chen
