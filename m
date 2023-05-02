Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF4D6F3B67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjEBA3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEBA3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:29:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FAA173D;
        Mon,  1 May 2023 17:29:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52c30fa5271so626589a12.0;
        Mon, 01 May 2023 17:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682987346; x=1685579346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBqHu+lnWk8vAz/lUfBmOPXhwTwQLj17nppKH0nr3PM=;
        b=rot8jGhY3EhOgIBxrI/7AcdOnBaOI1+96B+MlDzh8XetEEUzLhpaknn/X3MKOWIJUZ
         xNHJe5HzKEImoPjZPBQzW4QuMqTXRDzcHH412xekixvgYAmMjbw9Qdk90COQpEWDH9uu
         EX14alMCxLKrkt4qk5tvy0p80dltvTRe1zeW85zqwsKMRfuPCSQ+CfUbbiu8DVC86Z0C
         8s+o/myAHQhxh1ztXwp6pjIjf7KujXDcwZeuY1yDlwqqqrXGCxw+vB/gxq3DVdwPgoQq
         85Hq40T2OdvQ7Vl5R7csq2hkqdvy+5ypOkooUsJnqdiSH2n9GZyHdOX/0m63tlkdCHbN
         mjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682987346; x=1685579346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBqHu+lnWk8vAz/lUfBmOPXhwTwQLj17nppKH0nr3PM=;
        b=SbaOKbxeeBqDxKDOm58uHXdyz0EvtLIPSGlFRUGtxR19aX+cRGUPUtA4meesOvMu2P
         gjwjZsGTTPEUd88oTEHEQKnhzJSv3F+sh4UDZn+4wOQBxIjr5UHidd71oglpTvwuHm+f
         93YFCWi5UD0tWI/U3Hzjm/WHFXRS+p+eZiG8hEXGpZZIuBuG9A0fW8sp7OmoOn8yfr5V
         O7qA6kPXZ/US1QkUKoPrPJATM4YeN/Ym97YuC/1kt5/cyUSyLfA4PYe/48gFrn5DZC/v
         NnqHP4FdTjSYqwGhHMFZ0IupAfrB69tyfsPiENxHTDiQ5s3NMByUcszSYv2FzC9w/LUy
         Supg==
X-Gm-Message-State: AC+VfDxuDpRY1BUsWzcc+gc5nJGx78GQDxOPsoiVjSedOGAHKOIIcNGU
        e3tdzQKqv7Z2fLRcWMTkOUI=
X-Google-Smtp-Source: ACHHUZ5z5n/6hVzP5V2gfv0/gZNUKxFXz5RO0U4Esu3C7HcvvI7tKf3S4iPeZgZPRbYxTXcxt1LZ1g==
X-Received: by 2002:a05:6a00:1487:b0:625:e051:e462 with SMTP id v7-20020a056a00148700b00625e051e462mr24297867pfu.15.1682987346067;
        Mon, 01 May 2023 17:29:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id fa23-20020a056a002d1700b006259e883ee9sm18762101pfb.189.2023.05.01.17.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:29:05 -0700 (PDT)
Date:   Mon, 1 May 2023 17:29:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] Improvements for drv260x driver and add to Huawei
 Watch
Message-ID: <ZFBZTsIUXzuU5/IL@google.com>
References: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
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

On Sun, Apr 30, 2023 at 08:20:52PM +0200, Luca Weiss wrote:
> Clean up some issues with the driver I've noticed while working on it,
> then fix the magnitude handling which previously resulted the driver
> discarding the upper 8 bits of the magnitude value, and finally we can
> add the drv260x to the APQ8026 Huawei Watch.
> 
> While the "fix magnitude handling" commit technically changes behavior
> and could change behavior of existing user space applications that deal
> with this quirky behavior, it's definitely not correct and results in
> very unexpected behavior if the user space doesn't look out for it
> (meaning only use 0x00-0xFF magnitude, and also know that the magnitude
> was interpreted as signed value, see more details in the commit message
> there).
> 
> There's currently only one other upstream user of the driver,
> qcom/msm8996-xiaomi-gemini where I've added the dts authors to this
> patch series (Raffaele & Yassine) and some tests on that device would be
> nice since it's operating in LRA mode, mine does in ERM mode.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Luca Weiss (5):
>       Input: drv260x - fix typo in register value define
>       Input: drv260x - sleep between polling GO bit
>       Input: drv260x - remove unused .reg_defaults
>       Input: drv260x - fix magnitude handling
>       ARM: dts: qcom: apq8026-huawei-sturgeon: Add vibrator

Applied patches 1-4.

Thanks.

-- 
Dmitry
