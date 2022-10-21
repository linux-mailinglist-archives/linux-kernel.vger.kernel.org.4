Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873B9606D33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJUBuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJUBuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:50:09 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEC252828;
        Thu, 20 Oct 2022 18:50:06 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id a14-20020a9d470e000000b00661b66a5393so952815otf.11;
        Thu, 20 Oct 2022 18:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXtMniGRjo+alje14xIQkt51WSfg95TNsE4aKDJMY7o=;
        b=sKWJ4xONEW1VmbAcYrUoTKiYM4IeONsS3IX0q0lMPt34Mp3ZZ1lPTseG52HClNyAgV
         Ux5qZQU7wUuN1sZ11IUOZjbQQW78755bgdiKdPdD9nTRz6v5LtlB6WBNq0OWe4ycX6ah
         7D5JviydKdbDhcrEFRmt8TJImDyBEsbGfjPtvaiexPBjtY9a2I53tZF018k1EMcbHWBm
         iZHgNXqljOY3URJkBxJFlini/7GjUHtEG5U+bMxmyog3XVyBl7hHYtoPMKq2Plez5m2U
         Dp1cs0oChp33QtSv98EVUh711D4zgRoD2i4q8Z8KDqF91iYOEup5qqh1b4DYtIG0UeK+
         U2OQ==
X-Gm-Message-State: ACrzQf2FErhKMAOVGO7okZqaowPVXhDayUvpGuiTkk5PRBLRXjVPfXn7
        HXe7AUwtgKMWqcSeG5Io2g==
X-Google-Smtp-Source: AMsMyM4Ciguq4zEE6+Xcmz64LPGpou0MBUCld6E6Pc+SNUryDONCLu6wvFK4dmjJbxf5kFDRs5pQ1w==
X-Received: by 2002:a9d:1b2:0:b0:661:9d4b:3673 with SMTP id e47-20020a9d01b2000000b006619d4b3673mr8168039ote.139.1666317005754;
        Thu, 20 Oct 2022 18:50:05 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w135-20020aca308d000000b003549dde122fsm614032oiw.5.2022.10.20.18.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:50:04 -0700 (PDT)
Received: (nullmailer pid 2149816 invoked by uid 1000);
        Fri, 21 Oct 2022 01:50:06 -0000
Date:   Thu, 20 Oct 2022 20:50:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mikhail Zhilkin <csharper2005@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] mtd: core: set ROOT_DEV for partitions marked as
 root devices in DT
Message-ID: <20221021015006.GA2145299-robh@kernel.org>
References: <20221019114855.31639-1-zajec5@gmail.com>
 <20221019115041.31805-1-zajec5@gmail.com>
 <c8d12dd0-7504-0198-dacb-b3723d82fc60@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8d12dd0-7504-0198-dacb-b3723d82fc60@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:53:15PM +0200, Rafał Miłecki wrote:
> On 19.10.2022 13:50, Rafał Miłecki wrote:
> > From: Rafał Miłecki <rafal@milecki.pl>
> > 
> > This adds support for "linux,root-device" binding that is used to mark
> > root device MTD partition. It's useful for devices using device tree
> > that don't have bootloader passing root info in cmdline.
> > 
> > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > ---
> >   drivers/mtd/mtdcore.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index 07249af4f890..034b06aff660 100644
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -28,6 +28,7 @@
> >   #include <linux/leds.h>
> >   #include <linux/debugfs.h>
> >   #include <linux/nvmem-provider.h>
> > +#include <linux/root_dev.h>
> >   #include <linux/mtd/mtd.h>
> >   #include <linux/mtd/partitions.h>
> > @@ -735,6 +736,12 @@ int add_mtd_device(struct mtd_info *mtd)
> >   		not->add(mtd);
> >   	mutex_unlock(&mtd_table_mutex);
> > +
> > +	if (of_find_property(mtd_get_of_node(mtd), "linux,rootfs", NULL)) {
> 
> I forgot to re-do "format-patch" after "commit --amend".
> s/linux,rootfs/linux,root-device/

It's really the filesystem you are tagging, not a device, so I think 
'linux,rootfs' is better.

Rob
