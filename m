Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80CD711075
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjEYQIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjEYQH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:07:58 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6A9E58
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:07:36 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-331333e6bf1so5329655ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685030855; x=1687622855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9miRu1VdQdNXOCFnd7Ap8lDxsJRIToGRq1hdp3kNIU=;
        b=WCbCBCp/6pWCecbO7TofThM2e3nM40pk6AstOeeLTVDdW9q230thQnJZ7Dm7ahDTEF
         fkOSc3fH0M4M4/f+W8ul4womoZ2iEm5AJIAW8J1KQ4xthwEv+uoyzbfkYzOxFk07SV44
         y34ldp8CnPSi7Ma6gCtXSV+NWxHcZq0E52EFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030855; x=1687622855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9miRu1VdQdNXOCFnd7Ap8lDxsJRIToGRq1hdp3kNIU=;
        b=UYESDHJ68a13u5vimYD/3EsxbVbdulrvdwTvEbIIBSx2Dfc7MDMve8jgwP7ltZv1hX
         T2vVjkUH5STs1ALnOmciFOcmVnDotV6vCpoyqmqWJgH7Nn7du4zSoxaXX3ZTFMxfkQ35
         sPI1kJjMhb6WWszVovQSx/1FtrBfx8MBOiGNyvMKz1kSI4ySN/8lAx21OL41/AdTxISH
         WwBGAeIOVjnPeCVoV9TuK0gcULLNzcAoNAiKcUzEQT2TBc0ZvdiSbmxFXE+ZJl5yq7yR
         j0t/mpLH7sNzNUSRGETF4f2hdlGROohdVxhoCZTVR1YPkycrPNownUk3qGVG9n/xIbuk
         363g==
X-Gm-Message-State: AC+VfDxRL/zPlFKEBGXkXdF54c9FaL8fZYj8A+Yu96w6GHiygPeU8pAG
        CKcgF9HstKcbpFtUK2ss6QbK7l2MkSIKWKDpXDc=
X-Google-Smtp-Source: ACHHUZ5adc+KwVnPLr6w58giR02FPGGU3ReLPjCNAHSvR8Oz//Gakm1Hx8gWyxjcKDixL93BP5KyPQ==
X-Received: by 2002:a92:690b:0:b0:33a:63b9:db83 with SMTP id e11-20020a92690b000000b0033a63b9db83mr6346390ilc.19.1685030855195;
        Thu, 25 May 2023 09:07:35 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id v6-20020a92c6c6000000b00333b5ae4ab7sm398623ilm.87.2023.05.25.09.07.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:07:34 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33164ec77ccso191645ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:07:34 -0700 (PDT)
X-Received: by 2002:a05:6e02:17c5:b0:337:8a1b:b9ee with SMTP id
 z5-20020a056e0217c500b003378a1bb9eemr1742ilu.14.1685030853923; Thu, 25 May
 2023 09:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230525093159.223817-1-john.ogness@linutronix.de> <20230525093159.223817-5-john.ogness@linutronix.de>
In-Reply-To: <20230525093159.223817-5-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 09:07:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UPZOOW-K8XMfnjn-BGaMnr6Ee44FimpB=ZnrOJ6N3ngA@mail.gmail.com>
Message-ID: <CAD=FV=UPZOOW-K8XMfnjn-BGaMnr6Ee44FimpB=ZnrOJ6N3ngA@mail.gmail.com>
Subject: Re: [PATCH tty v1 4/8] serial: core: lock port for start_rx() in uart_resume_port()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 25, 2023 at 2:34=E2=80=AFAM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> The only user of the start_rx() callback (qcom_geni) directly calls
> its own stop_rx() callback. Since stop_rx() requires that the
> port->lock is taken and interrupts are disabled, the start_rx()
> callback has the same requirement.
>
> Fixes: cfab87c2c271 ("serial: core: Introduce callback for start_rx and d=
o stop_rx in suspend only if this callback implementation is present.")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/serial_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 37ad53616372..f856c7fae2fd 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2430,8 +2430,11 @@ int uart_resume_port(struct uart_driver *drv, stru=
ct uart_port *uport)
>                 if (console_suspend_enabled)
>                         uart_change_pm(state, UART_PM_STATE_ON);
>                 uport->ops->set_termios(uport, &termios, NULL);
> -               if (!console_suspend_enabled && uport->ops->start_rx)
> +               if (!console_suspend_enabled && uport->ops->start_rx) {
> +                       spin_lock_irq(&uport->lock);
>                         uport->ops->start_rx(uport);
> +                       spin_unlock_irq(&uport->lock);
> +               }

Seems right, but shouldn't you also fix the call to stop_rx() that the
same commit cfab87c2c271 ("serial: core: Introduce callback for
start_rx and do stop_rx in suspend only if this callback
implementation is present.") added? That one is also missing the lock,
right?

-Doug
