Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F179725CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbjFGLUD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 07:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjFGLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:19:58 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE41E6C;
        Wed,  7 Jun 2023 04:19:57 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-977c8baa86fso127275466b.0;
        Wed, 07 Jun 2023 04:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686136796; x=1688728796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyfFJWQd9X29oCetBrv8kPxo6ktxzcpnkHRc+KxeSac=;
        b=kMqZ2cN/QSFpaF8Qj6aGCMKBbhlYweDJgV1g0EH470pia2YdNMpHfOCRgIap9jyt6c
         CoAbexsfGnMbsyNrKyFsohq6nyFbEKpUhZpp7RFwHjB/S7/o6spa1RCmntfvGVTV/QaG
         4p2vGmSPozHUEORBtpHNghAIMNhexrGjNN4eip5LwMwgkuAOFLMkpgipu8YQiuLycQcY
         gi/zJrC0A5I30zYSz3NqltKXqX4DsrTkwdnKVDh+FmJ2f6RitaX+zZPTaZBBmP6sXJS6
         IsJ6voTK0sbyw4sP1bZZ1J43J1i2AD+03fe9LP9+9c57oBGJqbOBVV6OMYKmpcMWkAYh
         Fk9Q==
X-Gm-Message-State: AC+VfDxHFdo3qQnXjVuU0Ho6/vkZiOywT3xm1obxICTuMHu6Lqna7xHx
        zIGN9kYUEB/J1JQtk3SW1fylfvUmWCA620V8qe4=
X-Google-Smtp-Source: ACHHUZ6uB7lkwk0D1ggcEOKYyDgmBy+aW7rS19enPdaJbtrzImYvFeTsyk4SvxyDn9ZYhwpsacXs6kVJ97t/mKzLks8=
X-Received: by 2002:a17:906:73cc:b0:977:cc87:62b5 with SMTP id
 n12-20020a17090673cc00b00977cc8762b5mr1374862ejl.4.1686136795531; Wed, 07 Jun
 2023 04:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230607034403.2885-1-james.liu@hpe.com>
In-Reply-To: <20230607034403.2885-1-james.liu@hpe.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Jun 2023 13:19:42 +0200
Message-ID: <CAJZ5v0hTsEzFKvRf-MHpUxyJdFDUqc2ZL63s6BkyJyFtEzxvhw@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: reboot: Increase the delay to avoid racing after
 writing to ACPI RESET_REG on AMD Milan platforms.
To:     James Liu <james.liu@hpe.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hpelk@lists.osp.hpe.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 5:44 AM James Liu <james.liu@hpe.com> wrote:
>
> For AMD Milan platforms, the delay of 15ms is insufficient to avoid racing
> of reboot mechanisms. That said, the AMD Milan processors don't reboot
> in 15ms after invoking acpi_reset().
>
> The proposed 50ms delay can effectively work around this issue.
> This extended delay aligns better with ACPI v6.4 (i.e., sec. 4.8.4.6),
> which indicates that ideally OSPM should execute spin loops on the CPUs
> in the system following a write to this register.
>
> Signed-off-by: James Liu <james.liu@hpe.com>

Why do you want to affect everyone (including guest kernels running in
virtual machines AFAICS) in order to address a problem specific to one
platform?

Wouldn't it be better to quirk that platform and document the quirk properly?

> ---
>  drivers/acpi/reboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> index b79b7c99c237..002f7c7814a1 100644
> --- a/drivers/acpi/reboot.c
> +++ b/drivers/acpi/reboot.c
> @@ -78,5 +78,5 @@ void acpi_reboot(void)
>          * The 15ms delay has been found to be long enough for the system
>          * to reboot on the affected platforms.
>          */
> -       mdelay(15);
> +       mdelay(50);
>  }
> --
> 2.40.1
>
