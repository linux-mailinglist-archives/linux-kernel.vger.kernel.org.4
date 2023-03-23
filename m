Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7087F6C6FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCWSAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWSAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:00:48 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE53E1AA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:00:48 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id cu4so14648415qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679594446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCmJViR7AnJ87OgVngdPbSTlcpqdG4CS9e3iERkcMLs=;
        b=DIFW9o6IWATgiYe4QK7xhiWn3xuVkh+l1JTwF0NFaxhX/XYmaJlv3zC+f6dOa0cb9z
         uNl/FVxq/ZBBLcb/XnSzw3B6QEX3m2JgfA+hxaVZeHsZ1mRG3ouHCZvqcAQmCSS+M9/E
         oizrYYK5M3JK4EO91bmagPnpErOvGHlxICOhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679594446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCmJViR7AnJ87OgVngdPbSTlcpqdG4CS9e3iERkcMLs=;
        b=oOqEqNlCuDPX1fpbl+WN+DdawJWmbWdENOfzHCHYbClslnT+fcjLZCkJH/B9DNSTT+
         YyXKgyHbFA61ax1fJG88jYI3s2qjgRYBdyQMLmT5T0sJU2hgx29s/7wryAmwiKIijxRL
         CyCB7yIbmQ1EWdeKh+XQ5lRp+bl0yboj6QcBBOX+f3mSSftP5l6Cz3//vyUqgBfW6JJD
         btRUQxxhOP8KCkt9yNIvfKOdTiiT6kfV/SRPvNAcMPWFRjbB2mni4P2OKwK7C1+xE23Z
         Qcut3TqCGa+1AotuQ8rG6AVZkPhiGyc4/wLpA128DHbSp2MzRzM4ftDj5V2LYNucCevT
         0FnQ==
X-Gm-Message-State: AO0yUKXcs5QSFAE6CiuD0Ll7t2J/xo/ZjzjupY6F926XsnUGMKrQ+XaC
        zDJFkAAH9oVUNxX1m/cXLbrPrS6dODBbX3UoSwQ=
X-Google-Smtp-Source: AK7set9jNquvdp+f79r00v8DvvZnCM0PJfpii+Q9nUy2AgR84x8DhEoSA2S6f3aiofup+snKy5whjA==
X-Received: by 2002:a05:6214:5299:b0:570:bf43:499 with SMTP id kj25-20020a056214529900b00570bf430499mr12268644qvb.9.1679594446240;
        Thu, 23 Mar 2023 11:00:46 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n185-20020a3740c2000000b007402fdda195sm13698592qka.123.2023.03.23.11.00.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 11:00:45 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id p203so25810589ybb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:00:45 -0700 (PDT)
X-Received: by 2002:a05:6902:124a:b0:b69:fab9:de60 with SMTP id
 t10-20020a056902124a00b00b69fab9de60mr2829256ybu.0.1679594444864; Thu, 23 Mar
 2023 11:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com> <20230323114035.GL68926@ediswmail.ad.cirrus.com>
 <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com> <20230323174531.GM68926@ediswmail.ad.cirrus.com>
In-Reply-To: <20230323174531.GM68926@ediswmail.ad.cirrus.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Mar 2023 11:00:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X0SAEk_iUGQ=J-PWk_MzVc7ZikBM3N8rrnhGFzcdBNpw@mail.gmail.com>
Message-ID: <CAD=FV=X0SAEk_iUGQ=J-PWk_MzVc7ZikBM3N8rrnhGFzcdBNpw@mail.gmail.com>
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 23, 2023 at 10:45=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> I think really the best place to look at this would be at the
> regulator level. It is fine if mfd_add_devices passes, the problem
> really is that the regulator core doesn't realise the regulator is
> going to be arriving, and thus returns a dummy regulator, rather
> than returning EPROBE_DEFER. If it did the MFD driver would probe
> defer at the point of requesting the regulator, which would all
> make sense.

I think something like your suggestion could be made to work for the
"microphone" supply in the arizona MFD, but not for the others looked
at here.

The problem is that if the MFD driver gets -EPROBE_DEFER then it will
go through its error handling path and call mfd_remove_devices().
That'll remove the sub-device providing the regulator. If you try
again, you'll just do the same. :-)

Specifically in wm8994 after we've populated the regulator sub-devices
then we turn them on and start talking to the device.

I think the two options I have could both work for wm8994's case:
either add some type of "my children have done probing" to MFD and
move the turning on of regulators / talking to devices there, or add
another stub-device and add it there. ;-)

-Doug
