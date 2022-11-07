Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CD361FB77
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiKGRdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiKGRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:33:13 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE3A1F9FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:33:12 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id c129so12936248oia.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OtwMIMageNgEFgITDbP/X4AlmExFVOD7QsjK39jRkOs=;
        b=ZrBbGd0NE5W3bFjfpMfVEGchJiOqL5vKGUnJZWHQEDCz71oryF6CDiPscJkkJaNeeg
         /pKDfIl6hW5yw8tjgrcZSOwrloCrFqYb1/s9Bc1/cV94xFkaKkZwH1bCSgyaTCtOH5Nq
         2ijwSehO6aXkrD87GuWevIaaXGPhzXmGc/u0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtwMIMageNgEFgITDbP/X4AlmExFVOD7QsjK39jRkOs=;
        b=hFRvHh4CsrK9dzjO1E67Eks+0NeigmxoPvd/ezg4UqX21eSHIwpudnreSjeFwfaHpz
         Hd+MWpp0kYz/YWH/W9zB7W8B9OkAeF+9m2aycv26C0q9WhRdWeotvGl3EeapowhL32Er
         EFa8tIpUmKQ7bq1ckMq2a6R7NqW0aIB9gnUNuwISbDSrjire0OYmGfSvC2OUDjcc5JoA
         wvYAkbSDns/Ft42o7liPYQCsWVz7O/l4f/7zu4oKhnDh2stP8FRIdcakQpeBkiB+kX9e
         JI+S+JeeOSB++wJW7l/Fo5UyZiw6b2iSdp6EEaGuv9hEcd3bbLQ0UtSmKMXDLNEXDO3r
         zy+g==
X-Gm-Message-State: ACrzQf0127i1G+feATMVQaR9QEpfQgNAimf04Q9niaKZjYOtYEikUqYE
        rB+bO2d3dQHNu16R9FCUyzgUuJ1DcZbR4g==
X-Google-Smtp-Source: AMsMyM58URHlet91YVc1ZTCOgcPmck7PwChUtJRD93+Pe7zPa+yANJZKicGRDYFVxXEcOAezWKb1oQ==
X-Received: by 2002:a05:6808:490:b0:359:fcf5:3c0f with SMTP id z16-20020a056808049000b00359fcf53c0fmr24740171oid.65.1667842391642;
        Mon, 07 Nov 2022 09:33:11 -0800 (PST)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id x51-20020a9d37b6000000b00666a5b5d20fsm3115030otb.32.2022.11.07.09.33.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 09:33:10 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id x196-20020a4a41cd000000b0049f064d2591so156543ooa.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:33:09 -0800 (PST)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr46634218ybu.101.1667842059236; Mon, 07
 Nov 2022 09:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20221107161740.144456-1-david@redhat.com>
In-Reply-To: <20221107161740.144456-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Nov 2022 09:27:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj51-dtxf8BQBYP+9Kc3ejq4Y0=-6hCbf_XAnkT3fsgDQ@mail.gmail.com>
Message-ID: <CAHk-=wj51-dtxf8BQBYP+9Kc3ejq4Y0=-6hCbf_XAnkT3fsgDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/19] mm/gup: remove FOLL_FORCE usage from drivers
 (reliable R/O long-term pinning)
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 8:18 AM David Hildenbrand <david@redhat.com> wrote:
>
> So instead, make R/O long-term pinning work as expected, by breaking COW
> in a COW mapping early, such that we can remove any FOLL_FORCE usage from
> drivers.

Nothing makes me unhappy from a quick scan through these patches.

And I'd really love to just have this long saga ended, and FOLL_FORCE
finally relegated to purely ptrace accesses.

So an enthusiastic Ack from me.

                   Linus
