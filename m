Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECE76488BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLITAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiLITAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:00:43 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83970AD989
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:00:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so5907884pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMg099aQi7hLBEF3SgKTmpf8TrbpvWLiZ1q8A/xUZ+k=;
        b=VEDqSAkUYqie+fqRJ0O8HFwVPKR3WzYd6TEU4gjJVX+IRgpxueeqMSmJ1z5tRoY4iA
         2AnfmJLAxoEPGgqZnX+Y3pztxeB57d0HdL6OkuR9q9R8xt1Rx0iD9YAVyctwfZFMvvm6
         IqHdZWtTBU8Jg1NjbHL8KrD915cC5J7I+R6/DIsu27PUVx4fONC+WgxN8H7x5fu9mWVv
         1i+kxRKq3Y/V7nXppoZZncMA3oo8py+6fpIODZ0pc2UKgpcqQpDWKLe67F3c7xw1fnkC
         rUgLuwFndLzy1lw7l2HZI9qWCJxG5AalkByo4fD51eAUVA5Nx68+PeLvHlmefTcujc3g
         MGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMg099aQi7hLBEF3SgKTmpf8TrbpvWLiZ1q8A/xUZ+k=;
        b=TDBNj+0ItjExAAVs/PTKPtBCuAeM15Hdzkm1E9invfOXAnpP/P7poYVk8ynSYA1xk6
         ZncT0UJLDa3eLkiwINKqHMQ4f4yuh1JPF33u24PIPxuvY8u1zKNUasp+VEVB7XROLtLG
         Xwa4AqXDv+AQ0TK2tjMSWKnoK6YWZUw0hL9DQ7LcO8guvEmJZdZKJNMOLVdQz7hWKaHL
         iqkiQpb4/hh/KIGnjqmd71jjkmmAh5HA1HEkHUZg9ZBHxMvfffrBolbFOrqREyw/oC5w
         y0LyKH+N0/+GRMW2Kp7/FoX3Qvh9ZIS0iWjRRMd09Z2KfiqvVCuX98wO6FJx4+qZdeDc
         PG+A==
X-Gm-Message-State: ANoB5pnvLrMQ2efL1vgVegQyjp4prXFYc9kmKb03tNI/rdnCnA0kvjL2
        ZcHRYoBhETdHQch56HbdrisWBA==
X-Google-Smtp-Source: AA0mqf4CthZGlj5S8zGFaLR5e0xvxqBCEbDOVBDQE75T02ovAOL8VgehG1FBct07Ujk6DCXQa8owaA==
X-Received: by 2002:a17:90a:d381:b0:21d:203f:a316 with SMTP id q1-20020a17090ad38100b0021d203fa316mr5105488pju.47.1670612441723;
        Fri, 09 Dec 2022 11:00:41 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a2f8f00b00213d28a6dedsm1537064pjd.13.2022.12.09.11.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:00:40 -0800 (PST)
Date:   Fri, 09 Dec 2022 11:00:40 -0800 (PST)
X-Google-Original-Date: Fri, 09 Dec 2022 11:00:36 PST (-0800)
Subject:     Re: [PATCH 1/2] riscv: Fix crash during early errata patching
In-Reply-To: <20220922054743.30159-1-samuel@sholland.org>
CC:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        aou@eecs.berkeley.edu, guoren@kernel.org, heiko@sntech.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org
Message-ID: <mhng-38138b26-2922-4228-8a61-6d30afb2335c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 22:47:41 PDT (-0700), samuel@sholland.org wrote:
> The patch function for the T-Head PBMT errata calls __pa_symbol() before
> relocation. This crashes when CONFIG_DEBUG_VIRTUAL is enabled, because
> __pa_symbol() forwards to __phys_addr_symbol(), and __phys_addr_symbol()
> checks against the absolute kernel start/end address.
>
> Fix this by directly using the underlying kernel_mapping_va_to_pa().
>
> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  arch/riscv/errata/thead/errata.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 202c83f677b2..83174f13783e 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -76,8 +76,9 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
>  		if (cpu_req_errata & tmp) {
>  			/* On vm-alternatives, the mmu isn't running yet */
>  			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> -				memcpy((void *)__pa_symbol(alt->old_ptr),
> -				       (void *)__pa_symbol(alt->alt_ptr), alt->alt_len);
> +				memcpy((void *)kernel_mapping_va_to_pa((unsigned long)alt->old_ptr),
> +				       (void *)kernel_mapping_va_to_pa((unsigned long)alt->alt_ptr),
> +				       alt->alt_len);
>  			else
>  				patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
>  		}

Thanks, these are on for-next.
