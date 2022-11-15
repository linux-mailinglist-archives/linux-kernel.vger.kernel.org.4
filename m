Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16806291E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiKOGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiKOGfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:35:53 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44B51C911
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:35:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so611000pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zpq6wrWfGX8bxB3+xVIKWb00BlqK5w3SjhxTJfK4DaY=;
        b=UPu6QlQZ6wZFD7QB+Tlnv1r49FrhJjMyTwRDwZZXe3oufdUXkFOBWNwK6FGEIwSDi0
         zxkWMCzpUO1FYlOyQv9LxoKfPfSHpeYV/HPtykLidbfOKIGk+2BucWMwZ+2W4mTqrkwp
         aLPv+OrSIhk2Qis64nWneaQAAhLzEkdG6AfXSz6YUfFEnBDPOY1ONfUBz0rBXZ3+1wtP
         UtXRMso45HgIEXQbFeiHbqJ582RmtmwdPtgylUSh0eyiC/oFNF2W/6nl7Qd4CWZMtY11
         7teXu09vJNeyO3BbXne6hCb0FTpQaS/JnjSYzl7JNKFK9dIAJfgK3yuv9PfY0wZa2WA/
         2FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zpq6wrWfGX8bxB3+xVIKWb00BlqK5w3SjhxTJfK4DaY=;
        b=mfiiIXclMlkvIFEPHBRMhn9XaTWBi2JT5XCJxp1E3AeYAEJSzFkIUu+ayLjq9FUrF0
         QBNAx7kIck10kuV1c2KZuJC7cu0KuJATW8UrCYk8VvKQrv8Z26r1T4em7y9u1P5e49lm
         3BRqax0mgvG7tiVJma7fgxHI4ea5Y9glS4m6fJMigm9u/7q56VYZTBAKTdKyb9EedhMJ
         BqsjVWkVvIQ3GrHFetkyGM3eFRjI+3rJHvgSt13d6TSwmmq0aOoJCxAVCuX5D0gE1ZMB
         sx/vQzbOaMtebfh0YgxMV69qD3WHCb3/NgjKuXIhJNK1XFwvkj5ujQEzpaTgXbnBEu24
         yxAQ==
X-Gm-Message-State: ANoB5pmjhzD9r2JSnwxR3y/pswmeE6tBWw+V5WYT9TyG/IWvPxJYKrQY
        5oTW9LeiLxePYFKTlG0utPw=
X-Google-Smtp-Source: AA0mqf5brcwE8/5+e3obUHYZ2iFik6+VPMFFSbA8IoLCjkzqYAbXd/XNaH0HhoD5jAIbh1v4haF/oA==
X-Received: by 2002:a17:902:e483:b0:188:b44b:598 with SMTP id i3-20020a170902e48300b00188b44b0598mr2750875ple.54.1668494152227;
        Mon, 14 Nov 2022 22:35:52 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001822121c45asm8767874pld.28.2022.11.14.22.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:35:51 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH v2 0/3] alloc_mode changed after remount on a small volume device
Date:   Tue, 15 Nov 2022 14:35:34 +0800
Message-Id: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a fix patch for alloc_mode changed after remount
on a small volume device, and do cleanup for 'f2fs_tuning_parameters'
function.

The last one changes type for sbi->readdir_ra.

V1 -> v2 :
- set alloc_mode default state in default_options()
- let variable readdir_ra holds the sbi->readdir_ra state in
  f2fs_fill_dentries()

Yuwei Guan (3):
  f2fs: fix to alloc_mode changed after remount on a small volume device
  f2fs: cleanup for 'f2fs_tuning_parameters' function
  f2fs: change type for 'sbi->readdir_ra'

 fs/f2fs/dir.c   |  2 +-
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/super.c | 17 +++++++++--------
 fs/f2fs/sysfs.c |  5 +++++
 4 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.34.1

