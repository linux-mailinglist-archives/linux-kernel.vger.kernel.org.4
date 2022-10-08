Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697215F86FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJHTCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHTCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:02:45 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A02FFD5
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 12:02:44 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u15so3095307oie.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ikSon6n+bKY9qXzbVE0/cOlziToc6+MNWJiC+7LemSY=;
        b=LHQzM40tNdjD5M6kZkY3dvJQmBmoVSmwEdy1ft4p0Ds1z9xB7u6PNLYQfgEWSefibd
         wGHT00D1eoXfvDG+5A1geuiLxzv+cqXQPrmBtI0prjHLJo8IZDEfTik1QyVnmiAFrNfo
         HJwjK347pQ/eYMDTplbUuPhb8car2OMUE2GMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikSon6n+bKY9qXzbVE0/cOlziToc6+MNWJiC+7LemSY=;
        b=gC4nbO4JxAvO8NigSP5pX7nWZ819m+ndHcl5Cdqb3BoP12g5CxBM+83zGch3dAQTbz
         6tOEiV5w/ZWBARvBg+4xaOOgkBuC7x2fanzMZ+0Jcrje0I5TMzZ2kHdVEbAqnueZaqEu
         gEoUGe+UhwWWAITzSGkDRGe9gScUq5Hz+OBsbc8eAy4tm25l6KdgdCBXo0pjWLVpu5Dl
         5rkso2+puXKMw7ihn/PkXdNfLRUOz/ziHWRGCa5uBlFAfTwegA0RHRIiOtpYlnsT9XdG
         fmjZai9rbAJ8Veicrpnk695H79A46pcsuiuFDe6PMS2JPTGdXI6kloEfXETBoP2gX+o2
         gcWQ==
X-Gm-Message-State: ACrzQf3Jh+ciagdaix0mM9ya3jrpeW3V5Niv6cQpR2uveBjfHxZxF9RE
        UhHbU+6HarKWYaYCJULlvcVgwyydl64Tjw==
X-Google-Smtp-Source: AMsMyM66C6W+kuroO/rnPRvDIH/PgsPm+S7QiVtyaCqZBf43AAoqUJaEY3haQEZtDAdT/yeS+X8xuQ==
X-Received: by 2002:a05:6808:209a:b0:354:3031:71a0 with SMTP id s26-20020a056808209a00b00354303171a0mr4608273oiw.71.1665255762596;
        Sat, 08 Oct 2022 12:02:42 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id a2-20020a056870d18200b0013125e6a60fsm3029753oac.58.2022.10.08.12.02.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 12:02:41 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1364357a691so2320207fac.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 12:02:41 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr5565912oad.126.1665255761035; Sat, 08
 Oct 2022 12:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <Yz18QA27+gN0oaM3@google.com> <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
 <Y0AmmR2NfKc/Y7Mb@google.com> <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
 <Y0HB3K8IRVhX5IvT@smile.fi.intel.com>
In-Reply-To: <Y0HB3K8IRVhX5IvT@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Oct 2022 12:02:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixtjmiENLbc1=Hds3mMSjVRA3ZiwXN7yg8mw_1MCg_QQ@mail.gmail.com>
Message-ID: <CAHk-=wixtjmiENLbc1=Hds3mMSjVRA3ZiwXN7yg8mw_1MCg_QQ@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v6.1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Oct 8, 2022 at 11:31 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The Intel PMICs are the beasts when we want to run the code on the real
> hardware.

Yeah, I don't expect he driver to work on real hardware, but I'm
mostly worried about the fact that it also gets very little build
coverage.

The fact that I found the i2c semantic conflict mainly because I was
looking for it (it's cropped up multiple times this merge window) but
*without* seeing it as a build error, that's what worries me.

So I think the

    depends on I2C_DESIGNWARE_PLATFORM=y

might be better with a "|| COMPILE_TEST" to at least find the build
issues, even if actual runtime testing is a different anumal entirely.

               Linus
