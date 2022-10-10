Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522FC5F973B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJJDsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJJDsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:48:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7F18B07
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 20:48:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 70so8824471pjo.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 20:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHae+p8OlAHp+V5lhftHxU9vRo8UGtSzWUWZi2uZEnk=;
        b=P7t0mqMCOuB5RvBoKMUGbz+MzOHE+IGp1gucnTKj1tV4clKyMILD90ZzH0HHUe+HBg
         jyHFRibs0rWZOQm891YZFCRDawzdORXxL2BWf0QY+FZd3HC2ouL0WBwFVGe6SVLneJT+
         wTSe4hdw8bDqSGiMymGyy1VLRZqAE1KEZ0mH/MOIQ+1758iLP2zNCh8HKzpy3ygE78Z3
         dKPRy13AyfIHxhGc0PLgBiaok4ewGk1uf9H2FjxtBFMl/DLg8C2JHzfyBy67K1OrNcDH
         usWTR5AdwX6Lgh9Py1UtgnDI16vKpTudE3KLZ64VkHtBXTJAGlFrS+COMiodTwY1VKgC
         h9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHae+p8OlAHp+V5lhftHxU9vRo8UGtSzWUWZi2uZEnk=;
        b=12Q1NOGEYtTwBHUDRIvC9EbDpzQhwrS1T3uWccPhTeSz3MdAiRWuAqdf8ei8UmXIsn
         0lVCkUW8lCJTueX6BX1M4Su2r6c5E2AMlHg1fyrqsLL13vm0NIlRwUy9LrAFePZ4dz8p
         boPzpmsEL/OZxLoF9JSjkUAI2uLLY36c2kMbV7UQiQQ7AO8pyM19lajanyLiPmW9QZUX
         CgyA3rM/UkNb5UklV2NCYrYzGxrQTNnVV54riR/HD6Uu+47IDl8AZigVFiZkFG4vB3Z8
         5dHuyNu6rzRulNjFvELgiAgyLqu37f1JwQUmlvVSQiAMfOGvSHKu4yzEAcXRcI36GMkc
         AfeQ==
X-Gm-Message-State: ACrzQf3M9+rpp49I0HUYYb2eLdBPIYb+UWlCpvapS2WuGkkVvT0pIBVR
        L31paqDj1+95THYUTMz/rSnEqQ==
X-Google-Smtp-Source: AMsMyM4MXwciU8DYG7uPa2SAOYMKJ8KEgCki82/BHRPDAigNEfSbvZ116To5uehaJ23f51x2THoeFQ==
X-Received: by 2002:a17:903:1205:b0:178:ac4e:70b8 with SMTP id l5-20020a170903120500b00178ac4e70b8mr16920946plh.52.1665373690619;
        Sun, 09 Oct 2022 20:48:10 -0700 (PDT)
Received: from [2620:15c:29:203:5c2c:f18c:2a4e:44d2] ([2620:15c:29:203:5c2c:f18c:2a4e:44d2])
        by smtp.gmail.com with ESMTPSA id 65-20020a630244000000b0045913a96837sm5293845pgc.24.2022.10.09.20.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 20:48:09 -0700 (PDT)
Date:   Sun, 9 Oct 2022 20:48:08 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Alexander Aring <aahringo@redhat.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH] mm: slab: comment __GFP_ZERO case for kmem_cache_alloc
In-Reply-To: <20221008020312.1932347-1-aahringo@redhat.com>
Message-ID: <fe5780fe-7d52-53e1-4572-38112c4f69e8@google.com>
References: <20221008020312.1932347-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022, Alexander Aring wrote:

> diff --git a/mm/slab.c b/mm/slab.c
> index 10e96137b44f..7a84c2aae85a 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3482,7 +3482,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>   * @flags: See kmalloc().
>   *
>   * Allocate an object from this cache.  The flags are only relevant
> - * if the cache has no available objects.
> + * if the cache has no available objects. Except flag __GFP_ZERO which
> + * will zero the returned object.

Minor nit: it's probably better to do "... has no available objects, 
except flag ..." and not seperate sentences.  After that is done, feel 
free to add

	Acked-by: David Rientjes <rientjes@google.com>
