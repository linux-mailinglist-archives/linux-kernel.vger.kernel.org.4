Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5477E601711
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJQTL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJQTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:11:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0177646211;
        Mon, 17 Oct 2022 12:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C854B81A1F;
        Mon, 17 Oct 2022 19:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7908C43142;
        Mon, 17 Oct 2022 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666033875;
        bh=tO7/kt0swniWp6AN8F5z4QekxmdDOMH5ltqVkHH8tJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o/rAfKpVRQvkY3TxYYC97bnbwI9hpdDb/iUiHBlpFgAvqY3ktJXvK4QDW/iszFXNA
         z8euNNs93j5391o4Xh1LDCQWBqn3Mgdc5UtBDeQSFTAGawJr2NKn+Ybwqlr2hL9C5C
         IJpcJELO9fc3zVGBHiFmD9tO+k9sFP2QAdwC/0C8vdePiqWH838SQruYhu/vWa+QZ7
         og2rYaiaZW9ZXvQn7QESbCx2cwiNoKwi3vwKWcclIcQAtpmasMS0kpL9gNwtX1weSW
         t+/23CST3fuf5anYDcV1sBBYwzHT10QOTCogC4qUybk6rwfVdEo7hZZWuxkTaFRgMU
         YrcB3hm6qCSzw==
Received: by mail-lj1-f180.google.com with SMTP id a25so15211585ljk.0;
        Mon, 17 Oct 2022 12:11:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Hqf/YPAiUJ+O+jnpLORxiWvHBNqhgfJdXDTNSnTgLu7iKehD3
        lWUz+S/9luq7CJPSmdKx8td4wLtpxhxGzKqw6zg=
X-Google-Smtp-Source: AMsMyM6ReGmue1UrWjjx0gRLm2Y/eII3tEd7FI1SW56Gj77wGe+3iLjgGtHDtB46XCNVCBN2nHO/rcVJ1y9163LIpaY=
X-Received: by 2002:a05:651c:4d0:b0:26f:cd9b:419f with SMTP id
 e16-20020a05651c04d000b0026fcd9b419fmr4342897lji.415.1666033873850; Mon, 17
 Oct 2022 12:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com> <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com> <798f0911-5c54-ebe0-9d44-64bec0c96a72@igalia.com>
In-Reply-To: <798f0911-5c54-ebe0-9d44-64bec0c96a72@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Oct 2022 21:11:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGxNP+hnN5yo9Pb_kQC+tcDn+9d30h5QNAUm3JYgoGiwQ@mail.gmail.com>
Message-ID: <CAMj1kXGxNP+hnN5yo9Pb_kQC+tcDn+9d30h5QNAUm3JYgoGiwQ@mail.gmail.com>
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 at 20:23, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 17/10/2022 15:14, Ard Biesheuvel wrote:
> > [...]
> >
> > So at that point, I wondered what the point is of all this complexity.
> > Do we really need 6 different algorithms to compress a couple of K of
> > ASCII text on a code path that is ice cold by definition? Wouldn't it
> > be better to drop the crypto API altogether here, and just use GZIP
> > via the library interface?
>
> Skipping all the interesting and more complex parts, I'd just want to
> consider zstd maybe?

I just made the point that it doesn't matter. So on the one hand, I
don't have any objections to ZSTD per se. But I do wonder if it is the
best choice when it comes to code size etc. Perhaps one of the
compression algorithms is guaranteed to be compiled in anyway?

> Quite fast and efficient - it's what we're using by
> default on Steam Deck.
>
> I'm not sure what is the gzip library interface - you mean skipping the
> scomp/legacy comp interface, and make use directly of gzip?
>

zlib_deflate() and friends.
