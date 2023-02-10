Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE066928BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjBJUvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjBJUvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:51:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DC7F830
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:51:41 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r3so5796438edq.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s2Azvxdn84xto/x8V66pxCf76GAuLOkrFIRsWg8lS4s=;
        b=CExvujm0mDZb5b8Q0YyIk4qMEt2KO+XrVyPAus7CXHhyvaiDKton8DMFVNJsqauRlU
         nI1nneBrMPjQD5z0K9+CdqJYNcj8cP+aS9E0t7rQMDVkDPH9lCTi56TrRMFd1OP/EM6c
         8oYMudVstq0I+TSzaRmEBx/yV05z10/f7jbHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2Azvxdn84xto/x8V66pxCf76GAuLOkrFIRsWg8lS4s=;
        b=IO/lO40UmXaJXigQE/YoJ5QCoHRXBZDWac5/JE0FDOBQtXGaXb4OnNWPSq745U4WIy
         g9+h1niF1VBSNuSiRe0xyDrh5mG1RQHeReX/kPVDtmN5FGsXZ1zqb3dKj52AjRbztG0g
         NgP4us45x8pSIrEbTGoR0KpaiTFNKptm2jGmGK0qUXMVfgyPU38AsufnDSPkytf85bPI
         XMm7vyXvxLEk1HRCTPIBT+YalWkKAef+0AFrumWPJ+nN/LyHaXK2MjNKqs1uXb1iRLEL
         QSlpk0CfzvuMtbrNp3ya9pOXtOgmhXzN0UJDcyaLwEmdpeaYhAkjjZPtkWI6m83RxUo/
         CZHQ==
X-Gm-Message-State: AO0yUKUNxrdCIafWyoDQlVbOut3Q3wRSna6vD2xmQ1CIXTlCT0VzEe0T
        zB/xiRhwbKOSVOa3+TXT171LAjMcXpcvlhTqYcA=
X-Google-Smtp-Source: AK7set/3uUVJXMNBZsd6mfklOaZGXHtZ3ps6GgipkKEfyX91jVNWh49U5s8VxaO8FfLR2bJfpks6wg==
X-Received: by 2002:a50:a442:0:b0:4aa:9fc2:216 with SMTP id v2-20020a50a442000000b004aa9fc20216mr20542190edb.9.1676062299644;
        Fri, 10 Feb 2023 12:51:39 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id l26-20020a50c11a000000b00499e5659988sm2736325edf.68.2023.02.10.12.51.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:51:38 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id hx15so18897554ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:51:38 -0800 (PST)
X-Received: by 2002:a17:906:d217:b0:877:747e:f076 with SMTP id
 w23-20020a170906d21700b00877747ef076mr1548367ejz.0.1676062298057; Fri, 10 Feb
 2023 12:51:38 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <f6c6d42e-337a-bbab-0d36-cfcc915d26c6@samba.org> <CAHk-=widtNT9y-9uGMnAgyR0kzyo0XjTkExSMoGpbZgeU=+vng@mail.gmail.com>
 <CAHk-=whprvcY=KRh15uqtmVqR2rL-H1yN6RaswHiWPsGHDqsSQ@mail.gmail.com> <6858a9bd-a8aa-3eaa-979d-83e1743ce85e@samba.org>
In-Reply-To: <6858a9bd-a8aa-3eaa-979d-83e1743ce85e@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 12:51:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=JeuB3aDX4yej=9SE-J6RR9LG28eRVfntkoQCPpHNpw@mail.gmail.com>
Message-ID: <CAHk-=wi=JeuB3aDX4yej=9SE-J6RR9LG28eRVfntkoQCPpHNpw@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Stefan Metzmacher <metze@samba.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        Samba Technical <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>, linux-crypto@vger.kernel.org
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

On Fri, Feb 10, 2023 at 12:45 PM Stefan Metzmacher <metze@samba.org> wrote:
>
> I guess it would be easy to pass a flag (maybe SPLICE_F_FORCE_COPY)
> down to generic_file_splice_read() and let it create dedicated pages
> and use memcpy() from the page cache to the dedicated pages.

I really think you'd be much better off passing it off to the
*destination*, not the source.

The destination knows whether it needs to copy or not, and in the case
of at least networking, already has the copy option.

The destination might also already know whether it can use the data
synchronously, so that there isn't even any issue with "data may
change later".

In contrast, the source has no clue. It just knows "I'm a page cache
page". It would have to always copy.

               Linus
