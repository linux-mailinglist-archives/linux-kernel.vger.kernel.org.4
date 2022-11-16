Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5189562B145
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKPC1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiKPC1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:27:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A5827B31
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:27:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so1032085pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahZz9AJmzGlJIQIWPIPRIoLfIVWlXjpHEZJmoMH+xOc=;
        b=gGDZf0rtUePdblahow2E25VxQTPgN7jbIs+awl+TPpQNdPWanNp680Xf0nzQ7ZL+Ot
         pavAPVefaCJKXta+Y2M8VoiD75BMMdqL/nc6y3Yqu8UwQA1u6qmGuuFK0fY+nLsSH8Lv
         4roikcbwV07w5YhUXsWDMXrCohpJH7hktpUdLVjXRv7d5HQGPloCu2jKkH/ynM3gk50w
         h8zf6xWphdiQfuoWFN4iMPRILF10kWYXSXI11LOTIWcFzwHeIcSv1L8dXgpqEKnCy0x6
         7F+DA+dujgDJl1VAuzCRA5O4PpI8PiHDtP+PbEAhCa2VYjLRh7PxPQ5GU2Ty5bSEaJQ5
         EriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahZz9AJmzGlJIQIWPIPRIoLfIVWlXjpHEZJmoMH+xOc=;
        b=UuKr88/deKPWZcdrlJJDVEy9W6bQHJ7apbwtftNUBGg0RPwMtXdn1W68bd4n4PZrql
         M1XGIQQAZ/dhoB3tvpvkOan/5qxzsAcTA6qecQBEa+2SkLaAgDx0TsDcIApeFjBE8hi/
         apkG5ibItctO/Lr2NC9EIxlnsZTPihncpMkYCv0bnfX40QXK+TRTYhpkpLMEEzjG6gUM
         pWgcaXVAa478uDKhdCIBY7I0dhhLXF8A2mqbBnIkngVpXGIMLKS/mtYsu64Tg9eMMHYA
         Dl1qaHZuwIdmFMyOlbfvAa/d6QgNptT5vY9QWgtRIQXFSZAUYtsOYJQJqnAC31zxIV+7
         LiHg==
X-Gm-Message-State: ANoB5plsoq7z2FP22HJyB3ceEC4iM9bI4YB+qp85NBV89WP2k4ULJgqb
        aNAQaiuQ7WbDy773lKoA0g9n2ekv3AtCyEpXVtUL
X-Google-Smtp-Source: AA0mqf4YV8pgzBiL96jyU49MeQd2r/aiOKiYHCrbMrG+E2Fkmtbk+xgzRFLez6ziTJjdzAaOlAYcvbYh3pAWRbHWEqM=
X-Received: by 2002:a17:90a:2b8c:b0:212:f4f1:96ee with SMTP id
 u12-20020a17090a2b8c00b00212f4f196eemr1447232pjd.72.1668565634126; Tue, 15
 Nov 2022 18:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com> <20221115175652.3836811-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221115175652.3836811-4-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Nov 2022 21:27:02 -0500
Message-ID: <CAHC9VhTA7SgFnTFGNxOGW38WSkWu7GSizBmNz=TuazUR4R_jUg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/4] lsm: Redefine LSM_HOOK() macro to add return
 value flags as argument
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:58 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Define four return value flags (LSM_RET_NEG, LSM_RET_ZERO, LSM_RET_ONE,
> LSM_RET_GT_ONE), one for each interval of interest (< 0, = 0, = 1, > 1).
>
> Redefine the LSM_HOOK() macro to add return value flags as argument, and
> set the correct flags for each LSM hook.
>
> Implementors of new LSM hooks should do the same as well.
>
> Cc: stable@vger.kernel.org # 5.7.x
> Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/bpf_lsm.h       |   2 +-
>  include/linux/lsm_hook_defs.h | 779 ++++++++++++++++++++--------------
>  include/linux/lsm_hooks.h     |   9 +-
>  kernel/bpf/bpf_lsm.c          |   5 +-
>  security/bpf/hooks.c          |   2 +-
>  security/security.c           |   4 +-
>  6 files changed, 466 insertions(+), 335 deletions(-)

Just a quick note here that even if we wanted to do something like
this, it is absolutely not -stable kernel material.  No way.

-- 
paul-moore.com
