Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB446F0F02
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbjD0Xcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0Xcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:32:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FDE49FC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:32:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so16135634a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682638319; x=1685230319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF7fY9RgJvsaUiW5+pvB5L5glfDX1/XS+mhzYjwklRY=;
        b=cqIqvf8vm6hROjWO5JhW02LxQzz3JNYaftG+NiOMADXFEhiuWc3GVCihgYHv1bs0At
         L70JbEgYb3fGS/cZsKqiq+mmQtVlsoQreErl/PytOztq4uwo/YL2pl4kkYNZn9avYomC
         G2m60qBgGFepMNEdBtV8oIQWKH0XGvvEIgiqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682638319; x=1685230319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF7fY9RgJvsaUiW5+pvB5L5glfDX1/XS+mhzYjwklRY=;
        b=cVQYteSaaNp1LHvC6yxUVaiFPm/pzIHpv6zcHl0ipn0Vf624dECh//rzUVND8ffVKl
         1LH0lEEFWe6Q+Im+7IMMRXRqCh/vgOpSG+n8cBpyplJdmO8kzaQVJsIuryaaxhqovZNH
         ZW8TUzeUxmtF40fmRMvy0Q4QWR01O9TOC/ZfrRMltjgsNVbe/OIISxBK6Y367U7xgtVY
         YqxkMAMYKqzHjCiEaoYxdbE0MGXxoUwnuDNoksQ0a2KI26+wz8DN0VAOg+C8K6x3KE3i
         n4umdFHxCHWB7tMlNodxSKTdpt5bRk9BpTmSQEIYYZbMnSpsoRr4+Fi2QoJnr12p8CRn
         t3MA==
X-Gm-Message-State: AC+VfDxYX7z1Zmlh6I2K6yEs0sIFaCqtHOrxgi2BeagAQdj1W/yKyEQh
        jhfHu01ADpcQtaJd6pdqvlUcu/zRMSzF7OSAIyB8ig==
X-Google-Smtp-Source: ACHHUZ7PRUN6Cna4Y2DP17SZUts2noySY5MqsZ+5zzRM2+nNpodbyJaRQ9gjJwITyWi+7F6OqNDVJw==
X-Received: by 2002:aa7:d941:0:b0:504:8c15:a132 with SMTP id l1-20020aa7d941000000b005048c15a132mr2579519eds.7.1682638319137;
        Thu, 27 Apr 2023 16:31:59 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id d21-20020aa7c1d5000000b005027d31615dsm8277654edp.62.2023.04.27.16.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 16:31:58 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso16125519a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:31:57 -0700 (PDT)
X-Received: by 2002:a17:907:9616:b0:94f:81c:725e with SMTP id
 gb22-20020a170907961600b0094f081c725emr3578627ejc.59.1682638317464; Thu, 27
 Apr 2023 16:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZEqEx7C2iuApvrvt@kroah.com>
In-Reply-To: <ZEqEx7C2iuApvrvt@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 16:31:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcvp-JxG2PW7TF6HV2h1xx2_2SMh_HGNZuEpK0CtNTww@mail.gmail.com>
Message-ID: <CAHk-=wjcvp-JxG2PW7TF6HV2h1xx2_2SMh_HGNZuEpK0CtNTww@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core updates for 6.4-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 7:21=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Once again, a busy development cycle, with lots of changes happening in
> the driver core in the quest to be able to move "struct bus" and "struct
> class" into read-only memory, a task now complete with these changes.

Well, this also caused a build failure, and I didn't catch it during
the merge, because it only happened on arm64.

The reason it only happens on arm64 is that it is in the CDX bus
driver, and that one has

        depends on OF && ARM64

despite apparently building fine on x86-64 too if you were to just add
a "|| COMPILE_TEST" to it.

And I did notice this build failure eventually, since I do arm64
builds on my M2 Macbook Air. But while it's a perfectly cromulent
laptop, it's not like it's a speed daemon. It takes something like ~75
minutes for afull allmodconfig build, so certainly not between each
pull request.

End result: my merge test builds are all done on x86-64, and the arm64
test builds happen much less regularly (ie: typically a couple of
times a day).

I did the obvious fixup, but I can only assume (and hope) that this
was caught by somebody else during the merge window, and that

> All of these have been in linux-next for a while with no reported
> problems.

was just a lie.

                      Linus
