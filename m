Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08636995E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBPNeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBPNeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:34:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C35455C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676554396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDxOo4bfzqJtI+IAIUxoUzNCQsLES8Y2nciI7tqhkpk=;
        b=RStcCQI4+3Ue7pWd8Dr7l0LMCG3Xjr9U7SK3pCrhgqKaJfK1bIIbs55OYBvqNEkFFG2QfB
        ZWam/WwPZI0JJzuxIkXClk+xsogiGyOuifQrQ9Wny1IoT3wPKlomjQHMLcWXIWJWgCc21n
        0J6uTQtDdzKJ+jbDWs/Jq2N5hEdG+VU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-lmYvAoRvNzS9R8i5ASnrcg-1; Thu, 16 Feb 2023 08:33:11 -0500
X-MC-Unique: lmYvAoRvNzS9R8i5ASnrcg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE5BB85CBE5;
        Thu, 16 Feb 2023 13:33:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-193-101.brq.redhat.com [10.40.193.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3D48E492B17;
        Thu, 16 Feb 2023 13:33:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 16 Feb 2023 14:33:06 +0100 (CET)
Date:   Thu, 16 Feb 2023 14:33:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, corbet@lwn.net, shuah@kernel.org
Subject: Re: [PATCH v9 1/1] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <20230216133303.GB5200@redhat.com>
References: <20230210072503.1808-1-gregory.price@memverge.com>
 <20230210072503.1808-2-gregory.price@memverge.com>
 <871qmttiqa.ffs@tglx>
 <Y+rPH0T5r38+l2gB@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+rPH0T5r38+l2gB@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13, Gregory Price wrote:
>
> On Mon, Feb 13, 2023 at 09:26:21PM +0100, Thomas Gleixner wrote:
> > On Fri, Feb 10 2023 at 02:25, Gregory Price wrote:
> > > +struct ptrace_sud_config {
> > > +	__u64 mode;
> > > +	__s8 *selector;
> >
> > How is this correct for a 32bit ptracer running on a 64bit kernel? Aside
> > of not wiring up the compat syscall without any argumentation in the
> > changelog.
> >
>
> I'm having a little trouble wrapping my head around what is "right" here
> with regard to compat.  Granted I've never had to deal with compat
> issues, so please excuse the ignorance if this is a trivial issue.

The problem is the sizeof(selector). 4 bytes for 32bit ptracer but the
kernel will write 8 bytes. I think you should make "selector" __u64 too.

Oleg.

