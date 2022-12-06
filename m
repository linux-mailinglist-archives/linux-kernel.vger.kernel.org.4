Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB4644D35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLFU0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLFU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:26:40 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B908DF88
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:26:39 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q1so14371738pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5w/JA/rNNSsgqdpY1QhKCqr+BFJRPZ0RCMlM6oTlS2I=;
        b=JlgK0dUVOa387jbpMDqW8SJmd3bPSSNkuD8CDb/mCtVCLTauv/Mz5dEYnq9VYd7yWM
         JwMxFUCYoHau9FWytySAWrHGmCtBCPkoF/j/Rgdl0HSNO5InOf9tv4Oy5Iyn20gwoFoW
         mjn6XWtDDm9BgzJ8SSHMfe/wbyAyMqxRw/o1qeRmg3kDcijd/iifX6oRgXCY+yq158bm
         o59JzwqLo/A16mTGjUuX7sZhkMW7CTNAaUvw71fUmiYjpTWEwQ9laR6ZGgOUO07LJojx
         ho1GqsG0xA5ZzJVzh0L1Hv9XnlfNPQvm5J3zTfaDmgyANE5Zl4SGZavqHEO2tlfQcLpL
         EepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5w/JA/rNNSsgqdpY1QhKCqr+BFJRPZ0RCMlM6oTlS2I=;
        b=1ZtRy0XcoMc0+H5ZjZWEum7eNpTAQP5xuSBGY4gHjB9l8jrbwRISqpR2nK/7uy1N5E
         baCSN/ctqTmWdREr/feT70olhNSzvmoccrX4dOMsVDD88nx9DeXxk+Ods6ZSn+UyGm0g
         zNncjjTafTuC3HZLWflvnWTSDipCscX678DDzSHuOnBmecGWutkyvPkW72ddWq4fy6pY
         O5JLvQzxVPpgizsOeHo4zBX02edpZtSBSPmgLTfZ9+FIeaxs+8n/R2UOimQB0T1/asC9
         deJ1vu9+cQFEscpI/8I8X0n5bM2VRviI15Q6MiLX8z2DlIRHYc8PkoeoYMLO4oAR5tBq
         raUw==
X-Gm-Message-State: ANoB5pkWwmju4Jotf6F4mkG/Rq4dq0b06bqheptnbK8rR0BlD7BbI80G
        J+ORU8VulcVWbQxHXBHz9zyowYaSytnmveZzIqH+
X-Google-Smtp-Source: AA0mqf4ciNjmUT/XCeTPCg50EIAZp0OgH9sZk/GANybiOzZJiX9Bt5Gx/aG46+j2ClgYrf2v1V29Ctwj/ZxoSNUh75A=
X-Received: by 2002:a63:4424:0:b0:477:96e2:9065 with SMTP id
 r36-20020a634424000000b0047796e29065mr62696644pga.533.1670358399001; Tue, 06
 Dec 2022 12:26:39 -0800 (PST)
MIME-Version: 1.0
References: <202212051932088061889@zte.com.cn>
In-Reply-To: <202212051932088061889@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Dec 2022 15:26:27 -0500
Message-ID: <CAHC9VhQnfMkrRNmEe0FtcFis3pkPp7Xd8dUbE3cT+cSni-9qxA@mail.gmail.com>
Subject: Re: [PATCH security-next] selinux: use sysfs_emit() to instead of scnprintf()
To:     ye.xingchen@zte.com.cn
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 6:32 AM <ye.xingchen@zte.com.cn> wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

SELinux uses securityfs, not sysfs, for entries under /sys/fs/selinux.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 9a43af0ebd7d..517fe3454aec 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -174,7 +174,7 @@ int avc_get_hash_stats(struct selinux_avc *avc, char *page)
>
>         rcu_read_unlock();
>
> -       return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
> +       return sysfs_emit(page, "entries: %d\nbuckets used: %d/%d\n"
>                          "longest chain: %d\n",
>                          atomic_read(&avc->avc_cache.active_nodes),
>                          slots_used, AVC_CACHE_SLOTS, max_chain_len);
> --
> 2.25.1

-- 
paul-moore.com
