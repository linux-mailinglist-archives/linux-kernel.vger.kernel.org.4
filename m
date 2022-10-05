Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA55F4FCD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJEGbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJEGbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:31:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240847437A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 23:31:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bu30so4526118wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 23:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNh/E9aqZ9j1ZwtVMrozJo0+hjPOaqMfX5Hz5rXYYPg=;
        b=pcCsAWjQaX8lNFDUCS0ZWpZagAJtm3hgmjX7Hcwhwswwx4uLHdrojc+vUJ8PJrILoL
         Cz9Arp70EDEnRCBvKwF1pu6g0iztnM7VD2gfhVIUSyj1raSb6ewgnwd3oOpzdFM7SHSv
         C+X51zJ5jfdT2n/G6yQQnz102cVtIDFelJTK5t4WZylXHBfkslFImZMc7aDKC/VatwN+
         HyOTgiaJ3+pche4q7wSa7zALP3GWlKWbOPg//GpKTTSpylUhxEb0htoa39M3t9sRhLuL
         0TZNKUQtv2OBup7MEj6fs1m3sFV1SdXXR22CtT5ILR0A0IeCfloTr240fOyDG+auW/V9
         aPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNh/E9aqZ9j1ZwtVMrozJo0+hjPOaqMfX5Hz5rXYYPg=;
        b=vPDE1jXWEqN/v/qhNc9FAghLDLq42+bvEKSsbIji4K/lIFeHB6WaWozU/nn5sJ21a/
         9yV1kkipMfnOYfNAuvu5QxsgqhCPIYjSVe2OkUQgTZj74XNdgKcoGeZxgFIBg5JYu3zs
         Agrp5r7ddzelhualoojS9NBczlZtCDFGtsIS1kMRJDhV3KDOe97EWHHN/7i3bi2FvLJt
         N7GCHuUnO9XzS3CGIUeAJ8NsnuJ9dooqBtD2jqjfb8pMx3gDjRbIDSKm8dk4HI0S2b0S
         3WCiLdYyWzIY/Wzve3ezr8z0wjZTFpenMCSIk6g8HttXkiEsPy34EMQZ0Say2ukM+AJK
         sv7g==
X-Gm-Message-State: ACrzQf35ExK2WnShiWRhLaYu4EZ3ao5HPF9yukpMILyXMIqZ5d8EbxAZ
        4ljZAGxPJhsTmVo3dRMk6/A=
X-Google-Smtp-Source: AMsMyM6rVmggdWkxJgo0ghZNDXjeqwt4qI9o8llYD6s8ItLCZpyAn1dxYWMcfs/xDQYa/jjjZCHAqA==
X-Received: by 2002:a05:6000:184e:b0:22e:4612:496d with SMTP id c14-20020a056000184e00b0022e4612496dmr6879712wri.91.1664951458465;
        Tue, 04 Oct 2022 23:30:58 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c40c400b003b497138093sm932414wmh.47.2022.10.04.23.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 23:30:58 -0700 (PDT)
Date:   Wed, 5 Oct 2022 07:30:56 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure due to 81c0386c1376 ("regmap: mmio: Support
 accelerared noinc operations")
Message-ID: <Yz0koHybNXGTFfDr@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build alpha allmodconfig
with the error:

drivers/base/regmap/regmap-mmio.c: In function 'regmap_mmio_noinc_write':
drivers/base/regmap/regmap-mmio.c:222:17: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
  222 |                 writesb(ctx->regs + reg, (const u8 *)val, val_count);
      |                 ^~~~~~~
      |                 writeb
drivers/base/regmap/regmap-mmio.c:225:17: error: implicit declaration of function 'writesw'; did you mean 'writew'? [-Werror=implicit-function-declaration]
  225 |                 writesw(ctx->regs + reg, (const u16 *)val, val_count);
      |                 ^~~~~~~
      |                 writew
drivers/base/regmap/regmap-mmio.c:228:17: error: implicit declaration of function 'writesl'; did you mean 'writel'? [-Werror=implicit-function-declaration]
  228 |                 writesl(ctx->regs + reg, (const u32 *)val, val_count);
      |                 ^~~~~~~
      |                 writel
drivers/base/regmap/regmap-mmio.c:232:17: error: implicit declaration of function 'writesq'; did you mean 'writeq'? [-Werror=implicit-function-declaration]
  232 |                 writesq(ctx->regs + reg, (const u64 *)val, val_count);
      |                 ^~~~~~~
      |                 writeq
drivers/base/regmap/regmap-mmio.c: In function 'regmap_mmio_noinc_read':
drivers/base/regmap/regmap-mmio.c:358:17: error: implicit declaration of function 'readsb'; did you mean 'readb'? [-Werror=implicit-function-declaration]
  358 |                 readsb(ctx->regs + reg, (u8 *)val, val_count);
      |                 ^~~~~~
      |                 readb
drivers/base/regmap/regmap-mmio.c:361:17: error: implicit declaration of function 'readsw'; did you mean 'readw'? [-Werror=implicit-function-declaration]
  361 |                 readsw(ctx->regs + reg, (u16 *)val, val_count);
      |                 ^~~~~~
      |                 readw
drivers/base/regmap/regmap-mmio.c:364:17: error: implicit declaration of function 'readsl'; did you mean 'readl'? [-Werror=implicit-function-declaration]
  364 |                 readsl(ctx->regs + reg, (u32 *)val, val_count);
      |                 ^~~~~~
      |                 readl
drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readq'? [-Werror=implicit-function-declaration]
  368 |                 readsq(ctx->regs + reg, (u64 *)val, val_count);
      |                 ^~~~~~
      |                 readq


git bisect pointed to 81c0386c1376 ("regmap: mmio: Support accelerared noinc operations")

I will be happy to test any patch or provide any extra log if needed.

Note:
Already reported for next-20220818 at https://lore.kernel.org/lkml/Yv4hhoTTcRuk%2F2Kl@debian/

-- 
Regards
Sudip
