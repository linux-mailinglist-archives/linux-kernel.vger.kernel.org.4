Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2260B45C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiJXRjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiJXRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:39:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB06CF60
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:14:53 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f9so4658856pgj.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt6vGfaF+WpKB2crlph/A5DawhX6V7zOYBBnigw00K8=;
        b=gxgpngwcw2J9m/Txxh6Na8bPvzW7DpRvyLskV2o/EH1wrJNYuvEMYkLBLmTe/LrASH
         d5SdSjRqQxkxBFw6XtHwntsTV6ca36egfkxCcM1vSnj+Y2sei90tvUKDg4SUllnl6rrG
         CrdBrnL+bQs6ofFUy8OGAj9g+J+oh4ihqqviA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dt6vGfaF+WpKB2crlph/A5DawhX6V7zOYBBnigw00K8=;
        b=nF/zY2DT3rcfam5yRjv7DLPz4VzDA6mzb82fiAHJLeg0wdG5xD4f2W/mSqyrXicScE
         psVYGO0DTcAfvdOmMcKLsZSbaAjjOC3ZK0aUGgPquEl1nV8iHU8MXuvW6qYLmCnVddex
         XXSrhMQdyPInZhQCWA5JdpQFW99PtZHqtoNI2yyF6AMMSg/XG4pjexMX6CsPNhZIPZkW
         l6GDElY62aasuinsOf7LV5Lqx/D1lK4Vxh1W+POVsBIkidkupBuY8KvxZvqTxuSNr9V4
         N10uGTuCmC8WP4zjnTvl6QqhUdBOwR0JpWSyo4tyn8+eWlh74wapdv+tG3IVFXF3cRzv
         bi2g==
X-Gm-Message-State: ACrzQf2RtN5TTKmZZ1IKP7S9xfZKfu5jbC41jwmMz0py35FUuMDPtLK2
        yuHzvIuqho554xQDG9S91Luo445jRxnQBw==
X-Google-Smtp-Source: AMsMyM7wdlTIAwvAIWczUmdLq1L6gOiBklArWhdVKCfK9pv9FH95uWIICSC3F8VwFcAIA4lNNeesOQ==
X-Received: by 2002:a63:e40e:0:b0:46e:acf4:628c with SMTP id a14-20020a63e40e000000b0046eacf4628cmr18342548pgi.159.1666627945079;
        Mon, 24 Oct 2022 09:12:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5f9c:c5bc:902f:3da4])
        by smtp.gmail.com with ESMTPSA id u70-20020a627949000000b0056b8726d2d3sm5162pfc.157.2022.10.24.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:12:24 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/6] zsmalloc/zram: configurable zspage size
Date:   Tue, 25 Oct 2022 01:12:07 +0900
Message-Id: <20221024161213.3221725-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
clases, improving compactness of the pool and redusing the
amount of memory zsmalloc pool uses.

For instance, the huge size class watermark is currently set
to 3264 bytes. With order 3 zspages we have more normal classe
and huge size watermark becomes 3632. With order 4 zspages
huge size watermark becomes 3840.

Commit #1 has more numbers and some analysis.

Sergey Senozhatsky (6):
  zsmalloc: turn zspage order into runtime variable
  zsmalloc/zram: pass zspage order to zs_create_pool()
  zram: add pool_page_order device attribute
  Documentation: document zram pool_page_order attribute
  zsmalloc: break out of loop when found perfect zspage order
  zsmalloc: make sure we select best zspage size

 Documentation/admin-guide/blockdev/zram.rst | 31 +++++--
 drivers/block/zram/zram_drv.c               | 44 ++++++++-
 drivers/block/zram/zram_drv.h               |  2 +
 include/linux/zsmalloc.h                    | 15 +++-
 mm/zsmalloc.c                               | 98 +++++++++++++--------
 5 files changed, 145 insertions(+), 45 deletions(-)

-- 
2.38.0.135.g90850a2211-goog

