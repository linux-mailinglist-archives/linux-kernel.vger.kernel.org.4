Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EBA6A0EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBWSEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBWSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:04:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ABD4ECEC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:04:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s26so45232530edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OfV3cj6WkoUxagcNB6bb7SMIfI10z38gFMomhuJjaq0=;
        b=eVfpkGFam+YRabRFrkEwHVvKKN3r7syztUN7KFC1ScERvdMXEAzeTGxNKhcNGFhDZq
         JslFqsDg99eaT6JRVWgcR+4bAhW2/a3EtaxQLZQFk9Sp/xbACshQ2iVMqEimUWFpmWhc
         2NyNHpRc/aWtBMy+9asms12Z3xb8G7k8jciu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfV3cj6WkoUxagcNB6bb7SMIfI10z38gFMomhuJjaq0=;
        b=abnZuIn8v0oMrXPRBqIbdczJSMurRuAI/tAvr2hnEBnY7UHy7wr86ePvq+CpSwBXAx
         aRwTSg4Of455UJuvl9V0F0eKIcEuJh5oQXQyi9ux5CENhSC4rcE8RVwqjOCGK5hNc/Rq
         PgkLqhgRpgmLA+VhGBkmJdzRbTLPya5OZa7RxD2ztb4onWychFjQBgcsJR9/03qNK9hb
         XR2QTA9KoAEt5vXtGwLZa1+Wr08Wyu3hVWZPMwdinD+4RRDwSjaq+svxWJkQZvnXj3Pu
         UnQhJumMwfGN3ud1yASK5wIrg0bvh2V/4BUEoN3I3k17MlGE/ViYDGmUrGnchyvj8PHZ
         DjXQ==
X-Gm-Message-State: AO0yUKVHe36dD4plRHdoy8rCwlejwbVc6xZddkWqa4bg3MkuFDHJfRkE
        C+gmfBK6/fyqJ3n6DUnYz5A80Z4aD9bXv+4VHAPzVQ==
X-Google-Smtp-Source: AK7set9vBCIQ4HHO48GjGJLR1LcWsr/C4wqMlyClV8VZAc3D2LctMMlciLz5xuHy3pyt9z6Ub2Ez2A==
X-Received: by 2002:a17:906:4550:b0:8b1:7ae8:ba6f with SMTP id s16-20020a170906455000b008b17ae8ba6fmr23382355ejq.16.1677175443144;
        Thu, 23 Feb 2023 10:04:03 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id dx5-20020a170906a84500b008c33ebac259sm6953303ejb.127.2023.02.23.10.04.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 10:04:02 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id o12so45689291edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:04:02 -0800 (PST)
X-Received: by 2002:a05:6402:5484:b0:4ad:739c:b38e with SMTP id
 fg4-20020a056402548400b004ad739cb38emr7772982edb.1.1677175441752; Thu, 23 Feb
 2023 10:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20230223141542.672463796@linuxfoundation.org> <adc1b0b7-f837-fbb4-332b-4ce18fc55709@roeck-us.net>
 <Y/eVSi4ZTcOmPBTv@kroah.com> <cfd03ee0-b47a-644d-4364-79601025f35f@roeck-us.net>
In-Reply-To: <cfd03ee0-b47a-644d-4364-79601025f35f@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2023 10:03:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCG1zudvDsqdFo89pHARvDv4=r6vaZ8GWc_Q9amxBM6Q@mail.gmail.com>
Message-ID: <CAHk-=whCG1zudvDsqdFo89pHARvDv4=r6vaZ8GWc_Q9amxBM6Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/37] 5.15.96-rc2 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
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

On Thu, Feb 23, 2023 at 9:31 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This isn't the first time this happens. I seem to recall that you mentioned
> some time ago that whatever you use to apply patches (quilt ?) doesn't
> handle executable permission bits correctly.

Note that even though git itself does handle these things right, we've
also always said that if some old fogey wants to use tar-balls and
patches, that's supposed to still work.

I guess the same "old fogey" comment then covers quilt too.

End result: we should try to generally not execute our scripts
directly, but to explicitly state which interpreter it should use,
rather than then depend on the #! in the script itself to do it.

In fact, for shell scripting in particular, we go further than that,
and use $(CONFIG_SHELL)

Of course, in this case, it's actually using the Makefile '$(shell
..)' format, so I guess it looks a bit odd to write it as

   $(shell $(CONFIG_SHELL) script..)

but I do think we should do it.

Now, independently of that I also think quilt should probably just
learn the git world order about file modes, because let's face it, git
_has_ taken over the world. Mwhahahhahahaahaaa!

              Linus
