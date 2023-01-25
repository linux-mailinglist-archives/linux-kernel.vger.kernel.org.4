Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1E67AF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbjAYKXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjAYKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F73E3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674642163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rr13eYjbTYRH96MeV8Up2tdYMhCePM43zaWw8ahE9us=;
        b=SgFYeawbyfwitFqiiMQZha42KH+BufKOg9tV/RfWAtbnn06FoNNMDDoKECQ4EJBW8ofL6O
        sscZXTcYJ3G06+j6EX551LNzK/PSd9ivq9fZ6BbWS0A4FBlqmuqY4mHPJoWNz6UF9LiYg5
        dJso1oF3fUfrKfC+HqZwoWUaRjHYOaU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-OUsmUINVMcWaueQDPipuPg-1; Wed, 25 Jan 2023 05:22:42 -0500
X-MC-Unique: OUsmUINVMcWaueQDPipuPg-1
Received: by mail-yb1-f199.google.com with SMTP id y66-20020a253245000000b007cb4f1e3e57so19264718yby.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rr13eYjbTYRH96MeV8Up2tdYMhCePM43zaWw8ahE9us=;
        b=BoiIBDmx4UwPqhmC+KHWbiFZ6wmZ6QaISydhWcB9WvQqf2Jdt/t6NEpvOjZFCQxQoN
         Dca6Rc8wmuV7GXfpyYywieaCLnl7pcBahmQMAnSRjOzW41QhLfJ+e4yBTtpPs5Z3056l
         O+1XnAyuXPhvpC5hPPUb/chc+bO3my8JTF+fNrfpMxSLmNwZZVltq+HUwxO4Zly/JpNM
         p9nQ3zaGHPdgH3Mt8aBnOg01G9CWloqvsqkdH+ajd+uOqBIpACTDJrSO3dbO1n/LUw6W
         Qnjt5IL3MYWLLSbRAdLZpaaN1RfvszjbfmImdXjsSLSiUx+SHjdsjJFMt/IbIWfHUBiE
         KYnQ==
X-Gm-Message-State: AFqh2kq8fBMdxiqoo5E6aa/xqMtX8AWv8CL1AlOVGU65dlGL3i1gvoqU
        z89Fdww7pMN72HJdZzIWTXG+2BwBIZ5tZX0D1NmYFQnoiSlq53ctEj0iQntyyj1WQ78A6/kX+hY
        IvDJ8u6J10FjD2Q4IRyXeqE5/su4Bur451yZjkqHN
X-Received: by 2002:a81:48d2:0:b0:4fe:5adc:24bc with SMTP id v201-20020a8148d2000000b004fe5adc24bcmr2497820ywa.337.1674642161003;
        Wed, 25 Jan 2023 02:22:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvFNfvyBAiH/VVCdqNkB59RtPBVoQQeFANXZAk158KWgPw8WXeXLiwCoSH2AKkotOOwr42FeG7TNME3IT8gcSw=
X-Received: by 2002:a81:48d2:0:b0:4fe:5adc:24bc with SMTP id
 v201-20020a8148d2000000b004fe5adc24bcmr2497815ywa.337.1674642160824; Wed, 25
 Jan 2023 02:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20221220154345.474596-1-hadess@hadess.net>
In-Reply-To: <20221220154345.474596-1-hadess@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 25 Jan 2023 11:22:29 +0100
Message-ID: <CAO-hwJKVoPB8LGLVT_gw87nKM=+pEVU2HqhA_G_SfvCT2=hkBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Revert "HID: logitech-hidpp: add a module
 parameter to keep firmware gestures"
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 4:43 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> Now that we're in 2022, and the majority of desktop environments can and
> should support touchpad gestures through libinput, remove the legacy
> module parameter that made it possible to use gestures implemented in
> firmware.
>
> This will eventually allow simplifying the driver's initialisation code.
>
> This reverts commit 9188dbaed68a4b23dc96eba165265c08caa7dc2a.
>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

Applied just this one to for-6.3/logitech

Cheers,
Benjamin

> ---
>  drivers/hid/hid-logitech-hidpp.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 08ad19097e9e..7f9187201913 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -32,11 +32,6 @@ MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
>  MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
>
> -static bool disable_raw_mode;
> -module_param(disable_raw_mode, bool, 0644);
> -MODULE_PARM_DESC(disable_raw_mode,
> -       "Disable Raw mode reporting for touchpads and keep firmware gestures.");
> -
>  static bool disable_tap_to_click;
>  module_param(disable_tap_to_click, bool, 0644);
>  MODULE_PARM_DESC(disable_tap_to_click,
> @@ -4355,11 +4350,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>             hidpp_application_equals(hdev, HID_GD_KEYBOARD))
>                 hidpp->quirks |= HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS;
>
> -       if (disable_raw_mode) {
> -               hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
> -               hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
> -       }
> -
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
>                 ret = wtp_allocate(hdev, id);
>                 if (ret)
> --
> 2.38.1
>

