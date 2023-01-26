Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166E867D333
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjAZRbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjAZRbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:31:32 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B260C8D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:31:26 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e204so862309iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9BJJQzoDsnrUeYgDKx6LZgv0cypBSRKCQgn69cO5NY=;
        b=G2rPmK5wUbasPBB9wP26jHgdhIzDTXImqwlPuLi/CKZj4DtdTEcl5ekusISuKLF0bm
         CUG+8VQfyZpRAS0shgOK00Zq096xreZcdXRz9S2FNduzrL+gpA/BQHiXNi4V5sPtkeWh
         L8PJDe2KZFuPxIRwzPFys0/cRYOlyhrG9w4gMHQsolWjmXzFaoRoEBhkbamk4PE6vbF9
         USXYCFowo3wJg1sdq8/s96EEKtgzVx9oGF4PjjkdDQDV0g0Hj/W7Z+OoGjy8w+s6RngN
         NGPUwhAV1KJjSsYg70jMM2Bekmc4I4PCWRVL3vHEzja7CwgyTkoDGO3HEL7lHDlNdXAQ
         6pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9BJJQzoDsnrUeYgDKx6LZgv0cypBSRKCQgn69cO5NY=;
        b=CJnmlUn2OQTDYXL9sGlPtE/IDZSRywEoEI+DaiE0cuHUwHQB27Zi40aKRU7H7sIU+G
         taf/KwTrxm9NGnOIjDI98xfCswaMzs6scK531j3CPrPPAMCb+DYdBIKANvoYMIArLOg1
         1VoYMicjJgriZYPJmCziJgcJwIxBriXoI0J6SJ+7EMWA+6vQt4F3uWMIq65yZRUdjz6s
         cvIwIGHPIilAql4kAdbCaFOtQJRguqxW0zl2dtOItu8L5DPpf3g1KJHpgF7P4Dvig3pg
         UK/K/RFURKv3Pqoup+I5CG7rkacK5ovEDar34+SxIiENz79rw4GYOACLqeZ9EW6r90HP
         T68g==
X-Gm-Message-State: AFqh2krz/P2ErKCTzDiEHfW/xepe8Rna5aBHQWXv47cH0tqn8ldO+zlw
        0wtrH1yyukQYgoqITXFbSAr6FECPpmxSOn09
X-Google-Smtp-Source: AMrXdXt9WYOZCub+SRV6z4+V2VsdgVaUgzsgEWT5NgUCzBffkM/vKdVrPBTbP+KBlurR1oo8mG94xw==
X-Received: by 2002:a5d:9e4d:0:b0:707:6808:45c0 with SMTP id i13-20020a5d9e4d000000b00707680845c0mr4429830ioi.1.1674754285967;
        Thu, 26 Jan 2023 09:31:25 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n24-20020a02a198000000b0038a434685dbsm641377jah.102.2023.01.26.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:31:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230125065839.191256-1-hch@lst.de>
References: <20230125065839.191256-1-hch@lst.de>
Subject: Re: build direct-io.c conditionally
Message-Id: <167475428508.707060.7530877439951509379.b4-ty@kernel.dk>
Date:   Thu, 26 Jan 2023 10:31:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jan 2023 07:58:37 +0100, Christoph Hellwig wrote:
> this series makes the build of direct-io.c conditional as only
> about a dozen file systems actually use it.
> 
> Diffstat:
>  Kconfig          |    4 ++++
>  Makefile         |    3 ++-
>  affs/Kconfig     |    1 +
>  direct-io.c      |   24 ------------------------
>  exfat/Kconfig    |    1 +
>  ext2/Kconfig     |    1 +
>  fat/Kconfig      |    1 +
>  hfs/Kconfig      |    1 +
>  hfsplus/Kconfig  |    1 +
>  internal.h       |    4 +---
>  jfs/Kconfig      |    1 +
>  nilfs2/Kconfig   |    1 +
>  ntfs3/Kconfig    |    1 +
>  ocfs2/Kconfig    |    1 +
>  reiserfs/Kconfig |    1 +
>  super.c          |   24 ++++++++++++++++++++++++
>  udf/Kconfig      |    1 +
>  17 files changed, 43 insertions(+), 28 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] fs: move sb_init_dio_done_wq out of direct-io.c
      commit: 439bc39b3cf0014b1b75075812f7ef0f8baa9674
[2/2] fs: build the legacy direct I/O code conditionally
      commit: 9636e650e16f6b01f0044f7662074958c23e4707

Best regards,
-- 
Jens Axboe



