Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB66E5EB3FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIZWAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIZWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:00:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAB89F0F9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:00:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b75so8013284pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Z+V9HKEzE/RCD+QuWbpkWnuj/UNSjdfJYogyydpcU5E=;
        b=kdUvjIZklCh7p0dy2cbAnFPWMnaQ9KU6pSVxgIsJWiq+Rg7+dTzBAtFdhyUWV/brDb
         IpNU0HceJCKIFZWASfKOAiuYPFrkk0Borpnr6U537aRJejJsQ1FDpSlMfPthP5MEWXSa
         tH5lEPrVqifpJ/Q2B8PMTZfLFiNA71z5Vn/X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z+V9HKEzE/RCD+QuWbpkWnuj/UNSjdfJYogyydpcU5E=;
        b=px8f5oga04xMTowlt2GBf+7UVazSPB6z2rThaRfwIiI78ssCP63hh/2FDuokGUUmP9
         R2S1d1q+nG5ZfD0WXpCk9VSnCcISm7pnKH/Ofpg4Z5H4b8EWNDhVVlU3E4CXlEILdi4k
         q6SvsAjYhdMuywEZDoHd71J+GbCz1vFCjoizcXxdGez3nJPo+gAzQySWCKIBzMx9p+EZ
         vPbDiJpNMqn1SRvPzuGJ+Wpmg4eFh6DDn/TRAtLUGAfldEQGiTZViXZP01MLylKBl9r2
         HeIRxcIfC3ESalHPnqHdPYZFkzx6X5TwWNtiVfNmVfQ72HLeVdJob6d/RmSyUSJnXSVs
         WnJg==
X-Gm-Message-State: ACrzQf0I3aoVd3b41EgYMYpswep+h2oNsTBvrRqVeducxwHZyg6lzea+
        Q7bfoaKRie+/fiyJ8NlpuAF/Aw==
X-Google-Smtp-Source: AMsMyM6EH3TLoP5Ab4HNfRJxhe6hu7QGEmIFxPc9r5Y3xSUNCHlUgH+CVhBdd6e51YbiFdKv0fGl0Q==
X-Received: by 2002:aa7:9e12:0:b0:53e:27d8:b71b with SMTP id y18-20020aa79e12000000b0053e27d8b71bmr25834865pfq.46.1664229619477;
        Mon, 26 Sep 2022 15:00:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a24-20020aa794b8000000b0053e6d352ae4sm6408pfl.24.2022.09.26.15.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:00:18 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:00:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261500.B594CC10@keescook>
References: <YzIcZ11k8RiQtS2T@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIcZ11k8RiQtS2T@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:40:55PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/211
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
