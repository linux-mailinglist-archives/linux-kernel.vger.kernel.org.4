Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4AB62CD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiKPWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbiKPWGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:06:35 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457265E4F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:06:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k15so18795056pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nutEuvim+O03tSTgt7ijJRrnnZDjsohIvb1Cu5fAk68=;
        b=kvit6qLZvj/H2XpEcE2tQltVzbqvZTUcF7YL96hdze7uhRReeySYAwRj7jEkO95+jT
         31eKJqCfk3autqs9d6Qe9JcOI9dsEynpATjnrD+WNxnRfPxUZiLMsbsKo0tvPVm67rrl
         5ph02PC/dm0eahlxTJdGIrg7twRkBQcu8LbKkuf9ocLaZOKi5MoJBk0G4tDOL9H7Adpe
         eX+qwpauMZLYBshirL5wBYpJU1jXTLNGudyKTtX3PihPZYOfmm9k2G1bpQX82DA32qsQ
         837X1U4S6NKZAOoIGcvKtoWulmqag5/ZjP6/gA0F6qSP/yDhn0pTmkK2zHGAA96VboH0
         QQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nutEuvim+O03tSTgt7ijJRrnnZDjsohIvb1Cu5fAk68=;
        b=XPs57Zje784WP/ui49cbDtydeaLi6C6UjeFmAnLO7C24WM93S+nzlhGdVe4oan8aou
         9HnW2NMr6ZgUzxwE7Qm9/DrKzewqg36uXwYWsy9nyKLxb/zj2vnCeBlnYI6SsBk1Qx6m
         qMsG+ZHwDSGMNYMmewaGNVFAlDfgXWv3OD3LW3TiHZ18taj6N2n9MsVrLK2yDyesI/r4
         MyTje+FAluOkN+YbOlrnnTuQmD5DrFepv2WsWpxR39t2kvGfslrcEAm+oro/ZMJM9bwM
         Q43adiyp/9MxwiFjpsHBMJZ2JX8AdixG8OnAjy7NslzW95kX9Kl6yMo71AkHaaxnxTmk
         Ka+g==
X-Gm-Message-State: ANoB5pk7QMi194L29NLMEPHUabPOsoE/nE0CfxSPQWTLJ+of9FStJrP7
        MFIe0I2lbzh5GuOQa3ORgsFQPaYRL0975nKD3a1X
X-Google-Smtp-Source: AA0mqf71012OqDg1MufEYPKkE9j6ut4mcod3ENfS5sdsSRfuukb2vkcSQaaqHo0FKnolB7czO+CW7ZUacdcXI83TAIA=
X-Received: by 2002:a63:5d50:0:b0:460:ec46:3645 with SMTP id
 o16-20020a635d50000000b00460ec463645mr22826460pgm.92.1668636393463; Wed, 16
 Nov 2022 14:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
 <20221115175652.3836811-5-roberto.sassu@huaweicloud.com> <CAHC9VhQ+fUZfJwJ=oJ9ieszKeicnS7Z-QcJuJVL9HF5F0tcA7Q@mail.gmail.com>
 <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
In-Reply-To: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 17:06:22 -0500
Message-ID: <CAHC9VhRzzGt3N+AMxp93Zzq+1tWjd63hNv8AzZx4kppu2J535w@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/4] security: Enforce limitations on return values
 from LSMs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 9:37 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Tue, 2022-11-15 at 21:35 -0500, Paul Moore wrote:
> > If you want to somehow instrument the LSM hook definitions (what I
> > believe to be the motivation behind patch 3/4) to indicate valid
> > return values for use by the BPF verifier, I think we could entertain
> > that, or at least discuss it further, but I'm not inclined to support
> > any runtime overhead at the LSM layer for a specific LSM.
>
> Ok, yes. Patches 1-3 would help to keep in sync the LSM infrastructure
> and eBPF, but it is not strictly needed. I could propose an eBPF-only
> alternative to declare sets of functions per interval.
>
> More or less, I developed an eBPF-based alternative also for patch 4.
> It is just a proof of concept. Will propose it, to validate the idea.

Thanks, I think that might be the best approach.  Also, please
resubmit patches 1/4 and 2/4 with those small changes; those are nice
improvements that just need a couple of small tweaks to be acceptable
:)

-- 
paul-moore.com
