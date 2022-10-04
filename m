Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268035F4BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJDWUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJDWUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:20:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EC06566D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:20:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y20so814175qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date;
        bh=9Z3D2HflEaFugzAkCP6KlgI20l6mZZ2smreeM2YBiSA=;
        b=V3O7S3JcmocG+fv0Dhj7AQBTe8Z/ncmDF8WRf+6ar22CKWi2ypqMpScoshr/VzsFE9
         akyKuPB2Or5T3jJR6e45FPtpUXkHhiRkNDwWqMgMwZSrtnBW1t+dt8CQITcDC8yr+ShS
         FvqZQ+grU6sgvjQIjvtO8aIgrtV5ezPLUJK2t8J0e1y6t8thvHqrkbExI+u2uOlXMVDx
         OuSgVE4fbHOoLMulfJ/XecZXDj7qrL5L3M9TYVaILXYLEayvjTvZaBTQoPEXZ6EaERD6
         wnW8JBjAmTglKyCCcryu77o2nkKzXbhOxAQXIsHuikMaZYbymuG4PuraBY0mONxY3cpQ
         CcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=9Z3D2HflEaFugzAkCP6KlgI20l6mZZ2smreeM2YBiSA=;
        b=EupLcBBaFdQj/RQKoGJSQUywhBsh9Pk14BIBh+B7OT4UYWu1R95jqgIVkE1+yu68Ew
         fAJqqN8XNcMs8CES+EZEkcchGyky4e+1/NiKvtQNbOBXd9373bu+FM9oSTdHOSYCRGnQ
         hqPXiR2JlW3gZcdSiVQuUSLC1a4WJdVwNDSx+rUz+AnWehxOdsKjuAd5I+xoiCZ0ssMr
         Idr9TFAHvWMmWwksF9C7ZPEDLMIjfVmRR12DE8KPi+9WlDh/z1S8DWrlvQCzV05SiEc7
         Z2NkG9xyOTmEQfZWsv3eDUrsS0rlAc/3iteAtmlldSnDZcoTBXzQwvYOKpjXnUpfNkho
         ZYYw==
X-Gm-Message-State: ACrzQf2Ls9zoLNx2eyw1Vvvo91pLhRcve6BTpOWZudeLSkgFQwg8DAFB
        G4uYudqnbkv+zfIDH1sGzStf3SGXtw==
X-Google-Smtp-Source: AMsMyM4sN2gFVYSbr6/AmGI4Qo5UKeup3GPXq0JdZ1YGwZRtxskuWGuu8yrdfI7+xQSLmDsFXASM8g==
X-Received: by 2002:a05:622a:11c9:b0:35c:3a5a:1ca3 with SMTP id n9-20020a05622a11c900b0035c3a5a1ca3mr21815882qtk.476.1664922044424;
        Tue, 04 Oct 2022 15:20:44 -0700 (PDT)
Received: from serve.minyard.net ([47.184.185.126])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a244600b006d94c499d8fsm606602qkn.50.2022.10.04.15.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:20:43 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from dell1.minyard.net (50-240-203-141-static.hfc.comcastbusiness.net [50.240.203.141])
        by serve.minyard.net (Postfix) with ESMTPSA id 6932218000C;
        Tue,  4 Oct 2022 22:20:42 +0000 (UTC)
Date:   Tue, 4 Oct 2022 17:20:40 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.1
Message-ID: <YzyxuBHS9MKcells@dell1.minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.1-1

for you to fetch changes up to 05763c996f72ef934432639fe412f5193816fd9d:

  ipmi: Remove unused struct watcher_entry (2022-09-28 06:48:54 -0500)

----------------------------------------------------------------
Fix a bunch of little problems in IPMI

This is mostly just doc, config, and little tweaks.  Nothing big, which
is why there was nothing for 6.0.  There is one crash fix, but it's not
something that I think anyone is using yet.

----------------------------------------------------------------
Chia-Wei Wang (1):
      ipmi: kcs: aspeed: Update port address comments

Corey Minyard (2):
      ipmi:ipmb: Fix a vague comment and a typo
      ipmi:ipmb: Don't call ipmi_unregister_smi() on a register failure

Jason Wang (1):
      ipmi: Fix comment typo

Tomer Maimon (3):
      dt-bindings: ipmi: Add npcm845 compatible
      char: ipmi: modify NPCM KCS configuration
      dt-binding: ipmi: add fallback to npcm845 compatible

Xiu Jianfeng (1):
      ipmi: Add __init/__exit annotations to module init/exit funcs

Yuan Can (1):
      ipmi: Remove unused struct watcher_entry

 .../devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt   |  5 ++--
 drivers/char/ipmi/Kconfig                          |  6 ++---
 drivers/char/ipmi/ipmi_ipmb.c                      | 16 +++++++-----
 drivers/char/ipmi/ipmi_msghandler.c                |  8 +-----
 drivers/char/ipmi/ipmi_ssif.c                      |  4 +--
 drivers/char/ipmi/kcs_bmc_aspeed.c                 | 29 ++++++++++++++--------
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c              |  4 +--
 drivers/char/ipmi/kcs_bmc_serio.c                  |  4 +--
 8 files changed, 41 insertions(+), 35 deletions(-)

