Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB041717189
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjE3XR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjE3XRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:17:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4605C19D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b01d7b3ee8so31269225ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488663; x=1688080663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kMrqqORy60OYsKh+0hdgGppzkT4bCtjtqNCdTA8b/A=;
        b=h8gfttxwxyKja7yeHzvx8964FyoRcUtxJzUEEAWz3kHP6Z29hGrpBAwjV5rQT68jH8
         M7VC5TOW9EMruuJHT4rx/fIsHAQSSbWc0OYBrV/DAZq+XaOLnZl8wTBSRM6/mvWhaJY6
         4Y6XF2p5clZBwlQtdEsC5rRjCvi+PLSMz4qVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488663; x=1688080663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kMrqqORy60OYsKh+0hdgGppzkT4bCtjtqNCdTA8b/A=;
        b=CuU69p1KgYwz7FqrxiZLCBI266FYTBiH366hbbMUlnPr0tsyt7jn1ycAExO4ObgS8x
         oC7q5W5VdSie+5DPv4K9Md712yof7P1XEmDVg9Hj1mAiSAv+VddFUo49yuiRdqOVIJLy
         WZB3+hMxHBfvNvxVphbfm77r/5paxtXQFfVmqCCpz2G8Pi66ziGJSBwY3QpHzyuPoD7+
         OLuWcFTXbRae0UdwdfUsOP9AZ+slWkXSxlQjLNihdfDHatnTSe83SCr9GwhWESIE44UX
         jomMFpoKoybpc7Cq15IJkUWeXOEirv0vrINiCu+h8XWuOfsZccHEl2usHgUXnwQfBW4s
         KyMA==
X-Gm-Message-State: AC+VfDyw+8c9Y3kgw9ZvUkwFmhuo+vbMWrZXOzjzkXQ13iLLVyYT7G1C
        KSXS0yWjAHkzyUkSiPCWqO1C7uBHCp1VsEXIkPc=
X-Google-Smtp-Source: ACHHUZ5jiwQCWBkrZz3K8KqplAJMedpRiKJUVLueKQvFurMiNQqwvdcBK+jbpJ5mg02xOxUhtSPJoQ==
X-Received: by 2002:a17:902:db0f:b0:1ac:750e:33ef with SMTP id m15-20020a170902db0f00b001ac750e33efmr4403319plx.3.1685488662885;
        Tue, 30 May 2023 16:17:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001ab2b415bdbsm10835231plx.45.2023.05.30.16.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:42 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        linux-hardening@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: Replace all non-returning strlcpy
 with strscpy
Message-ID: <202305301617.F508DC762@keescook>
References: <20230530160248.411637-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530160248.411637-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:02:48PM +0000, Azeem Shaikh wrote:
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
