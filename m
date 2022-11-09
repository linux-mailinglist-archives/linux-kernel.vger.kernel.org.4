Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EEF6228FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiKIKuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKIKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:49:53 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC8C13F70
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:49:52 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id t62so18334530oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4NsaOOaEbhTsCVVYI+imS+ix3gQSDTV7dTnALQ6Ga9U=;
        b=YP82DL7J4NFI+2KLEppBy2zLWR1lg9ddBPulUyiwsoHLRXVhpsck0FiaX9hrton5g/
         Ow6brV9HvQEnKZvnehqufXGX1u0fDrdL58J6aWnuJS9V6DyahRG4qVUM4p+5ROzxIBcN
         vipCkPggN2BpZRb3H+TUZIPEYRYvwHiHdLe1rbGU8AEx4mmgvatAYXmgR052jUAcOgMH
         /B9hfWeB0cC2H0V1paCfBbfmIdGWkwJAsenVwiHaKXlCE4IzvsvE4lGcLfPzoxgvC3AL
         mqHxrpiYJl1ql8XBs/pZqJm3YJlWwjnMnRDYDN/dPTpOL06xp+beZfqcN7FTEc9IDcwR
         tPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NsaOOaEbhTsCVVYI+imS+ix3gQSDTV7dTnALQ6Ga9U=;
        b=22hYr1Wy53MYFbb/7yL+q0dDv5NALS7wV9B7rFtgGNxNUlLX2weLWt1vmSVwcpUmit
         LjFTzI5sfFdq8sVPzUVBDwmP8oRLbc8wczYnbPyuvfZ6YhMtRTsSuy4ZmerYQgqZNmwe
         zkeiwYkH+/0lrr6PlN1c8o/6fSlQg4lvzj1JauyLf3nyI9nBPRUvV/p7dZwsdREwhQyz
         7Qu5cKSk3f1uaoqEvYVSwkdEyET+zZU4B1aVmLillvlLs95xM00me9KFxuj4l/u2Mc9j
         7W0/xupFPqNKEl0KbMKnTZBoCSAO1+8K9Ao1OEblettKhxZe/vVZxZ7We+6wLQV1hUVs
         W1JQ==
X-Gm-Message-State: ACrzQf3Fatej147NAboVeYpuILL5HclS05G5rK6y/XqHQD70IJmUWwHk
        MVAYOL/ewETM4yCzdWV1SHUNdmQ0t1CvBxGkykM=
X-Google-Smtp-Source: AMsMyM6hrOwW4b2zlSmtPuSRCEESGtqcO/NYKT0Q6xTum2dXvWvY1hgQbuF/O01ifu7uHETF7WuYIEyM5TRwpQhddGY=
X-Received: by 2002:aca:e108:0:b0:345:a189:fea9 with SMTP id
 y8-20020acae108000000b00345a189fea9mr33040190oig.129.1667990991555; Wed, 09
 Nov 2022 02:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20221109093347.228761-1-zyytlz.wz@163.com> <Y2t8E597OQ8nk4D1@kroah.com>
In-Reply-To: <Y2t8E597OQ8nk4D1@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 9 Nov 2022 18:49:40 +0800
Message-ID: <CAJedcCyf=_WrPm=1gMks0p04k=wYYAgHKMA=oZR5ozod1rgP5g@mail.gmail.com>
Subject: Re: [PATCH v7] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, zhengyejian1@huawei.com,
        dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org, sivanich@hpe.com, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel robot did not provide a tested-by comment for this as they
> did not test it.
>
> Please never add tags that the person does not submit to you.
>

Okay, I will remove the related tag righe now.

Best regards,
Zheng Wang
