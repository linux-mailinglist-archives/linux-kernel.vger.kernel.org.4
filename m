Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF86A08A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjBWMbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjBWMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BCE3E0B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677155433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=50lBuV3QR2//PSngGTbSWZPBlP82sIgkQ+k5w94wfYg=;
        b=LBJc38PrWJiIV91ItccqrFGNlyEr8yDU5Qx9kEdptLySmD+681e8gRS0eMxyQ4NMfUFCFv
        uubTphrpp7lhn9UE5KKHEKbigdvl72AGuMlJN3uYmq8bagdpjPT+M2Yz8m3pCzfzkELsj6
        Q2IVfHra2nrZB2WV3XYXfbiMqikp8Lc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-NUsTCYPcMC6b5sDMgY8Nng-1; Thu, 23 Feb 2023 07:30:30 -0500
X-MC-Unique: NUsTCYPcMC6b5sDMgY8Nng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D790885624;
        Thu, 23 Feb 2023 12:30:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.239])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1CA42492C14;
        Thu, 23 Feb 2023 12:30:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 23 Feb 2023 13:30:24 +0100 (CET)
Date:   Thu, 23 Feb 2023 13:30:20 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v11 2/2] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <20230223123020.GA26182@redhat.com>
References: <20230221201740.2236-1-gregory.price@memverge.com>
 <20230221201740.2236-3-gregory.price@memverge.com>
 <20230222124834.GA15591@redhat.com>
 <Y/YzloHpiyOSvZfK@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/YzloHpiyOSvZfK@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22, Gregory Price wrote:
>
> On Wed, Feb 22, 2023 at 01:48:35PM +0100, Oleg Nesterov wrote:
> > On 02/21, Gregory Price wrote:
> > >
> > > +struct ptrace_sud_config {
> > > +	__u8  mode;
> > > +	__u8  pad[7];
> >               ^^^^^^
> > Why?
> >
>
> The struct isn't packed, so this is for alignment/consistency of size.
> The padding gets added anyway, and differently between 32/64 bit.

OK, I have to admit I didn't know that alignof(long long) == 4 on 32 bit.

> > > +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> > > +		                     void __user *data)
> > > +{
> > > +	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> > > +	struct ptrace_sud_config config;
> > > +	if (size != sizeof(struct ptrace_sud_config))
> > > +		return -EINVAL;
> >
> > Andrei, do we really need this check?
> >
>
> My understanding is that it's a sanity check against the above issue.
> In fact, it was what lead me to add the padding.

Well, if this is the only reason then this check and the "size" argument
ahould be removed, imo.

But perhaps it can be useful for future extensions, I dunno.

Oleg.

