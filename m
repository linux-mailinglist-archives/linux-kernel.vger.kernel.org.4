Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1185D7071C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjEQTPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEQTPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:15:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10046BD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:14:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53033a0b473so777030a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350886; x=1686942886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I86GqiU0YgzZjcmQYbWuXd34tQJA/R6gUQrAR3Ef4Vo=;
        b=a9BUGVeBYF7ixWNiY98NX+YR8nMPaRDXPVrEzp1DMOAcTrHdtsQyseNqO7cCzSPHTq
         hkxCLO4A3OLziF1E5Do+xEwfS6rY3QOBEJhYNvKI/HR4Dcbr96g7F1da1HYOhN2+UEgp
         ebtEQun6/IpF4T2lpL5yftuLBzWRT4BZG8O2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350886; x=1686942886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I86GqiU0YgzZjcmQYbWuXd34tQJA/R6gUQrAR3Ef4Vo=;
        b=W3j+FuWbW0vMFTaInk5cc9kJncQ8UY/AgovsB1Su80N4hOF+Mf31GqNdS8p/KeMgOv
         wJzeFNqBoEm4JYH3xiu2pcBUx0i0ZoDK8LdRXeUU6zd2+y5y2tzGYErA3VAG0pVZrEn0
         B+AKHNd90qZS5q4kmyThTWqBj1ECAsrcmrN8gzgzv3KOVJreX0WkcEB1AogeOrFSLP4E
         9HztOxmIgXCgsxPhuFsUuHVEFDyCIxIoS7ZHBBcSvzizBdkpC71cpV7h3VhtCirwk4Mc
         K1RaFGycErlignfqQMsOXY0k5FJGIvwaLAJw3Fw/BBU1RVBzlifVyPohMA9XLJMoZJi9
         FxxA==
X-Gm-Message-State: AC+VfDzhZKhzR2ZmeSAkeU+5oAPaSIjpu8eLBJQ4OZGE2ppM50ODvoLY
        kSnmwhG+hPSn1Q92vKBoowpfsA==
X-Google-Smtp-Source: ACHHUZ5k47l/bNRLiG9PgNcNSBM86j3ELSgSLeMZf8fFyVeviUlMsarseItJaDwcgLfSkjvALPfISA==
X-Received: by 2002:a17:902:b594:b0:1ae:3dcd:30fc with SMTP id a20-20020a170902b59400b001ae3dcd30fcmr5365858pls.11.1684350885863;
        Wed, 17 May 2023 12:14:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c08600b001ab13f1fa82sm376964pld.85.2023.05.17.12.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:14:45 -0700 (PDT)
Date:   Wed, 17 May 2023 12:14:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Replace all non-returning strlcpy with strscpy
Message-ID: <202305171214.3D13652AC@keescook>
References: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:53:23PM +0000, Azeem Shaikh wrote:
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
