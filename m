Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167467037EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbjEORZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbjEORYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:24:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692FA44B6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:23:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so113867187a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684171428; x=1686763428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd5dtKhNyHGq8Bf62oHV9wGTTQyA1cr8VVarKwpvWbY=;
        b=LiB1RmWlVjbSC9updoKbDubFk2hRTMu5fWK9nFdGOC2bIV94IUONKiMs5YLbZ9oOcb
         vwp464Cwlqlnxr109HBT4O00CW/DEpRI73sJShezDBXMWfudyF3CCIHxsOL5ivEN9/0E
         iCmyjiogLziGaVjJ6Dkff7vCpSYvWySsTGX94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684171428; x=1686763428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd5dtKhNyHGq8Bf62oHV9wGTTQyA1cr8VVarKwpvWbY=;
        b=a8i2paNslBu2ve+VzJ7eAeTDJZXsLroE3urgidwwsuEWOrQiLZchb3zUN6r5cPtreV
         2YCbeM2Ec8zrMzgsx3YxWFWZ2EUEDQHQc40AkTSAPIWLSLPRr/o1NNw4ettLWIPbB13f
         OASLBpjWURJiFK4liSUgTsIr9TJ8EoVkKls/1oGvv4bAl3uskuNZW4nBD/diJnadTn5E
         R5XI8QwjIG/VI/sEzZeWjdBDS0gzKG5t1sqRGzrigBA6r/g0HLTPYOgf5DJEnlq4X+Ae
         1ioczdT9ZygME9tmyPTFQdSyJG8PwzKd0X9SDGCm2nsPMVATE057V54rKpsyv/fXvvUd
         EGfg==
X-Gm-Message-State: AC+VfDwDsQ72OH1LCMm4FTQQoQbF0cF3ptUwDpO+GhP8iABAVFQH1IVA
        APHdORpOF6BVQA8mcEAQdrLybdiaeV7DFchKmf7B5zn1
X-Google-Smtp-Source: ACHHUZ5Q22RPSe/CTlKN1cW9Lqn9EOwyIZk3BIlEHQax7fgTUicWztkqMoRfbxFBY4CWdvHMptEx4w==
X-Received: by 2002:a17:907:da4:b0:966:4e4c:a36d with SMTP id go36-20020a1709070da400b009664e4ca36dmr22915127ejc.20.1684171427711;
        Mon, 15 May 2023 10:23:47 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906725100b0096a6bf89259sm6387729ejk.167.2023.05.15.10.23.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 10:23:46 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so113739351a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:23:46 -0700 (PDT)
X-Received: by 2002:a17:907:6e11:b0:96a:2210:7dd8 with SMTP id
 sd17-20020a1709076e1100b0096a22107dd8mr16414147ejc.38.1684171426288; Mon, 15
 May 2023 10:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com> <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com> <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner> <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk> <CAHk-=wiDqe+H7UnhD0qLbL8K8hnWUEdsRqcM4QnY=gZ3GytBRQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiDqe+H7UnhD0qLbL8K8hnWUEdsRqcM4QnY=gZ3GytBRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 May 2023 10:23:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjudDcq+TSaxOVX03iMTAhBDf6fup-tDhDpdQjGnKXgTw@mail.gmail.com>
Message-ID: <CAHk-=wjudDcq+TSaxOVX03iMTAhBDf6fup-tDhDpdQjGnKXgTw@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Mike Christie <michael.christie@oracle.com>,
        nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
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

On Mon, May 15, 2023 at 8:54=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Blush. I decided to build-test it, and then forgot to attach it. Here.

Btw, if this tests out good and we end up doing this, I think we
should also just rename that '.ignore_signals' bitfield to
'.block_signals' to actually match what it does.

But that's an entirely cosmetic thing just to clarify things. The
patch would look almost identical, apart from the new name (and the
small additional parts to rename the two existing users that weren't
touched by that patch - the header file and the vhost use-case).

                   Linus
