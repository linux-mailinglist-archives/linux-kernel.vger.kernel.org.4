Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983F95F11CD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiI3SsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiI3SsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:48:18 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B61F629
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:48:17 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11e9a7135easo6472523fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=apLaD9dZYgcCgeaaq4NLy24NMK1+qDu2uk9Le0m4zZY=;
        b=WxEZmxK/v24x8v3wVFVSuZls+JreolxYa2mbgC9fE496NRtNM+/Cs80mZBAfnazPFz
         KI05Pavota0M9lZu3BPNlkdfSzXAZjRD7qBNVt5FEAf74FXvvcYITzJ4WhyArPytve1i
         HVoBK8f88nf/BxLHp0/VzYdYPVmOvYTFIUui79918KJi+Mfl18W+zGjy+9CMLQWhgyue
         V6Sxk6uQZTn4ZPchFOMbETahonMVBLRYhTGxc0KAGlAKmY/JlpIr48xc5IhA/8rtKSwj
         TVXnkZRkVf4m/Nhwfb/lemyZVZriS9rvkq9ye4ws4P/UEh2wvnh/y79FlagCVLc+glJ8
         X1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=apLaD9dZYgcCgeaaq4NLy24NMK1+qDu2uk9Le0m4zZY=;
        b=BewcPIMA2wrAcKE4IrfGc2acp+ZlVLaHKzZ0DLiXwLWXpBomjW1udWQlzUAxm8pDWD
         EwWszgFfXVlKl55Oh5pumsJF5vlqku5bh3vswdz1P0W//l6ofzi+xW84av2iEGpxBBMN
         nSb65zhTevBsV4LpwB4VCnmVj6t8SN9ofbhUSc3Y2HEY6q/OMvUBJYBNe5JkYcEjwQ+j
         AzT4SzcmoWIfSaWe9BIF/0+8jZrUXW03Jk+gPkOd1fuFW/5iT9zmsnRGgb5q7CbY+y1v
         7OTZmyyZKIh9Fvt3AnjFcIBEPlPRbxL/BT2MAbdI52SqyWIz4b/ZZXSPxRWzeo3tET6o
         IM0g==
X-Gm-Message-State: ACrzQf0CbCzONj/xuE9SSWp8xlYzHAOMDHXcq0YEoIJqzkoPqJfmkc5f
        qnMj92RGylS8QcOOn16HRGqUtdAZhK62BFUWfVfQ
X-Google-Smtp-Source: AMsMyM437R9944hWYrWRP0SUIqACrElC+aRZcBMuuRBVk4RU5RAUNRM5fOXvl7AX8ljmk+WGeGTrT809DCwPGiIS2kQ=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr5603254oab.172.1664563695865; Fri, 30
 Sep 2022 11:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
 <20220927225944.2254360-3-ankur.a.arora@oracle.com> <CAHC9VhRBuBiuf6917fpP7n+Sy5fFTpzzEqRXfMGPCbnNU4jswg@mail.gmail.com>
 <8735cagcgi.fsf@oracle.com>
In-Reply-To: <8735cagcgi.fsf@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Sep 2022 14:48:04 -0400
Message-ID: <CAHC9VhTQ8HR4ZF1VNCwuFabTUU+Y+ooeDuSwNTozuWMo4RbgSw@mail.gmail.com>
Subject: Re: [PATCH 2/3] audit: annotate branch direction for audit_in_mask()
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-audit@redhat.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 4:20 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > I generally dislike merging likely()/unlikely() additions to code
> > paths that can have varying levels of performance depending on runtime
> > configuration.
>
> I think that's fair, and in this particular case the benchmark is quite
> contrived.
>
> But, just to elaborate a bit more on why that unlikely() clause made
> sense to me: it seems to me that audit typically would be triggered for
> control syscalls and the ratio between control and non-control ones
> would be fairly lopsided.

I understand, and there is definitely some precedence in the audit
code for using likely()/unlikely() in a manner similar as you
described, but I'll refer to my previous comments - it's not something
I like.  As a general rule, aside from the unlikely() calls in the
audit wrappers present in include/linux/audit.h I would suggest not
adding any new likely()/unlikely() calls.

> Let me see if I can rewrite the conditional in a different way to get a
> similar effect but I suspect that might be even more compiler dependent.

I am okay with ordering conditionals to make the common case the
short-circuit case.

> Also, let me run the audit-testsuite this time. Is there a good test
> there that you would recommend that might serve as a more representative
> workload?

Probably not.  The audit-testsuite is intended to be a quick, easy to
run regression test that can be used by developers to help reduce
audit breakage.  It is not representative of any particular workload,
and is definitely not comprehensive (it is woefully lacking in several
areas unfortunately).

-- 
paul-moore.com
