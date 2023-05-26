Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB3E711E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjEZChT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjEZChM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:37:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686BC13D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:37:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af98eb6ef0so2377671fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685068624; x=1687660624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFUluCk6Yg3CJh7zCYAWn34AyV3ksw1s+RmFmqdT4VM=;
        b=ZVVvNEeuRvv5sf0kqOR514LS1Iu+5Ia5iGdHgcuCiLHWeZh785cO8pEma86B0ZW0Kg
         awOf49dZ5Tem6bJ35Rurh91k6U9qPXumeUMeJycnRO/1Jlk5WWD9sq4jUUA71xamEEAf
         Mh7tU69J8JoTn3eZkjKGVXA4JsSM1ilICrrE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685068624; x=1687660624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFUluCk6Yg3CJh7zCYAWn34AyV3ksw1s+RmFmqdT4VM=;
        b=XSmGDrX/0gWiCnXKNz4DLYpoCGGC/14xl6EzTTufUYxqi9oNoJjKDkvzhyAZ332T8i
         DLCqbNmP36hkhThpzS9k7bykVHNzpdFVzqE9GjCTsAowyuVWkipNmtvAFxOKgh2hjZl2
         nKCd2eupZrl23Xlv3iA/dKnB656dYybCFZe6uTCLt7psDRtp5SHEw9shJBAAnY9C8P0E
         hLAWIMIu7OJHQM2KW4lBt6lKzeMtDqz1nvrwaJiKxFsTQucdZ2v8fqJ/loOpXNLtISrm
         Vm5ct/G7kApmm8pk8W1hJcaB+Qcwu1B2iqXtGseMEloT0ecoZwV+ZI3xtS1gKQa663LG
         t6OQ==
X-Gm-Message-State: AC+VfDziW4gZc6wkdeVi2WqWyDUJFeZFpoetMVEUJ5VApBrliiQYYZXN
        unwoRJ4GeyG2Saw2YQinFuBWydEBilBFNDU8aVqq1jX4
X-Google-Smtp-Source: ACHHUZ44T8X3NEDASeEC6YImyVDqUaOr6zJLZcQZzR33/8ilSpbKJskN20Z4+olVcZfeywguDwAd8Q==
X-Received: by 2002:a05:651c:234:b0:2b0:5a04:a5bd with SMTP id z20-20020a05651c023400b002b05a04a5bdmr128690ljn.42.1685068624583;
        Thu, 25 May 2023 19:37:04 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id l12-20020a2e3e0c000000b002b02e3f7ef9sm470221lja.61.2023.05.25.19.37.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 19:37:04 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4eed764a10cso183046e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:37:04 -0700 (PDT)
X-Received: by 2002:a17:907:d10:b0:96f:d345:d100 with SMTP id
 gn16-20020a1709070d1000b0096fd345d100mr533983ejc.59.1685068179297; Thu, 25
 May 2023 19:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230525223953.225496-1-dhowells@redhat.com> <20230525223953.225496-3-dhowells@redhat.com>
In-Reply-To: <20230525223953.225496-3-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 19:29:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=win3ttfr2xb1JcGroPSOoqGs0GooZq0DLsRtZzXUH5YeQ@mail.gmail.com>
Message-ID: <CAHk-=win3ttfr2xb1JcGroPSOoqGs0GooZq0DLsRtZzXUH5YeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] mm: Provide a function to get an additional
 pin on a page
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
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

On Thu, May 25, 2023 at 3:40=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> +void page_get_additional_pin(struct page *page)
> +{
> +       struct folio *folio =3D page_folio(page);
> +
> +       if (page =3D=3D ZERO_PAGE(0))
> +               return;

You added that nice "is_zero_folio()", and then you did the above anyway..

               Linus
