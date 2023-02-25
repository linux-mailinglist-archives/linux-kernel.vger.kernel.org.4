Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687C76A2B86
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBYTnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBYTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:42:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83309A258
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:42:57 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d30so10373305eda.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ06yesyUgRY5DSL1h615Nm6fkq1Vhy1HsTju3YI3UI=;
        b=ZxiqbkUqEBDW1KNccJkKK7LUehWcaHJqIx3XuFbnY0uj4GN7vGXNoMgM5/cavjr+eG
         S2Kis6MUPpPXHH77SUCKr0RJ+zmzrUB7pGcj7cYvyAVN8DMoK0njiV/r8E4ayS2IIvv3
         BpeF5BTztR59OOV/oLZdOZU6cfSr1Q6W0MNXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQ06yesyUgRY5DSL1h615Nm6fkq1Vhy1HsTju3YI3UI=;
        b=Pkdjw8cr2TD3y7lS1kFbRsNmkaB8OF/I7iH0INKxQdfradMVpwlyCn8R48iazlmiTd
         oFa2lHCfd6wnCrgPg4HGMa+rR6iNI8T42yrHREvM/oNDJIHT4QAcjp8SPmzt/4pL7xBe
         RgvHZgEUImrHzoqP8BSarglBuZHjfBCHCX3UqDpGQG8Mhbhzbrrimzrx4uTHo7QyBQoK
         534lg02USDY/dEs/P/i/Xkh1NHaSo4NuuFyQ+PKIG8CPuo9QEcexlkTkYe6iYU2jPimy
         p9VYv9nfVwquusNS3k+tgd3dz8rhCM4z90+hphV/eYaSjAZdTQKNQ8/BaP/FVdjsxgsZ
         5BLw==
X-Gm-Message-State: AO0yUKVnkCdRHvLOSDgX4ybQsJD2GFvSEPIaAqwqGez+9c89fBSF2nHS
        X/wqywbNa1Fp7U7Cl9dMuw/F8Cvthz4VfXZVn33+KA==
X-Google-Smtp-Source: AK7set+qWJkO2qlM1TNErGz8jiCd120qzDk3BSzYZgSnaAnqhZkqPXWnn7GGKlpUSWgP/JnSHWTHFQ==
X-Received: by 2002:aa7:c404:0:b0:4ac:b4f3:b8a7 with SMTP id j4-20020aa7c404000000b004acb4f3b8a7mr18578428edq.7.1677354175566;
        Sat, 25 Feb 2023 11:42:55 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id k29-20020a508add000000b004ad1d58a6d0sm1202427edk.56.2023.02.25.11.42.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 11:42:54 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id ec43so10288183edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:42:54 -0800 (PST)
X-Received: by 2002:a17:907:60cd:b0:8f5:2e0e:6dc5 with SMTP id
 hv13-20020a17090760cd00b008f52e0e6dc5mr2490334ejc.0.1677354173776; Sat, 25
 Feb 2023 11:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20230220194045-mutt-send-email-mst@kernel.org> <20230223020356-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230223020356-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 11:42:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-az1yPKQmmDMnTMdUrg8hLzPUiUtUQu9d2EbdquBOnQ@mail.gmail.com>
Message-ID: <CAHk-=wg-az1yPKQmmDMnTMdUrg8hLzPUiUtUQu9d2EbdquBOnQ@mail.gmail.com>
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        almasrymina@google.com, alvaro.karsz@solid-run.com,
        anders.roxell@linaro.org, bagasdotme@gmail.com,
        bhelgaas@google.com, colin.i.king@gmail.com,
        dmitry.fomichev@wdc.com, elic@nvidia.com, eperezma@redhat.com,
        hch@lst.de, jasowang@redhat.com, kangjie.xu@linux.alibaba.com,
        leiyang@redhat.com, liming.wu@jaguarmicro.com,
        lingshan.zhu@intel.com, liubo03@inspur.com, lkft@linaro.org,
        mie@igel.co.jp, m.szyprowski@samsung.com,
        ricardo.canuelo@collabora.com, sammler@google.com,
        sebastien.boeuf@intel.com, sfr@canb.auug.org.au,
        si-wei.liu@oracle.com, stable@vger.kernel.org, stefanha@gmail.com,
        suwan.kim027@gmail.com, xuanzhuo@linux.alibaba.com,
        yangyingliang@huawei.com, zyytlz.wz@163.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 11:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Did I muck this one up?  Pls let me know and maybe I can fix it up
> before the merge window closes.

No much-ups, I've just been merging other things, and came back to
architectures updates and virtualization now, so it's next in my
queue.

           Linus
