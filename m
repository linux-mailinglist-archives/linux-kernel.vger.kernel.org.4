Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4486F3B60
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjEBAYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEBAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:24:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162110E9;
        Mon,  1 May 2023 17:24:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab01bf474aso8604045ad.1;
        Mon, 01 May 2023 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682987045; x=1685579045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcw+SsB8ViaYF9OEERxm2TC24UTIvlYvUkpijbvcqkA=;
        b=Kemx6cpvy41sepp/F3CUlNuFfUXbdpQ1/ckDe0fw5kwbHo8XW6PzZdo8aVsKI8ny9R
         Dm3WyjAttNA0iwduQXq2bposZp92HOUYmmw4KqHi0YRzeBTwYpPg44zf6GO0UCZMpJYJ
         QtPwaWPDiSqn1EUJagmiDnJEK16WAy7lqjpuFoNLXXKq0KGi0TmFh5HZzsi2rx2t9Oig
         3CSZrNP0gADJ9BOpgPeWGRzpmZ0hNvVwrdOYNJSGsErdBmguWYuOzSas+brxxosPYPc2
         JSmpsK/kJSpXilXRpkc8dl9pLyGYegMtfXe8B7QgR7FW3rkr+m+5PsPbDmDhTI/lneuv
         6w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682987045; x=1685579045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcw+SsB8ViaYF9OEERxm2TC24UTIvlYvUkpijbvcqkA=;
        b=Klvt3NxwyZxk/uxM2NwnbxE61mgGOfyayr5fm/8f0axBJyu1F8mn9gtybvkaHMbaSS
         VBejRrXuK2rxur+QQd0yniLoWDPmk21wG5NZFzMuZtEqcfC+0D6sAZB3ramGeD+rQu1g
         4kmDJe2Y8rUuA/qAFfhtGqPrUQVJSNx5mwXHq79fc7+mWGWrLchr7/ogLGIg02Z/MeK1
         II4PdVxzV6iEhDX+iLJxdJpp6QEB25nl3sXWl1QN3pkiZzCGd+32OF21jN4cXkSK+a7c
         g2JWIMp8HwjACm0pQKPbwB5OQ4Tw4RGMSKqca764Wzmhnx3D3vwWpaFKygZ3etC0Zh65
         am2w==
X-Gm-Message-State: AC+VfDymyvMkafwepo1CFAvaVusSJNS/EWWeE4Xtf0uxGaUUvOpGGrJS
        v+aveJxnI3AqXCUk4YDL/4o=
X-Google-Smtp-Source: ACHHUZ50w+YTu1Zvn6I/ZCxdB6R6aZQSIW0BU+ffEPv3JSZmyYC1Nk2+bCb74QKCM95UEVUIkl4fFg==
X-Received: by 2002:a17:902:ecd1:b0:1a9:c07f:93f4 with SMTP id a17-20020a170902ecd100b001a9c07f93f4mr15673428plh.55.1682987044606;
        Mon, 01 May 2023 17:24:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902b60300b001a9b7584824sm7879332pls.159.2023.05.01.17.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:24:03 -0700 (PDT)
Date:   Mon, 1 May 2023 17:24:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Maximilian Weigand <mweigand@mweigand.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 3/6] dt-bindings: input: cypress,tt21000 - fix
 interrupt type in dts example
Message-ID: <ZFBYIZc5zKs6dpHF@google.com>
References: <20230501113010.891786-1-mweigand@mweigand.net>
 <20230501113010.891786-4-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501113010.891786-4-mweigand@mweigand.net>
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

On Mon, May 01, 2023 at 01:30:07PM +0200, Maximilian Weigand wrote:
> Triggering the interrupt of the IRQ_TYPE_LEVEL_LOW type can lead to
> probing issues with the device for the current driver (encountered on
> the Pine64 PineNote). Basically the interrupt would be triggered before
> certain commands were sent to the device, leading to a race between the
> device responding fast enough and the irq handler fetching a data frame
> from it. Actually all devices currently using the driver already use a
> falling edge trigger.

I'd prefer we adjusted the driver to handle level interrupts properly.

Thanks.

-- 
Dmitry
