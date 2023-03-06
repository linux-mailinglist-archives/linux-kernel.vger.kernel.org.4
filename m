Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BAD6ABA86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCFJ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCFJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:58:21 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972F71FEB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:58:19 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id x40so6017918uaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678096698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRpnKTH215Tktra2dAqtBTdRYqmrUvNtxnmB3KqVPb4=;
        b=8DvcYCoqlk4SM1NgdpcHCAWdD9VNX+dQ+Pv2VjwdE5BjDJKLi3KI5op/J7EwlHeaF3
         Oa1jFAVeaw6QOgWHI4eQt1KSe6kYeL6FfGCMSVoK8/JenAXWKj4nP96Iz4W3jyumSBZd
         uf1DC+32RJ9Xr6AlljXI6lJYT9CIeE86c0Sb6rG0y+Vp9CHlbqt1mUARddSbEkAnhbSJ
         2DGVU/KLzeKJ626lanxicMIrE+ltN7mhI92FRvEM1qPRdDioq/aZAbMQBP/uSnlQW4V3
         HL1BuP+g2m3eFCwC+gsz2z9+xdjjrR6vcyxj1G+ywbX5QFMt078ZL4VpGjWB5J/e5rqp
         QwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678096698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRpnKTH215Tktra2dAqtBTdRYqmrUvNtxnmB3KqVPb4=;
        b=aMgcK49Dbm0mJyII6nVWb+4zwc3Jpqqihf50R6cm3zFBKmTewvlg8F6kRzVqIPmMXl
         AsIY4A/kHZb5WIB201JsI59rzTOyV59BciV3hJhHmfZ9wvDd1KRFZs7LKAchAbPYxhjv
         9jIt8hFS6lETfhB1UiZC3WHPCncF/t7XrTnPmGDGxLMROkeai8Cu3etqi/FrNWhKv8UV
         Yfk6FSsB8jFPq2uUuUCQiKoKEJWBldP2fLd31k2QVazplCYePzgzLDy1rtoFXNYzmUEt
         r7Ugb7RQpcRfgH3rUTncb6JgqzIORbG5ilPZZMLCTzE+lM9FwXdwFkGEBiWkn0S2sw9O
         rrQg==
X-Gm-Message-State: AO0yUKUleDhzeTJk252NfphoQIg7VogRCBsaTsrcmNSDBFVc+XBAGi5v
        2JieFbWiBiayynoSA1yN5rsQ3W2qsT8+RSxzOccRBA==
X-Google-Smtp-Source: AK7set+0zWHQAAjF2kAMkOwQrSPD0Vb9EVA5afzS9lp2Pf3FaA54xLXOg45Z286kIc19kLc4ijTSX17RNn/g1A4Dv+U=
X-Received: by 2002:a1f:38cc:0:b0:406:55ae:5d93 with SMTP id
 f195-20020a1f38cc000000b0040655ae5d93mr6374682vka.1.1678096698699; Mon, 06
 Mar 2023 01:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20230217141059.392471-1-nick.alcock@oracle.com> <20230217141059.392471-21-nick.alcock@oracle.com>
In-Reply-To: <20230217141059.392471-21-nick.alcock@oracle.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 10:58:07 +0100
Message-ID: <CAMRc=MfEVgF+6NyAB=3g3_mFvfppHg45LNnvopO_SwqdeNFgkA@mail.gmail.com>
Subject: Re: [PATCH 20/24] kbuild, gpio: remove MODULE_LICENSE in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 3:12=E2=80=AFPM Nick Alcock <nick.alcock@oracle.com=
> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>

Applied, thanks!

Bart
