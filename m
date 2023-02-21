Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F869E987
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBUVbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjBUVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:31:43 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF521E5DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:31:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eg37so18893000edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WokcBLUnLSvFGi3BJyxHBNtjfEojDdGdaUBZIAtdp4s=;
        b=Z8fWeEjGHvPG6JVdryyxrCdAVI3nC1xgRLImgd5JYTLys0lbg6K9T9/bKIVU2pxAYq
         buyL+iGVc8ZxTzavZWiNk2peOlZUn+afRv9/LAf7YibQppVfDrabdLNyPLBvNFEel7FG
         Q6683yfIWP/EAL9pj4GrYv7q5bPSzT7lqTMMafhtQU2MAhzx+xlDm70LbkZOdMmpVm2k
         63T8vwVi4R9kVuF/gjxJStgsO2uST8/J7saB2E3On0KG21kGz/Td1ul3t4QugFSxJ3O6
         JUOMS8OtHGg9McIGMJlqhize/zO5ft2pWzH43XJAIYHPYhih0MCPIxu3IMjAu73RSUwI
         AhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WokcBLUnLSvFGi3BJyxHBNtjfEojDdGdaUBZIAtdp4s=;
        b=pS2VuuxIvE36C4PkkV4OP5v+vJLiorrIsHgIv5JjyMoTd3bvTtBMNXnfOLwtDugyLk
         nus3e29K9NmAu2M4nKzNKjD8ChFdjS07reGztzbIrSA/xVRizkTliP18e2ZPgiQseGUj
         K1m4KdprZw2EMTco9rmfB4JI1cnNbQWPHsHclVEQwLcJk+Qbac44ac0XJZ0jDgD6BLnK
         l2y8LCOU5pxP9+2kuEt0/yNAP3q2YpSZnNcdfwEtRDOyL6R0kcXLmtVAaZq52s2yOWH7
         M8f6SjDd8vVwB/y/okxfvPctAiYNCGQtWzLm7gqnMkCMmPQyiOVtB0Z6Ghy7sjzW3DvY
         3OJg==
X-Gm-Message-State: AO0yUKVqWUaAU+XIrre9hD7ReAUjAppgoMUP6Zw/inMcZGTRtiPqiN4P
        z6mdIjkVfpqY9HCi8Lgd1PkejP4/mzDKZrrsCUM5T5yx06w=
X-Google-Smtp-Source: AK7set9vk9Xi3fa2gAaKh/M40NvhtCdUZG0stm4aPGsfWumGGlTYYztJ7TujIRU+FWLYsnYhvWwu8Kb2bpljPLahEZc=
X-Received: by 2002:a17:906:8144:b0:8e3:da0f:f9b7 with SMTP id
 z4-20020a170906814400b008e3da0ff9b7mr866379ejw.4.1677015100846; Tue, 21 Feb
 2023 13:31:40 -0800 (PST)
MIME-Version: 1.0
References: <6474e163-e61a-e04c-590d-60c674dc7ed9@sberdevices.ru>
In-Reply-To: <6474e163-e61a-e04c-590d-60c674dc7ed9@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 Feb 2023 22:31:30 +0100
Message-ID: <CAFBinCCaQ1fwFmV=CtihP+peFGTiHfVXtdKmQYJnX3a+-wNuzg@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: meson: initialize struct with zeroes
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        Krasnov Arseniy <oxffffaa@gmail.com>
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

Hello Arseniy,

On Tue, Feb 21, 2023 at 11:07 AM Arseniy Krasnov
<AVKrasnov@sberdevices.ru> wrote:
>
> This structure must be zeroed, because it's field 'hw->core' is used as
> 'parent' in 'clk_core_fill_parent_index()', but it will be uninitialized.
> This happens, because when this struct is not zeroed, pointer 'hw' is
> "initialized" by garbage, which is valid pointer, but points to some
> garbage. So 'hw' will be dereferenced, but 'core' contains some random
> data which will be interpreted as pointer.
I think this should be written as "interpreted as a pointer". I'm not
a native English speaker though, so I'm hoping that someone else can
provide feedback as well.

[...]
> Fixes: 1e4d3ba66888 ("mtd: rawnand: meson: fix the clock")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Regardless of my comment above:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
