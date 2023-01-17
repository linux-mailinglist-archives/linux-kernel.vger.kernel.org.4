Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2EE66D405
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjAQCES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjAQCEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:04:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13BC234E9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:04:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so17612519pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SExj9sPYRI5nvri+f4hPOSN0wQyEHXBODvypNoBRz/E=;
        b=Gh1phClZGkEjfMyk7PFqNeMBC2BIMQscw5aErf3bX7JD7N4WENyYXGTvElDfKcp44g
         gR6v9FsUAlk3gLf+hll8ixHOu2Go53fjYr7VQw4w95GZqyidqq1U5/9JWWE6a9ksmjBx
         R7FDsKTErGWvXlNdJ1lh9Op1clvxpjFkY4/nJRgPJNEG2X6u0GbCcPWm3bnobYNDO1t1
         6SrPvB96sAFFi3J2LM9YgqfSuf39ca1gBny1IMzDsrP+RNhFbdFHORnBShPzbFGHE3A/
         SpzuwiNuEAVIP7kvNXqWXUUX9bIMkwC3jehvlsSwzEM/T6QBR2UBYgEkN7KNwXoa5LKq
         mUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SExj9sPYRI5nvri+f4hPOSN0wQyEHXBODvypNoBRz/E=;
        b=hdXDs99wqeWXnR5y/6BobcVgYub/k7gjEVu8T4MLqmeoP1lMGD0usn6OYhmUT4dApl
         Z1dbDGgOAiwmL1mHx1d0dV9CNQZgWZbyjrb7k1JJOlmtMb7zif4ctAFKrBPkQU3iNgfc
         UXrxQZJ67Bz1zrVBjveDp/V63aQ9bwI/h5tBaMf3DUtAY5++hUct3IXzSi1UPP6O7She
         rdzOFCEuxGlC0UJpZJjxI397pKlgrcWmUN6creox2/ZdNrG6CMBgncOE7U1ugyTulISQ
         b2f/ZJzi6JGxr/0yyl9vfYmpQh3VabCFTXAxO9GoDMCm7Ninc1LfyOdM9neiMX/Wj+1J
         yq4A==
X-Gm-Message-State: AFqh2kpJmQbK/vDyf4w6nIb0VJVcQSLB132bnl9PwVir7XA2nqq8MQ+K
        0Po3YCNSLKPrlNQwrhhXRQIPBg==
X-Google-Smtp-Source: AMrXdXuylkNfB24jq6lP5eNrDj0l8ogCU88AsbWP5oRdsJ/+84Sp6SEdDIbnJnwlrTXObRb9zwkMkw==
X-Received: by 2002:a17:902:b611:b0:194:52ed:7a37 with SMTP id b17-20020a170902b61100b0019452ed7a37mr419970pls.4.1673921055052;
        Mon, 16 Jan 2023 18:04:15 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709026a8300b0019492b949fbsm2860762plk.272.2023.01.16.18.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 18:04:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
References: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-cgroup: fix missing pd_online_fn() while
 activating policy
Message-Id: <167392105396.441215.10700011927533380031.b4-ty@kernel.dk>
Date:   Mon, 16 Jan 2023 19:04:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Jan 2023 19:28:33 +0800, Yu Kuai wrote:
> If the policy defines pd_online_fn(), it should be called after
> pd_init_fn(), like blkg_create().
> 
> 

Applied, thanks!

[1/1] blk-cgroup: fix missing pd_online_fn() while activating policy
      commit: e3ff8887e7db757360f97634e0d6f4b8e27a8c46

Best regards,
-- 
Jens Axboe



