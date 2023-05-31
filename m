Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050F6718991
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjEaSso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjEaSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:48:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EDF133
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:48:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51494659d49so112678a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685558912; x=1688150912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4X30oNDcGuw9SVg09/maVlh6cvqQ6J+4aW32/Zd99o=;
        b=JN5NwAwy6tGgJI9UABktNapr3ikCOFG8l39Yt9iJMRFeGTh9xfZHTa+SrVVUVGmtpe
         qunDYxEB8PuYFguPDk2mmJm0oP3X1+REOBX1c4U1S4cRCGm+B9QrhPFofyPt35QFTQh5
         SLvOUNXj+M7PZaAKVTXTZ9QrBrk1ZNUtIlO60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685558912; x=1688150912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4X30oNDcGuw9SVg09/maVlh6cvqQ6J+4aW32/Zd99o=;
        b=GE7AKweNIrm3oqgjBGH5jkRGvWAseFub4MgSTf6JNH+UMN08tIAhS8x8RfUii48QL3
         aTGtL8K4k2dmdO2fAbKSkOH2UwDghwzu1U9rwDbkmV3T2+w8dCmzLJ40f11d4utuCFYf
         khRbwoQv4Uq9qiECI3JFwnK6h0NJmoHDM8O8ASBBf5zRaZtlY79EqK03SmvjNi555kEz
         R3i6wlOGL+P2hMLdfTVcrslc3SWTCa/fBB96dHmIMEoHzXBSLYRQNiaguMNSgGl8LS0E
         tcT80FApYurN2DFuxZkOJr1t1MJ168YSSYMdljpKJ2OOzApKGyggcBDWdDoj7FhDd+3l
         jD1w==
X-Gm-Message-State: AC+VfDwEY1QvYM0O/hcRExgtOYR0RDxLdG4ekTM5Sit3e8axHJisu82Z
        BDzSFu69nKXpLBd2bMZoX17oQ6WtZo2K/uqSpP3ix650
X-Google-Smtp-Source: ACHHUZ6okCRcGtbxECXFnWu6DS/TO2bkjTIqAWfac9vPsGy9f7lBVgiE3ezV1rjxQEVvs5ONI/FuXQ==
X-Received: by 2002:a17:907:8a0b:b0:974:1c90:a520 with SMTP id sc11-20020a1709078a0b00b009741c90a520mr6407651ejc.1.1685558912375;
        Wed, 31 May 2023 11:48:32 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906829500b0096f92293e02sm9391625ejx.21.2023.05.31.11.48.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 11:48:31 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-96fb45a5258so1067925666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:48:31 -0700 (PDT)
X-Received: by 2002:a17:907:9609:b0:947:335f:5a0d with SMTP id
 gb9-20020a170907960900b00947335f5a0dmr6616481ejc.62.1685558911012; Wed, 31
 May 2023 11:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000030b7e05f7b9ac32@google.com> <00000000000040020d05fcf58ebf@google.com>
In-Reply-To: <00000000000040020d05fcf58ebf@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 May 2023 14:48:14 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjqv_dAd55m31fJk=6FAy1+=556L9y8eAOB92RstWy6_Q@mail.gmail.com>
Message-ID: <CAHk-=wjqv_dAd55m31fJk=6FAy1+=556L9y8eAOB92RstWy6_Q@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in attr_data_get_block (2)
To:     syzbot <syzbot+a98f21ebda0a437b04d7@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 12:14=E2=80=AFAM syzbot
<syzbot+a98f21ebda0a437b04d7@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 68674f94ffc9dddc45e7733963ecc35c5eda9efd
>     x86: don't use REP_GOOD or ERMS for small memory copies

That sounds very unlikely.

While we had another similar issue where not using REP_GOOD or ERMS
for user space clearing fixes a bug, that one failed by having
clear_user() oops instead of handling the right exception.

In that case the commit really did fix things, even if it was just by
pure luck, and removing buggy code.

But this one seems to have a failure case that has nothing to do with
exception handling, and I don't think that commit actually fixes any
semantic bug. I suspect the bisection was not entirely repeatable,
and/or might have been timing-dependent, and that the bisection thus
ended up on a random unrelated commit.

               Linus
