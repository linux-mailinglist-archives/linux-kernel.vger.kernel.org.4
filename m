Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C428721C61
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 05:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjFEDEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 23:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjFEDEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:04:41 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFC8A9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 20:04:40 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-786e783a748so1185029241.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 20:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685934280; x=1688526280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GemXbMIq5lp+454RKyClJK8enwTWlxZVZu2OjpvqlY=;
        b=oPX1da39xxxDeDArWOnV6VvW0eqMDZSK7f9Ve9mZ0kzDSYY1VOdxziYIN0/fC6NW1m
         F/prs75MzDyyEYf0I12KVAvkEYP3P2XZcNI5tU3X7t4GTFd4snKp7LpRiaKWrmR/jKQ+
         +HFYU/lo//sCc8NY3bh61JGMniX1nPvtycInI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685934280; x=1688526280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GemXbMIq5lp+454RKyClJK8enwTWlxZVZu2OjpvqlY=;
        b=fZVVVabUmMy/a4D0guZiyBrqZ/dLJxHYSrIDrNaPAqkCWTH9EkI8rK6dDyF/jVaQHa
         zFZvQhkzjEMEVA0YSppTbxtfAJ7netM6ltX6WTSmc0vCGlHB/98vvDq+/szzSCm8e3Zr
         A9BQLHM5ow75MA3V3dEXTI558BhNBtr68BQiW/FWEWp6rUAkV9VJDbkulJ+f8mXNSrZV
         8hgi+IRt3nOV4w2nxurfOAhZU4isaISVGJYHVKovLECDTv61pmqmEa/EZ7thslZRBkL3
         4CSOKvUe5Z4Bdu0CovK0NBhWLShn0e+6Euta6ZCoQWWwnr86yRWy52410AIQNQtD7mZC
         XCCg==
X-Gm-Message-State: AC+VfDwxYk0SfY8E20UmXIt/Xl5eV7wHAsFDQ3j/tnB1q244m17MGlH9
        r6eKrswlbHFvpKao1vrIaqQKxetYC8CH0amE1kscZA==
X-Google-Smtp-Source: ACHHUZ6jpGq4+6/+6ClKSVvkgkwQzzirwShAHbQSCjNu7NjQjavUuh0PcSmBXhB3NwTi/oX4WQQPRVTj7U6bPKM8aSE=
X-Received: by 2002:a1f:3d4e:0:b0:45c:e022:d713 with SMTP id
 k75-20020a1f3d4e000000b0045ce022d713mr4342803vka.12.1685934279946; Sun, 04
 Jun 2023 20:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230525113034.46880-1-tony@atomide.com> <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
In-Reply-To: <87a5xii33r.fsf@jogness.linutronix.de>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 5 Jun 2023 11:04:28 +0800
Message-ID: <CAGXv+5Gy=SqKukrDTpx+qVDgNDzMmMcC+Y0wkgfRA9xZCKBA6w@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 6:13=E2=80=AFPM John Ogness <john.ogness@linutronix.=
de> wrote:
>
> On 2023-06-02, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > This patch, in linux-next since 20230601, unfortunately breaks
> > MediaTek based Chromebooks. The kernel hangs during the probe of the
> > serial ports, which use the 8250_mtk driver.
>
> Are you sure it is this patch? Have you bisected it?
>
> Unfortunately next-20230601 also brought in a series that added
> spinlocking to the 8250 driver. That may be the issue here instead.
>
> For 8250 bug reports we really need to bisection.

As Tony mentioned, you're off the hook for it.

I should've been more clear. After reverting the top three patches in
drivers/tty/serial from next-20230602, the system booted correctly again:

    539914240a01 serial: core: Fix probing serial_base_bus devices
    d0a396083e91 serial: core: Don't drop port_mutex in
serial_core_remove_one_port
    84a9582fd203 serial: core: Start managing serial controllers to
enable runtime PM

ChenYu
