Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7839640731
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiLBMzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiLBMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:55:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6759DC5E0D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669985650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lc596KyOYqvjrnPcaKRdpq0W8UiV7G21GOZD+y7P6/w=;
        b=RVTyIU5cOiTbNZ95AUGdv0BCHeMJSVUawHgKWzB0PMv3UCJ9WdiUC7gSLL/QvXn612ude3
        uPxKXEb3bF0hFCw2Bwr0xGzY599xMyVvqIB8tYzgKMQ8Lpfj3ZlXiYz25vSvKYla4UUW9r
        PQ0OzjAjae+QK3dxzsXIldvM65fT0Bg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-1VQkJIyWM2KTaALtrRYEYA-1; Fri, 02 Dec 2022 07:54:07 -0500
X-MC-Unique: 1VQkJIyWM2KTaALtrRYEYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E63D8185A78F;
        Fri,  2 Dec 2022 12:54:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-178.brq.redhat.com [10.40.194.178])
        by smtp.corp.redhat.com (Postfix) with SMTP id 16E462166B2A;
        Fri,  2 Dec 2022 12:54:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Dec 2022 13:54:06 +0100 (CET)
Date:   Fri, 2 Dec 2022 13:54:04 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Seiji Nishikawa <snishika@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes/x86: allow to probe a "nop" insn with 0x66 prefix
Message-ID: <20221202125401.GA16230@redhat.com>
References: <20221201142644.GA27185@redhat.com>
 <871qpiqaz3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qpiqaz3.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02, Thomas Gleixner wrote:
>
> On Thu, Dec 01 2022 at 15:26, Oleg Nesterov wrote:
>
> > From: Denys Vlasenko <dvlasenk@redhat.com>
> >
> > Intel icc -hotpatch inserts 2-byte "0x66 0x90" NOP at the start of each
> > function to reserve extra space for hot-patching, and currently it is not
> > possible to probe these functions because branch_setup_xol_ops() wrongly
> > nacks NOP with REP prefix.
> >
> > Fixes: 250bbd12c2fe ("uprobes/x86: Refuse to attach uprobe to "word-sized" branch insns")
> > Reported-by: Seiji Nishikawa <snishika@redhat.com>
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>
> The SOB chain is invalid as it lacks the author's signoff.

Denys, can we have your signed-off-by?

