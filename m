Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2512D703211
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbjEOQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbjEOQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:02:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C698F9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:02:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f139de8cefso66182697e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684166528; x=1686758528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgkXNey1qqkRYDn0ndFfina8YyIW2oFgV1/nBHyisSM=;
        b=L0mzWjPIfIXM4lY9pDFM6KcSPIwfsMmZiDUA8szt3u6/o0JzcAxopC9UPGIOU6jY0A
         ZXrfX2RvrYXwmAZV4U+lQc7JImALy/RifvwIPBcS4DoVwoqxF7dnXMwyKptjvB8NY41I
         MRXjxGr1Tlptfs8ZlSNOeKddWFX7GOyEOrrkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684166528; x=1686758528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgkXNey1qqkRYDn0ndFfina8YyIW2oFgV1/nBHyisSM=;
        b=Li/tIW6LExYiqlq+nExzojO5nCPPu1p/POzLNCcJgClEgFKvewkHmla/8iwjccHLDl
         StiggJFLAluQCDLfaP/fcUxDit71xRlHrzKhilZc3OQ4EEI9pkwCVOmCN2I9jeVquVxj
         vrRYRphn9JDBRQ128Ifnc+1IiPr/MEkMbg1XneKmvxtIwzELyDm/qba8uj/PlYRBpUVU
         6VkGc4Zv3ykMrOZoOQ1x2WQkMcP0uvuP4riXwiFy3jUaDKZGLlDNSPg7lkZdINLYfg81
         Vj1pGE8KlsVRgd+RKENn4rFtZkOhLl8xV/aOnSplCz9hskDeDc+aY8ckCBUbDZh7H00G
         N8yA==
X-Gm-Message-State: AC+VfDwMHEgMpZWIAqS/eB73qDRJZ8+vStNH93vd0L/K7TmV5jH0vB07
        cG5xFHP/PH7wLQ4jWvyK3R2ZEQCs6QNcY+1CcCi3EA==
X-Google-Smtp-Source: ACHHUZ6vEyp9oHN58fjVCTwjVYN4G+/OdaShozx4U/+VQUtrcDx1CK2NLLCG98918AQWWjyh+/E3jA==
X-Received: by 2002:ac2:5fee:0:b0:4f1:4898:d183 with SMTP id s14-20020ac25fee000000b004f14898d183mr6189515lfg.25.1684166527967;
        Mon, 15 May 2023 09:02:07 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t27-20020ac243bb000000b004f27d033994sm1251964lfl.267.2023.05.15.09.02.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:02:07 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f139de8cefso66182535e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:02:07 -0700 (PDT)
X-Received: by 2002:a17:907:97c4:b0:966:4669:7e8d with SMTP id
 js4-20020a17090797c400b0096646697e8dmr27235914ejc.16.1684166217079; Mon, 15
 May 2023 08:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com> <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com> <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner> <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk>
In-Reply-To: <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 May 2023 08:56:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmN7cxAgmhDBqiE=c67Q2pp2+SqCknNcj3K+QNKivaSg@mail.gmail.com>
Message-ID: <CAHk-=whmN7cxAgmhDBqiE=c67Q2pp2+SqCknNcj3K+QNKivaSg@mail.gmail.com>
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

On Mon, May 15, 2023 at 8:52=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> Only potential downside is that it does make file references more
> expensive for other syscalls, since you now have a shared file table.
> But probably not something to worry about here?

Would the vhost user worker user processes ever be otherwise single-threade=
d?

I'd *assume* that a vhost user is already doing its own threads. But
maybe that's a completely bogus assumption. I don't actually use any
of this, so...

Because you are obviously 100% right that if you're otherwise
single-threaded, then a CLONE_FILES kernel helper thread will cause
the extra cost for file descriptor lookup/free due to all the race
prevention.

                 Linus
