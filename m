Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A32F5EFF23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiI2VOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiI2VOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:14:16 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B981C4824
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:14:15 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11e9a7135easo3314807fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HD+AV33GDQnjyFVXDDTE0Wqisrv2J294cmXf6Dxy6WA=;
        b=Mb4+284uLNUfBJYApUvYWsjljBC6bGq9LhZBknmcfnWo1eaLky/ISSJhhaOjFstQ69
         EESn70/zMp+J3xBefr/MbuA5Vr+rEcTZX0gRmjfWULwdYczcZ2lKlPS4sUxlxvXW+hVd
         44eOaUNpMrVHDUEsMaQkQuKx/ovT0Z5ZK2d3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HD+AV33GDQnjyFVXDDTE0Wqisrv2J294cmXf6Dxy6WA=;
        b=TlujCmbKoKISknf78WEDzHCj/g36agbKICv1ixmM1xB6e2sJ0l8oTNyJrHTbv6HPgo
         XVKCPej+qVcLusODEMpVlrywEsSOfkrEtMwPjOWglQxO+7neQKaLTJZFJtYPXaeJEORU
         RgMWjpBdaQ7jIfSPxw9aeZ62txPC3/B5BtCkhDgdkx7thU5nh6GTyqmZIaCGpDE+eQZg
         aaFTl8jrXY7Mf6E/H3AgdTKR2OvQYPBcpNfcHkaSHRsDcqk6PEyAOxjDy6LxGfl+17ZZ
         s3RDKM8WdnSQchJPHVGjoYruKE0OJPVt65MUaPHjvy156O63KnJgnJ412y+0jEdl8Jcc
         Sd9g==
X-Gm-Message-State: ACrzQf1lxLxhQzZQjQ6Q0ezdq3pVhPk4955GwpsxfNDokZve5O4fddrN
        6pP6udurpQQcSAlp23aCi7oAA34fEkVEmw==
X-Google-Smtp-Source: AMsMyM5NqGBiJgJAKSI8Cu1ahZ1gijoj90e5cxn6eoTvwuNh9o0SzJMpQSMmIut+XxuPBGs4zPpJtQ==
X-Received: by 2002:a05:6870:14cf:b0:12d:392b:1d9b with SMTP id l15-20020a05687014cf00b0012d392b1d9bmr2929101oab.38.1664486054427;
        Thu, 29 Sep 2022 14:14:14 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id d62-20020a9d2944000000b0065818e6fbdasm179973otb.24.2022.09.29.14.14.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 14:14:13 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id c22-20020a4a4f16000000b00474a44441c8so975017oob.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:14:13 -0700 (PDT)
X-Received: by 2002:a05:6820:1992:b0:475:c2c0:3f92 with SMTP id
 bp18-20020a056820199200b00475c2c03f92mr2154395oob.96.1664486053314; Thu, 29
 Sep 2022 14:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <dacfc18d6667421d97127451eafe4f29@AcuMS.aculab.com>
 <CAHk-=wgS_XpzEL140ovgLwGv6yXvV7Pu9nKJbCuo5pnRfcEbvg@mail.gmail.com>
 <YzXo/DIwq65ypHNH@ZenIV> <YzXrOFpPStEwZH/O@ZenIV> <CAHk-=wjLgM06JrS21W4g2VquqCLab+qu_My67cv6xuH7NhgHpw@mail.gmail.com>
 <YzXzXNAgcJeJ3M0d@ZenIV>
In-Reply-To: <YzXzXNAgcJeJ3M0d@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2022 14:13:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiBBXeY9ioZ8GtsxAcd42c265zwN7bYVY=cir01OimzA@mail.gmail.com>
Message-ID: <CAHk-=wgiBBXeY9ioZ8GtsxAcd42c265zwN7bYVY=cir01OimzA@mail.gmail.com>
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

On Thu, Sep 29, 2022 at 12:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Apparmor takes mount+dentry and turns that into pathname.  Then acts
> upon the resulting string.  *AFTER* the original had been resolved.

Ok. So it would have to act like a bind mount.

Which is probably not too bad.

In fact, maybe it would be ok for this to act like a hardlink and just
fill in the inode - not safe for a filesystem in general due to the
whole rename loop issue, but for /proc it might be fine?

                              Linus
