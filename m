Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3D6BFBA8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCRQuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCRQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D146B274AB
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679158171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYLPi961rrhMuWDEVxQoLmOJ4qh13a023msrkQ97CyQ=;
        b=KH0601HYyRYxL+oOmLcND9SzSVS5H6kc31NNIYhgxH2oYJN45LQeFLac/A3GD0n5c22PkF
        upfy9XCTvRD5liLMZa6pZGPgF7gyahLN4KjDj/0ejEc9/M84HqjvUMkFmrU4IAnN+VLfoB
        Oio/NvBHksXj0ok8hDnpLZ7Zjf5lP0s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-QpzIEW6KOlW-n_r2vIj-XQ-1; Sat, 18 Mar 2023 12:49:30 -0400
X-MC-Unique: QpzIEW6KOlW-n_r2vIj-XQ-1
Received: by mail-ed1-f72.google.com with SMTP id e18-20020a056402191200b004fa702d64b3so12020577edz.23
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 09:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679158169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYLPi961rrhMuWDEVxQoLmOJ4qh13a023msrkQ97CyQ=;
        b=5f7ytvwV+RWK64tYSatrdf1i3qAUx5uxdG45TNQqnADZw5wBJ25Jv27lKcb8uvt/hg
         gOUm0tWDUQneHPWkZYaxZICYbkyuq0TOH6F/pIL29dUB9mLhuRxBq+qcPNX2r/FYvpDC
         8TPtgl1GXARycl5rScyRw3MsE7tt+rNTfP6/LTsmjxkl7kjqoKHZv6kT5oSgTltjVyf6
         uMjR9gioa3JJv5Le7Ut6nTKMoYFnYVZ6VEvbleXB1lyg5cTXBySsBQSDAXrQjvC20zX4
         s0Xn94aQtKbJMfZf4/dGmNEXFD7CVDEGTPyZ5Q0cBkzGP6aGKU5QdVBug5ygVmrgS+As
         wEBg==
X-Gm-Message-State: AO0yUKUPtx0j3G5jNn1z1c75iczR5r4PWG4CJwx6QN6zoGPiFKdsagOt
        FY3cD4s1c5MkHJJc+crP1AZQFO1W1Ke1Lb1Xfqn+tHFyTOJaybsOTdCv7RKod9h5nhONIb2G37m
        eidm65nNdwuXeW5z9f0d0CRLj
X-Received: by 2002:aa7:c90f:0:b0:4fc:687a:c29d with SMTP id b15-20020aa7c90f000000b004fc687ac29dmr6847321edt.1.1679158169289;
        Sat, 18 Mar 2023 09:49:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set82X+r0HM83cSH5tYRr+jo2nTQ//vjM+T3XwYju9aqTznKPN6KcewIP3GtDMriqb/zd1kr+Kg==
X-Received: by 2002:aa7:c90f:0:b0:4fc:687a:c29d with SMTP id b15-20020aa7c90f000000b004fc687ac29dmr6847313edt.1.1679158169062;
        Sat, 18 Mar 2023 09:49:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm2537072edd.66.2023.03.18.09.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 09:49:28 -0700 (PDT)
Message-ID: <09d1ba06-a034-165d-2f7d-fba7d379e026@redhat.com>
Date:   Sat, 18 Mar 2023 17:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [REGRESSION] Missing nouveau backlight control on 6.2.x kernel
Content-Language: en-US, nl
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <87wn3f8zj7.wl-tiwai@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87wn3f8zj7.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On 3/17/23 11:04, Takashi Iwai wrote:
> Hi,
> 
> we've received a regression report on openSUSE Bugzilla about the
> missing backlight control of nouveau device:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1209296
> 
> On 6.1, with acpi_video=native option, the system provided
> /sys/class/backlight/nv_backlight entry.
> 
> On 6.2, with acpi_video=native option, there is no entry in
> /sys/class/backlight.  And without acpi_video option, it falls back to
> /sys/class/backlight/acpi_video0, which doesn't work as expected.
> 
> Hans, could you check whether the recent change in video_detect.c (or
> anything else) may influence on this?  My gut feeling is that the
> culprit could be rather some change in nouveau (so dri-devel is
> Cc'ed), but I'm not entirely sure...

As I already told the reporter, who first contacted me by private email about this, all the drivers/acpi/video_detect.c changes which may influence this are also present in 6.1.y (IIRC >= 6.1.5) . So since this is being reported as only happening with 6.2.y I don't think the recent backlight detect rework is involved.

And even if the recent backlight detect rework were involved, specifying acpi_backlight=native on the kernel commandline (as the reporter was doing before) should still work since it overrides all other backlight detection.

So yes this seems to be a nouveau bug and should probably be reported following the instructions from: https://nouveau.freedesktop.org/Bugs.html  (which I havealso told the reporter already).

Regards,

Hans



