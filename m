Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99A6B0900
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCHNaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCHN3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:29:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19918B3F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678282003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oKRxau3irol8jvjjSkixUGo9Iw+/UAjaIS/mBoMB6Uc=;
        b=TIPQt/QNsGDfRSOJWYscObzfOMdxhbdNJsoFaPufbdnoaB8i/v/lKqH5sWThE9Zh5vCdLs
        6qMMj1cFb1HI11W3nKeQY0x51ZL/dTSamF8SjslTOWR7FA0Sx/GcxnUHjmH9uZ8yz950qj
        3W7O+FcSdYo1qzkX7cRy993IvBzyR8g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-1fjDFFvsMs-KFbvGhwdoHw-1; Wed, 08 Mar 2023 08:26:42 -0500
X-MC-Unique: 1fjDFFvsMs-KFbvGhwdoHw-1
Received: by mail-ed1-f69.google.com with SMTP id u10-20020a056402064a00b004c689813557so23582589edx.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678282001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKRxau3irol8jvjjSkixUGo9Iw+/UAjaIS/mBoMB6Uc=;
        b=54eIFqVHzOd5utaLwLKa3c0acYV86eMHJnRsff56kFER0lNVur43FNMGA6CVqTumXu
         7G4qlLG0oyNiWE4L5UQLoi4UYTm3PRbNTmQ+oMH6BUx1KV+V6MS6T2yhvkQlO7dTD6XS
         JOx9B9rH77GwAxbdrF7egBA/BXUet/mmmt0K0SLTKLU5bLiJN1l5Ifq448XXaDwOt9+Z
         bv6VqB3DMvk/joKEIrW3gZPlE8JJyZd9es3FRvPTxLDvWIHvxSwMVLwLMHx3IwBPMYjE
         +6ODOHwPZiHhnWgnltUb2MOJEmODtjfO/06YbuJyK67IfSl8MIouNF+XMbkLZiVKVpS2
         NltQ==
X-Gm-Message-State: AO0yUKWditnsjGD8tfS6z0IDXFmNSNC5bmrrrx+m0vftMovw0BcQ0qz7
        XMiRLzS4Qu9kQ+ahTYY8zyP91lb/BgjrWGKn+cDchyLNOe99+ko4ztQhzGfUJW3V+rOPyrdAXnl
        RJzoixDwm8nUiwaU9JMOposrTKyc3FIf8
X-Received: by 2002:a05:6402:2037:b0:4c0:821a:40da with SMTP id ay23-20020a056402203700b004c0821a40damr19099353edb.34.1678282000917;
        Wed, 08 Mar 2023 05:26:40 -0800 (PST)
X-Google-Smtp-Source: AK7set9NHgSrN2m6Mo2d+vjEBdpCn2la3XrnQjGOgJZhp1hgejDPNH9Eb3ztNvvBE57RyAAI1gIiUg==
X-Received: by 2002:a05:6402:2037:b0:4c0:821a:40da with SMTP id ay23-20020a056402203700b004c0821a40damr19099330edb.34.1678282000617;
        Wed, 08 Mar 2023 05:26:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709067d4300b008e54ac90de1sm7448825ejp.74.2023.03.08.05.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 05:26:40 -0800 (PST)
Message-ID: <92a9442a-cece-4179-fbdc-3c9188da073e@redhat.com>
Date:   Wed, 8 Mar 2023 14:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: r8188eu: delete driver
Content-Language: en-US, nl
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
References: <20230308131934.380395-1-gregkh@linuxfoundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230308131934.380395-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> Now that the same hardware that the r8188eu driver supported is
> supported by the real wireless driver rtl8xxxu, the r8188eu driver can
> be deleted.
>
> Also the rtl8xxxu driver supports way more devices, and is a fraction of
> the overall size, making this a much better overall solution.
>
> Thanks to the r8188eu developers and maintainers and reviewers over the
> years, your work allowed Linux users to use their hardware before the
> real driver was implemented properly.
>
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Cc: Martin Kaiser <martin@kaiser.cx>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for doing this, I agree that this is the best solution
moving forward:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

