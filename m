Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961906131B2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJaIaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:30:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE972DC8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:30:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a15so15840613ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn48igS3IBXvOF+EgMV6gXOl/FBAcAGkVdcUR3W/h7c=;
        b=oc+qA1v+m8ZJGEKPfdZgxx8r7+kVVDbwsn2l62EmRfdtT6mvqr8CYJfYvyq0NbaXMl
         B0eIbAxgynY84yK2kZkyLsJptyHISCvQo8XkGuEn496nT66DZ+2+YcA1BQxITYO4b5mN
         bihzbQtVpVoC8JwYrMI3YyXwXkekSwrGTmreYEVgRUCJPYoG7RXvZoFEe2GWSZlr1mJC
         mqB3ELfLof4NUNO3zzqP6JHV2L36EHEOAkXI7l1F0HgxjodmiU/meSSMWLxR/inkv5Oa
         a1aw+RS6aW5b7mp9MsIELm72heCAtk9Lj6TU8xbkMnAL2kQyERj1eMTNsONjo+OfVWQt
         2Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn48igS3IBXvOF+EgMV6gXOl/FBAcAGkVdcUR3W/h7c=;
        b=jhNOn44FkALC9buo480rSK+Br2cIuZwDF+omr7wXnU4uAhH6eZIPHSLyuODpS6ruf4
         wyqF2YDawzQ1WvzQCHEv5O2J846pJD+88czlS8ineqjoHz8rmd+0HcOz/OLGpN5Zlozn
         vaAbuC4EL1qhwuuyLR8VKYUAvlt8Jmkprw0lTpAtKDN92icuTfZmlnSjBIWrEtCGtMPO
         2wHyrQJ7rTmBggk5/LO+nvwIT+GCtZSvC6vshLnnx+tG9N5FD0mQmdptRncb9/tQeT4S
         HIbch/5gPgRoD6iUmfXMtCrd/MoNMD0pcrB3h3CXGqBt5WmPfGpz4h4KGwC4s26krL4r
         Uzyg==
X-Gm-Message-State: ACrzQf3DDb9ECziGuWIwaPjefcsosDQKtyVsv2FDGpxVIQOL8NAsRqki
        sQFVal7UXNB5mmboedTlIqIypM3MRgT4TIIC83TdAsYFi5k=
X-Google-Smtp-Source: AMsMyM6zU8ESu6fo+vQq0wRW7221W7DcZYCUYmGGOlmdlzdT+GsowkFTOswei+XFKlJtDFMsVhTSPe5TcjMwVRmzoaA=
X-Received: by 2002:a2e:a4a9:0:b0:277:2544:f945 with SMTP id
 g9-20020a2ea4a9000000b002772544f945mr5119228ljm.39.1667205008477; Mon, 31 Oct
 2022 01:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <87h6zklb6n.wl-tiwai@suse.de>
In-Reply-To: <87h6zklb6n.wl-tiwai@suse.de>
From:   Steven Noonan <steven.noonan@gmail.com>
Date:   Mon, 31 Oct 2022 01:29:56 -0700
Message-ID: <CACv5JCJLSJ0G0jfQnucBwE3z62s6eSAYyyWW8U6FLfgn6P0ELA@mail.gmail.com>
Subject: Re: [REGRESSION 6.0.x / 6.1.x] NULL dereferencing at tracing
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, regressions@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit this same NULL pointer dereference on one of my systems, trying
to boot with either 6.0.6 or 5.15.76. Unfortunately it happens fairly
early in boot during network initialization, which makes it
frustrating to recover from.


On Mon, Oct 31, 2022 at 12:24 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> Hi Steven,
>
> we've got a bug report indicating the NULL dereference at the recent
> tracing changes, showing at the start of KDE.  The details including
> the dmesg are found at:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1204705
>
> It was reported at first for 6.0.3, and confirmed that the problem
> persists with 6.1-rc, too.
>
> The culprit seems to be the commit
> f3ddb74ad0790030c9592229fb14d8c451f4e9a8
>     tracing: Wake up ring buffer waiters on closing of the file
> and reverting it seems fixing the problem.
>
> Could you take a look?
>
>
> thanks,
>
> Takashi
