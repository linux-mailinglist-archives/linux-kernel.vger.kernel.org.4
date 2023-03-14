Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC716BA3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCNXrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCNXr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:47:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145124FF25
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:46:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id fd5so34979117edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678837603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNuC5vuLHUrjsLAEtJntp1DYmMh0ryjDseFJIAEyVKE=;
        b=fj86/b+QJX0eaHl5Rf2NI7wju4JZEekApJhkEnDDd2K7sihxbIUjszlDhT+AsMLw1e
         kx3XCXeA0rf6zyj4upejQi1UxCHnslvakdvrJb7GQITW4j/E6Cwuu3Ki850TKDnl2s9c
         dY4HmgBlPcaD6LOz7nulnviuEodO7jdkewS5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNuC5vuLHUrjsLAEtJntp1DYmMh0ryjDseFJIAEyVKE=;
        b=jvBCGRkxyggLgnN7kRGoiRpxFYKb3NS4DUpeyd8zbPJB/WdtbC3txFU8vty7ZtbGKJ
         B4l39jt1lGLEMcKgSOKATIGpC8fwHjvZhOR+K2fBXMfyBPUjOn4i2dqrem+aSY2lFi11
         qaMsJdnd02bx0+pFIiFhtweYc0qgBUkNRaBQ0NoR2Ge+DceVR4YA240EOayhOKujkKyu
         e4+RQ2DB+Rioo+yIouPtpsJW1QG8QMXTOX8Lh2ByIYx7K6noFh4CnKUmOS3AfnRwgYmE
         GZ4RQhTiHoGXKqBH+cwXmjXbQ4/+drYEnR4/h5rTDFBYV07NcGHfRYibABxRLspkKDcq
         NSwg==
X-Gm-Message-State: AO0yUKXELSeoZ24D14D00FjQdw2LuTxSDYvvnDSRLKiG8pW0DIbzADhJ
        S0dcJPzAb5OVLG2wD6Syn1Y4J5Pu16mzHzjVgKJc1w==
X-Google-Smtp-Source: AK7set9nG9J8xNES8O8TbAZpLPwQmjtO8MCrMkKsmDHUvjKR/eroGOkFADZnjnxIv88iW/kfT6GByw==
X-Received: by 2002:a17:907:8b9a:b0:8b2:c2fc:178e with SMTP id tb26-20020a1709078b9a00b008b2c2fc178emr4193739ejc.74.1678837602753;
        Tue, 14 Mar 2023 16:46:42 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ke4-20020a17090798e400b0092153c6b549sm1723567ejc.22.2023.03.14.16.46.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 16:46:42 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id da10so68974044edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:46:42 -0700 (PDT)
X-Received: by 2002:a50:d506:0:b0:4fb:482b:f93d with SMTP id
 u6-20020a50d506000000b004fb482bf93dmr435862edi.2.1678837212326; Tue, 14 Mar
 2023 16:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230314220757.3827941-1-dhowells@redhat.com> <20230314220757.3827941-4-dhowells@redhat.com>
In-Reply-To: <20230314220757.3827941-4-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 16:39:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKPK=Bn_je2A19rSptpDo589DWxBJi8UQYS7sPjDPurw@mail.gmail.com>
Message-ID: <CAHk-=whKPK=Bn_je2A19rSptpDo589DWxBJi8UQYS7sPjDPurw@mail.gmail.com>
Subject: Re: [PATCH v18 03/15] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 3:08=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
\> +static size_t splice_zeropage_into_pipe(...
>   ...
> +               *buf =3D (struct pipe_buffer) {
> +                       .ops    =3D &zero_pipe_buf_ops,
> +                       .page   =3D ZERO_PAGE(0),
> +                       .offset =3D offset,
> +                       .len    =3D size,
> +               };
> +               get_page(buf->page);

That

+               get_page(buf->page);

is still there, and now it's doubly wrong because it's never dropped
and will eventually overflow that count that shouldn't even be there.

             Linus
