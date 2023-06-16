Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3203B7325EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjFPDon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFPDoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:44:38 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4947C13E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:44:13 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b2b7ca1c5eso265808a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686887052; x=1689479052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a2Ulv78QuAGjOi2j/pfaZAa8VD3gW+dIc1IlHPwhgo=;
        b=WcMGhEKyC3M+S2Merj9KVwP4lTvDqjUOwM+WsD7R8r78jFEHYCOb7QrRYryNmslBn+
         OsWYgynlgJz/mcUXa0vBkSQ945w5T4IFIyncfGNrVA2Kv0IBT7mN9BturcRyGQmdWhHC
         tX/IA+5U7XsLq4APaAO00qJ5CM241RQVgLiqt1+ef8FiXESMLVWT1wc1EObXu9aq960J
         5Bh+3DCFMZAx/6KkROmen1I36YCFdEDYAzZrGepvW1GDmZn6wFYbv73Wy174qrAZTsI9
         Qyf2xesGgVG9ZmrBb4PA1pnXVRRu9oOxtmLw5/fD3dhfm64edfsmojJnZwgwsDCQPlmc
         XqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686887052; x=1689479052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a2Ulv78QuAGjOi2j/pfaZAa8VD3gW+dIc1IlHPwhgo=;
        b=evee0A1tOUIp6YE4ZDXLBiUNoQMj300NRGwKKSpX1INsq7KQzjUMEEs+8Uc34pFrTG
         GpBYqnwCX3QBKsiipkZC0GYKvBn0K6r0rjdjNoHUD+//vgwFObFGWauJRXUF0IkfTbeZ
         bRb1afhwoXohKiA3PXJy08q9kejktLzRGQBrZxYeUMMP7ICU9c4cVQsMdyZUV1YOx70Q
         JahXz6Q2CozMs3hM8yai+MdXqLqURMF0Ali833Cy2GEgtnqJ/ZPd+WzuTk5QtgM0GPkO
         +38IdeKZ53Oau0DMFYv3lIe/VCyvrw8hhQtRRQstLpZ/VfQ+Hh7xFmVS9UrEwmgJ9Fi8
         zqAw==
X-Gm-Message-State: AC+VfDyspDvVmyCJiqpZiPwyXtaVu87vWzcvVbTD9W1E4s3ncCoQFkZy
        9uzsNw5BL+rYfI4E95HgKTxjmbOzVO0St97fsOU3WA==
X-Google-Smtp-Source: ACHHUZ64Si5NNkyGzMJm0zpqrodm5rSl03FBfzVpoMnc6NiBwB+hP2OIVPQRiCS9cO6NWa7Rk4FCSXTk//Oj8K8vmdw=
X-Received: by 2002:a05:6808:1453:b0:398:850:6206 with SMTP id
 x19-20020a056808145300b0039808506206mr1200576oiv.27.1686887052641; Thu, 15
 Jun 2023 20:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <d9b22eaa-00a1-6c5c-99a0-126b085f7cb0@redhat.com> <CACSyD1NxcYn_Uy2DUk1ywSyWsxFzq4H+poaWvF55SZZz5W-uRw@mail.gmail.com>
 <3f54542e-235b-8456-f13f-786d21c6c14f@redhat.com> <CACSyD1OxAMowHTE7KnL8nac_-=Vp4eyO00oyMLFo0qcEHx33GA@mail.gmail.com>
 <bd119703-7b7b-c4ab-0c38-9b85809de252@redhat.com> <CACSyD1NfbD_YBADH-3bR0=sGkrkEqxfgYLvyNyTiWdTvw2R6vA@mail.gmail.com>
 <290d79bb-b1a6-3146-76a7-9938829e6ebe@redhat.com>
In-Reply-To: <290d79bb-b1a6-3146-76a7-9938829e6ebe@redhat.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Fri, 16 Jun 2023 11:44:01 +0800
Message-ID: <CACSyD1OK9=AuB8OWgk0WQwXc_tf827CMMor_qNs4VGUEM_suLA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     David Hildenbrand <david@redhat.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Yes. But just to stress again, one issue I see is that if there is a
> page in the BIO that is not charged, you cannot charge the compressed pag=
e.

I got it. Thanks.

>
> Assume you have some FS on that zram block device and  you want to make
> sure it gets properly charged to whoever is reading/writing a file on
> that filesystem. (imagine something like a compress shmem)
>
> If a user (or the filesystem?) can trigger a BIO that has an uncharged
> page in it, it would not get charged accordingly.
>
> The "easy" reproducer would have been O_DIRECT write() using the shared
> zeropage, but zram_write_page() is smart enough to optimize for that
> case (page_same_filled()). :)

Ok, I will try it.

>
> Maybe I'm over-thinking this (well, the we do have partial I/O support,
> so something seems to be able to trigger such cases), and it would be
> great if someone with more FS->BIO experience could comment.
>
> I'll note that this is fundamentally different to zswap, because with
> zswap you don't get arbitrary BIOs, you get an anon or shmem page (that
> should be charged).
>

Hi David=EF=BC=8C I know your concern and I will try to find the uncharged =
case.

> --
> Cheers,
>
> David / dhildenb
>
