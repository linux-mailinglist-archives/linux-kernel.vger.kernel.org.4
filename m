Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF3772005F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjFBL2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjFBL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:28:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCAA197
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:28:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9707313e32eso295405466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685705304; x=1688297304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1GnyRn3CUTJ1J4Rj60TNnTJgegattVBSNHX3CbgG/Y=;
        b=PrD07nOhqMMOui7dr1hFvNithn14j5tFeEpuSMeqd6/fCCGE5ktA6wR+nqtwU/13gh
         ioCdbkJwsluQur5y4OnIq/exx17v7aKVO8EQHg5d+vvF0aXn11CLnBvXvcUKPEbhsidP
         WRyEn0YL53R+mZjkDOMsAs31CzvOFXGuLumfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685705304; x=1688297304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1GnyRn3CUTJ1J4Rj60TNnTJgegattVBSNHX3CbgG/Y=;
        b=gw1f/s8jXEIxyevo+N5BE5DZL26KU224AAN+4F4La3R4e+syF9RgUqhwfRGHDa00yp
         8/ql+xJSjNKuAQxNmFrtk2pDlvYXMv32PcBdH9FQQjttPJSROCNeJZ14sun/9nsUMSNV
         rZ+GpGf6IIrlvAsLNidSWdJSuoVbfRGDgiVoodGBfGCIStQBjQFr9h2HLJf+R/N7Lgu+
         yALmPqyqUKsvUvirD2hH9W7n4Gq0v7esFgBBOzfUg4nJi7cez82mJ4ILIexQTE/Y/kZa
         ZdrqG23KFKdUNe0f5qQzzkfsc3kztBxqCklK59Qf+a3RNuVCVcDbJ2iVLkmOi/AlufWX
         kfYw==
X-Gm-Message-State: AC+VfDzBfc9VksReQNtIWxx9CTyJ1IA8qiGfCmBvbTlrAZhm0ggWZyMM
        svBUm0sFWyAJsLndgnGzQYqqu/SVrk+weidRYhSDdQco
X-Google-Smtp-Source: ACHHUZ7lKIyyBBlfwBsKD4WTXhCefwUjUhBvmyAfS8R0TJP9R50iCDbS30OSA8+NUsl/BelA6N+AaA==
X-Received: by 2002:a17:907:9413:b0:973:bcf6:1d4 with SMTP id dk19-20020a170907941300b00973bcf601d4mr10695534ejc.76.1685705304087;
        Fri, 02 Jun 2023 04:28:24 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906494e00b0097461fecc91sm651007ejt.81.2023.06.02.04.28.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 04:28:22 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-514924b4f8cso2814456a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:28:22 -0700 (PDT)
X-Received: by 2002:aa7:c403:0:b0:50b:c89f:f381 with SMTP id
 j3-20020aa7c403000000b0050bc89ff381mr1838560edq.29.1685705302070; Fri, 02 Jun
 2023 04:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
 <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-10-dhowells@redhat.com>
 <20230526180844.73745d78@kernel.org> <499791.1685485603@warthog.procyon.org.uk>
 <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
 <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com>
 <832277.1685630048@warthog.procyon.org.uk> <909595.1685639680@warthog.procyon.org.uk>
 <20230601212043.720f85c2@kernel.org> <952877.1685694220@warthog.procyon.org.uk>
In-Reply-To: <952877.1685694220@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 07:28:05 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjvgL5nyZmpYRWBfab4NKvfQ7NjUvUhE3a3wYTyTEHdfQ@mail.gmail.com>
Message-ID: <CAHk-=wjvgL5nyZmpYRWBfab4NKvfQ7NjUvUhE3a3wYTyTEHdfQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 4:23=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> +/*
> + * Pass a zero-length record to the splice-write actor with SPLICE_F_MOR=
E
> + * turned off to allow the network to see MSG_MORE deasserted.
> + */
> +static ssize_t splice_from_pipe_zero(struct pipe_inode_info *pipe,

David, STOP.

Stop doing these crazy hacks to generic splice code. None of this makes sen=
se.

Those zero-sized splices have never worked, don't try to make them work.

The splice() system call has always had that

        if (!len)
                return 0;

since being introduced. We're not adding any crazy stuff now.

Do what I already suggested: making SPLICE_F_MORE reflect reality.

Or don't do anything at all. Because this kind of hacky garbage is not
even amusing.

               Linus
