Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BC5705862
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEPULU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjEPULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:11:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B56EB5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:11:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf21bb42bso581725ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684267877; x=1686859877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLgrvnIbTez+ozLofGFvlDwgzYOgc3jwqI2qiIMZDlc=;
        b=fwxxiq7jxyRdl/2cy/Sv+GQ5mQiGF2Lstfp3s18yImRvFgABuVehmXn56JwCzbRdhQ
         KKufXmevtlLM+BTCz8VLc/cV+T/YAzLqsHnyHdPBjeUiw9eAvpKfIulQlnKV0CKwMsFA
         jKjaL6cYIgkSXEiU+Ok8enWf1b1VtTDsVqZng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267877; x=1686859877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLgrvnIbTez+ozLofGFvlDwgzYOgc3jwqI2qiIMZDlc=;
        b=Zc62Limcd/R0Yx1LQeFY/nzyMh2XOXZs/XW0pvaUOBTCXwcb5kLs62obCsZxvTBTAS
         wfCxrtCtVdrrn6xFe3C00Qx9vK5tWvDRTZVm8DPmnB4SK0k3nNEvDhWAraJUqfNzP2/k
         UUcfdP+YsxSz45XUOTpm7nWeXWtarD0G7v1TnLnpZSXtCheqUB6abIdizIg1jHKfjXbm
         9I8UWMDVBgivBV6mPt0+S5YmDgXaZm8TjTh9ZAtMe1HvuaCDBhUEyQjsf9VHFKRWdO+4
         OpaULvkdoBt6AkpXFRdqN6+3ecxeprl+sbAKxZYvNYxd+NPSvyK0B7C19gfziBl0fMLQ
         fv4g==
X-Gm-Message-State: AC+VfDzI142Vc+DdAtrnlEbWhseeckhJmIikrzYMnIn/p6cX5pYKtvHz
        /l8SaPH9MV97D6Fd76NoAY/A9A==
X-Google-Smtp-Source: ACHHUZ77IQniMgR4Y8NUBFcCMRu/KSrWXIuCgUNNDXjyikpYHkbmnL7WvFx0Bd2z/BIHgQdZGCLeMQ==
X-Received: by 2002:a17:902:8c98:b0:1ad:be4d:5dfe with SMTP id t24-20020a1709028c9800b001adbe4d5dfemr21153767plo.27.1684267877266;
        Tue, 16 May 2023 13:11:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p15-20020a1709027ecf00b001a1a07d04e6sm16019154plb.77.2023.05.16.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:11:15 -0700 (PDT)
Date:   Tue, 16 May 2023 13:11:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305161311.0A9B37E131@keescook>
References: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:39:56PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement with strlcpy is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
