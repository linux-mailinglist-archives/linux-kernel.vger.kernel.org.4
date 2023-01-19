Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB4674717
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjASXUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjASXTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:19:25 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E227CCD4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:17:40 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y9so68677lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kpclHWjHCh8u37izsHyLub1WI5T41GcP65dSnJSHN4M=;
        b=D56pePQdJRVdGhjYma2YESmzkNwZ8lpP8cVRAdzQ9shd5SMdPcZvlcQrRViIEqJCi7
         I9y513i7+mJWw7Nk00G36cQksMDV06px3DdfYNk+2wdPf0KpY+NX2eYZzNo5AMrg7gZc
         vmrxpwDTFSB6FhVJFgCt9kD1Hdn2b/QsKXg61OrSoyuM2dXTbQNfy/Pop6bfx29xpakg
         FaE+MarJ3fSs7FsPr2MTWSMype3Z5WGEZronLqGQM9cS3C3OiAcdH4uHkCagyYhOMK6R
         r8ueD36XGs52tPcPEP6AY/voffZcW4UM10N25DHMFj3BsMfZcSQnDuqArWXV6QM1Kb1Q
         9MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpclHWjHCh8u37izsHyLub1WI5T41GcP65dSnJSHN4M=;
        b=PBaGtg+1Oa4hc2pm46MQ6S6dVdXkzbtUOSvUNBY0+FCuahq/SrEuHWkBvND+XwPI/a
         OyQK8d6gbDkokKLl7ToteVumjzloY8/WsmEtgPlHsVYLk5PYe8sJTrEjzdOoEpz63FCi
         7j/wL2pRCrcBV5XTAVO4CEwUvOpQShMlsDtojT3C5O66qGTwbsh+n5NhSjQX10flrzr8
         fBiPHkVhjvOQy+GkijtomDHvp/1fTRrCzTN1QBjxG1bQu1AUIWzbLZzHvfnipGKJH8ln
         nEQaXaKMXpp7UeDL4mCblQE/p86yZWq3S9GGTTD1sh0uI6jvAGJ8fJoVKEPQkO+lmNoO
         Z+1A==
X-Gm-Message-State: AFqh2kpcH4ItiXWndLPlRb5cCiaZWEjlOiUKlHWo54n9Pi1mJDRSt9FY
        7NguBJjBcnirrsoAO7ULPKHYh3iI/dT0W6i8F+VwWg==
X-Google-Smtp-Source: AMrXdXvevcNFMCqNhojGd+9L+5uQBtQtnlbRWqtgQrBc7GvAS4VtfYoPAfatTKdEewsqyvxVayU+tlNZ/Q9qNERW+Rw=
X-Received: by 2002:a05:651c:1584:b0:27f:acdd:e42b with SMTP id
 h4-20020a05651c158400b0027facdde42bmr718959ljq.308.1674170258541; Thu, 19 Jan
 2023 15:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20230119213903.899756-1-dennis@sparkcharge.io>
 <20230119213903.899756-2-dennis@sparkcharge.io> <Y8nCS8Z0QKzbeY2G@mail.local>
In-Reply-To: <Y8nCS8Z0QKzbeY2G@mail.local>
From:   Dennis Lambe <dennis@sparkcharge.io>
Date:   Thu, 19 Jan 2023 18:17:26 -0500
Message-ID: <CAKYiA1ACTXSg2RubWEq-ETXpfZaF7BCYgGHL66PyHL=nGPt9ew@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rtc: m41t80: probe: use IS_ENABLED for CONFIG_OF
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 5:21 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> > -#ifdef CONFIG_OF
> > -     wakeup_source = of_property_read_bool(client->dev.of_node,
> > -                                           "wakeup-source");
> > -#endif
> > +     if (IS_ENABLED(CONFIG_OF)) {
> > +             wakeup_source = of_property_read_bool(client->dev.of_node,
> > +                                                   "wakeup-source");
> > +     }
> > +
>
> A way better patch would switch to fwnode_property_read_bool

If you like that better, I'll make sure that's how I do it in future
revs of the patchset. I didn't know if it was appropriate since I
don't know if it would ever make sense to call acpi_dev_prop_get on
"wakeup-source" or "quartz-load-femtofarads", or if that kind of
consideration should even matter when choosing to use fwnode_* instead
of of_*.
-- 
Dennis Lambe (He/Him)
Lead Firmware Engineer
sparkcharge.io
