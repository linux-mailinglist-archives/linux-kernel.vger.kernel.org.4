Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6200680788
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjA3Ih0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjA3IhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:37:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB924134
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675067796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4d/SMT2oPu4pWDgGmvW3ooby0A6gn9g87bNk00NILRw=;
        b=TfdTnAlyUueo5ZKYZ/XZbyfsXu4mhbBSmIaPx731l+EeVVg5B+VzErIlPdvp4ydySRV7z9
        aobGKFlNEOVPioC8xw+Hd4JhOKj8QcWmvQwhqtGa5fkT8do5PRgXC6Kgrp+tilxeKVo6wK
        KrzSzOXSIOE7V8ySEwBbOHTNA6jXTDA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-457-2-kZwvKwPAa5cld52zdxoA-1; Mon, 30 Jan 2023 03:36:35 -0500
X-MC-Unique: 2-kZwvKwPAa5cld52zdxoA-1
Received: by mail-ed1-f71.google.com with SMTP id s3-20020a50ab03000000b0049ec3a108beso7660613edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4d/SMT2oPu4pWDgGmvW3ooby0A6gn9g87bNk00NILRw=;
        b=WwGBdhz1jAHZ9EZr1LanpIKc35wqiEePI1bk8EouJeOYcnXKXzQp9KgjkMjzEXFM73
         RrA4Fw25s4+Mgzb+m9AZD8VgaQUEtnAjIUfR7RWsau9zWKxxNXh0WL1tgeDbHKtc6J2C
         2h3Lf02UONAedqCcGXYUOed1TXO+lU2rrcl9Oz41w8XY1O1HUSD3U4a0ZllXl/63A5Gx
         1hZJxLhSVoqCrNBLAkFxDQzXQmVoUQFBPN7Da+wR6o0cywRU1nAldfCRAMfutWwnRclf
         sdebYZljYcOSfuGtxa+LZEpDLFwRg23Qcf7CbSawarISCPuuYVrLgSxFu0/HfEsdqqER
         8f6A==
X-Gm-Message-State: AO0yUKWSYameSACE9rbdGbjtaZ+kI75OQXSA0Erh01N8W9ZYWoA5PvcL
        uywllcnmFDhp+ZBSx3KF69ayqwPyss8EyrNaZTf879V+r9uiqDy/9QWCFsDxMEYh1neZKG74GAf
        6v0ZfkdLqRu+XPoQz8iSal+2H
X-Received: by 2002:a17:906:475a:b0:887:981:5f7c with SMTP id j26-20020a170906475a00b0088709815f7cmr5019127ejs.11.1675067794096;
        Mon, 30 Jan 2023 00:36:34 -0800 (PST)
X-Google-Smtp-Source: AK7set/0R+gvMcJBFdYRnrzzxOkxWBZLXr5z/Tqk0BP+fIcTMCHK94EHX6VpDr3nSMq6rTGD5CNmOQ==
X-Received: by 2002:a17:906:475a:b0:887:981:5f7c with SMTP id j26-20020a170906475a00b0088709815f7cmr5019103ejs.11.1675067793927;
        Mon, 30 Jan 2023 00:36:33 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906714200b00888161349desm1582823ejj.182.2023.01.30.00.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 00:36:33 -0800 (PST)
Message-ID: <0937b9a5-0caa-2a73-33c4-82e6cab02ef0@redhat.com>
Date:   Mon, 30 Jan 2023 09:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/9] HID: Constify lowlevel HID drivers
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev
References: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/30/23 04:59, Thomas Weißschuh wrote:
> Since 52d225346904 ("HID: Make lowlevel driver structs const") the
> lowlevel HID drivers are only exposed as const.
> 
> Take advantage of this to constify the underlying structures, too.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I'll also pick up / merge patches 7 + 8 into pdx86/for-next
sometime this week.

Regards,

Hans



> ---
> Thomas Weißschuh (9):
>       HID: amd_sfh: Constify lowlevel HID driver
>       HID: hyperv: Constify lowlevel HID driver
>       HID: logitech-dj: Constify lowlevel HID driver
>       HID: steam: Constify lowlevel HID driver
>       HID: intel-ish-hid: Constify lowlevel HID driver
>       HID: surface-hid: Constify lowlevel HID driver
>       platform/x86: asus-tf103c-dock: Constify lowlevel HID driver
>       platform/x86: asus-tf103c-dock: Constify toprow keymap
>       staging: greybus: hid: Constify lowlevel HID driver
> 
>  drivers/hid/amd-sfh-hid/amd_sfh_hid.c      | 2 +-
>  drivers/hid/hid-hyperv.c                   | 2 +-
>  drivers/hid/hid-logitech-dj.c              | 4 ++--
>  drivers/hid/hid-steam.c                    | 2 +-
>  drivers/hid/intel-ish-hid/ishtp-hid.c      | 2 +-
>  drivers/hid/surface-hid/surface_hid_core.c | 2 +-
>  drivers/platform/x86/asus-tf103c-dock.c    | 4 ++--
>  drivers/staging/greybus/hid.c              | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
> ---
> base-commit: e04955db6a7c3fc4a1e6978649b61a6f5f8028e3
> change-id: 20230130-hid-const-ll-driver-fcfdd3af11b8
> 
> Best regards,

