Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474D7682014
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjA3Xwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjA3Xwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DFF2DE61
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675122722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAdTklmEDyAgRNbObsy/Ygo6Kv9vgqHE1ov2RCXdrFg=;
        b=cooegUOTAGO7rvWFTc16Uakzm1X1He/Fo5jchbeFU4XcMuxZvOA3iR4BIVOQR9h7+Ojjx2
        5jr2Bqb5N3dbsSsoGH1wn3cu7w4E0NUlS/+vn2lXQ1TBr13bo7X6lwVZM/qf+eLpw74p5P
        rVD/mtgnoszOKOjcL4Fy/tUSZIpmI0A=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-4aUFJjgFMxyzHn8l97Y27A-1; Mon, 30 Jan 2023 18:52:00 -0500
X-MC-Unique: 4aUFJjgFMxyzHn8l97Y27A-1
Received: by mail-io1-f71.google.com with SMTP id x12-20020a5d990c000000b00707d2f838acso7590218iol.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAdTklmEDyAgRNbObsy/Ygo6Kv9vgqHE1ov2RCXdrFg=;
        b=jLymSfLjg9lskfhY3ycoWu/9U7gKwkAtR9lI1KCiBR6CJHg7ILnqGjHAjwJDoN61ru
         qQCxU+zCMZ5VVCCdplvCLoH4AzCB+yhKaI1HUt5Gh2a6JaTu5YZ4pgrUpPfrDWC+T2XQ
         f7X6jKGjUYYs9UwA/v8FwhNXqogl4LYBbIHU9qp+L7m/41Tzyt255w4a4tgMs/ongfmk
         ez3KxVqgSmbgAuKOUraxqzNx0nQf7brmGTdog7xaY6S6izOGEloz92+i73KgD+hVKZKR
         lxwbZwL9OcFlH5MzedCHtlPGQHthPEsw/1/R/zG+43o89KLW0R0AJMIXyOLzia0sSirw
         HZaQ==
X-Gm-Message-State: AO0yUKWONvjXvNfqi4ovV19bemlLgmlq7SBZDUepnZD3SrJO2R3GLwUK
        26L3fZSKothNX0PoB2eadntsHdRuxGVBh8TLm329wTSgTPchlszDknWaRJ6Lw1hCSErZuUKTMlS
        00KlwO3vcIlBroQ21nwhb+NEQ
X-Received: by 2002:a05:6e02:190f:b0:310:eb55:3856 with SMTP id w15-20020a056e02190f00b00310eb553856mr6886965ilu.9.1675122720173;
        Mon, 30 Jan 2023 15:52:00 -0800 (PST)
X-Google-Smtp-Source: AK7set+Tjuh/QLV5ACoKjB78BPy3FHiMPojdoqjURp7yFxxmHnP5uajB9G0cNMY2hpBpgzJz6u+eCQ==
X-Received: by 2002:a05:6e02:190f:b0:310:eb55:3856 with SMTP id w15-20020a056e02190f00b00310eb553856mr6886951ilu.9.1675122719932;
        Mon, 30 Jan 2023 15:51:59 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w65-20020a025d44000000b0039deb26853csm5227538jaa.10.2023.01.30.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:51:59 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:51:58 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        dri-devel@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt \(Google\)" <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] [v2] vfio-mdev: add back CONFIG_VFIO dependency
Message-ID: <20230130165158.6993fc28.alex.williamson@redhat.com>
In-Reply-To: <20230126211211.1762319-1-arnd@kernel.org>
References: <20230126211211.1762319-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 22:08:31 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_VFIO_MDEV cannot be selected when VFIO itself is
> disabled, otherwise we get a link failure:
> 
> WARNING: unmet direct dependencies detected for VFIO_MDEV
>   Depends on [n]: VFIO [=n]
>   Selected by [y]:
>   - SAMPLE_VFIO_MDEV_MTTY [=y] && SAMPLES [=y]
>   - SAMPLE_VFIO_MDEV_MDPY [=y] && SAMPLES [=y]
>   - SAMPLE_VFIO_MDEV_MBOCHS [=y] && SAMPLES [=y]
> /home/arnd/cross/arm64/gcc-13.0.1-nolibc/x86_64-linux/bin/x86_64-linux-ld: samples/vfio-mdev/mdpy.o: in function `mdpy_remove':
> mdpy.c:(.text+0x1e1): undefined reference to `vfio_unregister_group_dev'
> /home/arnd/cross/arm64/gcc-13.0.1-nolibc/x86_64-linux/bin/x86_64-linux-ld: samples/vfio-mdev/mdpy.o: in function `mdpy_probe':
> mdpy.c:(.text+0x149e): undefined reference to `_vfio_alloc_device'
> 
> Fixes: 8bf8c5ee1f38 ("vfio-mdev: turn VFIO_MDEV into a selectable symbol")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix the s390 and drm drivers as well, in addition to the
> sample code.
> ---
>  arch/s390/Kconfig            | 4 +++-
>  drivers/gpu/drm/i915/Kconfig | 1 +
>  samples/Kconfig              | 3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)

Applied to vfio next branch for v6.3.  Thanks,

Alex

