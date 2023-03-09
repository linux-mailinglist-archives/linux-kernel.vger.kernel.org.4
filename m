Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA56B2C55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCIRuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCIRuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:50:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20A4A1D2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678384151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ag3m8BE68Ubj+bzVerBr255lxR7FSwvjAEEQS4DeCM=;
        b=h7QPshqXyKioXIB5c/MOf2dUecNtlAE/KCtvTL4QdLBOUp3o06Dd9Q8jHdGtBRFkosJD0J
        I3ZNHqgqtbI3gJU/mOVAeSaIvm3458gaA/pJRAb8zJjgkc+WmQaf3Qq0cJAFtjCD8s6vAc
        iWhJK+N/G/aS7V6bYXBSslNVPXrfM8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-makk0FqNPziV2-Cx4qxptQ-1; Thu, 09 Mar 2023 12:48:58 -0500
X-MC-Unique: makk0FqNPziV2-Cx4qxptQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EEE6857A88;
        Thu,  9 Mar 2023 17:48:58 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13F4C401B290;
        Thu,  9 Mar 2023 17:48:58 +0000 (UTC)
Date:   Thu, 9 Mar 2023 12:48:56 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, ritesh.list@gmail.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        vincent.guittot@linaro.org, vishalc@linux.vnet.ibm.com,
        vschneid@redhat.com
Subject: Re: [RESEND PATCH v2] sched/debug: Put sched/domains files under the
 verbose flag
Message-ID: <20230309174856.GA191475@lorien.usersys.redhat.com>
References: <20230119150758.880189-1-pauld@redhat.com>
 <20230303183754.3076321-1-pauld@redhat.com>
 <ZAnw3aKvR/9i9kkU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnw3aKvR/9i9kkU@kroah.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:44:45PM +0100 Greg KH wrote:
> On Fri, Mar 03, 2023 at 01:37:54PM -0500, Phil Auld wrote:
> > The debug files under sched/domains can take a long time to regenerate,
> > especially when updates are done one at a time. Move these files under
> > the sched verbose debug flag. Allow changes to verbose to trigger
> > generation of the files. This lets a user batch the updates but still
> > have the information available.  The detailed topology printk messages
> > are also under verbose.
> > 
> > Discussion that lead to this approach can be found in the link below.
> > 
> > Simplified code to maintain use of debugfs bool routines suggested by
> > Michael Ellerman <mpe@ellerman.id.au>.
> > 
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Tested-by: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Link: https://lore.kernel.org/all/Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com/
> > ---
> > 
> >  v2: fix comment typo and use cpumask_empty()
> > 
> >  kernel/sched/debug.c | 52 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 49 insertions(+), 3 deletions(-)
> 
> As no one has picked this up yet, and it is really a debugfs issue, I'll
> queue this up in the driver-core tree (which takes debugfs changes) for
> 6.4-rc1 unless someone screams.
>

Thanks Greg!


> thanks,
> 
> greg k-h
> 

-- 

