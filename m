Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C36615762
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKBCLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiKBCLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:11:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFCD1F608
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:11:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z26so2002325pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 19:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMwht8Kpuf4LTPdcGCutOruwBCb0mDtYIKt07DMBo4E=;
        b=3tM2CRKuvgSzDtO4YVhoaV1qCBEevMeRGgXGrmtKFAev/snlKP5Xk6nNeRdBCAP6B0
         VZZ1RkVha8lmm8QlrzbOLgbzk/oEJLb6KXV5DIspagBlE7prEN7VNxRg66/Xx9/6EEr5
         qDo+fMediXpg2y4tK0/cGWFw7vX7DgQismTRejAH5dC/j20lcsejEnhAg8YsM7fe84Db
         OwKwWnOMj2a95PzEx2MY6SckIx55uRbT++lNNE5UXKMXot23Yl3VzsMrASwHoZsXP7SY
         O4Ki5GqPakLrQqljsMvzRR5lUGVmtboW0JSadNNszzhifG9lhJz/ViHZImbU9sijLq+3
         W8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMwht8Kpuf4LTPdcGCutOruwBCb0mDtYIKt07DMBo4E=;
        b=ATJBW+FBzgVEn26GuLfQdwMIIsHbk/G44xymrGK1ahAFtvLHtAmr1HRT7crxNQN4d4
         dQfa36hFe5PWjo+J0/QJhZk/2/4z5/MhleseDI7C86qoy5y5xxrlDMdNiEjT9OqeZHqo
         UbTpkMPvmr9fJxZDw7XdOCpuB0wD+oKxpT1XMaKkbqhN5TbeWmGgYvjLJU1qq7T36J9Q
         drKygZVe4Oi2vBJNHNjhVdGuKG0/7lG2TsVrGK3ISYniV4cnbuhbxiHFq1Ja673e8E68
         L+xK5V5zlzBSsmar2XAHAaDBoyMaH+JVqf65zS2kWs/gcP8yT5Ex5D9NtTFrq/t8M2vw
         Lt1w==
X-Gm-Message-State: ACrzQf06jVP3iAkEaLFVpb3x7OrZqoxHDkP8JUfPFq/JFPmvQJHomOUk
        JqePF1Premm7/mLcwIGMYJ6w+Q==
X-Google-Smtp-Source: AMsMyM4mGiPfonebz8lFJ7kC7vx4c5XsK1r4ARLkgHxS1AY/xvIlHCobStZ6m2tfZTgTgMizeaf3ew==
X-Received: by 2002:aa7:83c8:0:b0:56d:8e07:4618 with SMTP id j8-20020aa783c8000000b0056d8e074618mr11391621pfn.33.1667355089608;
        Tue, 01 Nov 2022 19:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i59-20020a17090a3dc100b00202618f0df4sm232036pjc.0.2022.11.01.19.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:11:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, Yu Kuai <yukuai1@huaweicloud.com>,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, cgroups@vger.kernel.org, yukuai3@huawei.com
In-Reply-To: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
References: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v4 0/5] multiple cleanup patches for bfqd
Message-Id: <166735508849.16539.13483811523178998202.b4-ty@kernel.dk>
Date:   Tue, 01 Nov 2022 20:11:28 -0600
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

On Wed, 2 Nov 2022 10:25:37 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v4:
>  - move first two patches from v3 into another thread.
>  - add patch 1
> 
> Changes in v3:
>  - resend v2 with new mail address
> 
> [...]

Applied, thanks!

[1/5] block, bfq: remove set but not used variable in __bfq_entity_update_weight_prio
      commit: 060d9217d356a28e1bcfd2df0c8bf59aa24a12ce
[2/5] block, bfq: factor out code to update 'active_entities'
      commit: e5c63eb4b59f9fb9b28e29d605a4dabbeff7772e
[3/5] block, bfq: cleanup bfq_activate_requeue_entity()
      commit: f6fd119b1ae2c4f794dffc87421cf4ce2414401e
[4/5] block, bfq: remove dead code for updating 'rq_in_driver'
      commit: 918fdea3884ca8de93bd0e8ad02545eb8e3695d6
[5/5] block, bfq: don't declare 'bfqd' as type 'void *' in bfq_group
      commit: aa625117d6f67e33fab280358855fdd332bb20ab

Best regards,
-- 
Jens Axboe


