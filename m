Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808A55E886F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 06:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiIXE7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 00:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiIXE7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 00:59:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57B15101F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 21:59:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so552081pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 21:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dRtKEJsROLYDM0ai30/aDS7BiCQYcoHjmOi4Z2q3irc=;
        b=Cy+/NTZVkooL+DcEtr3BQFdm2WFzRQb0Q6k9A1FT/tze6Z8ELxxWtK4k9Vt5aCLLHI
         G5GfpD7+zydKxynimvkrn6mvFiIbxZA+FEAYXRyy235O5bt/Nmp4J//w6hdQztOWwn0c
         q3T7G+8LSpoeeogTIurjnWfChd0R3NYJgtacY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dRtKEJsROLYDM0ai30/aDS7BiCQYcoHjmOi4Z2q3irc=;
        b=tPJPiR26UHDxm62leFzWZKk/vfbalp3fDdxEM4J8/10aMqvDT8oAjZPgpan82qec+g
         yHTTuQcx4gsk7V9NDHhevpiEd24Yw/fqPh+oocELEyolF+1vfUogNpuxSI3z32TXX04L
         Cln3LvsH+mh5jRToUq8Nz9m/4K67LTsekQ/rIzad9IG+8dyruQ8PTUq3JTOOGipY/gJa
         J5FBt8+65+gyOZ4mVLwDihcNw4t2W1ymoxUdWsUK16SyY30PtgfeLkf5Uql+C5Rtb43o
         dSHlGD1wiB3WXN2/vbADpur3w9yuLSko17d7VWdvDMPH0HepZZtvY+/KeGQIoeBosIP2
         mr8A==
X-Gm-Message-State: ACrzQf3RoFIi0HUgWTfIoQwRyRKqBdoePNtl/cVreAP6aF3gqT9gu9Y8
        +t4oHacElNXmyrss8nxy8NtAlg==
X-Google-Smtp-Source: AMsMyM62BZwEq+cDnFHoakCXh9XB9TybVKc5Dq0tldhGOoH1AK+Vi8gTajzooKthyj2A8ZL4TGP4fQ==
X-Received: by 2002:a63:90c4:0:b0:438:a962:61e7 with SMTP id a187-20020a6390c4000000b00438a96261e7mr10288335pge.426.1663995560635;
        Fri, 23 Sep 2022 21:59:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b0016a7b9558f7sm6924724plg.136.2022.09.23.21.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 21:59:19 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:59:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     cgel.zte@gmail.com
Cc:     herbert@gondor.apana.org.au, bbrezillon@kernel.org,
        arno@natisbad.org, schalla@marvell.com, davem@davemloft.net,
        gustavoars@kernel.org, colin.i.king@gmail.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] crypto: marvell/octeontx - use sysfs_emit()
 to instead of scnprintf()
Message-ID: <202209232158.65A31224@keescook>
References: <20220923012952.238269-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923012952.238269-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 01:29:52AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Thanks for the clean-up!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
