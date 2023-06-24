Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751AE73C505
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjFXAJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 20:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFXAJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:09:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21B62726;
        Fri, 23 Jun 2023 17:09:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-557790487feso675155a12.0;
        Fri, 23 Jun 2023 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687565342; x=1690157342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbJYrnA9pnU+meP6XQ4kPeEwf/5w1AM0kN7wumRTQPk=;
        b=PNtSvWLdn9xOWUkW+c/xisBSDCt4yIiRGsF9p+IVVWTxHksTX8GoGu+4bK9ObiNHdS
         6nkRKXaZeOpZfl0YXRsSGGC11zmCYcuj1wb9sqSktGdWDxoAnWmA441nYZnikI90iq/M
         uU+DCPS67i4GDBwiL1j/ZIRm4zeu/icq8P2m7jmPy+pOAZk/rj+8EA8/U7PkEQTUfyXX
         f1wm9xWCYKJO3sjjiMInuykINkywjC9BVLZEY5OWqgz0X10/+wDgafPmFpZ16YHQteS+
         TL8R4XaE3ALyzu9H7LB6bVnh43dxlBQy/BfQ7Z7SdmWSxssvI/YXa7EhP3URwBjI+H2R
         S5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687565342; x=1690157342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbJYrnA9pnU+meP6XQ4kPeEwf/5w1AM0kN7wumRTQPk=;
        b=Y5OyNUywK3lUs3LszKOLDdHEyehi697qGIKttszeagd3iKyFVnXjC3Zu8dD1otPJ7E
         ASqglnmg5KqlifrK8Dcx7ThjMA30Ny8YG33XA/DM/KBoRKRxew0PegtGBNWitfoNoETe
         OA9/978TmjZiaZTC/q31mfHt5X9UM05qO+ugdeDRolbTPOjlRS4hhwoJzjYNkg2ztQJs
         69L6R+9wIU4stOqkm0m1m/L4rc0UdsOMvULSi7wpsvagHficE2UGNaep4wrSjD9MjP2D
         ohSYFKfetAA9pzgsv5gCDySnzvLwjL2ES5+ZV8sHc+Gr5X4F3wghsfgMQcImbtw0Yx1d
         8JfA==
X-Gm-Message-State: AC+VfDzqLCkbBQJUG68cXSYlvw3DRnAHkkMbdIDCFA3ejtQOcl+EbbIZ
        W0MfyiXl7I+SEvapNssljKg=
X-Google-Smtp-Source: ACHHUZ5UWmNb3hGeP/QCkeICkX9qJKsrvt0uGbMg739NNzwe0eHF70/k0NEUj6d2y5jm6EUom87PcA==
X-Received: by 2002:a05:6a20:7f99:b0:10b:4539:fa0a with SMTP id d25-20020a056a207f9900b0010b4539fa0amr28469987pzj.1.1687565342232;
        Fri, 23 Jun 2023 17:09:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o5-20020a656145000000b0052858b41008sm165159pgv.87.2023.06.23.17.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 17:09:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 23 Jun 2023 17:08:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 08/24] init: pass root_device_name explicitly
Message-ID: <c1391658-d785-4b2f-ba7e-01e4668685d7@roeck-us.net>
References: <20230531125535.676098-1-hch@lst.de>
 <20230531125535.676098-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531125535.676098-9-hch@lst.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 31, 2023 at 02:55:19PM +0200, Christoph Hellwig wrote:
> Instead of declaring root_device_name as a global variable pass it as an
> argument to the functions using it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch results in the following build error when trying to build
xtensa:tinyconfig.

WARNING: modpost: vmlinux: section mismatch in reference: strcpy.isra.0+0x14 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
ERROR: modpost: Section mismatches detected.

Unfortunately, reverting it is not possible due to conflicts,
so I can not confirm the bisect results.

Bisect log attached.

Guenter

---
# bad: [8d2be868b42c08290509c60515865f4de24ea704] Add linux-next specific files for 20230623
# good: [45a3e24f65e90a047bef86f927ebdc4c710edaa1] Linux 6.4-rc7
git bisect start 'HEAD' 'v6.4-rc7'
# good: [a5838c78db6a3a02e8d221e588c948f792e7f256] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect good a5838c78db6a3a02e8d221e588c948f792e7f256
# bad: [cca41cc0b5485a0ec20707316c1a00082c01a2af] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
git bisect bad cca41cc0b5485a0ec20707316c1a00082c01a2af
# good: [901bdf5ea1a836400ee69aa32b04e9c209271ec7] Merge tag 'amd-drm-next-6.5-2023-06-09' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
git bisect good 901bdf5ea1a836400ee69aa32b04e9c209271ec7
# good: [b4666c320b8113d94b3f4624054562e7add57e4a] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
git bisect good b4666c320b8113d94b3f4624054562e7add57e4a
# good: [b2c28785b125acb28a681462510297410cbbabd7] ASoC: dt-bindings: microchip,sama7g5-pdmc: Simplify "microchip,mic-pos" constraints
git bisect good b2c28785b125acb28a681462510297410cbbabd7
# bad: [9d217fb0e778d69b2e3988efbc441976c0fb29b5] nvme: reorder fields in 'struct nvme_ctrl'
git bisect bad 9d217fb0e778d69b2e3988efbc441976c0fb29b5
# good: [20d099756b98fa6b5b838448b1ffbce46f4f3283] block: Replace all non-returning strlcpy with strscpy
git bisect good 20d099756b98fa6b5b838448b1ffbce46f4f3283
# bad: [93c8f6f38be67e30adf8d8eb5e7e9ccb89326119] pktcdvd: Drop redundant castings for sector_t
git bisect bad 93c8f6f38be67e30adf8d8eb5e7e9ccb89326119
# bad: [c8643c72bc42781fc169c6498a3902bec447099e] init: pass root_device_name explicitly
git bisect bad c8643c72bc42781fc169c6498a3902bec447099e
# good: [87efb39075be6a288cd7f23858f15bd01c83028a] fs: add a method to shut down the file system
git bisect good 87efb39075be6a288cd7f23858f15bd01c83028a
# good: [aa5f6ed8c21ec1aa5fd688118d8d5cd87c5ffc1d] driver core: return bool from driver_probe_done
git bisect good aa5f6ed8c21ec1aa5fd688118d8d5cd87c5ffc1d
# good: [cc89c63e2fe37d476357c82390dfb12edcd41cdd] PM: hibernate: move finding the resume device out of software_resume
git bisect good cc89c63e2fe37d476357c82390dfb12edcd41cdd
# good: [e3102722ffe77094ba9e7e46380792b3dd8a7abd] init: rename mount_block_root to mount_root_generic
git bisect good e3102722ffe77094ba9e7e46380792b3dd8a7abd
# good: [a6a41d39c2d91ff2543d31b6cc6070f3957e3aea] init: refactor mount_root
git bisect good a6a41d39c2d91ff2543d31b6cc6070f3957e3aea
# first bad commit: [c8643c72bc42781fc169c6498a3902bec447099e] init: pass root_device_name explicitly
