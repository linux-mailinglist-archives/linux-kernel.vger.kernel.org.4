Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF836D360F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDBIKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 04:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDBIKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 04:10:49 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6631EEB7E;
        Sun,  2 Apr 2023 01:10:48 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17ab3a48158so27690251fac.1;
        Sun, 02 Apr 2023 01:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680423047;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29YYJrYDhT+9UyWZEkCjUn9HsfHoLWU9D1aux/U2VU4=;
        b=EiJWf2njKcQRCkNQ5F//bLaBc8lXUUmAbuD4P12Y/K7dY4Zd0d0xg6K+3YKH5fbHoX
         Km132z6utv+LuISyu4S1wSSdRmHpCGbC/xAD4dDkVjT7Q4cicotdEKMCIIu69/6m6KxR
         P0fIRPjWrf79HMusrTFSK26xZ3/sGCLHWODAuyF+fOWJ3TUe8y/pBGcPFlREth/PAyP3
         0+IcXZHQo58p8MPbN5+WNr+R4u7A6K3uK+pXdrwTay7//dFJh4yJckxcpLbJnKSMM39N
         Wy8wn0LcBTUChm6+1SIQfq7KOAPvfCq9U2c7oQIo1e9Aljnaa6yScEdmiq45TYEhHstZ
         TtaA==
X-Gm-Message-State: AAQBX9eF2VvDn/PDOCkBIO736pZD5eILteeQg0/04j3K2jdoNWxczx5y
        L+28EOaCd8CPcwLAxh9ZSO1ZyATAQ1LQQw==
X-Google-Smtp-Source: AK7set8r7ng6IuhEEmlu/Az5TRQt4kqlgZAMmpYQQ78NCvZV0IQNnKCdZvrfJvmtYwNUvTNKJV/C9A==
X-Received: by 2002:a05:6871:70b:b0:177:97ba:2eb4 with SMTP id f11-20020a056871070b00b0017797ba2eb4mr21897432oap.17.1680423047613;
        Sun, 02 Apr 2023 01:10:47 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id us16-20020a056870df9000b00177b33ce85bsm2511396oab.30.2023.04.02.01.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 01:10:47 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-17683b570b8so27627025fac.13;
        Sun, 02 Apr 2023 01:10:47 -0700 (PDT)
X-Received: by 2002:a05:687c:19c:b0:17b:5f31:7ae3 with SMTP id
 yo28-20020a05687c019c00b0017b5f317ae3mr7868128oab.5.1680423046878; Sun, 02
 Apr 2023 01:10:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Sun, 2 Apr 2023 09:10:36 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com>
Message-ID: <CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com>
Subject: Kernel Panic - V6.2 - Reseved memory issue
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to fix a kernel panic I am seeing on my vim3 board (Amlogic A311D).
I don't have enough knowledge about this area, but my current guess is
the kernel is using a piece of memory belonging to ARM-trusted
firmware that I shouldn't.
Log:

[ 9.792966] SError Interrupt on CPU3, code 0x00000000bf000000 -- SError
[ 9.792980] CPU: 3 PID: 3471 Comm: kded5 Tainted: G C 6.2.0 #1
[ 9.792985] Hardware name: Khadas VIM3 (DT)
[ 9.792987] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 9.792991] pc : kmem_cache_free_bulk.part.98+0x1f0/0x528
[ 9.793004] lr : kmem_cache_free_bulk.part.98+0x2f8/0x528
[ 9.793008] sp : ffff80000a2eb7f0
[ 9.793009] x29: ffff80000a2eb7f0 x28: ffff00001f358518 x27: ffff000000008800
[ 9.793016] x26: ffff00000262b300 x25: ffff00000262b300 x24: 0000000000000001
[ 9.793019] x23: ffff00000262b000 x22: 0000000000000000 x21: ffff00001f358538
[ 9.793022] x20: fffffc0000098ac0 x19: 0000000000000004 x18: 0000000000000040
[ 9.793025] x17: 0000000000000018 x16: 00000000000007f8 x15: 0000000000000003
[ 9.793028] x14: 0000000000000006 x13: ffff800008e48550 x12: 0000ffff9dc91fff
[ 9.793031] x11: 0000000000000004 x10: 0000000000000001 x9 : ffff000007e93680
[ 9.793035] x8 : 0000000000000020 x7 : ffff000001d2b100 x6 : 0000000000000007
[ 9.793037] x5 : 0000000000000020 x4 : ffff000000008800 x3 : 0000000000000001
[ 9.793040] x2 : 0000000000000007 x1 : 0000000000000000 x0 : ffff00001f358540
[ 9.793045] Kernel panic - not syncing: Asynchronous SError Interrupt

This doesn't happen with downstream Khadas 6.2 kernel, and that's
because the downstream kernel removed this from
early_init_dt_reserve_memory (drivers/of/fdt.c):

/*
* If the memory is already reserved (by another region), we
* should not allow it to be marked nomap, but don't worry
* if the region isn't memory as it won't be mapped.
*/
if (memblock_overlaps_region(&memblock.memory, base, size) &&
    memblock_is_region_reserved(base, size))
          return -EBUSY;


And this causes 3 MiB of memory belonging to ARM Trusted firmware to
be reserved.

arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi :
/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
secmon_reserved: secmon@5000000 {
        reg = <0x0 0x05000000 0x0 0x300000>;
        no-map;
};

And the mainline kernel fails to reserve that memory:
[    0.000000] OF: fdt: Reserved memory: failed to reserve memory for
node 'secmon@5000000': base 0x0000000005000000, size 3 MiB

It fails to reserve because memblock_overlaps_region and
memblock_is_region_reserved return one.
I think memblock_is_region_reserved is saying the memory is already
reserved by uboot and shouldn't be nomap, but it should.

Is there a bug here?
Why the kernel is failing to reserve this memory?
Is this an u-boot issue?

I would appreciate any help. The current mainline kernel fails 90% of
the time to boot into the Vim3 board.

Best Regards
Lucas Tanure
