Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20945612428
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJ2PXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJ2PXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 11:23:49 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17B51A0D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 08:23:48 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g127so653113ybg.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CXZNIY33Oy/b65bA20sLIyXzpuCYBJL0LJKU7I6qqcM=;
        b=IpJQWckeZaaen4F+DQtTPx4i4RX3sea5KHp/WfJ3dTkxQBT1R1OrvScgSiDzUYhf2y
         tm+hn5qAn9BY5FmvmiKxtGRze4xe3lWPidv34pKSbDdmLNSbsoksGVbmJAnKuQZvZw7v
         N+dOnOaCQ8sdZwI4SjqU31ZNBl68KNd5MVKpy7sN99lAqFi7gtieVajp2tqRiWAml52z
         1vOfIoEUC3ZzXokryYTRizEF2hCXKL6uRh6WArCwsd8zj0bikSSKZrD70N/dXd7XxopU
         NxVDb4/MaGNShyd1ISGJ1HncoreemByarYr5KWrrhpXuZFrWS0K55Wh/M3G8MTWEMZfS
         NWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXZNIY33Oy/b65bA20sLIyXzpuCYBJL0LJKU7I6qqcM=;
        b=3q+EhL/JV62qSlJqANHT3dsO6Zv01yuY8Ob25Di1flan4GJms8sXAEFC8RiB+SQQir
         Qgba9+TIkZLetw8f+/omZ8NfJdUQbAR78+6TZ8hTaAslNmhkepAJYLxTMga2yNMZ0soU
         4bu1U92yENAaV3tZHDXpD+52dLXfAZHuSCcfDIppTkFGjfsYhcWRvInj22u9NBLj26Nz
         wHGj0A2CHTjNM5eVQIB8t1oKSvLV1rG7eP40AnhiGmZWR3pB0n6m4xUWZjBSbP8BLhg/
         iQ7sYgr05IpE3HjRx5DNUpu5v5LCMW97wAT3unJwyVMcbSSIcOFfY0uOMIP0QCLRouXc
         PNBg==
X-Gm-Message-State: ACrzQf2plBHl7ls59fgmAWVoVZv3q6BJa/Wix5pGXuI+KUhhdYuDfXQv
        TQIcHaORNbKqfq+uLk0KCOPQfZrTiqv1kqgvp4xyDQ==
X-Google-Smtp-Source: AMsMyM4vGE+o1v/zxoLCmhzipagPc95qNyQCdi20jOgA0mTbrubAB9q3KUAT7HY0DXA3us3FIRnhTBFwSBwQbZ4u/zc=
X-Received: by 2002:a25:3187:0:b0:6c1:822b:eab1 with SMTP id
 x129-20020a253187000000b006c1822beab1mr4055272ybx.427.1667057027707; Sat, 29
 Oct 2022 08:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221029130957.1292060-1-imagedong@tencent.com> <20221029130957.1292060-3-imagedong@tencent.com>
In-Reply-To: <20221029130957.1292060-3-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 29 Oct 2022 08:23:36 -0700
Message-ID: <CANn89i+mK2VG2VnxPduSREHp70gJLP7oNp3SUoMW-YaSd7jJRA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] net: tcp: add 'drop_reason' field to struct tcp_skb_cb
To:     menglong8.dong@gmail.com
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, imagedong@tencent.com,
        kafai@fb.com, asml.silence@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 6:11 AM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> Because of the long call chain on processing skb in TCP protocol, it's
> hard to pass the drop reason to the code where the skb is freed.
>
> Therefore, we can store the drop reason to skb->cb, and pass it to
> kfree_skb_reason(). I'm lucky, the struct tcp_skb_cb still has 4 bytes
> spare space for this purpose.

No, we have needs for this space for future use.

skb->cb[] purpose is to store semi-permanent info, for skbs that stay
in a queue.

Here, you need a state stored only in the context of the current context.
Stack variables are better.
