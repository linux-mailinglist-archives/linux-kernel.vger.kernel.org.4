Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD77049BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjEPJxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjEPJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:53:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC56120
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:53:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24decf5cc03so9526593a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684230812; x=1686822812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tyBrBVnNr2SOCdaFWqHhcOXYMqWOw/MP+dWIFM1LTtg=;
        b=RclO7+etUaKAQjyZ1S8NsH+uIH632x2W9GFsGzLA3xsG7SzNK1aZbCM4M4P98+udqJ
         2EQErGfPB6nY+nSqePmqTMC4eRNLjVsyIrS4SHE6kgeKkDYVXhC+ptO8w4xC4VBwX8Aq
         UuIeIHDkDx5bynCZZEGpRa4bh/ORInxwhZOho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230812; x=1686822812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyBrBVnNr2SOCdaFWqHhcOXYMqWOw/MP+dWIFM1LTtg=;
        b=HeWZ59tqaa9r+fzubuqYmppNAP7hi1H5HZI3TElUApCRj1Pa5WQ4kUZfsoRIHo4juw
         Ru7Qj1V8rjaG30V6OBpbL0CI/dreegO7tayPWPoApBSr18DXLAFLutQ7BstLvD441gaa
         gi86z6y9kFd3IV/JSPLsur4lGOz89P6ebStb7OlErob84mbuusE9KMHGUL9tdDC1M3cu
         Fsni1wksm8snJITiFN7FSpqK/J8KaFOWSCK4ymA/qmyuOIsavFmaNMm4ud/oJnIdo9oG
         TvswzwYIjcUQrzFPqHwh0p6omx3WlGgszAKg9eTIJ/4wZXyLVFLgnpQvuljj3XAX56Og
         oGng==
X-Gm-Message-State: AC+VfDxsPgWIMlVqtPEk9LSDf3d9crV2F0GGysn+wJHCfbfOW2QGYTgd
        u4RFwg8+m2guJxjwhs2J11t7vgRHkEgG4nmZnnE=
X-Google-Smtp-Source: ACHHUZ6LeeP0sZF5pT75U6Di1ecCjIy1JjV7dI1uuDuaneUFbuVZv/3N/htzsX9mSjCLivc2hr9bPw==
X-Received: by 2002:a17:90a:8a8d:b0:24e:69e:71f with SMTP id x13-20020a17090a8a8d00b0024e069e071fmr35185215pjn.7.1684230812057;
        Tue, 16 May 2023 02:53:32 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id b30-20020a631b1e000000b0050bd4bb900csm13150378pgb.71.2023.05.16.02.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:53:31 -0700 (PDT)
Date:   Tue, 16 May 2023 18:53:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, senozhatsky@chromium.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1 1/2] mm/zsmalloc: use ARRAY_SIZE in isolate_zspage()
Message-ID: <20230516095327.GA15689@google.com>
References: <20230516095029.49036-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516095029.49036-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/05/16 12:50), Alexey Romanov wrote:
>  mm/zsmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 702bc3fd687a..f23c2da55368 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1888,7 +1888,7 @@ static struct zspage *isolate_zspage(struct size_class *class, bool source)
>  		fg[1] = ZS_ALMOST_EMPTY;
>  	}
>  
> -	for (i = 0; i < 2; i++) {
> +	for (i = 0; i < ARRAY_SIZE(fg); i++) {
>  		zspage = list_first_entry_or_null(&class->fullness_list[fg[i]],
>  							struct zspage, list);
>  		if (zspage) {

This patch needs to be dropped. We don't have that function anymore.
