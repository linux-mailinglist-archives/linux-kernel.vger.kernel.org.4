Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76B6ACBF2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCFSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCFSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5266E696
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678125908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bX9ZOH2qME/Vd0SYTRbzqrUXGxOcqFnRgnJD+kBL/DY=;
        b=OEB9qDfGb3mU1vwd5+mJrfcKY8tgqI/krJG2JHUtjg+2Mf9h0/nNwTKMx+oUGbVmQVAW7r
        rn13OqS2IaSrGEimIRF0Bg6Hn/zLSIrswMJMuS7KsAvmah37iluB4Clu8edKtEBAQSmicb
        GNmXlFWqb2TIHnbeVMscUnU7yBBxp94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-X0o_EJQYNrCgE2PjHPyyIw-1; Mon, 06 Mar 2023 13:05:02 -0500
X-MC-Unique: X0o_EJQYNrCgE2PjHPyyIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83B0818E0925;
        Mon,  6 Mar 2023 18:05:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 10B19C16029;
        Mon,  6 Mar 2023 18:04:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  6 Mar 2023 19:04:55 +0100 (CET)
Date:   Mon, 6 Mar 2023 19:04:52 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v13 2/3] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <20230306180451.GB13201@redhat.com>
References: <20230301205843.2164-1-gregory.price@memverge.com>
 <20230301205843.2164-3-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301205843.2164-3-gregory.price@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01, Gregory Price wrote:
>
> Implement ptrace getter/setter interface for syscall user dispatch.
> 
> These prctl settings are presently write-only, making it impossible to
> implement transparent checkpoint/restore via software like CRIU.
> 
> 'on_dispatch' field is not exposed because it is a kernel-internal
> only field that cannot be 'true' when returning to userland.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

