Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D76B9F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCNTIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCNTH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:07:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D4D22A1A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:07:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o12so66224811edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678820875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XXQN4LaizH2j4eXVSdO1xOJU1STk3wgvGGHOknlOD8=;
        b=a6WyRdFfi0DT7KYrcVh8KTBoERDVjfv/XJ6l0uILwYMBAPnA/UBOlqSBYK5E8mAA5E
         gyMsC6wKiXOOl13zzf6+ip5YEB6dQ1oXi+QLJ8Z5sLuxArOr0GPojIVKAlN0eNCjCQTJ
         oTKawdKO94eDLMqkex9c7ds01Gql5IOB48HKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678820875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XXQN4LaizH2j4eXVSdO1xOJU1STk3wgvGGHOknlOD8=;
        b=YPb0tCDSDG5Bmjx8qrIpVt+HcTgVFP1GB/4ayS85AaS5y9BB6jmlE5HbJejlIgiKHB
         4KTvNCo6AJEXoHqpS4RILohN0GoAqhg3ZTbe0qokBpHzvHoY9pMDU9ktbVD8IUrEYkrH
         pDkWly3c5BM8XpUcycqwbxO0DSSU3bY8MNNPLfrijiivF32rBCnVENtj6XcCHIWsw8cq
         bB8jpLvXxmRa5AMZFacNbn/zuBbO2N9j3xqE2EW6n6nfDt+Hq+r1Q6XVT/d0UXFAVVmH
         q4bqZ+D7v4xtND6s2ZhSQf7fXI5rflssxikER6mClt7xjO2Ch10+V+w9oeMh1XQkD/+h
         mHpg==
X-Gm-Message-State: AO0yUKVmvqu56KdsndnnxgbZciwoR8Ze3QmCiOzU49CrmLM3CioGb3Lw
        vPdPxnr8IPn9HR2/hMgss9t/+0fa9y2zTnCHZQ1MPQ==
X-Google-Smtp-Source: AK7set/w8BoQkrTEYzGlwWOCA2ojizrPkT3Vmao9NomjyMExwzK397jTlrBByNF3zB1Bs0AsI84X6g==
X-Received: by 2002:a17:906:9508:b0:907:6759:7679 with SMTP id u8-20020a170906950800b0090767597679mr3539591ejx.54.1678820875461;
        Tue, 14 Mar 2023 12:07:55 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id hd31-20020a170907969f00b0092d58e24e11sm1001048ejc.137.2023.03.14.12.07.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:07:54 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id da10so66352163edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:07:54 -0700 (PDT)
X-Received: by 2002:a50:d506:0:b0:4fb:482b:f93d with SMTP id
 u6-20020a50d506000000b004fb482bf93dmr106272edi.2.1678820874229; Tue, 14 Mar
 2023 12:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
 <ZBCkDvveAIJENA0G@casper.infradead.org> <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
 <3761465.1678818404@warthog.procyon.org.uk>
In-Reply-To: <3761465.1678818404@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 12:07:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
Message-ID: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:26=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Are you okay if we go with my current patch for the moment?

I  guess.

But please at least stop doing the

     get_page(buf->page);

on the zero-page (which includes using no-op .get and .put functions
in  zero_pipe_buf_ops().

Maybe we can do /dev/null some day and actually have a common case for thos=
e.

             Linus
