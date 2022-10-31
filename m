Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D7561381C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiJaNcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJaNcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:32:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7645A10045
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:32:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q71so10696788pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugTm/u2jy4pd2kxS+scWBZjg6LGxe8n/YNYVW38sYhU=;
        b=u6qinkMCHoNyE0cGeyXTBzgI7tog6amMwjX3vhlMB8WA7uxXy/B/s75yNvyRM0nR93
         LbFr8TNBCgWDlTJsD4FZAHDOp5NpSOfjdnMaRasj1HarfJjC51EpQEwSpsshcC8M3zxq
         AanvPftdJZXBB1cSE6HiDeGhEHicM2n2QCaiAIEbfRV9SjSvBL+ZljKnfga770C1Ha9m
         Qp4BZh1kKlyf//GQfvQoAKCzZYf52bXavCfDnjPjFeGKOKw1tcIexmYr2anAu5rj42uZ
         idGKGVmv1PVPyTuvAhdFpoVu4HQaPzyxQfKpciah4DKuKVvB9HQ/r2r9aVEIiymA3cAN
         4kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugTm/u2jy4pd2kxS+scWBZjg6LGxe8n/YNYVW38sYhU=;
        b=PR5hkDGhDuO5RIGk1eNmdbVuUficYT90ngx/lwHsGjZmpA9UoEnVsUDex3fpC05rkY
         VHEUGpSfzY2Tl78ien7WsCaetCC988hFhLQHXl36fUwQBoGcHIeuabHMTR4TDGmnq9EW
         zS9PdJf1Vcb0SHUoQoVvjzj+/oALKwGFpNldfz3fRdEYV82OqNdpe3Vug0SRYuACenDf
         74JcHCFN6ctGY1dfyG2KEOc6lrylmXkLxFb6eL5hNlu3Zbm+FdcFsSuY2/2bYnUp9pD8
         NQoxAiforTKCqLlnDaCqXriUI0MF4jNTflLUDq1k+JgtMg1Fh5lKTE0soWlXKUurboFB
         +FBg==
X-Gm-Message-State: ACrzQf2CipM+9paT5ct5tUpfu6m291cmNg7QxrR75U3vHSOiF9MpL25o
        zGPbE0xxOVNwUeZ5qATWpoa5Eg==
X-Google-Smtp-Source: AMsMyM4ZKXTMAaJgpxx0z9iUkgeAJZtz+ff0/1Qqg35SH7vj1POacxOO2f9EMcB85IbXbJJP0kdnYg==
X-Received: by 2002:a63:f457:0:b0:46f:7e1c:8538 with SMTP id p23-20020a63f457000000b0046f7e1c8538mr12566090pgk.554.1667223132881;
        Mon, 31 Oct 2022 06:32:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t189-20020a6281c6000000b005668b26ade0sm4565791pfd.136.2022.10.31.06.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:32:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-block@vger.kernel.org
Cc:     mcgrof@kernel.org, hare@suse.de
In-Reply-To: <20221029071355.35462-1-chenzhongjin@huawei.com>
References: <20221029071355.35462-1-chenzhongjin@huawei.com>
Subject: Re: [PATCH] block: Fix possible memory leak for rq_wb on add_disk failure
Message-Id: <166722313202.68022.4514926407660406546.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 07:32:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2022 15:13:55 +0800, Chen Zhongjin wrote:
> kmemleak reported memory leaks in device_add_disk():
> 
> kmemleak: 3 new suspected memory leaks
> 
> unreferenced object 0xffff88800f420800 (size 512):
>   comm "modprobe", pid 4275, jiffies 4295639067 (age 223.512s)
>   hex dump (first 32 bytes):
>     04 00 00 00 08 00 00 00 01 00 00 00 00 00 00 00  ................
>     00 e1 f5 05 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000d3662699>] kmalloc_trace+0x26/0x60
>     [<00000000edc7aadc>] wbt_init+0x50/0x6f0
>     [<0000000069601d16>] wbt_enable_default+0x157/0x1c0
>     [<0000000028fc393f>] blk_register_queue+0x2a4/0x420
>     [<000000007345a042>] device_add_disk+0x6fd/0xe40
>     [<0000000060e6aab0>] nbd_dev_add+0x828/0xbf0 [nbd]
>     ...
> 
> [...]

Applied, thanks!

[1/1] block: Fix possible memory leak for rq_wb on add_disk failure
      (no commit info)

Best regards,
-- 
Jens Axboe


