Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C88C6FC398
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjEIKLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjEIKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6E010F
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683627014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGPv5iCUe/eBYufrf+togrj567NQUc99rNeFfePlAYY=;
        b=BzVaFIktWVp1rtkDiWl784WP1dN/j23YNIMAKpDRmQyehDC+qdp8X0/C3Cr1s5xTjMqcTm
        yM7AQPKKjq7trpyueRTx5coSc6ObPoetgFKbUp7/lUnKpnGfnq6INNLF9ZAlx632+DyvnS
        GW4f5Z3gYfiqZ05cfatJtp9yT5g6Aj8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-mz46rL50NhO2H83ei-jS4g-1; Tue, 09 May 2023 06:10:12 -0400
X-MC-Unique: mz46rL50NhO2H83ei-jS4g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50bd07fbd97so6575054a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 03:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627012; x=1686219012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGPv5iCUe/eBYufrf+togrj567NQUc99rNeFfePlAYY=;
        b=Wr8g/6qXgdncobnodWqKHjmqzOLQJjickEDytldW3nBiCpRgkO2AgaACRP/a8HIyWb
         8zoMFF3asA60N6B1tF9zgbVV0tmJnruAWWPspASwderPirGOGDodEUovYpTjGSI7Fhd1
         MObTnIh5kdEaFr5F8+nPNk2y2klc8wWBfCLeu84/bant0vmu26pgXEwUSCga7/2LYESF
         2P0jUNrhu4I48yBwGj/0KR7iBpfpT8V8RBtkTbLDiCqJ5Mnm7brtXTkRfBZA+OTzp+Kb
         xrcByFQSf4Men7Gr681g93gDS1SBjguzW3BijrgIUbt3GqtcoK1S0zaHTPrlk6nVJn9n
         oMQA==
X-Gm-Message-State: AC+VfDyiOn2Kdiahkhb3tNgnu1e+ME4+tV0dtYMIB/zE4pgN3PiDP6fN
        SkcrVis09qLtb6SZ0DLmjYhU3TtpHg+zvA4yDIF7l3sQXLjDvXn5jIgptdbh1Lug4dz9KLcs28J
        uHWORt7go07OE1m7nVQpajb1o
X-Received: by 2002:a05:6402:398:b0:50b:c4b7:ee7c with SMTP id o24-20020a056402039800b0050bc4b7ee7cmr10710153edv.36.1683627011900;
        Tue, 09 May 2023 03:10:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5rmXSbjd7tRSiIdt4jdPrz6q/SlvLK9Q9OIrW2BOEcyWmsJSq3Cbk1SWq3t5xDEr9XCVnM6Q==
X-Received: by 2002:a05:6402:398:b0:50b:c4b7:ee7c with SMTP id o24-20020a056402039800b0050bc4b7ee7cmr10710137edv.36.1683627011619;
        Tue, 09 May 2023 03:10:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7da96000000b0050470aa444fsm579392eds.51.2023.05.09.03.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 03:10:11 -0700 (PDT)
Message-ID: <e62d7e89-315c-ee34-6708-a5e54d8ac4ad@redhat.com>
Date:   Tue, 9 May 2023 12:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] platform/x86: Allow retrieving the number of WMI
 object instances
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230430203153.5587-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230430203153.5587-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/30/23 22:31, Armin Wolf wrote:
> This patch series allows WMI drivers to retrieve the number of
> WMI object instances. This functionality benefits several current
> and upcoming WMI drivers, the dell-wmi-sysman driver is converted
> to use this new API as an example.
> 
> The changes are compile-tested only, the change to the dell-wmi-sysman
> driver also needs to be tested on real hardware.
> 
> Changes since RFC v2:
> - modify wmi_instance_count() to return an integer

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




> Armin Wolf (2):
>   platform/x86: wmi: Allow retrieving the number of WMI object instances
>   platform/x86: dell-sysman: Improve instance detection
> 
>  .../x86/dell/dell-wmi-sysman/sysman.c         | 13 +++---
>  drivers/platform/x86/wmi.c                    | 41 +++++++++++++++++++
>  include/linux/acpi.h                          |  2 +
>  include/linux/wmi.h                           |  2 +
>  4 files changed, 50 insertions(+), 8 deletions(-)
> 
> --
> 2.30.2
> 

