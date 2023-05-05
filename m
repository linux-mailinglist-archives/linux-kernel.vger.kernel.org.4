Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87906F89E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjEET4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjEET4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:56:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB00CE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:56:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so3969487a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683316610; x=1685908610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uodfulsdtw3sjyDmNcqZAR5xNDZaRRbWPpVcbEZw8Ik=;
        b=g1QeXrB7FG/nbTL7X7ZxVgUBymz6dKyR8phAGcAOfTG3K0be/NvuAxg2oHFVb7o+oy
         E1yvQPVd9a2OecanwcE+tLujgTIJjFeAraalgLG8zCy5ZyaglaWl4KRLDv9EmuNtymwV
         1lGSWakyKTfssiMFMzFuMFVJ1gYDPaHexjp6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683316610; x=1685908610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uodfulsdtw3sjyDmNcqZAR5xNDZaRRbWPpVcbEZw8Ik=;
        b=Bxcs7aXSF97zV2JybWRvBVpt5c1nWkz8E2iUfEpRKPgUA+fyZSc0Jc3kUyfmJpu5pP
         RefE1zLaxb4X2jIwYnOmkA79GCOJj2TFnj1bywiUUVdP+PQ13nEcLs7XjfUgZicJg+3J
         EXnAWPecvxdcl/hNSG+o+VEp5V/lAa2f0cv/yFpW8uD0WozVgLjA3/sjY+K8FC7ukwt+
         lvfjKDFwBtO4PyTcsPesxC5A2z+B6m9oU20WaWnKkvD7fc58+zC9R0wEEihfLuT+7CeW
         blQ9WNkFlfx7o4gbUj5Lb2EU5vMTEhZcxypV2FZBXc5u3hY3ds+DpXzf4vD49kY3py8D
         Rb2A==
X-Gm-Message-State: AC+VfDzgpK5qrprgxPluBPC5UWdHl0+Hq8ZrRqZ21ct5alN+5U4PmvxE
        pD7pxqNxC5bufCaYx1RVP9zCbT8hI3jttUl6RU7RDw==
X-Google-Smtp-Source: ACHHUZ46B0qvH5V4YUuc4vFmHuLNG/Yh4dRnou0Oxw2++bG0V3PDUtT5gYev0VJONNPOQ+wh5Owjvw==
X-Received: by 2002:aa7:c99a:0:b0:50b:d303:d2a4 with SMTP id c26-20020aa7c99a000000b0050bd303d2a4mr2334008edt.27.1683316609688;
        Fri, 05 May 2023 12:56:49 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7df92000000b0050bd59fd0efsm3202028edy.49.2023.05.05.12.56.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:56:48 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-956ff2399b1so415837366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:56:48 -0700 (PDT)
X-Received: by 2002:a17:907:6e25:b0:947:72bd:f72a with SMTP id
 sd37-20020a1709076e2500b0094772bdf72amr2287948ejc.72.1683316608164; Fri, 05
 May 2023 12:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com> <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
 <CAHk-=wgokAgkTVpEHM7c8oP9mca5s21RcxksF8h3FwWFJbCu3w@mail.gmail.com> <20230503190147.GA1719388@hirez.programming.kicks-ass.net>
In-Reply-To: <20230503190147.GA1719388@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 12:56:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVyHr9guj3fUh=Wq5vK+EMHN03VdBU83U6y2a+x9XCUg@mail.gmail.com>
Message-ID: <CAHk-=wjVyHr9guj3fUh=Wq5vK+EMHN03VdBU83U6y2a+x9XCUg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
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

On Wed, May 3, 2023 at 12:02=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Looks sane from a first reading. But I'll try and have another look
> tomorrow.

Well, I didn't hear back any more, and I was merging architecture
code, so I merged my branch too.

It does fix at least two bugs, even if those bugs are not necessarily
all that noticeable.

I guess we'll see if it introduces new ones...

                    Linus
