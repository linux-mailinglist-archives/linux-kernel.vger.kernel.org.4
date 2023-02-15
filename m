Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD4698111
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBOQkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBOQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:40:17 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C1740DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:40:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a10so23063825edu.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uRPFQs3djXckE7Oktaa+X2AruZRRb1EX46zdXuL2aNA=;
        b=O1Sb/PuAScpXjzzcEcRfdw765yckWsrlp60Zyj2Buh5pRD57qJFkPGXYlYGCSzbLKZ
         0OZJxcmxT4DRgg7vRAKUywcu+0OCNVsBpF50NrQuVlyfYQKR1YKZkGKhonllv6EdWSWj
         S4d4opyn+39fcS7g6apBLJVuIfqAPFopssH38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRPFQs3djXckE7Oktaa+X2AruZRRb1EX46zdXuL2aNA=;
        b=6JMaTtJv1on7Vx6MGKRGbUS5pc8xu9Nql0bXXMLBHPhv9IT21Q+PV+ajDValtVbxoz
         vIAaHGUaEwqs4FH5fO74tLZLWusIn+1IFyJmUNF3pjHGVKmimIVElNdOKWMW4uZh6QS5
         z7fbjkE5/1ua7Asge4shikELEx7nq9EOCAkUwGo9yRjwCQweqjHbEAKZxSRtk+uvZz8Z
         m86mhJxI3c2MDI1Nx3F7ifapUw5UdZH6G5x6EL7/PnJ2+IrDDIOE2W8ysDVw9SUnhRyn
         AoNKIEkMfLh7ipS8FrByd7fqV59d6xhiMpzRhGAE9gX335KQfUCCMDM5ydu84pmEw3N2
         Yaew==
X-Gm-Message-State: AO0yUKUA5MMb5ryUu3v4J8SQppbHb4X87g/YpKjZW2ojicDkG0z72Bqt
        EUNszxu3GFTEd5tJX2B8PIxf/h6Picmu6lG97fw+8A==
X-Google-Smtp-Source: AK7set/iPBXeldwcN/CINqXYZtP94LHe3RbLgypUPLbVvQFOUAvYldPBfIvqSUN53v/EVz7QuOACKnzaFEzlWm2AvNQ=
X-Received: by 2002:a17:906:8604:b0:878:790b:b7fd with SMTP id
 o4-20020a170906860400b00878790bb7fdmr1331614ejx.14.1676479214862; Wed, 15 Feb
 2023 08:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-6-dhowells@redhat.com>
 <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com>
 <3370085.1676475658@warthog.procyon.org.uk> <CAJfpegt5OurEve+TvzaXRVZSCv0in8_7whMYGsMDdDd2EjiBNQ@mail.gmail.com>
 <Y+z/85HqpEceq66f@casper.infradead.org>
In-Reply-To: <Y+z/85HqpEceq66f@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Feb 2023 17:40:04 +0100
Message-ID: <CAJfpegsuDWqVYa2n2tmQP0EfkcWtRjxFwU1EbG0On-XfQ8ZhFg@mail.gmail.com>
Subject: Re: [PATCH v15 05/17] overlayfs: Implement splice-read
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

On Wed, 15 Feb 2023 at 16:53, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Feb 15, 2023 at 04:50:04PM +0100, Miklos Szeredi wrote:
> > Looks good.  One more suggestion: add a vfs_splice() helper and use
> > that from do_splice_to() as well.
>
> I really hate call_read_iter() etc.  Please don't perpetuate that
> pattern.

I didn't suggest call_splice_read().  vfs_splice_read() would have the
rw_verify_area() as well as the check for non-null ->splice_read().

Doing it that way from the start would have prevented two of the bugs
that David introduced in the first version.

Thanks,
Miklos
