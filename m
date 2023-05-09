Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5226FBD9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjEID0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjEID02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:26:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4502B6581
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 20:26:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso5112512a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 20:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683602786; x=1686194786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ/oXg1cseZUCfQbyTrMIDIhrUodOoHxpaKbd9QSn4E=;
        b=FGTCPsKcPeb7yat4tEXdeq7zn/9IAHnMrLH6uDSOYgQFmB5skomdrhHsTkGcKVijsb
         qysWz6FVYkr4d4Q/M3JqnYAIrKCHSAro5n5IQYz6tR+Yxl6zE3OvvWqX4YPMPvfXC9Gy
         AcUDBcMDrAbVk/sI11NMX8mR4q6ZBcz6BgU/nisS1JNZqQkqwnK7+UGfY36bU0j6Fri6
         EDBMvz3K4JJt49o8XuUmd9GmUffR+R5j1zJFKA8wngXUWfduCggSJLVX7/pJjnQH4icC
         EP4hD/6KeWT3/rl+W7zikpCyDqaGn+fAxRMXxX+CkMzB9zwl9N6ow1CuIF1CSpV34pmi
         iWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683602786; x=1686194786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQ/oXg1cseZUCfQbyTrMIDIhrUodOoHxpaKbd9QSn4E=;
        b=EM9uguM5vSnW8aEHBW9Z4SIqPFQRYcHNNJOuDztoDJrmI21G8XSOZK+gD9fqotMtjA
         ZWXlp+tZTe0H6w7CvHADrAhe7WDh7ZOlRJWnsT8mFh8Ju1QleYJ4o+kpuM3dNB9hxVf6
         FxzIq37RvFnzu67Q0xqKAIbtGfYVBSrxwW12AZq5OVoj+b9NiD0BOoA3xBfMGoBjaK6Y
         JKunjIvk16MQJ+OyHYbCBAMTni1ByFCg6fbkGfhHa3v1D6YDAFlyGX7r6dCTbMCriGMb
         CWPfIl6fPvWgrC4gc7x9c8K0Fwcu4ZHDoX1D29n7NFEks/wl0z9mlp7u6VD+9Yql59Mb
         KQ6A==
X-Gm-Message-State: AC+VfDx956TP+LtNB/95dWaH6uG/u+dgUUSq3Jjhlw1dRsDdopYCQ3yp
        WAvAYW77Et49bIjL+fb91cLMfTE9gRMbA1ryBZE=
X-Google-Smtp-Source: ACHHUZ4fOz9SIwnxMFl+IHKx0mEioL5T64phQ7PiGfTAHBrAD8SivKHteSNb7ZNJzqHWmC4hT/PT3xqsGfRi/DMHxD8=
X-Received: by 2002:a17:90b:1296:b0:24e:596:624f with SMTP id
 fw22-20020a17090b129600b0024e0596624fmr12808987pjb.22.1683602786599; Mon, 08
 May 2023 20:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230117164041.1207412-1-arnd@kernel.org>
In-Reply-To: <20230117164041.1207412-1-arnd@kernel.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 9 May 2023 11:26:14 +0800
Message-ID: <CAJhGHyAG9GhNMGoqK7nNoeBh134zhQj-G5EdxQmS2ESo1i961w@mail.gmail.com>
Subject: Re: [PATCH] workqueue: fix enum type for gcc-13
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Richard Clark <richard.xnu.clark@gmail.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:40=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> In gcc-13, the WORK_STRUCT_WQ_DATA_MASK constant is a signed 64-bit
> type on 32-bit architectures because the enum definition has both
> negative numbers and numbers above LONG_MAX in it:
>
> kernel/workqueue.c: In function 'get_work_pwq':
> kernel/workqueue.c:709:24: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>   709 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
>       |                        ^
> kernel/workqueue.c: In function 'get_work_pool':
> kernel/workqueue.c:737:25: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>   737 |                 return ((struct pool_workqueue *)
>       |                         ^
> kernel/workqueue.c: In function 'get_work_pool_id':
> kernel/workqueue.c:759:25: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>   759 |                 return ((struct pool_workqueue *)
>       |                         ^
>
> Change the enum definition to ensure all values can fit into
> the range of 'unsigned long' on all architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/workqueue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index ac551b8ee7d9..fba8d0154a1e 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -83,7 +83,7 @@ enum {
>
>         /* convenience constants */
>         WORK_STRUCT_FLAG_MASK   =3D (1UL << WORK_STRUCT_FLAG_BITS) - 1,
> -       WORK_STRUCT_WQ_DATA_MASK =3D ~WORK_STRUCT_FLAG_MASK,
> +       WORK_STRUCT_WQ_DATA_MASK =3D (unsigned long)~WORK_STRUCT_FLAG_MAS=
K,
>         WORK_STRUCT_NO_POOL     =3D (unsigned long)WORK_OFFQ_POOL_NONE <<=
 WORK_OFFQ_POOL_SHIFT,

Tested with "old" gcc: 7.3.1

Tested-by: Lai Jiangshan<jiangshanlai@gmail.com>

But I personally prefer to redefine them as non-enum.

>
>         /* bit mask for work_busy() return values */
> --
> 2.39.0
>
