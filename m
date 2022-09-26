Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4149B5EB40E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiIZWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiIZWB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:01:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C999E62F2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bh13so7764889pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NT8F/Sj0Q9yRmFZyi3XfPWnAIOXfMEUrjgewG27HyFQ=;
        b=fG1qXK+12aDUGiqFjjOVulomtauZVkrqe3h5VvQdj+htLs5ndcJc0MdCDW+x5UcrKn
         +lcSzfixuuBRg6TR4H06W6f12YdqwR6ooH1yFU/iPC/F1VPkCdt3wyLOsZZwuGLjvFd1
         VzTQPpWPTGPrSs8uJT3B0igrvLR7gppRnrVAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NT8F/Sj0Q9yRmFZyi3XfPWnAIOXfMEUrjgewG27HyFQ=;
        b=mwK+tSa3uYGzZelVAEQ3tneojIyS5HJfbTe5mkCfGeWHzXtzXzjT4Ul84Xs78YdB5e
         T3v5s+ca3dVMDpTVvpTQ7Z70YAJskitt0oUmYIU29/ZtVzYMLroU1irAl27tMoF//E0n
         HqmfJpi8sbAM72oYEmC2THlq7Cp+++1kSjT3oEqgywid8mEpGDT/r70ajf19Te0aTuzk
         U4ibkb8khbyISguApNtFndVQiQF6nZgKne/vE1zMiTiPUpA0Gzy/h2j7HuVeFb66IzTe
         +yAMTjL152Cd+/HPJDF/URmc2mKqjNRHzD5biRNdfEvqvUcuFecMzCuJJMfqRM5+pmfv
         hX9w==
X-Gm-Message-State: ACrzQf0DFvzhtbK8g3EOsyaEEgSp5zBfbnvBist1nISQkH41aIP1+gTl
        RN8XAXRdQWVrVtgfw5KksErPxA==
X-Google-Smtp-Source: AMsMyM4y9lezo0/S2wIwtV3prmWvVTnyikbgsWsF5HtyKR42X3AVNNebI3RAI2KsxQVWW4FtvnHm9A==
X-Received: by 2002:a63:6a03:0:b0:43a:18ce:7473 with SMTP id f3-20020a636a03000000b0043a18ce7473mr22561085pgc.616.1664229713937;
        Mon, 26 Sep 2022 15:01:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t7-20020a63eb07000000b0043a0de69c94sm11034189pgh.14.2022.09.26.15.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:53 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:01:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: sh: rcar-dmac: Replace zero-length
 arrays with DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261501.E08CDA4@keescook>
References: <YzIdsJqsR3LH2qEK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdsJqsR3LH2qEK@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:46:24PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/217
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
