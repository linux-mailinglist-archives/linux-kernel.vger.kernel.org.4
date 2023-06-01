Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9332B719CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjFANJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjFANJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:09:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7FE7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:09:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so1303168a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685624974; x=1688216974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGLeNL4xyVWCzs5LFhZzIMiXdkid2+oUWl2Rt0i8z+U=;
        b=KM71FxQkhuCtTMGGWiWYBAzAbtxhLH88ZlN+MyRy2N8QngJe39QtlpcVLxM1ho6S6b
         XNuqd3EwfJyffpJtz1Pnu78Lc+opffulOzPdP86t3TK8meFA+nKCurJ9cEmmFY4vWvTe
         asM1KsDs+fBxS1q0X8slyE8vfNQcJPyGVM4nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685624974; x=1688216974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGLeNL4xyVWCzs5LFhZzIMiXdkid2+oUWl2Rt0i8z+U=;
        b=bFmSGVv8Z47Gd27sUbJzQgV6g98jZsJtAS+rB4GWIkewVdVToRpt0LRCSaDvgzmBA1
         Yll7Lj/dCeUWPw05qHwfowQu0X+1e8jCUknz92oz0f85aY0lthJphpBY5VJe0oyXMqny
         ewZqS0Asx66BAog8d3UXn+85mpWOqjpbEIh/vzV7Q/0l67tbBTkvfO5a8lyYOuZ+MWSN
         cVTS4HWMtRdohh1xEUr/ta5UAn7y+cKPUHie1YgxNG2NZ2c0t1R/9ek6Yak3iVxy9vZv
         AWubdF/RuTKFEb8iLVVWwa/n6g09DNekXZcPcP1fEWYonbAinFPNgFRCmoRK37zwPt/8
         Txhw==
X-Gm-Message-State: AC+VfDz+oR3V1bHJPnk8MlA9ig4bBgtCGoL1g9nlUMHpR8cBrX1LvmYa
        vV9Ck7H8aGvhr8o9ChsF2vdn8Nc41A+7DjBtpKITmsWI
X-Google-Smtp-Source: ACHHUZ6nOU2eTGDAD1B3QE48o+xAnhBiG+fdUSYKV9DNYToDmZBurWufp6AzAp6xTR9BO3emiE6nrw==
X-Received: by 2002:aa7:d9da:0:b0:510:f6e9:6d92 with SMTP id v26-20020aa7d9da000000b00510f6e96d92mr6228428eds.0.1685624974501;
        Thu, 01 Jun 2023 06:09:34 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id v5-20020aa7d805000000b005149134ccfbsm6657750edq.52.2023.06.01.06.09.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:09:33 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-96f50e26b8bso118294466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:09:33 -0700 (PDT)
X-Received: by 2002:a17:907:9722:b0:95e:d448:477 with SMTP id
 jg34-20020a170907972200b0095ed4480477mr8993487ejc.33.1685624973235; Thu, 01
 Jun 2023 06:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com>
 <20230526180844.73745d78@kernel.org> <499791.1685485603@warthog.procyon.org.uk>
In-Reply-To: <499791.1685485603@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jun 2023 09:09:16 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
Message-ID: <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
Subject: Re: Bug in short splice to socket?
To:     David Howells <dhowells@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 6:26=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> When used with sendfile(), it sets SPLICE_F_MORE (which causes MSG_MORE t=
o be
> passed to the network protocol) if we haven't yet read everything that th=
e
> user requested and clears it if we fulfilled what the user requested.
>
> This has the weird effect that MSG_MORE gets kind of inverted. [...]

I hate this patch.

The old code is unquestionably garbage, but this just ends up
resulting in more of the same.

The reason the old code is garbage is that it sets SPLICE_F_MORE
entirely in the wrong place. It sets it *after* it has done the
splice(). That's just crazy.

And that craziness is the direct cause of the bug.

You try to fix the bug by just extending on the craziness. No. The
crazy should be removed, not extended upon.

The "flag" setting should be done *before* the send, if we know that
more data is pending even after the "do_splice_to()". Not after.

And the networking code should do its own "oh, splice gave me X bytes,
but I only used Y, so I know more data is pending, so I'll set
MSG_MORE on the *current* packet". But that's entirely inside of
whatever networking code that does th esplice.

So no. I absolutely refuse to entertain this patch because it's
completely broken. The fact that the old code was also completely
broken is *not* an excuse to make for more nonsensical breakage that
may or may just hide the crazy.

               Linus
