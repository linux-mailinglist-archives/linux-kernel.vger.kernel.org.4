Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6862E043
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiKQPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiKQPrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B487616C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668699997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5HKEB3fHlBEv/KV0IugSFogCrFrsWVhqrP69OBbPPg=;
        b=dt8m3cDPOPayIHJsUBKXa9tzf2ILYLTpqmmN39sEK7MSO+UViAZ5j7Y3iXCKFkHaHVVhvk
        P2kReNEpP5R5hjkdQhxcGicnlCy2wQqincKRlyXqlQRm+m+aGmxuEnFwoQT0il6zMmle9u
        8qaAnl/K+5lRR5h4u6Woi85EIKR+v7Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-1Rth89DTNc6P3eYwTF55Pg-1; Thu, 17 Nov 2022 10:46:30 -0500
X-MC-Unique: 1Rth89DTNc6P3eYwTF55Pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F1A4101A528;
        Thu, 17 Nov 2022 15:46:29 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 150ED40C83EB;
        Thu, 17 Nov 2022 15:46:26 +0000 (UTC)
Date:   Thu, 17 Nov 2022 16:46:12 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, ribalda@google.com,
        zwisler@google.com, robdclark@gmail.com,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH RFC] kexec: Freeze processes before kexec
Message-ID: <20221117164612.65832e37@rotkaeppchen>
In-Reply-To: <20221116151610.7294a9e8@gandalf.local.home>
References: <20221116195624.124092-1-joel@joelfernandes.org>
        <20221116151610.7294a9e8@gandalf.local.home>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 16 Nov 2022 15:16:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 16 Nov 2022 19:56:24 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1175,6 +1175,12 @@ int kernel_kexec(void)
> >  	} else
> >  #endif
> >  	{
> > +		error = freeze_processes();
> > +		if (error) {
> > +			error = -EBUSY;
> > +			goto Unlock;
> > +		}  
> 
> If this is the path of a kernel panic, do we really want to check the
> return error of freeze_processes()? We are panicing, there's not much more
> we can do.

kernel_kexec isn't called during panic. We don't need to worry about it
here.

Having that said I think this is a problem in the device driver _not_
in kexec. In my opinion it's the job of the driver to prevent such
races during shutdown.

Thanks
Philipp

