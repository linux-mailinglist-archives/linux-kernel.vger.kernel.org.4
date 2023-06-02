Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8F7207B1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjFBQg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjFBQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:36:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44747B4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:36:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so3036015e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685723812; x=1688315812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzJT3HyKG2J4xiGoewlppsTGaruPJowM8pRCfo3JmUA=;
        b=ex3hBZuf687wTeLAQT1ZHHSKrPZ4p/Co3Hyth76X0c1fUP+5vgyQMVzI7qKNtWfwhg
         6445h4vRh9wUMGGbVwmbzHjKEmCVV329+8YPReHmBrIwsT4xncD9jR6mYSEsn7WKvhxB
         WEToExzPMBMClXU0lQOnnf+rxRLpv/r/dLHHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723812; x=1688315812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzJT3HyKG2J4xiGoewlppsTGaruPJowM8pRCfo3JmUA=;
        b=NTR+ywalsldSLFd1OgFaBBi6p+XBESCNwYxmVkwdAKxNmEnTZF128w7r6GMMO5R9cx
         8tOXEHUiKH6CH4AmPFSX5NtSbQVZ2WJLa5SK5NA3MvKDeupBB3eX47jwSqvQ5wiDfXWU
         vJdoYSO0/9tmPNzJrPWaSS4WIVwSR3aZE/cQruVNSD80rUv+FnEGrmw33o26nl4Sf7QH
         k86IZvXFdUU+D6vD3fqNC7S6NyVDgPMWQVYXPVRvplmgry9khq+hzHJEIbnviTx7yrpV
         GsbVSuO0NR2m3yfjMM8LU6z2mfeMUVWSrj5+6z3kjgyrn/BdkSZF/a5ba+WAs2VJVQHr
         mIdQ==
X-Gm-Message-State: AC+VfDzV2PU8wJBLP6gNBrpYYYO+vx340CsWPdEE2dBfibGf9x5p7dq0
        u1LM0f2qBMIOjrqU0tOWUHM5xoMKN+f9vhhyCDEoI3Vr
X-Google-Smtp-Source: ACHHUZ534QEGFhLp4mng+mMAyA3ZXtX2Wkj5WYPXEpB/69JydCNLc+qcIY0iYnWHax6ZEQjyU3nniw==
X-Received: by 2002:ac2:54a9:0:b0:4ef:eb50:4d3d with SMTP id w9-20020ac254a9000000b004efeb504d3dmr2194191lfk.18.1685723812538;
        Fri, 02 Jun 2023 09:36:52 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id c24-20020ac25318000000b004eefdd8b37fsm210753lfh.194.2023.06.02.09.36.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:36:52 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4effb818c37so3029984e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:36:52 -0700 (PDT)
X-Received: by 2002:a2e:7302:0:b0:2af:1681:2993 with SMTP id
 o2-20020a2e7302000000b002af16812993mr311009ljc.49.1685723811492; Fri, 02 Jun
 2023 09:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230602150752.1306532-1-dhowells@redhat.com> <20230602150752.1306532-6-dhowells@redhat.com>
In-Reply-To: <20230602150752.1306532-6-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 12:36:34 -0400
X-Gmail-Original-Message-ID: <CAHk-=wg-9vyvbQPy_Aa=BQmkdX7b=ANinNUU+22tMELuxmH99g@mail.gmail.com>
Message-ID: <CAHk-=wg-9vyvbQPy_Aa=BQmkdX7b=ANinNUU+22tMELuxmH99g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/11] splice, net: Fix SPLICE_F_MORE
 signalling in splice_direct_to_actor()
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
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

On Fri, Jun 2, 2023 at 11:08=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Fix this by making splice_direct_to_actor() always signal SPLICE_F_MORE i=
f
> we haven't yet hit the requested operation size.

Well, I certainly like this patch better than the previous versions,
just because it doesn't add random fd-specific code.

That said, I think it might be worth really documenting the behavior,
particularly for files where the kernel *could* know "the file is at
EOF, no more data".

I hope that if user space wants to splice() a file to a socket, said
user space would have done an 'fstat()' and actually pass in the file
size as the length to splice(). Because if they do, I think this
simplified patch does the right thing automatically.

But if user space instead passes in a "maximally big len", and just
depends on the kernel then doing tha

                ret =3D do_splice_to(in, &pos, pipe, len, flags);
                if (unlikely(ret <=3D 0))
                        goto out_release;

to stop splicing at EOF, then the last splice_write() will have had
SPLICE_F_MORE set, even though no more data is coming from the file,
of course.

And I think that's fine. But wasn't that effectively what the old code
was already doing because 'read_len' was smaller than 'len'? I thought
that was what you wanted to fix?

IOW, I thought you wanted to clear SPLICE_F_MORE when we hit EOF. This
still doesn't do that.

So now I'm confused about what your "fix" is. Your patch doesn't
actually seem to change existing behavior in splice_direct_to_actor().

I was expecting you to actually pass the 'sd' down to do_splice_to()
and then to ->splice_read(), so that the splice_read() function could
say "I have no more", and clear it.

But you didn't do that.

Am I misreading something, or did I miss another patch?

               Linus
