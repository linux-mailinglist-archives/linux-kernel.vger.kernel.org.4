Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27415EE3C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiI1SB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiI1SBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:01:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4B5100AA4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:01:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a29so13203435pfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JdaNct/G2JycPe4ErZLD0bdcxF7sV3x5ZSzi26f0LVc=;
        b=g/UF8+sjAIowCdq+SbQGgr58qUNEKqBINYp4gqmYRYyPJljH+zWtiS21cPbYkdN8t9
         aYtwiPIvqEad/zl6L8HgmGt1e7rIECz71QbIFeC+3JrKeNwmiec4liXTlqqnVUfUoFYt
         EMF4+V7VxUx8Ss7MtYo0k8hUOUMHmOU3bN6Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JdaNct/G2JycPe4ErZLD0bdcxF7sV3x5ZSzi26f0LVc=;
        b=eoIZs1n40ahmk+LTn6EyA9Vb0L11iITcBNMMC1f+fy6hjNBo+VXYxrMNmZGl/Zj58G
         13K1DBNqPBzJO3l6BhlOP4Jk/xEDCXvNPFUxNJijojVmyIQzktORZPCwxmIZ/nKeVuho
         S+QMUBEXEoMzwHcOfOTx/61K9zzM04KduGaTjJYkqH/bIHj4InGBSd6DA/tpomFo3xWA
         HtmTgc9ycqxMizdAJ2+0tmH819rKrKiqBHi1yhACpnOXDVtSDTS5zmDE3xXO0iJ3OxuB
         PVStLBI6t2ngyOSzkELNmGpoA/D5bn6Kmv228eqMwRDFjp+XLR0k/K+q/qs8fTLRk0wE
         FQpw==
X-Gm-Message-State: ACrzQf0j4hYuzyqY5AwVCpjMZM8uOr40EFIUWg41Vc6SlgO/qHWO/KS4
        HZQnPyQRKlB9cv2Y0NhvBkYY2w==
X-Google-Smtp-Source: AMsMyM6F0wUKd7/8qdqNwZVIIaRh5M4pwKa8t+qDZ9gM0fXutw7SwWVeHX0LkCx4/OjjgR/QVrS9YA==
X-Received: by 2002:a63:2bcc:0:b0:434:eb77:28a with SMTP id r195-20020a632bcc000000b00434eb77028amr29658693pgr.168.1664388112280;
        Wed, 28 Sep 2022 11:01:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b001732a019dddsm1822508plh.174.2022.09.28.11.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:01:51 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:01:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com,
        william.zhang@broadcom.com
Subject: Re: [PATCH] ARM: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Message-ID: <202209281100.5311EE081B@keescook>
References: <20220928174739.802806-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928174739.802806-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:47:39AM -0700, Florian Fainelli wrote:
> From: Seung-Woo Kim <sw0312.kim@samsung.com>
> 
> To enable UBSAN on ARM, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
> from arm confiuration. Basic kernel bootup test is passed on arm with
> CONFIG_UBSAN_SANITIZE_ALL enabled.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> [florian: rebased against v6.0-rc7]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Ah-ha, thanks for testing this. What devices did you check this on? I
know boot-up on arm32 can be very device-specific.

Which UBSAN configs did you try?

Thanks!

-Kees

-- 
Kees Cook
