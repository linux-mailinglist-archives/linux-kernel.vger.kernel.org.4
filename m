Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000C46EFC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbjDZV2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjDZV23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:28:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE4E76;
        Wed, 26 Apr 2023 14:28:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b99f0a0052fso4230819276.3;
        Wed, 26 Apr 2023 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682544507; x=1685136507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csnG/aChZgPBgsRf67ljm6apadApqU0JoShp+C1rCfY=;
        b=AcqzPNAqbFwr3Zd1l7i8Gdo2WXhAjJOUyP/djgqVYxwTr93FMPuUVNiGqC98ALD4Ni
         pPYVt63Trvd1j4Eq39POj+cyJ5CzJIAIruMDpJ8FANdkfjVXJfF/xrRvSjIstqv5Ez6c
         46p+/cu4pa9826QPY4C3rMo2DH2YmwUgE482Dt45CGy/OahCBX/KWjt9Qf3JOM8eFGAD
         142UloN2xOLVPy/BUfi5p0XzYyXtJrFqRhhlVvjMNjVygxNITb0m1tN+qdF7Yr4HcZnL
         sFPhRDqsYQdGcJWTOYP4rxbsTr8MiKwkereb5cAECm+mohK6EBpEkD6mLJv2CcHIEA33
         c2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682544507; x=1685136507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csnG/aChZgPBgsRf67ljm6apadApqU0JoShp+C1rCfY=;
        b=Mt2d7mHzNrsL6B+j7cXBw+mbEorQXfQAMfFP7wRz+EpEIFTcyzVJvL7Byp2iJ5degZ
         Me8JdaEvsPM3b070wkrzj8xyvy5e4uYQPCB1fpiIHOiXCBGWRzCIJ2np/xoGt9c5iC2y
         EFl9Ut7DbphNih37zu1WwJskHnHyr83bNQXXJZIgqg3jp4lH0yuIPIKV2mT36sDwEq/2
         SNgRSwD+l2kCDkyb5aXtMElQlIvqmc2ogT6tIBVWI3CDOizODhg+N7RfxwGAGC/yCCOh
         3SmfDz/QAU6q7TRB0v0VUYGkYVbfpJRMkOVLV+xMgFONyBaxc8c36Q2WWE2W3W9Rn3VI
         o4vA==
X-Gm-Message-State: AAQBX9dJUXH/JxzYUvc4eXUn+Cg1H67qn6suFft+3uuzIsfbBI1iJhS0
        pltOnk7egpQPrHUdYKbv56fjPcRBdKvbui88nkM=
X-Google-Smtp-Source: AKy350Y+eCrQTpMQt+hqdrQAnZo/eYVzzSodJwnQ6aWkIJSJZbmPk9uwTZd8uxZw/2DbyxvfCZFTkQvspxyn9uKJDQA=
X-Received: by 2002:a81:5e43:0:b0:555:ac76:a880 with SMTP id
 s64-20020a815e43000000b00555ac76a880mr15308726ywb.1.1682544507411; Wed, 26
 Apr 2023 14:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72nm-tWGPHMaNF11baVRDFpk8ruvTAVDEWKfraEzADWqQQ@mail.gmail.com>
 <20230426204923.16195-1-amiculas@cisco.com> <4b8e3c30-9626-dffd-0aff-4b5c650154ad@gmail.com>
 <CAPDJoNuX17h0=F7VRP=-VODG1bcdCYZAD+WNSofvpWPwwvbxMg@mail.gmail.com>
In-Reply-To: <CAPDJoNuX17h0=F7VRP=-VODG1bcdCYZAD+WNSofvpWPwwvbxMg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Apr 2023 23:28:16 +0200
Message-ID: <CANiq72nX9uHanKZ4at80O3p-c2S8WM4SCRGF3f=PHdO3itEZUA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: helpers: sort includes alphabetically in rust/helpers.c
To:     Ariel Miculas <ariel.miculas@gmail.com>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Ariel Miculas <amiculas@cisco.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:04=E2=80=AFPM Ariel Miculas <ariel.miculas@gmail=
.com> wrote:
>
> This is the format I see in https://docs.kernel.org/process/5.Posting.htm=
l#
> ```
> Link: https://example.com/somewhere.html  optional-other-stuff
> ```
> And looking briefly through the git log I see the simple `Link:
> www.example.com` format.

Indeed, the one you have in the commit is the right one :)

There are 5 commits in the kernel with the format mentioned by Martin,
but they were probably unintentional.

Cheers,
Miguel
