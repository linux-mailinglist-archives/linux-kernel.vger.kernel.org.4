Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811546017A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiJQT1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJQT0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F969F49
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:26:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gf8so11842638pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=waxKPyyTOtiCa96P8GAUa8RX865lJAs9k6vF17GqtdU=;
        b=GQo6pEUhUQiOcqbCvFsUJHsysQ3VyeKv8zYH+d3iB2r7nPEMSpSwchH3nFowEbOEUd
         1IyouP71wv2enXH2B+OLbxRP2d5VXhJFOhU+XINXhGdZLS7QxAvCJY/gUybHO8WzLpwZ
         fR0JP8IJpwFk9ZPlinhx/6ek9k+2jtTXfeBrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waxKPyyTOtiCa96P8GAUa8RX865lJAs9k6vF17GqtdU=;
        b=XHKq3tfyHoUkKlja1ENW80GTqHyUXF5NLqb7ZXx3rJWj4SUltIpLCVFJMlGsOh0isj
         tSDcbUdQsm//7umnWkxissVztIwBE34t/ra7RiVE29luoCU1d+DVfE5IUm5Xikbd2AyA
         vexWEpoG+dIHr1gmAeUN9BOzo3LtZx7d88X4HCBtpoMd5iFi0nfl8iMX6jTxR6gxyxrO
         5l20krynvQDnywLWZN4/8+wsAowSo/0rOGJdiGff49CxsZHHhCy9CBvyW5mJTEj+RVnn
         FFHQfsCZ54c3DBYmGgiXidbo/o0mRWNgvh9n/JtO+NLfdZuAMG845s/YIcF9RgVJFQ++
         MK2g==
X-Gm-Message-State: ACrzQf20/bIBPrcNjrOfFt7HYdwKqeZaBBBGj6FVtCcKV8iC/eqAB4gK
        791gs25QG1uZAq6SrvROkvVIPA==
X-Google-Smtp-Source: AMsMyM7EHAh8aCOxeSV7OcwhhU1HFMfR5qLWOAVFxVKo+mix7Mn3EPsONOdXWxrh3TboSbjh3hR8UA==
X-Received: by 2002:a17:903:189:b0:183:7473:57f1 with SMTP id z9-20020a170903018900b00183747357f1mr12802468plg.28.1666034733610;
        Mon, 17 Oct 2022 12:25:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c4-20020a633504000000b0043be67b6304sm6561648pga.0.2022.10.17.12.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:25:32 -0700 (PDT)
Date:   Mon, 17 Oct 2022 12:25:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
Message-ID: <202210171111.21E3983165@keescook>
References: <20210222150608.808146-1-mic@digikod.net>
 <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com>
 <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com>
 <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
 <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[*double thread necromancy*]

On Mon, Feb 22, 2021 at 02:46:24PM -0800, Casey Schaufler wrote:
> It wouldn't. But compiling the new LSM mynewlsm doesn't add it to
> the list, either. Today no one should expect a LSM to be active if
> it hasn't been added to the CONFIG_LSM list. The proposed addition
> of CONFIG_LSM_AUTO would change that. "make oldconfig" would add
> security modules that are built to the list. This is unnecessary
> since whoever changed CONFIG_SECURITY_MYNEWLSM to "y" could easily
> have added it to CONFIG_LSM. In the right place.

Having CONFIG_LSM/lsm= is to support the migration away from having a
"default major LSM", but still provide a way to separate "built" vs
"enabled". As such, it needs to provide ordering. (So we have three
concepts here: "built" at all, "enabled" by default, and in a specific
"order".) And not being listed in CONFIG_LSM/lsm= means an LSM is
disabled.

I don't disagree about "anyone who enables a new LSM config can add it to
CONFIG_LSM", but really I think the question is why require an _ordering_
choice. Most distros and builders don't care beyond having the current
"default major LSM" come first, which leaves only the "enabled by
default" choice.

To review, security= currently only enables/disables apparmor, selinux,
smack, and tomoyo. It will go away once the full implementation of
stacking is finished.

I personally think it's reasonable that a "built" LSM be "enabled" by
default, however, this is not universally held to be true. :) The need
remains that enablement be configurable. The current solution here is
to add/remove it from CONFIG_LSM/lsm=. What remains problematic, though,
is a mismatch between lack of ordering causing disabling, but enabling
doesn't specify ordering. Ordering only matters for the legacy major
LSMs, which is controlled by CONFIG_DEFAULT_SECURITY_*.

Here is a reasonable overview of the main "lsm=" thread...
https://lore.kernel.org/all/CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com/
https://lore.kernel.org/all/abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com/
https://lore.kernel.org/all/CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com/
https://lore.kernel.org/all/7741e4c1-cc54-4d04-a064-cb5388817058@canonical.com/
https://lore.kernel.org/all/CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com/
https://lore.kernel.org/all/5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com/
https://lore.kernel.org/all/CAGXu5jLBHN=YSs3Uh49bBJ1SRA1Km2UUD4j37GJJXiKhQq+KPA@mail.gmail.com/
https://lore.kernel.org/all/CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com/
https://lore.kernel.org/all/88b0cc69-cd42-1798-6ce4-d3cfbbc79d83@canonical.com/
https://lore.kernel.org/all/alpine.LRH.2.21.1810051449110.2590@namei.org/

I *still* think there should be a way to leave ordering alone and have
separate enable/disable control. And I think the growth of additional
LSMs that need explicit ordering supports this proposal.

What has become clear is that allowing _ordering_ to be generically
mutable is a mistake (and we had hints of this due to the standing
exceptions for "capability"). How about making these changes:

1) make ordering be source/"built"-controlled (i.e. similar to what
   CONFIG_LSM_AUTO proposes)
2) have CONFIG_LSM/lsm= control only enable/disable and NOT ordering except
   for the "major" LSMs.
3) introduce "lsm=+foo,-bar" that will enable/disable the given LSMs without
   changing relative order.

I think of it like this. LSMs declare their ordering position (btw,
capability remains an exception to the existing logic, and this change
would begin to regularize it, IMO):

first:   capability (cannot be disabled)
early:   landlock,lockdown,yama,loadpin,safesetid,integrity
mutable: selinux,apparmor,smack,tomoyo
late:    bpf
last:    ...empty...

And "lsm=" can only change the order of the "mutable" ordering LSMs.

As an example:

Assuming The "built" order for all LSMs was defined as:
  capability,landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,apparmor,smack,tomoyo,bfp

If CONFIG_LSM was:      yama,integrity,apparmor,selinux,bpf,lockdown

a) without boot param
   result would be: lsm=capability,yama,integrity,lockdown,apparmor,selinux,bpf

b) with boot param: lsm=selinux,lockdown,yama
   result would be: lsm=capability,yama,lockdown,selinux

c) with boot param: lsm=-lockdown
   result would be: lsm=capability,yama,lockdown,integrity,apparmor,selinux,bpf

d) with boot param: lsm=+setsetid
   result would be: lsm=capability,yama,safesetid,integrity,lockdown,apparmor,selinux,bpf

Thoughts?

-- 
Kees Cook
