Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B0E6956C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBNCjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBNCjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:39:21 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4D126FF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 18:38:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a3so2734108ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 18:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9roXr1MNKieEkfDYKCLMeMwvOQh6WqRC1DycfOcxMew=;
        b=xN5cF6A+pG2cWMwdWRCz9BTn9dBJYTD1UcD65+Kr0rOKbQptVJAAc9fgkH8JluA0pE
         86/gWvRbJumAGY8BoL281ZzqJar4ThVkARPWxED17QOoo1bl4a0h6viFMuElBg6QJ8SS
         HeYVdcARPq+M0+fHp2PKVNj4YBNkrETmNXem0KWM1d/AZj+b2vFM/4s5EUWxUmB8b+kA
         ufq4HXkXxQIVVbyh65lZ8TSMB5MT7mBDWR8U3856OOlyTwPtaZr/6iEmmJXCPakHscsN
         a/RYaaL3FKWnJgV+hfO9FZOh+ppvh/X9pMR2KLgE5kdoGjrJIdSEZagpLI1TlW4L3SEP
         IS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9roXr1MNKieEkfDYKCLMeMwvOQh6WqRC1DycfOcxMew=;
        b=cZj0Ur/EOUmhpVBUuMldsPev16/vabhKKawbvCI8wpjZh3pPNjlNxJ+zIdXiNNO9dQ
         tkRN/yFFcbuqUvwNTqstNQFpSz6HQkzl5he/YcLmD4fb/gbOVdnVw/nhrIq4y1cPe0ti
         ZHb5vK9x+kyc2nXRl6kT8IO1gou8njdiRFu40K/mStRE7L79SPUpHoXzr4/F7zxGyomR
         /pBIRsGtF39X8uYLaF5at9b2es2p6IKpM1rFwdg5gAZKBVRhRkl0Qv2HWM4cWAwllmn6
         9BY26uy3F2K++MGUEkl+dEZ7lGVo9KqRVniIbm/QPEheA0hs2HGoo+HFuYEJI15l90fJ
         JlJQ==
X-Gm-Message-State: AO0yUKXGeqqfIM7mKl22j2O96KA/WnVEkZXKC3J6mXxGEdbjSZ2FEPKD
        bCvJ7PIrjolKa9T4jOJq9htUlMs0gb09eqO5uQrJtPpYy1vx
X-Google-Smtp-Source: AK7set8emikUsd58cC7yseAKI8EJoyfzeKk4rky+xvAbB46z+TZOwyovOcrIQN8yjgqTBuXlEYomyLUOZJMvBlQZd7k=
X-Received: by 2002:a17:906:2b4b:b0:8a6:5720:9104 with SMTP id
 b11-20020a1709062b4b00b008a657209104mr546257ejg.1.1676342333755; Mon, 13 Feb
 2023 18:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org> <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
 <20230127032039-mutt-send-email-mst@kernel.org> <CACycT3u=vULuZ9-ZakBjxmbu88iUb+xB2mHJUnHA_8SuUV7H4w@mail.gmail.com>
 <20230213065116-mutt-send-email-mst@kernel.org> <CACycT3uY1dfP=5d1go+POh7-J1tUMW+9RXi92KtcFJYMzq-bOQ@mail.gmail.com>
 <87a61htn0n.ffs@tglx>
In-Reply-To: <87a61htn0n.ffs@tglx>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 14 Feb 2023 10:38:42 +0800
Message-ID: <CACycT3u9PmX47vOviVvXAx-ihG450i8y=uC8KZX3sRh9ywHF-w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export irq_create_affinity_masks()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 2:54 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Feb 13 2023 at 22:50, Yongji Xie wrote:
> > On Mon, Feb 13, 2023 at 8:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > I can try to split irq_create_affinity_masks() into a common part and
> > an irq specific part, and move the common part to a common dir such as
> > /lib and export it. Then we can use the common part to build a new API
> > for usage.
>
>   https://lore.kernel.org/all/20221227022905.352674-1-ming.lei@redhat.com/
>

Thanks for the kind reminder! I will rebase my patchset on it.

Thanks,
Yongji
