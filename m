Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C56FFC7B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbjEKWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjEKWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:00:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DFA1FD7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:00:46 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3ef34c49cb9so872381cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683842446; x=1686434446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEnuBFRoeoCUMFkZqOok9vk168rBBPu1XkXprJKNlqs=;
        b=EuTOAJASK3+B5vjp1G5fp4oCLaqBqstFV5xmxZMlYUxLY4Y9iaOjEZaaBdlcUMJoyK
         Rxd9ZhJUgNmNCOYrDQmB/rYzrmzr599ZoTdKdi4lM/nJcZiqeJCLmtMVItEvr8pzShjd
         cla+UzOFyahonvzdiuuSkFkC8Vkz05yeAaUxWrG+89kfFDk4aSrMQsUZ1QrLVOcVN9Hn
         RzCX8FwrGWSCvxWJw5Mu9LPk1XnDDAWiuuUFh5udKk4tTKqIeN+c+H4k0vSrR42I7UIF
         g0M3HzoMVLzfJtHxpGrMdDQIESwD2veYvVSOu3Ex2qW5Kg+wC8Pfpyy8yjTV67vSS5Ro
         XMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842446; x=1686434446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEnuBFRoeoCUMFkZqOok9vk168rBBPu1XkXprJKNlqs=;
        b=SrP7FbKvwV4M69D8n4MyY8niTsmqJhUoFd+lAU5oefr7R+e16YML3QRDSq7mdaGZaj
         NyvWI6QQiNwjrdalw+TgxKAVrTCnnxwAauvK2zIdXHHZOTK7fd+bqZLn/wPQT9wTeYJa
         tJn2eNVWx/p96PKnQDLMP5eEg3Bf8hG80QtFoGLAK1PaJ2oVtwhMbpdrJEBBxswS7Fep
         FvRV7w1i9Z+M1QUoOnsKwvXAh5HPeAaUKiq7kO1Z2PjVbRLo41tJONBiCe9woKb4k8wu
         LrOI/qM0K2yh0wc6/QPYH8wwVYUBi+qYLOCHh4xd5JnNv5uK8uSmNJoTd/lTRfUEYcKJ
         CHsA==
X-Gm-Message-State: AC+VfDz4/Vcj1EGOpEYoteOf+6+oD8HGIz91D4gJsFwFQLmpjdG0g2WQ
        t5NRdVT0ArHO2iSuAnBZOgZlawrQAG5o4RJ7kuN3Bg==
X-Google-Smtp-Source: ACHHUZ76UIMQRNxt62E19OmIL/umDvVX387jn2iloTd079HNSRy91xM1m1n4PpSK9EnBriiaEHnVjYd84JhsYIBiHUs=
X-Received: by 2002:a05:622a:11cd:b0:3ef:19fe:230d with SMTP id
 n13-20020a05622a11cd00b003ef19fe230dmr5923qtk.17.1683842445770; Thu, 11 May
 2023 15:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
In-Reply-To: <20230511182426.1898675-1-axelrasmussen@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 11 May 2023 15:00:09 -0700
Message-ID: <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:24=E2=80=AFAM Axel Rasmussen
<axelrasmussen@google.com> wrote:
>
> So the basic way to use this new feature is:
>
> - On the new host, the guest's memory is registered with userfaultfd, in
>   either MISSING or MINOR mode (doesn't really matter for this purpose).
> - On any first access, we get a userfaultfd event. At this point we can
>   communicate with the old host to find out if the page was poisoned.
> - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marker
>   so any future accesses will SIGBUS. Because the pte is now "present",
>   future accesses won't generate more userfaultfd events, they'll just
>   SIGBUS directly.

I want to clarify the SIGBUS mechanism here when KVM is involved,
keeping in mind that we need to be able to inject an MCE into the
guest for this to be useful.

1. vCPU gets an EPT violation --> KVM attempts GUP.
2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS.
3. KVM finds that GUP failed and returns -EFAULT.

This is different than if GUP found poison, in which case KVM will
actually queue up a SIGBUS *containing the address of the fault*, and
userspace can use it to inject an appropriate MCE into the guest. With
UFFDIO_SIGBUS, we are missing the address!

I see three options:
1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I think
this is pointless.
2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have a
UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SIGBUS
instead of VM_FAULT_RETRY. We will keep getting userfaults on repeated
accesses, just like how we get repeated signals for real poison.
3. Use this in conjunction with the additional KVM EFAULT info that
Anish proposed (the first part of [1]).

I think option 3 is fine. :)

[1]: https://lore.kernel.org/kvm/20230412213510.1220557-1-amoorthy@google.c=
om/


- James
