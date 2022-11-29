Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367D363C29B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiK2OdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiK2Oc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:32:56 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742027902;
        Tue, 29 Nov 2022 06:32:54 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id td2so20138213ejc.5;
        Tue, 29 Nov 2022 06:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75Q+VSWNhXZ80gGKXdyMvIPgS0GRk2hK2vOQF1Q9i+E=;
        b=L+vbw2JcZgZRcPyS5bFPFst6p1PBiCGXK1crG1i1jSCHg6QlS8NAi0kBlsgJMoW7GX
         /xFyBWVTOQFJm3gEsO7zEcFus894u5hDEOoR6bb9EN7y2lkuNigjAU9iJjCCgtsFITX8
         giRnE+Ir9rjcLDzcvVO04e5akB7PUkJ++UyqyVD5/CUI0Nj6Gc8/tKzT9QdkV+cqRqE6
         3e1Abv9HosLAAqKMrEoD4Aj8U4+CKLbox45x2fq2kJEWiV3oDPiqH4kv18DuMXDHum2j
         91tQre5lB7QeY/YHunmcp9O9yLQTM0YfeI7RMZqjB7qYXVyph2Qi96+c4kesaV4FQtHr
         7qbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75Q+VSWNhXZ80gGKXdyMvIPgS0GRk2hK2vOQF1Q9i+E=;
        b=a9wF2EnV+xduH5eLvdXQwQaBh+tBr+5/OBdh7owppHTE+Swj5kvROleP2JkaZnT4r0
         qfHrkALL+j9OpmnTBt38WO/OgxfZovma2j/b7EtVp9kKZD4xxJWJHQ8kdWh7s80dsrr+
         HaHXnmzgx69r2Dpqn+aMHFeplD1XjK7C2g7AskOla6xOgdzJp0fbICvAOCLyMfspHUJO
         hdqyw7255tNQ7Gxly3Il7ouYgs0m1e03n/do8bjllzsKafvrt1Ncx24oJCchAjHLrIJQ
         5VOdtMCdfA7DC/uY6WaXV8LztCnvs5Fg3U3y5gNM8UsDtvQoleUiZFF9rGqnumFXTXGv
         vcjQ==
X-Gm-Message-State: ANoB5pnTOl3TTFRwnxvN9lp4lo/ytx3RgjPoLPV2zAZ1gCDEAhDRhw00
        WwOf7naORCfMStogDzrqJHGT+07HoCWsM5fLvQQ=
X-Google-Smtp-Source: AA0mqf7cFMiFevsnuHTAOzYW5Lw1AaH9/eIzhGvuE49lrm8xI5qwEAUOmQ6onxwKuR1SGk9xJc5jwb16dlAh8xPH6hU=
X-Received: by 2002:a17:906:4f0b:b0:78d:aaf9:7b8c with SMTP id
 t11-20020a1709064f0b00b0078daaf97b8cmr49258925eju.229.1669732373347; Tue, 29
 Nov 2022 06:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20221129103949.19737-1-lhenriques@suse.de> <4914a195-edc0-747b-6598-9ac9868593a1@redhat.com>
In-Reply-To: <4914a195-edc0-747b-6598-9ac9868593a1@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 29 Nov 2022 15:32:41 +0100
Message-ID: <CAOi1vP8raoFP2dsc6RY1fONCsHh5FYv2xifFY7pHXZWX=-vePw@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: mark directory as non-complete complete after
 loading key
To:     Xiubo Li <xiubli@redhat.com>
Cc:     =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 3:15 PM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 29/11/2022 18:39, Lu=C3=ADs Henriques wrote:
> > When setting a directory's crypt context, ceph_dir_clear_complete() nee=
ds to
> > be called otherwise if it was complete before, any existing (old) dentr=
y will
> > still be valid.
> >
> > This patch adds a wrapper around __fscrypt_prepare_readdir() which will
> > ensure a directory is marked as non-complete if key status changes.
> >
> > Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
> > ---
> > Hi Xiubo,
> >
> > Here's a rebase of this patch.  I did some testing but since this branc=
h
> > doesn't really have full fscrypt support, I couldn't even reproduce the
> > bug.  So, my testing was limited.
>
> I'm planing not to update the wip-fscrypt branch any more, except the IO
> path related fixes, which may introduce potential bugs each time as befor=
e.
>
> Since the qa tests PR has finished and the tests have passed, so we are
> planing to merge the first none IO part, around 27 patches. And then
> pull the reset patches from wip-fscrypt branch.

I'm not sure if merging metadata and I/O path patches separately
makes sense.  What would a user do with just filename encryption?

Once fscrypt test suite is merged, I think we should let it bake
for for a few weeks and then merge the whole thing together.

Thanks,

                Ilya
