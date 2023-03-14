Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F456B9DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCNSDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCNSDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:03:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EEC498BC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:03:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z21so209240edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678816979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaNrWV0j7xcmGChzOfmkTnIc3tuBbFeTK4GfA059lX0=;
        b=Z8Nw3g1RTORE2RcMfbgEZErbFNUWfGT6irFXSVLUoNUYTw7Tmubk628kk2HgYt9Ugy
         hBJJNAv+TpehPO6qPDxJ7KdT9YgqERBC5l9e60tDIBerERAuumL3cAPmiLr6JHMBO8nr
         YJqjbebJ6UV2kwz4sEHmX42kAlwX7FDjjH8Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaNrWV0j7xcmGChzOfmkTnIc3tuBbFeTK4GfA059lX0=;
        b=meFLUJ4sN7lufIVm2Sfc3u2HyPKQsQBEWPQj7uhOMYZmfRD3SwUXRxnO5fgDyBLlfg
         kp5JxfKG19TL6X07j4dnjygKQljcQAeVEo+KP3/K9PU4Ve0oUQK/s1ZwredwvpG4ALwu
         5CBK7+f/CyBGtZviKXzjz1xoPcjttAtq3g8xH+tHUOH2ftpO6hx7M3/01jblZthkrRI7
         eQnC990k7RD04xpsTLodupqoUVoXt8RqmjVlR/g3ldBOQPVG6sJUAqe2zsl18xFt4Jt8
         jFJI1d9bq32j5hcV0hldtDm+Aul4NnUVDarYhCkmjSzM13pG69jyKHsWyxahvoWMU/OY
         jE+A==
X-Gm-Message-State: AO0yUKWA0NIkkeA+SvqGBhDVtFSJkH9i87IMwB/psWEbjuUYGxl37tOT
        VTOQlzdcrQrn5NIKevZBmOUxsoMASTPPttAkLEJgeQ==
X-Google-Smtp-Source: AK7set/9P4zEivmJjO3VSNP/96CE5QqYaWEfvbCW1ASei7CqsTyBEtaFJzqcuHczl8DmI/OPI+GwyA==
X-Received: by 2002:a50:ff17:0:b0:4fd:29a1:6a58 with SMTP id a23-20020a50ff17000000b004fd29a16a58mr4266331edu.19.1678816979599;
        Tue, 14 Mar 2023 11:02:59 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id g23-20020a50d5d7000000b004bb810e0b87sm1399428edj.39.2023.03.14.11.02.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:02:58 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id x13so18188186edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:02:58 -0700 (PDT)
X-Received: by 2002:a17:906:c30e:b0:8ad:d366:54c4 with SMTP id
 s14-20020a170906c30e00b008add36654c4mr1933623ejz.4.1678816977991; Tue, 14 Mar
 2023 11:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com> <ZBCkDvveAIJENA0G@casper.infradead.org>
In-Reply-To: <ZBCkDvveAIJENA0G@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 11:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
Message-ID: <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
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

On Tue, Mar 14, 2023 at 9:43=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> The problem is that we might have swapped out the shmem folio.  So we
> don't want to clear the page, but ask swap to fill the page.

Doesn't shmem_swapin_folio() already basically do all that work?

The real oddity with shmem - compared to other filesystems - is that
the xarray has a value entry instead of being a real folio. And yes,
the current filemap code will then just ignore such entries as
"doesn't exist", and so the regular read iterators will all fail on
it.

But while filemap_get_read_batch() will stop at a value-folio, I feel
like filemap_create_folio() should be able to turn a value page into a
"real" page. Right now it already allocates said page, but then I
think filemap_add_folio() will return -EEXIST when said entry exists
as a value.

But *if* instead of -EEXIST we could just replace the value with the
(already locked) page, and have some sane way to pass that value
(which is the swap entry data) to readpage(), I think that should just
do it all.

Admittedly I really don't know this area very well, so I may be
*entirely* out to lunch.

But the whole "teach the filemap code to actually react to XA value
entries" would be how I'd solve the hole issue too. So I think there
are commonalities here.

             Linus
               Linus
