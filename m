Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847336C51EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjCVRIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjCVRIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:08:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDF1E05A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:08:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so75868032edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679504884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ/qCKKtUwESl9xaaIjrhAfZQFyi97d2S+2qUwoE1zg=;
        b=Go9/j6vKoTDC/5mGgK/GUACxfIb88fOUkCayKBiNWp3zp6iZe+SKsmjQ4s9pP4pxVa
         CUQDs/JHWzfgytlKYJGLt7s64MUutg2O0rgiYtj9CZeasnwndA8GB1FdYj6BTsIkg/d8
         30LeOw5gx1dGhJVAHH2iXerHBorpyA2+2m2wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ/qCKKtUwESl9xaaIjrhAfZQFyi97d2S+2qUwoE1zg=;
        b=Hzf78bSuaOzv2rrEVifJPm0O69hgBqxifvraU5QmDYjoR0VM8yuCOvMdP/gR7wYU0C
         hEI16u6xzLpPHJcKIzfoN94QcJ3kdban61z1kvzXF85YIf3y+uxvkEoUgYTtJRvap3d9
         YPVGACeOORqaabpGMjhdHzxfTi7R5pPyEwN9VNSEIN0YdzwnWCjaxVbJTwLMkS5G9zgw
         GsWz3zUO/QjMF2Qme4ozlymAc7J6ZUC+IKvn/AWUs8WQmmdAPvozSdquD/vSbbYT8F84
         1ADf4kOnEB0KZsrsfCw2ksU5EkmvdDBIUltM79BSflQvfnW1lTQIVgT/6UQSgCBstH7m
         6idA==
X-Gm-Message-State: AO0yUKW27A1jViLBGoZy9kkPfeD1c5aIWemddBS72T+afgobu/ANMAD2
        bT6s5f0F589sLKyhT9mn2GJT/GdRCw0nmWgjTre1YVOG
X-Google-Smtp-Source: AK7set8jrCIP2mDSRdp9DaixxwSstXbkK8J2iB4CV5umHkcHM0vpqqLqSGU4yTbjw/wRBMs9aWimLQ==
X-Received: by 2002:a17:906:395:b0:8b1:781d:f9a4 with SMTP id b21-20020a170906039500b008b1781df9a4mr7332785eja.21.1679504884442;
        Wed, 22 Mar 2023 10:08:04 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id kb1-20020a1709070f8100b00933c4a25735sm4827773ejc.100.2023.03.22.10.08.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:08:03 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id eg48so75675530edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:08:03 -0700 (PDT)
X-Received: by 2002:a17:906:344d:b0:933:7658:8b44 with SMTP id
 d13-20020a170906344d00b0093376588b44mr3561499ejb.15.1679504883222; Wed, 22
 Mar 2023 10:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
 <20230321142413.6mlowi5u6ewecodx@wittgenstein> <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
 <CAHk-=wi2mLKn6U7_aXMtP46TVSY6MTHv+ff-+xVFJbO914o65A@mail.gmail.com>
 <20230321201632.o2wiz5gk7cz36rn3@wittgenstein> <CAHk-=wg2nJ3Z8x-nDGi9iCJvDCgbhpN+qnZt6V1JPnHqxX2fhQ@mail.gmail.com>
 <20230322101710.6rziolp4sqooqfwq@wittgenstein>
In-Reply-To: <20230322101710.6rziolp4sqooqfwq@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Mar 2023 10:07:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+VuPWUtCa=s7jmkqjMOvGbn=Q-KT-8YXdOLxFAPKiPQ@mail.gmail.com>
Message-ID: <CAHk-=wh+VuPWUtCa=s7jmkqjMOvGbn=Q-KT-8YXdOLxFAPKiPQ@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Christian Brauner <brauner@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 3:17=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> I don't feel strongly about this either and your points are valid. So I
> incorporated that and updated the comments in the code. In case you'd lik=
e to
> take another look I've now put this up at:

Ack, LGTM.

               Linus
