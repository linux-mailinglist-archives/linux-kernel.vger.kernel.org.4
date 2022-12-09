Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3566A6487C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiLIR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiLIR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:29:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D15C0C0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:29:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so8757923pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=034e6aXc5fwWVn7G8vG+SaZPWqCX6o7xueBmeUitIAo=;
        b=rQ7AcbnKUrYvtNvh5YEHFUt4qfi3oZXzaQMILUfbeyl3Zgt1bhCdGFxPQAZNxQjk4L
         ZqFzkPYtzhkQ/wAKPM8WylMyw0iYwX/ybdFp38hvhrCG/KnTw8RwxJgfB0BjKuZTUJSf
         F6VCaNN1M/cx2BCvuH/+mbkzGat/b4CtjLK9xoGuVlbBN5yB6VhOdmDpFyhhmDt9E2Sv
         EuSmWUHno0BgAANPkcRCN69P1P0QppoWhcI42uft/jYBZn48yFPKz82OcEeNR6L4swgp
         ViR9sCr07hxo/v+/GsePIRxZXMuGmPpe04RVQRDI1AHVahI4lTKy5lrrFCAz2+J4nw3F
         NNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=034e6aXc5fwWVn7G8vG+SaZPWqCX6o7xueBmeUitIAo=;
        b=asY6X4l8eWU7v12E91o9C3hHYHw/CkRGnN9ismWzj4DdQwz2n9xa48eIS+YeUZi5JV
         KHMYcthue9gXiPUb5pdPaMyxB5waSN/eUc/tfv3XcGWErc/yTptXQPCWSEpj9mVCCgsq
         V51B7aHYdTUmjkugGuLvN9WKuqsbdGgSJ8mCawPum0n8B83+/0l9KJp1BLYNEJEJI8XR
         EWDk+F0s1Q039wwJ6+eOQMVZ1a9mJYZ26uKILrrvdxnurv4ZVNLwLRdPyGToPU2DwTaj
         jaayRM8CrElSnLy1T0J4crhq8Whseqth5AGRobd5xsvNPqBDYvPUhaiBggXr0Tb9RWP9
         Ca6Q==
X-Gm-Message-State: ANoB5pl0FziHEI+vaPMdgRU1HgQm8k8tXnBtlTbc5hrQHz8Ujes+G71T
        OTgHmz+UwCXnR2PBnpnTNvgAKyp5k4Kul8CChOwS
X-Google-Smtp-Source: AA0mqf55vDvD0XlojvFe+sHxcQ/CjVBdp2MNl8uBQtS5gamKa8U/V0fzvoC6+i8XO/cxnQbhqCfBO1kZu3x0cdpCiwg=
X-Received: by 2002:a17:90a:2f22:b0:219:8ee5:8dc0 with SMTP id
 s31-20020a17090a2f2200b002198ee58dc0mr31085363pjd.72.1670606947501; Fri, 09
 Dec 2022 09:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 12:28:56 -0500
Message-ID: <CAHC9VhSKeTqR+m5g2Nacp9ZJbvD3=OADGMEfDRX4rsH8HmGO9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] lsm: Fix description of fs_context_parse_param
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     corbet@lwn.net, casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 3:30 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> The fs_context_parse_param hook already has a description, which seems the
> right one according to the code.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 3 ---
>  1 file changed, 3 deletions(-)

I just merged this into lsm/next with a 'Fixes' tag pointing at the
previous comment block commit, thanks Roberto.

-- 
paul-moore.com
