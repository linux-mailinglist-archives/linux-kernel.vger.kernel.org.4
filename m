Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279556BBA60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjCORBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjCORBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:01:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013B559E70
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eh3so22244468edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678899645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNcufV/o6gXGVvEybdJYpsgEKHaP677A9vzHvZRO1S4=;
        b=hmklnvS8zFNaTwg4I6AQ8EgxC3rDC55Fy1yfRRBp55jWHPiflyBzeHx2PDt50zg8GT
         D8dve4rM25zjPPSNbTl+uptvWB3CXXHZbGRLv00MJOeGP99iz9VvwSrP1tZCPGdmqxt5
         UYJQJr2DMflIuMNL31dLUytSBT/8YJpsXrhPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNcufV/o6gXGVvEybdJYpsgEKHaP677A9vzHvZRO1S4=;
        b=BrOY1F5rhx38IzgfEfRZOWEYa+/aQOWS7fkk6ToxSMuk0k+HoZUFCk8oiglPc3c+Fy
         gvXvAYudiHvzsJ0RN7hJznF+f5EtMnxI3Iss7wk8Dst+Aew41teK2YBX3QO6bYZNkmd4
         mejU2bwzALmw0x47dYVg2wZPxpR9GLEtHSFDaeBTrGgJ0wFEimZF83vYYO5PSipswlGv
         HAPAITer26t5lQ48ff5tINJClSXDkvtjSQazwLooaxIMPOILc3Dz3/063garKo7hFJ1t
         toP5xAGUCFtNviLUPafd+gKh0dBp3F5/PZqXz3nI131dQXWGynw9WE6Fb1MrkhQhYc56
         8xkA==
X-Gm-Message-State: AO0yUKVFXp0iEpqa+OnT/3zQqxAZFAB2QNGeeinuYYA+uWy5fT0M5X/4
        L3diHl74PYoYgvYRksVB8qpODprz29P1+Hp04M29mw==
X-Google-Smtp-Source: AK7set9lB7bq6obO5Ih/ViE4ogINwZdBVX1oKXlXMRtlGFLay2HB7+GAcy/jf+PAG5ODK+Vv/nS12w==
X-Received: by 2002:a17:907:7750:b0:8f2:bcb5:bbf2 with SMTP id kx16-20020a170907775000b008f2bcb5bbf2mr7640746ejc.44.1678899645346;
        Wed, 15 Mar 2023 10:00:45 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id qa17-20020a170907869100b008cecb8f374asm2771696ejc.0.2023.03.15.10.00.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 10:00:44 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id x13so30819610edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:44 -0700 (PDT)
X-Received: by 2002:a17:907:72c1:b0:8e5:1a7b:8ab2 with SMTP id
 du1-20020a17090772c100b008e51a7b8ab2mr4223971ejc.4.1678899643988; Wed, 15 Mar
 2023 10:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230315163549.295454-1-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Mar 2023 10:00:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSfbFAVvXpbRJ0NkNJbpo93d5ObdoHcNMvX4CYGrafAQ@mail.gmail.com>
Message-ID: <CAHk-=wiSfbFAVvXpbRJ0NkNJbpo93d5ObdoHcNMvX4CYGrafAQ@mail.gmail.com>
Subject: Re: [PATCH v19 00/15] splice, block: Use page pinning and kill ITER_PIPE
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Mar 15, 2023 at 9:35=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> ver #19)
>  - Remove a missed get_page() on the zeropage in shmem_splice_read().

Ack. I see nothing alarming in this series.

              Linus
