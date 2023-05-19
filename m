Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08056709C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjESQib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjESQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:38:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FBDEC
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:38:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f576ba41dso212309766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684514306; x=1687106306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afFaOwVkDQVoLtMd5ERUW5Y+E5Lld4ra+zl50KIIzto=;
        b=ZbrVrWRfNglslqvGcmAWJPXqCk6Euvmmjr3+urqqJAtD7nOd+18enTq5hPwB6HpwPG
         BUEXeo9PmfauhXj6WeDSGkrFTa79FPQQ6rZjk+kciqKVW2LLpIGfU7dkY8jHPmNu9za9
         MIrzWjxqgqJ01/tCH0D5s8e7kSDQ+TRLkQfdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684514306; x=1687106306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afFaOwVkDQVoLtMd5ERUW5Y+E5Lld4ra+zl50KIIzto=;
        b=DpSEh7fIda7U13L/+OFlnlFeC3jqaG5TQGTN0XMh90+oAHGSmR93BKfw/koWfzI5S7
         oR2Ejuij9kZ0ZybudyTmtt8ko3YQiFYXXbUXNPIA8Pq3krGKy+ktC5C0Yt8/PU+JE08P
         3qZ3TVRG8n9fndEcNjkVRA2/9Fn8HxagxST3E7MoQrK1/9bECMdN4imR5L4RfvlL2T4j
         rsrdV23Yma4aX+czZUGnt47/Q3zMPTqlxnW73d/BNc/oRzcFNThWxJ90hLAN7qZ2/vXg
         Aq2oZdwSU8RAfQuKe00QST3T9rWNe412iW1LbKI2pQ/9thX6RJcYDNE7i+XkF+F616PX
         s/yQ==
X-Gm-Message-State: AC+VfDw4WgXlFFX/y3JH/luoFH50ZhMgRrvKt7GODbcB5/ra6rV6WXz6
        8tzJFEU2y/uuroGmZ6OPHaTo0bBlR09hSi02hz24yZUh
X-Google-Smtp-Source: ACHHUZ4gr29xaduyYfOzei95ifYjENoFD6KCAebLUOfbpxXd3SBld9nwYap+yeCYYtqsHACVWCmtDw==
X-Received: by 2002:a17:906:7304:b0:96a:1ee9:4b0 with SMTP id di4-20020a170906730400b0096a1ee904b0mr2029531ejc.33.1684514305983;
        Fri, 19 May 2023 09:38:25 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id d13-20020a50f68d000000b0050b57848b01sm1919835edn.82.2023.05.19.09.38.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:38:25 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-96f576ba41dso212305366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:38:25 -0700 (PDT)
X-Received: by 2002:aa7:d7cd:0:b0:512:698d:34ac with SMTP id
 e13-20020aa7d7cd000000b00512698d34acmr65349eds.12.1684513894474; Fri, 19 May
 2023 09:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-4-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-4-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 09:31:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com>
Message-ID: <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof
 where appropriate
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
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
        Christoph Hellwig <hch@lst.de>
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

On Fri, May 19, 2023 at 12:41=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> +
> +       if (S_ISREG(file_inode(in)->i_mode) ||
> +           S_ISBLK(file_inode(in)->i_mode)) {

This really feels fundamentally wrong to me.

If block and regular files have this limit, they should have their own
splice_read() function that implements that limit.

Not make everybody else check it.

IOW, this should be a separate function ("block_splice_read()" or
whatever), not inside a generic function that other users use.

The zero size checking looks fine, although I wondered about that too.
Some special files do traditionally have special meanings for
zero-sized reads (as in "packet boundary"). But I suspect that isn't
an issue for splice, and perhaps more importantly, I think the same
rule should be in place: special files that want special rules
shouldn't be using this generic function directly then.

                 Linus
