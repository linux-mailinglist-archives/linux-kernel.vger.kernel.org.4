Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA9E6F8DC8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjEFBx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjEFBx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:53:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9744C01
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:53:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bcae898b2so4392594a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683338032; x=1685930032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maiOZWo4uY15gUQWerfOM/hHk3V4D/czecwW7zDGBv8=;
        b=eP7zF8JvpJEWwdEy7XvVkJqia2mB+7OOkkYGqPG/L6bxWMZ0NXh7A0mClq91MYEYeT
         G2YhjkJ7BZEhOL5lguyZ48DHvkBzs2W4i2Rqzp0Ky+OuSByrmj05sGMyMVZrPfLRKs+p
         +JFA32F8uyqKGJkH9XeERsVJlc0wJiJ6JE9bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683338032; x=1685930032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maiOZWo4uY15gUQWerfOM/hHk3V4D/czecwW7zDGBv8=;
        b=N1aYUVHzb4qONyBOluSxFvusW1Acy7rz5HGsFuBCtCAUlQQUnUnyjBB0mMYHdUGXRg
         jeEbR8d3kCSx5xEvTFNFENfL4V3unTJmedkzljLu5Kw/YGG4mF1XBMwBCA8vNv+Dojfq
         rqNWArP23EepzAUYRfey1tTJUvp13s1gA8o093BUMENrW8A8kpgi1b8mc1ACCzkXXKyh
         TfxsAlIr2Fmdh8YtpEPoSYojzstUGTUbZeX3FtU2A+i686miWZbqk/L+OJ2lRtjQlewy
         w1ba/5CAQPJ7h+cFjlM8fz9rzosC7VnaA0I3GBsXxy4Et2dn18nD9zYO4t9P9uUPctZ5
         nZlg==
X-Gm-Message-State: AC+VfDyUcJUp/Sd7FwQsrrZ+ZZSRNXARegnfGJEdTmtSISDqFoOa+gaI
        GW9JMObrnWDvz8YmhnfIlF4e0Kmo/SXqsDdEtG6kFQ==
X-Google-Smtp-Source: ACHHUZ5LnT+Psy0rxV0uG9FPF92CQUHRLq6yiX3Z7uiuK1CW33Nyt8Oww7Ch8hoIqA6fI557AsKkuw==
X-Received: by 2002:aa7:d59a:0:b0:50b:5dbe:e0f6 with SMTP id r26-20020aa7d59a000000b0050b5dbee0f6mr2912539edq.25.1683338032449;
        Fri, 05 May 2023 18:53:52 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090686cd00b00965bf86c00asm1624303ejy.143.2023.05.05.18.53.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 18:53:50 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9660af2499dso62501366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:53:49 -0700 (PDT)
X-Received: by 2002:a17:907:9345:b0:94e:c4b:4d95 with SMTP id
 bv5-20020a170907934500b0094e0c4b4d95mr2455003ejc.69.1683338029657; Fri, 05
 May 2023 18:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com> <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com> <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
In-Reply-To: <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 18:53:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifMNUnnuqXWjuSq2jM3VOKmKNjyW9FAsi3aEtV5PFcVg@mail.gmail.com>
Message-ID: <CAHk-=wifMNUnnuqXWjuSq2jM3VOKmKNjyW9FAsi3aEtV5PFcVg@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     Mike Christie <michael.christie@oracle.com>
Cc:     nicolas.dichtel@6wind.com, Christian Brauner <brauner@kernel.org>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
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

On Fri, May 5, 2023 at 3:38=E2=80=AFPM Mike Christie
<michael.christie@oracle.com> wrote:
>
> If it's ok to change the behavior of "ps -u root", then we can do this pa=
tch:

I think this is the right thing to do.

Making the user worker threads show up as threads with the vhost
process as the parent really seems like a much better model, and more
accurate.

Yes, they used to show up as random kernel threads, and you'd see them
as such (not just for "ps -u root", but simply also with just a normal
"ps ax" kind of thing). But that isn't all that helpful, and it's
really just annoying to see our kernel threads in "ps ax" output, and
I've often wished we didn't do that (it think of all the random
"kworker/xyz-kcryptd" etc things that show up).

So I think showing them as the threaded children of the vhost process
is much nicer, and probably the best option.

Because I don't thin kanything is going to get the *old* behavior of
showing them as the '[vhost-xyz]' system threads (or whatever the old
output ended up being in 'ps ax'), but hopefully nothing wants that
horror anyway.

At a minimum, the parenting is fundamentally going to look different
in the new model.

                   Linus
