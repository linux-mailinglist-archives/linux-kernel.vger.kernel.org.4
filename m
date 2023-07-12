Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E72750D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjGLPuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjGLPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1851BDA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689176956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkK/lE9xVUoE2L0I2FE1bsKN4N40S5rUCyjcnz9lCPs=;
        b=f7JLtL4Nap4buX7ad/9Jc+v8WpUjL/db9pCrxc6MJhg4yu8GRfu+sQHdGH4hZVMZGv0ZUH
        emSvWdNbYmrY+Z9r480wfBozAhy14gs1h6iHMhuN/vQWF80w+WcrtAzroG4gAkP6RvsMcP
        VldktcV1UTLZk/Vikpvonw75eEKa7Is=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-wvhaUxizMxiP9Jwb6MSV7A-1; Wed, 12 Jul 2023 11:49:15 -0400
X-MC-Unique: wvhaUxizMxiP9Jwb6MSV7A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso4162739f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176954; x=1691768954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkK/lE9xVUoE2L0I2FE1bsKN4N40S5rUCyjcnz9lCPs=;
        b=QhBNtapunpodthXZ7+iOtuRBsxF/YlNvE2XWJoGYJVQhah1G0iwa8I6o2jSk9e+19k
         8ep/oY8dokAh2kRlWUfAkOtkQlP+nu2SUCKUeTUzbPXwi8FMBsDQl8A7aHn6UzSx3Nbm
         iFiBFvixhalqexfk7EyFYnShWV8M+srEQ2GnK+arAub0O7zZm9Q1+U70cVC7kS3bmhu4
         UGbCzwrrw2gZiGL4eb3Vsq703oOtlwcy5XazZhWIfF6ymutR/qzF8P0lEeiAu3H2ajYZ
         snIdz7Gq0a1QcpFByoVbySYeJtjYr2IXss9a8B+Q9oiLQqs8ZdvDfmWHQxrYcR/ULMSS
         CSaA==
X-Gm-Message-State: ABy/qLanMULQVAv7zJrybWJtRlsn3YbjbIRzhn2WBbXerLvom/5cVXbk
        /n+Knfce51DdPrrovkI03gXabHnda7zJrB2or0WDr0cdeWLK3D2f30ZUeFvqZE4I3n4zAXsw1Ul
        2O1DfxW9TXC6V9vL5IltlDp0Ux6VbHMfh
X-Received: by 2002:a5d:4603:0:b0:315:ad1a:5abc with SMTP id t3-20020a5d4603000000b00315ad1a5abcmr2505859wrq.5.1689176954068;
        Wed, 12 Jul 2023 08:49:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHfZBXzs0WOpOSK4uyREoe1iPHFVtvPrhE48RQBaY4V+m6OOpZMax9BclCH2P9YghADvfsQjA==
X-Received: by 2002:a5d:4603:0:b0:315:ad1a:5abc with SMTP id t3-20020a5d4603000000b00315ad1a5abcmr2505833wrq.5.1689176953749;
        Wed, 12 Jul 2023 08:49:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u24-20020a170906069800b009920f18a5f0sm2732141ejb.185.2023.07.12.08.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:49:13 -0700 (PDT)
Message-ID: <af2be377-ff04-3b00-62c7-a1ff53dddd16@redhat.com>
Date:   Wed, 12 Jul 2023 17:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] platform/x86: thinkpad_acpi: lockdep support
Content-Language: en-US, nl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230704-thinkpad_acpi-lockdep-v1-0-60129548a738@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230704-thinkpad_acpi-lockdep-v1-0-60129548a738@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/4/23 23:03, Thomas Weißschuh wrote:
> Validate locking requirements in thinkpad_acpi through lockdep.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> Thomas Weißschuh (2):
>       platform/x86: thinkpad_acpi: take mutex for hotkey_mask_{set,get}
>       platform/x86: thinkpad_acpi: use lockdep annotations
> 
>  drivers/platform/x86/thinkpad_acpi.c | 45 ++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
> ---
> base-commit: 03275585cabd0240944f19f33d7584a1b099a3a8
> change-id: 20230704-thinkpad_acpi-lockdep-7def9d7f91b5
> 
> Best regards,

