Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549D6F1D88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346349AbjD1RkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjD1RkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:40:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DD02117
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:40:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so70731335e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682703621; x=1685295621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Yz349oFUmOScSh3gK7q+CJzw5AMxaiK8BGTCzMECc=;
        b=eWpMKQyWdgeu2gE938hlnuoXbF1fjfOxNVnuNd9nzINsZyAvP84R4AeDsvyQBMNnTz
         wcSNMl34gra/pUQ3z3PP53CIzM+kmC8JHXdTCNBhN9Jh963SXqqfN9R//Vcjw4qevSLO
         g3YLz5z33BzM4GabhFr90q05xXlPY9Buit0EQE5gbj2rK5OJiYzrCz3eBCR1/IBpGjVP
         ko9XI58oX64VpnKv48eo+oOFoUNaXD8UBFVWLhc/07R3Nabu533dziN7EH2mClYPnHmp
         69nl4U5d15c1o5ZF/85o2gooW7e7N4McpEip+mUCLE3wNYnj6emU9bZ8myYEZb+wzPVY
         5WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682703621; x=1685295621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9Yz349oFUmOScSh3gK7q+CJzw5AMxaiK8BGTCzMECc=;
        b=TgKQ2Nh18xo1dxrJa6lP9vj1W0n8Cf426j0BmpH+zDD2zv/Rb14EcgcRu8E7gq3aS9
         P4s4TuS/vrbybKfYmPT6LZUP9posWTK66XvTLNeJNsC/1s1Nd4ejmNE8IMcgdVP16sOs
         vIWm6uodF/8Z4d8DOgSzQYM0fxhf4TP28qnbPKaCnzOrc2cWuPI3Op4JzDXK8DOLKS3u
         iHdn4WfgsDkPDZozcrkYPKTqYV0Dr04T+eugl9Vfdnzk5j2sfJlIEHCXiLqtXRqXxBha
         c0tG4cHiXQLkNe+DRsDLVxgrcM8O66UxVQ/gWeeS6066ps+Vzb+Ni7zg6D352bbTq/vE
         t27A==
X-Gm-Message-State: AC+VfDxbl1XKhkGGKueDOTDw9h0Y+kTFM6aISr+7KhAUd3jQLKquyrLM
        24dFo7gYndJYUntYhQ03WU8=
X-Google-Smtp-Source: ACHHUZ4j9Do5hCrwjMF0gqZVmAtUyPmzxD1UXqsCqqijvH57rUBRSay386g0G2MfLkLdGQkWbI0WeA==
X-Received: by 2002:adf:db41:0:b0:2cf:edd8:12d3 with SMTP id f1-20020adfdb41000000b002cfedd812d3mr4980916wrj.66.1682703620632;
        Fri, 28 Apr 2023 10:40:20 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm21700273wrp.20.2023.04.28.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 10:40:19 -0700 (PDT)
Date:   Fri, 28 Apr 2023 18:40:18 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: change per-VMA lock statistics to be disabled by
 default
Message-ID: <443a229c-4923-4c87-ba38-6ab4979d8f2a@lucifer.local>
References: <20230428173533.18158-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428173533.18158-1-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 10:35:33AM -0700, Suren Baghdasaryan wrote:
> Change CONFIG_PER_VMA_LOCK_STATS to be disabled by default, as most
> users don't need it. Add configuration help to clarify its usage.
>
> Fixes: 52f238653e45 ("mm: introduce per-VMA lock statistics")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/Kconfig.debug | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 6dae63b46368..a925415b4d10 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -274,6 +274,12 @@ config DEBUG_KMEMLEAK_AUTO_SCAN
>  config PER_VMA_LOCK_STATS
>  	bool "Statistics for per-vma locks"
>  	depends on PER_VMA_LOCK
> -	default y
>  	help
> -	  Statistics for per-vma locks.
> +	  Say Y here to enable success, retry and failure counters of page
> +	  faults handled under protection of per-vma locks. When enabled, the
> +	  counters are exposed in /proc/vmstat. This information is useful for
> +	  kernel developers to evaluate effectiveness of per-vma locks and to
> +	  identify pathological cases. Counting these events introduces a small
> +	  overhead in the page fault path.
> +
> +	  If in doubt, say N.
> --
> 2.40.1.495.gc816e09b53d-goog
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
