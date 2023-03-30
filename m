Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8A16D030D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjC3LYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjC3LYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:24:33 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFFDA265
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:24:21 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id t13so13790704qvn.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680175461;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdKipMhEB4vdHlMiUNkGlf7Pph62xlLHFGj7LA3sLc4=;
        b=GhqPwpwm5+aLWZSGZL6KHY5T3Ky+2petggxGW82jJbcYqQ+weEcb2ErZbOnLTPrize
         CLPG2oWR5Nc5kmNfj4GpSPLJez/OcRkgPdBAicUHTzYD3kOqrDDYrPLD7JDj/HvaeYtK
         kicvzLF9Y3Bb2n4SQbyxFYlo5vV2K2otGONB/PPXBlJ/PqBVwM6pFOalEYNaVZ8N1DYj
         qYMxEa1HNTKRkgu75YjuRkDwSeBtllf0mbDI++YFOh2gBaoVTB1XW6KCYDsWm1QXTZBF
         CwkCfv3U6QJ2iEeTDMnyyLcZuFWnWJTp+4RM8S7g0hbJx8tik9HQK5AJ9F70Xbca6LMt
         Rqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175461;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdKipMhEB4vdHlMiUNkGlf7Pph62xlLHFGj7LA3sLc4=;
        b=z2wSEGed5SmJ0jJ8obpzHD9MN8ts0h0tOgfyjSBmTeQHa9wdLgU6B5qvWueIOChP37
         fsbrY1QeTxGh+Alzo3Q1vRvoFTdWVgX13tA1K2JrdPxpPwTS3of2bJA6rDw7p9/pVhoB
         2Ohl062Fo4yo8sCNy1VrHQoeTxHRiiCtEmG8lrer6dG1DsVqXpscXaiP/qe/xRGKMOr0
         vs+d0C7+o+qsgeS1+/cuvjMk/nX/88nJhjJ3RPjnEsK4jdIFURvSPxa0F87rkK/AHrtY
         sj2SaqPOziXvARqOATveQ/L30Pd5QXlbmwVvnC6Fzd0sXkFV6A1VSsWoy/X6o7apDE1Q
         uTow==
X-Gm-Message-State: AAQBX9eW7wwLr7Ini2Y064dX0LnX/sgv1qMU8FxCsNQqaFarCnQzqO2Z
        mK0ZjRSpF0Ntu8arxDd+9bFX
X-Google-Smtp-Source: AKy350a6oy3DHYMDNZaU05eApS6TE1WaIFpW/qqCnUoroDzzZn+WcUIYOnzzHq9JqNYcTgvToFTJJw==
X-Received: by 2002:a05:6214:27e8:b0:5bc:7989:ea31 with SMTP id jt8-20020a05621427e800b005bc7989ea31mr33839189qvb.38.1680175460900;
        Thu, 30 Mar 2023 04:24:20 -0700 (PDT)
Received: from [192.168.7.217] (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id z6-20020a0cfec6000000b005dd8b9345a0sm5385498qvs.56.2023.03.30.04.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2023 04:24:20 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
CC:     <linux-security-module@vger.kernel.org>, <jmorris@namei.org>,
        <keescook@chromium.org>, <john.johansen@canonical.com>,
        <penguin-kernel@i-love.sakura.ne.jp>,
        <stephen.smalley.work@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <mic@digikod.net>
Date:   Thu, 30 Mar 2023 07:24:19 -0400
Message-ID: <1873242bbd8.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAHC9VhRuKqaYD=WCzuuk4=+qFSvCjCEMEsPjAh9pQe-=LyMthA@mail.gmail.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-5-casey@schaufler-ca.com>
 <CAHC9VhRuKqaYD=WCzuuk4=+qFSvCjCEMEsPjAh9pQe-=LyMthA@mail.gmail.com>
User-Agent: AquaMail/1.43.0 (build: 104300275)
Subject: Re: [PATCH v7 04/11] LSM: syscalls for current process attributes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On March 29, 2023 9:12:19 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Mar 15, 2023 at 6:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:

...

>
>> +/**
>> + * security_setselfattr - Set an LSM attribute on the current process.
>> + * @attr: which attribute to set
>> + * @ctx: the user-space source for the information
>> + * @size: the size of the data
>> + * @flags: reserved for future use, must be 0
>> + *
>> + * Set an LSM attribute for the current process. The LSM, attribute
>> + * and new value are included in @ctx.
>> + *
>> + * Returns 0 on success, an LSM specific value on failure.
>> + */
>> +int security_setselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
>> +                        size_t __user size, u32 __user flags)
>> +{
>> +       struct security_hook_list *hp;
>> +       struct lsm_ctx lctx;
>
> Shouldn't we check @attr for valid values and return -EINVAL if bogus?
>
>> +       if (flags != 0)
>> +               return -EINVAL;
>> +       if (size < sizeof(*ctx))
>> +               return -EINVAL;
>
> If we're only going to support on 'lsm_ctx' entry in this function we
> should verify that the 'len' and 'ctx_len' fields are sane.  Although
> more on this below ...
>
>> +       if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>> +               return -EFAULT;
>> +
>> +       hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>> +               if ((hp->lsmid->id) == lctx.id)
>> +                       return hp->hook.setselfattr(attr, ctx, size, flags);
>
> Can anyone think of any good reason why we shouldn't support setting
> multiple LSMs in one call, similar to what we do with
> security_getselfattr()?  It seems like it might be a nice thing to
> have ...

Scratch that, I just reminded myself why attempting to set an attribute on 
multiple LSMs in one operation would be a nightmare. Sorry about the confusion.

--
paul-moore.com



