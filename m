Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1906AF2A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjCGSye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjCGSyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:54:07 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218389AFE5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:42:03 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id b16so5771787iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678214519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIBoIM/MahzmKHcLNphJUdBT59zK6GNgrma5w7fsSlM=;
        b=RSDaAUvJWdX/pgYCQD9V62BikNMQtSk4X+T8iCz13FrSmzG8etaoNw+evqN5EpGvwq
         A3kS3pRnZHrG0Y5rgBHrGQqy9s7dpWwDTXU3PJjJkoZrMlhYEeLVn1ZCJxuBMW0Ct4Uu
         3ojVYRwF9Q5Lf4yMbgwCqvKRi+0J2C4+iPcIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIBoIM/MahzmKHcLNphJUdBT59zK6GNgrma5w7fsSlM=;
        b=aFfG2jkk1nFLZRLkIgao4EEFFwfsXS//+Z8/v1ngxywCQXXHOW69x4Rb1wxBNhC43A
         eYOu/kp33FsTjnu1LvfE6CuATjjSa7DdKF3qYC4A20cPR7Ks2eiTb2iXeHnqguiDXeAU
         jCOdArgQN9VHtvheWHh9T4LbvCOZcP/T77ZpdT0HSzt1JMbWInNBUJcczHEWYXUW4DjL
         0zJMJT249CeY60JUgzxlPCqieLYUUbagzJrsUwrhMfffnnGbNhLNFNT6OqwGk61/FQFn
         vxbcW5D82qcAglJNJ+yxC6CVChZNAG6ZaOZJQuB8n9xKx4ehHhrT69nXFNKTlCu1U+dw
         q7Iw==
X-Gm-Message-State: AO0yUKWT44FVTqz2oySXqAOTZdYzX3Rh+0YSgBtGtiwdheIJJcYauVUq
        oisFrAXpjEy6I+LIJ8UnW7F+yQxW8iWKEVc7c8I=
X-Google-Smtp-Source: AK7set8iCYFDCOdz8c1g0x8gZpbGeR670sH3FzT5i9jaOB+HFPEkC271/zqDsuef0kHZ2u2Wi/fxRQ==
X-Received: by 2002:a6b:d802:0:b0:74c:ae72:5b9a with SMTP id y2-20020a6bd802000000b0074cae725b9amr9083055iob.4.1678214519201;
        Tue, 07 Mar 2023 10:41:59 -0800 (PST)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d894d000000b00734d27b267dsm4315781iot.17.2023.03.07.10.41.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 10:41:58 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id h7so4863161ila.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 10:41:58 -0800 (PST)
X-Received: by 2002:a05:6e02:928:b0:317:fc57:d2f7 with SMTP id
 o8-20020a056e02092800b00317fc57d2f7mr7437142ilt.6.1678214517983; Tue, 07 Mar
 2023 10:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20230307164405.14218-1-johan+linaro@kernel.org> <20230307164405.14218-4-johan+linaro@kernel.org>
In-Reply-To: <20230307164405.14218-4-johan+linaro@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Mar 2023 10:41:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VR5oCThAuc29Bum-VHQUcH_H+s4nr55YpJk1aYaqZKTQ@mail.gmail.com>
Message-ID: <CAD=FV=VR5oCThAuc29Bum-VHQUcH_H+s4nr55YpJk1aYaqZKTQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] serial: qcom-geni: fix mapping of empty DMA buffer
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 7, 2023 at 8:43=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Make sure that there is data in the ring buffer before trying to set up
> a zero-length DMA transfer.
>
> This specifically fixes the following warning when unmapping the empty
> buffer on the sc8280xp-crd:
>
>    WARNING: CPU: 0 PID: 138 at drivers/iommu/dma-iommu.c:1046 iommu_dma_u=
nmap_page+0xbc/0xd8
>    ...
>    Call trace:
>     iommu_dma_unmap_page+0xbc/0xd8
>     dma_unmap_page_attrs+0x30/0x1c8
>     geni_se_tx_dma_unprep+0x28/0x38
>     qcom_geni_serial_isr+0x358/0x75c
>
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for seri=
al engine DMA")
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 2aa3872e6283..9871225b2f9b 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -631,6 +631,9 @@ static void qcom_geni_serial_start_tx_dma(struct uart=
_port *uport)
>         if (port->tx_dma_addr)
>                 return;
>
> +       if (uart_circ_empty(xmit))
> +               return;

I guess you could remove the uart_circ_empty() test in
qcom_geni_serial_handle_tx_dma() now? In any case, with or without
that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
