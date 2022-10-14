Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71215FF70D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 01:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJNXs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 19:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJNXsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:48:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A8FE923
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 16:48:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h185so5597525pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QZI/RqGnedzhVKRkdDMdjD3VHFiD/WtMgGFjHrwV9E=;
        b=KnSdxaaGLSvkI99TvIbrbSUUvmAOAxfEqbL+31ZrkN1Gfp0YkJGkOui74tPIAh0NgT
         LLq/dGPuaCoO9WLeNv+a2y/xtSHpzCWI36EJMYq6k3DGpgsukzAzHZK+QrLLcYrxK8/W
         OeSrP/U8trz4hvqKw+cb/WMsaum9QXzDw92B9Iut+j5+V3qaYmq2hqn9y1wx7r0kQVl5
         lDvS+o91ObQJ35vlSjpnel2jF8H3mZUFUj0o7cljURAnvW0vg06YfDJPb4XkksJYwsQ8
         21AK2tB0bCX6iYQQGTVQ/mR7SSFEZYfOfUBp6wuM6q2O9h9bmMBfNLlBh9hs6usglABE
         n9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QZI/RqGnedzhVKRkdDMdjD3VHFiD/WtMgGFjHrwV9E=;
        b=D9mQY7cneoNre/RkMyPcnJZ9RRY0OO9LOae+e5RhFXqr78M0fVb2ZlLKTt0vCRDIe8
         KWkj6w63wZSQ3LK6psV+t7Av04RxptkCYXi+5KXdCtzXNNwhP1O9v5lS7DldE1N//XLN
         aLkTWNY4lpr88NcKv8jAYCTeSahLMHgQjxbXXYEq7tMjcSULuGNHhgCuiyVWQVXBaWGm
         xe4nTRg00464VJYj3Ddwi3Yd3FDt7lV1qkSvFpY+cX+Jl1HOB+xuVspVR/45fihzCwix
         SeBD1Ny2zYE95c3JojntnGMhB5TjgLE+tpNpc1paPV4y5DTelmsprdnmbUY8NfmO0v19
         EUsg==
X-Gm-Message-State: ACrzQf1HtFOXMNqc7+PaBVQqXiPGL2d6tppJAIemlGeUNEl8h2d5WAAH
        JmqZ2EjOhb+Iwq7Dy7+onfY=
X-Google-Smtp-Source: AMsMyM4gRZUkhS+sXJU511zMUbOxhDdsWoimzJmbCC2Z+UHp8Qo/CauVmIxAS4NYnTU3evUQPnNDCg==
X-Received: by 2002:a63:91c9:0:b0:459:ca3:7245 with SMTP id l192-20020a6391c9000000b004590ca37245mr337385pge.94.1665791329912;
        Fri, 14 Oct 2022 16:48:49 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 73-20020a63064c000000b0043c732e1536sm1934836pgg.45.2022.10.14.16.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 16:48:48 -0700 (PDT)
Date:   Sat, 15 Oct 2022 08:48:43 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/17] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
Message-ID: <Y0n1WxxwbgSOmMwJ@hyeyoo>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
 <20220817101826.236819-11-42.hyeyoo@gmail.com>
 <20221014205818.GA1428667@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014205818.GA1428667@roeck-us.net>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 01:58:18PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Aug 17, 2022 at 07:18:19PM +0900, Hyeonggon Yoo wrote:
> > There is not much benefit for serving large objects in kmalloc().
> > Let's pass large requests to page allocator like SLUB for better
> > maintenance of common code.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> 
> This patch results in a WARNING backtrace in all mips and sparc64
> emulations.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at mm/slab_common.c:729 kmalloc_slab+0xc0/0xdc
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-11990-g9c9155a3509a #1
> Stack : ffffffff 801b2a18 80dd0000 00000004 00000000 00000000 81023cd4 00000000
>         81040000 811a9930 81040000 8104a628 81101833 00000001 81023c78 00000000
>         00000000 00000000 80f5d858 81023b98 00000001 00000023 00000000 ffffffff
>         00000000 00000064 00000002 81040000 81040000 00000001 80f5d858 000002d9
>         00000000 00000000 80000000 80002000 00000000 00000000 00000000 00000000
>         ...
> Call Trace:
> [<8010a2bc>] show_stack+0x38/0x118
> [<80cf5f7c>] dump_stack_lvl+0xac/0x104
> [<80130d7c>] __warn+0xe0/0x224
> [<80cdba5c>] warn_slowpath_fmt+0x64/0xb8
> [<8028c058>] kmalloc_slab+0xc0/0xdc
> 
> irq event stamp: 0
> hardirqs last  enabled at (0): [<00000000>] 0x0
> hardirqs last disabled at (0): [<00000000>] 0x0
> softirqs last  enabled at (0): [<00000000>] 0x0
> softirqs last disabled at (0): [<00000000>] 0x0
> ---[ end trace 0000000000000000 ]---
> 
> Guenter

Hi.

Thank you so much for this report!

Hmm so SLAB tries to find kmalloc cache for freelist index array using
kmalloc_slab() directly, and it becomes problematic when size of the
array is larger than PAGE_SIZE * 2.

Will send a fix soon.

-- 
Thanks,
Hyeonggon
