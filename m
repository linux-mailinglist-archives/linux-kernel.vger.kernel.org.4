Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08A270EF30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbjEXHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbjEXHPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:15:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F185690;
        Wed, 24 May 2023 00:15:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30a95ec7744so386165f8f.3;
        Wed, 24 May 2023 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684912525; x=1687504525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTwUX3qEpiLdoo2WOruxY9BVcBrptDaoYsD2JHxAesc=;
        b=j8e8aqmI8nrYA59qDNX4vMDiOXCYqlzQxVL4aYAfwG42G4CYrBVAzwMIaQ1Erv4hSX
         kGnV/G7awoKyLM0rQLSvaUFEp3Hpw4ah+4cG8HaHB56syFLX7L0MYR65eGXbihrEsIoD
         SKFnAIVtSLLkt1jAT0tsSLblry/Honk98G/08iXl1PQRBddaPXBvuSyHUw1Kmn+ylCCT
         sV7KZtxCVJuQCifkRIaVp8pQX52QrXsytC2TEwVxo/cqI6OlZidu3v4eKWO7B/5iLSJY
         xGr6RyW9Eu6cY4erU9ajh/uOeMhMdmwf7XUieuntprkeSa6X871PlVGHWwJZJh9y1mF0
         A1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684912525; x=1687504525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTwUX3qEpiLdoo2WOruxY9BVcBrptDaoYsD2JHxAesc=;
        b=DViwCu5oYZMQo/t7wXh8255Z5MDB4232QD0aQSCnW3pFmpw5XiCrreI6vDp+yhZ7ex
         CBcxWMF94GyUQoFGQY/fowzI9JD6hh1Uo5wELYVkDhrwjdufJmGr3/zSS6TTJ2Ga2XgR
         JKx+WSk2UDA9qMzHQ+vPm2EGrBFBTa20Wb0ZOETHvZ0fE1jKCx0wWO3+NvmQQVaLRC2m
         ABgskU0S4LJjcENwbGWTBCOpQp281h/K1+EJE6YL7HjSDqc84QCZiGw8Fc1lAdWnDNFu
         TKYWNPKzJcjyeVf1Huqwr68QWX2QE+HJDEps/LErItU+IcrDndRcV/MMVYl30bHuqbuC
         s15Q==
X-Gm-Message-State: AC+VfDxpXIxeEKAeFwUiAm79Xtsnl8UUBW8CGAwe02W9qUYXzntWi8u2
        aVGXAxIK6v80iwW9nc0y4MY=
X-Google-Smtp-Source: ACHHUZ7XW0cvABpggLT4CBW+cXjOYhS4kBeHV38swA1xGYzOVfRUCNPM9inU5JsOBBUisX0wNc+F7A==
X-Received: by 2002:adf:e912:0:b0:307:7e64:4b52 with SMTP id f18-20020adfe912000000b003077e644b52mr14169357wrm.36.1684912525160;
        Wed, 24 May 2023 00:15:25 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d53c2000000b002ffbf2213d4sm13537164wrw.75.2023.05.24.00.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 00:15:23 -0700 (PDT)
Date:   Wed, 24 May 2023 08:15:23 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
Message-ID: <f2ca936a-1441-4cbd-b16c-ff2d54630a75@lucifer.local>
References: <20230523073136.4900-1-vbabka@suse.cz>
 <310077ed-6f3f-41fe-afcf-36500a9408ec@lucifer.local>
 <623a87c6-c0d2-799a-c39e-0d14dcdfa6df@suse.cz>
 <ae3ff438-5e5a-4a75-b4e9-575324a584f7@lucifer.local>
 <ca7860db-220f-ae77-93e6-2a38f6c1130a@redhat.com>
 <4674f97f-5f97-45b7-a4b9-a19ca46b7ce1@lucifer.local>
 <9191d9b0-3318-4e70-a81b-69acff184fc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9191d9b0-3318-4e70-a81b-69acff184fc6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:28:32AM +0200, David Hildenbrand wrote:
[snip]
> > > The file is only compiled with CONFIG_HARDENED_USERCOPY:
> > >
> > > mm/Makefile:obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
> > >
> >
> > Yeah ugh at this sort of implicit thing. Anyway it'd be preferable to stick
> > #ifdef CONFIG_HARDENED_USERCOPY around the prototype just so it's
> > abundantly clear this function doesn't exist unless that is set.
>
> I recall that it is very common to not use ifdefs unless really required.
> Because less ifefs are obviously preferable ;)
>
> Compilation+linking will fail in any case.
>

I don't want to insist so hard on something that doesn't really matter, the
bike shed can be blue, green or red it's fine :P

So,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
