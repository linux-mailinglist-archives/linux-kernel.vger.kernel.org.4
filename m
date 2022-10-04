Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F285F3D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJDHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJDHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:52:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F02B629
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:52:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bs18so12799654ljb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hDLgl54lQbCbBFcDniLURkIOZ8VxzTrUQLa1hPgXuhU=;
        b=TLz0pOaEFehLI7kJ8vWp9kyOedmp8K1CEfQwPg+CpY8bhx56EoQYEXiFCjaX2XXhJj
         IibpX5uMkTq+ymjrlCY0lDnHUxAV4F1OiZPRzBMVNR1Yr7is0y3JgrFVe3vy7CMzQsEu
         Bvlw0Ui7kSj+TxZGbse1T8mDkrhnXwYGUessQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hDLgl54lQbCbBFcDniLURkIOZ8VxzTrUQLa1hPgXuhU=;
        b=RyF3XeAtvWL/WmWmZNkEV9WhU8cTehnsc7v8PMLnAGgpOXV/tGKeGiRzp6bF1bxM8m
         ghhCC7KxZgwheIcouLJBklIaiR92tA6z4ckM+d8Sf4fyAQTTokIFOCw/SInpvU7RdvLk
         O7etQTteSMSkZZn1IuCEYZxRoTzym65JcIKpDHh+fMFSECbACJvH9kfqwV4Al+vRkBa7
         HfC5n6F7yvqFh+5hlNm5qFAkhJlToVIAz0Usz4OreCbejROdPmT61JMt6UyFCQ/ky7/a
         r6vx2ZqFFh6OLADUI+lfZ+tLCMqx6c2r6Zd9/nBU2kdObN83tYOv3Meql5X98Y6FJDKx
         kjSQ==
X-Gm-Message-State: ACrzQf27UkK90M2ykv8dlGnkR2nZAm5V8JLg/nOqSo/aPKhBvgfgWgP6
        LYG8HFSBR98Orxxh2Z3QcEtjRA==
X-Google-Smtp-Source: AMsMyM7c4Auh3lsU8KRII+WuvMlQD1uThsBFLcylMouY4aiWHHB0xwKAlWIZ7x5UGN6eYhwfhwSSJw==
X-Received: by 2002:a2e:9e43:0:b0:25d:d8e9:7b15 with SMTP id g3-20020a2e9e43000000b0025dd8e97b15mr7790083ljk.234.1664869943857;
        Tue, 04 Oct 2022 00:52:23 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i25-20020a2ea239000000b0026dcf0cbb97sm841663ljm.137.2022.10.04.00.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 00:52:23 -0700 (PDT)
Message-ID: <86e54c78-f1a3-47da-1073-88919f96cce8@rasmusvillemoes.dk>
Date:   Tue, 4 Oct 2022 09:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Sean Anderson <sean.anderson@seco.com>
References: <20220728144254.175385-1-vladimir.oltean@nxp.com>
 <20220818141309.ifl3kddmxojqc2jl@skbuf>
 <20221003094542.tlh6xoee77akuubn@skbuf> <864jwlapv9.wl-maz@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <864jwlapv9.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 17.28, Marc Zyngier wrote:
> On Mon, 03 Oct 2022 10:45:43 +0100,
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>>

>>> Just checking in on this patch to make sure it hasn't been forgotten.
>>
>> Is there something else I need to do such that this patch gets accepted?
> 
> No, it just went under the radar. I would have liked an ack from
> Rasmus, but this has been there for long enough.
> 
> I'll queue this as a fix for 6.1.

Sorry, I've not been working on that ls1021a board for a long time, so
while this was on my radar, I haven't really looked at it until just
now. I wonder why we haven't seen that splat; we do use the -rt patches.

Anyway, it looks quite sane. FWIW and if you haven't queued it up already

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Rasmus
