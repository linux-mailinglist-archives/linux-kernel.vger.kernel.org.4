Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7B6F9EE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjEHFFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEHFFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:05:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503D35BAD
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 22:05:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30626f4d74aso2482253f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 22:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683522319; x=1686114319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fbfvoKfgiM12B1Ut3FJxOwEXBRwutegFqnPFSgjB7A=;
        b=D5u6nRUv/RriKM1CtnPuJ5Ba95vdFjT6oTwYoIDCZ3Q0lAON3tPf6ieD35AhmfqvhN
         w5/w4aDkA6eHG5xDeet0rngyFYOmmmfuko16UVgRz9u7F2e0RdANQUI+8gXYFo/i6DO5
         HImJABLy5bK8llB/fIKxuhosXSLPoXoc5f6EZ5bao/qLxdX7uiAevacGUIxiaRdiLjfz
         J44VN2RXVUw1Rq0sOjgPj5HzQ4RHwvt4u0o4kGJVvMeRWKvRZcMrT7Z/5GcFXwqZ0XLa
         cXNfkVqe167vIdoVlToAgION5WaLg14+hYYZKdAsQ0RElL0a2YgqqtckA6qlDA41fFVw
         +IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683522319; x=1686114319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fbfvoKfgiM12B1Ut3FJxOwEXBRwutegFqnPFSgjB7A=;
        b=Il6UhBfLwr6w6UhAu/jZSYt12adcu7WXcloBt7x9zR7Hfi06/JKe6V2W60b1MMdo/I
         1eZGgKmBcYXKF5k0OR1tvAOyxC7QiP9CSDpoUGH5RhhBdDsY9shUyIg+63B8ju2wnVx0
         IQEFfForODhLTSnY6/vr0Y6om6Xm/oEXYX8H3GYHZEdOThg/o42O25nG1enVHqpAP0Jp
         ldBiRfm0pMKJS4bWwituDpmgixEDtRa1g+Owzl4UcuK03lXvRY4S/c0eUvstpzrz0W2D
         iAT5UNHdhVHuvLNLtkm7OUr3kuzvCvdwzm7Bp4A9+9+IHRS33c4MeikbMsC5U38oZNOM
         ZWyg==
X-Gm-Message-State: AC+VfDyomTQ2usL2bMawc7+RwaSQDna1y5ZgsP56VHAB3v+jJPikUP/T
        i/+GaHRmJWaEtVpVYPD6rjrKZQ==
X-Google-Smtp-Source: ACHHUZ71fzd7c49z4LH9GSU1ApfeVtUSmcSlw7du0LOqFqhCgFgL91CAJx3v2TmNYCdaD59XsL7nmw==
X-Received: by 2002:a5d:51c4:0:b0:300:2067:f5d8 with SMTP id n4-20020a5d51c4000000b003002067f5d8mr5938711wrv.65.1683522318946;
        Sun, 07 May 2023 22:05:18 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b003063db8f45bsm9995253wrt.23.2023.05.07.22.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 22:05:16 -0700 (PDT)
Date:   Mon, 8 May 2023 08:04:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Brandon Ross Pollack <brpol@chromium.org>
Cc:     Dan Carpenter <error27@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, keescook@chromium.org,
        nathan@kernel.org
Subject: Re: [PATCH] .gitignore: ignore smatch generated files
Message-ID: <22f05605-b67f-45e5-9cd6-34285c8bb28e@kili.mountain>
References: <20230427023345.1369433-1-brpol@chromium.org>
 <CANiq72nxNtLvx1J-50F8D05QQjx4FBPkrhg6pysc25RL6--Zhw@mail.gmail.com>
 <CA+_b7DLoTEn6_2auTVN9Wj62ogOFXnhf7kTmh_KCZPkCBfJsSw@mail.gmail.com>
 <CALWYx-bvyzN3nGtGpLKyoayWLtzKwJGCtdFMfg=6bJSP2qYNGg@mail.gmail.com>
 <969f9704-6781-4bd6-a0ee-46c7110a2c93@kili.mountain>
 <CALWYx-ayGvg0iuRi15+JyGrThmiOqzwxPNfEfpqUpbsknkcpgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALWYx-ayGvg0iuRi15+JyGrThmiOqzwxPNfEfpqUpbsknkcpgg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 10:20:48AM +0900, Brandon Ross Pollack wrote:
> This is actually my first patch, is there anything else I need to do to
> apply it or should I let the maintainers handle it from here?
> 

You need to send a v2 patch without the trinity stuff.  (I removed it
from Smatch already).

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

