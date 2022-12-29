Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBC658D95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiL2Nm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiL2Nlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:41:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867311C1F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:41:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so18950771pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5HPkp/bFHtlvqu2/9jRhTUPSjVDvmYX0Z0JICpgPF4=;
        b=WFu/SR8ZQg4bvs/mrWjdnOB/Wz2Hq7FEggZ6qtDdUaH3RW37YntXntNMzjPxuJEZz1
         bWXfmgfwr2pjRdqhtqhlh2rnan7W+xaAEybVXbumaqFNwc3FBXNSQc3pItIDGuoFQ6CP
         hFGnj5tnxjKsjyDi9+yxuaIPAG4dPpGYLJeT1IZZXDNvUpNXoK5Ni/IcVULmfe0QzYFL
         H/Rfzj/pI6Um4SsLjrCTtvovY8n5F3snqxXV5pR6wXTZamfBZ6gQ52XgmFh7gTibj2wX
         xQW4og84vn1ayRFb5A+Us/AMEbEI+6Ut2XhwHEt2A4zQV4o7WVQTlj4RGX05i5jcUPRB
         FtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5HPkp/bFHtlvqu2/9jRhTUPSjVDvmYX0Z0JICpgPF4=;
        b=jnxWVlha+NzhGdwwLFp/Kmr6JgDjvY6B5WaO8EJfKWsaPcIpI6jhRJp0nDa48W4hX6
         UHiLAZn8zmEC8XLr2lIanlgdRARiwuh+9xZqU3KwVQauzQSoKjWvCfM/eMzEJW958Ufp
         Isp/ZsI3+nWyfNSdDBFh31jnTUHvUx/DDBs/Da7OJTB8mTUam4VP8x1cAokaiFeV1Ggk
         nbqiCal7kDz1vl6k2aHpkM2jb5LVnLOCy3rVt0oceSzYqEtlJKf8x5adDlvCLy6dcDwd
         MrI2YpaCbZwmJk1q2238+nIVSa4UZ97wSEtWVZGCKP9GPEVt8NMtK+/vbVoSGAXuXohX
         NA+w==
X-Gm-Message-State: AFqh2koTkrltdKSF1jMN9uyGftdTFQBt+GqMBu8xWyRJyJ0A+Cw1whtC
        oFDF2G1YjGL4bc9cxfa9BgY=
X-Google-Smtp-Source: AMrXdXt/NRkAl9nuAw4qYUXU/X7DpyDKQIWmG9aLNEm2LrPvqt3ErvGsqUoxY7op3IzjLMckXTZJwA==
X-Received: by 2002:a17:902:f68a:b0:192:49f4:fe67 with SMTP id l10-20020a170902f68a00b0019249f4fe67mr40899472plg.57.1672321304209;
        Thu, 29 Dec 2022 05:41:44 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b001895b2c4cf6sm12830895pln.297.2022.12.29.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 05:41:43 -0800 (PST)
Date:   Thu, 29 Dec 2022 22:41:38 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, slab: periodically resched in drain_freelist()
Message-ID: <Y62ZEsE4mJOqNFAD@hyeyoo>
References: <b1808b92-86df-9f53-bfb2-8862a9c554e9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1808b92-86df-9f53-bfb2-8862a9c554e9@google.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 10:05:48PM -0800, David Rientjes wrote:
> drain_freelist() can be called with a very large number of slabs to free,
> such as for kmem_cache_shrink(), or depending on various settings of the
> slab cache when doing periodic reaping.
> 
> If there is a potentially long list of slabs to drain, periodically
> schedule to ensure we aren't saturating the cpu for too long.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  mm/slab.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2211,6 +2211,8 @@ static int drain_freelist(struct kmem_cache *cache,
>  		raw_spin_unlock_irq(&n->list_lock);
>  		slab_destroy(cache, slab);
>  		nr_freed++;
> +
> +		cond_resched();
>  	}
>  out:
>  	return nr_freed;

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
