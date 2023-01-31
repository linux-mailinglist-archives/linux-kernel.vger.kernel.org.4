Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9121D6835CF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjAaS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjAaS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:56:30 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13871564A2;
        Tue, 31 Jan 2023 10:56:28 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h9so7446785plf.9;
        Tue, 31 Jan 2023 10:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo+PP5rZvWzLJ4tS2JVrm/BkjseLKTB/pXjSiJS1fiA=;
        b=NjNUfeiwVedY7ijAaJxzQFpFTTobwOPiU41FJ5iXy/Wq+F5e9+LGe+pdUQEY6vlBEP
         qEp3Qd9hK3vgULEWl28bIZWr7dpCCiCCIIhWKx5oYwh+6mqWsPgJtkvgDjaFsVMSmIBD
         bi6XJqZCN0gZk22ObkHTTLAr4UWh4W6ovLJvc0WDQNyiDBlAhK9Jfezh5T+sb5b/QanF
         b8Wl+Qd4LeMTml7+WbLs/erEBn53MSL04J8HRJBnKVCL1xeeGYhYj6XKN09HS8Vkcr4P
         qE3ZxCjABT1vjVgmYvJr7UoFu5L7FdeQ+Uw9+qFjRUBtZyl+hWmqaoFuNEaORtoUdpvU
         HXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vo+PP5rZvWzLJ4tS2JVrm/BkjseLKTB/pXjSiJS1fiA=;
        b=f2xS4KwCRHAqrsUm1JxGeacLX2fOJWA9uO+gEep0wc87HFO9Y4bfIQwwxk6OTPCOlC
         r9I+z7KZfWHSi+jwwNUQSmfxAzn1pTWEO4Dj+Tp8Vdm3j1ZhGOY2K3LkoDq0m5I4cgw8
         UcmrOQFS1udJOVas1DtEso+LwPSBm9M9thwAK80mpfGkGDV40XnDXxnn7rvbXJkjiL68
         meF7Yit3Y7Txbiwd5MN+0L6UWIKh0wRG5WMvvXP4gMsQ7xIzYA4H/ydVvD19hZEQWp2H
         KTY6vM3z+8XHyVaiQwp2HGF5kLYjPb703z4XkEFkQsoDsMEPn8Olbq3bq1WmlLtBvaC+
         nT8w==
X-Gm-Message-State: AO0yUKVD7NZ5qo9eKoRvUYK1Hicz9w92XQiEvo1hR6EXdlaZA+6sbE6a
        dclX0gxhoBMBdvfNKCzVgcg=
X-Google-Smtp-Source: AK7set8BWzzHDDq6BZxjX/SxLpe2V3z0ke8s/n1Zor+AIq9deBw2h//6/n/pGYXbJImCXxooRRwO1A==
X-Received: by 2002:a17:902:e2d3:b0:196:780a:ada8 with SMTP id l19-20020a170902e2d300b00196780aada8mr23941plc.6.1675191387610;
        Tue, 31 Jan 2023 10:56:27 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b0019601f98550sm1412397pls.132.2023.01.31.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:56:26 -0800 (PST)
Date:   Wed, 1 Feb 2023 02:56:20 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro
 (xiaomi-elish)
Message-ID: <Y9lkVAbvxMoOOrdp@Gentoo>
References: <20230131123515.833-1-lujianhua000@gmail.com>
 <ecfd20e4-905a-3ce3-86af-c9d9ad0cfd94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecfd20e4-905a-3ce3-86af-c9d9ad0cfd94@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 07:06:31PM +0100, Krzysztof Kozlowski wrote:
> On 31/01/2023 13:35, Jianhua Lu wrote:
> > Add a compatible for Xiaomi Mi Pad 5 Pro.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > No changes in v4
> > 
> > Changes in v3:
> >   - Pick up Krzysztof's A-b
> 
> Where is it?
Sorry, I accidentally drop it when I copy paste changes log.
I will readd it for v5, sorry.
> 
> Best regards,
> Krzysztof
> 
