Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57089621A47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiKHRS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiKHRSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:18:24 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A1358020;
        Tue,  8 Nov 2022 09:18:17 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y186so13487904yby.10;
        Tue, 08 Nov 2022 09:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nN5NpQCUpCrNFjmHjL5ONWMsPKFEDUAp7grcotZhonw=;
        b=J4yoSQKrdz2XPEPQBXUpt95WeNr6DcCo8dk6C0heLTAmfSlIMQgbywc+w5e+WRSFRT
         8kDEiSSmCQ0iga9tszf3YAHC7HTpyBHlNO+LSKucBKQ9BQICJy9VN9y6z1slZRqWGV+M
         7L6uQGF0dlg8mJLrV4Jb4xr/9BiqANIYSOQ29ZeFSLsYs7MgUAMguwNv6dgcM4EseOpf
         13V4223l73iNPHedPeVPmtGYccIcf2Cc9ulM+ch6FHR/0CTmg+l8ycIK3pz1ZTvaK/KP
         Ww/oVEIKpX/Brp3S+I51F1UgnLAzCWX6vGVumOl4yF/iAMORj+aT1qeL98tmJTD4STHZ
         KAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nN5NpQCUpCrNFjmHjL5ONWMsPKFEDUAp7grcotZhonw=;
        b=wHQgcmLzV+qDZfQY8RBiT618bvUbyq5N3MmoRkg6AhydJ67xu4byUK4ZorN/aY6YVJ
         ngNJ9rYX1V3bHnuEBN8JiC73u1qNs+W21vdeB14Y8vGTkh5U/1giA9djmr3eT82S/sXh
         JkwF0dPas99jn18kNe/7/hDJGWBhbMh+/zYSHjpBmwN5ZRldmsGuLYu6YLzK8sPI7Tim
         APgXvUIQOcs1N05hpKA28QOdNRFOGh5Lg8zsbCc4w2gfWRzc/Vnvv4I/iGvn69C5oj5v
         U9LkSJrWe4XqRSJP2Qg0cDRejnIdz2YnTEHKvX7JieswkJjUTPvOC4p60AGw6nFQlEQs
         Lyng==
X-Gm-Message-State: ACrzQf1xuzksVRzw3vFLUk1FOE73ouZ9FXNY9OMqBGd6FZ7tEDxV+DI6
        YugBaKLAeGxI4xuPui7jBZNZ6uHmPRZ8eLgYliOyDvt0eExC8dTwGyc=
X-Google-Smtp-Source: AMsMyM5FZ4kTRtsawAU+tP4boYiUWOGe6vBLGALChoywQx/ctlIO0pYyAxOglAglSTAoLoVYoZOY5KOAD6gd9tLQYc0=
X-Received: by 2002:a25:b215:0:b0:6cb:f84f:b1c5 with SMTP id
 i21-20020a25b215000000b006cbf84fb1c5mr57293918ybj.579.1667927896213; Tue, 08
 Nov 2022 09:18:16 -0800 (PST)
MIME-Version: 1.0
From:   Dennis Dai <dzy.0424thu@gmail.com>
Date:   Wed, 9 Nov 2022 01:18:05 +0800
Message-ID: <CACMswuMd18=nhvLK2Tw3H84GnDPnhuS_YRNFEDZ5T4B5DJQtBQ@mail.gmail.com>
Subject: nvme driver: possible missing `unregister_irq`
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
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

Hi all,

I was inspecting the rust nvme driver [1] and would like know if the following
code contains a missing unregister or I missed anything

// nvme.rs:180, in NvmeDevice::setup_io_queues
        admin_queue.register_irq(pci_dev)?;
// nvme.rs:186, in NvmeDevice::setup_io_queues
        let q_depth = core::cmp::min(...).try_into()?;
// nvme.rs:190, in NvmeDevice::setup_io_queues
        let tagset = mq::TagSet::try_new(...)?; //TODO: 1 or 3 on
demand, depending on polling enabled

Line 186 and 190 could abort the execution of
NvmeDevice::setup_io_queues without calling `unregister_irq`.
In the end this could result in an `request_threaded_irq` without a
pairing `free_irq` on failure.
Or is the job done by Rust by auto dropping?

Thank you very much!

[1] https://github.com/metaspace/rust-linux/commit/d88c3744d6cbdf11767e08bad56cbfb67c4c96d0
