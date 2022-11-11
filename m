Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513D3624F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiKKA4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKKA4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:56:42 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA16C606BC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:56:41 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v17so3020309plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8AB4APy2pddbTNqiGQoT5yqMTz/uyFuVDSxlzN+Oi0=;
        b=aZS3vpOgOGqwuol0MaD23BOqPU3B6GloRsuvGNSE4Mq1CehxYKrRRfBCz1gLXnSrAx
         4yk5hShqx2fuWMSjjgvk1TG7RtC9xtkfNAGrqLCNn6CH2ke3k75FVppth/FtKWp++AXh
         jZV+LOklGig3Of0zt09LAZA9ZEAfmtrQldi9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8AB4APy2pddbTNqiGQoT5yqMTz/uyFuVDSxlzN+Oi0=;
        b=dut1F/GiNeagdwMACGvVQbFgq3PfMYj+IxcQj5jvYZEC6xKI7t6VBD4sOTTir45KyH
         Bt4VsJf/t8rWZgXoUqqXt1x3bzyKsiRuEiewVnJPT2apF3c4T6ZlmYAJrmV+s8mUWmKn
         ODGBRyiMIPUQgRMCgzZXknza7Z1sNPhqjNTMMWyA7IKI2Nb0ojRpaQh1Sh2203A0JeeN
         NDQpJ18nOPCdBVJUFWnY+A6H3k43wvicgtiQQuDeUll6Fz3dlXA7HJ9cEa0h/M0GrJ1c
         gkqXCaiogL26103ZgdsKNVPoCJpSWsnFfG5swZWMAu2DjeWtXtKQhx+YKMjSsaOgmZgq
         h1sQ==
X-Gm-Message-State: ACrzQf0ZrsfJ2hymF36Iln7+QJHO2pzAM6NuClj1togbCIEKPqHHctex
        bbiOJkWf0+iINe33rSBsH4VzLQ==
X-Google-Smtp-Source: AMsMyM5mW+0hkuFQJ6UywbnVVXvPVuRqZe3ekCt3uLAhkI9kyRQRsO3Q/YuQgGdBAHAIuNUlzwlLHw==
X-Received: by 2002:a17:90b:906:b0:212:e996:704a with SMTP id bo6-20020a17090b090600b00212e996704amr2772722pjb.13.1668128201364;
        Thu, 10 Nov 2022 16:56:41 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id r19-20020a634413000000b0046f59bef0c5sm218722pga.89.2022.11.10.16.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:56:40 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:56:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y22dxEcs2g5mjuQ7@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <Y21+xp52OQYi/qjQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y21+xp52OQYi/qjQ@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (22/11/10 14:44), Minchan Kim wrote:
> On Mon, Oct 31, 2022 at 02:40:59PM +0900, Sergey Senozhatsky wrote:
> > 	Hello,
> > 
> > 	Some use-cases and/or data patterns may benefit from
> > larger zspages. Currently the limit on the number of physical
> > pages that are linked into a zspage is hardcoded to 4. Higher
> > limit changes key characteristics of a number of the size
> > classes, improving compactness of the pool and redusing the
> > amount of memory zsmalloc pool uses. More on this in 0002
> > commit message.
> 
> Hi Sergey,
> 
> I think the idea that break of fixed subpages in zspage is
> really good start to optimize further. However, I am worry
> about introducing per-pool config this stage. How about
> to introduce just one golden value for the zspage size?
> order-3 or 4 in Kconfig with keeping default 2?

Sorry, not sure I'm following. So you want a .config value
for zspage limit? I really like the sysfs knob, because then
one may set values on per-device basis (if they have multiple
zram devices in a system with different data patterns):

	zram0 which is used as a swap device uses, say, 4
	zram1 which is vfat block device uses, say, 6
	zram2 which is ext4 block device uses, say, 8

The whole point of the series is that one single value does
not fit all purposes. There is no silver bullet.

> And then we make more efforts to have auto tune based on
> the wasted memory and the number of size classes on the
> fly. A good thing to be able to achieve is we have indirect
> table(handle <-> zpage) so we could move the object anytime
> so I think we could do better way in the end.

It still needs to be per zram device (per zspool). sysfs knob
doesn't stop us from having auto-tuned values in the future.
