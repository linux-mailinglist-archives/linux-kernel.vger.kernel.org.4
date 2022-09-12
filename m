Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4366D5B62E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiILVjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiILVjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:39:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007FD2DA85
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:39:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c24so9467653pgg.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=9va10owt2kdB7040RfjKrKT4WvQou3BJy+ohAPRZkvg=;
        b=LtO24KfwsPnwmv/Pbqxhx/YNUzaS8UUT7/n16y9uJB8RWFFgciBd7q3vCu0r88X02X
         tMGS9NDzg+RMkxhLndAvZYBIvsTepXxJTrYrJ8iqWiCdM+WSvEk6t15pCSv6j80vU56i
         NTZlQAI7cgQ42Tn+vY5Mm1WkwF3K1TT3nAxGeLBcP9t7K7jzO6p591UapAfTP+tWaeyD
         IadlhnGDxPC7xzP2npdDjBDpZncBw4rz3XQiRO/QoJeYdltCYGHV0hYi1fERAorbkLLs
         HTWaC/Nzt/4ha96Pg36UazZaW7ycf38E1VZrfcu56MFojgYyaCbAKGHbekimSCxe6fGR
         f+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9va10owt2kdB7040RfjKrKT4WvQou3BJy+ohAPRZkvg=;
        b=MGwg3O2/Vp5O4EmozM5RsKNdKcVpjUJPcB2OJHMBtCU+lxDOkV3SmDx/fvLaRlezaO
         LuFnf3P1u9eb7lMUGsieTyLP5/JJh5TjFWxJOb1R9hybLVmAHM8I5HHGkpFHDFgi3cWW
         oCnDrNHN81O2A9ZSIR2ei33rDyqjFQXvO461zYtas6buNUGcv69s1oU4YmdAXHk91ZZA
         UC68h+1U2tuB56037TVy4FZp5Bqddty6IC3bqCiS1BU+3JUe7O5snbz4nYYR/I5xcRwf
         A/m94K21w+e2ko0OtH4NNeAl6wq6UUPrdqTtji2bb9coQZKYK1IWQmBiuNMFk6cRVRzU
         pXbg==
X-Gm-Message-State: ACgBeo3ylGHThWbJCGrA9ouKVAi/EOcSneAjuueQOpmkzQFqXaMLrzhu
        raX6Tb28SyhXjVFp0TsRJLYmiEcg83sBOA==
X-Google-Smtp-Source: AA6agR4L9ELbW3v6eIQg1InDMWlHwfkd+PLn4vhIyLhmE+0dHUx+p7eVGWPOhwpVJXBU9jQUTYA6Dg==
X-Received: by 2002:a63:847:0:b0:439:22e4:8e49 with SMTP id 68-20020a630847000000b0043922e48e49mr3360966pgi.165.1663018744321;
        Mon, 12 Sep 2022 14:39:04 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090340c700b00176e2fa216csm3469947pld.52.2022.09.12.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 14:39:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Sep 2022 11:39:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Christian A. Ehrhardt" <lk@c--e.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kernfs: fix use-after-free in __kernfs_remove
Message-ID: <Yx+m9knwzSFDwyPJ@slm.duckdns.org>
References: <20220907200811.654034-1-lk@c--e.de>
 <YxojA7pDe8Ur7wpd@slm.duckdns.org>
 <Yxpr4HSSxNw3SDrI@cae.in-ulm.de>
 <Yx+jpDxSjAad+fEq@cae.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx+jpDxSjAad+fEq@cae.in-ulm.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 12, 2022 at 11:24:52PM +0200, Christian A. Ehrhardt wrote:
> Sorry, no patch (yet). But here's the whole story of the initial
> syzkaller report (form top to bottom). I'm not sure where we go wrong
> but I think several places could do better here:
> 
> The code in net/9p/client.c creates one kmem-cache per client session.
> All of these kmem caches use the same name ("9p-fcall-cache").
> Is it ok to create several kmem caches with the same name? My feeling is
> that this is somewhat unexpected but should probably be allowed.

I don't think that's supported. kmem_caches are exposed in sysfs and having
the same name is gonna cause issues.

> In the setup in question slab caches are not merged. Thus the slub
> code uses the kmem cache name directly to create the sysfs directory for
> the slub cache. If we allow multiple kmem caches with the same name the
> slub code should somehow make the sysfs names unique (e.g. by adding a
> serial numer to the name), right?

I think we're just in uncharted terriotory. Maybe some things will work
while others don't. Nobody really thought about or tested this usage.

> Before creating the sysfs directory the slub code uses sysfs_remove_link
> (aka kernfs_remove_by_name) with the following comment:
> "If we have a leftover link remove it." In fact these "leftover"s
> are the sysfs files of an active kmem cache with the same name.

Hahahaha

> Additionally, sysfs_remove_link() looks like a bit of a misnomer
> as it removes whatever exists under the given name. This may be a
> symlink but it can be an entire directory hierarchy, too.
> Is this intentional? At least it's been like that forever.

It's a historical artifact. The backend implementation has changed while the
wrapping sysfs interface remained the same.

> If kmem cache creation is done in parallel we can now have
> concurrent invocations of kernfs_remove_by_name_ns() for the same
> parent and the same name. This is what eventually causes the race.
> 
> The race is possible as kernfs_remove_by_name_ns() looks up the
> name of the target in its parent but does not acquire a ref count
> on the target before calling __kernfs_remove(). __kernfs_remove()
> may drop the kernfs_rwsem in kernfs_drain(). Thus a concurrent call
> to __kernfs_remove can complete the removal except for the nodes
> that the first instance of __kernfs_remove() holds refs for.
> As explained above no ref is held on the root of the removed tree.
> This causes the use-after-free that KASAN sees and complains about.
> 
> For kernfs_remove it is reasonable to expect the caller to hold
> some kind of reference to prevent this type of race and from a quick
> check, the callers seem to get this correct. The only exception that
> I could find is kernfs_remove_by_name_ns. This is easy to fix if
> kernfs_remove_by_name_ns() hold a reference on the root node across
> the call to __kernfs_remove().
> IMHO this should be done. Should I sent a patch?

So, no matter what, I think it'd be a good idea to make remove_by_name hold
onto the kn it's removing, so please send a patch to do so. For the rest of
the situation, I think the right thing to do would be updating 9p so that it
doesn't create multiple kmem_caches with the same name.

Thanks.

-- 
tejun
