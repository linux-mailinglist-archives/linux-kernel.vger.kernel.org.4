Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C767CFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjAZPUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjAZPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:19:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5076DFF6;
        Thu, 26 Jan 2023 07:19:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d14so2103028wrr.9;
        Thu, 26 Jan 2023 07:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTcSSL/iGBYJ3OOP/OM1aOCQDWU0nhRLOzQgbipENkk=;
        b=RcN66RxdWLkkJsGprRRgwSGXRDPavM/6ObhgfD9AZIz/g9Zvwzw+3andtdUnNqbolX
         0sTOvlMnf0YWvniod6C2nmgIyBC3sXBPyza49RexUgkKwwAcg7WmHx9QWUpnJxpxZYFL
         5dzL7D2MnWcdog6YJyVnyPQ1st2cJiRp963vhk4jmGXvKhKHP8Z2MYHwCiv5Hi5wCN29
         N7sYYKv107Y7U1/zQkGuyoWmuQ9R/66WwOuMKq2sc4aVXtQvHb6GxfhTygraXB+2FF93
         4NnAMUKtaRHa/nV9t7FESWOWL4KzSttHFWyp84kwjOBAJIwPDAKz5vOLxYEECpE0e0py
         Erhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTcSSL/iGBYJ3OOP/OM1aOCQDWU0nhRLOzQgbipENkk=;
        b=rg9taq7/rg0v3l9t/LWzxsHKS1gr0u5xOr+ji7IGMSDkm4+kPAcXldoQU3fhuj2+A+
         lZOqrnAu63pD0k9o80Lxl8XoFkJD3eRYPSIQzmWEjIdiF22scfyKklz73lRmZJ903Bgm
         LtKMWDs36s+C+Th20D8sx8j5PIHGIYHU2/ifaXA/EIhBnGaVYXmFXH8l0M6PcLyPah/9
         prRq7dYQiiI/kClKVSXVm3BdDBw6EZA6imoT2OofsgypgqCwRP0WyF3r/DPM1iwrQgAn
         P86waC9Odl/gaLdSYe5LGiJNOpXdtpT4XBRBWCxmB24xyPwxZt5S+v0/A46m9qPv7aa5
         7JsQ==
X-Gm-Message-State: AFqh2koZhprXPh1F009f6U2+U7sVgDMsvT7Y9LAPGoyhgsVbAqfx7opf
        an4tWVdG8bpHrhRMUUgq6r8=
X-Google-Smtp-Source: AMrXdXtJU+W0HRSrmOB1NYRP2NX43QNH2so5vwrpDreKKFJglc9+HVkPUWl2icOcdtE4vQCGudlsmw==
X-Received: by 2002:a05:6000:1f14:b0:2bd:c03f:c010 with SMTP id bv20-20020a0560001f1400b002bdc03fc010mr32395864wrb.40.1674746336622;
        Thu, 26 Jan 2023 07:18:56 -0800 (PST)
Received: from smtpclient.apple (p5dda2d96.dip0.t-ipconnect.de. [93.218.45.150])
        by smtp.gmail.com with ESMTPSA id q12-20020a056000136c00b002882600e8a0sm1585143wrz.12.2023.01.26.07.18.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:18:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH] pwm: imx27: fix race condition .apply,.get_state
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
In-Reply-To: <20230125164316.wkoi4qfzbhna3h6g@pengutronix.de>
Date:   Thu, 26 Jan 2023 16:18:45 +0100
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leif Middelschulte <Leif.Middelschulte@klsmartin.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <76FC6AC2-7588-4C87-9EDF-F7D057683E48@gmail.com>
References: <20230125160142.586358-1-Leif.Middelschulte@gmail.com>
 <20230125164316.wkoi4qfzbhna3h6g@pengutronix.de>
To:     =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

> Am 25.01.2023 um 17:43 schrieb Uwe Kleine-K=C3=B6nig =
<u.kleine-koenig@pengutronix.de>:
>=20
> Hello Leif,
>=20
> first of all thanks for the patch.

Thank you for supporting the effort.

>=20
> On Wed, Jan 25, 2023 at 05:01:42PM +0100, Leif Middelschulte wrote:
>> From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
>>=20
>> A race condition might occur, ultimately leading to switching off the
>> PWM that is supposed to be turned on.
>> The condition is more likely, if `CONFIG_PWM_DEBUG` is set and the =
PWM
>> has been enabled before Linux is booted.
>=20
> As I understand it there is no problem if PWM_DEBUG is off, isn't it?

There is =E2=80=9Eno problem=E2=80=9C as in: It=E2=80=99s not obvious at =
the moment/it slumbers. That=E2=80=99s true.

>=20
>> After writing some value to the register linked to the duty cycle
>> (`MX3_PWMSAR`), the related debug function
>> (`core.c:pwm_apply_state_debug`) reads back (`.get_state`)
>> a wrong value (`0`) as the configured duty cycle. This value is =
stored
>> as part of a temporary state variable that it subsequently reapplies
>> to the PWM for testing purposes. Which, effectively, turns off the =
PWM.
>=20
> I thought the thing is: Reading PWMSAR yields the duty_cycle that is
> currently in use. Now if .apply() is called with a new value for =
PWMSAR
> and immediately after that .get_state() reads out PWMSAR the previous
> period (with the previous duty_cycle) probably isn't completed yet and
> so the old value is read.
>=20
> In this case it wouldn't always be 0 which is read. (Hmm, but with the
> conversion we had about this issue, my theory sounds wrong?!)

This is correct. The value will not always be 0, but the current and/or =
future
value of the sample FIFO.

The problem is that it can be quiet hard to tell exactly which value =
will be
read back, as the PWM features a FIFO. The read back value depends on
the timing between register read and write.

>=20
> Maybe instead of waiting in .apply() (which hurts active consumers),
> only wait in .get_state() until MX3_PWMSR_FIFOAV drops to zero?

This is what I=E2=80=99ve implemented in v2 of this patch.

>=20
> Apart from that, the markdown(?) style you use is unusual for kernel
> commit logs and comments. I'd write:
>=20
> With CONFIG_PWM_DEBUG=3Dy after writing a value to the PWMSAR
> register in .apply(), the register is read in .get_state().
> Unless a period completed in the meantime, this read yields the
> previously used duty cycle configuration. As the PWM_DEBUG code
> applies the read out configuration for testing purposes this
> effectively undoes the intended effect by rewriting the previous
> hardware state.

Thank you for pointing this out. I have adopted the suggested =
description
In v2 of this patch.

>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> Industrial Linux Solutions                 | =
https://www.pengutronix.de/ |

Thanks again,

Leif

