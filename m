Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601FD6F8893
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjEESWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjEESWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:22:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0064A1385C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:22:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965fc25f009so77950166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683310948; x=1685902948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niEyfzemTkaSRMh1nlyeJEnYlz7/sxOKWncwH1LouFI=;
        b=NCnL5UD8Ga+om3tqFsVPg6ntFsZvE6IBTNqNT1MC05W5bdcn0gpY0bxjeL8h5PNOev
         C8HeLGjnhc1gzl4qFzyBU/T05lsuUo+Xj1Ujx2PeM/9umb/y12tFEIhoDkXaBeGWP9JX
         Esl+5lmeG6LO/kaWq1SLEX4gA2c089nnTNfd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683310948; x=1685902948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niEyfzemTkaSRMh1nlyeJEnYlz7/sxOKWncwH1LouFI=;
        b=J3dW3Fczd32nxGY3LLmodIC0ViWDtiHOf+ylJ/q5Jd6F6e3b1xoA/f06LnpB1nQD5q
         1N/UcaboPfOdce1nH8Y7lh2FObxRcp7/5OaCd51Ar0DD1LUAS+9MNj5a/xvRY4WESsGX
         A7pqV4VtsRhl1OsMVcj1n9b5D6DenU7XIgQso/nvjse/u3+xmL1qcaI9LRfm/28qeW/P
         dwPB/rTG+6jXuN9HrPYRvbbiltQbl4kdKpaJ53EwySGX/HbcW61c2/qanQipogftF4UA
         CjN1rVm4e08EoiIWr5mQrK3Dz7KXN6JfH1tRUajzvQM31AkiS/uyBJEqrKG54D4iGC67
         xxjQ==
X-Gm-Message-State: AC+VfDzED2jIsyWG9Q4VYvL5yTNTPzsxrEDCPChLwV4Ef2rWVOGyZT3J
        63KlDKvJFaql9TDmX++d7h7/aCLk7aJWggJ++P83/w==
X-Google-Smtp-Source: ACHHUZ4BfdCKPhL8n4EPQ6ci/99mWPc5QXk9B7zs2DpagAytl8UZcka46IAo/QFURvmLhiiKFVAQ+Q==
X-Received: by 2002:a17:907:3f17:b0:94a:474a:4dd7 with SMTP id hq23-20020a1709073f1700b0094a474a4dd7mr2316586ejc.60.1683310948251;
        Fri, 05 May 2023 11:22:28 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id n19-20020a17090625d300b0094a82a236cbsm1234868ejb.129.2023.05.05.11.22.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 11:22:26 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-95f4c5cb755so372817566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:22:26 -0700 (PDT)
X-Received: by 2002:a17:907:720f:b0:933:1134:be1e with SMTP id
 dr15-20020a170907720f00b009331134be1emr2160145ejc.53.1683310946183; Fri, 05
 May 2023 11:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com> <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
In-Reply-To: <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 11:22:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
Message-ID: <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     nicolas.dichtel@6wind.com, Christian Brauner <brauner@kernel.org>
Cc:     Mike Christie <michael.christie@oracle.com>, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        ebiederm@xmission.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
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

On Fri, May 5, 2023 at 6:40=E2=80=AFAM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Is this an intended behavior?
> This breaks some of our scripts.

It doesn't just break your scripts (which counts as a regression), I
think it's really wrong.

The worker threads should show up as threads of the thing that started
them, not as processes.

So they should show up in 'ps' only when one of the "show threads" flag is =
set.

But I suspect the fix is trivial:  the virtio code should likely use
CLONE_THREAD for the copy_process() it does.

It should look more like "create_io_thread()" than "copy_process()", I thin=
k.

For example, do virtio worker threads really want their own signals
and files? That sounds wrong. create_io_thread() uses all of

 CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_IO

to share much more of the context with the process it is actually run withi=
n.

Christian? Mike?

                Linus
