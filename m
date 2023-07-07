Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C774A845
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGGAyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGGAyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE5C10EA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 17:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688691242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ERH9y8ye6CIkPXHBNLurA/7NLrmFEv4udLe/+CQPv00=;
        b=LJOADU1m4JBX1CtUTcYeXudaEHO+2eCVPql9Eo9Xf75ezRVC9cZikjzI18R2tX5kEhWeae
        J3x3lZ7zpIj9UEQ/Gk57b0Prid0VJ91mx2+thIAQUVTbFsAlvF6vunadO8DdF8r3Qz9R8l
        Y85oNEFROxWWShgym6hyw2WhEOqUGgY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-khqsK6SxNumoaCOB1zv-6g-1; Thu, 06 Jul 2023 20:53:59 -0400
X-MC-Unique: khqsK6SxNumoaCOB1zv-6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6F23101A528;
        Fri,  7 Jul 2023 00:53:58 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DA9A492C13;
        Fri,  7 Jul 2023 00:53:56 +0000 (UTC)
Date:   Fri, 7 Jul 2023 08:53:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
        bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
        atishp@rivosinc.com, thunder.leizhen@huawei.com, horms@kernel.org
Subject: Re: [PATCH -next v7 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Message-ID: <ZKdiIGRAQYx9zILj@MiWiFi-R3L-srv>
References: <20230704212327.1687310-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704212327.1687310-1-chenjiahao16@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/23 at 09:23pm, Chen Jiahao wrote:
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
> 
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Hence this patchset introduces the parameter option crashkernel=X,[high,low].
> 
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=X,high"; or reserve a memory range
> below 4G with "crashkernel=X,low". Besides, there are few rules need
> to take notice:
> 1. "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
>    is specified.
> 2. "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
>    and there is enough memory to be allocated under 4G.
> 3. When allocating crashkernel above 4G and no "crashkernel=X,low" is
>    specified, a 128M low memory will be allocated automatically for
>    swiotlb bounce buffer.
> See Documentation/admin-guide/kernel-parameters.txt for more information.
> 
> To verify loading the crashkernel, adapted kexec-tools is attached below:
> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
> 
> Following test cases have been performed as expected:
> 1) crashkernel=256M                          //low=256M
> 2) crashkernel=1G                            //low=1G
> 3) crashkernel=4G                            //high=4G, low=128M(default)
> 4) crashkernel=4G crashkernel=256M,high      //high=4G, low=128M(default), high is ignored
> 5) crashkernel=4G crashkernel=256M,low       //high=4G, low=128M(default), low is ignored
> 6) crashkernel=4G,high                       //high=4G, low=128M(default)
> 7) crashkernel=256M,low                      //low=0M, invalid
> 8) crashkernel=4G,high crashkernel=256M,low  //high=4G, low=256M
> 9) crashkernel=4G,high crashkernel=4G,low    //high=0M, low=0M, invalid
> 10) crashkernel=512M@0xd0000000              //low=512M
> 11) crashkernel=1G,high crashkernel=0M,low   //high=1G, low=0M

The series looks good to me, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

