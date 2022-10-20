Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205396064DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJTPpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJTPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:44:58 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB0A59700
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:44:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 126so68754ybw.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vuJ1OX3Cxr4MI7P448IfdHAHrYdLDVJPbpwIxu/boEU=;
        b=xMxRHb6kucYGsW9hgAzpoA9Lp+fP7/3igVJMrDYXimIwAFBIhogm6Ny0iqNRwWAd6M
         QCRLVyks3/AwZIbTclS1429iwxEVUnzp7Ve/+6cep979/rEg8jj7z4FrLSCNPwvZzBX5
         eYXfZv3ZYsHno6Rcwm9krsK06MTBhCt/tO62c/ZEbDyQCCJG1JgYELb5fvPl5ku03T2U
         qX51NYl7WbDfvxqxuLPCRh1G/eI4QWC9LaloVz8Efve0N5Y5TAFYTBe3lS+Bf4/oJcX1
         ae634PdCsN/+fDy7ZLl1PPCnK2wfmPKYp8PKPXjFYocmVwBRzJy6tML39FHZs5qMT4Ry
         jlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuJ1OX3Cxr4MI7P448IfdHAHrYdLDVJPbpwIxu/boEU=;
        b=2y/EVE132hGq21SirfC/lswq3sre8yYuT1NakCyk4bw9ljzsjUOX9JaMJKu2rvN9k6
         1bvGpAIJmVgsakE8HIyTkfcBL5u6PoSMfVm8eWiWGB+zW+bVb4vum65vbcrm+yVaq8Vq
         ok8r6kVuL2h8o2e1zz8tfqBnbUAYdSbda86+t+n/+vxT43CHFODTTnTprwMEufIjZpC5
         yZmDSVccfc1eSwXkjWLxk+iK6t3T10prS8hAdYIS+aewzmrqEDkD0emgMDQXxdawVC4+
         CxHPg43w2eag3bIMlChGC3u3trcIeZ6p07BxDM9/HHEpVduLf5kA5gJEAWRzyNuq8FRp
         DmfQ==
X-Gm-Message-State: ACrzQf2dculUbeMyzBUNFYZl3Mevch3S0WZbipiVD/1mc6164zMq4uG0
        j9QX4ZfmNC1UqlPFFxqhVxMq0bI+SusNbHDiE+ca
X-Google-Smtp-Source: AMsMyM5/43dxXX5gedL3EoAC+ilNlRScxaa0bWqmfjUQl7AhYvjk8ffyfXpADkAas0i8D4N5gYdy7izZJXYwLEv6TwQ=
X-Received: by 2002:a05:6902:724:b0:6c0:1784:b6c7 with SMTP id
 l4-20020a056902072400b006c01784b6c7mr11983384ybt.15.1666280693355; Thu, 20
 Oct 2022 08:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220927195421.14713-1-casey@schaufler-ca.com> <20220927195421.14713-7-casey@schaufler-ca.com>
In-Reply-To: <20220927195421.14713-7-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Oct 2022 11:44:41 -0400
Message-ID: <CAHC9VhQbr1zgyvzM9zB97+rzO-Rcy6CUt_3-54ED-SEanVWyRQ@mail.gmail.com>
Subject: Re: [PATCH v38 06/39] LSM: lsm_self_attr syscall for LSM self attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 3:57 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a system call lsm_self_attr() to provide the security
> module maintained attributes of the current process. Historically
> these attributes have been exposed to user space via entries in
> procfs under /proc/self/attr.

Hi Casey,

I had hoped to get to review these patches earlier this week, I know
you are very anxious to see something happen here, but unfortunately
that didn't work out and I'm now in a position of limited network
access and time for a bit.  I will do my best to at least comment on
the new syscall related additions, but thankfully you've already
started to get some good comments from others so I'm hopeful that will
help you keep moving forward.

One comment I did want to make, and it's important: please separate
the LSM syscall patches from the LSM stacking patches.  While the
stacking patches will obviously be dependent on the syscall patches,
the syscall patches should not be dependent on stacking.  However, the
LSM syscall patches must be designed from the start to support
multiple, simultaneous LSMs.

Thanks.

-- 
paul-moore.com
