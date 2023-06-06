Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3E723BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbjFFIfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbjFFIel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CB010E9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686040332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdoGUsAWfHDr2wQyL6tJs6W/yiY+jfIRUSQEw3HixAk=;
        b=ZYHxLwbH6Eo3CiTYgzkeM767ZyZe4epmS1Rk4bE763FLqC+cMbQfJrKTYIeUoh+zTXJ1//
        esSaycNAyjHwuVdJVKwr/q3zMivNemUaEfecmZcI2lpqXiQ/MzeU1QscYdqFc4fYzm/dbf
        RF2R7buoHKiHGbX+FN3D+W/uiti2B2o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-VAaI4qp4Ps-YACnvumIhvQ-1; Tue, 06 Jun 2023 04:32:11 -0400
X-MC-Unique: VAaI4qp4Ps-YACnvumIhvQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f602cec801so12057445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686040330; x=1688632330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdoGUsAWfHDr2wQyL6tJs6W/yiY+jfIRUSQEw3HixAk=;
        b=mFb+l1DrHhu+Vf/HEUR404DoDOaqegUZVzVtMZIxtyCL5kMWp0w+PEKcjysPTwRBYr
         x3cwxy4NeYsgXBScx6Y2p9PRr3dmBm8JlgX6k8qPwM2M1+zUmn5TYROamwJk1EaXc1lp
         gtgGj+lTG3zKStm2pGaZySxLTRe/G5m3HB0ApdRHryRdklKYJUvMP4PM2F++kfYbq4N6
         QCcWThuqu2Q4+GQJYaWlzgblGu1zq+YRdDO1N07M6CKP/i+ermZQGh7ooZmxXvo63djv
         M51unEsBEqwpcKQRtb6ImA1Bqg2MWZfIuNhlK4VYoHjqZGRvcGrELWvXVbyIGZmZD0hS
         9Bqw==
X-Gm-Message-State: AC+VfDxLt6Bcg2a36HAfgR9e1Voh9WjhTfOE+8iSjgLgWwivnUTyTab9
        /aXKfCv/BzAeTn7bHWipXSv2jJvfEu3oQDnCZJXNEO7cRGvyvRB+5G5sb2I3CtDyp5mCBW92+h3
        /wKtMyQHbVNZ2w2FC7InRuK71
X-Received: by 2002:a05:600c:1551:b0:3f1:7490:e595 with SMTP id f17-20020a05600c155100b003f17490e595mr1691951wmg.2.1686040330273;
        Tue, 06 Jun 2023 01:32:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mpfcPs5jilgFaHL8M4M0PoskD/r9L0dayDg39w3cIqXFW0pL1ZX8Qj4pnjveyA/vuspDHPQ==
X-Received: by 2002:a05:600c:1551:b0:3f1:7490:e595 with SMTP id f17-20020a05600c155100b003f17490e595mr1691926wmg.2.1686040330004;
        Tue, 06 Jun 2023 01:32:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-89.dyn.eolo.it. [146.241.114.89])
        by smtp.gmail.com with ESMTPSA id v10-20020a1cf70a000000b003f41bb52834sm16803885wmh.38.2023.06.06.01.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:32:09 -0700 (PDT)
Message-ID: <649f4d8d5e96b3c8e39ab56487888fe86e543066.camel@redhat.com>
Subject: Re: [PATCH net-next v2 08/10] crypto: af_alg: Support
 MSG_SPLICE_PAGES
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Jun 2023 10:32:08 +0200
In-Reply-To: <822308.1685619312@warthog.procyon.org.uk>
References: <bd2750e52b47af1782233e254114eb8d627f1073.camel@redhat.com>
         <20230530141635.136968-1-dhowells@redhat.com>
         <20230530141635.136968-9-dhowells@redhat.com>
         <822308.1685619312@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-01 at 12:35 +0100, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > > +	if ((msg->msg_flags & MSG_SPLICE_PAGES) &&
> > > +	    !iov_iter_is_bvec(&msg->msg_iter))
> > > +		return -EINVAL;
> > > +
> > ...
> > It looks like the above expect/supports only ITER_BVEC iterators, what
> > about adding a WARN_ON_ONCE(<other iov type>)?
>=20
> Meh.  I relaxed that requirement as I'm now using tools to extract stuff =
from
> any iterator (extract_iter_to_sg() in this case) rather than walking the
> bvec[] directly.  I forgot to remove the check from af_alg.  I can add an
> extra patch to remove it.  Also, it probably doesn't matter for AF_ALG si=
nce
> that's only likely to be called from userspace, either directly (which wi=
ll
> not set MSG_SPLICE_PAGES) or via splice (which will pass a BVEC).  Intern=
al
> kernel code will use crypto API directly.

Thank you for the clarification, I got lost a bit. The patch LGTM as
is.

>=20
> > Also, I'm keeping this series a bit more in pw to allow Herbert or
> > others to have a look.

@Herbert, the series LGTM, I think we should apply it. If you have any
concerns, please voice them soon!

Thanks,

Paolo

