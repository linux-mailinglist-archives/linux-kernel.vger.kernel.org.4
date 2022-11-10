Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077AB624A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiKJTKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiKJTKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:10:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A16545EDE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:08:58 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso2572247pjc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G/mBYtyztie+h46PmH/Zk9zR5WE6VE58AciLGHizxbI=;
        b=SmJlkilE12HGb2sxMtzADB8mWWLr5U39bQBL/7O1hZWQtMgy3TV0d93aXgTIPejC8Y
         TyZffY736lWsDPIQDXaXfm7yx202fM43f7/Qi2RvURxY6USUTVgl5gBDL7l7ahZ/BmBA
         qIs77nlaqzDUKb6k6Mu5ysnXIhzPJAtQDbwmK9BA0xmhubloj1e6lV5uhfuLQnau3sMT
         rZRLbzdjxdx5I5AoBAdgY8UtJ3C0k4CQukGnLzed8ga+Xa7e1QDTDFqAFZ1ohGoEJ7QT
         nxBAo6gE0p+3SsTOrVz2D3i/NqabdqYsIY9UvyBfHmJGGLqywLjWc1n5gdtQVqnHjVtM
         ZFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/mBYtyztie+h46PmH/Zk9zR5WE6VE58AciLGHizxbI=;
        b=R2U67AnhiaKR+O2KUWz1iWOraMPIt9z8WdFK1vtnHaoi/MxQEzvpvQUIAPQCQ4tIL3
         2/FoPirvKOD39eOGh5SJD9o1TGJItZRoflBQAOATqbgd7MU6zS5dT21Q82WgcsbyNT7Z
         jbumaIPqLrATtBPGmR8fIWrCcvRUys2jwrM+X8xJt+wZNHXc4rYUathr2MVpQJ6qmpcf
         NIrCICnE9MUKYXBVXsGE8jQB7IY+FdItiA5GnJcfgzUYldz3cBpIbWZqBQQ7VeYJ/tec
         PUX0zG2+m2VVLhPetUZ6cCb60G637Q0u/mCPZ9uiyqn+5waLvy/ajR8MV8X4J7Z0gCU+
         detA==
X-Gm-Message-State: ACrzQf2t0oAt8HyVY75f8lgbyj+K/6ka2L6KnuSXEw1pCGODjRYQi8gO
        bU8MtNWQqOEJp63dO9B6r0JfHIT9D+/eoOeqfMs=
X-Google-Smtp-Source: AMsMyM5TElItKyrxA7BJRgm8tw06WTvSGL7ZM1pFeJNuHzXf512lMP/JotH3KDH26F5g+z7aWEKllgFznuY37dYZPv4=
X-Received: by 2002:a17:902:cccb:b0:185:4880:91cd with SMTP id
 z11-20020a170902cccb00b00185488091cdmr1758619ple.130.1668107337925; Thu, 10
 Nov 2022 11:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20221110190612.1341469-1-detlev.casanova@collabora.com>
In-Reply-To: <20221110190612.1341469-1-detlev.casanova@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 10 Nov 2022 16:08:44 -0300
Message-ID: <CAOMZO5BiFdVJ5tipBKfo6ZGSeGw4m4raoV_x1y1ffOJgBGg2Xw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Reset the CHIP_CLK_CTRL reg on remove
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:NXP SGTL5000 DRIVER" <alsa-devel@alsa-project.org>
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

On Thu, Nov 10, 2022 at 4:06 PM Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> Since commit bf2aebccddef ("ASoC: sgtl5000: Fix noise on shutdown/remove"),
> the device power control registers are reset when the driver is
> removed/shutdown.
>
> This is an issue when the device is configured to use the PLL clock. The
> device will stop responding if it is still configured to use the PLL
> clock but the PLL clock is powered down.
>
> When rebooting linux, the probe function will show:
> sgtl5000 0-000a: Error reading chip id -11
>
> Make sure that the CHIP_CLK_CTRL is reset to its default value before
> powering down the device.
>
> Fixes: bf2aebccddef ("ASoC: sgtl5000: Fix noise on shutdown/remove")
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
