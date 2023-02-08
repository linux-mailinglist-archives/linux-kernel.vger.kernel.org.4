Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6494C68F985
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjBHVNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjBHVNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548602DE62
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675890749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=urtHEAv6TEXWhqK0ccVUEtbQBcR8E+gJVsq26PRR1Pg=;
        b=TvglznH9BEJHpeYBIspKSabpEViNpJ8nM9fVnRoyXyAUq2xoBolRO2z+CIeAshkQY1lM8T
        oRO9z8ihp8g2jJ0GSwU/8F3W/9WK2xHf7H37M7SF5FuSpPoS3Sz7mDQ82B3Fg0okHQEqpA
        7qlN7sv2jlYRc2Ta5HKZRNqp1LTZ5dI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-127-DcH1lR_6OmqV11IdXUiuwg-1; Wed, 08 Feb 2023 16:12:28 -0500
X-MC-Unique: DcH1lR_6OmqV11IdXUiuwg-1
Received: by mail-wm1-f72.google.com with SMTP id x10-20020a05600c21ca00b003dc5584b516so1738650wmj.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 13:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urtHEAv6TEXWhqK0ccVUEtbQBcR8E+gJVsq26PRR1Pg=;
        b=tIDG/0jrf4osD7Kk/cpz/MSr4tD2X60+tUJzgaa0i74evpTQ0MfWTAIgmzOdlNu+05
         dARYhAayjm3yzguzEvztxDO39ATSEDPGbnmC2JJHHfcSZbsSN+D3dvXbbpiJtIgXvrPi
         jGKPiJChxHlRCxwgRqU1brU57EdlXfp+cxO0p6sPTPnjUHkHY/+QBMdijcCL6YcMNZbJ
         6iYpZU7om6Tw8lyL3WcSxrkGVzeWElNAOnl6b0ruDWeLXELN4Hw0viGBmBCe9Bp3TtlT
         IBeWb0zuOwHLiVn+KShOX9+SOu/tybCZbdJVa5JmKN9jf71BxWrBpIu/TZ+TPFs4iVKP
         neKg==
X-Gm-Message-State: AO0yUKVKOWRKTxlZHAFzhJVg6n1Mmy2VlH6/izi4tV+Qyz25rKWHd8o3
        S08yHL8Mj6FB0s/Y8u4sXZeYyX3I32j8EoR95XtTjRu7LUdWZJ8AzCthXTt0EV8OjJnm4bTUpPh
        P3SELjai/OHNpIIUgWVBsd27E
X-Received: by 2002:a05:600c:4a9c:b0:3dd:1b6f:4f30 with SMTP id b28-20020a05600c4a9c00b003dd1b6f4f30mr10581876wmp.3.1675890747093;
        Wed, 08 Feb 2023 13:12:27 -0800 (PST)
X-Google-Smtp-Source: AK7set+SEIQDKhnpiK7g7LlHXVjc1t0Oty/78WEZWZfusDb3P9/NANYw2WZHQxzeHgsToIOSvWxArg==
X-Received: by 2002:a05:600c:4a9c:b0:3dd:1b6f:4f30 with SMTP id b28-20020a05600c4a9c00b003dd1b6f4f30mr10581862wmp.3.1675890746822;
        Wed, 08 Feb 2023 13:12:26 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id ip21-20020a05600ca69500b003dc59081603sm2742148wmb.48.2023.02.08.13.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:12:26 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:12:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     qemu-devel@nongnu.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH RFC 0/7] revert RNG seed mess
Message-ID: <20230208211212.41951-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All attempts to fix up passing RNG seed via setup_data entry failed.
Let's just rip out all of it.  We'll start over.


Warning: all I did was git revert the relevant patches and resolve the
(trivial) conflicts. Not even compiled - it's almost midnight here.

Jason this is the kind of approach I'd like to see, not yet another
pointer math rich patch I need to spend time reviewing. Just get us back
to where we started. We can redo "x86: use typedef for SetupData struct"
later if we want, it's benign.

Could you do something like this pls?
Or test and ack if this patchset happens to work by luck.

Michael S. Tsirkin (7):
  Revert "x86: don't let decompressed kernel image clobber setup_data"
  Revert "x86: do not re-randomize RNG seed on snapshot load"
  Revert "x86: re-initialize RNG seed when selecting kernel"
  Revert "x86: reinitialize RNG seed on system reboot"
  Revert "x86: use typedef for SetupData struct"
  Revert "x86: return modified setup_data only if read as memory, not as
    file"
  Revert "hw/i386: pass RNG seed via setup_data entry"

 include/hw/i386/microvm.h |   5 +-
 include/hw/i386/pc.h      |   3 -
 include/hw/i386/x86.h     |   3 +-
 include/hw/nvram/fw_cfg.h |  31 ----------
 hw/i386/microvm.c         |  17 ++----
 hw/i386/pc.c              |   4 +-
 hw/i386/pc_piix.c         |   2 -
 hw/i386/pc_q35.c          |   2 -
 hw/i386/x86.c             | 122 ++++++++++----------------------------
 hw/nvram/fw_cfg.c         |  21 ++-----
 10 files changed, 49 insertions(+), 161 deletions(-)

-- 
MST

