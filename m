Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C862F6D8E63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 06:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjDFEiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 00:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjDFEh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 00:37:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5439BDE;
        Wed,  5 Apr 2023 21:37:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h8so146329631ede.8;
        Wed, 05 Apr 2023 21:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680755876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omwjfi+Gdv/8Pb9riMkNMFR9+eIPSxmZH2vSg68TvNU=;
        b=FFTR7A4oR4L80kBumqZFyw2O4/XnIrSHzSxwvhmllQd5G2JeBy9bX5Cl9cJtO2wYTQ
         Cg/v31anaKnYETjH/jHFXI4Ob/xhp1cLWJjKSZZXruL7OnxZBh1N+cv1o/KnoVMZgysy
         XCa92FEM/joC4L8z1hdYW3fz4J5qbBAJOTJ5vLlpM5nTkUNqwgQJVmjQoRP0hUkuPqfW
         JHwa/YqSq88S+rMLGdHqv/x+RMqtq0MLJobxj42JjFtM22AE08fDn7pJrKwHYUUjDxij
         LJ9stBmBuEfOlHZOkpbIG40eLipEtybdvg5G0kRUmMG+qsz45cO35g5cKD/FeREDcclJ
         pJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680755876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omwjfi+Gdv/8Pb9riMkNMFR9+eIPSxmZH2vSg68TvNU=;
        b=pVoV/lUh2g6LZrneEN4ir0wuWn/YlD92CQ7zHlhF7bMzu9LOdMReFnpmWh5Rov8yIj
         FjERFXvxFQfn0e9qy4SblesL2yshC54pCOSrWq7GzWHxGiTm6Xf5WeL+1OE8XeH9aEfp
         a0FaxzrzTNTKrUykMoG4Y2FF+iE6VZ+OV/7va8P7GBOoHjGfO96mIY5ALMMQoxpYDjhV
         oOMqspjI2ZIJ1JlM26D+MF3HXp+WRsbBHjeL4/2xbysFQV91GVm2UYVtA234ErT6im7C
         N/HqGiIs/g4AtmFutf9uW4NbjVR4LwgbE8EiVSasot9+6apPP93QCBJyyV2lO/SRnD+p
         CRuQ==
X-Gm-Message-State: AAQBX9f7Uz0pAAioDKgsmpDwlqKgUkRjr3FOJXqAFy0Mah31mQhdJV4t
        LvU/T5oaO5pUZjX50r5GUlw=
X-Google-Smtp-Source: AKy350ZfPWq0ms6fhEO1YjM1NJsQoqEDPPcwJckn1x5geLZ+tbKysggW6VrKGyp/nMxFg70s6deAyw==
X-Received: by 2002:a17:906:6d95:b0:927:dfc6:51e6 with SMTP id h21-20020a1709066d9500b00927dfc651e6mr4121578ejt.6.1680755875687;
        Wed, 05 Apr 2023 21:37:55 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id kf17-20020a17090776d100b009342fe44911sm243299ejc.123.2023.04.05.21.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 21:37:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 6 Apr 2023 06:37:53 +0200
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <ZC5MoREk30MIt79u@pc636>
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406001238.647536-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> executed before kfree_rcu_monitor() to drain page cache, if the bnode
> structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> page cache again in kfree_rcu_monitor(), this commit add a check
> for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> if the krcp structure's->backoff_page_cache_fill is set, prevent page
> cache growing.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9cc0a7766fd2..f25430ae1936 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2907,6 +2907,8 @@ static inline bool
>  put_cached_bnode(struct kfree_rcu_cpu *krcp,
>  	struct kvfree_rcu_bulk_data *bnode)
>  {
> +	if (atomic_read(&krcp->backoff_page_cache_fill))
> +		return false;
>  	// Check the limit.
>  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
>  		return false;
> -- 
> 2.32.0
>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
