Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F017744C8E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 09:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGBHuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 03:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBHuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 03:50:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2BA10E6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 00:49:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso2707811a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688284179; x=1690876179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvxoQCcibS+AeU+E0ygHuM6m7OcRFNmks4L94pMdxYI=;
        b=ZtZXwH2MeGsjV8yFfBnJjWlbkQzmf4oSMr3YNv3pBErULIxGVXHyX3fa05xeDAaUcR
         FtoTrbYdH97gMy7NhtyE8jKvgcB1m+5PJkZ4pXFp36b0WrwMVW6GCTQcPyG4IlQXpqXQ
         H/ebOzOmkPiqEc0GPETYzScw6NtBD80CoFCeZsaEbxFyao3c8ckIcEa0TOig5Yem7olB
         ZcWNGsHW1+0NGnU8lRyK3+5ISROloHE8U32K27k2x/fwd5k1v7bGEMkA1AQWRJwFJDL/
         L+31h03h+9svZnYKFBNrm7BV89IrZm+nrmZcwQLIpy4JgKzUOM0XNEe/tCbIVfif9nfS
         gkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688284179; x=1690876179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvxoQCcibS+AeU+E0ygHuM6m7OcRFNmks4L94pMdxYI=;
        b=OZUXap7R+ORaoOEkrpnjQDr7yc/ZE3q7Dxfq1lPVJvDFZdDIPVKGXDIlNUwyHcVyz9
         wi+KNTJ8rzkkZLColUOnmCt6AYzTPtZNV9DgRWZJBsltShAXPjQcFjL5ptFNI+Ms83XI
         2iKJg0Zfh2Od85+wsqBu1r33YEotpdcoFCxBIZBmpzPxU3xsCk8Mpb8qizOzTvnFSAvv
         iey+26n0ERvKq0FFX/KVywD3dfgD/0AgRealK0WXUmBE5gLzNbiaq3kcJlx6fsmQhqHs
         TMSVtRw7h48hS0IajVJ1+Mph5ckP42l6iz5rOwnxW4E9FkPWBhOQwla1MQK68VzY4T6J
         PMlA==
X-Gm-Message-State: ABy/qLbZ/jmwQFr8jnyMdD2zzMRB/GZQEuHaLRb1s7Ze+/3AMlXEmQD8
        rrcfELW5etMFTLSI7SWCSV8U+Hv4Pxbf5HIRC65A
X-Google-Smtp-Source: APBJJlGufhzK/2ECRJBm7gDRrro6kXoBCSrchWDG2fH7jB9xtkPCg+JFTBP6i6pSVuIMpszBV7lZcb+qPuqMMarDNGE=
X-Received: by 2002:a05:6a20:8e14:b0:123:4ffe:4018 with SMTP id
 y20-20020a056a208e1400b001234ffe4018mr9366994pzj.60.1688284179674; Sun, 02
 Jul 2023 00:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com> <20230627113652.65283-2-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-2-maxime.coquelin@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sun, 2 Jul 2023 15:49:28 +0800
Message-ID: <CACycT3vvOaNcrigbaqbGKJM9KxKR3nGmOQRDUfd1e08+XDp1rA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vduse: validate block features only with block devices
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Marchand <david.marchand@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>, xuanzhuo@linux.alibaba.com,
        Eugenio Perez Martin <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 7:37=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch is preliminary work to enable network device
> type support to VDUSE.
>
> As VIRTIO_BLK_F_CONFIG_WCE shares the same value as
> VIRTIO_NET_F_HOST_TSO4, we need to restrict its check
> to Virtio-blk device type.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
