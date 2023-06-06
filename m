Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4D7236E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjFFFhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjFFFhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:37:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F81D1B5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:37:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso57286535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 22:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686029849; x=1688621849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoUHwD8w+kKjmc3avPKcsVA5n30zqUm3b1LqVb2lcwc=;
        b=dK9j3rwdrIHmwA5gzUDL5tH/UX7eWEGDGTMUOJCFNTHKhcP5R0HdKS9IUGpFse1lv8
         KJ3AfqXHuQ+WvMWLg99j9dClHk4jKXoHxorPmmuSaNCXeQIIEvT2SpQ26+iFqXaSHaUW
         krY967MPnTBvOoj94NgY5pJpeO4WSTG6M1L3fYjQrUH05h4poYwZIPct0CMYGPUEUZy8
         aWOhSC1uQgTpxctdjDlXZBiuBQzCZ+kLHxfSu3QccNWiLLjdrDawl2xk0nqsomoW6mkW
         YA3MEBDMcp/OKI2iLH3X3iQj9x0sSg3dIYKmJAX68FlAbpdPdseUXJU8Y4bS7TqNRhZ1
         5nYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029849; x=1688621849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoUHwD8w+kKjmc3avPKcsVA5n30zqUm3b1LqVb2lcwc=;
        b=SsRpgzBAmWRXJ0yhoCVwjSmfNirRkYH95cdy983k7chCqdobnixwD19pcL4QQDqCjE
         YYs8iDG1UrpYYjztq1qxdq1Srpm5l765zIBa58CfGw/i3wWT/+PqTu+pYk5fti5dRqLi
         MPAIcpI7hhVYyjCEWoFYAOybgxOQBoldoOkfVyAvF14MDJNbbJ9VW2K+x2L0IockF36r
         82PK4h9HzVi1zN0h2VmJEx4mN0QVaylHFSBmzHOOY7G9PG4h79lXGQl2DH51Eg6JRH3j
         jtK+bMZonA4+acbcar7jfHcx59ineerXzYQZ8+kp5PPZF9W4cZovAYPnUMjlXsSfmEsN
         3Lpw==
X-Gm-Message-State: AC+VfDyxbao06hdoyufscY5BSX0mU7QHYjzwEHIfgxxCjyYEVNO7M7YW
        lCh5XRG6kiIVkAMvOP01DFIQRg==
X-Google-Smtp-Source: ACHHUZ6U649U7QVSiO3bf0E60yABocDdMYxGRGsy804/SnOF2M6fkFXKSFC+Gcz14TGKbJXkkGMB7g==
X-Received: by 2002:a05:600c:c1:b0:3f5:fbd0:94ab with SMTP id u1-20020a05600c00c100b003f5fbd094abmr1242919wmm.3.1686029849543;
        Mon, 05 Jun 2023 22:37:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k21-20020a7bc415000000b003f7381af5besm7133235wmi.25.2023.06.05.22.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:37:28 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:37:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] test_firmware: return ENOMEM instead of ENOSPC on
 failed allocation
Message-ID: <8ab7c6f1-7572-49f4-9781-46f4935ea7bf@kadam.mountain>
References: <20230605162746.614423-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605162746.614423-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 06:27:47PM +0200, Mirsad Goran Todorovac wrote:
> In a couple of situations like:
> 
> 	name = kstrndup(buf, count, GFP_KERNEL);
> 	if (!name)
> 		return -ENOSPC;
> 
> the error is not actually "No space left on device", but "Out of memory".
> 
> So, it is semantically correct to return -ENOMEM in all failed kstrndup()
> and kzalloc() cases in this driver, as it is not a problem with disk
> space, but with kernel memory allocator.
> 
> The semantically correct should be:
> 
>         name = kstrndup(buf, count, GFP_KERNEL);
>         if (!name)
>                 return -ENOMEM;
> 
> Cc: Dan Carpenter <error27@gmail.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---

The Cc stable might be a little bit much...  No Fixes tag either.  But
otherwise it looks fine.

regards,
dan carpenter

