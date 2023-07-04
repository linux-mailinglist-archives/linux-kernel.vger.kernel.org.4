Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38B746B61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGDIBu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 04:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGDIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:01:47 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1AFBD;
        Tue,  4 Jul 2023 01:01:46 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so5886056276.3;
        Tue, 04 Jul 2023 01:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457706; x=1691049706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VFQbKQ0ZnXtJ93rzqEp4TN1FXtg0VMVDun5sAa3KpE=;
        b=SDquQbPBWpTbehYAmyvhPCkR1YBjoD2kcCsVDC1WE7hT2TyPqMk0zcpEQ+QrP9/WFP
         yz149Nsu9rx2RFISvczX1V20aE/nwr7KN13G3nLL3HGBUTiwsLcx/kOJlOUyzYDuKV78
         1bGwV9GVD9Y5860FBgqLOq1FAsuh9efwZv84cwlr/Q7GpcB9j4TXoCQwCw6vLjvsKbqd
         j1wCsqgCJaeQbG8z+Gtw1efA2ECnxL/ndkpzVwjWKKGv1BRotrRUeHgcWSsxtfM9crR/
         JB2lLSCBcDsXeMxW39sJ+nlPPzRszb1z+F+/p2zsrKA/NfGGW8Jm7QBxrnFl9q7P9z1r
         1FWQ==
X-Gm-Message-State: ABy/qLabVOqQAHqTiKIKxYlwGqLfhYkpmgh3GNpsGxmtx978XVCkr+qw
        E3BtfcOhU/4XcjRuPAZOMLoR5gMqgrPiog==
X-Google-Smtp-Source: APBJJlHuE0CyWv1H1OT9oPTvzcdrZ4aBv/ohZ3eDhedacSRBOh5ouERAtTbgDBp9fGCmyX6U/bHOPQ==
X-Received: by 2002:a25:9e87:0:b0:bcc:571d:a300 with SMTP id p7-20020a259e87000000b00bcc571da300mr10345771ybq.20.1688457705942;
        Tue, 04 Jul 2023 01:01:45 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id a126-20020a254d84000000b00be45a29d440sm4777189ybb.12.2023.07.04.01.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 01:01:44 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-c50c797c31bso2558601276.0;
        Tue, 04 Jul 2023 01:01:44 -0700 (PDT)
X-Received: by 2002:a25:6cd4:0:b0:bac:1522:f870 with SMTP id
 h203-20020a256cd4000000b00bac1522f870mr12173244ybc.52.1688457704084; Tue, 04
 Jul 2023 01:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230703230534.997525-1-javierm@redhat.com> <20230703230534.997525-2-javierm@redhat.com>
 <CAMuHMdXRg1OUy6UHuH4H+qkK-qO+jTKdVoG_SRM3q_PkyD+Bbw@mail.gmail.com> <87h6qkyuv4.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87h6qkyuv4.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 10:01:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBkV30X32UWdV5k_PSJfeOF-a5=eCBo_3N2265w+n1hA@mail.gmail.com>
Message-ID: <CAMuHMdVBkV30X32UWdV5k_PSJfeOF-a5=eCBo_3N2265w+n1hA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] video: Add auxiliary display drivers to Graphics
 support menu
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Jul 4, 2023 at 9:54 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Tue, Jul 4, 2023 at 1:05 AM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> The drivers in this subsystem are for character-based LCD displays, which
> >> can fall into the same category of the DRM/KMS and fbdev drivers that are
> >> located under the "Graphics support" menu. Add auxdisplay there as well.
> >>
> >> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/video/Kconfig
> >> +++ b/drivers/video/Kconfig
> >> @@ -30,6 +30,8 @@ if HAS_IOMEM
> >>  config HAVE_FB_ATMEL
> >>         bool
> >>
> >> +source "drivers/auxdisplay/Kconfig"
> >
> > This is inside the "if HAS_IOMEM" section, while there was no
> > such limitation before.
> >
>
> Gah, I missed that. Thanks a lot for pointing it out.
>
> If I move the source outside of the if block, are you OK with this patch?
>
> I think Thomas is correct and would make sense to put the character-based
> drivers next to the DRM and fbdev drivers since all these are for display.

Yes, makes sense to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
