Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE06ED155
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjDXP3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjDXP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47349CF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682350138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3Xi1SdkhmIfRjRu7FuyqmHC/va+/w7r2t9GfgfXyFY=;
        b=KO7WZm6P4duamLUDR/J2g/xyZoRNnEH8Va8Vds99It4YNSu+6HAQXFaTNEiSCEU58hlvhC
        OsmojEQE7r9SxA5PkSiWmVlW/2SAKl/bB4n1QOb/Xb+GLW6OB+GyW4PmWrv/NPswVlopNF
        KPRI/ik8U/KWEH7TjoNr4QFZZ561Hcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-zSF27hSuNk2LL6ngf1XAMA-1; Mon, 24 Apr 2023 11:28:55 -0400
X-MC-Unique: zSF27hSuNk2LL6ngf1XAMA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B378D85A5B1;
        Mon, 24 Apr 2023 15:28:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.225])
        by smtp.corp.redhat.com (Postfix) with SMTP id 728CE492B03;
        Mon, 24 Apr 2023 15:28:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 24 Apr 2023 17:28:44 +0200 (CEST)
Date:   Mon, 24 Apr 2023 17:28:41 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] riscv: uprobes: Restore thread.bad_cause
Message-ID: <20230424152841.GB32615@redhat.com>
References: <1682214146-3756-1-git-send-email-yangtiezhu@loongson.cn>
 <f60e6e0f-a520-2e8d-0b81-6b15498cb300@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60e6e0f-a520-2e8d-0b81-6b15498cb300@loongson.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Tiezhu Yang wrote:
>
> >diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
> >index c976a21..194f166 100644
> >--- a/arch/riscv/kernel/probes/uprobes.c
> >+++ b/arch/riscv/kernel/probes/uprobes.c
> >@@ -67,6 +67,7 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > 	struct uprobe_task *utask = current->utask;
> >
> > 	WARN_ON_ONCE(current->thread.bad_cause != UPROBE_TRAP_NR);
> >+	current->thread.bad_cause = utask->autask.saved_cause;
> >
> > 	instruction_pointer_set(regs, utask->vaddr + auprobe->insn_size);
> >
> >@@ -102,6 +103,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > {
> > 	struct uprobe_task *utask = current->utask;
> >
> >+	current->thread.bad_cause = utask->autask.saved_cause;
> > 	/*
> > 	 * Task has received a fatal signal, so reset back to probbed
> > 	 * address.
> >

Acked-by: Oleg Nesterov <oleg@redhat.com>

