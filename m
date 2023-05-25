Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0010A7111C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbjEYROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjEYROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:14:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4618D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:13:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so4925015a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685034837; x=1687626837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zMzRygPKkdKlo23QW/uYg+LGfB6C3Hjzj0Tw04tNig=;
        b=Feyukfe41/EEc27ov+RYVZa87DlQS5o+aYT5ANIQSyY63yodQ8haDKmAKbAuGkQIEA
         aHcrhlnB3MaNTM8sEzViXPwQtME41H/ELJwpCSp/bKDSG7IcI9xZUwf8MEH9jnAfXdsq
         QrOrIye3cDhzr7Z4LId0RtdUj4vd74Xrx6NHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034837; x=1687626837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zMzRygPKkdKlo23QW/uYg+LGfB6C3Hjzj0Tw04tNig=;
        b=Gbox9RYdzsOb71Hn8D4tySyBpSjyjCh224BgTAp8MeTSxhLnJPD6At9yrcCFsxn2r1
         BEri4uB+NbMWp/ea2NtufVK3yORkNMuYttvauGUasjGq35Ng2gDoZZT/8jWb/9gbQefH
         n5dIS31m3dcdZ/31ZXA/J+ID0gASPxzbX3nVgAPq7CKoqPpuxmzUPG8Z/asJeGMX2siE
         xitYuvSWaMbDrgtBNg2s66yMw3PYb1kmZT175K7U2VNaZPKzEnGQym112YNMmkd7/7XT
         rs93MEkAcKiO7weDpB+FhXNvLb90iyFYt7naAWe0F9FiJEl6pxk0WV9XRhI3M90FKYRi
         /2MA==
X-Gm-Message-State: AC+VfDzR/VsvJ2cTcD8f3cbtRyOY2MEOZT+U/D8MPv/BXsIJId5NrZ+E
        p3Dsk56OfSgkpvqq1NZ/TSNEQxqkRgu6ARFJ+9xyX9KL
X-Google-Smtp-Source: ACHHUZ7XKiTcbVuDP/RMsVcEYH4Z+WT3i3bOhTqZymtd9lp4Ewt+5jH8Dy8o5oyQmD/5Qo5meqEWtw==
X-Received: by 2002:aa7:dccc:0:b0:50c:d5d:c960 with SMTP id w12-20020aa7dccc000000b0050c0d5dc960mr5389500edu.38.1685034837266;
        Thu, 25 May 2023 10:13:57 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id g19-20020aa7d1d3000000b0051056dc47e0sm749416edp.8.2023.05.25.10.13.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:13:56 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso4923868a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:13:56 -0700 (PDT)
X-Received: by 2002:a17:907:a49:b0:96a:498a:bd4b with SMTP id
 be9-20020a1709070a4900b0096a498abd4bmr2248713ejc.64.1685034836175; Thu, 25
 May 2023 10:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <88983.1685034059@warthog.procyon.org.uk>
In-Reply-To: <88983.1685034059@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:13:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguy6bcoUznDCU3mr-wbi-8NigkTw5GvwiF8R76J=vGUQ@mail.gmail.com>
Message-ID: <CAHk-=wguy6bcoUznDCU3mr-wbi-8NigkTw5GvwiF8R76J=vGUQ@mail.gmail.com>
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

On Thu, May 25, 2023 at 10:01=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> What do we gain from it?  Presumably since nothing is supposed to write t=
o
> that page, it can be shared in all the caches.

I don't remember the details, but they went something like "broken
purely virtually indexed cache avoids physical aliases by cacheline
exclusion at fill time".

Which then meant that if you walk a zero mapping, you'll invalidate
the caches of the previous page when you walk the next one.  Causing
horrendously bad performance.

Unless it's colored.

Something like that. I probably got all the details wrong.

                Linus
