Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA9650D03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiLSOHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED271E0A2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 06:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671458779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nuVjVLBj8E1x4HBavhbBfOmlBo2lVvbRsYo3c8J2IAY=;
        b=WPlslR2sfJyybnqaST83DyUehC+1G7Rb/WKISwLvR4FjYN7EtReBoPVUNoNwTyesBOoYGn
        /uovASfJFScM8VxrXyvBBhOHYUYCg6O2xyOPaGiYgfaz56A9PlRpaKr6rWt9hmTrRe2pOu
        CPusgIXWwXA/7xIHliVBKZ9NQrU2SVM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-ydHQ1dAcM6iGUO3C1MkA3g-1; Mon, 19 Dec 2022 09:06:17 -0500
X-MC-Unique: ydHQ1dAcM6iGUO3C1MkA3g-1
Received: by mail-il1-f198.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so6639635iln.21
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 06:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuVjVLBj8E1x4HBavhbBfOmlBo2lVvbRsYo3c8J2IAY=;
        b=AUi10nwI+nSsQit5lPFW6Yvi/7wAiqo3IJ9FiAeK+5aZmDkKPBD2YBZ+foR+GIxcYu
         dDac0NT7iwX07+bOXZQpqh52ud1T50O5lcdYYmPGDwgaa0uGv+jukpYdSJEVr/Fdkpwl
         UCHDtKrh70CnRchvyeMTUaWMnLLN9xqUbJHE37T3oS5NCIyM3e89oAp6fwavE5EQRQ2P
         iUNFzcoV8K1WQyls8+RxOvCfvOvVuziz7ibCCefD553pmyKeb8aL95VSlaT85Sz8pd21
         FaUTHZg++XQ8g3OIdyy7v8EjFL1dYeaknG1MHVnhNjavNwGsSp/IcxuF82+SCTrCkdNT
         lVlg==
X-Gm-Message-State: ANoB5pnbUOkKKi95fDLQyeaoGmLERQs9S0A0PHt7iUcoSKGkorF04Tgy
        YCK0XK6xbS2rPuR4upAJIdYxLTagzQLJZSz/C2M5KlFa1y1L4E6xIBefRYbXIr/MixuUEBwenQF
        mOSgSLcLAwInpp60mncr4oX3UDqm0iSPdtt+5XNkq
X-Received: by 2002:a92:ca8d:0:b0:302:de10:7ae1 with SMTP id t13-20020a92ca8d000000b00302de107ae1mr37983330ilo.15.1671458776999;
        Mon, 19 Dec 2022 06:06:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5HsqW3uYLj3Z+BSfkHisqf8EAo68havrtSEvHFzsSQz53HGMcIdhS8KxdYoPUtoUD8VI3yzwO/jE3fe1h0XZs=
X-Received: by 2002:a92:ca8d:0:b0:302:de10:7ae1 with SMTP id
 t13-20020a92ca8d000000b00302de107ae1mr37983326ilo.15.1671458776758; Mon, 19
 Dec 2022 06:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20221215154416.111704-1-hadess@hadess.net>
In-Reply-To: <20221215154416.111704-1-hadess@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 19 Dec 2022 15:06:05 +0100
Message-ID: <CAO-hwJJefrHHkffo2o1bq1iJCQJe2-Oq3PZ0to07RS0U-xA5Sg@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Guard FF init code against non-USB devices
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 4:44 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> The Force Feedback code assumes that all the devices passed to it will
> be USB devices, but that might not be the case for emulated devices.
> Guard against a crash by checking the device type before poking at USB
> properties.
>
> Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---

I have added cc: stable, and applied to for-6.2/upstream-fixes

Thanks,
Benjamin

