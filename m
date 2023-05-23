Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E25A70DFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjEWOye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjEWOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:54:32 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910FEC6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:54:30 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so979439e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684853609; x=1687445609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPDh95iV7ZIM20wN/RJo+ESwo6JWKcZLQ714XdToWTM=;
        b=DdHuAtDLZ9Aq51LhMVyMbW66l8PWVwpjFPyAL61hIwDs2FRDPLSzbn5lL5TSEU8FYe
         A0iVDHBCruSZFsZFzXga9b/u4binsWQaYCtWpm+OQn6yWKklx1PrG34abagolPcGljBH
         abIcZkGgzvY9CkvZsFzobWfaVkIrhMhwdrbFn8u2SRw3k2/gk1UzBawPNHAPf7lup4Rr
         Tu6Fj2CXDgLMIYhMA+gw3d6LEcjs82jRu4IFQ/+M1qZMpoRnqsISgOLfQ4T76XJNAnfy
         qeJSKVqbQbpWAWXoobZMO4l3FeqIpv/OzMjNijaoz6K1x3GrcZUiyypu06cwqSRaFzrs
         6u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853609; x=1687445609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPDh95iV7ZIM20wN/RJo+ESwo6JWKcZLQ714XdToWTM=;
        b=OCb9JUSABVZ5KrPq7PF99ERYdtfQF4d+lII4xOLbDdE78g/V9CU+D2jeoN302GbQJS
         zpVWdlM7WlXfzmyHOiVx18sK4FhLFwJOAz368J0GCyYwJgVcC4TEsEU/b4XFTm8Fka/Q
         gr8jouFqgLtBuDZw6toiZfIG32ZCNVm753EgGEFL+4kbrGjejmVCC2XLy0ngjepUc0b5
         fR1elNdPrsT3e6YgC+Zr+8qFEwQOS72VjCcwS7gs6P5CrGKd7tPtG65kzqMRUDzCw8Bn
         0urbq05ioN2jvoxBWTwmi/LDEgw6KjYjdgd025609pkfBTkWrwEhx+bbi9hOzAtPePrQ
         LSjw==
X-Gm-Message-State: AC+VfDywQXuV26fTaT6db9fSE3q2Y4ivvTdMi0Au3NXhBmXl2LK49aGN
        oUZlHYpo1HGAEMTlFVyPW4k=
X-Google-Smtp-Source: ACHHUZ7xLEhYELzSdWO0jZx+QmWP4agZmxO45Aopzbemh2+A2FF5b+51Q4BYW3u6x1LYMlHl4DuLfA==
X-Received: by 2002:ac2:4182:0:b0:4f3:93d6:377b with SMTP id z2-20020ac24182000000b004f393d6377bmr3877478lfh.37.1684853608618;
        Tue, 23 May 2023 07:53:28 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id x7-20020ac25dc7000000b004eff6c7bc08sm1351889lfq.75.2023.05.23.07.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:53:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 23 May 2023 16:53:25 +0200
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/9] mm: vmalloc: Add a per-CPU-zone infrastructure
Message-ID: <ZGzTZWq/hAYCE3DA@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-5-urezki@gmail.com>
 <ZGxYZlLoADBWktT8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGxYZlLoADBWktT8@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:08:38PM -0700, Christoph Hellwig wrote:
> On Mon, May 22, 2023 at 01:08:44PM +0200, Uladzislau Rezki (Sony) wrote:
> > +#define fbl(z, i, m) z->fbl[i].m
> > +#define fbl_root(z, i) fbl(z, i, root)
> > +#define fbl_head(z, i) fbl(z, i, head)
> > +
> > +#define fbl_lock(z, i) spin_lock(&fbl(z, i, lock))
> > +#define fbl_unlock(z, i) spin_unlock(&fbl(z, i, lock))
> 
> Even if it is just temporary, I don't think adding these wrappers
> make much sense.
> 
If open-coded, it looks like:

spin_lock(&z->fbl[BUSY].lock);
fbl_lock(z, BUSY);

the reason of adding such helpers is to make the name shorter.

> > +struct cpu_vmap_zone {
> > +	/*
> > +	 * FREE, BUSY, LAZY bookkeeping data of this CPU zone.
> > +	 */
> > +	struct {
> > +		struct rb_root root;
> > +		struct list_head head;
> > +		spinlock_t lock;
> > +	} fbl[NFBL];
> 
> Maybe replace NFBL with something longer and more descriptive?
> 
> But also in general it feels like this should be folded into a patch
> doing real work.  As-is it doesn't look very useful.
>
I split it for better understanding for review. But i can fold it.

--
Uladzislau Rezki
