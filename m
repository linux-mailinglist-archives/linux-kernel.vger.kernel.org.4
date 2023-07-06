Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FD074A46E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjGFTdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGFTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:33:18 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE519B7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:33:17 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so1245757276.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688671997; x=1691263997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/HxHbXLNJv+lS+LCsj1UjFihNTm7/vbMz1wj09lZS0=;
        b=TROPnefO4+gDrwvBfvPMatWedD7GsJrtpxi99yvQgsB6s9yRQkohIt7ny5ZPQJD8Kr
         TOAqGMJx8rnezjhfIkyv7CNJLPZExKtiqtfGblsFkR2PhTb38CpXBsQjJKzyrbeH53v2
         fDj4xNhS1jSYBC2O4yM49vZvuxkfzesOv0XdIzJC9mGTq/t0V8KsuGcHYjb6mVX161pJ
         Tlq9upDEOtv1Urxd860KNjgT7yjAXJ/Hi0+WyEJrh0oPNlNJ0NNxQt/0iYl+sexXyCVv
         cqRFxNKlmPVjCCJtDdMnk1CsabdYdlAVRosUUOfsvuVqggsirWHaAqYHMXMar2iywveH
         v4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688671997; x=1691263997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/HxHbXLNJv+lS+LCsj1UjFihNTm7/vbMz1wj09lZS0=;
        b=hkjzaqWj/jM++EHto6Y8/OhLP6xGqsb2WcPPVP5wq49xgOoVnYm9LBIt6kc5RXDDdb
         cUspSe5ePrxsA+Enb9q8f+2pzFQqKrtTjSDalxpwm6FCTS0iU1t3aKh3jyjDAJmcL+JP
         pf1ATulXXhnhLqPHWMRrHEuz3s+inUh5YMgtM1KioSdPHdITsxvPiX4esIzfMdduoXWj
         TEuTLbqyancPLM2r8dfPEZLs7F/kKvSOzxf4C6cII5OvLhbjJpiEkvp8QOLY/vOExKQe
         xn/2WfEluxmcPPfobSvfQnWerqKzcmKFmbjbxpLBex79Stc3DK5jeZCuitDLt5EhK6lv
         W67Q==
X-Gm-Message-State: ABy/qLb1tou7xNlBDjBI0dsOxfuQpMA9wqIqptqTn+8jUFhKxvaNKAxl
        jBU969KzcLjxIPOaqg8Wkszu4ZaL563UYKV+Keu/IJNQ37Q=
X-Google-Smtp-Source: APBJJlHgcvi6ghDvVIx2BKPyrE7PPMq00pH1YnkPcuZQJ6pCA053HlYmKDQhFGvKMxmiaODhbJP5Ng4gETCtTLs10fg=
X-Received: by 2002:a81:49c9:0:b0:56d:4d7:4a45 with SMTP id
 w192-20020a8149c9000000b0056d04d74a45mr2535462ywa.52.1688671996769; Thu, 06
 Jul 2023 12:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230706185100.84322-1-hugo@hugovil.com>
In-Reply-To: <20230706185100.84322-1-hugo@hugovil.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Jul 2023 21:33:05 +0200
Message-ID: <CANiq72kZ0cHxCKkm_781G__9tJxYCw3tpJarqvLOFB4Jw6ZONw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: hd44780: move cursor home after clear display command
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, Lars Poeschel <poeschel@lemonage.de>,
        geert@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 8:51=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
>
> The "clear display" command on the NewHaven NHD-0220DZW-AG5 display
> does NOT change the DDRAM address to 00h (home position) like the
> standard Hitachi HD44780 controller. As a consequence, the starting
> position of the initial string LCD_INIT_TEXT is not guaranteed to be
> at 0,0 depending on where the cursor was before the clear display
> command.
>
> Extract of CLEAR_DISPLAY command from datasheets of:
>
>     Hitachi HD44780:
>         ... It then sets DDRAM address 0 into the address counter...
>
>     NewHaven NHD-0220DZW-AG5 datasheet:
>         ... This instruction does not change the DDRAM Address
>
> Move the cursor home after sending clear display command to support
> non-standard LCDs.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thanks! Sounds good to me, as long the extra command does not
introduce some issue with the actual HD44780 -- can we double-check
the HD44780 still works as expected?

Cc'ing Lars and Geert since they may be able to give it a quick test.

> +       /*
> +        * Some LCDs (ex: NewHaven) do not reset the DDRAM address when
> +        * executing the CLEAR_DISPLAY command. Explicitely move cursor
> +        * to home position to account for these non-standard LCDs:
> +        */
> +       return hd44780_common_home(lcd);

Few nits:

  - Explicitely -> Explicitly.
  - Isn't the command `DISPLAY_CLEAR` instead of `CLEAR_DISPLAY`? (at
least the identifier above is `LCD_CMD_DISPLAY_CLEAR`).
  - `:` -> `.`.

What about something like:

    The Hitachi HD44780 controller (and compatible ones) reset the
DDRAM address when executing the `DISPLAY_CLEAR` command, thus the
following call is not required. However, other controllers do not
(e.g. NewHaven NHD-0220DZW-AG5), thus move the cursor to home
unconditionally to support both.

Cheers,
Miguel
