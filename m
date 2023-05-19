Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC0709C56
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjESQW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjESQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:22:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56110C9
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:22:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f6a9131fdso120780966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684513360; x=1687105360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kK1ZTkygyrBiweN68dKEUcpOojpjbump5mMSvci/Nuk=;
        b=bwtFDBDC3jTlfO6bC+iFLb7YneWb5Ug61piudRWSqHfASXBjBRMDV8MSVD9ZYlplFB
         tqcnQgLe3Dwu2YHtisEWRqrETv1ThJSxv7HNdj6XstcShJeZnebWEtzJKDR+prHqSw8W
         TZ908EW8sXWw9AzcL9V6nGNZc3jYwSnX1Xq7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684513360; x=1687105360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kK1ZTkygyrBiweN68dKEUcpOojpjbump5mMSvci/Nuk=;
        b=OxThvR1Duid+1y5Q2+IahOX+ThzTAkWrtrMlq1bAXwy7hrX8DKLjM7DDeqnSRZXSS3
         oLBDQ52o3aoQaHXkEBJed2J3GbT1cgIweCTTGtuJiOQFmyNe6B1c5gR9rvoBd5iMu/vh
         vt39+tkxW+0kTYYh7EbuRvuAmACXE7YbDpGIxDABVqnDmlnAPi8cNO57EHPN7IKbG4Tw
         TuKdfcGSQtUog7gfXQS5kd28Xs/K/GAV120XOcWYfcZNNJDRFJOuA4AzgMoYDYkDBptM
         EzP7GFs06bBLwOfC0IYL2zlBr5ARh8j3G2qX7gbdjF2iMdBLDgB/vwK0wFtUiJpHnVIc
         b/Mg==
X-Gm-Message-State: AC+VfDyY9JuVwFkJHCSUxg8mE8timLuqa+56QUgRLAyabI6K/HZSIRer
        RE/moQAy8YcsT3JjkgfV7gxV14Ri7AAlssZK2qE5VyMP
X-Google-Smtp-Source: ACHHUZ6VkbKAdwjC6dtX/025o9KrTSgXvSlCh4/MMAZkKZfNa7Z5pMOJ7VC9orES/ceZGsERxoiQOg==
X-Received: by 2002:a17:907:709:b0:965:6075:d0e1 with SMTP id xb9-20020a170907070900b009656075d0e1mr1844213ejb.72.1684513360561;
        Fri, 19 May 2023 09:22:40 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id kq2-20020a170906abc200b0096f89c8a2f7sm57958ejb.90.2023.05.19.09.22.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:22:39 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-510ddeab704so3850162a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:22:39 -0700 (PDT)
X-Received: by 2002:a05:6402:2d5:b0:510:f6e0:7d9f with SMTP id
 b21-20020a05640202d500b00510f6e07d9fmr2254674edx.13.1684513359285; Fri, 19
 May 2023 09:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-10-dhowells@redhat.com>
 <ZGcvfLWAqmOLrnLj@infradead.org>
In-Reply-To: <ZGcvfLWAqmOLrnLj@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 09:22:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzSLXt38J_B2=QWCDi7A1c5B0_cJ3XYRj9rYn+YXbjQA@mail.gmail.com>
Message-ID: <CAHk-=wgzSLXt38J_B2=QWCDi7A1c5B0_cJ3XYRj9rYn+YXbjQA@mail.gmail.com>
Subject: Re: [PATCH v20 09/32] tty, proc, kernfs, random: Use direct_splice_read()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Arnd Bergmann <arnd@arndb.de>
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

On Fri, May 19, 2023 at 1:12=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Pinging Al (and maybe Linus): is there any good reason to not simply
> default to direct_splice_read if ->read_iter is implemented and
> ->splice_read is not once you remove ITER_PIPE?

For me, the reason isn't so much technical as "historical pain".

We've had *so* many problems with splice on random file descriptors
that I at some point decided "no splice by default".

Now, admittedly most of the problems were due to the whole set_fs()
ambiguity, which you fixed and no longer exists. So maybe we could go
back to "implement splice by default".

I agree that as long as the default implementation is obviously safe,
it should be ok, and maybe direct_splice_read is that obvious..

           Linus
