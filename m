Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE36D7C28
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbjDEMEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjDEME1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:04:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAC9423B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:04:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5456249756bso672189497b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680696265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc1O/3tBn4f4m5JiXi+5lhNQ7hroBGI4J7HFe2W6iv8=;
        b=EYWaxXUSiPtfLUoWDM9RflZoqa17EbClslQ0heuLVOFRybCojXfHZJ0fHM0AXA04a3
         pB72KI0i7KHj9yyHv+Wg0Fl0KKi8QeyPJ4lmfKIGYFErVbPZm6l9j/2D58vLTs1R2VqZ
         hYzzVzvnR3NguzhoxyOreeCCQG0iNL9oy6ngua4/vs7LgjLe6C0NS+qwYxImOhiKj+kB
         NihWwU6S7E6SmeejoKrNgxCsrJqaPQseq44LaGLH/uPllBADmqb8VAA+yVlDmzGNN/35
         7I7M9LSXtHeycdcHXjVL/NHM1reF7nMSThBvoQc4m185huU5P3iQPJ4645NQ9LST1f1u
         Wkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680696265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc1O/3tBn4f4m5JiXi+5lhNQ7hroBGI4J7HFe2W6iv8=;
        b=kePtWzvhqVP/cQOFnNq0nCflNL9WbtgojgQL+Qh7g/J00FA9jrgT0qY+hxnNHOaEXg
         QDYD3tPExNTBbY3SUSYMJkkyKkJWHPcJrFxIoMTYRChStO+LofvaQain58tJ1iIXlmTR
         MGwyztsOOJVP9b/t8FhKZGJW2ZYlGib0Z+gJVuL2i8UaBe9xbDdNxYROrbgHc/aqrypL
         R3DRCrokf4zytdM/ob9oFBXDUf8767ZCC0aryX3hiKvsv37Niw6EU3VjlATIRUUrPTP9
         twPRw0MGwCSdGfvJlgHDoh54UowbcoLic3TvtocTnKgXyoIZTnD00zi2+5IJUiqP0/Oa
         CGdw==
X-Gm-Message-State: AAQBX9dUYezFG/sBX1V+4icpFy4dfbyDxTOkR0XIJPQYqKdTNj/HHVjn
        yBuLpYLmqsjGEXoAweWeauKSSw==
X-Google-Smtp-Source: AKy350a4jWPDXhkQi5gazv6P2Kmuc4h33MIHoIgUjltYXV7mcOq17COGqVWrtU0rEDFGX2sYenkbmg==
X-Received: by 2002:a05:7500:5e88:b0:fe:ff2e:de76 with SMTP id fk8-20020a0575005e8800b000feff2ede76mr205702gab.4.1680696265174;
        Wed, 05 Apr 2023 05:04:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id n2-20020a374002000000b0074860fcfc00sm4313790qka.136.2023.04.05.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:04:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pk1sF-0076sS-LN;
        Wed, 05 Apr 2023 09:04:23 -0300
Date:   Wed, 5 Apr 2023 09:04:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Price <steven.price@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] smaps: Fix defined but not used smaps_shmem_walk_ops
Message-ID: <ZC1jx1LIwENgzTaO@ziepe.ca>
References: <20230405103819.151246-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405103819.151246-1-steven.price@arm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 11:38:19AM +0100, Steven Price wrote:
> When !CONFIG_SHMEM smaps_shmem_walk_ops is defined but not used,
> triggering a compiler warning. To avoid the warning remove the #ifdef
> around the usage. This has no effect because shmem_mapping() is a stub
> returning false when !CONFIG_SHMEM so the code will be compiled out,
> however we now need to also provide a stub for shmem_swap_usage().
> 
> Fixes: 7b86ac3371b7 ("pagewalk: separate function pointers from iterator data")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304031749.UiyJpxzF-lkp@intel.com/
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> I've implemented Jason's suggestion of removing the #ifdef around the
> usage and prodiving a stub for shmem_swap_usage() instead.

This seems OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

  
>  extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
>  			  struct mm_struct *mm, unsigned long vm_flags);
> +#ifdef CONFIG_SHMEM
>  extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
> +#else
> +static inline unsigned long shmem_swap_usage(struct vm_area_struct *vma)
> +{
> +	return 0;
> +}
> +#endif

Though it would be nice if this file didn't have so many ifdef blocks

Jason
