Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95026B168B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCHXeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHXeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:34:23 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A9F62DB3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:34:22 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z5so61546ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678318460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApZcN/clhztxkBCrrdq75AIej//C1Akoazz2oc+iFsg=;
        b=bzcE8Eu0G71O0Q+G3YwDQZToN0QKr0TZU63k6JpO6xoizNELCjKlTAeD9Tc2lU1qFa
         ua1PMRrmfCHErCeeNgXZty2Cr8pthB1F2vJ3mOPai3zdEF1+cVimyIWGJiV7cu3mAM87
         pqYuEF1qffc3Wl5wsJc9KhADOTyzZs+lDaczs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678318460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApZcN/clhztxkBCrrdq75AIej//C1Akoazz2oc+iFsg=;
        b=gsM61C/aGldnCC0GiG8Lw+a0WYPy+v/xTQZyv5jZJmS4v7UjzHSj5Ip+iBlnI4uZ+x
         muD0NVYR4524fC1ceSQ1h+jzmqtOQ17HHXL1EKH3ENDyP0l0mreMvkvzmpgBEKKwflKY
         CjCNPVhZkajiu99xelf29KrUPBBztYABnSgvv2rZ8o33phQKEdN0pJdSA6MgN+LMvPoh
         QtV+9TJ5V0MxBTKElp4184rxmug3DxmPWpNa5fMrknxuef8VpI6sZd3KdDrKxf4JvG55
         8RIPGymKfGUqiK85TH8JTnmDvRDYTjdI0QS/dO2aT5ZAw4qNXIA/wndYTYIJ1586VUdn
         XPZw==
X-Gm-Message-State: AO0yUKVVIA+0+gVP8CsucKCVw/OafSVbWZsNFkMQuAAreuDL2Q0N3U9X
        1U9beFTqQQRqVsIwq1+0GH35CbI9o77dN4tAJmPhtk5r
X-Google-Smtp-Source: AK7set+EqojSsPShuTlLQOPEGz5PD/wyYAq2RbBTUMAdQ8z3SmbFMbKaq2zX6w1VX+HGZeZVQFjtig==
X-Received: by 2002:a2e:aa98:0:b0:294:6e65:4ca6 with SMTP id bj24-20020a2eaa98000000b002946e654ca6mr5454750ljb.38.1678318460419;
        Wed, 08 Mar 2023 15:34:20 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id a23-20020a2e88d7000000b00290b375a068sm2728014ljk.39.2023.03.08.15.34.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 15:34:20 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id g17so107508lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:34:20 -0800 (PST)
X-Received: by 2002:a17:906:398a:b0:877:747e:f076 with SMTP id
 h10-20020a170906398a00b00877747ef076mr9357904eje.0.1678317959537; Wed, 08 Mar
 2023 15:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
 <CAHk-=whCA4-uc5WV_-68Mpmu-TiSv6fxkSjZ19zzcW9jpSxDvA@mail.gmail.com> <CABPqkBR_U06L8skMsDXxSXfMptezequzRCxOTELAXxGDK+F+DA@mail.gmail.com>
In-Reply-To: <CABPqkBR_U06L8skMsDXxSXfMptezequzRCxOTELAXxGDK+F+DA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Mar 2023 15:25:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqRUVq_U8D+ZrP_2sUzJ2bq5oGdD_7xi=mQnEY3b=O2Q@mail.gmail.com>
Message-ID: <CAHk-=wjqRUVq_U8D+ZrP_2sUzJ2bq5oGdD_7xi=mQnEY3b=O2Q@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     Stephane Eranian <eranian@google.com>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, james.morse@arm.com, babu.moger@amd.com,
        ananth.narayan@amd.com, vschneid@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 10:13=E2=80=AFPM Stephane Eranian <eranian@google.co=
m> wrote:
>
> Tested-by: Stephane Eranian <eranian@google.com>

It's out as commit 7fef09970252 ("x86/resctl: fix scheduler confusion
with 'current'") if anybody cares.

           Linus
