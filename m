Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907E66FB24D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjEHOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjEHOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:11:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E4934121;
        Mon,  8 May 2023 07:11:06 -0700 (PDT)
Date:   Mon, 8 May 2023 16:11:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683555064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CW4Oxt6tgBDx4EZWBOZEPdQdc5GDnBQfLbNGBkiVv4=;
        b=X4SNdbppA5MERKaBrIpNtP6vpEMhhILRycjTD77g5tgeTGfeUq8gk3n8GcFnOfc3TaMp4x
        OBF4J95LWPZMjmkV+qx+Kud75BGmzBGiYqFAjU8WN2x8ppJSUKi2F28rj6yzOkiZgHoMB7
        Zu9L1mZMxNa4i+vcyDTjm8J8vEF0NIoYwuoxnpLPwOaqfYmS62lvzYcsR7UtovX+6I7G0H
        jEPqfpdqGfPW7/xWVpbfw93aaqvXfwohiestqGelxKED5stUt27vimkALJdcVSBozG1l52
        zop1N3movPQNUhR8szByUnhTEENR+mpAPqw9Xwu2gKpOjopUDxrfdyFtlppqFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683555064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CW4Oxt6tgBDx4EZWBOZEPdQdc5GDnBQfLbNGBkiVv4=;
        b=WP4fSM2rpc6FWChlzYEDb/dSood2U58WPY53v2FJxIJQlgWNMJcbeagvKhIRS3X7bFIhPl
        YPmltLBGNK/N3YCQ==
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] scripts/tags.sh: Fix gtags generation for O=
 kernel builds
Message-ID: <ZFkC9+rF6xYOlte3@lx-t490>
References: <20230504201833.202494-1-darwi@linutronix.de>
 <20230504201833.202494-2-darwi@linutronix.de>
 <20230504213246.GB1666363@dev-arch.thelio-3990X>
 <ZFQrD3qKIMGjI9Zd@lx-t490>
 <CAK7LNAQO2dLL8G2BxK_NPD2YG35nh90_9VFeTi+OFHQrn0YHvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQO2dLL8G2BxK_NPD2YG35nh90_9VFeTi+OFHQrn0YHvg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Fri, 05 May 2023, Masahiro Yamada wrote:
>
> It is wrong to check whether you are building out of the
> source tree.  See line 159 of the Makefile.
>

Oh, didn't think about that case. Thanks for the reference and the
further clarification in reply.

I'll remove the ${O} check then and use saner mechanisms.

> BTW, this patch does not work for me.
> It spits a ton of "not found" warnings, then generates
> empty tags.
>
>
> $ make O=build gtags

Interesting...

When doing:

  $ make O=../build gtags

  scripts/tags.sh "$tree" variable is set to the absolute path of the
  kernel source tree. Thus all the paths fed to gtags are absolute and
  this patch series works.

When doing what you tested with:

  $ make O=build/ gtags

  scripts/tags.sh "$tree" variable is set to the path of the kernel
  source tree *relative* to O=build/. So in that case kernel source
  "$tree" equals ".."

  With this series, the build will fail as gtags current working dir is
  the kernel source tree, and all the fed paths are thus invalid as
  they're relative to O=build/ instead.

  Without this series the build will still fail given the original
  problem of having the files "outside the source tree", where gtags
  thinks the source tree is "build/".

I'll think of something that can cover the both cases.

Kind regards,
Ahmed

--
Linutronix GmbH
