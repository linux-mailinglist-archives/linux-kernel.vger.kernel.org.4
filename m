Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BE1738E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFUSKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjFUSJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:09:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890B1992
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:09:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e6541c98so5128624b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687370970; x=1689962970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpKS56YO6XbOetsyWxaBSPZDOmgSxMxVtPPYv6jOKso=;
        b=WpfCWUZeinWi6yBfOIp9eK9fHXs7y3W3CJxsQtCSOL+9ZJwB0cQtVvWzl3ZSl5sepC
         i8YdFlaS/9XV2Wg82MTORgTzlKtBK9L3i4E7/JP/EspwhuDiKhg/9DOf/2Ze7SBCgZUr
         JH8SptsFhYYmhcpQYU+FifKw1N6djtiAHyt1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370970; x=1689962970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpKS56YO6XbOetsyWxaBSPZDOmgSxMxVtPPYv6jOKso=;
        b=OgS/GobyoepRWJixoCvhJwhIB6nwVXo1JjyaTnDmWkzyljOFYd4ofN2MA66YFUxnX2
         cObw9Ovqeuh1AzqRX5oXRkhHVXbwDFeGphzjdSjtZ0xeBQiv3I8hblvk3XmNIOPoPoD5
         9RCDUWVWTqFUs9KsFwltI4fqB2j1zhPX3ZMaJcZ5a0ex0wTgLOWIjv6XjB9QU+WAV+Bx
         m7aT0N8RxHns5WFLTkC/DFsMIvc0pinyl1uwZ39H3/LXW9usjsByl05XHnfmxpc2/r5k
         807QOeE0QqEwflviuRG2zd/cOCa3djfET5PHjQ5KgQ0mSA8fL9xIPRWqyLUk5Whx1zSt
         FuoQ==
X-Gm-Message-State: AC+VfDzLupPz5qrbCQARiSsxO5+WjIPGDjJIliKBpYs5QabFCsk0aI8Q
        KNcnJ5tnf0oUOYcIhkjhgLl5tw==
X-Google-Smtp-Source: ACHHUZ5FjO//3o1cxickEcjMVH4iLi4UrTcCcOnvUfVCxJ9QqbIqUza86v/28jUXHMQakR8a5uMsaQ==
X-Received: by 2002:a05:6a20:429f:b0:122:24ed:f77e with SMTP id o31-20020a056a20429f00b0012224edf77emr9558877pzj.33.1687370969818;
        Wed, 21 Jun 2023 11:09:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b0066883917159sm3191586pfi.79.2023.06.21.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:09:29 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:09:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bodo Stroesser <bostroesser@gmail.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: Replace strlcpy with strscpy
Message-ID: <202306211109.1D5C9E2@keescook>
References: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
 <20230621030033.3800351-2-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621030033.3800351-2-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:00:32AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
