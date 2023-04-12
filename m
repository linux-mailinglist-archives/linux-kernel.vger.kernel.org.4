Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E7F6DFC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjDLRS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDLRS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:18:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1542D55;
        Wed, 12 Apr 2023 10:18:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bs70so6157985pgb.5;
        Wed, 12 Apr 2023 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681319902; x=1683911902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvLbR2CvJm8LYRpIaUIoJ2NSe+iNRSULSNxhdOJFJz8=;
        b=GaP1QCaAtO1xkrbMj6q4LNfCz2tuQ6hRx2vk3ynSAugjrfb01J5hzKs2slm+R2RKS3
         n0vcJuSdIBI09v+exED7q0oBH4/IyHmyyKlpbwxdVE5M0TSnNjRLCvRryU8HxJdRy3Q5
         4AUnK5a/2HSDJboUFg7beHgyInsuK8NRp6ziTFMfSJpM7W5wIMbnYpbIDEdmBHe7fhiW
         TbcOC/GwwchQxvJFBfZsIn8ts4LPFXD9587O6T5TfzaskTscnIgRobZS3dOUY+8Wph3T
         FbBcErIU0cJI9nbJZh2kWh5jprA+CKIpbq5LniudCRNIJr1JkIiEOR8u5R+X9Mlghxhn
         7h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681319902; x=1683911902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvLbR2CvJm8LYRpIaUIoJ2NSe+iNRSULSNxhdOJFJz8=;
        b=MoBKFFO9YKZ16CoA7q/Jww55Zfp14s4WHuzTaQC04jKHixN0tAQ+mZ24PztOvbY3RK
         t45prYGlMxcnAAZgRWeM5MKX7LkRoo0ksIzhQkLG4vFaek0mgK1ked7e3ltMvnHyzH7U
         f8EJSH41Payc7TAsf6NfpS6oel4QykpkF98bXGCRGHsU1hjtbN/q6NOZUV0TWyKYrfNq
         2l1O1vCgZ4CouOWp8afqUv1Fbu8Vl0ghgYcbjvRnMHD28XjIXu/OOZP9pEKlO6BVOnP7
         2RfGkfXRxO37uga+2Aw1T77bzRmqK8j2YQLj/VCK+O5o4utqvpW3zkBlVEzPA58gUQs4
         TTpQ==
X-Gm-Message-State: AAQBX9cTyy3tYn+TmeOhOK9X/7KcmjcSlnGkoMOK3PS2jqtluQK+1lS3
        tZCyRD6WDlQcTzpTqrQ70pfZU8z17mHeAAtyYcE=
X-Google-Smtp-Source: AKy350Yh1a+zxe+KmSWLcWshOnG5GWSu4+Rd4V7terRsd6SwFpcQH6D3ALSgdvnPKM78bk6fdUseluqP1bjoLvoJvVI=
X-Received: by 2002:a63:f349:0:b0:503:a7:d244 with SMTP id t9-20020a63f349000000b0050300a7d244mr4284988pgj.9.1681319901789;
 Wed, 12 Apr 2023 10:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230412171441.18958-1-zyytlz.wz@163.com>
In-Reply-To: <20230412171441.18958-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 13 Apr 2023 01:18:09 +0800
Message-ID: <CAJedcCxqTr0s6dpRgqnUQXaLWzW4ZS3FCtRgF8bYh8U12=FtTA@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: pci-ish: Fix use after free bug in
 ish_remove due to race condition
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     srinivas.pandruvada@linux.intel.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, rafael@kernel.org,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
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

Hi,

I missed some detail in the patch. bh_hbm_work_fn will call
ishtp_hbm_dispatch and access &dev->fw_clients in it.

Best regards,
Zheng

Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8813=E6=97=A5=
=E5=91=A8=E5=9B=9B 01:17=E5=86=99=E9=81=93=EF=BC=9A
>
> In ish_probe, it calls ish_dev_init to init the device. In this function,
> ishtp_device_init is called and &dev->bh_hbm_work is bound with
> bh_hbm_work_fn. recv_hbm may be called to start the timer work.
>
> If we remove the module which will call ish_remove to make cleanup,
> there may be an unfinished work. The possible sequence is as follows:
>
> Fix it by canceling the work before cleanup in ishtp_bus_remove_all_clien=
ts
>
> CPU0                  CPUc1
>
>                     |bh_hbm_work_fn
> ish_remove      |
> ishtp_bus_remove_all_clients  |
> kfree(ishtp_dev->fw_clients); |
>                     |
>                     |&dev->fw_clients[...]
>                     |   //use
>
> Fixes: 3703f53b99e4 ("HID: intel_ish-hid: ISH Transport layer")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-is=
h-hid/ishtp/bus.c
> index 81385ab37fa9..ada7cd08dbeb 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -744,6 +744,7 @@ void ishtp_bus_remove_all_clients(struct ishtp_device=
 *ishtp_dev,
>                  */
>         }
>         spin_unlock_irqrestore(&ishtp_dev->cl_list_lock, flags);
> +       cancel_work_sync(&ishtp_dev->bh_hbm_work);
>
>         /* Release DMA buffers for client messages */
>         ishtp_cl_free_dma_buf(ishtp_dev);
> --
> 2.25.1
>
