Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9836ACEB4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCFUAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCFT7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:59:54 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B44679B3E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:59:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s11so43520393edy.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678132768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1XTDsCbaUwAZiPAaRhe5A3Pa5A5jC7TGlivcSDkX8s=;
        b=hDTeK8ppPk4RSELh5/QrBizlL3R8ylnpJU0J+2w3OfoBo02rzZ2tWyFLHgqHhv4nce
         xO90scHZeg0EJeYHtRXM8pppazS8MkKkMS+GeVRgLdX+7JxMzJYvUyPo9POH59VNICDz
         BcYxgaa8UvCh48ZbkDASsu0f4urdh86FGnTUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678132768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1XTDsCbaUwAZiPAaRhe5A3Pa5A5jC7TGlivcSDkX8s=;
        b=wKfccg54Gb5cUTbM+T7bk5rVMB3QbxN1BV+QfWowrMNeUOILFBTC2MB5D1l6yhbHx0
         fTl8N7tQpbapE60PjFj9GX9ocULGMU3uVlFOtVparwP6WEWzYAhDt6SVyXjWkJVsbmYE
         ugRXg0jiM39w9d5oAyDLVTnCha71M1IVmltg+lTybocrwVYc/2N6w4qFfcwYEAFb1DOr
         jSxRN6bNMTpsHEMhOAMUDckGn0i0d/xG2cEKDrmuarwU1eO2R/R3AdqohR8La5Z3OaQP
         JXY1ZFRHP/puNv4LVgUtfmhdy13OKW/k2/mkdY+TmzfgKXk/i/nq5bR49BdLsU84898z
         1y7w==
X-Gm-Message-State: AO0yUKW+ZxaeiKcd5FkGZeKl+62TB7lT3NBDIocZv68kg1YsmKjRPghT
        x9Qhk/I0SwoeT13/EfgvUFI5korGzMcADTMzr+UH7lZf
X-Google-Smtp-Source: AK7set9WqycN9rmNoq1Ug8AO+Dn50ImUh9hw9sSgTWQeWlLwyGgd4U5a9h6oJ6KU6QinQ5TO197IyQ==
X-Received: by 2002:a17:906:1405:b0:870:baa6:6762 with SMTP id p5-20020a170906140500b00870baa66762mr12526883ejc.14.1678132767782;
        Mon, 06 Mar 2023 11:59:27 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id bo6-20020a170906d04600b008eb5877a221sm4973304ejb.75.2023.03.06.11.59.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 11:59:27 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id i34so43540423eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:59:26 -0800 (PST)
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr5861816ejb.0.1678132766519; Mon, 06 Mar
 2023 11:59:26 -0800 (PST)
MIME-Version: 1.0
References: <74178f6a-22b1-42f0-aed7-98ef5ad8a690@roeck-us.net>
In-Reply-To: <74178f6a-22b1-42f0-aed7-98ef5ad8a690@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 11:59:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizRZCQr7MXzaarTHsxCtJ+KYmmUFS31xydxSwU4uGz-g@mail.gmail.com>
Message-ID: <CAHk-=wizRZCQr7MXzaarTHsxCtJ+KYmmUFS31xydxSwU4uGz-g@mail.gmail.com>
Subject: Re: Linux 6.3-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 11:53=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> With the patch below applied on top of v6.3-rc1, the crashes are gone:

Thanks for reporting and testing. I think the only one that people hit
in practice was the random.c one, but the others were certainly bugs
too.

I'll commit those things asap since this clearly hits people much too easil=
y.

The lpfc driver should probably be cleaned up, but I'm going to commit
that minimal fix rather than worry about cleanup of some driver for
hardware I've never seen..

             Linus
