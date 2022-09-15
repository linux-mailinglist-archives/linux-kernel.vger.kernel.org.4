Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708C55B9FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIOQso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIOQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:48:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB65C72FD7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:48:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e5so18645608pfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zlA6ptTTn1LB8f3ds6R6bK3ndLgpFyQYa5/cgjmBz0k=;
        b=EkH8vzH6AY/x2FDEot3lJqk0qgC1I0+W6noGE8h+Y7T5NdA67sJRGO99osypN4wxjP
         si3T4JRl24o/N1JFcREcZ+zhM49Wim0sKm0xkSF0UULLVn87ChuPX89dvF+y0pdogAfr
         dKUfrjDX9+mkcQ0KQAMMNZU7EcTIPVzAUmPLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zlA6ptTTn1LB8f3ds6R6bK3ndLgpFyQYa5/cgjmBz0k=;
        b=dzKjZjLEHHk7hkH3uy/1X/626M77W/CTV/XHTZXbULDxUGabj9gpA0V7sHDvbZO1Za
         vJCu0N156JS3b+wdJeHMKTfRLp9foBke/koxcneKiIdz27I0VN9t1+EYArpiiZw8FvnE
         HDrOnChMRffLHfvJBxRwivoFEQiH7jL1oMrc3BdgpyjEwgZYTYtQlNerIjo6R+wf/t9P
         9eQk9rZQng1VNiVWZmMAXuDWVKdjjV3Qb7gxtw2qHvi0HOXQybKNl3kSF+S6jr4dsGne
         8sXT+JN41BaEr49hVOnknEP8ySRWVoKmoz5gpTTsxSQAxnWesFXnGSF6iyFlM/UgPB54
         y4yw==
X-Gm-Message-State: ACrzQf1OOF/wBP1dBW0kXLVLDuhzCVrIK4Rimkx0wkt4t30DOp4rV63m
        sGuBPk6SXIGzrYXGyTQe6jXx9g==
X-Google-Smtp-Source: AMsMyM4FdBRmEUaoFqZ1ZX6Vh6XtevMCEGOiKjv87UB8WmxxEo9+INCb9SpLcAAa5zOhruJLuTG+QQ==
X-Received: by 2002:aa7:8892:0:b0:540:edcb:4773 with SMTP id z18-20020aa78892000000b00540edcb4773mr674454pfe.19.1663260517947;
        Thu, 15 Sep 2022 09:48:37 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:3af2:34b2:a98a:a652])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b00177ee563b6dsm13174970pls.33.2022.09.15.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:48:37 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
X-Google-Original-From: Sarthak Kukreti <sarthakkukreti@google.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH RFC 0/8] Introduce provisioning primitives for thinly provisioned storage
Date:   Thu, 15 Sep 2022 09:48:18 -0700
Message-Id: <20220915164826.1396245-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sarthak Kukreti <sarthakkukreti@chromium.org>

Hi,

This patch series is an RFC of a mechanism to pass through provision requests on stacked thinly provisioned storage devices/filesystems.

The linux kernel provides several mechanisms to set up thinly provisioned block storage abstractions (eg. dm-thin, loop devices over sparse files), either directly as block devices or backing storage for filesystems. Currently, short of writing data to either the device or filesystem, there is no way for users to pre-allocate space for use in such storage setups. Consider the following use-cases:

1) Suspend-to-disk and resume from a dm-thin device: In order to ensure that the underlying thinpool metadata is not modified during the suspend mechanism, the dm-thin device needs to be fully provisioned.
2) If a filesystem uses a loop device over a sparse file, fallocate() on the filesystem will allocate blocks for files but the underlying sparse file will remain intact.
3) Another example is virtual machine using a sparse file/dm-thin as a storage device; by default, allocations within the VM boundaries will not affect the host.
4) Several storage standards support mechanisms for thin provisioning on real hardware devices. For example:
  a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin provisioning: "When the THINP bit in the NSFEAT field of the Identify Namespace data structure is set to ‘1’, the controller ... shall track the number of allocated blocks in the Namespace Utilization field"
  b. The SCSi Block Commands reference - 4 section references "Thin provisioned logical units",
  c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".

In all of the above situations, currently the only way for pre-allocating space is to issue writes (or use WRITE_ZEROES/WRITE_SAME). However, that does not scale well with larger pre-allocation sizes. 

This patchset introduces primitives to support block-level provisioning (note: the term 'provisioning' is used to prevent overloading the term 'allocations/pre-allocations') requests across filesystems and block devices. This allows fallocate() and file creation requests to reserve space across stacked layers of block devices and filesystems. Currently, the patchset covers a prototype on the device-mapper targets, loop device and ext4, but the same mechanism can be extended to other filesystems/block devices as well as extended for use with devices in 4 a-c.

Patch 1 introduces REQ_OP_PROVISION as a new request type. The provision request acts like the inverse of a discard request; instead of notifying lower layers that the block range will no longer be used, provision acts as a request to lower layers to provision disk space for the given block range. Real hardware storage devices will currently disable the provisioing capability but for the standards listed in 4a.-c., REQ_OP_PROVISION can be overloaded for use as the provisioing primitive for future devices.

Patch 2 implements REQ_OP_PROVISION handling for some of the device-mapper targets. This additionally adds support for pre-allocating space for thinly provisioned logical volumes via fallocate()

Patch 3 implements the handling for virtio-blk.

Patch 4 introduces an fallocate() mode (FALLOC_FL_PROVISION) that sends a provision request to the underlying block device (and beyond). This acts as the primary mechanism for file-level provisioing.

Patch 5 wires up the loop device handling of REQ_OP_PROVISION.

Patches 6-8 cover a prototype implementation for ext4, which includes wiring up the fallocate() implementation, introducing a filesystem level option (called 'provision') to control the default allocation behaviour and finally a file level override to retain current handling, even on filesystems mounted with 'provision'

Testing:
--------
- A backport of this patch series was tested on ChromiumOS using a 5.10 kernel.
- File on ext4 on a thin logical volume: fallocate(FALLOC_FL_PROVISION) : 4.6s, dd if=/dev/zero of=...: 6 mins.

TODOs:
------
1) The stacked block devices (dm-*, loop etc.) currently unconditionally pass through provision requests. Add support for provision, similar to how discard handling is set up (with options to disable, passdown or passthrough requests).
2) Blktests and Xfstests for validating provisioning.

