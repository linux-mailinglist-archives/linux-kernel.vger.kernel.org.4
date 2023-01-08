Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9AA6615E9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjAHOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjAHOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:51:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47962B1C4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 06:51:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BAE760C8F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 14:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D2C43392
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 14:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673189513;
        bh=KjA5BnH8CE2ygFiZf0BIJuiFfY+3yoOv6vwmcQ3/x6c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MgXxwlwGjziPFX9NjwMHPU/CjvQoYLIMU7mBMw++Tg+D2zbt1LAFDwP04eckcZCIv
         oSecZ/CYh1Ml4RGaN9ASgKEQbtEiqBXK+ZrjcnjrJC8IJwCUJI+pUjeTq2uxW2oeug
         qMoUGWut0EGrSPBBPnViu6hPPREBT134/1OOL78ikxnLE7+XnlIRYM0Kt4OW/2Qb/w
         HHuiOzkHLlZkz6lkwaf6XL+WYUvQml1bi8izeE2ckl7HVPeM7gLqS8XXtTYI4HN8fN
         RuFk/eo1Dg+qgcQx8aUMo12erxVhePwAV5N7VZUj5QcPthUlusYSDH8d8aNNoPAiZY
         tHohof8meqWzg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-4c7d35b37e2so26473417b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 06:51:53 -0800 (PST)
X-Gm-Message-State: AFqh2kovRNbwLAoiRpivo6lEt4H1TmZHp0rvKsyyKXXdjKzcRH3qk3yJ
        82dy8vIXM38g63fRiR2M02qUm+GyPwBxUBnye2w=
X-Google-Smtp-Source: AMrXdXsm/I+2zXpzZ30pXsubs+V9qnmWOjrp3oDKmo5Sd/U+Sm76tzcvWicAFaOHDSMObStcbbmWMOuIQ/HnPqp2qXU=
X-Received: by 2002:a05:690c:c91:b0:4bd:471e:ed00 with SMTP id
 cm17-20020a05690c0c9100b004bd471eed00mr1822331ywb.487.1673189512831; Sun, 08
 Jan 2023 06:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20230107184827.2837347-1-trix@redhat.com>
In-Reply-To: <20230107184827.2837347-1-trix@redhat.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 8 Jan 2023 16:51:26 +0200
X-Gmail-Original-Message-ID: <CAFCwf10tOe4H1wyOeJiDk_0NWUAbsNRXemzg1H_6RBsf7Yz8dw@mail.gmail.com>
Message-ID: <CAFCwf10tOe4H1wyOeJiDk_0NWUAbsNRXemzg1H_6RBsf7Yz8dw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: remove redundant memset
To:     Tom Rix <trix@redhat.com>
Cc:     gregkh@linuxfoundation.org, dliberman@habana.ai,
        osharabi@habana.ai, obitton@habana.ai, talcohen@habana.ai,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 7, 2023 at 8:48 PM Tom Rix <trix@redhat.com> wrote:
>
> From reviewing the code, the line
>   memset(kdata, 0, usize);
> is not needed because kdata is either zeroed by
>   kdata = kzalloc(asize, GFP_KERNEL);
> when allocated at runtime or by
>   char stack_kdata[128] = {0};
> at compile time.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/accel/habanalabs/common/habanalabs_ioctl.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
> index 619d56c40b30..949d38527160 100644
> --- a/drivers/accel/habanalabs/common/habanalabs_ioctl.c
> +++ b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
> @@ -1123,8 +1123,6 @@ static long _hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg,
>                         retcode = -EFAULT;
>                         goto out_err;
>                 }
> -       } else if (cmd & IOC_OUT) {
> -               memset(kdata, 0, usize);
>         }
>
>         retcode = func(hpriv, kdata);
> --
> 2.27.0
>

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.

Thanks,
Oded
