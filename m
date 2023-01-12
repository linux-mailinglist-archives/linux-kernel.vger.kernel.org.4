Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A536685C9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbjALVrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjALVqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:46:38 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07556C7F1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:39:22 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s67so13698440pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2G1ZoEYxGQpgfk9wwUZHFbGRL7cXxq7vSTyyjT2OdrE=;
        b=RL/4iEJmfTC51uP/4p2GTfep3Y9t1w6elQSazYFdY6QRYSjvTppjQIpOtNDtKDpcU4
         RUnDv+CeLUjRJGhYrULLlWDGf5ASBUqttj5zeSF8e0GYaUhurhvZvjzRMwanhoso4Zt5
         xY9GvqZnkHeaPkspRHFqz/HyeFIEeGEK/5j2FjzK5+cDXS2ZVC9kwN8Fzq1mDhHn1VIc
         RIpbrvIno2AM2/KDwlxl33qz/rqJXf54CWA9Ev4bYIk8V20fX7Ecc7F6B6dkSgROnArh
         TU6zSQZXyKKu1ev3rpwvAwCwMnDwLIY0jVQBFpLHsw5zvVFLjR7AP86rlaTN0sddoeoo
         IPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G1ZoEYxGQpgfk9wwUZHFbGRL7cXxq7vSTyyjT2OdrE=;
        b=hslqvqmnXsSQ5SYikE7UQlXv4Y7uljm0dU0dT5UlV99vjX//JMOW74y6Eyq5WG5Qwp
         up/7aJCzgwGr+rS2BQ7CegkLUxpo/s6l775Y6AYEuiEnVlOzoP9hf3mJ/0xuNQoFKbpq
         ujY9A79lun9huKGsfjur3kjhxkeA9cQXAXoQIQuVgad1zIy06qJZKoHdDHsQePC41XpU
         LkKT9BfL+k7ERWuKd7Qsh7vqFAZe2Tw1FHxYS9ax/2LK/bskx95KL+7WiIeicKq9cG7O
         r4DC5ldhDfNpGw3vs+3/B6+wDZNB16e3oPITKNecYnSVEhSmWRPI8JjmelXQ7/2DA+Fg
         pkvw==
X-Gm-Message-State: AFqh2kpotU0NtGW1elhD2VtM2dnVly/lp7IGDfNe0669SLOM5qw2Kvzv
        VuwQvnNPedm2HxL0Hqac9LmyvZUVbsz69HXMfJ05
X-Google-Smtp-Source: AMrXdXvBOTxwky5Htp9NUFLASZ+yHQHATlj3a7gvPm0oPR4fxSDvOYBoiF6PzmjXfwgALYXvizdMhkJbqqi76Nf1MKg=
X-Received: by 2002:a62:158f:0:b0:588:e66e:4f05 with SMTP id
 137-20020a62158f000000b00588e66e4f05mr1366618pfv.23.1673559562029; Thu, 12
 Jan 2023 13:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-5-casey@schaufler-ca.com> <f8dca9d2-6e5e-4584-88b3-f71f62988dab@app.fastmail.com>
In-Reply-To: <f8dca9d2-6e5e-4584-88b3-f71f62988dab@app.fastmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Jan 2023 16:39:10 -0500
Message-ID: <CAHC9VhRRRo9V-q8jT7AbSh1eTPGN7OmxP9hrPz=GTPQa80RjCg@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self attributes
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, Kees Cook <keescook@chromium.org>,
        john.johansen@canonical.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 9, 2023, at 19:07, Casey Schaufler wrote:
> > +/**
> > + * struct lsm_ctx - LSM context
> > + * @id: the LSM id number, see LSM_ID_XXX
> > + * @flags: context specifier and LSM specific flags
> > + * @ctx_len: the size of @ctx
> > + * @ctx: the LSM context, a nul terminated string
> > + *
> > + * @ctx in a nul terminated string.
> > + *   (strlen(@ctx) < @ctx_len) is always true.
> > + *   (strlen(@ctx) == @ctx_len + 1) is not guaranteed.
> > + */
> > +struct lsm_ctx {
> > +     __u32           id;
> > +     __u64           flags;
> > +     __kernel_size_t ctx_len;
> > +     __u8            ctx[];
> > +};
>
> I think this should be changed to be the same layout on
> all architectures regardless of __u64 alignment and
> sizeof(__kernel_size_t) differences, to avoid the need
> for compat syscalls and explicit clearing of the
> internal padding.
>
> Maybe just use __u64 fields for all three integers?

I have no problem with that ... the ctx[] field is variable length
anyway so keeping it as a __u8 should be fine.

-- 
paul-moore.com
