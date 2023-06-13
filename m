Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB53872EBF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbjFMT0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFMT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:26:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366610F7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:26:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3031611a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684389; x=1689276389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+SosEkKxrJ4iAWZXd5DjfQpM6I+3FcUNGS4ZB6BQj4A=;
        b=JdzTuCqkydZaMrlBB6HTchxSO433vMvvLmkR4+JQpTxqGXNu1MkqdKezS1kWnXeC1Q
         grWqoJ4OFbqkQarU9txPOzOt9IXUAlOrWIE+XgJGBzLtDYyifdcngX8QR/fZVRlL/+vX
         rDkjGqQQ/sbh8tygrKUmbTadtIv4M6LPXRaLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684389; x=1689276389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SosEkKxrJ4iAWZXd5DjfQpM6I+3FcUNGS4ZB6BQj4A=;
        b=mH1HZ6t9zctxi/4sMBb75TUgsL26uyy7dI4sN+pI83KnGc0qarAzc98RluPnHYU3Vu
         R76h3Yz50J2naza3DiHuIrDp4R7sdzR/QOTIH0RlSQPPFsihLIsGZ6rsfv9FC/gArjsE
         WzoFd4nmKTvXZxANTIJBPvYwQP/UjerFEEzRTY8jT5OLv2hVC3269nTvibVWT6YDcojy
         nPMFZsP+1mXl95WgkAK6HWqjl61m1P8hOuj/g67UDHr12DcPxvKXVM2leueFP9dm0y4e
         uTfvi+B85dz3gphaby6zNQQFFo/ePf/UJZLIlbJJv0rBLWq/eXtY/aNyxKgtRcGiRR++
         vM0A==
X-Gm-Message-State: AC+VfDxc740hG98mvr0Dggpj48v1+aRbS+72P9NSx9SDYhl3deYLytk3
        uprU8FIuR7+K2aEw7O/Tb9QIwg==
X-Google-Smtp-Source: ACHHUZ44VzTwH+0xXpJiQxXjGR6yiAwRkrzjcnEdzxWQzJhz/bD17uN1IGN7Ir14/V9fVnunMHnE4A==
X-Received: by 2002:a17:90b:4f44:b0:253:727e:4b41 with SMTP id pj4-20020a17090b4f4400b00253727e4b41mr10151302pjb.34.1686684388826;
        Tue, 13 Jun 2023 12:26:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s64-20020a635e43000000b0053efc8ac7e9sm9724096pgb.29.2023.06.13.12.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:26:28 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:26:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        linux-hardening@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] netfilter: ipset: Replace strlcpy with strscpy
Message-ID: <202306131225.6EADAF4@keescook>
References: <20230613003437.3538694-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613003437.3538694-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:34:37AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value from all
> callers of STRLCPY macro were ignored.

Yeah, the macro name is probably not super helpful here. It seems like
it should have originally be named IFNAME_CPY or something.

> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

But, regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
