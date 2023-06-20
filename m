Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F577375A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjFTUIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFTUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:08:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55C31712
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:08:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6686ef86110so1786743b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687291696; x=1689883696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=318XWlM4e2igWpHIz+MggKIvdfRUN34HXiCvg/LQO1g=;
        b=Lp9Ynt5oCqS1VBGBFjTYki3QVEgduCsI9ENm5Wb6G9x9aS8tOXFfZPXAV6sRbLp+Qv
         p+xN70BT+pqT7VeF1i2oB5Dwcw7MsKdeAdewxCYAnVKF/9aZE9PN3ruzVqH7QLlyo9nc
         gYn1I1DDKN3htnPyQ5unIWvsBfqMePVFHBT0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291696; x=1689883696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=318XWlM4e2igWpHIz+MggKIvdfRUN34HXiCvg/LQO1g=;
        b=K6KL+O51yS8XIg+bTJRIBiniuh+dZNcttURArO+ZiMmLcJlF9G52CyzyGf6Zo8PQtp
         TaFug916w5aiRK2RiREQiXS9OTlAkbDR7kHKmQhj5y0Kx4eEsAe8numKC5szQOH7/D7u
         /auNrB5bKQJQJCWJ1C0IU0Kq4WLeeVT2MN5zbnj7McZG/EtfuTTLJFQbkzvIXfkGKjP0
         WFPbFr9LnHfJ8GZam7HJzueF6gGV4j+C3eIPxYdRclXsGPzpUZ65NOS5SwTXDIZhWYg6
         w/y7bqkXHo/GKUw0YdZSHvAO6GCiG+rMydo2FTEhmh7hrv3LO/mXh4RqXeBBuqAAkjdz
         JCcg==
X-Gm-Message-State: AC+VfDwMJEfmN8A6YorNp4ooj/91c2YZWKBZfqS3YSXW1IM4iQJy8j0j
        M28nbuViSvYIzbfUC+5svM5APrwJLaYKpOuoMrQ=
X-Google-Smtp-Source: ACHHUZ4w+QcT4yTeHsbDafU9337nCtSLcAT22q8xLPV/C4QuIV1WjrS0iBIP+9+M75o5kMUvZHLV6w==
X-Received: by 2002:a05:6a20:a125:b0:11f:7f84:21c3 with SMTP id q37-20020a056a20a12500b0011f7f8421c3mr6808021pzk.31.1687291696290;
        Tue, 20 Jun 2023 13:08:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x19-20020a62fb13000000b0066872ef995fsm1678339pfm.5.2023.06.20.13.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:08:15 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:08:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        Tom Gall <tom.gall@linaro.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: check for missing Fixes tags
Message-ID: <202306201259.D3E15331@keescook>
References: <ce2d9aa7-b1e6-402e-8471-ad52a321c008@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2d9aa7-b1e6-402e-8471-ad52a321c008@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 02:45:12PM +0300, Dan Carpenter wrote:
> This check looks for common words that probably indicate a patch
> is a fix.  For now the regex is:
> 
> 	(?:BUG: KASAN|Call Trace:|stable\@|syzkaller)

I thought the bare word "syzkaller" was going to match too much, but
looking through commit logs, it seems fine. If it does end up too noisy,
perhaps "@syzkaller"?

For "BUG: KASAN", though, I think we need to make this more general to
catch KCSAN, KMSAN, UBSAN, etc:

	(?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller)

UBSAN does not prefix itself with "BUG: " like the others:

$ git grep 'pr_err(".*SAN:'
kernel/kcsan/report.c:          pr_err("BUG: KCSAN: %s in %ps / %ps\n",
kernel/kcsan/report.c:          pr_err("BUG: KCSAN: %s in %pS\n", get_bug_type(ai->access_type),
lib/ubsan.c:    pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
mm/kasan/report.c:      pr_err("BUG: KASAN: %s in %pS\n", info->bug_type, (void *)info->ip);
mm/kasan/report.c:      pr_err("BUG: KASAN: invalid-access\n");
mm/kmsan/report.c:      pr_err("BUG: KMSAN: %s in %pSb\n", bug_type,

But, yes, please, I love this idea. :)

-Kees

-- 
Kees Cook
