Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9845E6CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiIVUSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiIVUSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32349110B0A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663877924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3oprjemUkt7kMHECIu5uPyweyyYP9Tv3GSK6vQIX50=;
        b=J1S6QCbOr2yjSXRj9J+bmIznY7IhoaJCkuKd0G0Yn0Hyk+Sh/IY42AfkjtTz62HXpxKjKl
        /OZ+2QRGUxxwT348APWFhTRrKDeaym7W0m5CtyGiMMX6U4/i9IN2BvAikqWepObR4k3FjC
        O/y/1UBevnuD0KrD9W2Meavfs4z4Fbw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-t0K73ewvN1OClP4CxhOYzQ-1; Thu, 22 Sep 2022 16:18:43 -0400
X-MC-Unique: t0K73ewvN1OClP4CxhOYzQ-1
Received: by mail-qt1-f198.google.com with SMTP id g6-20020ac84b66000000b0035cf832dec9so6849369qts.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A3oprjemUkt7kMHECIu5uPyweyyYP9Tv3GSK6vQIX50=;
        b=zG7d84PFf7aVUKCvCCLaTZxG50tqknnQdbl73tjSlna0cy2Ojy66/I/C9hfsj/DnZi
         6Joc7uGs4oBY5uUGGzD6+cM2OfzFWl4/b9WDSSrGlYWOOT0ZyAFoejq+HXS/xK/H+ekn
         cKj58EKo4YbQmozafZBFpUu5OiJy+YMATO27IClS4/9FEitpieiBXxfGBN6yvgPtWDu4
         80V4WceHB1J2Ih8R1HsT9D2qShMNtLXOsyVBymzpGrQmp+q6OmpJAEWFgBlfobeuqY5G
         AIuvCxTsbHyutukOTToDsrE6s90fl1yotyzfqLihXnLcteXmurpLKm0dric7Qp7SqWf0
         cObw==
X-Gm-Message-State: ACrzQf3bbaGq8gH5eK5ep3yS6W/hv/r88eqtuknIXughOl2FFhrWaawY
        h/4YSKV8F9mWetbrI2yEKBJ7Rq08q1b8YkkP6ckQqanqkBDSLDulTaBIsmdsK//S5jYl4zJ+iT3
        kLVnvY1//OxsLi+mk5CHv19cQ
X-Received: by 2002:a05:6214:ca9:b0:4aa:a2c9:2f23 with SMTP id s9-20020a0562140ca900b004aaa2c92f23mr4168780qvs.60.1663877922798;
        Thu, 22 Sep 2022 13:18:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pni2LYkOzrlIhwMpx1cHEHZsx5JF13Oj7xoj30GUGp9q95MmDDdN84zCN9ktdm0iGF55Otg==
X-Received: by 2002:a05:6214:ca9:b0:4aa:a2c9:2f23 with SMTP id s9-20020a0562140ca900b004aaa2c92f23mr4168770qvs.60.1663877922617;
        Thu, 22 Sep 2022 13:18:42 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00::feb? ([2600:4040:5c48:e00::feb])
        by smtp.gmail.com with ESMTPSA id o67-20020a374146000000b006ced5d3f921sm4248065qka.52.2022.09.22.13.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 13:18:41 -0700 (PDT)
Message-ID: <76ef7f62cf3327e4c7fc4ff96c2978e8dfabff91.camel@redhat.com>
Subject: Re: [PATCH 0/9] Input: synaptics-rmi4 - Bootloader v7/v8 firmware
 update improvements
From:   Lyude Paul <lyude@redhat.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Sep 2022 16:18:40 -0400
In-Reply-To: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry this took me a little while to get to, but more sorry it took so long
for anyone to review this for you!

Anyway-luckily it seems I retained most of my RMI4 knowledge, so I was able to
follow along with the patch series pretty easily. I basically only had one
small comment about a missing Cc: stable@vger.kernel.org tag on one patch, but
the rest looks good to me:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Feel free to poke me if you need my help getting anything else reviewed

On Wed, 2022-06-08 at 14:47 +0200, Matthias Schiffer wrote:
> This fixes the firmware update function with bootloader v8, allows to
> recover from interrupted updates with v7/v8, and does some code cleanup.
> 
> I believe that the code that allows to recover from a broken partition
> table is also necessary to make flashing a different partition table
> work at all, but I wasn't able to verify that, as I don't have any firmware
> images with different partition tables to test with. In any case, I'm
> pretty sure that it is working correctly now, as recovery from a mostly
> empty flash without partition table has been tested successfully.
> 
> I have only tested the new code with bootloader v8, and I don't have the
> documentation / interfacing guide for v7, so it would be great if anyone
> could check that I didn't break updates for v7.
> 
> 
> Matthias Schiffer (9):
>   Input: synaptics-rmi4 - fix firmware update operations with bootloader
>     v8
>   Input: synaptics-rmi4 - introduce rmi_f34v7_check_command_status()
>     helper
>   Input: synaptics-rmi4 - fix command completion check for bootloader
>     v7/v8
>   Input: synaptics-rmi4 - rewrite partition table unconditionally
>   Input: synaptics-rmi4 - reset after writing partition table
>   Input: synaptics-rmi4 - make rmi_f34v7_erase_all() use the "erase all"
>     command
>   Input: synaptics-rmi4 - remove unneeded struct register_offset
>   Input: synaptics-rmi4 - simplify rmi_f34v7_start_reflash()
>   Input: synaptics-rmi4 - drop useless gotos in rmi_f34v7_do_reflash()
> 
>  drivers/input/rmi4/rmi_f34.c   |  16 +-
>  drivers/input/rmi4/rmi_f34.h   |  17 --
>  drivers/input/rmi4/rmi_f34v7.c | 349 +++++++--------------------------
>  3 files changed, 81 insertions(+), 301 deletions(-)
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

