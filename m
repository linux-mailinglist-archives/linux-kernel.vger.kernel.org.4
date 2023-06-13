Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC772D83F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbjFMDwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFMDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DD1A7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686628300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C3Qet8pfbumCHeQRQJPhvf0fawkFBs8tKAQEcPXsl8=;
        b=CgU+buaz7bwgNG1D3XzkgA1JlXA+4b1M/5GrBbW0Dd1yb59ygQVK3mJwS3HETAHZ/T4UEC
        F5txiX90mjy2N3gN2mnDTWoNOOSGgx8s/Y0OTspVw0BIDtTIG7kOEIa4IM0RM4ieXTrwnn
        QVckMo8YCc9PggAqpRS/wHmSqTWYkMs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-oK7Z7RroPe2XBjAICh719Q-1; Mon, 12 Jun 2023 23:51:38 -0400
X-MC-Unique: oK7Z7RroPe2XBjAICh719Q-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f9a7a41baeso7488871cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686628298; x=1689220298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C3Qet8pfbumCHeQRQJPhvf0fawkFBs8tKAQEcPXsl8=;
        b=iGRZXPKFcE5VF35GiYD0eqTULyBOYrE6I2OgRKH4ghcXVaSNsc6972E5jIsKX+Z3yk
         43a5SEBecBoV7Pnb6BUKy39DBVA31olXPjwwtWx2g+zWFF94fSD8Ejo461HCYWzI4vWV
         4N5d2KoFED1VVGsevDhYYZZE7rkvTpS+3cA3qI5A3Ij+QVM9t4wOTtqWKvKNCBewaQ+O
         YPkzqt+TQKXIeBQvgYLyLI27iHo6/oBwo6k11r2zXznPYtJ/OHrT/LbQiqEfDilh/7mL
         3CyZ9QTvqsMralZyFGvPH3xHfo6E+UyJv1JwZkdg9zkXcn6KVcG20u7JINSkn/RxBgSD
         dT3g==
X-Gm-Message-State: AC+VfDzpT2RAdRnPY+kHiEgAPVU8s0fyH9lqeLkaM9mg961VT1fjA09S
        ZmRJXszukiBH42tlkirSKY3vGGyfDz6xHyDYd/1Rn212VOY6pE7KqEPPxZNiQG0VvdK1uPRh08r
        HtaBEXP/7/3apPmxcnDb6kGjeQI0LqSmUURqE7uYs
X-Received: by 2002:a05:622a:58d:b0:3f0:ab4e:df6b with SMTP id c13-20020a05622a058d00b003f0ab4edf6bmr13376053qtb.67.1686628298179;
        Mon, 12 Jun 2023 20:51:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ77q9JM4D3nlwn+WSOng3WLkYEnk7ORFVxoz6Go1qcYYHvUtAhi0IrS4HeqbAYoiDffwJDzqdo9NagKfCPHwxI=
X-Received: by 2002:a05:622a:58d:b0:3f0:ab4e:df6b with SMTP id
 c13-20020a05622a058d00b003f0ab4edf6bmr13376041qtb.67.1686628297957; Mon, 12
 Jun 2023 20:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230520052957.798486-1-leobras@redhat.com>
In-Reply-To: <20230520052957.798486-1-leobras@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Tue, 13 Jun 2023 00:51:27 -0300
Message-ID: <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to call_single_data_t
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping

On Sat, May 20, 2023 at 2:30=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> Changes since RFCv1:
> - request->csd moved to the middle of the struct, without size impact
> - type change happens in a different patch (thanks Jens Axboe!)
> - Improved the third patch to also update the .h file.
>
> Leonardo Bras (3):
>   blk-mq: Move csd inside struct request so it's 32-byte aligned
>   blk-mq: Change request->csd type to call_single_data_t
>   smp: Change signatures to use call_single_data_t
>
>  include/linux/blk-mq.h | 10 +++++-----
>  include/linux/smp.h    |  2 +-
>  kernel/smp.c           |  4 ++--
>  kernel/up.c            |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
>
> --
> 2.40.1
>

