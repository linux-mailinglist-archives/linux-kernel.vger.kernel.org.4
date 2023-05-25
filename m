Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD071111F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjEYQiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjEYQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:38:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3366195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:37:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3a611b3ddso1478514e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685032678; x=1687624678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNfCUobrUAUA40iHcw/nxcay95zNsz3B8ogepnZvesE=;
        b=hX9uByaQAh6r7X5V2dES+20lCPIMCD6w+iaY0Oj7clZFaG3SjaSngMzrGlXDwHWFzR
         8xr+Ny07W3tUaqCSSj4yeJeeVqij7mvecUolAWpEHfaZdpFY3ULu2JHC6sfO+OA5sHhC
         87AY24b8aRCM0dRqEzwlYt+J3n/dHAgHZJ7Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685032678; x=1687624678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNfCUobrUAUA40iHcw/nxcay95zNsz3B8ogepnZvesE=;
        b=GPa3Jc31fB+i9h8MVbpPnaGy07qKsZz+5kEDWEtKgITliOdkyaQ+HyzY3H7xzGM4yp
         s5cx7dBn+Z1MaeCd2z/XmFMfXicj0CxLPvKJQJlRZt+5BfCMEVKKu2vilDZOZR97Lfmi
         55JXPbSzrMuQcM/GeW3PslAQM7H7ZRbFb7/t6jhQR07dMsPFgMptUm6FipuOKQbk4Adn
         IVScq4+PozqOJqTgadNDAftV2VK1N4VJ8ldt4ItyS9guAHgOOOWts+b7VztnDI0GYoWD
         2902oB9zJXfo3SFEwQyszzx45jrnSCHSGltdmsX+sTL2GN2aWgh4+a9SfLHX7wDu81pw
         Hmig==
X-Gm-Message-State: AC+VfDwnIYjFUhDUosN6junqmgHavyrm5AdGiDD4fHCHdffrNIvgyNA0
        GACsUmrnuU40b/o2Uu05DP11MYCTGgpN3rYq7XyeaAE7
X-Google-Smtp-Source: ACHHUZ6VPqV9nt/EEzRnVYbVCdKB2LVoEoXfP5ZyzPw0MNG81yti+g2+E8ixHdUQUVe+KOwLGFBXfw==
X-Received: by 2002:ac2:5630:0:b0:4f4:c6df:22a0 with SMTP id b16-20020ac25630000000b004f4c6df22a0mr868442lff.18.1685032677758;
        Thu, 25 May 2023 09:37:57 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004edb8fac1cesm263084lfc.215.2023.05.25.09.37.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:37:57 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f3a611b3ddso1478491e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:37:57 -0700 (PDT)
X-Received: by 2002:a17:907:a407:b0:96f:5511:8803 with SMTP id
 sg7-20020a170907a40700b0096f55118803mr1880847ejc.22.1685032321217; Thu, 25
 May 2023 09:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org> <3215177.1684918030@warthog.procyon.org.uk>
In-Reply-To: <3215177.1684918030@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 09:31:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
Message-ID: <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, May 24, 2023 at 1:47=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> True - but I was thinking of just treating the zero_page specially and ne=
ver
> hold a pin or a ref on it.  It can be checked by address, e.g.:
>
>     static inline void bio_release_page(struct bio *bio, struct page *pag=
e)
>     {
>             if (page =3D=3D ZERO_PAGE(0))
>                     return;

That won't actually work.

We do have cases that try to use the page coloring that we support.

Admittedly it seems to be only rmda that does it directly with
something like this:

        vmf->page =3D ZERO_PAGE(vmf->address);

but you can get arbitrary zero pages by pinning or GUPing them from
user space mappings.

Now, the only architectures that *use* multiple zero pages are - I
think - MIPS (including Loongarch) and s390.

So it's rare, but it does happen.

             Linus
