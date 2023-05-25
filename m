Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06E4711839
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbjEYUhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjEYUhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:37:39 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B7612E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:37:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-776fdba68ecso3958939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685047056; x=1687639056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q5BIhyHxy2KwWgZBKI5+TSZP/AvpzgkEZSqlGxlLuw=;
        b=Kx00xw4a5iHvK4aXJD/fCMsNYirQ9jNTa3Jel53gQybyfNTYFlM4/fIiXXbwi2A0Vq
         mS9R4FK2WowLhVOBThQH9axk/FkCGSZ/FuXzLXA/8AU4ETFATduKcLeUW9VIFjmsVbhz
         A22SW0BP3RR6eq8aBME3RPGM5T+ey2iRYxZRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685047056; x=1687639056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q5BIhyHxy2KwWgZBKI5+TSZP/AvpzgkEZSqlGxlLuw=;
        b=PBnR0ojIUWytC3tt4Txk4uof5wQMtHN2uHIBGC42pl2Hr3RP1ggpxWRNorma2kOLHo
         sF+HM2973EN1G/8BzW4WfCl0NbzfUpRmNPzJBOI/CCVuJBNgtTIC2r8Ifrrog8okKuH6
         ClOCwgt6PX7L/2AdwXZIGHKSnDZGGxkldlft1BRKZOAchR9csbPoBpeP3VFdkzuUAegL
         iUWfEdwayeSDN18PpVEHRosDLOyTHnQCDChzgux1bpIZcewuJ1oJnZaYRUfhzOlhvI3D
         cuxck5wcuDc5EoQiD4DoMD3NK/2XnK12cNytm3IkVh/KwPGj4DYnaBYlr7inlVm2ODHV
         x+sg==
X-Gm-Message-State: AC+VfDxfFrFu9daoq1Drel1ciiUCtbVrEhsYI0KufUS0oCDBV65+mihL
        b4OvUAVAUxa5Mq1k5JePVt6Ma1ZD1YCahQXRUQs=
X-Google-Smtp-Source: ACHHUZ5J0cXRRmsvkyOKZm8xTW3p+dQa9eNft0BI1cmpv1ny44NQDfJf7ENlBQGFHjn51HGcykhhog==
X-Received: by 2002:a6b:640d:0:b0:776:fd5d:bee7 with SMTP id t13-20020a6b640d000000b00776fd5dbee7mr374130iog.18.1685047056596;
        Thu, 25 May 2023 13:37:36 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id f2-20020a028482000000b0040fbb3bd38csm653073jai.145.2023.05.25.13.37.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 13:37:35 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-33164ec77ccso38915ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:37:35 -0700 (PDT)
X-Received: by 2002:a05:6e02:1581:b0:320:9759:bf6b with SMTP id
 m1-20020a056e02158100b003209759bf6bmr68419ilu.3.1685047055386; Thu, 25 May
 2023 13:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230525093159.223817-1-john.ogness@linutronix.de> <20230525093159.223817-3-john.ogness@linutronix.de>
In-Reply-To: <20230525093159.223817-3-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 13:37:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U42xgt1PBdpaqtuzHOAjVUdWRyRaE0OpWiiMm-B1qf7g@mail.gmail.com>
Message-ID: <CAD=FV=U42xgt1PBdpaqtuzHOAjVUdWRyRaE0OpWiiMm-B1qf7g@mail.gmail.com>
Subject: Re: [PATCH tty v1 2/8] serial: core: lock port for stop_rx() in uart_suspend_port()
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

On Thu, May 25, 2023 at 2:35=E2=80=AFAM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> The uarts_ops stop_rx() callback expects that the port->lock is
> taken and interrupts are disabled.
>
> Fixes: c9d2325cdb92 ("serial: core: Do stop_rx in suspend path for consol=
e if console_suspend is disabled")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/serial_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
