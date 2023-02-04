Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB55168A81C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 05:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjBDENG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 23:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjBDENE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 23:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8BC66D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 20:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675483936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCd6IH1kuSRhazY3lirDDEsbjEKOXtX6NtTmDCDsrd8=;
        b=jG/0DJVpf4/GAXcSh1YpH4j+VTOm8QpUpYc3b8rSJP/9HMveKkH2PrSFEnD4ge8+hb9rX6
        JUEqmYLdbNjBy7/4Lw7QHzMa+2gARrK9hS1+I4lTGJ0441u9jA57Qxvj5tp/nqrIjGB3P0
        1T35dHax8SgmZAOEmjc+2d8fURCY9bg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-BdN2xQFkMbO6m7WXdcsDHA-1; Fri, 03 Feb 2023 23:12:13 -0500
X-MC-Unique: BdN2xQFkMbO6m7WXdcsDHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAEF9802314;
        Sat,  4 Feb 2023 04:12:12 +0000 (UTC)
Received: from localhost (ovpn-12-127.pek2.redhat.com [10.72.12.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2D70112132C;
        Sat,  4 Feb 2023 04:12:11 +0000 (UTC)
Date:   Sat, 4 Feb 2023 12:12:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, urezki@gmail.com, lstoakes@gmail.com,
        willy@infradead.org, hch@infradead.org, error27@gmail.com
Subject: Re: [PATCH v4 0/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y93bGLwIROQB3Yfs@MiWiFi-R3L-srv>
References: <20230201091339.61761-1-bhe@redhat.com>
 <87357o7yeh.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87357o7yeh.fsf@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/23 at 09:47am, Stephen Brennan wrote:
......snip...
> > Testing
> > ***
> > Only did the basic testing on kvm guest, and run below commands to
> > access kcore file to do statistics:
> >
> > 	makedumpfile --mem-usage /proc/kcore
> 
> Hi Baoquan,
> 
> Sorry I haven't commented with testing info or review on each revision:
> I'm not really familiar with the details necessary for review. However,
> it looks like this is getting close to ready, so I did another test:

That's OK, and your testing is very helpful because I don't know how to
create vm_map_ram() area to test the patches, just did basic testing.

> 
> [opc@stepbren-ol8-1 drgn_vmalloc_test]$ sudo insmod drgn_vmalloc_test.ko
> [opc@stepbren-ol8-1 drgn_vmalloc_test]$ sudo dmesg | tail -n 5
> [   20.763310] missing module BTF, cannot register kfuncs
> [   20.840200] missing module BTF, cannot register kfuncs
> [   91.475814] drgn_vmalloc_test: loading out-of-tree module taints kernel.
> [   91.479913] drgn_vmalloc_test: module verification failed: signature and/or required key missing - tainting kernel
> [   91.484926] drgn_vmalloc_test: 0xffffa51ac2d00000
> [opc@stepbren-ol8-1 drgn_vmalloc_test]$ sudo drgn
> drgn 0.0.22 (using Python 3.6.8, elfutils 0.186, with libkdumpfile)
> For help, type help(drgn).
> >>> import drgn
> >>> from drgn import NULL, Object, cast, container_of, execscript, offsetof, reinterpret, sizeof
> >>> from drgn.helpers.common import *
> >>> from drgn.helpers.linux import *
> warning: could not get debugging information for:
> drgn_vmalloc_test (could not find module in depmod)
> >>> prog.read(0xffffa51ac2d00000, 64)
> b'\x00\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\t\x00\x00\x00\n\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00\x00\r\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00'
> >>>
> 
> So this definitely still resolves the originally reported issue. Feel
> free to add, if you want:
> 
> Tested-by: Stephen Brennan <stephen.s.brennan@oracle.com>

I noticed Andrew had picked this v4 into his mm tree, maybe Andrew can
help add this Tested-by tag.

