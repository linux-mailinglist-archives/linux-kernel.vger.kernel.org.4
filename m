Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5476670C4A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjEVRuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjEVRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:50:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1C115
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:50:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f00d41df22so4776278e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684777798; x=1687369798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0vGfy2nsZav2HY5i+tp/Nl3rfKXvicFLnxzClJPsL0=;
        b=BFv8XI38pZSHLHDMZj62EI7ZNe0EZgB8s+H5o3U/4aOg4f9ch3MpMvvQY7Ar71671n
         j4cCEqI9XZl1gEy2FVuN8lzXoRVM9YdpJPKxe67FVFgmy5ImyLLiAN6XEbz6CZENm4BY
         h3iXXSpMCRDTY156UR8E0/8dNRRqOMofukZ9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777798; x=1687369798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0vGfy2nsZav2HY5i+tp/Nl3rfKXvicFLnxzClJPsL0=;
        b=CfBSNqRx6RrX3odKupmgmlLzRiXpjLFY4gxcNu4tvDjs0eaB0H2V2EqPj3kaLrGM7M
         E/4oipbb1g2PbAnMkximUUJ9Stg/XIIjRI8m158lRdrmAm3gHZUr3Izsuo9ByLL3fSYU
         yunffJhnaiaczUay1LviRlcVHtPgfDrUZhdJSQwaJwqKCkmw5NAX2oDCd6zgWTC3770i
         bi4Zt3QfLveJ8zb6oowG1Vfv/ZJ35Jb9onk3yb8fASTFpVeBaH4he4PM8wcePIi0CKs7
         HBAprCOsaGutRCj7bO9ZtI2TnNThumLYPtioInDJruzttvAcPX0NbHfolBK0ct324f/+
         qyZw==
X-Gm-Message-State: AC+VfDyS7DvWNNC2IqSFdHr46+AYvHeR4fRl2lWmZiNjMffnjgSVJMfL
        QcBZNnmOZLApe1Xn2NZ3lTyAfubH5PhkRDmqn8vCGLrB
X-Google-Smtp-Source: ACHHUZ7NLlHXovT9m2Uq0tK4WPvmCCJSnRFHZO0nClhtf6TkTSeKYKrH2tXK836Bf28TdYLsmxdcyQ==
X-Received: by 2002:a19:f816:0:b0:4f1:4074:b4fd with SMTP id a22-20020a19f816000000b004f14074b4fdmr4345104lff.29.1684777798571;
        Mon, 22 May 2023 10:49:58 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id f2-20020ac25322000000b004d4d7fb0e07sm1046126lfh.216.2023.05.22.10.49.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 10:49:58 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2af2e1725bdso30514371fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:49:58 -0700 (PDT)
X-Received: by 2002:a17:907:1688:b0:965:d7c7:24db with SMTP id
 hc8-20020a170907168800b00965d7c724dbmr9757222ejc.32.1684777349281; Mon, 22
 May 2023 10:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-24-dhowells@redhat.com>
 <20230522102920.0528d821@rorschach.local.home> <2812412.1684767005@warthog.procyon.org.uk>
In-Reply-To: <2812412.1684767005@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 10:42:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
Message-ID: <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
Subject: Re: [PATCH v20 23/32] splice: Convert trace/seq to use direct_splice_read()
To:     David Howells <dhowells@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 7:50=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> We could implement seq_splice_read().  What we would need to do is to cha=
nge
> how the seq buffer is allocated: bulk allocate a bunch of arbitrary pages
> which we then vmap().  When we need to splice, we read into the buffer, d=
o a
> vunmap() and then splice the pages holding the data we used into the pipe=
.

Please don't use vmap as a way to do zero-copy.

The virtual mapping games are more expensive than a small copy from
some random seq file.

Yes, yes, seq_file currently uses "kvmalloc()", which does fall back
to vmalloc too. But the keyword there is "falls back". Most of the
time it's just a regular boring kmalloc, and most of the time a
seq-file is tiny.

                      Linus
