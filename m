Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1473352D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245325AbjFPPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjFPPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:53:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00572D43
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:53:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b517ee9157so5982905ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686930816; x=1689522816;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgfV+5KO3Uf8SSxMlMaKIkFpl9kYZ91ZmMdAQxENxOg=;
        b=2F21qpxJcutuLQ/jgylm2fCqjyxYzKNus6Hgvb80quo6TcA0cW1tAAdPcyMZcltBJ1
         CkQm9aE1mPmurnuSKPpRYYJhggiaG1JUAPFI/3hTMh9t+cwgFe0Q1FIUa92k00GOJ9U3
         RiJiFmtRy7IXrFwO+zxB0GkY/WByYoQrq9DuW25x0PN5/bFvCt5gRyfFjU3gHazUntiz
         lVR41p+RVM0aGPQ7KbnyO2U5I5wUfK7jD1CkhXP711TnT6x55DDwxmLKISp+ZeHGd+ZD
         wibaaUl0831HwnDVQ4HKlvaLFlFLqXotpJ/18Expx020GA3czb+1X8B4/U0eMZDm0eQb
         LT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686930816; x=1689522816;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgfV+5KO3Uf8SSxMlMaKIkFpl9kYZ91ZmMdAQxENxOg=;
        b=k4braumAW6YJjstEcC8/2C0ie/XZ22rHOXW5iJUYez2aLRxWto659P06bmqYoZtZCI
         Sb0HDr9Rgfaj5pWLVmdGUF2ZeAEAfOjv9j65H7OLTGATeVxyxLBZVhMVPSf19ypuD0/o
         Ox+jwSsYxqrOWq50DLM51IrGUtVmXPVgPUxZTTmdlO/8MaWnt5le32GYa7vwmcWeUnZ9
         6U7jpQg53DO7V/0pj1UrxOrZDrKqZSuVVZwHl9KDlMNpdMonXBWAlx0ksrEEzO6yPADZ
         KFR2tEDVG5b8XpUxKFIj4/b573h2/un8vjLv3Vf6zfsuSzU03Ki9F2AzCUebzBJ14p7m
         wx9g==
X-Gm-Message-State: AC+VfDwb+2BvLY6VsrYLtSYPcJVByFO0cwfMbu8ELCFA7cab/mOYj3eO
        Tvt6T8ANv/IGDL2/IuuGCjeMlxHIqorfIS0xrI4=
X-Google-Smtp-Source: ACHHUZ6T52dvH3HhRt6C2aR9b9HeLHn+DIBhCZBUZNFukDA68Vh+8yVVogVpqVo/HBpl4XbeW5JzOw==
X-Received: by 2002:a17:902:e84e:b0:1ae:2c87:f771 with SMTP id t14-20020a170902e84e00b001ae2c87f771mr2587533plg.20.1686930816367;
        Fri, 16 Jun 2023 08:53:36 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001ac8e0ea157sm15906783plg.144.2023.06.16.08.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:53:34 -0700 (PDT)
Date:   Fri, 16 Jun 2023 08:53:34 -0700 (PDT)
X-Google-Original-Date: Fri, 16 Jun 2023 08:53:12 PDT (-0700)
Subject: [GIT PULL] RISC-V Fix for 6.4-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-7c3e3b18-17a7-4bf5-a977-f287ef6d18b7@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 99a670b2069c725a7b50318aa681d9cae8f89325:

  riscv: fix kprobe __user string arg print fault issue (2023-06-08 10:23:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc7

for you to fetch changes up to b104dbedbe61d89a933479f8effce6409037ef73:

  Documentation: RISC-V: patch-acceptance: mention patchwork's role (2023-06-14 07:44:11 -0700)

----------------------------------------------------------------
RISC-V Fix for 6.4-rc7

* A documentation patch describing how we use patchwork.

----------------------------------------------------------------
I figure there's no reason to delay this until the merge window, it's not
technically a fix though.

----------------------------------------------------------------
Conor Dooley (1):
      Documentation: RISC-V: patch-acceptance: mention patchwork's role

 Documentation/riscv/patch-acceptance.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
