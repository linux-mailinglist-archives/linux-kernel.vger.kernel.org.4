Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2268D637355
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKXIIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiKXIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:08:38 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296397344
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:08:37 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 189so336625ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1H8eACwsPHCorcFfJu+1RNheIDT08lbVO89iT+IwrnE=;
        b=hcvgfywrs5CNQciRKRok+L2IOwPt9pTi98wn0IlvOxeiwBYuar9JGTQ2hv4dCeko7M
         ZBp13zhDouAH4H5ECU0rGau8v+fdckbM7MJ9GpMrCJImdG9wrE3G3Rn/B2lXzeZj4Aqa
         i9Ocixhl+jm3HmWdBvG29olLeMYvewUdacS45whUJ0/oeDIcjU7ZRgkx/XHIIc7oCjcr
         UwrhwSKungivUzxn29AlDs3wEtz5pe4aSHNPOqX/xAdFHlVHvOqkUU3+KgWzlPcw3cjD
         3bprMUoOubz2SOrxrtB8biAA5z2xwfZ0bl4gqJR2HqGhPAGYHNBH6I5qy2mawLlHTHjh
         A0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1H8eACwsPHCorcFfJu+1RNheIDT08lbVO89iT+IwrnE=;
        b=DYmZk9xrWuOwsZgNztUViul2lmtN5L7QqcS/F8ahLgEn/VTEgJp3tAq4zpD8BIWgbF
         XQ84mi/etrNXX47qzinHE6/dXJzINCZ8f9z1x68D43ba1s0AJouGaP40Ay/A3YntTW7T
         bNGlv8rl3pdEZoeD6eOfgWTDiLoSmgPRF6gx+3vqf+tXYPXhbu6hm7Ogyp2K8rZqNB3a
         6AH5m95/tfrLGlqB8tcsAjw9r2THhCMV85zG4MLL1v/O9c27a4wTAll9Bxw6BDhVdjx9
         DaUPGOTcGIlWApIboNzorIW5C0ZK1/EOZ9QBCx+bF0rEwAY7Xt1P5OQ2wKKyNySmpDuz
         s0ng==
X-Gm-Message-State: ANoB5pnL0ruw7rHg9jV4lvvMED8/dO/XeJ1GiFCQ5CeHRvf/TmAWdhkf
        5v0Nr864teNlcSJsCSoftHkq7HMIwOtuM11qJrZHfT/nY1s=
X-Google-Smtp-Source: AA0mqf6Hbdl6bOW3lnt8Z2632YBw3AlpSzi59Dc46vuxtwqXTS9h2hH8z8cCGrtUctrK50at+cr6iD8ez62zNLmX+ss=
X-Received: by 2002:a5b:b43:0:b0:6de:1554:867b with SMTP id
 b3-20020a5b0b43000000b006de1554867bmr11396138ybr.16.1669277316282; Thu, 24
 Nov 2022 00:08:36 -0800 (PST)
MIME-Version: 1.0
References: <00000000000063536805ee0769d8@google.com> <20221122043504.GR3600936@dread.disaster.area>
In-Reply-To: <20221122043504.GR3600936@dread.disaster.area>
From:   Marco Elver <elver@google.com>
Date:   Thu, 24 Nov 2022 09:07:59 +0100
Message-ID: <CANpmjNNH0woaJEzviEj5sfzeOyFXCcE4U-UwUcgjL97aU7LVxg@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in assfail
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+1d8c82e66f2e76b6b427@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz invalid

On Tue, 22 Nov 2022 at 05:35, Dave Chinner <david@fromorbit.com> wrote:
...
> Turn off CONFIG_XFS_DEBUG, and this failure will return
> -EFSCORRUPTED as expected because syzbot fed it a corrupt log. THe
> mount will simply fail as you'd expect given the malicious
> corruption that syzbot has performed.
>
> If syzbot is going to maliciously corrupt XFS filesytsems and then
> try to abuse them, then syzbot has two choices. Either:
>
> 1. do not enable CONFIG_XFS_DEBUG; or

We've disabled CONFIG_XFS_DEBUG - reports like this should no longer be sent.

Thanks,
-- Marco
