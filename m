Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5C6ECB02
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjDXLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjDXLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33CE210A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682334491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dp8THvRtHWbI7oq8asUizkVUk3mdmGjgjj7UOLbkef8=;
        b=F1Z7kjAnXH8xHf6mT1rs2AyKc59/XOPngC2brEn7tARjQhmPhfRq7Ev2pdiXA3ZKHNW1Ex
        52qD1/Q3o1G74DcHOy6vbCweFBRw3DBJ7Z5xJc0Y7+qvtkmG7JfjVQoO9NNEsrpGmAytjG
        zsVbZRNykZLTHqg1LZrrlZ97XXvjA24=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-WcO18q13Od6hIVflrwyiCw-1; Mon, 24 Apr 2023 07:08:05 -0400
X-MC-Unique: WcO18q13Od6hIVflrwyiCw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56AE91C0878A;
        Mon, 24 Apr 2023 11:08:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.225])
        by smtp.corp.redhat.com (Postfix) with SMTP id 844FF492B03;
        Mon, 24 Apr 2023 11:08:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 24 Apr 2023 13:07:54 +0200 (CEST)
Date:   Mon, 24 Apr 2023 13:07:50 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] MIPS: uprobes: Restore thread.trap_nr
Message-ID: <20230424110750.GA11631@redhat.com>
References: <1682213883-3654-1-git-send-email-yangtiezhu@loongson.cn>
 <ZEShNUil0gsVlrDo@debian.me>
 <f99fe71d-cd97-e641-d637-5e7efbcad5f5@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f99fe71d-cd97-e641-d637-5e7efbcad5f5@loongson.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23, Tiezhu Yang wrote:
>
> Cc:
> Oleg Nesterov <oleg@redhat.com>
> Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>
> On 04/23/2023 11:08 AM, Bagas Sanjaya wrote:
> >On Sun, Apr 23, 2023 at 09:38:03AM +0800, Tiezhu Yang wrote:
> >>thread.trap_nr is saved in arch_uprobe_pre_xol(), it should be restored
> >>in arch_uprobe_{post,abort}_xol() accordingly, actually it was only done
> >>in the post function, just do it in the abort function too, this change
> >>is similar with x86 and powerpc.
> >
> >I'm confused (please fix up grammar, spelling, and punctuation). Can you
> >explain why thread.trap_nr should be restored somewhere else? Also, what
> >x86/powerpc changes as reference?
> >
>
> Here is the related first commit for x86 in 2012:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0326f5a94dde
>
> When xol insn itself triggers the signal, restart the original insn,
> in this case, UTASK_SSTEP_TRAPPED is set [1], it does *abort_xol()
> instead of *post_xol() [2], then should do the restore operations.

Yes... for example, if the uprobed task was killed abort() should restore
the state and (in particular) change ->trap_nr from UPROBE_TRAP_NR back to
->saved_trap_nr.

So the patch looks fine to me.

Oleg.

