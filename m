Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DDE66A102
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAMRqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAMRpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:45:49 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E015693C12;
        Fri, 13 Jan 2023 09:33:53 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id p17so15246096qvn.1;
        Fri, 13 Jan 2023 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rdNFzR2HXAM0I6o4LtYMGLs27i6wb7L8wZBq4XrqOgA=;
        b=jn8y1R8jlawme8uN/QfPpr5bxbxYgK7XsTQDc28+dK0JTIbFfOq/FDyWyXKVYugjr3
         hi7GCIjyaBy19l3tipMoOwKdwMdztLuDDvrRuBw0isXJXl4J91uYQ0lcN3W4OryGJX3b
         ok7FTNZgNb0jBdzVMeI5Iwt061m+fTU3OnyBUOFRmKcRzL1uG+jaQFWyiVo1MfWGaojs
         hcl9paYx24I0mxBEILeli9S67wC26J0LbLhVzmEYEZr/2utcMBlvmi0Rtcpc9ZbxUhzh
         Fhrvg1m7rXCG06gyomjxQOS5QdsgIC+5Jcfj/Y1syp3C1UiWfWQpuwyLYus84Wvzl/gb
         ebjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdNFzR2HXAM0I6o4LtYMGLs27i6wb7L8wZBq4XrqOgA=;
        b=fY2BdvSE7cVA4gn/+UEL2B0/27hDv42Vcrc4wYyGsV/Dj6mqfc6gW8zsSINbcrA+oz
         75kyePSaN8By6ZnIkoiK0XQ+VaEFkdRo++sy3lN7GNnE2qnm+jl8HqueNWpo61KpBXGq
         aHMedW+fOZWxRHQmH25ZMuGIaQPGmJ3vNNhoXzoBSJtu8ouWxVwBCpvCJDL4UxLGyP/P
         zbarFihYjbs8DkK6AQoM5Uj5sCUAP92XfzJBkkR/Q5Xqee1WQJ+4IEe0l9jLOIQ6b487
         ut3L+4bLSX1DmyTj5uyhFmylzvXkajjk3/M0/fwgOKnPO0oz+67MwSWOSFaxGZ4tJfQo
         nSLw==
X-Gm-Message-State: AFqh2krGDX0zWUJksiWXyjKN6k/trbl+wOcii9tYlq8YRqZeWvfMbMny
        V3wDeaDqazuiWrD8H9YE0sqa/RuC10et7Hs++N8=
X-Google-Smtp-Source: AMrXdXv5fCAGSNPoHCCzhzB+I5AgQW57dhBaT9Bg8GzOCUrpc16yaUDboHvNh8Pi9gMf5JRpjwrWahprV1cBniPXIME=
X-Received: by 2002:a05:6214:3906:b0:4c7:1ebf:719f with SMTP id
 nh6-20020a056214390600b004c71ebf719fmr3302962qvb.64.1673631232962; Fri, 13
 Jan 2023 09:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20230113165724.27199-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20230113165724.27199-1-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Jan 2023 19:33:16 +0200
Message-ID: <CAHp75Vc3+_SiVFzmJPM2dtPqUGErGY6Qc6_deS1yaDkjtT35rQ@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: Fix wrong FIFO level setting for long xfers
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Sergey Nazarov <Sergey.Nazarov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 6:57 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> Due to using the u16 type in the min_t() macros the SPI transfer length
> will be cast to word before participating in the conditional statement
> implied by the macro. Thus if the transfer length is greater than 64KB the
> Tx/Rx FIFO threshold level value will be determined by the leftover of the
> truncated after the type-case length. In the worst case it will cause
> having the "Tx FIFO Empty" or "Rx FIFO Full" interrupts triggered on each
> word sent/received to/from the bus. In its turn it will cause the
> dramatical performance drop.
>
> The problem can be easily fixed by using the min() macros instead of
> min_t() which doesn't imply any type casting thus preventing the possible
> data loss.

But this would be problematic if the types of the parameters are different.
Currently they are u32 vs. unsigned int. I would rather assume that
FIFO length is always less than or equal to 64K and just change the
type in min_t to follow what dws->tx_len is.

-- 
With Best Regards,
Andy Shevchenko
