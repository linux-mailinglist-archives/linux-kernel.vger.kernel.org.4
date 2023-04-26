Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFB6EFC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbjDZVRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZVRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:17:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC26AB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:17:41 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51fcf5d1e44so7523840a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682543861; x=1685135861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mn6UfNCg0frCwO9LQEVgo3zTrnFxCqpigYKkVd6EnQ=;
        b=zrqOQt3vdLfXDAeTjlXqmMr8Ec9NjcVaOcvqpHYfKX+LD3A+CR5V10B9dDUmPeOn6l
         Mw9rdth014TD14+uVerzeCMXVi21GmnSZqIktpQmSPdRBtHcIN2xP+IMdXxwMkMPehUU
         ASyUAs9lrWygPrjbil61i3XS8CqREgMyFTC4IYgs8VIU+jDlUXvNNF8NFz+n+s4UoLO3
         T6eTk+Badq+U/FUAmZDYU0uGFukuQ7abN2sIsljGeI2igl70BG43DJHzCs+BcZaqLne9
         YtnkCl2L3azyKiA24BE1njB56iQVpZeytVegm0htnvVJPkESsaml0LV2fPjIfP3rzbIa
         RZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543861; x=1685135861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mn6UfNCg0frCwO9LQEVgo3zTrnFxCqpigYKkVd6EnQ=;
        b=EfHAiHvGtkzK7DELVd84/YEYZ5C8zlrVk69KBVbsRF6rCfn0qGWc9rJ6upqlzlejM1
         Ptx6DWnV/y8Bgb8aqJnnBVyjhQdtuxAeET0uNuyx84NK7Y5t7YywAyxP6JAGaO1gPp7Z
         NCDsIljPZVM6UY76TisDFvCy1m8OqL9YCnVoLwTFByjgDbRpZXGHpVxVuH1SC73qr9J1
         YXqbvTVN77RUEumA8b6LfHyr/Q8PKmBtvl0DVJgPceglA74mJcvjW9b1hy8yad+x6EUj
         WvHt06EyLtoGsARtXy3VfsqiHYhrPS6pXTmyqHM9/lE60OCHBWzqY+otaJw7zCce9ZDH
         QEhg==
X-Gm-Message-State: AAQBX9dOfmvNTR/IJ8nrDuygsc0HBv/XyGnviDp1g/Rqmd3xo/fNKOjs
        FNmu0q+vcW+I4eRvPiLp6ThdnA==
X-Google-Smtp-Source: AKy350Y5ZisNDXgxTIhq93sjeqfrFBwlRJvH5WaxjoX5i7xg40wIQ26a6adZ2jxKYgd09EMsxx96ZA==
X-Received: by 2002:a17:90a:660d:b0:246:f9ff:8e70 with SMTP id l13-20020a17090a660d00b00246f9ff8e70mr21040459pjj.26.1682543860989;
        Wed, 26 Apr 2023 14:17:40 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n10-20020a63ee4a000000b0051b0e564963sm10314070pgk.49.2023.04.26.14.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 14:17:40 -0700 (PDT)
Date:   Wed, 26 Apr 2023 21:17:37 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/3] Revert "android: binder: stop saving a pointer
 to the VMA"
Message-ID: <ZEmU8ULSEQhDVyX+@google.com>
References: <20230424205548.1935192-1-cmllamas@google.com>
 <20230424205548.1935192-2-cmllamas@google.com>
 <20230424223419.6n2z72mocgmcj3aw@revolver>
 <ZEcMhOywwzsc6CN5@google.com>
 <20230425014328.d6vvimziv6je5xdg@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425014328.d6vvimziv6je5xdg@revolver>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 09:43:28PM -0400, Liam R. Howlett wrote:
> * Carlos Llamas <cmllamas@google.com> [230424 19:11]:
> > 
> > The specifics are in the third patch of this patchset but the gist of it
> > is that during ->mmap() handler, binder will complete the initialization
> > of the binder_alloc structure. With the last step of this process being
> > the caching of the vma pointer. Since the ordering is protected with a
> > barrier we can then check alloc->vma to determine if the initialization
> > has been completed.
> > 
> > Since this check is part of the critical path for every single binder
> > transaction, the performance plummeted when we started contending for
> > the mmap_lock. In this particular case, binder doesn't actually use the
> > vma.
> 
> So why does binder_update_page_range() take the mmap_read_lock then use
> the cached vma in the reverted patch?
> 
> If you want to use it as a flag to see if the driver is initialized, why
> not use the cached address != 0?
> 
> Or better yet,
> 
> >It only needs to know if the internal structure has been fully
> > initialized and it is safe to use it.
> 
> This seems like a good reason to use your own rwsem.  This is,
> essentially, rolling your own lock with
> smp_store_release()/smp_load_acquire() and a pointer which should not be
> cached.

We can't use an rwsem to protect the initialization. We already have an
alloc->mutex which would be an option. However, using it under ->mmap()
would only lead to dead-locks with the mmap_lock.

I agree with you that we could use some other flag instead of the vma
pointer to signal the initialization. I've actually tried several times
to come up with a scenario in which caching the vma pointer becomes an
issue to stop doing this altogether. However, I can't find anything
concrete.

I don't think the current solution in which we do all these unnecessary
vma lookups is correct. Instead, I'm currently working on a redesign of
this section in which binder stops to allocate/insert pages manually. We
should be making use of the page-fault handler and let the infra handle
all the work. The overall idea is here:
https://lore.kernel.org/all/ZEGh4mliGHvyWIvo@google.com/

It's hard to make the case for just dropping the vma pointer after ~15
years and take the performance hit without having an actual issue to
support this idea. So I'll revert this for now and keep working on the
page-fault solution.

Thanks Liam, I'll keep you in the loop.
