Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78E75F5A30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiJESzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiJESyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:54:54 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA6318B06
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:54:51 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-132e9bc5ff4so1852004fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qFz8bcXSm8NKx+cQ2WBeXMjTdSUy3qZJoPO+EKQrt+k=;
        b=NgFXCEoOwxhznFgovrwNaSKvGa6GrTCOnIddMQRVCb83LQHPPOqAQigJIqyEA6Mu9U
         2op2a7Ahuy/CUAf5CiVfnXr3zzMZQcbrbZ+Ya2KCsxmxB/NBv+f7R4h7bK3Db/Bb/ZhC
         mycMkLuYRZGr8SBQPoJVFxfkwMQN1keAVyeXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFz8bcXSm8NKx+cQ2WBeXMjTdSUy3qZJoPO+EKQrt+k=;
        b=mRYL2EWDTTpVY9cs/VfsOxAhkBAYNi9uj3+pqXVo0EPrswwaOer7+pyQb6uNsqMm7e
         edfRo81h8iUw1HqRpDR56EzLCOAToNqTdnBgxEtAT3gOvKDF/OzXbis+ut684sCz6N7y
         8C6bJPdSeCpb/z7EtJOpGr3ZEwxm7LQgERip8vnHs+FEa7zRb5y6/5qgdJguXW1C5Zd3
         UIGT3G+gvV+YyOFddF5QhtyAErV1CL5U4GxV7T6u2wpNfFDdohoVqGEJGHWegBg0VBs5
         lzy+BtJiRcY5ydhE0ZH6vSl/LB5pADOj7zFTqExeZSRHL8/cmMrTk6pckGjK4lhw3Dom
         UlFw==
X-Gm-Message-State: ACrzQf2CkVOTSGSXUvVxLwV6C2rFnFhoTqvnUVY7iv58x9qhNnfuFz4E
        IKbWYmuouxnQOllmyhOG+dcoX9LCf56znw==
X-Google-Smtp-Source: AMsMyM5p+PjE1yHisHEMdskrO3w5HtdI8/gPrFq5ImkGCnNKFXu+nD+NMweJFOeGO1P3tBsDGgRhBA==
X-Received: by 2002:a05:6870:170e:b0:132:beae:87ec with SMTP id h14-20020a056870170e00b00132beae87ecmr589130oae.298.1664996089607;
        Wed, 05 Oct 2022 11:54:49 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com. [209.85.160.44])
        by smtp.gmail.com with ESMTPSA id n6-20020a9d6f06000000b00660d73c8bdesm1461863otq.50.2022.10.05.11.54.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 11:54:48 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1324e7a1284so12246863fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:54:48 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr569402oab.229.1664996088058; Wed, 05
 Oct 2022 11:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org> <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
 <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Oct 2022 11:54:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihQGNanXu3aeN12rsq+2K9BDkZEij-9HWtbVxFbXg1rw@mail.gmail.com>
Message-ID: <CAHk-=wihQGNanXu3aeN12rsq+2K9BDkZEij-9HWtbVxFbXg1rw@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 5:39 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> We already have /proc/sys/user/max_user_namespaces.  It is a per userns
> control so you can run it in as fine grain as you like.  A little
> cumbersome perhaps but real.

It's not that it's cumbersome.

It's that it is *USELESS*.

Sure, it limits the memory footprint of somebody who does the
fork-bomb equivalent of user namespaces, but that's the least of the
problems.

Just think of normal users. They'd want a limited number of user
namespaces for things like sandboxing (whether google chrome or
whatever).

So distros do want to allow people a few of them.

But they want to be able to do so in a *controlled* manner. Not a "ok,
this user can create five user namespaces and do whatever they want in
them". Because we've had the issues where some kernel part has gotten
things wrong, and thought "local NS root means root" or similar.

So it's not about the number of namespaces. AT ALL. It's about *who*
and *what* does them.

> I don't know.  I tried to have the conversation and Paul shut it down.

I really get the feeling that the problem here is that you're not even
acknowledging the whole issue to begin with, since you mention that
"max_user_namespaces" not once, but twice in the email.

> It would be the easiest thing in the world in security_capable to
> ask is this a trusted app, if not the answer is no.

Isn't this *literally* what security_create_user_ns() would basically be doing?

IOW, letting the LSM just say "this app is trusted to create a new
user namespace".

And that is what the LSM model is literally designed for. Because the
kernel doesn't inherently know "I trust this app". It doesn't know the
difference between "google-chrome" and "l33t-crack3r". It needs some
kind of external set of rules.

See?

               Linus
