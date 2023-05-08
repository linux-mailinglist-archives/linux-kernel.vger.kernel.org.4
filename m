Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CBD6FA38B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjEHJmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjEHJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:42:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA77B1BD9
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:42:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so12264625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683538949; x=1686130949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T28Oe9DLpF1dSUeZW91IdnljnrR4fIJ/NpuV6c302EY=;
        b=BTnrdj4jH0W70BgMtxpBsZzGmZVfaDaPiROfwnS03tMi9i28YBjUONOZU50i7X0avq
         4Xh8BywWoQeE5TiSasI4IsPm4EcMQRpMrmeNqP4gdYPI9Y5SmMXAYdYo/Q8ZlIrbRXsA
         hMbPg1A1cg/5IcuCU4GWeTEgrVUDVSqANnYjFymAG8M/ZEUatpcRJe75IhNmewZt2RUF
         IuzXmihKmi1MCgn39WoFW2Pzull0Ryv3PMMsW3ZJSzyqNVUtZ9H88g/Akhk1AV4VRa6y
         J5wzYmW8d0j8bMZij3dVY2K4MK0PxILbEWWMy7VNyTLM7s4/Nb7TejrcJcUi54UJg4+e
         Z9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538949; x=1686130949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T28Oe9DLpF1dSUeZW91IdnljnrR4fIJ/NpuV6c302EY=;
        b=lzTLUFFrf5iAqOSEF3C1t0wE8eTMAsmax/JncHTZMKnePxBeNPRPdcR9pVhqpYnN42
         6yp8KPnOX1nCHLm2A3Nrf5ICwTE4heRnL+8PqSS4u4FqIlSVDGH+YgOYOvSLb7zV1OwT
         fXZnMfYH9NNwpTpNEukgK/+JlKSsST7o+eOOk6pL9LlAjTQNRVS6nUdKZM7vloC0Mpnj
         m82n+ElUbdFKnPu3J3VV6PjvnAsA5OzFY8VpLKMlZcpYoWXXnMyo/3lUyuhW3jpURB5m
         1c5/BA0qIcCLSvwW9z3LCAK374XuWoLRBL1kTT6+y52SiBfQofB8mIilcfaOl2WgZibg
         9x1g==
X-Gm-Message-State: AC+VfDw7Ks5N/XsW2ASD+VMbb+yb5X9VjgMSGWi0y6mlwF1UP/3emoFT
        Zdorm8muXS/gXRnW/n1ZqNM7qA==
X-Google-Smtp-Source: ACHHUZ4UQHEf433tFWn0nSdr6SjZi3u98MrjjsndSNYjc3f1SikgzFIg2tV1fCCk8PlpXGP5f06AhQ==
X-Received: by 2002:a7b:c5d6:0:b0:3f0:b1c9:25d4 with SMTP id n22-20020a7bc5d6000000b003f0b1c925d4mr6643097wmk.21.1683538949209;
        Mon, 08 May 2023 02:42:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003f32f013c3csm16366326wmh.6.2023.05.08.02.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:42:26 -0700 (PDT)
Date:   Mon, 8 May 2023 12:42:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Brandon Pollack <brpol@chromium.org>, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
        keescook@chromium.org, nathan@kernel.org
Subject: Re: [PATCH v2] .gitignore: ignore smatch generated files
Message-ID: <1bb3aa1d-1f01-4260-9ebd-598f3dffa420@kili.mountain>
References: <20230508055226.3183447-1-brpol@chromium.org>
 <CANiq72kHP7SQNkY2iU6h3PacmRZUN3yRfk2VJjROz51YVBXoxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kHP7SQNkY2iU6h3PacmRZUN3yRfk2VJjROz51YVBXoxw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 11:29:47AM +0200, Miguel Ojeda wrote:
> On Mon, May 8, 2023 at 7:54 AM Brandon Pollack <brpol@chromium.org> wrote:
> >
> > ignore smatch generated files.
> 
> Sorry, I should have mentioned this in v1: this line just repeats the
> title -- please also give the rationale for the change in the commit
> message, not just what changed.
> 

I secretly wanted to say both things you said.  Also please start the
commit message with a Capital letter.  Here is my proposed commit
message:

The Smatch static checker creates some data files in the kernel root
directory.  Add them to the .gitignore file so that no one accidentally
commits them.

regards,
dan carpenter


