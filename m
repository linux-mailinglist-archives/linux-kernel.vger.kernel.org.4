Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B9719C16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjFAM0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjFAM0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:26:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E475812C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:26:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51496f57e59so1191094a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685622407; x=1688214407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJAjrSKk1Ndk8NS3+84Nyv09lcJ/qTEF//Jjgbbt0wY=;
        b=LGLOY87tAQB5Ec3Y/8e9bnJnLtd/lGFTHfUqGHlZ1neCaUmqu9e4KFMZ1Q07UdBUiS
         CdiBESxy9kRbLeq0zuqkHlalm6ndly4hQ8f4MQzhITWaxsDa6sOghru+QBRhIC7SPWq9
         XayY6yOukqd5rQWFrGOCL45YmEWSNMjxMMW2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685622407; x=1688214407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJAjrSKk1Ndk8NS3+84Nyv09lcJ/qTEF//Jjgbbt0wY=;
        b=jG0oG6rh8jZDTz6DfpFgVScl4WoGJnbNmPaBB7jWORDm51atjJFyIYwYalY1WZaFJw
         IFqJ+pcTgxKtwf4wxNz2uQhVeZuq89jfnM30Plns+0U02nt91IqYjExRSUGtO+2NXQj3
         nMhmz1xRJDfmiyoF084rCAN1gHakK6aKOXkSDXDq7r8JTy6z2GiRX6q7OSW/oLjz9dWw
         ZGPUjr0xo4xuxDlh5SY4PFEUZt8QiIWehTjF5PiV4ZOXud75H3WIVCIYsRPNjKVaU7vH
         WGgMtA8TJ/D7i9LNKZH5IZ9/sUD2B4ye7aWugWErKXHuDwDfak8Ezuet/C4nMMnMcjqK
         Rufg==
X-Gm-Message-State: AC+VfDya3sqaadU6JXuG709ELzHoG5PyvK49zh5GCk1GX9jt/YDufy6n
        f4IzQkQxTnZkfZCKO+mdwNeVRRkaLt9DPKx3nkX993Vd
X-Google-Smtp-Source: ACHHUZ7LKTE347m2Fdn+x2aBDQHzRGMbaUR0kRCWoigdtt1lQ2roQwgNxvoNRqm7U2Pkl8zL0ODjKw==
X-Received: by 2002:aa7:d387:0:b0:510:487a:ca3d with SMTP id x7-20020aa7d387000000b00510487aca3dmr6577739edq.23.1685622407255;
        Thu, 01 Jun 2023 05:26:47 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id v5-20020aa7d805000000b005149134ccfbsm6616578edq.52.2023.06.01.05.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 05:26:46 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-973e7c35eddso104460866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 05:26:46 -0700 (PDT)
X-Received: by 2002:a17:907:9412:b0:973:daa0:315 with SMTP id
 dk18-20020a170907941200b00973daa00315mr8333457ejc.1.1685622406136; Thu, 01
 Jun 2023 05:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230519-vormittag-dschungel-83607e9d2255@brauner>
 <ab8c9f95-c9e9-de04-4e28-78163a32da80@leemhuis.info> <20230601-herzallerliebst-dschungel-4515db351a0c@brauner>
In-Reply-To: <20230601-herzallerliebst-dschungel-4515db351a0c@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jun 2023 08:26:29 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgQAgHh_rjiFaAO+Y_mRQvp4SJ7SQ7niVKj89hDmh8Q_A@mail.gmail.com>
Message-ID: <CAHk-=wgQAgHh_rjiFaAO+Y_mRQvp4SJ7SQ7niVKj89hDmh8Q_A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
To:     Christian Brauner <brauner@kernel.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Mike Christie <michael.christie@oracle.com>, oleg@redhat.com,
        nicolas.dichtel@6wind.com, axboe@kernel.dk, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, konrad.wilk@oracle.com
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

On Thu, Jun 1, 2023 at 6:47=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> @Mike, do you want to prepare an updated version of the temporary fix.
> If @Linus prefers to just apply it directly he can just grab it from the
> list rather than delaying it. Make sure to grab a Co-developed-by line
> on this, @Mike.

Yeah, let's apply the known "fix the immediate regression" patch wrt
vhost ps output and the freezer. That gets rid of the regression.

I think that we can - and should - then treat the questions about core
dumping and execve as separate issues.

vhost wouldn't have done execve since it's nonsensical and has never
worked anyway since it always left the old mm ref behind, and
similarly core dumping has never been an issue.

So on those things we don't have any "semantic" issues, we just need
to make sure we don't do crazy things like hang uninterruptibly.

            Linus
