Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963D864DA44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLOLaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:30:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661392A436
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671103766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s79I6f0sGNxy151HZm2V6cUhxpd0OX3k4SAk1Tg/6hY=;
        b=i563UPN/A+1VkHFJu04bMzCaVKiyoNzXfKvCYzQqo8eyfTLD5Ym7QUo+spuDakX61QAo8q
        OpXWQT6/IoL6f3BYLNj/1FEnTdy2GJFnZ5YBpqnkct6gS9DP7IOhwBbNI/pjm8g0Pge397
        l/T2JU9mg4yajAtpUInLYoC4CVqyVMg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-HlfS8suwOLywNouxGtqoyQ-1; Thu, 15 Dec 2022 06:29:25 -0500
X-MC-Unique: HlfS8suwOLywNouxGtqoyQ-1
Received: by mail-wm1-f72.google.com with SMTP id n8-20020a05600c294800b003d1cc68889dso646350wmd.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s79I6f0sGNxy151HZm2V6cUhxpd0OX3k4SAk1Tg/6hY=;
        b=Tl2ykFGhyj01sMNTh3hjDKeJ4gdXvgEQRiQ+3ZmU7yHqq1sxf9xMvbP9OhqhNuYKRU
         hz73DyTc8iSasEaQ8NB+AW/txnkn2jxcMFKdz966LMl6i9q/r82ps0aPVlGF/6wYGnVe
         d4l0xzQh/qW1vRX5rmtIm+Tm+jnVChFXj3hF0pAFBtkQSN7pjb4Ez+wV7qhgsZBBA29R
         LN2s41FLuLlhkGnR8U1sAX4ZxIh6vlzZC29rZx3YIBabuu+oI4bQoW6l25bFt1RmuNxt
         MLnYh3MSGujvY+Z0wwFGVuZqbxmFexfQ1QsSdUB6baqu6jkGKE0GLTK7J/9GwjPuwM0x
         t8NQ==
X-Gm-Message-State: ANoB5pmeqVZAosfpc+h6CFDhF/Cfh5xgWpdC3lX5IPDApPZglJ875J54
        lK4r4j7x8b/DuaVdYcvqlltRzkjFLNZ6uj1u8KzQl+YH/16PvV0ZXXotbcuuqRJG9RzMU+Yd9JX
        woO3FDGQdWCuOxkB1GrOCLiqy
X-Received: by 2002:a05:600c:4f48:b0:3cf:76c3:b2e2 with SMTP id m8-20020a05600c4f4800b003cf76c3b2e2mr21774728wmq.35.1671103764152;
        Thu, 15 Dec 2022 03:29:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6QtPSWfcg0Jin/wRT3erF3PlMrnopWx+8GOVDqPlWrrrm+c6PMsETikq+pnxzgJUBXZ/ccBw==
X-Received: by 2002:a05:600c:4f48:b0:3cf:76c3:b2e2 with SMTP id m8-20020a05600c4f4800b003cf76c3b2e2mr21774713wmq.35.1671103763907;
        Thu, 15 Dec 2022 03:29:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003d1cf67460esm5580541wmp.40.2022.12.15.03.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 03:29:23 -0800 (PST)
Message-ID: <0d35858867ae1c3de899d6162aa39e013daff435.camel@redhat.com>
Subject: Re: [Patch net] net: dsa: microchip: remove IRQF_TRIGGER_FALLING in
 request_threaded_irq
From:   Paolo Abeni <pabeni@redhat.com>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux@armlinux.org.uk, Tristram.Ha@microchip.com,
        ceggers@arri.de
Date:   Thu, 15 Dec 2022 12:29:22 +0100
In-Reply-To: <20221213101440.24667-1-arun.ramadoss@microchip.com>
References: <20221213101440.24667-1-arun.ramadoss@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-13 at 15:44 +0530, Arun Ramadoss wrote:
> KSZ swithes used interrupts for detecting the phy link up and down.
> During registering the interrupt handler, it used IRQF_TRIGGER_FALLING
> flag. But this flag has to be retrieved from device tree instead of hard
> coding in the driver, 

Out of sheer ignorance, why?

> so removing the flag.

It looks like the device tree currently lack such item, so this is
effecivelly breaking phy linkup/linkdown?

What am I missing?

Thanks!

Paolo

