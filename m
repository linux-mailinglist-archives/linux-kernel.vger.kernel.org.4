Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB76F1090
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 04:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344783AbjD1CyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjD1CyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:54:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D8B1BFA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:54:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-95369921f8eso1519394066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682650448; x=1685242448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9mxxPAl4POq2fq0d8t6aqpR8L52uoUsixYLH2L9aFc=;
        b=ZPk0kJ3F0NtZVICxhc3a3DXop4x4L91ocVVqE6hotNGm7wYzk9hjYizAd6xEbDFkNx
         xQlbQrVEZgQiUjP7CyzX/mVC91Ds+FzOGiyUtvDiz6nGl/bMnws3jXj8gAcNqX8fiOh4
         Ktpfpqcvab8BvlwGJQ/grUpV6NWFBFjBsZAGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682650448; x=1685242448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9mxxPAl4POq2fq0d8t6aqpR8L52uoUsixYLH2L9aFc=;
        b=cNxxR7Q1KsyqhhOj5n1ulmLY4I84NDRTKD9lGZm/Wh8rfrU53HUkxmttsw91EQbfPE
         UhOXeeX6JQ7igOauU1ohcIeSWI25ZKzRuDJ1HqnBFZHXg5Erv+y+vqzRgptz1tJb6oh6
         bGgBsENIeqMg3yHLO5N2bMRnB8F6ezX6kV0ByyP5gQM0eI8UI+Ful9bK0y3gPaUHHgnr
         zOiCJrBBa8iVQeQ6YT38W1OvbUlWAIuNfgOrYJwqf701Y+KIIeDH81oknwmyUI60jEvt
         nWVH5aiYdBAk04xhLnz1ClsCWI7F3mqFnZqSCTafC5c1CYe1ayHUHIxNlqJSLy4Vuu3l
         sY4A==
X-Gm-Message-State: AC+VfDxwpTWN7cjoKCwCbrPXNh0dpsXsFgz7tsogbhc29kQngWE8hQpj
        m2/Di09qeCbN78dztlWoFman4w8hcLyfgr8x8X2maQ==
X-Google-Smtp-Source: ACHHUZ5ajjIjCpCZZp9Whdwe9j+dmrjgu7KdJT2bBL8Yn9j8OH2SHxhRItfIcW+EuEey4bnx6d/2xw==
X-Received: by 2002:a17:907:970d:b0:94f:6852:549b with SMTP id jg13-20020a170907970d00b0094f6852549bmr3936184ejc.9.1682650447864;
        Thu, 27 Apr 2023 19:54:07 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id ml24-20020a170906cc1800b0094e6a9c1d24sm10771053ejb.12.2023.04.27.19.54.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 19:54:06 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-94ef0a8546fso1518569266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:54:05 -0700 (PDT)
X-Received: by 2002:a17:906:da8d:b0:94e:4586:f135 with SMTP id
 xh13-20020a170906da8d00b0094e4586f135mr3520975ejb.6.1682650445056; Thu, 27
 Apr 2023 19:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230427140959.27655-1-vbabka@suse.cz> <2023042719-stratus-pavestone-505e@gregkh>
 <3cc6e10c-f054-a30a-bf87-966098ccb7bf@suse.cz> <CAHk-=wgdGzy6-3jzN6Kvtz1QxStTZBZPz1zy9i4gM9nbe5FGbA@mail.gmail.com>
In-Reply-To: <CAHk-=wgdGzy6-3jzN6Kvtz1QxStTZBZPz1zy9i4gM9nbe5FGbA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 19:53:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwoKFbrCGXW9uwX3SPOezLdOKstuLAju1KTi5Ryq+ZcQ@mail.gmail.com>
Message-ID: <CAHk-=whwoKFbrCGXW9uwX3SPOezLdOKstuLAju1KTi5Ryq+ZcQ@mail.gmail.com>
Subject: Re: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in
 vma_merge() case 3
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Greg KH <greg@kroah.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
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

Hi Vlastimil,

On Thu, Apr 27, 2023 at 8:12=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ack. It's in my tree as commit 7e7757876f25 right now (not pushed out
> yet, will do the usual build tests and look around for other things
> pending).

Gaah. I just merged Andrew's MM tree, and while it had a lot of small
conflicts (and the ext4 ones were annoying semantic ones), the only
one that was in *confusing* code was the one introduced by this
one-liner fix.

I'm pretty sure I did the right thing, particularly given your other
patch for the mm tree, but please humor me and take a look at it?

That 'vma_merge()' function is the function from hell.

I haven't pushed out yet because it's still going through my build
tests, but it should be out soon.

                       Linus
