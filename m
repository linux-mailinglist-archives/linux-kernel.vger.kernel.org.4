Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2102972A6A7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjFIXRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIXRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:17:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345742D7E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:17:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b02d0942caso10223415ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 16:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20221208.gappssmtp.com; s=20221208; t=1686352661; x=1688944661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RWuX+kZ/I+FgoPe+JjGYufRY/zYD1Mu3QxCDrMKGlE=;
        b=n6tk3kvmE4tmB8KJRAQbmvKm6tDzPxxBtgvVo40GnL8Z019gUykcAyYKe+2GJ/BCvB
         mZfAt6QLb+TcGcFYLxzYksdcaGG0vipWUtab6Ff8EftrRZmNtRyJy3szqsraaTodiLwL
         R1nNMxwL1wDrUOBfnQsEm2EZ5bRpWDvRVZrI9T7WmK4DXa5CImG3CLc5+0OIO19I0Y+7
         aD6OfXyv9vpk7So7Bh/hmNxK/TVHQvJM0dTdGhGrwmJGd2idK3MLi3Tz+D+kFTTlCK20
         clrboVuQKvzuNCFEPHCjKNutbBBTyEQZyTn1JAae7fZLGAImgFXKcq8p4OZvpPsg42TC
         T5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686352661; x=1688944661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RWuX+kZ/I+FgoPe+JjGYufRY/zYD1Mu3QxCDrMKGlE=;
        b=bpXG7KUXPhvYBbOZS7CY/d9u+fMReR+fP39iW7pZwSd2X1hfJUJnh9mUgCGZhmg9Mx
         hlmGRF8UcM/NdS1MY4cpRZYfAh3qj0MfuYy3//i4meetF3PgCOazkZBwYy31gCe1rXER
         HCkNxQdG6QzHHSlgSy+ioWPuRCMiApSDW4WUdG52q+KTdAAAHB+SdrBlm3jjldI3GTuT
         g/okUNJaPqxad4gSKIWczql+2a0MWRzkZwNMPGOKcMrOAkxbHAHnVLHpfq5rmSTYAKiK
         991Uz4oQbi/qC4Bim/fn7yOAFSv5ztQA17kjHrAqHrKr/gAViBo1VMTJcNBuXwNvtn22
         6vMw==
X-Gm-Message-State: AC+VfDzgxC9teywPVV5m44PHiJtYVcc6SOfsrsF9U/wNkKXOq5YmTyUn
        EUwbNjyoGhTix/Flq/qyWS/EdQ==
X-Google-Smtp-Source: ACHHUZ7ihrkV19nTxaELivb9kdHmXDY6SEwTwsd6YpSswQGgsHzOKYi3wbTgq24gQqqtjJr6azf+yw==
X-Received: by 2002:a17:903:1104:b0:1af:d225:9002 with SMTP id n4-20020a170903110400b001afd2259002mr308875plh.14.1686352661470;
        Fri, 09 Jun 2023 16:17:41 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:400::5:eb84])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001b045c9ababsm3756196plx.264.2023.06.09.16.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 16:17:41 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:17:39 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] x86/unwind/orc: add ELF section with ORC version number
Message-ID: <ZIOzE4f2xr9CCA45@telecaster>
References: <5b70bc58ef70aab0a821111cd3201eeced8bab95.1686263379.git.osandov@osandov.com>
 <20230609220430.agw2rtswmjbquzom@treble>
 <ZIOmpuqLTJROYQt8@telecaster>
 <20230609224803.275vqw345utsusah@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609224803.275vqw345utsusah@treble>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:48:03PM -0700, Josh Poimboeuf wrote:
> On Fri, Jun 09, 2023 at 03:24:38PM -0700, Omar Sandoval wrote:
> > > Though, instead of
> > > using an incrementing version, Peter had the idea to hash the struct,
> > > like:
> > > 
> > >   awk '/^struct orc_entry {$/ { p=1 } p { print } /^}/ { p=0 }' arch/x86/include/asm/orc_types.h | sha1sum
> > > 
> > > That way we don't have to remember to bump the version number, and it
> > > would be more resilient to partial backports in distros.
> > > 
> > > Would something like that work for you?
> > 
> > Any sort of unique identifier works for me. One thing that the proposed
> > hash wouldn't catch is if ORC_REG_* or ORC_TYPE_* are ever renumbered
> > (i.e., the meanings of existing values change). It also wouldn't catch
> > if something about the .orc_unwind_ip section changed. But assuming
> > changes like that would be much rarer, it could be handled manually by
> > bumping a "salt" for the hash. E.g., by adding 'BEGIN { print <SALT> }'
> > to the awk script:
> > 
> > awk 'BEGIN { print 1 } /^struct orc_entry {$/ { p=1 } p { print } /^}/ { p=0 }' arch/x86/include/asm/orc_types.h | sha1sum
> > 
> > I'll defer to you guys whether it's easier to remember to bump a version
> > everytime or only in those rare cases.
> 
> I think I'd prefer only bumping it in the rare cases, because we're
> going to end up forgetting either way ;-)
> 
> To catch REG/TYPE changes, we could forego awk and just hash the whole
> file, the only downside being that it might introduce unnecessary
> changes if we change a comment or something.  But the file changes
> rarely enough.
> 
> Or we could tweak the awk to also print ORC_{REG,TYPE}_* pretty easily.

Printing ORC_{REG,TYPE}_* should cover almost everything, and if there's
anything not covered, it can be handled manually, so that sounds good to
me. I'll draft a patch doing that.

Thanks,
Omar
