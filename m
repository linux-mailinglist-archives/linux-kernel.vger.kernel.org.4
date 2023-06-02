Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893117208B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjFBSAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjFBSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4728F1A2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685728767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vEfy4ABvbNm71f6wJfPO0YUTrGmZR9PK0H6cIJhbRw=;
        b=abSWuJysw7fwpk4xV/ySYfNpwdSuqRYLYAUcUa0q4pAfshcQROlA/mfbY43F11nYKg7EOP
        UciJLWjz4kIVRNgoOlVGGXcjJwIRSmAM/UAnAo6p9MCPmImlSUdbgY50DC0qoFpTVgol4o
        2FNlNdisUno9tox0oerPLeWNh2bgsks=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-nTsWchWkPnyhyWDJbcXr9A-1; Fri, 02 Jun 2023 13:59:24 -0400
X-MC-Unique: nTsWchWkPnyhyWDJbcXr9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB2033C14116;
        Fri,  2 Jun 2023 17:59:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0193FC154D7;
        Fri,  2 Jun 2023 17:59:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Jun 2023 19:59:02 +0200 (CEST)
Date:   Fri, 2 Jun 2023 19:58:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230602175846.GC555@redhat.com>
References: <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
 <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
 <20230601074315.GA13133@redhat.com>
 <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02, Jason Wang wrote:
>
> On Thu, Jun 1, 2023 at 3:43 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > and the final rewrite:
> >
> >         if (work->node) {
> >                 work_next = work->node->next;
> >                 if (true)
> >                         clear_bit(&work->flags);
> >         }
> >
> > so again, I do not see the load-store control dependency.
>
> This kind of optimization is suspicious. Especially considering it's
> the control expression of the loop but not a condition.

It is not about optimization,

> Looking at the assembly (x86):
>
>    0xffffffff81d46c5b <+75>:    callq  0xffffffff81689ac0 <llist_reverse_order>
>    0xffffffff81d46c60 <+80>:    mov    %rax,%r15
>    0xffffffff81d46c63 <+83>:    test   %rax,%rax
>    0xffffffff81d46c66 <+86>:    je     0xffffffff81d46c3a <vhost_worker+42>
>    0xffffffff81d46c68 <+88>:    mov    %r15,%rdi
>    0xffffffff81d46c6b <+91>:    mov    (%r15),%r15
>    0xffffffff81d46c6e <+94>:    lock andb $0xfd,0x10(%rdi)
>    0xffffffff81d46c73 <+99>:    movl   $0x0,0x18(%rbx)
>    0xffffffff81d46c7a <+106>:   mov    0x8(%rdi),%rax
>    0xffffffff81d46c7e <+110>:   callq  0xffffffff821b39a0
> <__x86_indirect_thunk_array>
>    0xffffffff81d46c83 <+115>:   callq  0xffffffff821b4d10 <__SCT__cond_resched>
> ...
>
> I can see:
>
> 1) The code read node->next (+91) before clear_bit (+94)

The code does. but what about CPU ?

> 2) And the it uses a lock prefix to guarantee the execution order

As I said from the very beginning, this code is fine on x86 because
atomic ops are fully serialised on x86.

OK. we can't convince each other. I'll try to write another email when
I have time,

If this code is correct, then my understanding of memory barriers is even
worse than I think. I wouldn't be surprised, but I'd like to understand
what I have missed.

Oleg.

