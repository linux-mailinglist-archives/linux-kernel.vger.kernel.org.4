Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3EB658FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiL2RcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiL2Rbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:31:40 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5120F15FCD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:31:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n4so19559925plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVJacmndrR3SXF4pgI7oq7jigbBGB7nMmK3ZJ4uErFg=;
        b=sLDUvYVARgK48hM4ztw89h3d9Pa2+0WTyT7T5Ud9zRoin3WUKukse7kiiDZK/VqpLy
         TTV8avCc4fhG2Q4R4ek5ySBKdx9iZ9VUoBkgSVttyKy+QT7h6f7rsNNr5APjsuJ036QY
         bvRIrXiGnJ4encNQ85H3NcxikMAaZgZXmx+2WbHUfO4YvZJc8cQK3u7CGNMAKkvMgviE
         qPg4A5cB8ZgArCQSwb4L9pFxEBj/rBwNe3P9/d2Klt0PAKvxbQaXXnxCkAkxni2bxWnZ
         4ph22vu4DS5S7CwJenUcWlx2fGHqIA3NHkf6DcE46OxlcnThLbDf6M7u0v8qLZuaaBvy
         B+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVJacmndrR3SXF4pgI7oq7jigbBGB7nMmK3ZJ4uErFg=;
        b=N06AY8k7cqXTbIPoQBvY1T57iIjW9g1xnZEEOgPOYx6T3lQy6tcLxnLerP3leTSSEv
         7R4u4W/AC3sgtd7FrF8HrSCtsjS+oPoEIt07DK/vne1QD1T4+nEO0OAi7ruq5xsP2DT3
         E6yLgn4LfhgndRItFxAMi0BH+bmSPw59xkCFq1tswMuLiLR4HCAgL6IdCxGfBhE4UbdT
         ExNzlP1M/aqlPCStLvu3En7T2dSvDo+vMUvYI9oWD36P5vXXAmntVkpYlbg4UlI4+ZHO
         EPXCZVo4x5ZktI12wMV/KczqHMRW4cjGMD1Urqml439q6x+Krtr9X2K9AeTpHzTHgA1g
         BMlA==
X-Gm-Message-State: AFqh2kqmATKHosUsN7Yau9EswKKSlixZn4a5jGRinH8R2gMWH/KxGeQt
        4gb2ROLd+OpKbNcNTUTNJn0oCOqT/4eZeS5SIU8=
X-Google-Smtp-Source: AMrXdXv0mxJh49+wrAsaFTyEAENNSxXzOQUalYVKurBjgXyeUd3pmwBkvxXy4JCbjCFBxoRUdIpJ8Q==
X-Received: by 2002:a05:6a20:c78d:b0:a3:878d:c126 with SMTP id hk13-20020a056a20c78d00b000a3878dc126mr39597273pzb.42.1672335087597;
        Thu, 29 Dec 2022 09:31:27 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id 27-20020a63115b000000b00477bdc1d5d5sm11199985pgr.6.2022.12.29.09.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:31:27 -0800 (PST)
Date:   Thu, 29 Dec 2022 09:31:27 -0800 (PST)
X-Google-Original-Date: Thu, 29 Dec 2022 09:31:18 PST (-0800)
Subject:     Re: [PATCH] riscv: uaccess: fix type of 0 variable on error in get_user()
In-Reply-To: <20221229170545.718264-1-ben-linux@fluff.org>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        ben-linux@fluff.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ben-linux@fluff.org
Message-ID: <mhng-33b9aafc-448a-4400-9a06-cb222724363a@palmer-ri-x1c9>
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

On Thu, 29 Dec 2022 09:05:45 PST (-0800), ben-linux@fluff.org wrote:
> If the get_user(x, ptr) has x as a pointer, then the setting
> of (x) = 0 is going to produce the following sparse warning,
> so fix this by forcing the type of 'x' when access_ok() fails.
>
> fs/aio.c:2073:21: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/riscv/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 855450bed9f5..ec0cab9fbddd 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -165,7 +165,7 @@ do {								\
>  	might_fault();						\
>  	access_ok(__p, sizeof(*__p)) ?		\
>  		__get_user((x), __p) :				\
> -		((x) = 0, -EFAULT);				\
> +		((x) = (__force __typeof__(x))0, -EFAULT);	\
>  })
>
>  #define __put_user_asm(insn, x, ptr, err)			\

Looks like arm64 has a pretty similar pattern.  They've got the __force 
__typeof__ already, but given the similarity it might be worth 
refactoring these to share the error checking code.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

I'll give this a bit of time like usual, unless anyone's opposed I'll 
put it on fixes.  I wasn't planning on sending a PR this week anyway due 
to the holidays.

Thanks!
