Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6394F629C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKOOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKOOkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C1319C13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:40:03 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o30so9809241wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=gYl16z55yRd40eIcM42G8VWz9xZyml6dqS4a2jdGLsM=;
        b=UWSCke5z4k1lllo1omFCPYg1l0ZHdkTxnTVhHXlacPa9bV32jD2GW3y7V51HILdbLP
         bxhQ/kBcqJVJ+/VwrN+mnvhb/0jSNBGssPHfzWNORlLVLxhXRzVGOLS7juc35oiOhaE/
         1JP9evWjfyUvKJ/OVTP+D2mC8zmrqTbuwjxjCyjhDSU1fwX+CdMqU7X+ENKe0K16jbxt
         s5XOZzzzob+oIKXJBzc610arQeVEExH0LRUdJiL2Kawi+OxBoc7jKXIOj2q1/GXjSaWv
         naAWCGfNdPw6M5/s7YGrVyUx8WUeZB/S0bSgJe+UCREEJ8PfyuIde3aa7DCU2XkxAk6I
         7qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYl16z55yRd40eIcM42G8VWz9xZyml6dqS4a2jdGLsM=;
        b=VhuXCNhZb957BrpfV9G30qBM7aH4w1ycaBaotpXD8SpwhRkJPOzOHr4fr8tdBjqya3
         NNe5hv4FocvD+gOlSPQoVCb7vH0rZ8Y56V+bDVdVXEPgGaEqUUzFz6pn4ZwLtLe+U/uU
         /TqErgkIi7qM5Glw2fr8rdgCWZQ7lrN1iIbmaVZdivubVqHGH7+rk5FNiat6/eD0KFZP
         q8MZihI1cCmHvHSnVwnNLtTgR9xp4eW/fSBxLahyhyr6n4WK7hrIOtyWn4LNJQ1nMWzn
         axqVfc4CvzzuJXZzzNPSFCPRvrDlcBiX5nxaniRM/2sgVhHAc2rV2U5H2nkYA1QK1vCG
         3+gg==
X-Gm-Message-State: ANoB5pmWyP0zBIDhvHRZ3N3fmVAUHKXVeU1+81NnKeEBQwdpJ9M3XK/h
        iJzbX0Zjdm6U8jGZAeRM9Mw=
X-Google-Smtp-Source: AA0mqf7QIedPW6aoUd/+PAPfsp3EfmNy6x4uiSijfxJiykApA3acwLeX3yMsOLWKatwrapj/MGUvEw==
X-Received: by 2002:a05:600c:3d12:b0:3cf:92cc:9e5f with SMTP id bh18-20020a05600c3d1200b003cf92cc9e5fmr1743273wmb.181.1668523202020;
        Tue, 15 Nov 2022 06:40:02 -0800 (PST)
Received: from localhost (94.197.22.174.threembb.co.uk. [94.197.22.174])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d404b000000b0022ae0965a8asm12610005wrp.24.2022.11.15.06.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:40:01 -0800 (PST)
References: <20221112152446.41690-1-aidanmacdonald.0x0@gmail.com>
 <b49601d7-701a-1047-79bb-dbed27f0f485@linaro.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: max77843: Replace irqchip mask_invert with
 unmask_base
Date:   Tue, 15 Nov 2022 14:37:43 +0000
In-reply-to: <b49601d7-701a-1047-79bb-dbed27f0f485@linaro.org>
Message-ID: <yc3z6sIuDhoFA28Hp7iVrO5yGgykuxDS@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 12/11/2022 16:24, Aidan MacDonald wrote:
>> Remove use of the deprecated mask_invert flag. Inverted mask
>> registers (where a '1' bit enables an IRQ) can be described more
>> directly as an unmask register.
>>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>
> This is a resend? Or v2?
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof

It's a resend. The last submission couldn't be applied at the time
because of dependency troubles.
