Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268D5EB4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIZWli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiIZWle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:41:34 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ABB90806
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:41:33 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m81so10075246oia.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tz2cEwqQBI5KOid9Ym3jdh1CtIss2mqT+yeVpI5D5SM=;
        b=5WMM3Qo+EagYcdk/4XzPR7M1Nkp26RLOWPb1x61inBt4ynUprqDGH/n2uKScMC+AV0
         EcFTOsJ5mdWcraZ1soCsfLi7zx5w0vD/VBx5UsNCU5hsv98jWYpXFxAnSq162zbHwfMx
         iqLiAf99fvx4Bmp4Z2Bt3Tz4f+c4u0SJditYcS0saNoVVvvEDIiw4VAuTOXVoOpURqDs
         l5S/Xz9djK88fduZ+aQgRsHpuZF3xxnJwOqhpcVPGQ3n7OUFOqtY0lcurwbzfVsrLbco
         vxExn+Zqc/jBXo9VBrKMIPYnRCffnj/oBxm1X3GS0LIglmabtIgcE8YOTyR+w1dDwro1
         YTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tz2cEwqQBI5KOid9Ym3jdh1CtIss2mqT+yeVpI5D5SM=;
        b=xRD3RLAacnn2tqFo1vFb5NMqPqXVj3Jc6XbGqXV1H3inqXORJhhi6rIIVkk+HV9+No
         PJ/eQrhs8HkWLKUVwi8hH5yV2iIndWo1CqM+dTQPZvX00yWU5Qg4nls4EdsfRbFcEAsJ
         ZkmomdB1VRr/Hc7mjnnG0LJrwPn3KMvG1SW9v2rLWbM/msfUuZ0Uver3qBHi6FtOOHpb
         7R81u6vsqqs6jHfopTnJ6M+SAuMajQfPZK+a64MdI+nAG1tLSvFagJsE7ADeoIdK3ybB
         7I4+WE0+o1N7Ou9cXwm1n/+3Z3RepUhhCmkUFknK3a13Vik2PCr28OmXX2fEg+4CzrX0
         ZAeg==
X-Gm-Message-State: ACrzQf1ItiGVh9hehUJpHHc7+cdpFHFg3bJmf61kHLXueSRlA1WtAHFE
        W2db0Q7rFj210fDIfk75pjyhgLPWHVMp2zr1OBy3yTgXzQ==
X-Google-Smtp-Source: AMsMyM4w8nRvJwif6MuQV1Y60DIJ5t08oIJfRG7hIO1WM7+Mw7vUvSGUBu9AGMzwflSnF4bjdKW2wOh01hwIbLeR7Ws=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr488080oiv.51.1664232092411; Mon, 26 Sep
 2022 15:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220926131643.146502-1-nathanl@linux.ibm.com> <20220926131643.146502-3-nathanl@linux.ibm.com>
In-Reply-To: <20220926131643.146502-3-nathanl@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Sep 2022 18:41:21 -0400
Message-ID: <CAHC9VhS9kJ4aEp_Y_imcsj_0JOn523Au=ct6uQEPjNDVVjYxVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/rtas: block error injection when locked down
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org,
        mpe@ellerman.id.au, serge@hallyn.com, ajd@linux.ibm.com,
        gcwilson@linux.ibm.com, nayna@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 9:18 AM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> The error injection facility on pseries VMs allows corruption of
> arbitrary guest memory, potentially enabling a sufficiently privileged
> user to disable lockdown or perform other modifications of the running
> kernel via the rtas syscall.
>
> Block the PAPR error injection facility from being opened or called
> when locked down.
>
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  arch/powerpc/kernel/rtas.c | 25 ++++++++++++++++++++++++-
>  include/linux/security.h   |  1 +
>  security/security.c        |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)

The lockdown changes are trivial, but they look fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

-- 
paul-moore.com
