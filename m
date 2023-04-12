Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA96DED7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDLIXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:23:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45049D8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:23:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B5E381F6E6;
        Wed, 12 Apr 2023 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681287778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FcWShTLZwMj7byM7GoWhs0brUy/V+V07RbFzNi8EJrw=;
        b=RRjhePAoThGFfAjD0LLLU76W+SHe2Wj4A865se3memKBHXtWbfv+mPLJNzrt5/Ze1B0V4+
        7DhIgSiHLyoBvDP0NjZc5D7TtH7/yHr/+hP3fiXJz0Cq2aGSWgbFLxT5vfMCLvEtMD8fLa
        oHFHPSKj+TLy6cfYsiFopXC/eRpqFAo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95BC2132C7;
        Wed, 12 Apr 2023 08:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WEFDImJqNmR4WQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Apr 2023 08:22:58 +0000
Date:   Wed, 12 Apr 2023 10:22:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     jstultz@google.com, tjmercier@google.com, sumit.semwal@linaro.org,
        daniel.vetter@ffwll.ch, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [PATCH v3] dma-buf/heaps: system_heap: avoid too much allocation
Message-ID: <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
References: <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcas1p4.samsung.com>
 <20230410073228.23043-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410073228.23043-1-jaewon31.kim@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for being late. I know there was some pre-existing discussion
around that but I didn't have time to participate.

On Mon 10-04-23 16:32:28, Jaewon Kim wrote:
> @@ -350,6 +350,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  	struct page *page, *tmp_page;
>  	int i, ret = -ENOMEM;
>  
> +	if (len / PAGE_SIZE > totalram_pages())
> +		return ERR_PTR(-ENOMEM);
> +

This is an antipattern imho. Check 7661809d493b ("mm: don't allow
oversized kvmalloc() calls") how kvmalloc has dealt with a similar
issue. totalram_pages doesn't really tell you anything about incorrect
users. You might be on a low memory system where the request size is
sane normally, it just doesn't fit into memory on that particular
machine.


>  	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
>  	if (!buffer)
>  		return ERR_PTR(-ENOMEM);
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
