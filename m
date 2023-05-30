Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB2717199
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjE3XVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjE3XV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:21:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABA0E41
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso5676169b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488870; x=1688080870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gIVpjYFpxwY477D2q1tutyOoTXMzxG7tr6AvT0HGlgY=;
        b=jfJiBNZwCDcW0t1O+xpF1c2xToCW30Jz8zQaXHjwZTgxTyHxTvlnRlMS3kur7yVxTA
         MsGbc5Qg4jcc/wQHtewCT2WVDNSWx/XTbsvHXOHEpPVSBRVT851fe+vdKO2aLUcmV191
         eVdHck1oPB9Sm8/aZ10Xbe5SlbzQ2OUph9T3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488870; x=1688080870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIVpjYFpxwY477D2q1tutyOoTXMzxG7tr6AvT0HGlgY=;
        b=adYJROBKebCcDSk9PHoC4hfsqgCmFu8Vf7SuSlqaudft5aQzAlISEM2V5IJ5nKJJmK
         NyhgNlXlmvFSmVUylesnxMei39Mgvl4v+3UQkCQ/BISrumtBTd6hHhYZZ8ZeY2jRRL7e
         xwPPds8lflV9eIeScxQZK4/nG2jY38e77FjHtZ8Py2a1aKnTrTC5YljMzMHoTP7/Yue4
         kA4fE5nqTYkU2hnN7C2cEZT8ERJQnDih8cK5FraWDRUxscs2dPoTcXqHEW3PlyHgmRjl
         RbXAXRfUDddwk3G+phaOjWPDE173e5uxR4xWFMbFlliVpn9ECrbZyfIvU4wByLh188DN
         ETWA==
X-Gm-Message-State: AC+VfDymvhKy6gpMYsOK7E6haMaHmqzByRZTxeycT8bCWIWElk0aRRTY
        40KPC+tpFLt+IcAk+jTx2PAxjQ==
X-Google-Smtp-Source: ACHHUZ6a+iF8gO/7GTzwZBy4xcNB/leKn4ifXZOxeku9fKFIvdV+PoDEP3zi2aNr6sORHNSh/5I1Wg==
X-Received: by 2002:a05:6a00:a13:b0:64d:7162:9cf0 with SMTP id p19-20020a056a000a1300b0064d71629cf0mr4792726pfh.8.1685488870577;
        Tue, 30 May 2023 16:21:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c5-20020aa781c5000000b006439df7ed5fsm2184661pfn.6.2023.05.30.16.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:21:10 -0700 (PDT)
Date:   Tue, 30 May 2023 16:21:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-hardening@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] sh: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301621.BD4A8EA78F@keescook>
References: <20230530163041.985456-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530163041.985456-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:30:41PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
