Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0576143D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 05:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKAEJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 00:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAEJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 00:09:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4F81581A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 21:09:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id j14so19235948ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 21:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cF8Xdl9bnZMP6PM/jkktbmXgdydLrtVZtbsNWEfml5U=;
        b=FcYPBsVGNwpLUaVZpBQpN2jDmWuSOvdtv3EXZzTUOoN03N+zmje8U7oXs61ElaPtPc
         dBR1CYPcPTURxarJfA7S56CUEQ/2MP4Tux6zXOszbp4ve9bgY8/mZdAdhP2eNrvpVl9C
         dGPMuLTkIMQfhsddoP3qJeaRx5X7OfqNoMo0EXrQyltiVmFmom7y/iCvztaUJLQsUXcl
         HaLw05/mY4FyYMDGibztfm9W+6OnvIipOLkiiUTO8b/d1eHs1I993fUuJmD/SC8wCXlP
         NSEIZfIfxYVhtLhBdaDB6IRvqZmT1fSkMiP0SbrsIdtydu5RqX+quAS202TEzQ2HcQdf
         fR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cF8Xdl9bnZMP6PM/jkktbmXgdydLrtVZtbsNWEfml5U=;
        b=rTyr0CxqV76wDPtXcgLScabR7j8E+fCnv/cWIXRl9pHLS18Lx7ojhln2gtsJmPnFXH
         ZWdZb6PpA3CwRjWHCAAwP39oT1us363j9Tz2hYSa1gyTm/KfT/5i+AMx54ACAW63DOsd
         Nm1aHMRa6jgbJwCQVOTKG//SnC3N2S435DP3mYvZLKsu8tkyZPjCJuhBzRnBiSggWch3
         vYm4tmVlXYESkgjYwaoWoO4cSBzvFPJj/tKnDGusRygLcX2gdVm7AhYSQmoCCTZK9dVu
         2t7xfq5rKllERJv/YFyiVbEtGPsyGNa6htbCfkT0dzWlGMDvn/c6R+WpQJWTtxPouHRi
         PR4Q==
X-Gm-Message-State: ACrzQf1GshxcSUWZUKPpoa7NEmMGJhS+lANy2UU/d2zKri05I3jMyIru
        8c8VyRqD1ZfRAOJwkJrRCF4iYddmBloyWNm300kaLY6Q
X-Google-Smtp-Source: AMsMyM6UH75Sposa99DLgTit3IWe9pM+Mo8+QmlB6OHJ9TnMMhQsA5EnFYZqHUFNE6jOlDug3KLBAccTWhk0vmihMmY=
X-Received: by 2002:a2e:7c02:0:b0:277:54ee:e8d9 with SMTP id
 x2-20020a2e7c02000000b0027754eee8d9mr3497137ljc.309.1667275769528; Mon, 31
 Oct 2022 21:09:29 -0700 (PDT)
MIME-Version: 1.0
From:   Sijie Lan <sijielan@gmail.com>
Date:   Tue, 1 Nov 2022 00:09:18 -0400
Message-ID: <CAGAHmYA=QPJZy-NCRFF_17y-3HLb4UxcXVRiw=6c-1N7Fa7kQQ@mail.gmail.com>
Subject: Mkfs.f2fs on null_blk device
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     chao@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to make f2fs on null_blk device, it always shows "Device
size is not sufficient for F2FS volume",
I am I gave enough space for the file system, i.e, 20GiB. I just want
to know hot to fix it.
this is the output message:
[sijie@fedora null_blk]$ sudo mkfs.f2fs -f -m  /dev/nullb1

    F2FS-tools: mkfs.f2fs Ver: 1.15.0 (2022-05-13)

Info: Disable heap-based policy
Info: Debug level = 0
Info: Trim is enabled
Info: Host-managed zoned block device:
      20 zones, 2147483648 zone size(bytes), 10 randomly writeable zones
      524288 blocks per zone
Info: Segments per section = 1024
Info: Sections per zone = 1
Info: sector size = 4096
Info: total sectors = 10485760 (40960 MB)
Info: zone aligned segment0 blkaddr: 524288
Error: Device size is not sufficient for F2FS volume
Error: Failed to prepare a super block!!!
Error: Could not format the device!!!
