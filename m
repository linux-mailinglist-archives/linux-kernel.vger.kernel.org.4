Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33F667EF96
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjA0Uez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjA0Uex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:34:53 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818CB7B799
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:34:52 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k13so6222760plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pudrmnrH09DULfMiSFSmBZ0Zt0rEOGn6UpZspb2AT/c=;
        b=JZ5f+/aBY7Z2hbqlxT2PlK3ayJdos0JugOhziRogUbhtxkV4zCdm59LJF6s0PkBOKO
         Mg/LpJGOMt/+CeblEzhdAWZDSo/gnhGXnFJds4qZGg3jeZnz8XymCGpJSvj2DikIgl1i
         EHlkmLt/Z41eV1zzKY6ivHP6/RzSLBU7h5Y7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pudrmnrH09DULfMiSFSmBZ0Zt0rEOGn6UpZspb2AT/c=;
        b=1NLv/ifAbkaKC+I13cTyfIE43FN5CdRnCr3jkN/39r9xfR+zGI6PpBIUazlmrJYPFo
         cdtKnp88fiCbgQ8UsUxou2+i2/JeDqPRJIb8mmXx90a/L75IYF0+vxu1lMK05YWf3RuH
         F949M6bPh/lHsuDSjvj0mszvZTheKj9ObaksJ0ZJPCO3aB2TYmNUAOFjxRSYoansQEzk
         U0ztziWE6ehST+EdgPonf4hZZ77+yVNWKnnnecv6IC91JKfxpx35EsYYGhBTby47M0Xk
         wRwqp/O0cpmo/WhFHL4Bh+rAha1qk0kFgbY09p7r6PKVvZeiIZ+yHkXg30EAKcRQI/Uw
         8ljg==
X-Gm-Message-State: AO0yUKXE7qnLJ4A+ymY9a8aOCoBjO+ZYZaBeWQUHKHSuGlOvQ037889M
        gSX1lC49pGzhUbN+AXE0JU+GbA==
X-Google-Smtp-Source: AK7set9A65oshOZxlGJilXx9e95e/cm7HwXyo2e9K9wAn6kguBbs6QpI0wpFMp6dvPRz1WMX+O165w==
X-Received: by 2002:a05:6a20:6926:b0:bc:32ff:9afb with SMTP id q38-20020a056a20692600b000bc32ff9afbmr4754151pzj.44.1674851692043;
        Fri, 27 Jan 2023 12:34:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b00196349cf655sm3229487plb.282.2023.01.27.12.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:34:51 -0800 (PST)
Date:   Fri, 27 Jan 2023 12:34:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>, bristot@redhat.com,
        ebiederm@xmission.com, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        alexl@redhat.com, peterz@infradead.org, bmasney@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Message-ID: <202301271234.8E4A4ED@keescook>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <167482213665.546991.3626486119597692007.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167482213665.546991.3626486119597692007.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 01:31:13PM +0100, Christian Brauner wrote:
> From: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> 
> On Fri, 20 Jan 2023 11:25:11 +0100, Giuseppe Scrivano wrote:
> > This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
> > processes to hide their own /proc/*/exe file. When this prctl is
> > used, every access to /proc/*/exe for the calling process will
> > fail with ENOENT.
> > 
> > This is useful for preventing issues like CVE-2019-5736, where an
> > attacker can gain host root access by overwriting the binary
> > in OCI runtimes through file-descriptor mishandling in containers.
> > 
> > [...]
> 
> Only needed for privileged sandboxes. The userspace mitigations Aleksa
> and I did for the CVE in all affected runtimes back then are nifty but
> complicated. The patch is a decent compromise.
> Picking up this prctl() for now,
> 
> [1/2] exec: add PR_HIDE_SELF_EXE prctl
>       commit: 673301182d473ef61a98c292cf64650c73117172
> [2/2] selftests: add tests for prctl(SET_HIDE_SELF_EXE)
>       commit: bafa339eda3f79d567386e1fae59bb0537156c96

Thanks! I'm late to the party, but I came to the same conclusion as you
did. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
