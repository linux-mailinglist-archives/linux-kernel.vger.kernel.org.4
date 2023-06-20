Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79577375E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjFTUQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjFTUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:16:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFDF1FC1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:15:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-668689ce13fso1753433b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687292117; x=1689884117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugg5Bn6O5nwawhDuTl20N+YQmkiNRZWUsdUMwl/ozoM=;
        b=eisvxZmVwycNuQOHor0Vhx2McMYxaUxYRyBHGhZapsWz+dARtltTBA9muZw0VNx8O5
         KI7Cnhbi7j+8/K/SRnIj9Mp9UpWH3l/vApI+5jovdL1d3YtofCxK/0h+5RAC8vKW0MWQ
         ZjgoYQS62LU+Ci7mZEGBpePdyojjDbX60jhH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292117; x=1689884117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugg5Bn6O5nwawhDuTl20N+YQmkiNRZWUsdUMwl/ozoM=;
        b=JXnnY5irP2vGPA5egctWo24RAz8MN3LlD9W38Gb04rdVZykAO4vXLl8OxhtBMOuFsc
         vcY/mULSFk+n2k4nvJ8AFH43NKdUT5W3Wbz8cUCH7xlIknJH8Vu112aYKHKT2Bc0UK6H
         JlGYyF1OLKjWUiFxvlPuLEh7Pp8Uo5G/pThykFRvZvG8F+x/O/S4lf2knsiAmfJP//VR
         oH0ZtovV+9gia9DWTxXiqGFECP1Ys7+nv0LO0r+zxm0H/tHBtiMnwIduhK7unWrCa/Sl
         GyWLnBGQT5ScvwL5YJMp0Fh2WZ5QpfHTrnLErZYRnuoD6m/XHdS1v/C/vnXGcwn2C9ML
         xVww==
X-Gm-Message-State: AC+VfDzBMDI+Cq4l+YHx075l93HtVYd1N/PKbz33XdosL6JxZX1DHW5x
        vcYreLdWmCBk6mui1CEnDyK5Aqd9s+4HnSu6QM0=
X-Google-Smtp-Source: ACHHUZ7DHmliAxTvQVIqBr73bQmGkR82MdiWfo2PN+3zZtYfizCQt7jsEa85Fp+cEDXJ6T7X+ljRXw==
X-Received: by 2002:a05:6a20:394d:b0:122:2bc1:8855 with SMTP id r13-20020a056a20394d00b001222bc18855mr4355231pzg.10.1687292117365;
        Tue, 20 Jun 2023 13:15:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g11-20020aa7818b000000b0064fd4a6b306sm1671184pfi.76.2023.06.20.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:15:16 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:15:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nios2: Replace all non-returning strlcpy with strscpy
Message-ID: <202306201313.C425BCB@keescook>
References: <20230530162358.984149-1-azeemshaikh38@gmail.com>
 <202305301620.346CC541@keescook>
 <45ed31e0-9ecd-56ea-c0d4-3c68a3fd8cf5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ed31e0-9ecd-56ea-c0d4-3c68a3fd8cf5@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:15:41PM -0500, Dinh Nguyen wrote:
> 
> 
> On 5/30/23 18:20, Kees Cook wrote:
> > On Tue, May 30, 2023 at 04:23:58PM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > > No return values were used, so direct replacement is safe.
> > > 
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > > [2] https://github.com/KSPP/linux/issues/89
> > > 
> > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> Applied!

Thanks for taking this patch! I just wanted to double-check, though; I
haven't seen it show up in -next yet. Is this still queued?

Thanks!

-Kees

-- 
Kees Cook
