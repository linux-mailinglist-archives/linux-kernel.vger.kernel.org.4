Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7280D6B50FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjCJTeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCJTd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:33:56 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CA4618BE;
        Fri, 10 Mar 2023 11:33:49 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id v48so4261296uad.6;
        Fri, 10 Mar 2023 11:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678476828;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1tsoDHbRLd4Gsv2f3QvtJYgVrLylBlGS0wxu++9jiA=;
        b=C1qXAnzf+O6M8E4oJ1KpcT85YoiCJY0D3cxSx7khMiO/Wh9FWZLM8RkYLSt6GNKnV8
         8xsttC2yZrVAEb/t6XNV/njYre/AlINl6ixvvI6vBHfTCKKybKz0GOyj4vzTOnMZhgVh
         wnozj9sEzYJ0demzenhAO9CFrPMqIUWkqqY5bZXyd2JnpgV/HRNtX/niSkOqLYS9gwnh
         sZduIkN3POpFIladN4uSRZfMWuPKvVKBq4UQeRxj5bg/fxSUyuRZT0Hn0E0zPoOqG2nZ
         +mkIhWciUzwTvfL9XQs0xjt9ZpVPn0iUm/tZTLlXI0u8SxrDffwecxcOi8gvOCZCISa9
         tjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678476828;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1tsoDHbRLd4Gsv2f3QvtJYgVrLylBlGS0wxu++9jiA=;
        b=Tyd+HhXIVoCLuQFZrwhLV7TBJaCfGbzgTnxmaGdHJGucvgXj3gWVT29iZlthNHtYfk
         ilbbfOJ5UZ6GUh0w/dgm0afMc3EdusWgxtJ5U/bBepL6LJ3SesB5NJTpF8F00ZqiDq5f
         qZvE+RwmCVmp9f35sWaTezTq0YiMKbUuGCTaRwD3KD/AWCTqczyLEQPtD5W/NBQQes6H
         PM9HjEmAxoz0mnovkLA5JH5g8oHIlowzWv5jQW5vy+4xxFGYTQs9YCAjGN+t4f1zEDPa
         0VbOECUVSXmTZdLrjkxzkeTje5nAaKPQ3F96hVVQ5UxWDQY5HPadE+PmmBFg/hBuRPe7
         N8Sw==
X-Gm-Message-State: AO0yUKUOiGEf/XBJUJ6ArtUd8Z4p6UEp7+sh1tSnVV0w09VkrgOCAEch
        4nm7dTC7GgBnTTEURRV/GY0A0XFIfximFFH21+ieKhWXAfm0FG22
X-Google-Smtp-Source: AK7set9KRzPYK0gGoSDnMf/s/6uN1AuDxWAQvoeWKltmWdl/WPVumAR6jyG+9JpItD7bT5IZr7vw4dAnUeAx/gS/4q4=
X-Received: by 2002:a1f:4384:0:b0:41d:fe99:4633 with SMTP id
 q126-20020a1f4384000000b0041dfe994633mr16805286vka.2.1678476828197; Fri, 10
 Mar 2023 11:33:48 -0800 (PST)
MIME-Version: 1.0
References: <CAOCAAm7AEY9tkZpu2j+Of91fCE4UuE_PqR0UqNv2p2mZM9kqKw@mail.gmail.com>
In-Reply-To: <CAOCAAm7AEY9tkZpu2j+Of91fCE4UuE_PqR0UqNv2p2mZM9kqKw@mail.gmail.com>
From:   Mike Cloaked <mike.cloaked@gmail.com>
Date:   Fri, 10 Mar 2023 19:33:37 +0000
Message-ID: <CAOCAAm4reGhz400DSVrh0BetYD3Ljr2CZen7_3D4gXYYdB4SKQ@mail.gmail.com>
Subject: Re: Possible kernel fs block code regression in 6.2.3 umounting usb drives
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With kerne. 6.2.3 if I simply plug in a usb external drive, mount it
and umount it, then the journal has a kernel Oops and I have submitted
a bug report, that includes the journal output, at
https://bugzilla.kernel.org/show_bug.cgi?id=217174

As soon as the usb drive is unmounted, the kernel Oops occurs, and the
machine hangs on shutdown and needs a hard reboot.

I have reproduced the same issue on three different machines, and in
each case downgrading back to kernel 6.2.2 resolves the issue and it
no longer occurs.

This would seem to be a regression in kernel 6.2.3

Mike C
