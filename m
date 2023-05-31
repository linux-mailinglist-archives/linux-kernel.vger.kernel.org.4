Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89437718E56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjEaWUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEaWT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:19:58 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9030F124
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:19:57 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75b0b5c9eb8so4472785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685571596; x=1688163596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/jTKIkWp5S3hrOoSNCwINC/h38BfNRFFGaXj+xEvDYQ=;
        b=Chb8/evMuwJFAZr3IRuau3cOgrPVEB3DMF5OnQZEBbGifvNOVSXrkrLVS4KU6ZdemA
         8qdlojJUbR+Yy70Oo0HwBYq1i6TFW+Wz5CpvhM0jaWupb8K2IZskD2X84boucIiqRn9A
         FXc3ZR70tUtHVZ9/lBQoNxmgVDYZiUbGKBg6cn9GSGDKL3A6S8BrzTlK0W9Lih9pq+TV
         uqRgePsG9dy+409Qf91ezFK88iq6nTjpllF0+x1CBn2rt68ChXmA4NcKmM+KrFPZSMQf
         RgvOK1oV9k4wJOI7wg7FbGCeHnFTxG8zPjCTTjTB3l8D/VVyX7Ov1dFy2QPUUcOi+MnA
         yRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571596; x=1688163596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jTKIkWp5S3hrOoSNCwINC/h38BfNRFFGaXj+xEvDYQ=;
        b=U4jWZmTZpPslFZfZypnjr5fgnmZBqGsMZbjqAmSvY9YjjJXvhaJDfEvIfb/oez+WHg
         OMaX1HrACjZhJBSu4zAEi16AcxPR3bZFVnRuZwKcmT5hZsU/xTSAq5X/8XkRwquSTHjX
         5k7FbU2Gqd30evQN6+h9wFBSwpFrO5UnGQmo+w2ihW3r+5LDX52j2GP8El34iUOSojYR
         TUwPzd++wvBNztNxIPJB/WnRGPBgOXRGNUtO2it0N+cmydk8eFULnkf6j14oIPOTYbDX
         v2PmqpcAx2kImRFjE7rwxh7vv8A14GzijfIzebqZY9LErZwcIOpHk2m4D5fAHGeu4Uk3
         FzsA==
X-Gm-Message-State: AC+VfDzfPJfpN53ztq+P0eN4qotdEk4+p+DeXDZMobaYMtG4hrjNLIEV
        5H20pCCBnfyneDjF+e6rID48qA==
X-Google-Smtp-Source: ACHHUZ4c3S3KwC90dBrVb/pTIaI8w6XyuzWNnE2JCVMDLHEXYJs2rXthpT1zdPPS9QgI096caPz9Rw==
X-Received: by 2002:a05:620a:8186:b0:75b:23a0:e7b1 with SMTP id ot6-20020a05620a818600b0075b23a0e7b1mr5753518qkn.18.1685571596644;
        Wed, 31 May 2023 15:19:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id r28-20020a05620a03dc00b0075bcc5ab975sm5549183qkm.92.2023.05.31.15.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:19:56 -0700 (PDT)
Date:   Wed, 31 May 2023 18:19:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
Message-ID: <20230531221955.GD102494@cmpxchg.org>
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 04:39:34PM +0530, Charan Teja Kalla wrote:
> This patch is tested on Android, Snapdragon SoC with 8Gb RAM, 4GB swap
> mounted on zram which has 2GB of backingdev. The test case involved
> launching some memory hungry apps in an order and do the proactive
> reclaim for the app that went to background using madvise(MADV_PAGEOUT).
> We are seeing ~40% less total values of psi mem some and full when this
> patch is combined with [1].

Does that mean those pages are thrashing, but because you clear their
workingset it isn't detected and reported via psi?

I don't rally get why silencing the thrashing is an improvement.

> [1]https://lore.kernel.org/all/20220214214921.419687-1-hannes@cmpxchg.org/T/#u
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  mm/madvise.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 340125d..3410c39 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -409,8 +409,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			if (folio_isolate_lru(folio)) {
>  				if (folio_test_unevictable(folio))
>  					folio_putback_lru(folio);
> -				else
> +				else {
> +					folio_clear_workingset(folio);
>  					list_add(&folio->lru, &folio_list);
> +				}
>  			}
>  		} else
>  			folio_deactivate(folio);
> @@ -503,8 +505,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			if (folio_isolate_lru(folio)) {
>  				if (folio_test_unevictable(folio))
>  					folio_putback_lru(folio);
> -				else
> +				else {
> +					folio_clear_workingset(folio);
>  					list_add(&folio->lru, &folio_list);
> +				}
>  			}
>  		} else
>  			folio_deactivate(folio);
> -- 
> 2.7.4
> 
