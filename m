Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD66162CECA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiKPXea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiKPXeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:34:10 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC0E69DCF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:34:05 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id io19so17881947plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ud1y37qUMgCM/gxdvQMw6rjpiQr0rPzHkykb2T1TOw=;
        b=jrbRsTzGFBtzJXH4NdouZxUiYyPKQAwY/xmJBh4NVbrtqvniX5UYfXIvowNG376O3f
         eLwtZTd6ba3W1ujHY9KXiw+svILo/W9OFO1m0UalP4EKpmsMfepiy/i6aa86EHCqWKyv
         qWDDUfVotm87pdBDO0Xfgi/+YAkeaCgX+rdo+EuhlYGYDIRpsDvKWmFauliHak4wVNLI
         DckVU+/rox+Oi5exTkkDEUKV2Mxw/H1pKQZSwIgdYuS8DxVPCnV8ODquNjjbEQLd89Cy
         sawoAYJG40gaeXZUtqg1vF9XmIjooLLPk2rc3kHLfhCY5MUl7GxaHbuv8P1UN8euweGp
         hkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ud1y37qUMgCM/gxdvQMw6rjpiQr0rPzHkykb2T1TOw=;
        b=TB9H+GQ8L7Ax/6PLibOae3djjw74OTWqL3GzFBNPsVBefEv1jQ1rwiRoPoDYaK+qp5
         z3x60IIDl4gJGmez+KbPeJcVzk3XwXNTMgKerSbo25x9A9mqo8WU6B8UlsKSX1kxWvra
         H/c7mh/JOXn68wHe/12PImRU2l2FgsiuJsXX9+6VuIbEBI4a71tqQR3ExtzbT1Jo0oq+
         Hxys6Hxl6eTz6oGmCmn6wGlCdUxNoLr7/uSfChJiOvQg1kGF2E7oyEFpbhfpW7Pq9R0p
         DjrFaqZaIkBoJMGTuJc2D1V/XEcAwuxmEoQYZ+3D3X1LOdvv9aJg+3HY8AkRUyn/2y8w
         MuCw==
X-Gm-Message-State: ANoB5pmIpqT9pVuYMbRA6x7cE3ZjNs5EJgbEIjQpSo6K8pwsyak5ZItE
        Bg26jE4isJFkYaRRRAkn1KMyN3bhdUKFhY/EXUOi
X-Google-Smtp-Source: AA0mqf6autHIA7b+foED8yvIyyGbA11Im+/0A/6tknTVjps8BtDl7zzp+NqROZqk5yDoHG6fU2SESmQwmeAn21G2aCE=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr5961252pjb.147.1668641645195; Wed, 16
 Nov 2022 15:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20221025113101.41132-1-wangweiyang2@huawei.com>
In-Reply-To: <20221025113101.41132-1-wangweiyang2@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 18:33:53 -0500
Message-ID: <CAHC9VhRa16htUXSN0AXrbUwadRa-qQv+UX8ZO_8W_z2eL=6trw@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: Roll back to original exceptions after
 copy failure
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com, serge.hallyn@canonical.com,
        akpm@linux-foundation.org, aris@redhat.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 7:02 AM Wang Weiyang <wangweiyang2@huawei.com> wrote:
>
> When add the 'a *:* rwm' entry to devcgroup A's whitelist, at first A's
> exceptions will be cleaned and A's behavior is changed to
> DEVCG_DEFAULT_ALLOW. Then parent's exceptions will be copyed to A's
> whitelist. If copy failure occurs, just return leaving A to grant
> permissions to all devices. And A may grant more permissions than
> parent.
>
> Backup A's whitelist and recover original exceptions after copy
> failure.
>
> Fixes: 4cef7299b478 ("device_cgroup: add proper checking when changing default behavior")
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
> ---
>  security/device_cgroup.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)

Merged into lsm/next, but with a stable@vger tag.  Normally I would
merge something like this into lsm/stable-X.Y and send it up to Linus
after a few days, but I'd really like this to spend some time in
linux-next before going up to Linus.

-- 
paul-moore.com
