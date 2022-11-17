Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18462D5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiKQJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiKQJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:07:35 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E825A6E3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:07:34 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s12so1601731edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yjNlU8q2y36L4sRDz7WyozzVBMIW4wTXmXo+aeTQepE=;
        b=E+E1YRgkWSrVP3uIhxnrmYo8avbWBja+WVFLPxfsB4qF/MRGDZgBu2Myai5WjF6nwB
         v4d7POJpuGIYcYANWoKza7uSRiqPEfIItpKIJVzN6v7LDFeWVUu89k1k/RObMO7xMS6G
         NAyJ8r8rL14ueqzH5/ZMEqb0xIY/bTZ9TrNE+IjdaBeEbHQ/bWeog5L2bDDN1Ote2bHU
         3VJfqbysVXQH0X8I5B0sOiY4rL4jrJ3sflrhM8YnJcmOQSa6xdKGP/wKSVUXES60SLbX
         b0MxpY5z4CwuUWq6U6/XGB5k0mMLf4yrMdmHsfsBGI12e+MSfi/chx/MwEPWLQ/ukdZJ
         hftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjNlU8q2y36L4sRDz7WyozzVBMIW4wTXmXo+aeTQepE=;
        b=rfclHKMYmaZ3WoG3Z1/yZILpFAHMusT3/5gbNnKCgpC2Gwz7JlOyXlqXp0YOwxDrzZ
         +8JqxZ+2mw3aXLEXuppiqm0OuKOUPmU88gFOCHGTCbr4LJK0/yvRnNQ7+uBVi/MCEQC0
         Uux1ZqEACon403MApuDcIIaV2gHx4jb2eKWVzl68LySWerkNEatK1J4A0frEpCVXoGJS
         teaHSotuUwW7NTzUzLWwm9an3snxmaC6WxA7xnNcDzkzFpiXDP4TIFrZSGzPloUadrTc
         6osNbfvqNE138Xo7S1fZqQIbG4QsLeHM6TrOLXo/lfvE5Zm1Tm1JDhkngBAQEkYPDyYc
         7hRg==
X-Gm-Message-State: ANoB5plc36N96NUK2GATbJ0sVWDWx3Pb7DTFuh9vTJUq54VQfWZ2+wL+
        rm2zUUvUWNGPAEQPUbvDV/mp+e8787+j1yvrgSrJdw==
X-Google-Smtp-Source: AA0mqf4eW2j5xeUD3XT6l4PcGb3bqpIe7DMA8nLtU3wrTQp86Z8ebjhL0qefUE1DLcnpS0Vru26vexv7J82nnBZVc2U=
X-Received: by 2002:a05:6402:2948:b0:463:bc31:2604 with SMTP id
 ed8-20020a056402294800b00463bc312604mr284934edb.32.1668676053056; Thu, 17 Nov
 2022 01:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20221116065717.3069712-1-ruanjinjie@huawei.com>
In-Reply-To: <20221116065717.3069712-1-ruanjinjie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Nov 2022 10:07:21 +0100
Message-ID: <CACRpkdZCwDvJkOr+7_3ua_sb1p70pMDcx7UTcH=VTKQBvX9iLA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: ste_dma40: use devm_request_irq to avoid
 missing free_irq() in error path
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     vkoul@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 8:01 AM ruanjinjie <ruanjinjie@huawei.com> wrote:

> free_irq() is missing in some cases of error in d40_probe(), use
> devm_request_irq to fix that.
>
> Fixes: d7b7ecce4bcb ("ste_dma40: Rename a jump label in d40_probe()")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - use devm_request_irq instead of adding free_irq() to fix the problem.

Thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
