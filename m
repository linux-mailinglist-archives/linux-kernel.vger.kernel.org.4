Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13967417AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjF1R5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjF1R4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:56:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CC6273B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:56:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b80ddce748so1419795ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687974959; x=1690566959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFGqQjNLgtCZhOK9NTaUTj7bxMdQbyY6Zjaqy2ayJjA=;
        b=HT4hhiN5JNn0QZARAU/GPGa/fqMUEU/xWerlomznK4qOeXv70AjIVWQytBKI7nuUOr
         y30LJria+EJLeMYiwDI19PBMLCYv1zqAHrXhJ6OjGKVqFeNZQkbHJWTgPh+UcIJ+VZI8
         nwgB7vTZxK12d6z/+pMZx7pQCb4SnIcPvgFdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687974959; x=1690566959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFGqQjNLgtCZhOK9NTaUTj7bxMdQbyY6Zjaqy2ayJjA=;
        b=U2GH4JkKeoaauOCR6t2mRFes66W2mCMJAKjiLYZmHOj81R6jySVoq+1jOjYs6mP1rT
         IwBy9VCVBwwEMqO9XXEz2SVtwxtS77knVIBIHczh32HlPngEqo+8ZMi8cXool/siX9gi
         FmEi3LwPxaqkN6LvFeGQEg/Vb0xNQDt4M2HaMdAHUrGO8CZOfZKbpJOorlfrl9KYOLup
         FopiCWO7CJR3bD4ngcOe90fopcqzd/2R3iBBCfT57Yht5IO8tC36jQA8YuttCD1nt7q9
         hLKzYHQO2nS35t2t9f0bUXS8XKspuHDWAZhI18wHpf63wuTppdGNNoP6WVTwGKst2OzV
         PKjQ==
X-Gm-Message-State: AC+VfDz9hVwptAD9DyCEYYCaahdFk8OBNrltA/w133UO3ambOOEsNFbl
        PRksNOADU3uk6BHjIP+my5h2jw==
X-Google-Smtp-Source: ACHHUZ4pCHzrs3aB3Au1vDEg5t3p5jkohCdi/8ZwcCKxSUqYnxrYOVYU9Bcm50mn5vuXsh9GgTVoug==
X-Received: by 2002:a17:902:dace:b0:1b3:c7c1:8ded with SMTP id q14-20020a170902dace00b001b3c7c18dedmr10816630plx.27.1687974959600;
        Wed, 28 Jun 2023 10:55:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902b08800b001b8307c81c8sm1970075plr.121.2023.06.28.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:55:58 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:55:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yuxiao Zhang <yuxiaozhang@google.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation
Message-ID: <202306281053.EC5115465B@keescook>
References: <20230627202540.881909-2-yuxiaozhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627202540.881909-2-yuxiaozhang@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:25:41PM -0700, Yuxiao Zhang wrote:
> Current pmsg implementation is using kmalloc for pmsg record buffer,
> which has max size limits based on page size. Currently even we
> allocate enough space with pmsg-size, pmsg will still fail if the
> file size is larger than what kmalloc allowed.
> 
> Since we don't need physical contiguous memory for pmsg buffer
> , we can use kvmalloc to avoid such limitation.

Conceptually, I am fine with this change. I need a little time to trace
down the allocations. At first glance, I thought this patch only needed
to cover pstore_write_user_compat(), but I guess the read side needs to
be adjusted as well?

I'll double-check.

And yes, Greg's questions are all good -- fixing syntax and adding size
details in the commit log would be appreciated.

-Kees

-- 
Kees Cook
