Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEABD6EE067
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjDYKcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjDYKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C7468C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682418663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkMHifCLaqZQe23JCKz0wmjfgG+ZZZ7m9ycDSIKx5x0=;
        b=X6lCvllwbEjC3LRTte2zF83uTzcvT0VEQoiqGLPWiKmqNeJ3XCM/BZi0/07ObugR+GcEAW
        kUYvuL/ofR5n82FwHn0hptqUOUZWpydA4SQbJihSLmTeAhCnSgYuWH/8hg/K0ytlvrZizv
        UE2iX79BPPOFpzviNn2yI/Xr/IEKs6A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-sDakO3UgNHqEz9V-OtpPwQ-1; Tue, 25 Apr 2023 06:31:01 -0400
X-MC-Unique: sDakO3UgNHqEz9V-OtpPwQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94ec76d7a26so512831366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418660; x=1685010660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkMHifCLaqZQe23JCKz0wmjfgG+ZZZ7m9ycDSIKx5x0=;
        b=aF7XGOtNOSa6EvKSsThmZKFLPPuzr5smnxBluXJQiALS3DHzt7VSYwf7ogPA7RVmc5
         EZJzZQrl9uAyour9evtfyELwFVW4SEu5111ik9MHSUcy7R/rVgYgSkfZi3PvvpuxRi01
         OCLxCrSWtFE+Mi8xw0LVF69KKtezDZhbhPJa6lmSYdpuJ0JOuuaAccil4jybsWmmh1dx
         /EC/Pf/YP/MV7gN5mgDK69prOIQUqtOukCqwOFpl3465W/0bHGYyQ3UpkisdC7WtBaav
         7+vxn+14LJtMomA8mvtxAPJdgjM2n9lT4VEHRwBYtzFlPWv2OCbNbOxF1IaFsI/V4Cbe
         H1iw==
X-Gm-Message-State: AAQBX9dF99cviaNAWTcuwzB3UsBtYbKQvaGe7J8+SpO5WeeqUjOrj/xE
        i1GslzwqZ2B+X0mI6COx6mvd/XFMPuefcSdv59t5OLQIiHwlSamsdzlTv6DCFehLGuNNUhkxN+l
        wsewhyljfRIw8DzQdRz3h86mL
X-Received: by 2002:a17:906:19ce:b0:94e:dd3f:b650 with SMTP id h14-20020a17090619ce00b0094edd3fb650mr13035671ejd.18.1682418660732;
        Tue, 25 Apr 2023 03:31:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZWvpXVsqotwJMVCcXpApG9Pp9pQl/N2qIHkm+Soa3pwcq0A663kb3Gqpzim79ZsmIsa6ao3g==
X-Received: by 2002:a17:906:19ce:b0:94e:dd3f:b650 with SMTP id h14-20020a17090619ce00b0094edd3fb650mr13035657ejd.18.1682418660467;
        Tue, 25 Apr 2023 03:31:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906328a00b009599c3a019fsm2455809ejw.60.2023.04.25.03.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 03:30:59 -0700 (PDT)
Message-ID: <6ddd373b-6bcb-85a7-2423-ceea5d3f1246@redhat.com>
Date:   Tue, 25 Apr 2023 12:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v10 02/14] HP BIOSCFG driver - biosattr-interface
Content-Language: en-US, nl
To:     Pavel Machek <pavel@ucw.cz>, Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
 <20230419151321.6167-3-jorge.lopez2@hp.com> <ZEJ1f7vOL1zCyNyR@duo.ucw.cz>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZEJ1f7vOL1zCyNyR@duo.ucw.cz>
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

Hi,

On 4/21/23 13:37, Pavel Machek wrote:
> Hi!
> 
>> Linux Security components are under development and not published yet.
>> The only linux component is the driver (hp bioscfg) at this time.
>> Other published security components are under Windows.
>>
>> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> 
>> +/*
>> + * ascii_to_utf16_unicode -  Convert ascii string to UTF-16 unicode
>> + *
>> + * BIOS supports UTF-16 characters that are 2 bytes long.  No variable
>> + * multi-byte language supported.
>> + *
>> + * @p:   Unicode buffer address
>> + * @str: string to convert to unicode
>> + *
>> + * Returns a void pointer to the buffer containing unicode string
>> + */
>> +void *ascii_to_utf16_unicode(u16 *p, const u8 *str)
>> +{
> 
> Does this need to go to library somewhere?

This has already been discussed in earlier submissions
of the driver, the utf16 format is HP specific (prefixed
with a 16 bit le lenght, and the 0 length string needs
special encoding) so despite the name this is not generic.

It should probably be prefixed with hp_ because of this
though, to avoid potential symbol conflicts when builtin.

(and the same applies to other generic functions).

Regards,

Hans


