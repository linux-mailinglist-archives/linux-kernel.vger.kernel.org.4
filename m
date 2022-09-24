Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162795E884B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 06:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiIXEYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 00:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiIXEYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 00:24:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21976155664
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 21:23:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1945281pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 21:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JwdiKuWAXIR8s1mqhbb5lF09zKLRfTe1ZSaNoLOpjDI=;
        b=oWoq2NjHlI/t3Diujc7ttYvYtrCisBNDQUTDlFoLB8VPZgvUALrsFw/OoDClOBR291
         AILumiFzf9WDEmol8HsZRTVubx6ntw1tPkflegrT3lFadCdSgeYJS+l5JmbMIxD+jXDy
         ndxSnBDjihGj9HljWl6R8G7MMPk8WgA/5phGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JwdiKuWAXIR8s1mqhbb5lF09zKLRfTe1ZSaNoLOpjDI=;
        b=5V3ovDgviYxlKjXhxVR0Ucutn5pLxi43JNNWQjMDWTn7EoVWFv2b8Tp3WC+srEKeOo
         pGqzw8QGv4/i10irEhynstEXjbku7spMRIq9JC50P7bdhlZEMQaOOkSK4ZRuzIBtt3zc
         IXjca8CDwXFqS35BBw9B8ZJiKs45xDX1504iAyZt0mhvygUxZE2pWKXF9ZgGdxppOx59
         /GwQCgqoh0e8CzeaDJzG3nhkFTE9nykTRDab2C9ughV9aIKcZGM8voGYZGzajU43I+ju
         F9b26/mg787OI0FjDCnA4tCoVUK9nW7mTEOuBUNmLoFWwGeZb1ziZYtGqdQJnXMSDoc3
         q82w==
X-Gm-Message-State: ACrzQf1rAzv6RHbdWUxNYm0XxVzDs3ZKVLU7Xu7MrgNSB3QoWqRAne8u
        KZPbR+J6mnX2YKN7BK7CsCzpSQ==
X-Google-Smtp-Source: AMsMyM7B40I/ueFyxxvn+uDhEdzY1SgeaoqoqTKep+usyR+Fzu79Zywg/YOiskfedSeS4h4RunuEhg==
X-Received: by 2002:a17:902:bb88:b0:178:24f6:4dfc with SMTP id m8-20020a170902bb8800b0017824f64dfcmr11526773pls.169.1663993377361;
        Fri, 23 Sep 2022 21:22:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q19-20020aa79833000000b00540c3b6f32fsm7227822pfl.49.2022.09.23.21.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 21:22:56 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:22:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Split memcpy of flex-array
Message-ID: <202209232119.E32C14857@keescook>
References: <20220924030741.3345349-1-keescook@chromium.org>
 <Yy58rt9N0+dHrNtt@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy58rt9N0+dHrNtt@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:42:38PM -0500, Gustavo A. R. Silva wrote:
> On Fri, Sep 23, 2022 at 08:07:41PM -0700, Kees Cook wrote:
> > To work around a misbehavior of the compiler's ability to see into
> > composite flexible array structs (as detailed in the coming memcpy()
> > hardening series[1]), split the memcpy() of the header and the payload
> > so no false positive run-time overflow warning will be generated. As it
> > turns out, this appears to actually reduce the text size:

Er, actually, I can't read/math. ;) It _does_ grow the text size. (That's
2_3_ not 22 at the start of the text size...) On examination, it appears
to unroll the already inlined memcpy further.

> > 
> > $ size drivers/hv/vmbus_drv.o.before drivers/hv/vmbus_drv.o
> >    text    data     bss     dec     hex filename
> >   22968    5239     232   28439    6f17 drivers/hv/vmbus_drv.o.before
> >   23032    5239     232   28503    6f57 drivers/hv/vmbus_drv.o
       ^

-Kees

-- 
Kees Cook
