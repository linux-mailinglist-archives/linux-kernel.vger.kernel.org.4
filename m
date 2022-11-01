Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916D614B65
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKANKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKANKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:10:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA2A1A83A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:10:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u6so13492983plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HodXEuYzqCTG15c9CAh+5cByd+S8fmEjuYPaH6ghzhM=;
        b=knk5c/ux/y+eglyyWWu4j84v8Ixq48CJt4i6w1OYiGXLO7ZbsDuN1LZ9K8gjNEXT5/
         hbIWLRqA0lkXtkUwHfcsuW6QYxCGdKl4w/kXLoRohhz0aTjbuaZBnVK7wqeCOUWdxd+9
         6tKG/0IlXKVbwFh5KlXOe+TNLH/3M75z2O8Pzk/QRl1hHGe3YIdoGxMdNr8cW7DzKs7n
         1zthSjGfeet4uE2cKkMEoucbJKxS23TnfcQu62MBMB0DcvbqhYkIIdcTHSKzZGxWMNok
         +kXWDnlzy7os746o9KBcVFg0NpEbqyOLCxLYpInlga+0m8H2YbadRiCDV1SWVAGjiwvs
         JI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HodXEuYzqCTG15c9CAh+5cByd+S8fmEjuYPaH6ghzhM=;
        b=aEXOtsVXT6esqeuL7zATGDc0JKONZaIpXA5hVM3ew0yCut25C2hpFXXZ45f/jPEMGV
         k+MDp3SetGExcUPyq+fVAyntLUFNpzy5iZ9PDYztxHh2fKzV8wgWVzpCuxqeSH7F+iyx
         iICA/3YR1RAm/ei01LQUl70oOdfHZx9cgMyXfQ2U9VrHduRfLAJ5UYoGDOvwRF3+R3QD
         Jxkpq16I8rnqXolYKWiufeGB1uENqCqEcgpsp0xA37vHxVUgg8yahAoMuDDbjokq6Lgb
         PBrZKN0KLYla18TgDXCR/ah/1EMHwGwTpF7g0b8OwiloCRo7GWkd0PmeBv2GV0lYzp2f
         ibFA==
X-Gm-Message-State: ACrzQf3C4IGmbkorXA0GaERmR2PuNd1Mx/xnt6UFEw8lbfIIUVk2M94/
        tkGLOjbVGTSdRombkA1/2jzbJg==
X-Google-Smtp-Source: AMsMyM7AsUERJZGxdlKUJXlDnooCAE7Bx7toADGqJAI1DxXNkDerEMNtwcPUtTk3YLcZ4bhI9ecSXg==
X-Received: by 2002:a17:903:183:b0:184:8c1a:7a95 with SMTP id z3-20020a170903018300b001848c1a7a95mr19464851plg.137.1667308208882;
        Tue, 01 Nov 2022 06:10:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f70700b0016c50179b1esm6335596plo.152.2022.11.01.06.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 06:10:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>, paolo.valente@linaro.org,
        tj@kernel.org, jack@suse.cz
Cc:     yukuai3@huawei.com, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
In-Reply-To: <20220916071942.214222-1-yukuai1@huaweicloud.com>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
Subject: Re: [patch v11 0/6] support concurrent sync io for bfq on a specail occasion
Message-Id: <166730820758.252147.11493585744578710855.b4-ty@kernel.dk>
Date:   Tue, 01 Nov 2022 07:10:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 15:19:36 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v11:
>  - keep the comments in bfq_weights_tree_remove() and move it to the
>  caller where bfqq can be freed.
>  - add two followed up cleanup patches.
> 
> [...]

Applied, thanks!

[1/6] block, bfq: support to track if bfqq has pending requests
      commit: 3d89bd12d352e20f4f7c8f11a0f1a712b95a5295
[2/6] block, bfq: record how many queues have pending requests
      commit: 60a6e10c537a7459dd53882186bd16fff257fb03
[3/6] block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
      commit: 71f8ca77cb8764d46f656b725999e8b8b1aec215
[4/6] block, bfq: do not idle if only one group is activated
      commit: eed3ecc991c90a4a0ce32ea2b35378dc351f012b
[5/6] block, bfq: cleanup bfq_weights_tree add/remove apis
      commit: afdba14612622ec75896e5646950b3562a9aadd3
[6/6] block, bfq: cleanup __bfq_weights_tree_remove()
      commit: eb5bca73655cb6aa3bb608253e1e47283240c933

Best regards,
-- 
Jens Axboe


