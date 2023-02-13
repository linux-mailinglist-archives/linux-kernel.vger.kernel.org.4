Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0083C694FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjBMSyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjBMSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:54:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82274222DC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:53:47 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XumuzdKDIJOLVLxOQFa7Ls9fvvPzp/W5mMqaQUxDX9U=;
        b=xGob6qvpa705D1lyN8pau6eEY/lV1qg5ggnK9ZzlISZV8ZpYwAYAg1c/FVF97Wla8Io1tg
        2VXfdtHLOdaWDnew1TPKPLs5MlA3wjmsG6esWNVjdA8OXRZAkmEgj3jJjvb20YkKm2HrQ2
        Uc9itVGQBUYfrmtd459gBddWmL75xlWzHoAMVyU70zL2bC6LPiCIqOq7iri7wtkG74iQNW
        DTWaNXRivbVg0QiudwTOLiJxatkUbRXy6JQI2CmbZVn0UsksB9zndbSvgF63/xHGoLa+3N
        COtu5OoV7cqCoWFGAFVg5q2HbFDRG/ebN3sV3+IfOwNSHLh8JZxvyQ0t5zOv6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XumuzdKDIJOLVLxOQFa7Ls9fvvPzp/W5mMqaQUxDX9U=;
        b=U2axGgm9NS+lQo3rT9ONaCbWGnPK9Jm7xmja90tV85w8IO8Bh4aVu0JC8SbfYtOkoz4hHe
        lUdRHrOqfgY2kuAw==
To:     Yongji Xie <xieyongji@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
In-Reply-To: <CACycT3uY1dfP=5d1go+POh7-J1tUMW+9RXi92KtcFJYMzq-bOQ@mail.gmail.com>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org>
 <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
 <20230127032039-mutt-send-email-mst@kernel.org>
 <CACycT3u=vULuZ9-ZakBjxmbu88iUb+xB2mHJUnHA_8SuUV7H4w@mail.gmail.com>
 <20230213065116-mutt-send-email-mst@kernel.org>
 <CACycT3uY1dfP=5d1go+POh7-J1tUMW+9RXi92KtcFJYMzq-bOQ@mail.gmail.com>
Date:   Mon, 13 Feb 2023 19:53:44 +0100
Message-ID: <87a61htn0n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13 2023 at 22:50, Yongji Xie wrote:
> On Mon, Feb 13, 2023 at 8:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> I can try to split irq_create_affinity_masks() into a common part and
> an irq specific part, and move the common part to a common dir such as
> /lib and export it. Then we can use the common part to build a new API
> for usage.

  https://lore.kernel.org/all/20221227022905.352674-1-ming.lei@redhat.com/

Thanks,

        tglx
