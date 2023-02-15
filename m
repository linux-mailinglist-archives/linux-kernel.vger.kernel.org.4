Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97352697FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBOPuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBOPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:50:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927803669C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:50:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s11so15031381edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxx4XcKwvyNpOp3VEGiE+719FH+KggeO1TDcZH8XIXc=;
        b=fUwRQosoarROxeHu1csL4um6cmJozX9RvBTdZqgdbzyF8Barwc8bIYcCdoDTmo/GS3
         IrM2E/JJIeMfYbsTW+034l9vqtsfBsV6SKeI/tbgP1heCoXj5YxjirQn7a2KEY1Q5MRe
         3QmYbDaieDTABhmer07N0SUOHXk1nlNqWCtBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gxx4XcKwvyNpOp3VEGiE+719FH+KggeO1TDcZH8XIXc=;
        b=cwkiB+STwU3rfh3cFrzG+M4GjPENLJ8Ku2S9BaGrZ+glmKeoIjCrlbJQ0TTvBhTc1I
         0TLNR5R9c6QwvAtqJ/+KhkTrSkSbA2TGJ7BqbBpEoq+3BtvoU8MGuqCYnZvZdr45rWMF
         /WxIQ4PuibcI42dwot0rvngVVR++zKf93oCpluVBI8dzZNF44qiMgpkmoHcITiMc1rse
         KfiitDLnugdj5FQ76cLay33Xouc7sldynCeL6IvhoiZeqrBzHos8D7pOrxlHI18dAwZX
         ZzS4c3vpYOjrWDkv11UMprrdygZdM1LKUyzFuNZhaw6ivCqpAvnQhgHJp6Fxwa8Oej1H
         gjig==
X-Gm-Message-State: AO0yUKVyJ22eo7A5wXHb/9MYKfsqZEIaBBghr63Fhv0Obo4X6WzrFFwQ
        yxJZOaNma+q1DeBa46oZ2keHdxzAoJ2S7lK4qT3qKA==
X-Google-Smtp-Source: AK7set/c1PSjKuHwb5HoUktp2BYZfMk+QVL6t/16rqfQYUzXFAPu8C+88H0jVH04WKFY9zcgUpkjnk6LsbMVdzmu3MI=
X-Received: by 2002:a50:99c1:0:b0:4aa:b30f:c784 with SMTP id
 n1-20020a5099c1000000b004aab30fc784mr1318317edb.8.1676476215115; Wed, 15 Feb
 2023 07:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-6-dhowells@redhat.com>
 <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com> <3370085.1676475658@warthog.procyon.org.uk>
In-Reply-To: <3370085.1676475658@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Feb 2023 16:50:04 +0100
Message-ID: <CAJfpegt5OurEve+TvzaXRVZSCv0in8_7whMYGsMDdDd2EjiBNQ@mail.gmail.com>
Subject: Re: [PATCH v15 05/17] overlayfs: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 16:41, David Howells <dhowells@redhat.com> wrote:
>
> How about the attached then?
>
> David
> ---
> overlayfs: Implement splice-read
>
> Implement splice-read for overlayfs by passing the request down a layer
> rather than going through generic_file_splice_read() which is going to be
> changed to assume that ->read_folio() is present on buffered files.

Looks good.  One more suggestion: add a vfs_splice() helper and use
that from do_splice_to() as well.

Thanks,
Miklos
