Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741336B1E98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCIItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCIItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:49:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ABC73AD6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678351742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EC6Y5lbtkWTNJ12e9OJkDOPxU0LJq7Kyd+/8uJWMvYQ=;
        b=GTdUfJxHndIuySfCA2WDdzWjcJXbrZAGknZFAPlyIGmd4ilQ/TzxLMbrsfEWLMwSkau6cE
        Vd+ClfUtfjG22W6XAqO9l6oqUs18bGMZYisMUHW/3Nj+onnAJLlWcMlknlZFKpSfx2Sdxp
        VlNKvwFp9DcfhxDAPkdIpPXe0nKAX6A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-Wy1K0_MyPcia1R56yL3Hjg-1; Thu, 09 Mar 2023 03:49:01 -0500
X-MC-Unique: Wy1K0_MyPcia1R56yL3Hjg-1
Received: by mail-ed1-f70.google.com with SMTP id y24-20020aa7ccd8000000b004be3955a42eso1885022edt.22
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:49:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EC6Y5lbtkWTNJ12e9OJkDOPxU0LJq7Kyd+/8uJWMvYQ=;
        b=e/TId4mCJDgWOmVzo5oG5njtI6DbHb3yeyxagg9MWhthatEyciRRHacjewmgjrI5lc
         7I7Nd7uOjx0rChA5nGDU8xTHJPjpEphZ/VnfKvYJSwmougmIST7T9ZynUxOGTahij+s9
         w3tRo4dhG0wfALT9NqDcudO5NpKiuY3XAJRpoXbIKpXeVJN90nHFsHXbvZkvH5hcwT2j
         jQ3MKn3OFq60fhha4juyvgBRd3FXSj+zHfZjrsANzU43ALme21Pf/aTFKP8EVePwrgAo
         czaNX4gokcG//k+poSsaT97VZP4P4IRMACINo/jygpi6UKMnR0seE5v3uEOUScPFqqy5
         8m6Q==
X-Gm-Message-State: AO0yUKUR1wUj/gwuLfHHJlUo6FxaE+0TbFM1RpWNxA6I+VSKq4ZYijCm
        SwcsMb0ZhLnro9QRRRsVw4GSutivqtvWVt4q+WrM+SSxEMFgVLi3F83NpkGKHUmnvmWnVvlY5N0
        WQlOgP5VnL9z8h1CPymoh0I+Q
X-Received: by 2002:a50:fc17:0:b0:4c2:3592:4a77 with SMTP id i23-20020a50fc17000000b004c235924a77mr18027800edr.30.1678351740181;
        Thu, 09 Mar 2023 00:49:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/n5Tm2xYdLkq9+15iUOlHNsCULx+dgycuz0kJ0kFCsAFKhxz58+7OGfMn7Y5avPrYqY/A95w==
X-Received: by 2002:a50:fc17:0:b0:4c2:3592:4a77 with SMTP id i23-20020a50fc17000000b004c235924a77mr18027791edr.30.1678351739911;
        Thu, 09 Mar 2023 00:48:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f21-20020a50d555000000b004c059535b43sm9378310edj.31.2023.03.09.00.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:48:59 -0800 (PST)
Message-ID: <4c63d660-1105-9a8a-1010-cc05125d06d3@redhat.com>
Date:   Thu, 9 Mar 2023 09:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Content-Language: en-US, nl
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230309122822.77435e33@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230309122822.77435e33@canb.auug.org.au>
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

Hi all,

On 3/9/23 02:28, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drivers-x86 tree, today's linux-next build
> (htmldocs) produced these warning:
> 
> include/linux/apple-gmux.h:99: warning: Function parameter or member 'type_ret' not described in 'apple_gmux_detect'
> include/linux/apple-gmux.h:99: warning: Excess function parameter 'indexed_ret' description in 'apple_gmux_detect'
> 
> Introduced by commit
> 
>   fc83fbc80e1a ("platform/x86: apple-gmux: refactor gmux types")

Stephen, thank you for reporting this.

Orlando, can you do a follow-up patch on top of your
latest series fixing this ?

Regards,

Hans

