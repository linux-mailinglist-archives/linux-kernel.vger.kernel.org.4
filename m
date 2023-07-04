Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666F6747786
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGDRKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGDRKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:10:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC2F3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:10:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9924ac01f98so711409066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688490633; x=1691082633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NInIoTXHnfyzm6QF9CbEiMuJrtrExLNeYRgH/orq6kw=;
        b=akjDXgUAKFymHvwP62XXmHCA9GMcfWmrZ7wrQwCXE7ec9cT/uge4aFmaVG80tkwh7H
         gdl/Fc7P/X/JBAFiE/vBIn2yVZ6V2XSrfNT7Oyqplj80hKKduNO8AxHOCoII2p+c8aRp
         3WBWiHLKukFXhIPKkA3IHFbj40PRnNhhHvb9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688490633; x=1691082633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NInIoTXHnfyzm6QF9CbEiMuJrtrExLNeYRgH/orq6kw=;
        b=GBHydXFgWkBAlGAgpEfX09+B2kYN1nVFL+yCwvYklS0/HzhomtVt+lsThgkDfIJw04
         mI1g1pP5zfxe52RnaVfqmr5E7VLdXfMn33UjKdQx5tidLA2LttDvcMVvqqnKrqR6b3X8
         JAViYgtt6iTO9NxmBinprfnvYOYUIdaVgwzyBHfZAHo7uDn473lUQkmvnCHYbXoZQAb+
         OiQ7Mitgk803SMJyYNvRSqOftob0btIccchwWmAUsD9KrKS8XAWe8v2sAIX6n8Om/blL
         Zm2TheJ6E3aTMXVBi14bkeATXR6tYzTHoL7ekaNeHaxrWrjL7YxKSml1tSVu+b672ILF
         nJ6A==
X-Gm-Message-State: ABy/qLYZ/QMhbXYE7Hol+j2aB2rX3vDEBrAPCy84sEFERkMY+JmCH5CC
        ueLlQlTMjs0qoj91ioebFAnSeFtf6ATKYeiOY01mO0SG
X-Google-Smtp-Source: APBJJlEAwjkLe9cGUQ5rLzvwE2ygMUOrJTESc/OlA6eJv2R3zdLzke9huvZF9meGAGKbizyHX4eqDQ==
X-Received: by 2002:a17:906:edbd:b0:992:c0bc:34a2 with SMTP id sa29-20020a170906edbd00b00992c0bc34a2mr9704255ejb.42.1688490632868;
        Tue, 04 Jul 2023 10:10:32 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709063e4d00b00992ae4cf3c1sm7266276eji.186.2023.07.04.10.10.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 10:10:32 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d7f4c1cfeso6846017a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:10:32 -0700 (PDT)
X-Received: by 2002:aa7:d9d6:0:b0:51e:527:3c64 with SMTP id
 v22-20020aa7d9d6000000b0051e05273c64mr7824520eds.16.1688490631850; Tue, 04
 Jul 2023 10:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230704092309.22669-1-vegard.nossum@oracle.com>
 <20230704100852.23452-1-vegard.nossum@oracle.com> <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
 <7cf14d1b-1a3a-fea7-0d2c-409ab828569b@oracle.com>
In-Reply-To: <7cf14d1b-1a3a-fea7-0d2c-409ab828569b@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 10:10:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg70vQAKPOqo-Ym6n47KSpm09kc-dmKME9Sd1HUcdZ-sg@mail.gmail.com>
Message-ID: <CAHk-=wg70vQAKPOqo-Ym6n47KSpm09kc-dmKME9Sd1HUcdZ-sg@mail.gmail.com>
Subject: Re: [PATCH] module: always complete idempotent loads
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 08:12, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Maybe just do the f_mode check in finit_module()? Or... new helper,
> fdget_mode()??

I actually wanted to do a fdget_read/write() helper long ago: we
already basically pass in a "this mode is not ok" flag for the
FMODE_PATH case, and it's sad how many extra "do we have
FMODE_READ/WRITE" tests we have when it would actually make tons of
sense to just check it at fdget() time.

But I created the patch, and then decided it was just churn for
something that didn't matter a lot.

The existing "mode" argument to __fget_light() and __fget() would end
up split into "error if these bits are set" (existing) and "error if
these bits are _not_ set" (new) arguments.

It was straightforward, but I looked at the patch, and then looked at
all the existing users that currently check the error separately, and
went "bah", and threw it all away.

Which is not to say it's not the right thing to do. Maybe we should at
some point. But doing it right (ie doing it in that helper before we
even bother with reference counting etc) is just a bit too much work.

The alternative is, of course, to just have a *truly* stupid wrapper
that does the error checking and does the "fdput()" if FMODE_READ
wasn't set. But that's just disgusting.

Anyway, for this module case, I just moved it out to the caller.

> Apart from this, there is another bit that looks a bit weird:
>
> len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
> if (len < 0) {
>      mod_stat_inc(&failed_kreads);
>      mod_stat_add_long(len, &invalid_kread_bytes);
>
> I don't think we should be adding error codes to byte counts.

Ack. I fixed that at the same time as a "multiple problems with the
error paths".

                 Linus
