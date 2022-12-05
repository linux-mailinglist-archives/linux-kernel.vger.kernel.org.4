Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D0A642ABD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiLEOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLEOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:53:47 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349AE1CFF1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:53:46 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d14so5171029ilq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 06:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8WCQX0onWpnDBVym9j3m/71P7IfFJWXQgDgdNkbKEOU=;
        b=QDv/tdmZd50a2ODcrZ0WTqSu28qAlF3OcWR1QmiCMovrPPKuXhrGXlyx1TlGpnlN/5
         EtJxEq3u6c5XDJ4eUP79yx3GY5ExJ3PUivMVhBa+8echINDQN+FjVpEX+NRy42/uA04N
         +1otezEkxx4xOoqIlsML7fMf+lXyIpTZN2bxufZJgJhebUg0GD/ArfJ826aUlsE8qzgk
         EkDPR7bY/8piqphYHOfrsMXsOpB1BNbZGXCNGIIqhf3Gryeug9RFjRYlb+eHGAKuIowP
         c9HsnXhVV+DAFnDf7b5fi9PhRnB/V8daAJ94lgIwFaxFizFqoDfDPAzHZi2rxSHtDqvW
         3+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WCQX0onWpnDBVym9j3m/71P7IfFJWXQgDgdNkbKEOU=;
        b=AFzDdWgbIcbRhOkSt8jYCqIvZr/d5uxmxKqxZvW3hQahNPLMBPWBlImM2tDoAgJcxK
         5A9JjvkvlILks68906Y4bSLYeam3uiTs53IRaPsl2IspMmtntmdj0RHifmYdvZ2T1PCX
         3DUs+8w12+dCSyyYpr1nORtRw9B+5wHS9GKi4cIhWTZyyPmRnb5ByzLDsJQep3zQrG4d
         dUi6I3U+SX0C6FqvbmOJj51t4rd6gI+cCoKzzdWLmtgnN31hesd+XFuSBzSCdk7xOqvw
         vYYC82XMpbneiYF3E32GYzlsTs5oHZ0UQawmAmCF/kK8t/t0CXGe1yOBQXCjG8RGxwku
         srXQ==
X-Gm-Message-State: ANoB5pkt24/HZgQfKPmMGA62n6LoqBlVRlqY7ZBjWRYek6SlPnh5GSuU
        c0JsDj4SqtTbgXoZ73CHqkpmJmrG5YOS7jeIuafNNA==
X-Google-Smtp-Source: AA0mqf48t9WhD9Pqk3NhT0dysGZhuPb9owsoth4mC4RS3ROjbVP1SzRpOeeYPwlCsiepriuTkyIxEFnAaP15Y13uEgM=
X-Received: by 2002:a92:6809:0:b0:2f9:4d92:5b2a with SMTP id
 d9-20020a926809000000b002f94d925b2amr28697063ilc.177.1670252025218; Mon, 05
 Dec 2022 06:53:45 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8PEizPDwMGFd_ui0Nrw@mail.gmail.com>
 <20221205145005.ku75npr3dsz3fqgo@revolver>
In-Reply-To: <20221205145005.ku75npr3dsz3fqgo@revolver>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 5 Dec 2022 15:53:09 +0100
Message-ID: <CAG48ez1=dLpebzSNu+8_kOfbVLySXZF44nmr+TU5m4cUjg0MBA@mail.gmail.com>
Subject: Re: brk() in v6.1-rc1 can expand file mappings, seemingly without
 taking file locks
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jason Donenfeld <Jason@zx2c4.com>, Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 3:50 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> * Jann Horn <jannh@google.com> [221202 13:54]:
> > As of commit ca57f02295f, brk() can expand ordinary file mappings (but
> > not file mappings with weird flags), and I think it does it with
> > insufficient locks. I think brk() probably needs some extra checks to
> > make sure it's operating on a brk-like VMA (which means it should at
> > least be anonymous, and perhaps pass the full can_vma_merge_after()
> > check so that we're not creating unnecessary special cases?).
>
>
> Thanks.  This is probably caused by commit 2e7ce7d354f2: "mm/mmap:
> change do_brk_flags() to expand existing VMA and add do_brk_munmap()"

Yeah.

> Specifically the checks around expanding the VMA.
>
> > user@vm:~/brk_stretch$ cat brk_file.c
>
> Thanks for the testcase.  I have a fix that I'm testing, but it's worth
> noting that the brk call will succeed - except a new VMA will be
> created.  Is this what you expect?

Yes, that's what I would expect.
