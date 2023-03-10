Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F086B4E55
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjCJRRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCJRRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:17:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D9C8083
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:17:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cy23so23203088edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678468665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4L/SHZyks/7guh4hx9DHAjGFq4iwVKD1iq8DrmoyKQ=;
        b=EEl4Ll2WkH5nHGXz993/iZ4ibdZMQTPlCvxlMLKiooYmq8BUrGBb4QaN3YR1fcz5KS
         ohEApwDYRrdFLp8wouqaIEY5NxlriuIKxRmu1/fDuTM/PT9/pS3oCYjtAWloHgVUXZ+d
         +pOJfKvM8/pNRV7qQEUeJLnR9APruwvt9jW1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4L/SHZyks/7guh4hx9DHAjGFq4iwVKD1iq8DrmoyKQ=;
        b=KbwMWcnncmCMXVfeOgNkCfQY47fbn/NGe2jZ+Csogsx1woqTktAhRQA0HJr1jEK+mQ
         n3P3ZuuBXJ3jkJ4MeHBaNLW83ksUXfoKwldtuEb6NVpxGALzYdRBGst3kgFdDsgxMS8C
         l4mVb07gKnk+lRPknDmhwOvrgqm1RXZFFColHICYyNybImwzlrstOumEGY9QLQuTh2c8
         Up7Jdr/mNmFLPF7/AQ8loZWRWFeT23sDQqGdycB8L52w8tO6bl1Xyi+ZMU1EIKsi9UuS
         oJZXqG16aWVz3E2NS2VkU6GLLL9BXnlMTFiuv5ERb9GD8PAQU4tOCqO/ilv2t/IkAar/
         66jQ==
X-Gm-Message-State: AO0yUKXPpYxQ6Tw/t2wuoaRG42f/Ec/FK0zbdyBeKWqnX5TuVJPR6YgZ
        QQWHrHItHS6tTlp9R/1iIXapU2yzDJ6a8e4JhsUMaQ==
X-Google-Smtp-Source: AK7set+n8ZemMQ65BjYj8cA3K4w7jCcT1YfQgWwMSACjShTA83tvJq6spxV1k9afsiwpFpmaDrL08g==
X-Received: by 2002:a17:906:444d:b0:87b:dac1:bbe6 with SMTP id i13-20020a170906444d00b0087bdac1bbe6mr25037034ejp.36.1678468664946;
        Fri, 10 Mar 2023 09:17:44 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906824d00b0091d9b634abcsm116357ejx.27.2023.03.10.09.17.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 09:17:44 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id k10so23214963edk.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:17:44 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr13458233eju.0.1678468663895; Fri, 10
 Mar 2023 09:17:43 -0800 (PST)
MIME-Version: 1.0
References: <1115586887.187161.1677658022188.JavaMail.zimbra@nod.at> <CAFr9PXktRBm66vgVjOnwTeucBD36OuPjDVNd9cH1F8u0nesKrA@mail.gmail.com>
In-Reply-To: <CAFr9PXktRBm66vgVjOnwTeucBD36OuPjDVNd9cH1F8u0nesKrA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Mar 2023 09:17:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi29bbBNh3RqJKu3PxzpjDN5D5K17gEVtXrb7-6bfrnMQ@mail.gmail.com>
Message-ID: <CAHk-=wi29bbBNh3RqJKu3PxzpjDN5D5K17gEVtXrb7-6bfrnMQ@mail.gmail.com>
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS updates for v6.3-rc1
To:     Daniel Palmer <daniel@0x0f.com>, Christoph Hellwig <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 4:19=E2=80=AFAM Daniel Palmer <daniel@0x0f.com> wro=
te:
>
> > Christoph Hellwig (1):
> >       ubi: block: set BLK_MQ_F_BLOCKING
>
> This seems to be causing one of my machines to lock up during boot.
> It's using a squashfs root that is on a ubiblock that is located on an SP=
I NAND.

Hmm. That commit 91cc8fbcc8c7 ("ubi: block: set BLK_MQ_F_BLOCKING") is odd.

Christoph - you removed the

        blk_mq_start_request(req);
        ...
        blk_mq_end_request(req, errno_to_blk_status(ret));

from the workqueue function, but while you added the
blk_mq_start_request() into ubiblock_read(), the 'end_request()' is
missing.

So I suspect the IO has completed, but the change means that nobody
was informed about said completion, so now trying to mount an ext4
filesystem on it hangs on the read.

But I don't actually know this code, that was just from looking at the
commit that breaks.

Christoph? Daniel used your infradead address, I don't know if it all
goes into the same pile, but let's use your regular one. And I can't
see Daniel's message on lore.kernel.org at all, for whatever reason,

                  Linus
