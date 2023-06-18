Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21E7344ED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 07:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjFREtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 00:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFREtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 00:49:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BCC1731
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 21:49:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-982a0232bdcso362172566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 21:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687063753; x=1689655753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5rzEa5zaabq7BO9YTYpmhHbtEFXaArlfXhtHDBAqIU=;
        b=m7WEfevY9YhSF6Z7flyGT/mOPrBk6ufb19mK5/73bFvzkKOU34uP8SpoQXneLp3Wjf
         IbWmgGrf6EbHGKeDwRW1D3piqmvTGbKEkCe87tSoQzBrO7/NrE9CInrAA0vtJcxP2g3u
         3OEDejeTGbOPaPhsFBHWDpmzLBierdgfxEShcn9HU4lgoZnltZEdDrvll3c7LXsSIfQx
         ADtJxoCbSknGToMrALrp/6l9FtE7lstGABYZMoyaSPUS39bGG5n85gvpoP6yf7zbMKNu
         +jEV9PXtS4fyvCuky28ZACeMBXY/KgjqyENd8gJfCugOl/poDI942cFU9nnK0e6HDLeB
         bvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687063753; x=1689655753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5rzEa5zaabq7BO9YTYpmhHbtEFXaArlfXhtHDBAqIU=;
        b=hJiyvRcUy1k+2j8X5sI934FNM4+QnlrmTIcvXloNxxsuBK0EgXqgf/Ym5WGqAtysNS
         Nx8DR5abmYIAb8SDyTd+wQF+fvdvlFKCcG0ApQYXxy6ya5h8+toDehUe4rrH4N8qcaZK
         PVnnx8uB89NcdHRt4iuF9TSqvFbLZ/NJWRtARN2yLqPBuNXgVP3v+SQEj+MC9Z6kjCrA
         MyBEDAwJ/EXrxWemvmCVBZMFLYHTSJXBtbws2NbcaEPLHGPB/Up2JiJBPt0U2rMgw2By
         dMoVaaG+U5hEgk7qdXqugNw9aDN2CoCk4b+Ii4SoJpBqSwQ+Hhm49zsJCW1uA8j8K5n/
         NF0g==
X-Gm-Message-State: AC+VfDzF8UOkV4HAc3lT8o/ry1Nk/H2U9glw1WsA23zCbR5SDzwtwAh5
        agTFrayNbl5vKNsqbmcul7emHL8kr2T/+GxlzQ34kg==
X-Google-Smtp-Source: ACHHUZ4iNbApKH/9BJYO2Sn0xpoJtnRFi9+ygdAyyZviwBoqXWxee5Ivn9uwZypCW958ZA7RBaCmsgjS39R/51zfT6o=
X-Received: by 2002:a17:906:58c5:b0:988:891b:28c6 with SMTP id
 e5-20020a17090658c500b00988891b28c6mr267336ejs.15.1687063752679; Sat, 17 Jun
 2023 21:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
 <20230612093815.133504-2-cerasuolodomenico@gmail.com> <20230618043857.GA2417524@google.com>
In-Reply-To: <20230618043857.GA2417524@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sat, 17 Jun 2023 21:48:36 -0700
Message-ID: <CAJD7tkbRn2txAt94keKTRbAA7--XF3rXSa8vsh9eGZa2CUWP8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm: zswap: add pool shrinking mechanism
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        vitaly.wool@konsulko.com, minchan@kernel.org, linux-mm@kvack.org,
        ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 9:39=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/06/12 11:38), Domenico Cerasuolo wrote:
> > +static int zswap_reclaim_entry(struct zswap_pool *pool)
> > +{
> > +     struct zswap_header *zhdr;
> > +     struct zswap_entry *entry;
> > +     struct zswap_tree *tree;
> > +     pgoff_t swpoffset;
> > +     int ret;
> > +
> > +     /* Get an entry off the LRU */
> > +     spin_lock(&pool->lru_lock);
> > +     if (list_empty(&pool->lru)) {
> > +             spin_unlock(&pool->lru_lock);
> > +             return -EINVAL;
> > +     }
> > +     entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru);
> > +     list_del_init(&entry->lru);
>
> A quick question: should we zswap_entry_get() here?

We need to hold the tree lock for that, and the lock ordering is tree
lock -> lru lock. If we try to grab the tree lock here we may
deadlock. In the next code block we release the lru_lock, hold the
tree lock, make sure the entry is still valid in the tree, then do
zswap_entry_get().
