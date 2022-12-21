Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C197652E61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiLUJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiLUJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:21:02 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC32DEB4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:21:01 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-460bb6ec44bso10480427b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GdBHixmIEv6hOlchC/qp1j/sG6Htlu0RfoDp0oBFpT4=;
        b=D3X8mRE2crBgGEVyUX3K4KS+R2JbIxF9wo/5kXFjDg8fbDrSy0+PqWSIC5f1T0gfJM
         YxOylDvVXQyP3YJJaa8HndLDF/D8/qvMXz4119hQqQdfy7nA0CcnCVpcq+l7WvXVxS5A
         /Gm5XhG1fJFmyOLA6NEbEohEyZ4QJPHt0fV4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdBHixmIEv6hOlchC/qp1j/sG6Htlu0RfoDp0oBFpT4=;
        b=Law25uNaETlGqNlA5t8dofLkhdLIlWW9TnkaoNzdQBMeNtu7kC567hWU4gWCirhE/C
         TOoMpH93OeGTwofMbpduXGAy28gHtaUm7jqZubBK2GijFcq92d8xUdgjgNSm61HbAQDa
         IQDMqpHSN+KhdoNAity/LM23Lkx9F6sNN1l+dlmu3wcT+LzfBoztnCnFxcmyfRZpjvNe
         RqF8G0cgy/4qtvwxzkDExchrTu1KUhGtH0KGM1ThwyaztxhI/2SfXfJpaC8yfgWr+JGW
         ykkMx5UWvVap+4e+mWSmmu3AbODhQxOqCX1HkImhC+sVwSf/cF+qfp0vphooJaBJ0+MV
         NiZQ==
X-Gm-Message-State: AFqh2kq7G1oUW1fvgOwcMbLxSnnKRTKsRddMSVsYEI5JXSYYgnysLxzA
        XHhyhA1USQhgYFQTAyBnJs+xooeYqUd3sD20taFXojoTPgqDgrDu
X-Google-Smtp-Source: AMrXdXuDZP3huzKwnSrYzcLfOsxhi9bC8TChPDvh7YCGBFcEtyx2l6GJ/kdx10BPsjZhHQk7GW4nP63qMJH1yi1taFM=
X-Received: by 2002:a0d:cc8c:0:b0:368:70a8:9791 with SMTP id
 o134-20020a0dcc8c000000b0036870a89791mr129912ywd.197.1671614459562; Wed, 21
 Dec 2022 01:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com> <20221221070122.4167-1-zhouruihai@huaqin.corp-partner.google.com>
In-Reply-To: <20221221070122.4167-1-zhouruihai@huaqin.corp-partner.google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 21 Dec 2022 01:20:47 -0800
Message-ID: <CACeCKaeVMDWNCmatKBk+V60K_Cqct1gGT+iDk6Et08dY-BCdWQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: deferred probe when typec
 count mismatch
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Cc:     bleung@chromium.org, groeck@chromium.org, knoxchiou@chromium.org,
        weishunc@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 11:01 PM Ruihai Zhou
<zhouruihai@huaqin.corp-partner.google.com> wrote:
>
> >>> Is this really seen in the field ? The EC should never report a wrong
> >>> (random) number of ports. If it is not ready, there should be _some_
> >>> indication that it isn't ready. Does it really report a more or less
> >>> random number in this case ?
> >>
> >>  Yes, I saw this on corsola board. The EC report a wrong number(not random), because corsola emulates HDMI MUX over the current
> >>  type-c mux stack. The ec has to fake a type-c port to pass the MUX info. But the task are not initiated on starting up, and increase the
> >>  type-c port counts after the tasks finished. In this case, I saw the typec->num_ports = 1, but the nports = 2, which will be probe failed and
> >>  block the HDMI mux function.
> >>
> >>  I will send v2 patch, if nports > EC_USB_PD_MAX_PORTS, then return -EINVAL, but if nports > typec->num_ports, we consider wait a second
> >>  to ec task increase the type-c port counts if there're a HDMI DB attach, then return -EPROBE_DEFER
> >
> > The current code just reduces nports if it is larger than
> > EC_USB_PD_MAX_PORTS. Again, I don't see a reason to change that.
> >
> > Anyway, I am not sure if the above will work reliably. I am not sure
> > what "HDMI DB" refers to, but if it is an external connector its
> > status could change anytime. In that situation, no amount of waiting
> > would help. Either case, the EC on corsola should really not change
> > the number of ports it supports. Either it is a constant that should
> > not change, or it is dynamic and the EC would need to tell the host if
> > the number of ports changes (up or down). Trying to fix this in
> > cros_ec_typec without well defined protocol exchange with the EC is at
> > best a kludge, but not a real solution.
>
> Thank you for the reply. The "HDMI DB" refer to the daughter board
> attached to the mainboard, which don't change anytime. In fact,
> the corsola EC increase the port count dynamically with some delay
> (no see a standard yet) during bootup. There is the EC code to
> increase the port count [1]. If the cros-ec-typec get the type-c
> port counts from EC before the EC increase the port counts, then
> will probe failed if return -EINVAL. I think the cros-ec-typec
> is replying on the fragile delay in EC, cros-ec-typec module will
> not get the fake(HDMI) type-c port counts once the EC deferred
> call is later than the driver probe. That is why I make this
> change. For the verification, the driver always probe failed
> when EC reboot without the patch. But the driver probe passed with
> the patch after a few times deferred probe.

Sorry, but I agree with Guenter; I don't think this is justification to add a
hack for 1 board in this driver.

In what situation does the EC task take so long after reboot that it
occurs after a module probe (which occurs shortly after system boot up)?

Why is the "corsola" board increasing the Type-C port count dynamically
after some delay, and what is that delay amount? Why can't this be set
via CBI/DT or its equivalent on your ARM platform?

This seems like fragile code in the EC and should be fixed there. The
number of Type-C ports reported by the EC really should be invariant
across the boot lifecycle. I don't think this patch can be accepted.

Frankly, I'm concerned that doing this might be introducing some subtle
bugs in the EC Type-C code too (I'm certain there are assumptions
about port count being static there too).

If you really need to change the number of ports dynamically in the EC,
add a board specific-hook to not respond to the EC_CMD_USB_PD_PORTS
host command until you have "set" the number of ports.

Best regards,

- Prashant
