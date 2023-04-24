Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC06ED75A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjDXWBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjDXWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:01:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763FC5FDB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:01:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f7a0818aeso735684966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682373663; x=1684965663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jX4WyMbkislXBcF9DSsfnsysTOqMW0k3Anz9dgRCQ8=;
        b=OSWsanieDlZtpPTwLKcgFCfVKxsI84hwL2UluNI+Xrh6Q/YJZRM+yvu5FuVJTSuYDy
         K//TLrT75hFSA354IpKdr6MYkjq15PD/8q0iK78ebVLzeBiMzeFFftdgc/81CvlI46Cq
         CB1mUpGxn22k5b0C2GQRLIVKu91UBCLvpqEf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682373663; x=1684965663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jX4WyMbkislXBcF9DSsfnsysTOqMW0k3Anz9dgRCQ8=;
        b=CYwWmFhr4Efnori9NtuW0uSBFzb9nQXqsnbh3SO4JSQR8GPq+qEfurE+ZFadRWjW5F
         5cmw/8iNxXkkbj7Dy75flC2jz8bbSkAe+ZX8UQal1KbDGrVP1c0ELDCNc96/BAWNXbak
         W73mMvGugtA/JgABTQ5akb51uH5Ukp55QvhYQMgF5p6uirBQMk1fAPAtCo+cYvLDuphj
         lQAirygDTJ+QdxdN1pWtRW7I9usl9JMFTZbJGCygMTfHAfuATj7PhvXOkT4Ki6Sxk/cG
         VZLl6weQkt/3znbfWr8ZHFcce2fpHZbfXHCoW/Q/0sMg2KJjQ8X9bpXGlKyqQly7BNPh
         y8VA==
X-Gm-Message-State: AAQBX9dp9I5QXWz9kq6wX1Z38TGItNmS1iWTFcCBFvTTNGbSxCLv626W
        51UrYdoTCKi0O5x2jXc7HPIJuEVRrDipu/8UpfGbcrU1
X-Google-Smtp-Source: AKy350b8Nh4VSjxawyjUr0kz8K0Rxo6lMmm9mDE6ooOFoXe2jzeNIUfeXCEFMWF1z9s6cKMjN4DSZQ==
X-Received: by 2002:a17:906:3f91:b0:953:7e12:838a with SMTP id b17-20020a1709063f9100b009537e12838amr9913242ejj.67.1682373663607;
        Mon, 24 Apr 2023 15:01:03 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id hq32-20020a1709073f2000b0094f206b97e8sm5968614ejc.130.2023.04.24.15.01.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 15:01:02 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso7515477a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:01:02 -0700 (PDT)
X-Received: by 2002:aa7:d887:0:b0:4fa:4a27:adba with SMTP id
 u7-20020aa7d887000000b004fa4a27adbamr14146345edq.22.1682373662196; Mon, 24
 Apr 2023 15:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk> <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <ae8ee8f3-9960-1fd9-5471-433acacb6521@kernel.dk>
In-Reply-To: <ae8ee8f3-9960-1fd9-5471-433acacb6521@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 15:00:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ+S79vjAJf92TE8PqCie4xZPAhRgVchHnPesVHZPO0g@mail.gmail.com>
Message-ID: <CAHk-=wiQ+S79vjAJf92TE8PqCie4xZPAhRgVchHnPesVHZPO0g@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Apr 24, 2023 at 2:55=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> I took another look at this, and the main issue is in fact splice
> confirming buffers. So I do think that we can make this work by simply
> having the non-block nature of it being passed down the ->confirm()
> callback as that's the one that'll be waiting for IO. If we have that,
> then we can disregard the pipe locking as we won't be holding it over
> IO.

Ok, that part looks fine to me.

The pipe_buf_confirm() part of the series I don't find problematic,
it's really conditional locking that I absolutely detest and has
always been a sign of problems elsewhere.

             Linus
