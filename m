Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC46D6BD76C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCPRrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCPRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:47:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E5D5886;
        Thu, 16 Mar 2023 10:47:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bj12so1618885pfb.8;
        Thu, 16 Mar 2023 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678988868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9SAhDTUfzzdtxFRaJt2z4xXgPUjuKH9QoOiW/CTOH4=;
        b=oxGodCYRFlNab53gMZGwNONjRXnLYO4I+5Zkgl/20hzsCzdwkBwJYnLRV5wUOnR0hA
         869xJqSounKutKmnyK+5bMO6jN9wtT/2QUhyNwjTPkQkWbvsqbTrTXt7+G/O/wq6N4Ym
         MA1mdDEMmun5OaMeKmqoCXpwj0GnxpuTSwduvOiyEdKhipLylZWfYQTjZ4jHojPGzDkz
         yrwBVNeLFhkO+MZNiaZ5mBKpExh8ovjHXoUuDQgp/57V0+CqR5sai+NEDpLbU3w84uOf
         whtZFVQwvH10kWPZPbKF9s0C4ssyFegv3hDai1+h+R/9pTfZJnWtzdG/V1Z1ZxMWvLu0
         yF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9SAhDTUfzzdtxFRaJt2z4xXgPUjuKH9QoOiW/CTOH4=;
        b=X6x3qyTfjXkC6X/rQNDTmvpTAr3BtmZ7qsUiTvhjb+6/nOGTt+zRwY59oAP9+qEn2h
         5UPv5WZ4YWp4DG2bsGIzfdwZ4kkY2zlftdFHn3UYwxs1a86BEJPHLSxI6iudzKRdlQkH
         f3hfgAfpQKm5v9CgPXU5+X7CVvmbT2jKLrOCC+qkBxbR8wXZ0v/LTZYKfJkOKQuhjb8t
         DlxcQoL1T5zheljRSFMRHcxGfhJ+0x0vi0nuliX0tMqcn19NWWyOooZfIf6GAqLQTpgM
         AoTlq7N5EGyPR0S5KujNttyIqdPImc65hrjy56JkCySy01Akrw6gShh7xA0vKdBD8q0B
         0Nbg==
X-Gm-Message-State: AO0yUKXVl8TQL50YugjGarTd0qqE9Gr9qKo3CGiUjC86qdS9R4MG86Tb
        UnWCt7Z1KzY5Iok/hvVbxtR4kPQNQ82eUkGuLJs=
X-Google-Smtp-Source: AK7set92SsjYIm5T6L+HFODIGzXVebVZUaFW1HhF/vFX0B9Armoh2TNXAih5sz2wP4vEi6vTmbIf1T9h/xmsB3Oj1Ww=
X-Received: by 2002:a05:6a00:148e:b0:625:563e:7d17 with SMTP id
 v14-20020a056a00148e00b00625563e7d17mr1989258pfu.0.1678988868287; Thu, 16 Mar
 2023 10:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230316174432.1592087-1-zyytlz.wz@163.com>
In-Reply-To: <20230316174432.1592087-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Mar 2023 01:47:35 +0800
Message-ID: <CAJedcCz1+0ceVSjhnLwjDODcqPYLGPB1MEfFeTyrw0KH3e-0Qw@mail.gmail.com>
Subject: Re: [PATCH v3] usbip: vudc: Fix use after free bug in vudc_remove due
 to race condition
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry this is not v3 but v1, I will resubmit v1 again. Sorry again for
my mistake.

Thanks,
Zheng

Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=94 01:44=E5=86=99=E9=81=93=EF=BC=9A
>
> In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v_time=
r.
>
> When it calls usbip_sockfd_store, it will call v_start_timer to start the
> timer work.
>
> When we call vudc_remove to remove the driver, theremay be a sequence as
> follows:
>
> Fix it by shutdown the timer work before cleanup in vudc_remove.
>
> Note that removing a driver is a root-only operation, and should never
> happen.
>
> CPU0                  CPU1
>
>                      |v_timer
> vudc_remove          |
> kfree(udc);          |
> //free shost         |
>                      |udc->gadget
>                      |//use
>
> Fixes: b6a0ca111867 ("usbip: vudc: Add UDC specific ops")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/usb/usbip/vudc_dev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
> index 2bc428f2e261..33d0991755bb 100644
> --- a/drivers/usb/usbip/vudc_dev.c
> +++ b/drivers/usb/usbip/vudc_dev.c
> @@ -633,6 +633,7 @@ int vudc_remove(struct platform_device *pdev)
>  {
>         struct vudc *udc =3D platform_get_drvdata(pdev);
>
> +       timer_shutdown_sync(&udc->timer);
>         usb_del_gadget_udc(&udc->gadget);
>         cleanup_vudc_hw(udc);
>         kfree(udc);
> --
> 2.25.1
>
