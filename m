Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005A46507A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiLSGjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLSGjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:39:47 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF56402
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:39:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id u19so19124060ejm.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zd1mHyRN65lmN5xV+vXr0Mw3jIgs5Oj3GSKs1eE1JMs=;
        b=JUQuTlyHEzYg1D7o0VriaNmZ+dS6TmeOSZE5kxXst33424NsZNB4GoVs7OrA9wplEU
         Drk3zFZllJsUFQGGO2/4SiFuCHeQYBa0jI2WJmTZFZLvuM13vCvOK6SWZSAZKnhxC7IC
         UTduNeUgBWllqu+fJb1FfN/CHgcH02y6hxvnp/5kJ1mUOeX/OM/H/p52GBWAg4NJL4H7
         aD+aLN37KitbevJHmaClz8wBAPIuXDg7pxpBNbjW6bNfPB3n9jUvEK03lj0K8HF3xPEY
         qmttpoXCb4I91oyCoX2JxbAIz5bbQ6aCq/AXFx2MV6eME2hyR53YHe+5iSTnpg5TzTNy
         EwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zd1mHyRN65lmN5xV+vXr0Mw3jIgs5Oj3GSKs1eE1JMs=;
        b=LTMX7z+4BzCV2LRDXo24T4fRYbckhBcDjP7prXEv8NSPXyVY8u2qgyJJNcuJj75KvQ
         pw6a9m6d/6lx5tC4Qj0Tjb5ysqx1Te8BgKoZEhpAbNtgEs/nDgeVuIawAORzzNOr8Kbb
         QZWLDahr/uNEoY3s0Y4byerHQca02BgM0GmsNHvOS15wfB4ycGI+Lm98OAzdnxwktBf7
         mtD89Q39vwGc9YaG/W5242HPdXg1NNcB7g412jKPKQ8HwXiXhnaijJrVPXxWrISJt5ZC
         g+5L/gWjyHRPljqswrdqohA+eP26TatTXd0Vi82pxXQ/h9c7jFPRdAX79Kf8FAzqRUWn
         nK6g==
X-Gm-Message-State: ANoB5pn0nThE/0fYuJG6ZF5bjjjBsumrjTlrx5qwx0z/OQADWCDsWcZ9
        6gQyTDHcKMPHXocyNAWgR1Vj8vft63h+H9y8vIU2
X-Google-Smtp-Source: AA0mqf6IvVU57fVD9DTwYYQAkrFuiEH0B89oSrd3NQNspl2r5Izkdk8Fd+W5ZHpOqmv9Y13s/g+JNKRKR/ZDVFzMMtk=
X-Received: by 2002:a17:906:4351:b0:78d:513d:f447 with SMTP id
 z17-20020a170906435100b0078d513df447mr73969432ejm.708.1671431960711; Sun, 18
 Dec 2022 22:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-3-xieyongji@bytedance.com> <CACGkMEuAxEEvShwN8Q_k-FKZODesORn4zJG7UFHD-KS8sQXYjg@mail.gmail.com>
In-Reply-To: <CACGkMEuAxEEvShwN8Q_k-FKZODesORn4zJG7UFHD-KS8sQXYjg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 19 Dec 2022 14:39:09 +0800
Message-ID: <CACycT3u5x1wJi8Q1Pm88ckivEUHV11jrzrsaU7JRmVP73M9+DA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] vduse: Add enable_irq_wq sysfs interface for virtqueues
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
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

On Fri, Dec 16, 2022 at 1:43 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > Add enable_irq_wq sysfs interface to control whether
> > use workqueue to inject irq or not. The vhost-vdpa case
> > can benefit from it.
>
> Do we have a benchmark result for this?
>

It can reduce 2~3 us latency in our sync I/O test.

> Or I wonder if we can extend set_vq_cb() by associating an eventfd
> then VDUSE can signal that eventfd directly?
>

It looks good to me. I can try this way in v3.

Thanks,
Yongji
