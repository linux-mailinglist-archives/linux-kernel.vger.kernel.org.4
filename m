Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89BC611992
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJ1Rpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJ1Rp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:45:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD3E4F3BC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:45:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u6so5433914plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sq+4+K8W7qz9CqdPYKGdGPJUiIj89nYCMsj4hrq+PXE=;
        b=Qk8LjvSnKQ+nIz7iqqSWHFadvUV7NzJ6KPQ1r3p/lUiuWBKuG4/YdTl8U2LDkwWWQX
         ZTdEZPBQv33zkr7IS54F9tB+LCHpxqUrERaqe7kqttssTQmiUT8DJ26n3dEcMAIJPPmw
         2uAFLRTwFf+091cseHU88g11bR5cZGAOVEfyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq+4+K8W7qz9CqdPYKGdGPJUiIj89nYCMsj4hrq+PXE=;
        b=SMAUf3dOkGJ4XPSIZ/MRLX1hzxHoPNwdjpxbqwxBgUyUNWaxO4WykMNXhbLjm3rvdq
         AZs+ffxH/g9q01YDvcaOtJOUO/Clc/FU67lfwF03kaRYY8epn/qAz+2i943F7j+Hu/Hp
         akZAhTx/DeiFn97E/7xfPpnzNdiJ4CTelVWVniUEldyUR42QbgB0k5iHWndDS7Rny5qd
         wRc866Z5lrYBoBaE/ImQLF0Tz5FNv+naWZW3uEV5YISSb+8SBD98fMlHmvrN6MUCINty
         FDV0ySLgV66d2oSBQDAF+u4AHT5blPHusRYrJK5gozGl/NEkDz3+ss+ZpsfdFPKSXlZB
         PW7w==
X-Gm-Message-State: ACrzQf3vlHMvjgwQWqsC3MVJ+3pLrtD8b+y8K7I3piYyqrroc8tqNJ/R
        TS5QznBoqmicfTkUCaW9laroVA==
X-Google-Smtp-Source: AMsMyM5xMG3TVG7u/78SN5J7HmVo4/yAWKlp64gxV3zMh7Cx/cWT4TaKn1MTwMTg+/YXh4xKD0Cd8A==
X-Received: by 2002:a17:90a:cf82:b0:20b:3525:81ec with SMTP id i2-20020a17090acf8200b0020b352581ecmr452552pju.42.1666979123537;
        Fri, 28 Oct 2022 10:45:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090341c800b001866a019010sm3368538ple.97.2022.10.28.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:45:22 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:45:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v1 2/2] kselftest: vm: add tests for
 memory-deny-write-execute
Message-ID: <202210281043.DFC05DEF@keescook>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-3-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026150457.36957-3-joey.gouly@arm.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 04:04:57PM +0100, Joey Gouly wrote:
> +#include "../kselftest.h"

I recommend using kselftest_harness.h instead; it provides much of the
infrastructure that is open-coded here. But yes, testing is good; thank
you! :)

-- 
Kees Cook
