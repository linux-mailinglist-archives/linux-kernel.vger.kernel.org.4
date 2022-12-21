Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0B652D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiLUHBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUHB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:01:28 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF648BB8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:01:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id d10so1157547pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8lfguS/R5l28BwM1JLclRJo0wooyg7ZgG8Xn7e24+VI=;
        b=ZbmmtNu8a3wKgraC7xoKXpRzifobRRXlPtRmmIamt23dMBiHMD8Wm6Mmg1sSqRt3i4
         bY0bY2Nn2MPqG09SP3iwcUryZeEGFBIOM8vjp6pqiMCUdp1ajYYXMam8mqM+2F4Cf/cM
         YqJmHFVhvtp00Dz1qIMvOQ5YN+5pFbafQpTcx6DJqx0z0SsGKuYM8yQewO4mkzIcwO/D
         04xReUcx4cq4FcyBvYMSfr5lldk9V3Hg6Z6ilkxu6ltT3uaTGYUVsYBaN4YCRKr0yJP/
         pkJ2JMyEaGuixvEC63jHEVhfC9kT9MnEU3ECrx9MqUEampMy71kxiJ5mx/LZyXR5KKhx
         7Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lfguS/R5l28BwM1JLclRJo0wooyg7ZgG8Xn7e24+VI=;
        b=HJKKLTQaD7yuGk9sgUKjzcU2fPY78HZgD2dI0dRxrF1e39Wa1/D7JiH8WVKnDp1UP1
         vSDO32oaOsaRYUvCmBmecB0thxFjiZAll7Qwlpzz+fKvCpOqWGCY8QB3fiqoWfYDmzzc
         bdmDxOU3RvV6RBp/+Yt6CojYM1yrO3K0rU0WMbmfiT9Cdip4fSe0qSRgMfJFhGyOif/E
         4ctG3V5kEnUW7xv4Oc7wmqys2nCiNnV9melggM+I4DQAKCAN98+1JEh0Avk8kbEcVtpR
         YdsOrbOZjbdZ9+6YUB9qm7z0XM3qMk0seXsKGAlPdOXX1xYLxzSTq85Q294lwGZCrwwk
         x7FQ==
X-Gm-Message-State: AFqh2krhsCmShto/5mQ9QNWu0eCSyyCzR/ErZe1YI/CqV9cG1i9IiR4T
        TJ0wKIO6S1dquqx5Mx/zqDc3pg==
X-Google-Smtp-Source: AMrXdXsH8jXt5lg4cvAsxJmJHCaYs84T0CQiR8wx0+o8cKnHDmqITkMzaPJurdtAART6DPwpTNnP8w==
X-Received: by 2002:a05:6a00:124c:b0:577:753a:6af with SMTP id u12-20020a056a00124c00b00577753a06afmr1302452pfi.31.1671606086156;
        Tue, 20 Dec 2022 23:01:26 -0800 (PST)
Received: from ruihai-HP.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id f185-20020a6238c2000000b00575b6f8b84esm9772567pfa.26.2022.12.20.23.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 23:01:25 -0800 (PST)
From:   Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
To:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        knoxchiou@chromium.org, weishunc@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: deferred probe when typec count mismatch
Date:   Wed, 21 Dec 2022 15:01:22 +0800
Message-Id: <20221221070122.4167-1-zhouruihai@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com>
References: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Is this really seen in the field ? The EC should never report a wrong
>>> (random) number of ports. If it is not ready, there should be _some_
>>> indication that it isn't ready. Does it really report a more or less
>>> random number in this case ?
>>
>>  Yes, I saw this on corsola board. The EC report a wrong number(not random), because corsola emulates HDMI MUX over the current
>>  type-c mux stack. The ec has to fake a type-c port to pass the MUX info. But the task are not initiated on starting up, and increase the
>>  type-c port counts after the tasks finished. In this case, I saw the typec->num_ports = 1, but the nports = 2, which will be probe failed and
>>  block the HDMI mux function.
>>
>>  I will send v2 patch, if nports > EC_USB_PD_MAX_PORTS, then return -EINVAL, but if nports > typec->num_ports, we consider wait a second
>>  to ec task increase the type-c port counts if there're a HDMI DB attach, then return -EPROBE_DEFER
>
> The current code just reduces nports if it is larger than
> EC_USB_PD_MAX_PORTS. Again, I don't see a reason to change that.
>
> Anyway, I am not sure if the above will work reliably. I am not sure
> what "HDMI DB" refers to, but if it is an external connector its
> status could change anytime. In that situation, no amount of waiting
> would help. Either case, the EC on corsola should really not change
> the number of ports it supports. Either it is a constant that should
> not change, or it is dynamic and the EC would need to tell the host if
> the number of ports changes (up or down). Trying to fix this in
> cros_ec_typec without well defined protocol exchange with the EC is at
> best a kludge, but not a real solution.

Thank you for the reply. The "HDMI DB" refer to the daughter board
attached to the mainboard, which don't change anytime. In fact,
the corsola EC increase the port count dynamically with some delay
(no see a standard yet) during bootup. There is the EC code to
increase the port count [1]. If the cros-ec-typec get the type-c
port counts from EC before the EC increase the port counts, then
will probe failed if return -EINVAL. I think the cros-ec-typec
is replying on the fragile delay in EC, cros-ec-typec module will
not get the fake(HDMI) type-c port counts once the EC deferred
call is later than the driver probe. That is why I make this
change. For the verification, the driver always probe failed
when EC reboot without the patch. But the driver probe passed with
the patch after a few times deferred probe.

Link:
[1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/program/corsola/src/usbc.c;l=47
