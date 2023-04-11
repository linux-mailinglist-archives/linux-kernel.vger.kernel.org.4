Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AEC6DE164
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDKQqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDKQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:46:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BD2558E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:46:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id xi5so22001490ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681231573; x=1683823573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWck0qnNaoiFiCtCGNjSsTsFcMjQqGSwfdGnBkruvQE=;
        b=MbVv3M5wjyeWsSWIRL4r5ZirT7K5n9QJ5g/k24GIIt1qkwdAek7yEMtNBg3EoO6d0I
         F2AjeCQZWficlvHmS5wc4oe850OJRh6/7ccdaeoXIHdllOzLIEFksCCrG3d018hBKMN0
         c8jpBDr9uoHQ8gTXgv193cG+89LSFZRveSDfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231573; x=1683823573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWck0qnNaoiFiCtCGNjSsTsFcMjQqGSwfdGnBkruvQE=;
        b=Jwnu8SEe/ueJxOqAAaN1N2sx2jyXW2Eg5VOdoKHF49W2ZdEHn74H8xTbsTRoTuRRMA
         bO42V/vOGSl+f85o9PQwWdKDhDuoSTb/PFvnOpPvLYMGrDGCNhUIwVvTbF8rb7Cfg3xK
         AUCDV+n30koDSUQTG6x0D/wNNM3Fb36SS1FE1vb1ZQaFtspIMrGTT+yTwh9Y4HwnBozg
         5bY/I0611mnPL3VMTZJW1+a+ZHFKX+OABmadPvWF7AzoUFjPDerUjRRd9coa66WbtgVh
         T+hFl5EYijP4jEhMRiP5U5ewj7DXXbt3/lxPCkJ6TD69AJC5Gt1SajbAv7Hqx0LWJtT0
         5txA==
X-Gm-Message-State: AAQBX9e7l1Z4WwI1QgtN6xP/7vFkM//qR1GtzDsh2xiuT7IOg5YpkQRC
        yr9uT2cOlvGcIfkzou1jKFJYxU+PsMOA5pqTM6XW2A==
X-Google-Smtp-Source: AKy350Z3ge2rAJKkXh1IQ4Mk59RaFDbL3Bz+8zCwpchHb+2gpODeKFQrHKi1OJ31MiDqtgwsIWqEGw==
X-Received: by 2002:a17:906:c08a:b0:932:c1e2:9983 with SMTP id f10-20020a170906c08a00b00932c1e29983mr12872666ejz.15.1681231573205;
        Tue, 11 Apr 2023 09:46:13 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id t6-20020a50ab46000000b0050499afe96bsm2866276edc.10.2023.04.11.09.46.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 09:46:12 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50489a2bc4dso2028766a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:46:12 -0700 (PDT)
X-Received: by 2002:a50:baec:0:b0:504:9390:180f with SMTP id
 x99-20020a50baec000000b005049390180fmr4434766ede.2.1681231571945; Tue, 11 Apr
 2023 09:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230410153917.1313858-1-pbonzini@redhat.com> <CAHk-=wiYktfscvihY0k6M=Rs=Xykx9G7=oT5uCy1A80zpmu1Jg@mail.gmail.com>
 <2560f4b4-8620-6160-eee5-4086630bb5cc@redhat.com>
In-Reply-To: <2560f4b4-8620-6160-eee5-4086630bb5cc@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Apr 2023 09:45:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSZViPSuwTv02P34ncDJNFdZS4RoDxN4C2EEoff-W7Ew@mail.gmail.com>
Message-ID: <CAHk-=whSZViPSuwTv02P34ncDJNFdZS4RoDxN4C2EEoff-W7Ew@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 6.3-rc7
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, KVM list <kvm@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 11:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Out of curiosity, do you have some kind of script that parses the "git
> request-pull" messages and does these checks?  Or was it just the
> mismatch between diffstat and tag message?

For me, it's manual - I check that the diffstat matches, but also
check that the description matches the shortlog I get.

And if anything looks weird, I dig deeper (the diffstat often doesn't
match - some people use "--patience" for the diff which can generate
small differences, or there are other changes nearby so that the
merged end result diffs differently from the pre-merge state etc etc).

But "git request-pull" should actually have warned you about the SHA's
not matching. When it generates that

  "are available in the Git repository at:

     https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

   for you to fetch changes up to 0bf9601f8ef0703523018e975d6c1f3fdfcff4b9:=
"

verbiage, it should actually have verified that the tag matches
locally, and it generates that commit ID and the shortlog from the
local tag.

And the fact that the shortlog (and commit ID) you had was the
expected one, but the tag pointed to something else makes me suspect
that you are mis-using "git request-pull".

I strongly suspect that you did the request-pull *without* pointing at
the tag (in fact, you cannot possibly have pointed at the correct tag,
since the request-pull contents did *not* match the tag contents), and
then fixed things up manually later when you created the tag.

So you must have explicitly avoided all the automation that "git
request-pull" does.

              Linus
