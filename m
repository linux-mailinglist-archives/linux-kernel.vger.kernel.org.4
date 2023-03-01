Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C06A726E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCAR5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCAR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:57:50 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526034393C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:57:49 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i6so1201309ybu.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677693468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS8gxb/BAKcb5Qhb7xUkYJmcaclxaW+vET8K5zohQMk=;
        b=AaBkHaTOa8zX03V0EgwDTNq3O8VGEKb35AoUWDNmVkm+E7UrBXSFXat1qfbLB8ywox
         JkYeUU/XGZMaANQJZFyj7YO+i0uUNtEqAmQZ6AViTxoFHa5phKMTpLmgWAdNau/wzmod
         KP5QQUKpg6nZhDe70URJZloS3092JYZh/xbdZM4+uFC9bMiwlMvc/S2ZxuIbNCsy56Ll
         72sNbrypQuG4AgpOhXYjKhTh5UcJIHpKx858943srfJMYczYkOp+B1TxKyW2m7ahh5mP
         nKN4nJNUwk8qrDks1V+8tDSP1BTpVhT8ZLXLMiy/k/MrENdELThm5LDN/vgHxUZmSTXu
         yZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677693468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yS8gxb/BAKcb5Qhb7xUkYJmcaclxaW+vET8K5zohQMk=;
        b=m2BwXycUiWf531R8/aJ/GE7Qq/13KEXiyaGNfEzm8EzgJy3H2ImtZk6ss69bqX1iyf
         fvutwJLK4VtHZJ3tHvUCOqJKmXwJ8fUglQrQa41OorzGDxWir+KmoIy6fO/T8wC1pehY
         cyJBCNxJAM4QsErpKtkloTZmw6OW2tuapnTxiar48uWV9NGu8Cfb7FKtxLXnURCnzMoY
         EnZMqkBKyv8qGln8kMGGUGU7nhnEjtDOsfB7lGTSPyIr88YN2fmqSCcLe4JSi7Z6qAQ8
         GgkKRt8SEjhdhcla5CZRGPez0jCBtw1Xl12vz4urmFURjZl+y3qv92Acayj+roPOULzF
         Nz5A==
X-Gm-Message-State: AO0yUKWuNSvRtCsUu3V42BM56arqsVfq3t3io69fv4Vy8T9kYubHxhGL
        Ov1X0tQcmJtn8o8pawfMVj9cBsyUJes231iQisr3Eg==
X-Google-Smtp-Source: AK7set91dEBOhjZ6IK/Slp8Pqu7FBG5YQF/xJ4OuIqRX2VCv1xiN+XH51iiG5hHz3gcgshWsOtptzW2aU6l9R/ESk0U=
X-Received: by 2002:a25:9704:0:b0:a30:38fb:a2e4 with SMTP id
 d4-20020a259704000000b00a3038fba2e4mr3210561ybo.6.1677693468339; Wed, 01 Mar
 2023 09:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20230301022720.1380780-1-surenb@google.com> <20230301022720.1380780-2-surenb@google.com>
 <a45e3136-bc88-2de2-4127-62e103656242@redhat.com>
In-Reply-To: <a45e3136-bc88-2de2-4127-62e103656242@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Mar 2023 09:57:37 -0800
Message-ID: <CAJuCfpFwvgs-_M60qNA6aJHi3qQ0+WB=zcBGbFPbqJ8tu=5m-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: document FAULT_FLAG_VMA_LOCK flag
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, error27@gmail.com,
        willy@infradead.org, Liam.Howlett@oracle.com, jgg@ziepe.ca,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        mathieu.desnoyers@efficios.com, pasha.tatashin@soleen.com,
        laurent.dufour@fr.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 1, 2023 at 12:27=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 01.03.23 03:27, Suren Baghdasaryan wrote:
> > FAULT_FLAG_VMA_LOCK flag was introduced without proper description. Fix
> > this by documenting it.
> >
> > Fixes: 863be34fc093 ("mm: add FAULT_FLAG_VMA_LOCK flag")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Link: https://lore.kernel.org/all/20230301113648.7c279865@canb.auug.org=
.au/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > Fix cleanly apply over mm-unstable, SHA in "Fixes" is from that tree.
>
> Okay, that should be squashed then. LGTM.

Yeah, both fixes in this patchset could be squashed into the original
series without information loss. I'll leave that to Andrew to decide
what makes more sense here.
Thanks!

>
> --
> Thanks,
>
> David / dhildenb
>
