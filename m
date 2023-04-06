Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085BB6D9EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbjDFRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbjDFRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:21:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3683F83C3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:20:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sg7so3099706ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680801600; x=1683393600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3uUKW6dzuBcxiv7wPFPlh8AowQu6NgUDOohsGPsRqc=;
        b=ZNnjoRSA8C4ZUWBDwwSK4LmnYcrDpdogkx9nP+8KF6c320nxYGztaz6TDB6Dsjqkm4
         ccgfzCvbaHMmAlRxMUCr3xuShpm9/QKykpwAE8ROW51UabKnTIILVt8qX6ZcJno0lxky
         9xeVAP6ecNVK8VGVUTMQNedb3VD/43s+jiKnBRv6QWB8PlWCBxn2cfGCCCIb5KgvpuSp
         6LBraGJa64PNgHiOZ9L34rxVwUklDh/2DRL9P0K0PEGLWRSSv26etIsV7SQYzAmESvDf
         rZoemeliwLysUhEIt5RCsQd/m1XHZ4fAV6t9CDyKsuNJgpNpEYya0sfAMs6ASP1ItCZQ
         H9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801600; x=1683393600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3uUKW6dzuBcxiv7wPFPlh8AowQu6NgUDOohsGPsRqc=;
        b=6Ce3isC8zY3ydf3rd/KLCD+VA7/G0mxgC0Lmrm40Sv0bFhN8CVGw9BAebxYRg0zxeF
         yG7yywd5N8CLbQalkSX9HI/kvwxztWtEk5n9tse/F0Y3DYjV8G8LY5r0DIjoUjRsti5B
         S3QMHPMifF25RQQCNykwLdDJnYkDKgYP06nBFaVfF56x4khzCvFUiBH77v45ckitcxLp
         kS8iCMvjy+87vR8xD1SN1TkY9sCjh3AFRnukSkPgkUQLAV0FVx3RLPUXy7vQFW4YJxAP
         n04AmUKu5LVvRKOP7jcle6nlJgmZI1YpBEz6kTA0A42DGD9SJIYXVNuEhJaJi7FCllPl
         nadw==
X-Gm-Message-State: AAQBX9cUfYrdSjEcxrfak6q/LdWzRk3EBl9XxeVDUFvLM3XtXYyQ57aE
        IetzrgOx/DjbKqGbzNsq9BU=
X-Google-Smtp-Source: AKy350ZCfyM5SOtfesc+qhalcrjMtsxx6jFR13Rhm/qVNJRtMoNKH+wOa0M+HbZUj7qNsLdXb0nIHQ==
X-Received: by 2002:a17:906:4555:b0:932:3d1b:b69d with SMTP id s21-20020a170906455500b009323d1bb69dmr6836311ejq.47.1680801600276;
        Thu, 06 Apr 2023 10:20:00 -0700 (PDT)
Received: from andrea (host-79-22-3-90.retail.telecomitalia.it. [79.22.3.90])
        by smtp.gmail.com with ESMTPSA id mf21-20020a170906cb9500b009495cfe446esm1050570ejb.223.2023.04.06.10.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 10:19:59 -0700 (PDT)
Date:   Thu, 6 Apr 2023 19:19:43 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Deduplicating RISCV cmpxchg.h macros
Message-ID: <ZC7/LzV53KsZ/cSn@andrea>
References: <20230406082018.70367-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406082018.70367-1-leobras@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 05:20:17AM -0300, Leonardo Bras wrote:
> While studying riscv's cmpxchg.h file, I got really interested in
> understanding how RISCV asm implemented the different versions of
> {cmp,}xchg.
> 
> When I understood the pattern, it made sense for me to remove the
> duplications and create macros to make it easier to understand what exactly
> changes between the versions: Instruction sufixes & barriers.
> 
> Thanks!
> Leo
> 
> Changes since RFCv3:
> - Squashed the 6 original patches in 2: one for cmpxchg and one for xchg
> https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com/
> 
> Changes since RFCv2:
> - Fixed  macros that depend on having a local variable with a magic name
> - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com/
> 
> Changes since RFCv1:
> - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
> https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com/
> 
> Leonardo Bras (2):
>   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
>   riscv/cmpxchg: Deduplicate xchg() asm functions
> 
>  arch/riscv/include/asm/cmpxchg.h | 319 +++++++------------------------
>  1 file changed, 67 insertions(+), 252 deletions(-)

LGTM.  AFAICT, this would need to be rebased, cf. e.g.

  a8596dda1fbf7e ("arch: rename all internal names __xchg to __arch_xchg")

from the tip tree.

  Andrea
