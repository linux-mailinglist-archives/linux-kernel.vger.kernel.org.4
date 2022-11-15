Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990F162A30F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiKOUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiKOUfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F66C3123C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668544304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6SnydtGhvRB1WXJGQc/GnEivc01dn3HZFeqVNWDLRw=;
        b=a6spF9R8ambST/8QMqyc57ehmdRcOsiYn0B3i88Hua0gsiVNTuJ8yWm+yL0JeKabQYVqU2
        tXNwbrHaO2j4YIykjZMp5Va9YIkz+nzspJbIltVHpHlSbo1+GPyMAfGU6oOqFciYyUyh2w
        j7diwwfAxmSqrHcBxyf6jQLMc5E24LY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-397-a0JAsYJ0P5OkWxQGT2ke1w-1; Tue, 15 Nov 2022 15:31:41 -0500
X-MC-Unique: a0JAsYJ0P5OkWxQGT2ke1w-1
Received: by mail-ej1-f71.google.com with SMTP id dn14-20020a17090794ce00b007ae5d040ca8so8108117ejc.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6SnydtGhvRB1WXJGQc/GnEivc01dn3HZFeqVNWDLRw=;
        b=h6U7xNmEcXig8bA6bUn1h7jC18KikGwD4M/fU3RpuisoGLPRuBtBP7pjhSmjUlfSdd
         QOTlk7ZB3CawmicXXQabEFBUvMg2w9m7W2QXtWbmEHm0oh3sNOE3waivJERsmGB9kA5R
         nqgboy0YVrf4gXhRF+xwwziZ07WwtQQl+bDUbBL0+Up5Io002BE2vq3OHMQssy6P3g2o
         sJdBlg52OReLso0FBgV3qIL9BcoJ7TMYNzJlousL4oDSmzAxar43nJwm/XOsaL8Fofys
         6E5+hi2URlhq/EGXHKzD9BGGHoxwDfFQ45WseDUUdBFS2eCwY3jurtGbEMO9HYbjvNZw
         WFbA==
X-Gm-Message-State: ANoB5pm0TDEh1MBXvJ+kFtJXOt+hPpkJ6Fjq6QTc4Wn2wq1ukwXk5uPi
        2glgQOFNY+DhetDOEeEQ/bSwxz6DQHVJC/J/VBmV5jcmEikjGQe0BHwpdeCsFrQWfZM+ODZxQMH
        tIF9Y7zEd4YHkCEh3wmDj11OY
X-Received: by 2002:a17:906:492:b0:7ad:bb54:75d3 with SMTP id f18-20020a170906049200b007adbb5475d3mr15239281eja.484.1668544300669;
        Tue, 15 Nov 2022 12:31:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6rfuCW6M+fSsYP2tM+nBSTMFTn0vK4e4vNkKmOR1CQt2TLUrb4lgeBkWbly7x94fEYFWdyFg==
X-Received: by 2002:a17:906:492:b0:7ad:bb54:75d3 with SMTP id f18-20020a170906049200b007adbb5475d3mr15239265eja.484.1668544300481;
        Tue, 15 Nov 2022 12:31:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id hd16-20020a170907969000b007ab1b4cab9bsm5894956ejc.224.2022.11.15.12.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 12:31:39 -0800 (PST)
Message-ID: <382b83c0-a075-999e-6ba2-410d25343d57@redhat.com>
Date:   Tue, 15 Nov 2022 21:31:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 3/7] platform/x86: ideapad-laptop: Report
 KEY_CAMERA_ACCESS_TOGGLE instead of KEY_CAMERA
Content-Language: en-US, nl
To:     =?UTF-8?Q?Eray_Or=c3=a7unus?= <erayorcunus@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        mgross@linux.intel.com, pobrn@protonmail.com
References: <20221029120311.11152-1-erayorcunus@gmail.com>
 <20221029120311.11152-4-erayorcunus@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221029120311.11152-4-erayorcunus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eray,

On 10/29/22 14:03, Eray Orçunus wrote:
> Reporting KEY_CAMERA when pressing camera switch key is wrong, since
> KEY_CAMERA is supposed to be used for taking snapshot. Change it with
> KEY_CAMERA_ACCESS_TOGGLE, so user-space can act correctly.

I'm afraid that we cannot just go and change the emitted key-code,
users might already have setup key-bindings to the existing
KEY_CAMERA code. Also key-codes >= 240 (decimal!) don't work in
X11 based desktop-environments. And even under Wayland they still
have issues, see e.g.:

https://gitlab.gnome.org/GNOME/gtk/-/issues/4353

So I'm afraid that I cannot take this patch.

Note that since a sparse_keymap is used, you can always override
this on your own systems by using a /etc/udev/hwdb.d/61-keyboard.hwdb
file, see: /lib/udev/hwdb.d/60-keyboard.hwdb for the syntax to
map a (sparse) scancode to the KEY_FOO code of your choice.

Regards,

Hans






> 
> This patch needs KEY_CAMERA_ACCESS_TOGGLE to be defined, thus depends on
> "HID: add mapping for camera access keys" patch.
> 
> Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index b67bac457a7a..0ef40b88b240 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1038,7 +1038,7 @@ static void ideapad_sysfs_exit(struct ideapad_private *priv)
>   */
>  static const struct key_entry ideapad_keymap[] = {
>  	{ KE_KEY,   6, { KEY_SWITCHVIDEOMODE } },
> -	{ KE_KEY,   7, { KEY_CAMERA } },
> +	{ KE_KEY,   7, { KEY_CAMERA_ACCESS_TOGGLE } },
>  	{ KE_KEY,   8, { KEY_MICMUTE } },
>  	{ KE_KEY,  11, { KEY_F16 } },
>  	{ KE_KEY,  13, { KEY_WLAN } },

