Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797017303B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbjFNPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjFNPXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C59A11B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686756166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZh2p9vXZ9e46XeeWLcrDNXcBuLVV71Q2XCdEow9ONs=;
        b=aJgFSP6Ro37g/QylLeaPOXrIi0aeKe9lQ+IvuH+uQfvSUuVCbMVfkpPFfO2/Byf342zYwg
        hgMCllVHTuBz0CKVfpk9uOCv5vMzMNvw2NLZ/hemX84/BidtEVdRLLrNb9k3z7eeU4H9zK
        2lfGIQYUfB2HTP3E5YuJJxRRXDO1ZFY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-Fg6rM2VWM7ielz5q-en8oQ-1; Wed, 14 Jun 2023 11:22:44 -0400
X-MC-Unique: Fg6rM2VWM7ielz5q-en8oQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24B17185A7B2;
        Wed, 14 Jun 2023 15:22:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF15AC1603B;
        Wed, 14 Jun 2023 15:22:39 +0000 (UTC)
Date:   Wed, 14 Jun 2023 16:22:39 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614152239.GH7636@redhat.com>
References: <20230614094522.GA7636@redhat.com>
 <20230614103011.GL7912@redhat.com>
 <20230614103953.GM7912@redhat.com>
 <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
 <20230614125320.GA1640563@hirez.programming.kicks-ass.net>
 <20230614130348.GF7636@redhat.com>
 <20230614130945.GK1639749@hirez.programming.kicks-ass.net>
 <20230614145348.GB1640563@hirez.programming.kicks-ass.net>
 <20230614150717.GG7636@redhat.com>
 <20230614151920.GN1639749@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614151920.GN1639749@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:19:20PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 14, 2023 at 04:07:17PM +0100, Richard W.M. Jones wrote:
> > On Wed, Jun 14, 2023 at 04:53:48PM +0200, Peter Zijlstra wrote:
> 
> > > Clearly I'm doing something wrong.
> > 
> > I'm suspecting version of qemu may have something to do with it, but
> > honestly I don't know.  Which qemu are you using?
> 
> ivb-ep: QEMU emulator version 7.2.0 (Debian 1:7.2+dfsg-3)
> adl: QEMU emulator version 7.2.0 (Debian 1:7.2+dfsg-1+b2)

We had a report that it occurred on qemu 7.0:
https://bugzilla.redhat.com/show_bug.cgi?id=2213346#c5

I didn't try qemu 7.2, but I've been using 8.0 in my tests.

I'm now trying (on Intel again) with qemu @ 7efd65423ab22e6f5890,
the latest version as of now.

> I'll try and upgrade the adl to 8.

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

