Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF73614C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiKAOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKAOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:18:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E201BEA0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:17:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m6so13621634pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVsPtY3gVVM6m0QHBZpxv+Y/aCVxmoQdB7+i7F7TWCQ=;
        b=MM8TAdVEAPrMP4gB+CoMrgeFjUrfg/XOHPXB2QECZc6ixysal1mRzAx+qI0QpzX0Mz
         gYelXhLGuCHbx9ajsVOu/DG5uzVHmmbVYwGqNyzDvfg12PMKOxP4kxnfb4vP56g+Pr8Z
         8yqbNT4j14QXmo3RjpT+SElJHRyc97dv/wNR56e6EFusM7TcGLNlos+dmkne+7mjcV7O
         o87MC8/TvQ5OQdvXlNCmOiL9TuRQI8mMpOzB9gEmbzoNGY4WHkcgN3KaJse/OxNSWd0R
         WFoxseVM9ZtvF/DbweUs9EuL2pE47WQVZDUE9Q3uWWLnU2fzYjE8zObULHZJPlpSKBKp
         3fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVsPtY3gVVM6m0QHBZpxv+Y/aCVxmoQdB7+i7F7TWCQ=;
        b=KCiwLSdM945AROzMmqqEaZUuzyx2eovtJpNEqnGabnY0y0Jt0f1qZ4As0W5VpW6M8Y
         KcLuouKrxvNAJWNSo3CiRw8ccwoqiEl/gkasgzPsfaALqY1FD5YqzDgrkgu+Hde6YEHV
         JMzweoEfgxKOBjKphdE/pLmTmkGXZX00PnCQdL1fSEzPp16La0O7++BNWN5uZstt6vru
         4brUtmUnFn1pJJ+X9V2hbHqKSJ5Ji52grJ2uhbwsBpta4DgpIefoadw0ekZ55lZhT+5n
         e3MvdGbo3AvTlpkxnDVr6R2FdRoTrs4cwjnrDrXeVwYT07CSqH6OmEbDWClE1cDZ0wZR
         MP4w==
X-Gm-Message-State: ACrzQf1IgalJZt0pW56ICkHgRFWjKYfB8wkI/YymvjxKqZFfszsFp89/
        TGBfqEFzuYSUcM/6/AEcS5HbLL44yQY0YqC1
X-Google-Smtp-Source: AMsMyM72gNO54ErtsjGoUazzXoJi35Y8ynT6N5Dt40dHY6HOEqnAG6xuh0sWSdTndAqizB3NaDV0eQ==
X-Received: by 2002:a63:4383:0:b0:440:3e0d:b9ec with SMTP id q125-20020a634383000000b004403e0db9ecmr17966187pga.54.1667312277768;
        Tue, 01 Nov 2022 07:17:57 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902bcc600b00186e2d57f79sm6386770pls.288.2022.11.01.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:17:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Kemeng Shi <shikemeng@huawei.com>, josef@toxicpanda.com,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20221018111240.22612-1-shikemeng@huawei.com>
References: <20221018111240.22612-1-shikemeng@huawei.com>
Subject: Re: [PATCH v2 0/3] A few cleanup patches for blk-iolatency.c
Message-Id: <166731227683.256723.3065138031958824780.b4-ty@kernel.dk>
Date:   Tue, 01 Nov 2022 08:17:56 -0600
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

On Tue, 18 Oct 2022 19:12:37 +0800, Kemeng Shi wrote:
> This series contains three cleanup patches to remove redundant check,
> correct comment and simplify struct iolatency_grp in blk-iolatency.c.
> 

Applied, thanks!

[1/3] block: Remove redundant parent blkcg_gp check in check_scale_change
      commit: b6e03072a91ecc815c9f62037871d621b09df2b3
[2/3] block: Correct comment for scale_cookie_change
      commit: 77445572e643538019d9919669ddf36efb6a353a
[3/3] block: Replace struct rq_depth with unsigned int in struct iolatency_grp
      commit: 718ac0e343f8fd81ab042aa4936d25fe10f6b318

Best regards,
-- 
Jens Axboe


