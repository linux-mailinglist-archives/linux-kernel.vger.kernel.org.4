Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC365BB470
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIPWj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIPWjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2988BB9F84
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663367962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhYwrTEM5JyN6rurGhxXS/hiRRIr6cuLaeWImR7nsEk=;
        b=OMwLOeicIIPv6eP/wy53cXca+e0CKuv4xveWpcUOsowb820xTetNkyN4SlKNR8wTeGU68X
        nqWmyUNmT5/cE9/HouIULkEpnmYOlvUr0bZyUTDC/OIC4yWvazzUBxl6C8w92qVt5GTVBi
        cHRGDU3odTcsmQZGz/OAswJEUYtl26g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-MKuOPdr8PE6Ts0uVhdkXrQ-1; Fri, 16 Sep 2022 18:39:21 -0400
X-MC-Unique: MKuOPdr8PE6Ts0uVhdkXrQ-1
Received: by mail-qk1-f197.google.com with SMTP id n15-20020a05620a294f00b006b5768a0ed0so19390555qkp.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HhYwrTEM5JyN6rurGhxXS/hiRRIr6cuLaeWImR7nsEk=;
        b=0DZySYarIUyiA5dsDdJ2ZNZHaWjJd9Y5beKcjUCVkTyczZyiMWpu7Gay1lJhvp3IR8
         hQkeU+rTvSgi0W94D5atqI1pCeGhvAr5jPQLQA4Yxc0aopXEnUCXldvLh98vxlGlsEYL
         919A4fkGtL9RHU8CHbJCfi2GEoeJUwQTj8j4Hk7UjrkjjsYBqhyyE3bpanzTnvDXL+ie
         6KBHwR95/RY9zUc4bNNq6rnhjoOThFHkLz2bQLdbrNMV+h18SH8aSWwt4tKprvtm8cLw
         2YYxFzUm2SIay2MqcwJNBl1LipAsg5Sbye9wdtq8WrLy2sKvqmlwjBDLXII9bjDE21BM
         p96A==
X-Gm-Message-State: ACrzQf1I3NMSuBoO2gJWdw9+rZh3UvnSCZDiCSGUsz0iciCnk2tx126y
        AVioCjcQTqEig6HQBQIiQXxW6rFzoJ7tOTZTvUSjIw984joPS7/X24agjLt9oGdhFMQw/gAtAFY
        MIQaGplSqaJRijKC1lHK63R8z
X-Received: by 2002:ac8:5e08:0:b0:35c:b97b:8b23 with SMTP id h8-20020ac85e08000000b0035cb97b8b23mr6459285qtx.585.1663367960572;
        Fri, 16 Sep 2022 15:39:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4IVYbEJeATX3JAJs4XV52Zi5ZgFDy8Zk10Y3Fl8S96hqyY7mNdc2kNc23f7trtnw+ZkPicgQ==
X-Received: by 2002:ac8:5e08:0:b0:35c:b97b:8b23 with SMTP id h8-20020ac85e08000000b0035cb97b8b23mr6459269qtx.585.1663367960355;
        Fri, 16 Sep 2022 15:39:20 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00::feb? ([2600:4040:5c48:e00::feb])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a011200b0035ba4e53500sm6315183qtw.56.2022.09.16.15.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:39:19 -0700 (PDT)
Message-ID: <4b0d603814c8740b125cc6130b67c79e37405d69.camel@redhat.com>
Subject: Re: [PATCH 0/9] Input: synaptics-rmi4 - Bootloader v7/v8 firmware
 update improvements
From:   Lyude Paul <lyude@redhat.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Sep 2022 18:39:18 -0400
In-Reply-To: <a959cfe90356b702727413e7c14b246875eb88b6.camel@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
         <26790cfecb827245187233bc81f9fb89553bb4a7.camel@ew.tq-group.com>
         <c434ba87606d3d7696ae076684ceea67bfe662e3.camel@ew.tq-group.com>
         <a959cfe90356b702727413e7c14b246875eb88b6.camel@ew.tq-group.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would my review count at all here? I hadn't reviewed until now because I
wasn't sure it would, but I'm happy to take a look if you think that'd help.

On Thu, 2022-09-15 at 10:02 +0200, Matthias Schiffer wrote:
> On Mon, 2022-08-15 at 09:43 +0200, Matthias Schiffer wrote:
> > On Mon, 2022-06-27 at 10:31 +0200, Matthias Schiffer wrote:
> > > On Wed, 2022-06-08 at 14:47 +0200, Matthias Schiffer wrote:
> > > > This fixes the firmware update function with bootloader v8, allows to
> > > > recover from interrupted updates with v7/v8, and does some code cleanup.
> > > > 
> > > > I believe that the code that allows to recover from a broken partition
> > > > table is also necessary to make flashing a different partition table
> > > > work at all, but I wasn't able to verify that, as I don't have any firmware
> > > > images with different partition tables to test with. In any case, I'm
> > > > pretty sure that it is working correctly now, as recovery from a mostly
> > > > empty flash without partition table has been tested successfully.
> > > > 
> > > > I have only tested the new code with bootloader v8, and I don't have the
> > > > documentation / interfacing guide for v7, so it would be great if anyone
> > > > could check that I didn't break updates for v7.
> > > 
> > > Hi everyone,
> > > 
> > > any news regarding this patch series?
> > > 
> > > 
> > > Kind regards,
> > > Matthias
> > 
> > Ping - can we get this applied, or at least any kind of feedback?
> > 
> > 
> > Kind regards,
> > Matthias
> 
> 
> Ping - another month has passed.
> 
> Should I resend the series? Not much has happened in the RMI4 driver,
> so the patches still apply cleanly to latest linux-next.
> 
> Kind regards,
> Matthias
> 
> 
> 
> > 
> > 
> > 
> > > 
> > > 
> > > > Matthias Schiffer (9):
> > > >   Input: synaptics-rmi4 - fix firmware update operations with bootloader
> > > >     v8
> > > >   Input: synaptics-rmi4 - introduce rmi_f34v7_check_command_status()
> > > >     helper
> > > >   Input: synaptics-rmi4 - fix command completion check for bootloader
> > > >     v7/v8
> > > >   Input: synaptics-rmi4 - rewrite partition table unconditionally
> > > >   Input: synaptics-rmi4 - reset after writing partition table
> > > >   Input: synaptics-rmi4 - make rmi_f34v7_erase_all() use the "erase all"
> > > >     command
> > > >   Input: synaptics-rmi4 - remove unneeded struct register_offset
> > > >   Input: synaptics-rmi4 - simplify rmi_f34v7_start_reflash()
> > > >   Input: synaptics-rmi4 - drop useless gotos in rmi_f34v7_do_reflash()
> > > > 
> > > >  drivers/input/rmi4/rmi_f34.c   |  16 +-
> > > >  drivers/input/rmi4/rmi_f34.h   |  17 --
> > > >  drivers/input/rmi4/rmi_f34v7.c | 349 +++++++--------------------------
> > > >  3 files changed, 81 insertions(+), 301 deletions(-)
> > > > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

