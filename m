Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2276607CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJUQrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJUQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:47:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AEC25C484
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:46:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u21so8050826edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8UA4QZ0zgHvnNoMDh2LWPJVzCCJtGmudtS3v5Nvvxo=;
        b=GpP0pQtV8FCCLDxaNWanoIOgSq6/iajnPwdA7bB1a6JSXs9LxYI7xWAbRwSHhDTq4A
         iWn5ABGTKppenuDmbcDoBlST0mpdLkxNvQenDGWtaueNGcYxpL13GKi8cWFNYTJ+3VPW
         7OtNlTtqCJsqz2G02ITzqD+/tVJ10w/JJSr6PspTsghr0h5XftIV9mrhgh+SmXx5bIgb
         uh/U4RCqTfWeoTDgDO1AnAvRU9E/wwXmg+pHj8f3h1R+VvxmWf6GF2Akhwya1isnLPuI
         5fJAGoTGGu1GiplKw7EI8xUieXxKWv/1QBCMIsdVs9fCPeHbgF6I1uVPIUPgwQdKVlJT
         DxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8UA4QZ0zgHvnNoMDh2LWPJVzCCJtGmudtS3v5Nvvxo=;
        b=Bw6yNz6LSRUenHTE+99xZLf4nCgWOUat52b8B3qv3ZSMTS6Zl8k9YzN3FsDNG8v9iT
         dL9DsniryyOGzSGXPYPVPMMqzbYECLxxkaVD9UAGUI3cP0Uio8sHOeUWZ7hz8qq1cSD0
         Dk4BbPc4MPgkwAQeNwUaizSpyqafWU9nwj2fwbYaXeokRzHD5mcwFm0K1wj/Fy56sQho
         ra+oCgWsEV9TCnuLvCQW+z2461EWLZS3iIJdzHThCrSb7e4kH2mU4wSXoqnHQQ0duS9y
         +bEEG4xRFUzJLsjA/dV15kllFYWiK7xgmC+dSNakD7Rjp9uHB97jUSqn2SZFsdVPx/9W
         nZrw==
X-Gm-Message-State: ACrzQf3fVMVjTevZml7z8mmRZ0pUEqcajmDOAzrzSWmhaGq6LfFNnwib
        4h935CvlIi1T6GhvRAJOxw9CZaIfp75o2Q==
X-Google-Smtp-Source: AMsMyM5B8ROyjUb8mw+dp6dugHFMZnU7jrGNBiC96C21DaFcoiGypG8W5Nivxb4E60HzVQQ9dq0HEw==
X-Received: by 2002:a17:907:75e5:b0:78d:95d3:255d with SMTP id jz5-20020a17090775e500b0078d95d3255dmr15429453ejc.495.1666370807961;
        Fri, 21 Oct 2022 09:46:47 -0700 (PDT)
Received: from hera (ppp046103015185.access.hol.gr. [46.103.15.185])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b0079e552fd860sm380851eja.152.2022.10.21.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:46:47 -0700 (PDT)
Date:   Fri, 21 Oct 2022 19:46:45 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org, pabeni@redhat.com, hawk@kernel.org
Subject: Re: [PATCH net-next] net: skb: move skb_pp_recycle() to skbuff.c
Message-ID: <Y1LM9TdodXYlYzuF@hera>
References: <20221021025822.64381-1-linyunsheng@huawei.com>
 <CAC_iWj+oKwHkQRKZhELB=5FOj8n-0ZRC7B0uc9F4vF2h7bncHg@mail.gmail.com>
 <20221021085138.19b2c8a7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021085138.19b2c8a7@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub 
On Fri, Oct 21, 2022 at 08:51:38AM -0700, Jakub Kicinski wrote:
> On Fri, 21 Oct 2022 09:02:36 +0300 Ilias Apalodimas wrote:
> > > +static bool skb_pp_recycle(struct sk_buff *skb, void *data)
> > > +{
> > > +       if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
> > > +               return false;
> > > +       return page_pool_return_skb_page(virt_to_page(data));
> > > +}
> > 
> > Any particular reason you are removing the inline hint here? 
> 
> It's recommended in networking to avoid using the inline keyword
> unless someone actually checked the compiler output and found the
> compiler is being stupid. I don't know the full history of this
> recommendation tho.
> 

Ah thanks, didn't know that.  IIRC there was no particular reason.
Probably because the majority of the functions in that header are static
inlines.

> > Doing it like this will add an extra function call for every packet
> > (assuming the compiler decided to inline the previous version)
> 
> Should be fine, tiny static function with one caller, I'd bet it's
> always inlined, even with -Os.

Well it's compilers -- I wouldn't bet,  but fair enough

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks
/Ilias
