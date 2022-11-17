Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7F62D560
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiKQIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbiKQIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:46:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A35551326
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:46:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE6D62112
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37A7C43140
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668674785;
        bh=lshv90GZvIIRK6CiPhX598Z0NXfqQjkAdH3RaDMv5VI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u/OQDRNwnK/M9biz6uwuatzfT/SMUcdgkHij+2f2WkgwBIi67jSFOfow+6aVJOzI5
         6bfkSeOWA2AAcF7wIVZSlAdB93FVP4d8LwMpBWnavdF2n92eVcHHvfOgQKshqzkKnm
         noutrGxbrEL4RfwtSVfvkXcUA1Aw5rLsTsAuVPGmyQDLimO6vDJ0FKyp/7uB5rF+AQ
         vAFxT8B0sVy0su8LzqEB1N95Zww3N4JTh/K7YgC3AbQ6QvzlA6Y5jkjzuS2K5AhK6h
         AR+/vYHPVeQoziZehyoUhvH8lLgmCSup8jMHu72nHdPmvs4fnH5BGgepAxX9xXjujc
         T3/jw+ZHrP+rQ==
Received: by mail-yb1-f173.google.com with SMTP id z192so1120449yba.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:46:24 -0800 (PST)
X-Gm-Message-State: ANoB5pmmjwvz4Gv34L02VnPkGHS9pgHmj4euGqXXLCbFpbm07sscrOFb
        uYbD/OzthBYYhWcMaw4flcej5vHYGd9nuZKiJJ8=
X-Google-Smtp-Source: AA0mqf6HeEJZ+tdQw5CBNfxZKT4jBpeHrgZVXlfuQnhJWeQGG5PT1VyndJ7zdBDZbvkTJhvXL8jiWN3PXlXdLSAlpMU=
X-Received: by 2002:a25:83c7:0:b0:6dd:1ffe:2028 with SMTP id
 v7-20020a2583c7000000b006dd1ffe2028mr1209144ybm.550.1668674783929; Thu, 17
 Nov 2022 00:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20221116134126.199087-1-marpagan@redhat.com> <Y3T/ESXEb+MF2QEW@kroah.com>
In-Reply-To: <Y3T/ESXEb+MF2QEW@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 17 Nov 2022 10:45:57 +0200
X-Gmail-Original-Message-ID: <CAFCwf1193-TiMdx3unuHC1H4zK+7qYg_4A5mtOB7VGmqZ6M6HQ@mail.gmail.com>
Message-ID: <CAFCwf1193-TiMdx3unuHC1H4zK+7qYg_4A5mtOB7VGmqZ6M6HQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: added return value check for hl_fw_dynamic_send_clear_cmd()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 5:17 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 16, 2022 at 02:41:25PM +0100, Marco Pagani wrote:
> > The clang-analyzer reported a warning: "Value stored to 'rc' is never
> > read".
> >
> > The return value check for the first hl_fw_dynamic_send_clear_cmd() call
> > in hl_fw_dynamic_send_protocol_cmd() appears to be missing.
> >
> > Signed-off-by: Marco Pagani <marpagan@redhat.com>
> > ---
> >  drivers/misc/habanalabs/common/firmware_if.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
> > index 2de6a9bd564d..311942108dbc 100644
> > --- a/drivers/misc/habanalabs/common/firmware_if.c
> > +++ b/drivers/misc/habanalabs/common/firmware_if.c
> > @@ -1782,6 +1782,8 @@ int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
> >
> >       /* first send clear command to clean former commands */
> >       rc = hl_fw_dynamic_send_clear_cmd(hdev, fw_loader);
> > +     if (rc)
> > +             return rc;
> >
> >       /* send the actual command */
> >       hl_fw_dynamic_send_cmd(hdev, fw_loader, cmd, size);
>
> Are you sure this is ok?  If the first "clean the buffer" command fails,
> all should still be good as that wasn't the real command.
>
> But maybe the hardware will never fail this?
>
> thanks,
>
> greg k-h

Actually it's a real mistake, it was overlooked when the code was
written (although chances of failure in clear cmd are very small).
I'll apply it to my tree.
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Thanks,
Oded
