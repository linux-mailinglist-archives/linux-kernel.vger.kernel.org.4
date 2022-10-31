Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EBE612FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJaFlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJaFlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:41:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F283767B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h2so9823504pgp.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qYzHeSSWpBV9igzsiV6R7/nw1z0St+lje5YCFrJ9iR8=;
        b=Oz+OOjNr80VG+44uo2/7Z8ABc9d+XbNkC32w/HOs2qRoQep/xN6GVFC7laUxKIaGIZ
         jvLHCD3VnqTHGasgauVDVFlA/b4QooZvDWvvxT96NaEYZDWEmRkro0vBo28be7quUMOf
         XI+jLl46Kd3uEmNNgyfERpK/yxg7hf5I8//DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYzHeSSWpBV9igzsiV6R7/nw1z0St+lje5YCFrJ9iR8=;
        b=prU+Dr2TbQIorlHFlaF6+1b+PHro4ES7YqS/Z+J+Sx+tqewcY1gu/DiTXtCS1QlPPi
         xTmVyBddfIsvJwsL4sxUklvM6Md3Lc8KjO+17BB7SdMbH6Bd/FE6XdvgGiBNGk+zGZTm
         diq8hVOWGdoUYYhnTw4J1ph6LyHfXxYBwLWgz/KDjt3W5+P+3t/BJWShX6bH3K5Kbp6D
         k8mhnRAolEgPVhgkLXx+5sqJv0aJ75lq6goGPpw+N9uVJTMw0fZqpYpC3JiQzSd3KtdI
         Na6xGHwPxsRFgPS+dFCFuqhoX0mq8qcxiFtN+J5rzg7ZmKHXekiCnYv7CFONkjtU/VRv
         5wgQ==
X-Gm-Message-State: ACrzQf0KyvLhVlPabc/iwKvm8YcK6e7gIc2ImBibWQGNlF7eB5Zl1y5C
        2OlSH3Th+KVU+2q4dKLVT4xoeQ==
X-Google-Smtp-Source: AMsMyM6H6wbT7GWuWfAO4ELtIj4GeOWzzfNWRL1yQxKQ5h8hV4XDZcz8i+Ys2B7yFIRDStZTEqZ1Dw==
X-Received: by 2002:a62:3281:0:b0:56d:385:149b with SMTP id y123-20020a623281000000b0056d0385149bmr12610665pfy.29.1667194876904;
        Sun, 30 Oct 2022 22:41:16 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b0056befcd7958sm3573308pfj.84.2022.10.30.22.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:41:16 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Date:   Mon, 31 Oct 2022 14:40:59 +0900
Message-Id: <20221031054108.541190-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	Some use-cases and/or data patterns may benefit from
larger zspages. Currently the limit on the number of physical
pages that are linked into a zspage is hardcoded to 4. Higher
limit changes key characteristics of a number of the size
classes, improving compactness of the pool and redusing the
amount of memory zsmalloc pool uses. More on this in 0002
commit message.

v4:
-- Fixed type of the max_pages_per_zspage (kbuild reported a
   "warning: right shift count >= width of type" warning)
-- Renamed max_pages_per_zspage variable

v3:
-- Removed lots of text from 0002 commit message. Now it's shorter
   and simpler.

v2:
-- Cherry picked a patch from Alexey (minor code tweaks to move
   it ahead of this series)
-- zsmalloc does not require anymore pages-per-zspage limit to be a
   pow of 2 value, and overall doesn't use "order" any longer
-- zram does not require "zspage order" (pow of 2) value anymore
   and instead accepts an integer in [1,16] range
-- There is no global huge_class_size in zsmalloc anymore.
   huge_class_size is per-pool, since it depends on pager-per-zspage,
   which can be different for different pools.
-- There is no global huge_class_size in zram anymore. It should
   be per-pool (per-device).
-- Updated documentation
-- Fixed documentation htmldocs warning (Stephen)
-- Dropped get_pages_per_zspage() patch
-- Renamed zram sysfs knob (device attribute)
-- Re-worked "synthetic test" section in the first commit: more numbers,
   objects distribution analysis, etc.

Alexey Romanov (1):
  zram: add size class equals check into recompression

Sergey Senozhatsky (8):
  zsmalloc: turn zspage order into runtime variable
  zsmalloc: move away from page order defines
  zsmalloc: make huge class watermark zs_pool member
  zram: huge size watermark cannot be global
  zsmalloc: pass limit on pages per-zspage to zs_create_pool()
  zram: add pages_per_pool_page device attribute
  Documentation: document zram pages_per_pool_page attribute
  zsmalloc: break out of loop when found perfect zspage order

 Documentation/admin-guide/blockdev/zram.rst |  38 +++++--
 drivers/block/zram/zram_drv.c               |  63 +++++++++--
 drivers/block/zram/zram_drv.h               |   7 ++
 include/linux/zsmalloc.h                    |  14 ++-
 mm/zsmalloc.c                               | 112 +++++++++++++-------
 5 files changed, 176 insertions(+), 58 deletions(-)

-- 
2.38.1.273.g43a17bfeac-goog

