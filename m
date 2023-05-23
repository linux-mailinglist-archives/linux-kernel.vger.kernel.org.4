Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE970DFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbjEWPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjEWPBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:01:37 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F30FE9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:01:36 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so2593763e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684854034; x=1687446034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bI1dsyGUTIty3MU+zkXPgg+upru8yu3Pn2ZYvnI6C4=;
        b=Rbg31YrzW/nfnIVkC+VyHJGr0WjR+UfL0YLUdxZlOdp1yuKvdVjAjq/7YL4IP/roVs
         P5Y+bFK9KCxBaz8sT/t30rl8XvNaN9zEpIvNQ+xojy6clrxsjKHXgZGPwK13Sk7M6MrY
         PyCiPieag/kwtCC8EH0CTJ+sAG9WuzASDm4JK43soq0ZSHWeOUBilEXyHqgsb+oNNSAr
         Mawo+1voujfJ/sx2iI3A/FduJO80/MgBO5+plE1HDa9YuE3OTk6aPt/cVftlOLcXFjXs
         6novV7fTpm6EoOkgoQXw2z53LqHGNkDJHDy7+ouNBtey3Yg43cRv/RpwKCIvzaCYVu+0
         ORqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684854034; x=1687446034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bI1dsyGUTIty3MU+zkXPgg+upru8yu3Pn2ZYvnI6C4=;
        b=c9bqxbpQHp5LHoeLjh+0G0OZd2IUI9EVH1yS14S27XUsCPJ19eMrL76BqCwAqth+V4
         LgVfIMts8YeLcm6lH9QUHDKOn24kPYiEb3UGmKBaDdVbkYENaGQIQdsuhh3yRxM6/kIG
         7JNmdHaZOdRHOE09+54Reb7fs4EFQoo+ngP2QI3qpLpaRId01fKC22Tx7tN/Jk53/aMY
         Qr/YuCOaIk6WK6/w49njMQUPbjf09+toYfN6GkV6KJDsvSrNVnpLhfN5gvK1g1aP6LG5
         Yj22NkEgNxaSUFifEP2lpGRzA2J4VLMMHUeHs8uXzmuLgIGnYE+3EkdP7mjNGQvDMt8q
         yF9A==
X-Gm-Message-State: AC+VfDwV1Nj3S42qb9O28hoPCp+ZdhX7/KptJNS1TaFm1p0JPVVW9V90
        0B1yaKSSBl1E01NP3buWtik=
X-Google-Smtp-Source: ACHHUZ5MalfVVPuyw5i+e7t92ZK5wn0NHZyUCZjNJcZ3PSZ+TnhHQvdKVGnoQv2r/t6wFYjo2xn9eA==
X-Received: by 2002:a05:6512:908:b0:4ef:f11c:f5b0 with SMTP id e8-20020a056512090800b004eff11cf5b0mr4427623lft.54.1684854034234;
        Tue, 23 May 2023 08:00:34 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512014600b004f27cecb68asm1376307lfo.166.2023.05.23.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:00:33 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 23 May 2023 17:00:31 +0200
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
Subject: Re: [PATCH 5/9] mm: vmalloc: Insert busy-VA per-cpu zone
Message-ID: <ZGzVD7hkl5v3A2dO@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-6-urezki@gmail.com>
 <ZGxZOGpaq9ybRLZ7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGxZOGpaq9ybRLZ7@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:12:08PM -0700, Christoph Hellwig wrote:
> >  /* Look up the first VA which satisfies addr < va_end, NULL if none. */
> > -static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
> > +static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
> 
> Please avoid the overly long line.
> 
Will fix it.

> > +	struct cpu_vmap_zone *z = addr_to_cvz(va->va_start);
> > +
> >  	/*
> >  	 * Remove from the busy tree/list.
> >  	 */
> > -	spin_lock(&vmap_area_lock);
> > -	unlink_va(va, &vmap_area_root);
> > -	spin_unlock(&vmap_area_lock);
> > +	fbl_lock(z, BUSY);
> > +	unlink_va(va, &fbl_root(z, BUSY));
> > +	fbl_unlock(z, BUSY);
> 
> I find the BUSY magic here very confusing, and would prefer to
> just spell the actual lock reference out.
>
No problem. I can make it open-coded. What is about an access to tree/list?

>> unlink_va(va, &fbl_root(z, BUSY));
I mean this one.

--
Uladzislau Rezki
