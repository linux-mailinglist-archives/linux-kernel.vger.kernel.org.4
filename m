Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF6F688B96
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjBCAOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjBCAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:14:36 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9862B08E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:14:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m2so10935158ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zaQNMCliREGWsw5ki7EtaX9v0ELmXISaiv3DWIK5tsM=;
        b=DNx+UcYaPWB2GGHKmyI05nUP2WYo9nCEWB9i9rv59hvwdIew6+8E9ozFSDnwkqiR/0
         Bc5nu3ZshSHO9QfHyblOyJTTpZXUJwvxo9yU57+Y+2n/dX7I04FlrcVUmHVDqPivx+sn
         ex8/Ybm+pudw+c7E2XO7oyziEhp2m6tWVP3gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaQNMCliREGWsw5ki7EtaX9v0ELmXISaiv3DWIK5tsM=;
        b=37te++t8COKsi/pf7hEY/v8wd88e8n7rT9mP/armjDh6cWn+WhZiqg3IVqB9/1g7Ht
         STqhbyvtBzMdyU7Ao8fG1folp+0ZWhIJ47N/agn3Yw7NJ6TOdFv7Rg+HMC3xt+oVU5L6
         pRmWLKhKDW0w5HblA3TQ6kMwVyY2xgNGfXAqZ7075YAP8jrUZVap83A4Ufh/T3hmei36
         P+lXMu4k2kfE2sPqC4Fhe7WbJwcQmaDZRB9ur4jw8wuJGqSFUoqCUquk+uQz6/dPLDFJ
         B3kaSPryoYokCD+9MZRA85nz3QXjKOOq+OJaSiTDuemjK5UDQ806Cx2a+QAJo9+KWf94
         bnjQ==
X-Gm-Message-State: AO0yUKXBOEP3T/YFTrqdgfHuENaGyz9vpm7QkPxp70K0Mc6NNfqwh5yo
        6X8gDH+J1koyemUF1SM+YouSv4ZmOiHXaSDvjezTWw==
X-Google-Smtp-Source: AK7set+72qWxzvszIJcUfCpb+KIxZzP6ebCdFGHkO1LHPb4QUuS90chcyJS3Z7g/jONo1wOXdPVX8w==
X-Received: by 2002:a17:906:184a:b0:88d:777a:9ca6 with SMTP id w10-20020a170906184a00b0088d777a9ca6mr7589196eje.18.1675383273790;
        Thu, 02 Feb 2023 16:14:33 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id ox4-20020a170907100400b008874c903ec5sm513119ejb.43.2023.02.02.16.14.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 16:14:32 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id m8so3707073edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:14:31 -0800 (PST)
X-Received: by 2002:a50:d715:0:b0:4a2:649a:72eb with SMTP id
 t21-20020a50d715000000b004a2649a72ebmr2549747edi.70.1675383271716; Thu, 02
 Feb 2023 16:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com> <20230202232517.8695-2-michael.christie@oracle.com>
In-Reply-To: <20230202232517.8695-2-michael.christie@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 16:14:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTzdQr7xNm53ZUJT0jxaxSYLkf8XT2S1CoxnyFgVafKg@mail.gmail.com>
Message-ID: <CAHk-=wjTzdQr7xNm53ZUJT0jxaxSYLkf8XT2S1CoxnyFgVafKg@mail.gmail.com>
Subject: Re: [PATCH v11 1/8] fork: Make IO worker options flag based
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
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

On Thu, Feb 2, 2023 at 3:25 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
>  struct kernel_clone_args {
>         u64 flags;
> +       u32 worker_flags;
>         int __user *pidfd;
>         int __user *child_tid;
>         int __user *parent_tid;

Minor nit: please put this next to "exit_signal".

As it is, you've put a new 32-bit field in between two 64-bit fields
and are generating extra pointless padding.

We have that padding by "exit_signal" already, so let's just use it.

Also, I like moving those flags to a "flags" field, but can we please
make it consistent? We have that "args->kthread" field too, which is
100% analogous to args->io_thread.

So don't make a bit field for io_thread, and then not do the same for kthread.

Finally, why isn't this all just a bitfield - every single case would
seem to prefer something like

     if (args->user_worker) ..

instead of

    if (args->worker_flags & USER_WORKER)

which would seem to make everything simpler still?

            Linus
