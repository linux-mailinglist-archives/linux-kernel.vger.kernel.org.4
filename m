Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8772DEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241548AbjFMKAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbjFMJ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:59:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9098710FC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:59:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f8d5262dc8so1207395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686650375; x=1689242375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlUoGmD+Nfi7K2nHm0LGWuLWSwRbzH1OWwMGWxNfqrM=;
        b=OwZMBzxmZi8GYXKYUFBPh7/x5iWEMT13GxKzuI5U9ZCQOEGQweYPFbetgB/yeF2eo+
         JPjG8t8VtY4e0bz+v7fKE8y2oDOmPygXuZIj0eKQkQyCh0msrqb0VE9iElMVzjno/Od/
         U+St9XrDfAm6BCcvEfdpe1JnkpYuLLk3dDCly87ImNh45wEzNJfvaKjP8h3GgL4F2iWa
         4BpS9XmjSmz8Tlp2+h3AMgeX82VmR2Q7jUmWIE5S1GQdVJJYF7OimRsO3g4BkbjYHnna
         axAL+h31Wuxzd2cyr2wOEPfbd9eSss92evfNGp0mHoXhYI2EAYIoIHhdloEytxVaK3bC
         A0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686650375; x=1689242375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlUoGmD+Nfi7K2nHm0LGWuLWSwRbzH1OWwMGWxNfqrM=;
        b=ix+qfqFYAk8PC+SOZBSQmRlidhN+B8Yo4kW1nBTvLi+oQ9qIkUhxXBd1E9hcFzdYCD
         0mZxFo4K9SSdWSMOVZHDFEZ1f5Wen6P5vwS3W4rL+/HBiJN0E5CRapkwIpdr9upM6iNu
         hM6/qD8pbomk4XGh0HAcYYK79utWhRexd4wHByEMHHO6hTrKV+70g//jnCGFruGNzvyo
         FX7pGJATc4lwhDF2m8y2evN0uRJr00qWQtj5oB/klYYZTNIVjai3M7Z36Deg2H0LZGzN
         HmvoU6NR/WxxVyiHU8jwJbxf3AJ3l2Lqyc6Z5IxD5OzAJsiGFFTuOVSfbpdmUwygbYRs
         ELMw==
X-Gm-Message-State: AC+VfDxvF49wN6niJLRoxZbjyDcPRpeqVU5MCPGknYuASuXGOuMDiETr
        lWe6rqr5rfBvRJDKU1rY8cmp/A==
X-Google-Smtp-Source: ACHHUZ48AjkEKc9KR3ij8G3kZiakHkZ+tjQ0KaSTDHC4QnSEoudDWbftA4K3pG4bxUF8hqmHpSPFXA==
X-Received: by 2002:a1c:750a:0:b0:3f7:3634:e21b with SMTP id o10-20020a1c750a000000b003f73634e21bmr9945985wmc.2.1686650375078;
        Tue, 13 Jun 2023 02:59:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b14-20020a056000054e00b0030c2e3c7fb3sm14717409wrf.101.2023.06.13.02.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:59:33 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:59:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     gregkh@linuxfoundation.org, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, martin.blumenstingl@googlemail.com,
        mchehab@kernel.org, narmstrong@baylibre.com
Subject: Re: [PATCH v2 resend] media: meson: vdec: Add MODULE_FIRMWARE macro
Message-ID: <293fbb78-26df-4328-8a1b-047fdfc9153e@kadam.mountain>
References: <20220818064810.17856-1-juerg.haefliger@canonical.com>
 <20230126153258.1558471-1-juerg.haefliger@canonical.com>
 <20230613115018.562c843f@gollum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613115018.562c843f@gollum>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:50:18AM +0200, Juerg Haefliger wrote:
> Ping
> 

You CC'd almost a hundred different mailing lists but you left out the
one that matters.  Resend and CC linux-media@vger.kernel.org

The linux-media maintainers work off patchwork so they'll never see this
patch as is.

regards,
dan carpenter

