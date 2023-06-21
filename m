Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C2C739143
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjFUVHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFUVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:07:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9818E1713;
        Wed, 21 Jun 2023 14:07:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3070880b3a.3;
        Wed, 21 Jun 2023 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687381636; x=1689973636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxmHl6BRr4PCuqTmBRiO+tAEIgtNXslvgtPUDDYEk5g=;
        b=oaaQAD9cGxPEmmAEmp3xGt7xjEDHAjuq0ULgnSRpME/0jfp5uei/cX5bL8V/aTAfhH
         hGFWO3YeJ3zlpyqmhNTJ05nkVcTO1M/HDS0v2QoCyMuns2gymjr1mbs6jmFOyRyil0qq
         vcyzj1o2Ck1X3aVmQGLz4L9hkX9lfx6AQT24lQNjfNxQH9R4tS/AEunlf++n1awxctia
         qJ98y1ah/MBR2KqBgpSJJANu16QO+OsiafXzPlFT+YT6hqPWe/wpX4qzCQbp6I2b6Z0s
         6kPlRQHCX37mmmjg0xxMV8lxc1ZMwpW5fT9QS8opCIJ2BIJNlD/MCDUvxyl65Iqcm/gB
         mk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687381636; x=1689973636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxmHl6BRr4PCuqTmBRiO+tAEIgtNXslvgtPUDDYEk5g=;
        b=PRqbGXj+tPzeooTWfTT9v9jKXFF1IulAnwKM+YOJjSb28x3AFfborShfy1ewIUqDBB
         hbiqt6Fm50mNpoUzE8zuMCCAXDMfLe0nIlWbA8pSYzMv/QIXZvEdaiEjfjH1VdjxEDXb
         K78m7F/dwSkwzn/dYCCgbKfglRQuyS1Q1CWcIHohxPJlEWFKdS26aGtMLxWcP/7BOQ9H
         TfEyFFCTZNRruVnW0ktXTvygq8hTMqPiwzNvkmJ1GmZJY5oPG9vUQJTTgmlh2Kr2BKHA
         ZKLIYwA6IrZW/S1g2D2vlZZRiBXwf6oa7wYzsOQNjVA4O/FKQ8mu2jWtmMoRSP+SJFir
         la5w==
X-Gm-Message-State: AC+VfDx+ZGToYJptkKs5n1VSnsRYUIjBfPICexcZP4KPWvKV8xLo0Tbi
        5p22qfbPqqA+0HxWxVLHLBs=
X-Google-Smtp-Source: ACHHUZ7UDAN/DUH7d080Yzd19oIbDx6FPfqIcDrxG092wrfQR3eJP0wA81oUirDnxYC5Jt9r4xQd0w==
X-Received: by 2002:a05:6a20:3d88:b0:10e:96b5:45fa with SMTP id s8-20020a056a203d8800b0010e96b545famr13704285pzi.43.1687381635960;
        Wed, 21 Jun 2023 14:07:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g7-20020a635207000000b00528db73ed70sm3529775pgb.3.2023.06.21.14.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:07:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Jun 2023 14:07:13 -0700
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
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 14/24] init: clear root_wait on all invalid root= strings
Message-ID: <8c1992bc-110a-4dad-8643-766c14bf6fd4@roeck-us.net>
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523074535.249802-15-hch@lst.de>
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

On Tue, May 23, 2023 at 09:45:25AM +0200, Christoph Hellwig wrote:
> Instead of only clearing root_wait in devt_from_partuuid when the UUID
> format was invalid, do that in parse_root_device for all strings that
> failed to parse.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

In linux-next, almost all of my boot tests from usb drives as well
as a few others fail with "Disabling rootwait; root= is invalid."
in the log. Bisect points to this patch.

It can not easily be reverted, but the following change fixes the problem.

--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -413,10 +413,12 @@ static dev_t __init parse_root_device(char *root_device_name)
 
        error = early_lookup_bdev(root_device_name, &dev);
        if (error) {
+#if 0
                if (error == -EINVAL && root_wait) {
                        pr_err("Disabling rootwait; root= is invalid.\n");
                        root_wait = 0;
                }
+#endif
                return 0;
        }
        return dev;

Debugging shows that early_lookup_bdev() indeed returns -EINVAL.
Looking into it further, it turns out that devt_from_devname() returns
-EINVAL for root devices such as
	root=/dev/sda
if the device is not found, making it impossible to rootwait for such
a device (this might for example be a raw USB drive without partitions,
or any qemu drive with format=raw).

Guenter

---
# bad: [15e71592dbae49a674429c618a10401d7f992ac3] Add linux-next specific files for 20230621
# good: [45a3e24f65e90a047bef86f927ebdc4c710edaa1] Linux 6.4-rc7
git bisect start 'HEAD' 'v6.4-rc7'
# good: [e867e67cd55ae460c860ffd896c7fc96add2821c] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good e867e67cd55ae460c860ffd896c7fc96add2821c
# bad: [0ab4015a11182e2a19c3dd52db85418f370cef39] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
git bisect bad 0ab4015a11182e2a19c3dd52db85418f370cef39
# good: [901bdf5ea1a836400ee69aa32b04e9c209271ec7] Merge tag 'amd-drm-next-6.5-2023-06-09' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
git bisect good 901bdf5ea1a836400ee69aa32b04e9c209271ec7
# good: [07164956fbc26eff280f3a044a489460ae36413c] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
git bisect good 07164956fbc26eff280f3a044a489460ae36413c
# good: [3067e020d361ed346957eb5e253911f7a3e18f59] add snd_soc_{of_}get_dlc()
git bisect good 3067e020d361ed346957eb5e253911f7a3e18f59
# bad: [0dbbd269fb6a8799f312dfc9b1ae1244a144cfc6] Merge branch 'for-6.5/block' into for-next
git bisect bad 0dbbd269fb6a8799f312dfc9b1ae1244a144cfc6
# good: [6c500000af037f74b66dd01b565c8ee1b501cc1b] block: mark bio_add_folio as __must_check
git bisect good 6c500000af037f74b66dd01b565c8ee1b501cc1b
# bad: [1a0ddd56e545b743af510b5a1b8dbdfe7d35cd3b] pktcdvd: replace sscanf() by kstrtoul()
git bisect bad 1a0ddd56e545b743af510b5a1b8dbdfe7d35cd3b
# good: [e3102722ffe77094ba9e7e46380792b3dd8a7abd] init: rename mount_block_root to mount_root_generic
git bisect good e3102722ffe77094ba9e7e46380792b3dd8a7abd
# bad: [d4a28d7defe79006e59293a4b43d518ba8483fb0] dm: remove dm_get_dev_t
git bisect bad d4a28d7defe79006e59293a4b43d518ba8483fb0
# good: [c0c1a7dcb6f5db4500e6574294674213bc24940c] init: move the nfs/cifs/ram special cases out of name_to_dev_t
git bisect good c0c1a7dcb6f5db4500e6574294674213bc24940c
# bad: [702f3189e454b3c3c2f3c99dbf30acf41aab707c] block: move the code to do early boot lookup of block devices to block/
git bisect bad 702f3189e454b3c3c2f3c99dbf30acf41aab707c
# bad: [079caa35f7863cd9958b4555ae873ea4d352a502] init: clear root_wait on all invalid root= strings
git bisect bad 079caa35f7863cd9958b4555ae873ea4d352a502
# good: [cf056a43121559d3642419917d405c3237ded90a] init: improve the name_to_dev_t interface
git bisect good cf056a43121559d3642419917d405c3237ded90a
# first bad commit: [079caa35f7863cd9958b4555ae873ea4d352a502] init: clear root_wait on all invalid root= strings
