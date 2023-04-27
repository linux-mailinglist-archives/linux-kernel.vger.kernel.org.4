Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E606F025F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbjD0INp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0INh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:13:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E252D79;
        Thu, 27 Apr 2023 01:13:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2febac9cacdso4989293f8f.1;
        Thu, 27 Apr 2023 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682583215; x=1685175215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W2YdJ16upKTR7fyZcjH5Yz52tSKzgQbMIFH5U7k9qM4=;
        b=kSTts5ONirlPcLsG3bXihpXCeWHIR1Xzd+Rv6O3764HUcW3eO/Xn4nVfliLtTlBYkU
         TliokqyisW0v9BeuR7U5GO/jzFsQ/BBtCO1tsfPBInElguvy+mrUelD2TvWbo1XO9MhG
         L+/Ezz7Zjy6U/BJrKtQ7XHEaGZP3N9PdIchpMKvTtAJ9zREwnBHCRDG9E73Pf66i61Mq
         DMhXppshDc/VidnhD0CMUqBkdOvUHW7WREg3uf2Q0SafHg+fO9Ojg93qXHImaJjvW1SZ
         /asPgLvXqPzEjev3qzWNlbb7qnmTUIArP/McUBzg9oEI2jYF6IYZ8O3IlJvp4yawNEVy
         vMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682583215; x=1685175215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2YdJ16upKTR7fyZcjH5Yz52tSKzgQbMIFH5U7k9qM4=;
        b=lzthvELC8Knx5oGzNPocN8lcTNHp1iywUO0VUzxJj0+sqMDPsgCORVHZeV5itDz0wv
         ukH6KNUyB5jYl6jeb23EDmr33yrPpS1A+0FKdPe5N9bKqP/t5fzdyf4YdpFyM6WHXr8y
         auNEGem5J7e0gCdCnvN/Vbyw6UZhb+ohqwAXyOz/dhf6iHaC/eml+3G67yhPJRpUbkWH
         ryvH8Mv6CzVkL3tStVX3c82eTDv1ct8zlZPYubPTlrcL3d7XFQtkPFu7eOqkFpnj3JN7
         l8UAmmkztq2MWDjTMSA4mtcASm5ZVmU7NelTClcts1R6FP/bB5EvjHMStFTitparohDd
         ABrw==
X-Gm-Message-State: AC+VfDxJ/Qr0gG9RYXj6XnD0cNTSIjvN/oFzd0+zQygI6VXouNrCoOwC
        nNc5CK2bWFaZaf+AVgvBEVYg15lMPE1xkomRzh8uEFX6aw==
X-Google-Smtp-Source: ACHHUZ58CNSZ5iF3CO8HsMCZB+ylZ0Z3HNxrAMDIrzf3j9WXyC5gDT2ffSabtTzc2mfk8VG58xgJXDL+IdfUb0lPOt8=
X-Received: by 2002:adf:edc2:0:b0:2ff:c0c0:532a with SMTP id
 v2-20020adfedc2000000b002ffc0c0532amr592937wro.25.1682583214884; Thu, 27 Apr
 2023 01:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZEf0RYdD5jhE9JEk@nixie71> <20230425164903.610455-1-tomas.mudrunka@gmail.com>
 <ZEnErxfnSn2JOpvm@nixie71>
In-Reply-To: <ZEnErxfnSn2JOpvm@nixie71>
From:   =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date:   Thu, 27 Apr 2023 10:13:22 +0200
Message-ID: <CAH2-hcLOA0ECg7ubKh_r9BryRuGPjJ1Cv1ErUpMmQ+Yag5qnWA@mail.gmail.com>
Subject: Re: [PATCH v2] Fix freeze in lm8333 i2c keyboard driver
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, thanks for your notes.

> This is the right idea. I am sort of splitting hairs here, however I
> think it makes sense to place this read before the IRQ is requested
> and not after.
>
>
> As written, there is room for an ever-so-tiny race condition wherein
> the IRQ is asserted just after it is requested. Before the threaded
> handler has run however, the new read in probe swallows the IRQ status
> before the threaded handler can read it and react to errors.

In fact i believe quite the opposite case to be true.
If i read before registering IRQ there will be ever-so-tiny race condition that
would allow to miss the edge (exactly the bug this patch is fixing,
but limited).

In the case you describe the worst scenario is likely that the interrupt handler
will be called only to re-read status and immediately return on this condition:

if (!status) return IRQ_NONE;

> Also, I think you should at least capture and evaluate lm8333_read8()'s
> return value as is already done for the calls to lm8333_write8().

Well. If you think this will bring any benefits, i might as well just call
lm8333_irq_thread() instead of lm8333_read8()
Would that be acceptable solution?

Tom.
