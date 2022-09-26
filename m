Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649385EB408
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiIZWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiIZWBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:01:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC1BDF05F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso8262336pjm.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cwy5GYd8Dih14UwvwShPmCNz0QAIoJi79OciA/VYVJI=;
        b=dJR17a7Ct4TbA+qmnfIAWKuT4kiKvu439jsP/3qW67iCancIZqKV0UP7bDw7eDJ5KE
         4QlBNhhrMIHTB6AMbclxjdavsP+nctpOT2lMWMWD5TpY4qa/G3EML5ita9DAe54UCnkR
         a46WplXriSCVp3+Q/J7jg9xnmquuuFHQaAMQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cwy5GYd8Dih14UwvwShPmCNz0QAIoJi79OciA/VYVJI=;
        b=W2PSYJda3sACiUao4UQ5PtXSuogZE+f8WRPdGBoGV+M5Lpp46f0dTmN8mwttAYQhFG
         QJ1l49euvrDVQI+nv26/Nqp7vtvZdggJ2ByKPA0Plrzf2Im/cFnC48T6KxqWuSjI0Qaa
         WcUeh+sQglo2kfwFNpnM1LIW5edHcVuvv2pXnejJQc/+5E1ektdGPpD1b3dot58TIHCt
         pCm2UXcCN839s5fcDwMTRWRBZWW+53RN7DFph77rW2M+iIbROloO6EAqBi0tGM4iNdkv
         SxUTYJLYOrSoM1l/G8yeBuxzlaIrUAwYZtGgqezXPb636DqdyEdv3L5r4EHHsjm7pWwC
         Wkyg==
X-Gm-Message-State: ACrzQf0w1dMJLwcbRUwPc2ID9QmwSmaI8v/eBLdV9csrDH9mb2DYv6Nu
        fG7V5j+7y0zAIK+uvCyleWFkTA==
X-Google-Smtp-Source: AMsMyM64nw0QwPnYBVhr8wkQ2W4B/t9MdaS2y1Q0lHJKsoI1ufso/FQpWXEXNJO9lqYED/FVqRf2zg==
X-Received: by 2002:a17:902:d88a:b0:178:e0ba:da21 with SMTP id b10-20020a170902d88a00b00178e0bada21mr23746398plz.139.1664229690634;
        Mon, 26 Sep 2022 15:01:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jg11-20020a17090326cb00b001769ee307d8sm11764542plb.59.2022.09.26.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:30 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:01:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] carl9170: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261501.31320B5@keescook>
References: <YzIdWc8QSdZFHBYg@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdWc8QSdZFHBYg@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:44:57PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/215
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
