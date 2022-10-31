Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68528613DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJaTCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:02:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197DF9FEA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C609EB81A4C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AB2C433D6;
        Mon, 31 Oct 2022 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667242936;
        bh=mPFQfM6aS5Jpa/KM2LAixsEQQCB5mlXyCDNlwxKELgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbnCkEgmsMw0FrJmGyw06vEWI6dSEQBMFS5Sgqf0Ta6UTj5fs00a/aRDqYWTjWdmA
         VCPshaXXIMRSkUy8RLbZ4d/WUjuSFMtt5318O8xT6t16VHMIptayNrzfEbwYNicYpL
         97DvqWY66uIey9O4Zi7EjBCGJ7YDEhCtommN/UkOliy3JM4LVnHvJYcynnXmtwNGy3
         mtqPqlfUUpuS8u981aFOUqPqBUGU9GEFQikrIdpRVSp4Th5X5iWooPxkfykKIWXegA
         EsRfw1u/xkDUoBXIgXX2MidR93ViZ5HEv6LHHi5NdHeVj0NJ1DjoWnFl0eP2GP72wq
         CZmCILzLfd5bQ==
Date:   Mon, 31 Oct 2022 20:02:12 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH RESEND 2/2] ucount: Use atomic_long_try_cmpxchg in
 atomic_long_inc_below
Message-ID: <Y2AbtAAVBjmya9qJ@example.org>
References: <20221017144049.3404-1-ubizjak@gmail.com>
 <20221017144049.3404-3-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017144049.3404-3-ubizjak@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:40:49PM +0200, Uros Bizjak wrote:
> Use atomic_long_try_cmpxchg instead of
> atomic_long_cmpxchg (*ptr, old, new) == old in atomic_long_inc_below.
> x86 CMPXCHG instruction returns success in ZF flag, so this change saves
> a compare after cmpxchg (and related move instruction in front of cmpxchg).
> 
> Also, atomic_long_try_cmpxchg implicitly assigns old *ptr value to "old"
> when cmpxchg fails, enabling further code simplifications.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Alexey Gladkov <legion@kernel.org>

Eric, I think the patch looks good. You already reviewed the previous
version [1]. What do you think about this version?

[1] https://lore.kernel.org/lkml/87pmi6z143.fsf@email.froward.int.ebiederm.org/

> ---
>  kernel/ucount.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 74f5b4959feb..2c04589a61ff 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -214,16 +214,14 @@ void put_ucounts(struct ucounts *ucounts)
>  
>  static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
>  {
> -	long c, old;
> -	c = atomic_long_read(v);
> -	for (;;) {
> +	long c = atomic_long_read(v);
> +
> +	do {
>  		if (unlikely(c >= u))
>  			return false;
> -		old = atomic_long_cmpxchg(v, c, c+1);
> -		if (likely(old == c))
> -			return true;
> -		c = old;
> -	}
> +	} while (!atomic_long_try_cmpxchg(v, &c, c+1));
> +
> +	return true;
>  }
>  
>  struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid,
> -- 
> 2.37.3
> 

-- 
Rgrds, legion

