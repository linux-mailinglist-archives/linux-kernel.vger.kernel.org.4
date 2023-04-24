Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02736ED152
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjDXP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjDXP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179EA19D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682350111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uIDKs7C3LWJvB7Ayc1EEStt5gge8jFMIwXcZbhssBfA=;
        b=RYvvcU/7r022T2Xd84eP7DSCfTLWLUdV/m7u8BpqPMONjEGERX23YkNEsnZmvYDsWiT86w
        961CTPRPL+/U/Y7iAcC9IU55hD5KkoGH8EGJ80jMquxuiN9TaOmhYUMSdqc4LgI/UPZMFi
        YTLoRJ0Kqmtr4NeXrB8Deq17Lfnvy4A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-U95PYXJNN2yT1yIIZ1hCnA-1; Mon, 24 Apr 2023 11:28:29 -0400
X-MC-Unique: U95PYXJNN2yT1yIIZ1hCnA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 220DE29AA3BF;
        Mon, 24 Apr 2023 15:28:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.225])
        by smtp.corp.redhat.com (Postfix) with SMTP id F3658492B03;
        Mon, 24 Apr 2023 15:28:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 24 Apr 2023 17:28:18 +0200 (CEST)
Date:   Mon, 24 Apr 2023 17:28:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] csky: uprobes: Restore thread.trap_no
Message-ID: <20230424152815.GA32615@redhat.com>
References: <1682213987-3708-1-git-send-email-yangtiezhu@loongson.cn>
 <cdacf9d8-cf59-bf4e-5379-0b5bfc03a4e2@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdacf9d8-cf59-bf4e-5379-0b5bfc03a4e2@loongson.cn>
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
> >--- a/arch/csky/kernel/probes/uprobes.c
> >+++ b/arch/csky/kernel/probes/uprobes.c
> >@@ -64,6 +64,7 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > 	struct uprobe_task *utask = current->utask;
> >
> > 	WARN_ON_ONCE(current->thread.trap_no != UPROBE_TRAP_NR);
> >+	current->thread.trap_no = utask->autask.saved_trap_no;
> >
> > 	instruction_pointer_set(regs, utask->vaddr + auprobe->insn_size);
> >
> >@@ -101,6 +102,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > {
> > 	struct uprobe_task *utask = current->utask;
> >
> >+	current->thread.trap_no = utask->autask.saved_trap_no;
> > 	/*
> > 	 * Task has received a fatal signal, so reset back to probed
> > 	 * address.

Acked-by: Oleg Nesterov <oleg@redhat.com>

