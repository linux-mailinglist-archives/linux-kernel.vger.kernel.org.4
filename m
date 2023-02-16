Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44FB699CED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBPTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBPTTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB7EC65B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676575125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vq/8D3nKqtw1WIOPbD3NZdoxax4+1C1opON75SAH+KA=;
        b=gnn+mw4fAVZP34XSIwtPEMYOMav5ZfFIMkgj6H/cwxDsH3hMbNLAnkCcsYOpC5moQ+C8HB
        dguudob2Dt9msIDhxl9a1fh+vNqabMj7AZPedmnqPUUeFbWgIUBRAnRjA8YypCFhJdVQ4H
        AU0Zr21XS86d02yV2BTFYqThqxwCvg0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-KZAnHyNOO0qDHJPspJ6R_w-1; Thu, 16 Feb 2023 14:18:44 -0500
X-MC-Unique: KZAnHyNOO0qDHJPspJ6R_w-1
Received: by mail-qv1-f71.google.com with SMTP id ib5-20020a0562141c8500b0053c23b938a0so1632620qvb.17
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676575123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq/8D3nKqtw1WIOPbD3NZdoxax4+1C1opON75SAH+KA=;
        b=l7XvU/NDXte24FSEhHLW3nYnLqrnKd4N5CgqHO6UT3fd9BXHACRXkHMRL0mdANe2U9
         7G26wI4RqZcxLak1KadtKPWmJG/DkLsF1Sgv26KaEFxAi+MNbgF72PVmZWijuDO/1dvz
         neRyMh/76O0MmaH9eU/OEueKbZ4O0Nz7yOmgw4lKl+tjZkvVD26AItAMUWX9D/GRe4qj
         TszPxvEhHLYgE6jN0awHxJjh/s+FlfVAy09t+RASyeRiibyBt2CJEUj4QLGALpTJB0nb
         ZWQRJlyxi0Q6zqxYvhhjhfboaan86G/Cb5yQqJBBCcwW3+hwavaNksyEVeNS1YAruCkH
         23aA==
X-Gm-Message-State: AO0yUKVuvC3JEhXCkVxSqlI94riOEXwV5TFTKRIGdajzfK3EIU40O+gd
        2BqReOD74xUnNdVDUMpFhAlBxw2PfjSDI46Q3uYrD5eaLRSQoCA702g0EUFmsEOsTXa3qOEfpDN
        6zWkj5mX7WL2Wb9g3J3ZGH/Bs
X-Received: by 2002:a05:622a:1c1:b0:3b8:4951:57bb with SMTP id t1-20020a05622a01c100b003b8495157bbmr13365172qtw.5.1676575123587;
        Thu, 16 Feb 2023 11:18:43 -0800 (PST)
X-Google-Smtp-Source: AK7set94r9QdJOHGjbfUETh7ovLgpkDfMBET1BqCT/UpQvalJnj5Q431hrj7SLkgGPpOCMlAFoI5Jw==
X-Received: by 2002:a05:622a:1c1:b0:3b8:4951:57bb with SMTP id t1-20020a05622a01c100b003b8495157bbmr13365134qtw.5.1676575123243;
        Thu, 16 Feb 2023 11:18:43 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id m9-20020a05622a054900b003a530a32f67sm360565qtx.65.2023.02.16.11.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 11:18:42 -0800 (PST)
Date:   Thu, 16 Feb 2023 14:18:41 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Bowler <nbowler@draconx.ca>
Subject: Re: [PATCH] mm/migrate: Fix wrongly apply write bit after mkdirty on
 sparc64
Message-ID: <Y+6BkcrLBKJyGZUn@x1n>
References: <20230216153059.256739-1-peterx@redhat.com>
 <611c1202-1978-8886-eec3-929933ee75cd@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <611c1202-1978-8886-eec3-929933ee75cd@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 05:59:16PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 16.02.23 16:30, Peter Xu wrote:
> > Nick Bowler reported another sparc64 breakage after the young/dirty
> > persistent work for page migration (per "Link:" below).  That's after a
> > similar report [2].
> 
> Thx for handling this.
> 
> > [...]
> >
> > Note: this is based on mm-unstable, because the breakage was since 6.1 and
> > we're at a very late stage of 6.2 (-rc8), so I assume for this specific
> > case we should target this at 6.3.
> > 
> > [1] https://lore.kernel.org/all/20221021160603.GA23307@u164.east.ru/
> > [2] https://lore.kernel.org/all/20221212130213.136267-1-david@redhat.com/
> > 
> > Cc: regressions@leemhuis.info
> 
> Not that it matters much, but feel free to use this instead:
> 
> CC: regressions@lists.linux.dev
> 
> Then things don't depend on me (in case I ever get help with my cat
> herding job). And it also make it even more obvious that this patch
> fixes a regression to anyone who handles it downstream.

Sure.

> 
> > Fixes: 2e3468778dbe ("mm: remember young/dirty bit for page migrations")
> 
> That's a commit from 6.1, hence this should likely have:
> 
> Cc: stable@vger.kernel.org # 6.1.y
> 
> [no, a fixes tag alone does not suffice, see docs]

Oops, I just forgot that.  We definitely need to cc:stable.  I'll make sure
it's there if there's a new version, or I hope Andrew could help to attach
otherwise.

Thanks,

-- 
Peter Xu

