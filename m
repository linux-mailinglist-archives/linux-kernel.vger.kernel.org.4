Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634768C314
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBFQWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBFQWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:22:43 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF5EC7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:22:42 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id m15so4867939ilh.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2C5DB0DT3DMLvYn9ipFWXLklAkx9iRL+ziwmHL1NmU=;
        b=l46PwS5w/HydIlvsf09Pe09XCzvVhobWtcTYS/5AQ9DMU3ca8ngjBILswut8tEJmf5
         f7xUAET+afbV7EJyEsiaxX7nSVXWSCI8RHkLsuKAuRzgicFnFp/grKk1JP57GzWAiDI/
         iJKq1uJKkfoTLrMSHe/K8WDL11ssu3moSvj4+kN69UHAXiIkcv038nd9hIhAkAbBaHp4
         9A3nw3vPP1rvsG2fLG8lKmF6W0qaiOCrtxClA70Tnh3Q5/BpgSzEhkWy2wGgjzXQZLRw
         kM0vx/SP4MzDx3VY0AME2QagV6DDCKAQvf7yNgS2QlxW1Aex0/d6CWvFeyKukRzD8kaX
         rJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2C5DB0DT3DMLvYn9ipFWXLklAkx9iRL+ziwmHL1NmU=;
        b=qHbM20c26NPP6H105TqqWRC0qI5S4ybaUyabBZV448RWfAbmz6lJjK3CYaKvTXvuAa
         ANJgj0OUKe95Iybh21OSyw8eFFFua05XGpI/sXuwzA99MZMsMcPtjtqt9i8XzyXhIRog
         v3qEGlagUFvKtOzbh/q6IpbEgLm/gvq60l2wO5JJ+gg9pwSv/iriC4jIBRywBlLHZsrM
         P47+I+hYbQTs4eHJsCluCjBhOOLS7yENNwSYxVqhTikKxmdxd9tPGhoOORG++7TsbCoa
         c7txK5KEozVOU+5ggWBTgyGFVXZDJlVcmloMYl4qt1G1XeuK2NDy3rD2o6DkZw1v6viE
         ijXA==
X-Gm-Message-State: AO0yUKWzPcM1VWiemo/iv/4QDr0su4nnqbYMnYMKzCUbSP8T9K7AOAjA
        l1EUQu+XE+OwfFee+149xNFk/A==
X-Google-Smtp-Source: AK7set8pWSRiHHFGPKVc5ARuURtlyO/9eZ+z4L8uNlTWyuliPeOlgpPof8idQJW68AjFLF42SbH4/A==
X-Received: by 2002:a92:ce06:0:b0:310:8c56:d7de with SMTP id b6-20020a92ce06000000b003108c56d7demr11216852ilo.0.1675700561561;
        Mon, 06 Feb 2023 08:22:41 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z27-20020a05663822bb00b003afe5e747d6sm3650419jas.126.2023.02.06.08.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:22:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, dwagner@suse.de, hare@suse.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     john.garry@huawei.com, jack@suse.cz
In-Reply-To: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH v4 01/14] blk-mq: avoid sleep in
 blk_mq_alloc_request_hctx
Message-Id: <167570056052.23119.7411390353642727169.b4-ty@kernel.dk>
Date:   Mon, 06 Feb 2023 09:22:40 -0700
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


On Wed, 18 Jan 2023 17:37:13 +0800, Kemeng Shi wrote:
> Commit 1f5bd336b9150 ("blk-mq: add blk_mq_alloc_request_hctx") add
> blk_mq_alloc_request_hctx to send commands to a specific queue. If
> BLK_MQ_REQ_NOWAIT is not set in tag allocation, we may change to different
> hctx after sleep and get tag from unexpected hctx. So BLK_MQ_REQ_NOWAIT
> must be set in flags for blk_mq_alloc_request_hctx.
> After commit 600c3b0cea784 ("blk-mq: open code __blk_mq_alloc_request in
> blk_mq_alloc_request_hctx"), blk_mq_alloc_request_hctx return -EINVAL
> if both BLK_MQ_REQ_NOWAIT and BLK_MQ_REQ_RESERVED are not set instead of
> if BLK_MQ_REQ_NOWAIT is not set. So if BLK_MQ_REQ_NOWAIT is not set and
> BLK_MQ_REQ_RESERVED is set, blk_mq_alloc_request_hctx could alloc tag
> from unexpected hctx. I guess what we need here is that return -EINVAL
> if either BLK_MQ_REQ_NOWAIT or BLK_MQ_REQ_RESERVED is not set.
> 
> [...]

Applied, thanks!

[01/14] blk-mq: avoid sleep in blk_mq_alloc_request_hctx
        commit: 6ee858a3d3270a68902d66bb47c151a83622535c
[02/14] blk-mq: remove stale comment for blk_mq_sched_mark_restart_hctx
        commit: c31e76bcc379182fe67a82c618493b7b8868c672
[03/14] blk-mq: wait on correct sbitmap_queue in blk_mq_mark_tag_wait
        commit: 98b99e9412d0cde8c7b442bf5efb09528a2ede8b
[04/14] blk-mq: Fix potential io hung for shared sbitmap per tagset
        commit: 47df9ce95cd568d3f84218c4f65e9fbd4dfeda55
[05/14] blk-mq: remove unnecessary list_empty check in blk_mq_try_issue_list_directly
        commit: 08e3599e7401a7eae5e68f5e2601cc4a4e53951b
[06/14] blk-mq: remove unncessary from_schedule parameter in blk_mq_plug_issue_direct
        commit: 3e368fb023ffab83404f628d02789550d79eca9c
[07/14] blk-mq: make blk_mq_commit_rqs a general function for all commits
        commit: 34c9f547402f11c0241a44800574ec4fa38cccb8
[08/14] blk-mq: remove unncessary error count and commit in blk_mq_plug_issue_direct
        commit: 0d617a83e8d4d3149d76cc074d9779a3b0ee7baf
[09/14] blk-mq: use blk_mq_commit_rqs helper in blk_mq_try_issue_list_directly
        commit: 984ce0a7d75b577fd84f2cc7a83e6e2d2503f90e
[10/14] blk-mq: simplify flush check in blk_mq_dispatch_rq_list
        commit: e4ef2e05e0020db0d61b2cf451ef38a2bba33910
[11/14] blk-mq: remove unnecessary error count and check in blk_mq_dispatch_rq_list
        commit: 4ea58fe456c21bb259a7cbf8498946f86e9b84aa
[12/14] blk-mq: remove set of bd->last when get driver tag for next request fails
        commit: f1ce99f7098d9e7a322caf48eb8af05be7999827
[13/14] blk-mq: use switch/case to improve readability in blk_mq_try_issue_list_directly
        commit: 27e8b2bb149aff7b7b673b46c7206f4f37c30093
[14/14] blk-mq: correct stale comment of .get_budget
        commit: 01542f651a9f58a9b176c3d3dc3eefbacee53b78

Best regards,
-- 
Jens Axboe



