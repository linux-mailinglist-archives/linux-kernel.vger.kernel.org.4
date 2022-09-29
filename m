Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACE55EFF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiI2V33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI2V3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:29:22 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF8C146632
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:29:22 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-12803ac8113so3338428fac.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zWEEW0io6OLT3d76J4YRO+ROrxoFQ09A3+z0bkYNhFk=;
        b=LEvFJnetoNHBkkAzEJsR1PxWKQVoG84Y/dJeHRNRHwsNUetMHIRQpvPy6NjFzEFffW
         NYYFj1OXKx+Gaka66SwjaDtqbrt1Y/l5VlQSQSQNZyVCvmG9PFfVDqGUjwWktp8raszl
         DxIIMvq17kw7qgy9J/IyQbze79kON/+UTztss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zWEEW0io6OLT3d76J4YRO+ROrxoFQ09A3+z0bkYNhFk=;
        b=CgRlDt/nluhMXykQoDLbAZUBKmO8fOnpFO7aRT8TFenfXMfN41EXk7a77mMN3Bs2gT
         XiNXlFIu8I2E/YgzLfSbchD64qLTbD74ciNqP+rUHH7AtQzvNf7Itu3CQRd4AJLy/Bd9
         kCMZ8OnMpbnUmnz62IUytksscqS8hE+1+yQzGd4cDQ1zMRr/WxSrNoJz5IlykEbQrdH6
         KVKk6w17bCC7cQFI7lDfBK+o43P+OLb6y7mZkVC7O5MaPA5qNw4/41o0bqVSxI/MnhBt
         L5+3kN7JQtwPVuck6ToGAOnPTqblD7HeKv+VX2A+CXaVlKUNSePGGY9nTLtnyTkvnUjV
         CGpw==
X-Gm-Message-State: ACrzQf3EGzcwFG5pGfK51Vse02F0FYdRsikahSEYACBT+aITOnhlwg7Y
        udp+vFwa+rpcnonZIy2/haT4G41KjBnB1Q==
X-Google-Smtp-Source: AMsMyM4QXcvkOvTPbR5KHFcNTytOhuMbD8NJ6jW336ncn5Tb8SjeKg9VL//JuJkZyE0Sy0u93FXzXw==
X-Received: by 2002:a05:6870:2110:b0:12c:cfd2:8178 with SMTP id f16-20020a056870211000b0012ccfd28178mr10094231oae.123.1664486960866;
        Thu, 29 Sep 2022 14:29:20 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id h16-20020a9d6a50000000b006394756c04fsm198504otn.0.2022.09.29.14.29.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 14:29:20 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id h1-20020a4aa741000000b004756c611188so1000213oom.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:29:20 -0700 (PDT)
X-Received: by 2002:a9d:2de3:0:b0:638:e210:c9da with SMTP id
 g90-20020a9d2de3000000b00638e210c9damr2259623otb.69.1664486959800; Thu, 29
 Sep 2022 14:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <dacfc18d6667421d97127451eafe4f29@AcuMS.aculab.com>
 <CAHk-=wgS_XpzEL140ovgLwGv6yXvV7Pu9nKJbCuo5pnRfcEbvg@mail.gmail.com>
 <YzXo/DIwq65ypHNH@ZenIV> <YzXrOFpPStEwZH/O@ZenIV> <CAHk-=wjLgM06JrS21W4g2VquqCLab+qu_My67cv6xuH7NhgHpw@mail.gmail.com>
 <YzXzXNAgcJeJ3M0d@ZenIV> <YzYK7k3tgZy3Pwht@ZenIV>
In-Reply-To: <YzYK7k3tgZy3Pwht@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2022 14:29:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihPFFE5KcsmOnOm1CALQDWqC1JTvrwSGBS08N5avVmEA@mail.gmail.com>
Message-ID: <CAHk-=wihPFFE5KcsmOnOm1CALQDWqC1JTvrwSGBS08N5avVmEA@mail.gmail.com>
Subject: Re: [PATCH 3/4] proc: Point /proc/net at /proc/thread-self/net
 instead of /proc/self/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
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

On Thu, Sep 29, 2022 at 2:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, what e.g. debian profile for dhclient has is
>   @{PROC}/@{pid}/net/dev      r,
>
> Note that it's not
>   @{PROC}/net/dev      r,

Argh. Yeah, then a bind mount or a hardlink won't work either, you're
right. I was assuming that any Apparmor rules allowed for just
/proc/net.

Oh well. I guess we're screwed any which way we turn.

           Linus
