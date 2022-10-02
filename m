Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC575F2179
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 07:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJBFsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 01:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBFsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 01:48:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8AD3AE4F;
        Sat,  1 Oct 2022 22:48:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d1-20020a17090a6a4100b002095b319b9aso6728309pjm.0;
        Sat, 01 Oct 2022 22:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=VgNJ1GE8Vgm6Xrjpg25iYal6CFtq/s9kQyktt7aaKUE=;
        b=G+Nj6O7uP97vjLNbXj4dcOqlrfn4eMtnO/h4QuV/EibeSN4ZaYQmOTtgl4OtxFWRI0
         Nai1l3/0NNcI+Uz4dCAlRU7YktoD1cWb/eb1XXaOfrdVvWeJHmDxfKTqzC1+1Lsd9dLI
         g5Duc9IPiWKsY1VbsNNTOIpoCP/bkn14RytKtGZ4IKMdq8pgtPhm6GbO50uLtEF483uf
         VquHJNKdjBjwNKTzUWDS/6S49AYqYdPJc910tE18zQIu0Md8QblasL+uSiBJiY37WJrI
         0BstAUkz8zO5JXFnGpIP9cJhiuaq+tvLVbuNzj2+OiFLtTxwiHw3Z0T09fsvsN+bRVYt
         lgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VgNJ1GE8Vgm6Xrjpg25iYal6CFtq/s9kQyktt7aaKUE=;
        b=IKqJzLfDbG/x87F1RIwsObPHbHGHo1hql93c1f90PfwuNtvopqbUNuYPhEs33SXosn
         h2M9UgS/+2mUsA2VuzQX3eLCdnw5DF4iXi3Ihx2rZ5JgG6uDQQPgGnu/1DxzKqKzsrME
         IgEK1g9iioYp28jeWACWyAIwe56quNB2jGlSmFC6Ebhd2D+083/Eqnhx14eMklDNNnr7
         jYcOiDS82vH8+PhCOm4cxvUKIp9xWkZtuWNxIBI5tTCQQTg+O8WeiejfROP8N31em7KZ
         sYu6eUvefiKFoFH67ILyziK6FBdP7nwMldZz+199q6z0CfQAWPhEeXbwAOVw5BSsoenm
         HfRg==
X-Gm-Message-State: ACrzQf1dSvCTKqQfrzfoJ6DDcdNCyH5yqVZZkSZpunB2xUxdXkpH0WiR
        qkGqJrfg1P+rUS/UyMD/7Mn2yQwRSv6lfQ==
X-Google-Smtp-Source: AMsMyM6zcOmhnWnhzVBi4ImyiM+v9uxCF+36fpU07h+TPPwm4nBzBAWJMVgaipQrQdbr56KhISXwiQ==
X-Received: by 2002:a17:902:e841:b0:177:82b6:e6f7 with SMTP id t1-20020a170902e84100b0017782b6e6f7mr16871883plg.66.1664689689467;
        Sat, 01 Oct 2022 22:48:09 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id f69-20020a623848000000b0055fd8b687fdsm2192713pfa.95.2022.10.01.22.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 22:48:08 -0700 (PDT)
Date:   Sun, 2 Oct 2022 14:48:02 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <YzkmErHFyYW3awRn@hyeyoo>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo>
 <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:54:45PM -0700, Hugh Dickins wrote:
> On Thu, 29 Sep 2022, Vlastimil Babka wrote:
> > On 9/28/22 19:50, Hugh Dickins wrote:
> > > On Wed, 28 Sep 2022, Vlastimil Babka wrote:
> > >> On 9/28/22 15:48, Joel Fernandes wrote:
> > >> > On Wed, Sep 28, 2022 at 02:49:02PM +0900, Hyeonggon Yoo wrote:
> > >> >> On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
> > >> >>> It's a bug in linux-next, but taking me too long to identify which
> > >> >>> commit is "to blame", so let me throw it over to you without more
> > >> >>> delay: I think __PageMovable() now needs to check !PageSlab().
> > >> 
> > >> When I tried that, the result wasn't really nice:
> > >> 
> > >> https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/
> > >> 
> > >> And what if there's another conflicting page "type" later. Or the debugging
> > >> variant of rcu_head in struct page itself. The __PageMovable() is just too
> > >> fragile.
> > > 
> > > I don't disagree (and don't really know all the things you're thinking
> > > of in there).  But if it's important to rescue this feature for 6.1, a
> > > different approach may be the very simple patch below (I met a similar
> > > issue with OPTIMIZE_FOR_SIZE in i915 a year ago, and just remembered).
> > > 
> > > But you be the judge of it: (a) I do not know whether rcu_free_slab
> > > is the only risky address ever stuffed into that field; and (b) I'm
> > > clueless when it comes to those architectures (powerpc etc) where the
> > > the address of a function is something different from the address of
> > > the function (have I conveyed my cluelessness adequately?).
> > 
> > Thanks a lot Hugh! That's a sufficiently small fix (compared to the other
> > options) that I'm probably give it one last try.
> 
> I suddenly worried that you might be waiting on me for a Signed-off-by,
> which I couldn't give until I researched my reservations (a) and (b):
> but I'm pleased to see from your kernel.org tree that you've gone ahead
> and folded it in - thanks.
> 
> Regarding (a): great, you've found it too, mm/slab.c's kmem_rcu_free()
> looks like it needs the same __aligned(4) as mm/slub.c's rcu_free_slabi().

Just one more thing, rcu_leak_callback too. RCU seem to use it
internally to catch double call_rcu().

And some suggestions:
- what about adding runtime WARN() on slab init code to catch
  unexpected arch/toolchain issues?
- instead of 4, we may use macro definition? like (PAGE_MAPPING_FLAGS + 1)?

-- 
Thanks,
Hyeonggon
