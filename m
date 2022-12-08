Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30A5647371
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLHPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLHPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:46:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F3D442E6;
        Thu,  8 Dec 2022 07:46:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vv4so5032336ejc.2;
        Thu, 08 Dec 2022 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hx136BtekxTmwLZD7bGGNVUmasUyrecFxbV6zXvxhlw=;
        b=VsLhZdFkHAAdY6gwdApujYzePoiaYntbpwi0+Kpqh2ZMQTXk4rFn3/ssggKjWUiTmR
         wNeYEiBX09HLYGcVur473K7hngdnLnLLzKxSsZ0NiMqN51CBpYhd4xEuarsx2H0GOkPT
         v79U47ce3Vkm75isoZKkb2bVz0O6H9x4lGWFgsX+tvAlyR6MAOSfIj+OeJuRjtOpgLRx
         rTluIfO19Ef2Ygr5RZOHHppeza48PZwAdnRI7LnAz2eastqvD2ZSsMac1l+FuGppfhCw
         jEmMP2CZZbTagifxtKUNQl4lMGMjrc8lXSLQDAGE3JMU6TTIHagnS2iQB5ppTWgQPFHL
         7vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hx136BtekxTmwLZD7bGGNVUmasUyrecFxbV6zXvxhlw=;
        b=jI+XKzYfomLxAoKF029hyCWPYWdKzPYFYyelAv0XB2pdodQVE9/mukOAxjx2NxWRWT
         PE07Pbq03sM/hhP0hGJr7L8zj0hUfpLQIDt7KzwFJXMio27c2S59rXP5A0rZVBK7PHJV
         /rhwbZ1MrSQCh/rwfIiG2Tz10KI8X11M/0gYg/QB7rCkDmqINNZm7xEGtFtS8PC8Pvop
         YquYsis79xBLXsh9dr5mqaM5wP+7SRp+zd2qbNC/wgNQKIH13abYPV+I8V5xhZnW2F+v
         xI6o4MGxuca4pPEUfdQ44JHQ1tLceK4h4PAOKnXChvHHiMKAVS6JR5lFLamYCXpfCjSq
         BC8g==
X-Gm-Message-State: ANoB5plAGDT66h+IkNVvn+nFGoP7K55aV0OEBCMwEq7ItWXnSG5z6wL0
        AtVyjWUBf87s2v19fnT6oWvrg7COFQ2CQDULalo=
X-Google-Smtp-Source: AA0mqf7hgGmmHaoKTJH7Ov6Q2Esx/9X+AVoDk7pjmrQlT+a1dcKvC5wjZUe63LaiZ+oN7xMTcf9/hyZZYTPFEu8qByo=
X-Received: by 2002:a17:906:4bc4:b0:78d:6325:356 with SMTP id
 x4-20020a1709064bc400b0078d63250356mr78824050ejv.6.1670514375534; Thu, 08 Dec
 2022 07:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20221205210354.11846-1-andrew.smirnov@gmail.com>
In-Reply-To: <20221205210354.11846-1-andrew.smirnov@gmail.com>
From:   David Rheinsberg <david.rheinsberg@gmail.com>
Date:   Thu, 8 Dec 2022 16:46:04 +0100
Message-ID: <CADyDSO4uh6b+sSZTkZ2_DR923=bA=kXgK1LqUMkknCMzf_DSwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Handling of non-numbered feature reports by hidraw
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
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

Hi

On Mon, 5 Dec 2022 at 22:04, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> I'm working on a firmware of a device that exposes a HID interface via
> USB and/or BLE and uses, among other things, non-numbered feature
> reports. Included in this series are two paches I had to create in
> order for hidraw devices created for aforementioned subsystems to
> behave in the same way when exerciesd by the same test tool.
>
> I don't know if the patches are acceptable as-is WRT to not breaking
> existing userspace, hence the RFC tag.

Can you elaborate why you remove the special handling from USBHID but
add it to UHID? They both operate logically on the same level, so
shouldn't we simply adjust uhid to include the report-id in buf[0]?

Also, you override buf[0] in UHID, so I wonder what UHID currently
returns there?

IOW, can you elaborate a bit what the current behavior of each of the
involved modules is, and what behavior you would expect? This would
allow to better understand what you are trying to achieve. The more
context you can give, the easier it is to understand what happens
there.

Thanks!
David
