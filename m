Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913825EFCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiI2SV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiI2SV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:21:57 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323C13F2A9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:21:55 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v130so2456101oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hxDmnM1IL2wJ6pbSJipbjQaG4VApgtgIvJlR8md9+aM=;
        b=PenDZ4du+ECiK5JkhEN/8v2etfVrHhJu4FghACXwbcptNy/wJ70A8VBSZT9NkSkTWz
         65vvWHEwnH8ygm1rMdIUcQ5V5pwA3WRX3FrNxMbeLYUxHwne4hNdXGhX0d1rE7XDH+WL
         m38r0MlN5hRKyvv9BMtAFTNTtBfUfjwsz3DP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hxDmnM1IL2wJ6pbSJipbjQaG4VApgtgIvJlR8md9+aM=;
        b=mA9x5cM/vzjwTvVOfMQJtGcx1+c83OL9zjl0fhwq1H9pwE7TbZlcM8MWOB7fhCiBlj
         Zq+npdTtVqPSZuisgF3pQiJmPhu2reWRzbgZuJ2dibRhsOvaEKQS5YCJ9DuJZP+MU/KQ
         4WfniO6sdLPJiYeMaGExKGK4iQdda+EFytxfFZOjfZq5EFlRLwzsXuQ1nvOof0DEwHn+
         7M9Py1BSxc3Z3jE7xOSBFmmsnw5Ye3SaN/Gdf/WYEOe0ZRo54UqB6xAqyzqlyeIUZCXe
         M9KVztLBVDWQdf9OF3gvO9PC27Vng3LIzzb/28xz/IcatVjF1P4BTi6/S6ymtW7om6qC
         zuaw==
X-Gm-Message-State: ACrzQf0iXJh7rAEPVyQilXuUs5Bk6QfvGQtfldP8icVFq1aWsxUl0oJo
        MOEsfwroxeZTIc1zLe2Rq7udcMCtCnABJg==
X-Google-Smtp-Source: AMsMyM7BB6QrqLKtHllbIhVZRYtXWRTFPaIdwVLrHGt0dKLyplFxcYR0RTy6u5cWVFW/yKrp3SpWdg==
X-Received: by 2002:a05:6808:118b:b0:34d:8f58:d95 with SMTP id j11-20020a056808118b00b0034d8f580d95mr7634955oil.22.1664475713940;
        Thu, 29 Sep 2022 11:21:53 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id e12-20020a4ab98c000000b0047634c1c419sm55622oop.12.2022.09.29.11.21.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 11:21:52 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id d74-20020a4a524d000000b004755f8aae16so665078oob.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:21:52 -0700 (PDT)
X-Received: by 2002:a05:6830:611:b0:65c:26ce:5dc with SMTP id
 w17-20020a056830061100b0065c26ce05dcmr1952667oti.176.1664475712268; Thu, 29
 Sep 2022 11:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <dacfc18d6667421d97127451eafe4f29@AcuMS.aculab.com>
In-Reply-To: <dacfc18d6667421d97127451eafe4f29@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2022 11:21:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgS_XpzEL140ovgLwGv6yXvV7Pu9nKJbCuo5pnRfcEbvg@mail.gmail.com>
Message-ID: <CAHk-=wgS_XpzEL140ovgLwGv6yXvV7Pu9nKJbCuo5pnRfcEbvg@mail.gmail.com>
Subject: Re: [PATCH 3/4] proc: Point /proc/net at /proc/thread-self/net
 instead of /proc/self/net
To:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Thu, Sep 29, 2022 at 8:22 AM David Laight <David.Laight@aculab.com> wrote:
>
> This was applied and then reverted by Linus (I can't find anything
> in the LKML archive) - see git show 155134fef - because of
> issues with apparmor and dhclient.

lkml archive link:

  https://lore.kernel.org/all/CADDKRnDD_W5yJLo2otWXH8oEgmGdMP0N_p7wenBQbh17xKGZJg@mail.gmail.com/

in case anybody cares.

I wonder if the fix is to replace the symlink with a hardcoded lookup
(ie basically make it *act* like a hardlink - we don't really support
hardlinked directories, but we could basically fake the lookup in
proc). Since the problem was AppArmor reacting to the name in the
symlink.

Al added the participants so that he can say "hell no".

Actually, it might be cleaner to make it act like a dynamic
mount-point instead - kind of "automount" style. Again, Al would be
the person who can say "sure, that makes sense" or "over my dead
body".

Al?

Or maybe that crazy AppArmor rule just doesn't exist any more. It's
been 8 years, after all.

                   Linus
