Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622676F3B43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjEBAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjEBAPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:15:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F42F3C3C;
        Mon,  1 May 2023 17:15:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a6ebc66ca4so23300595ad.3;
        Mon, 01 May 2023 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682986506; x=1685578506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi5pDb7HBXni/ayovnb+LOZ2HTVejHNW7Qub9jb90PM=;
        b=QUYBzj945r5wUubZ1uWohQHX8h+wIieaQr0Vo/bdoEAEC9FNqbTbJMV2UKrzokCN0A
         inONCFairPAZ2KgH9z5NN6uFcLzw95W/+sFc7A1QrQYFjnZPlYENdcoVRS8X587lMi63
         IHSpnuQrtqPSzNwk5MyiTXWYbaGLt2xH0fbwsLAunBumv8VjOfoVpTEXtFEMQf1ONd5y
         NEyruxKwSabHrtD0dOQnpNq6AHPsUdiSwd4ShThsmgR3K3z8SM/C84F2x5JJeym1uKBv
         q6QCqJttVzhyWXpKEHRTU9lxnmQhc520FsvY7uL05A8H5KUTG86ugYn4V+1RhphIm1JH
         fXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682986506; x=1685578506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi5pDb7HBXni/ayovnb+LOZ2HTVejHNW7Qub9jb90PM=;
        b=SIkAcTgLllrnTnr96Jkc/vGxwB7gk6rgdLOktRju9hv04ZQavnEeIBdxQQyNc207va
         Y73ZTuw2aMlxBzyZH3pxZbkeshxINUZtg63CXm28Or78Am6RAbKrRlX87k4f9NvsFwY4
         8jP73zOyMehc9lBieFwPEEGy08QswGcLg9x/w8GFzGAvVaizRwIej/1SG/DDRycYZ8tX
         iS405m0sfpNPqxXUEkOcB2aaaGy5Zp0djZ8Gc525roDDS5fBgUoerCoLN7xMjsJv1Qrk
         huHl/o0fwmqMP3fnKtLhcQqgwgZpvX53R+VqLjQN/FVZyvpjy8HONomaC0uCGeB2iBsu
         9h/g==
X-Gm-Message-State: AC+VfDzWf9xjxNHLBNguZxzVGOmoFW297NtL1IBRpKkszx+TQsvlFBMm
        zJMMnRzQNwJDavgrIz9qNYs=
X-Google-Smtp-Source: ACHHUZ5vqPZ+u6fmqnmE3J585dV0ERUREqcgFCte4mA2eI85/7BzozoF6kbppuTw+KpwJe4yrdM4VQ==
X-Received: by 2002:a17:902:d482:b0:1ab:b0e:1941 with SMTP id c2-20020a170902d48200b001ab0b0e1941mr371090plg.69.1682986506443;
        Mon, 01 May 2023 17:15:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709027b8800b001a661000398sm18346170pll.103.2023.05.01.17.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:15:05 -0700 (PDT)
Date:   Mon, 1 May 2023 17:15:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Maximilian Weigand <mweigand@mweigand.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 1/6] Input: cyttsp5 - fix array length
Message-ID: <ZFBWBuZouN+CppYf@google.com>
References: <20230501113010.891786-1-mweigand@mweigand.net>
 <20230501113010.891786-2-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501113010.891786-2-mweigand@mweigand.net>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 01:30:05PM +0200, Maximilian Weigand wrote:
> The cmd array should be initialized with the proper command size and not
> with the actual command value that is sent to the touchscreen.
> 
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> Reviewed-by: Alistair Francis <alistair@alistair23.me>

Applied, thank you.

-- 
Dmitry
