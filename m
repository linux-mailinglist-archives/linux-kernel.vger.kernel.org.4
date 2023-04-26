Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818466EF828
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbjDZQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbjDZQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60B1BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682525357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erKsqZ6PhfpGuRSr7TKmSUm9LgXe9vjm1nzPbCbLxKs=;
        b=LV1KyAtFiGFWqB88nzkRaETkjluUYg9rPQuZr3dV++1KuVr6J7tVnQZexUlZUy9AFoKA6r
        ydeGz5t6N5fws6DLhYT9+4vhLaIWFb4ORsg7fep3NC+W2nm92y/Vwgq7FYx7AEwU0zG0de
        fKd4SKvAtfHhxdit7Dh7XKZJ9IHq4Ko=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-KsxGby9vMqWb-cYeCE_T3g-1; Wed, 26 Apr 2023 12:09:16 -0400
X-MC-Unique: KsxGby9vMqWb-cYeCE_T3g-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5050340f541so6673213a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682525355; x=1685117355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erKsqZ6PhfpGuRSr7TKmSUm9LgXe9vjm1nzPbCbLxKs=;
        b=ctg4XL6EjVJozAIwa/mhlSJZPJUcgXWeej/q/b28TMTcaSvWfv75dSQb0kn0vRiThj
         bkpYFfFBVM80lPni/G272tW6a9unUj9It0nrwpeg+TNIOzzQDG/Vb7rJcMk8EBekBI5x
         kjazga8zj8iXdq8I1dkRClqHnMhvwtUM8Eea37kl5w5oKTqzwx7nlZcm0KKA60np+xwx
         sPVwXYyShVtQppvgSeHuUHxe3rVx+Vfoc9oOjCA/CDHtfZEE3R92SM3WcthlGGmuuxYj
         Ib8rdaSnt2f4duHaydXiTME1tL7e3Q97HunIUvimL/CP5+Bg4K6U6FxVJhx1pGNKHX89
         WGQA==
X-Gm-Message-State: AAQBX9dv3bXst6fb/s5p3meTNVLBMEmRzS9JDQ6ltDiaz6IvSnVE+FRp
        L9xIuIS+fyKm5lDNgQLKL/TRwvwmf+338IXGCEH5/0RYz3XJYvRxhMb0iwBf10zGIyufIiM010z
        ryQyIaBgJ0KnJKPSI2GnT5X8wzQ/ibHh4
X-Received: by 2002:aa7:d7c5:0:b0:504:7d53:2148 with SMTP id e5-20020aa7d7c5000000b005047d532148mr17319985eds.30.1682525355159;
        Wed, 26 Apr 2023 09:09:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350anx2sC5Pqc4Hhggb8KfSFvLG2RmVT2FaoRvOJO0KMbM0Q0KYD3ZHaAHSgaCTHgF+3bpJ4ZIg==
X-Received: by 2002:aa7:d7c5:0:b0:504:7d53:2148 with SMTP id e5-20020aa7d7c5000000b005047d532148mr17319972eds.30.1682525354910;
        Wed, 26 Apr 2023 09:09:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h25-20020a50ed99000000b00505060e4280sm6814607edr.94.2023.04.26.09.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 09:09:14 -0700 (PDT)
Message-ID: <0b609a22-5da3-8305-ac93-caf1a0265170@redhat.com>
Date:   Wed, 26 Apr 2023 18:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] platform/x86: hp-wmi: Add HP WMI camera switch
Content-Language: en-US, nl
To:     Jonathan Singer <jes965@nyu.edu>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20230426152139.1692-1-jes965@nyu.edu>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230426152139.1692-1-jes965@nyu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 4/26/23 17:21, Jonathan Singer wrote:
> Previously, when the camera toggle switch was hit, the hp-wmi driver
> would report an invalid event code. By adding a case for that in the
> event handling switch statement we can eliminate that error code and
> enable a framework for potential further kernel handling of that key.
> This change was tested on my HP Envy x360 15-ey0023dx laptop, but it
> would likely work for any HP laptop with a camera toggle button. Now
> we emit an SW_CAMERA_LENS_COVER event, on a device that gets created
> on the first such event so as to not report incorrectly the state of
> the camera shutter before we can know its state.
> 
> Signed-off-by: Jonathan Singer <jes965@nyu.edu>

p.s.

> +		if (event_data == 0xff)
> +			input_report_switch(camera_shutter_input_dev, SW_CAMERA_LENS_COVER, 1);

I assume that event_data = 0xff happens when disabling the camera, so
we report SW_CAMERA_LENS_COVER 1 when the camera is disabled, right ?

Regards,

Hans


