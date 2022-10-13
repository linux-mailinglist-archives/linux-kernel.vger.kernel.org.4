Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4C5FD7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 12:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJMKrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 06:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1833204C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665658041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6GB/B4JNp1TxbUrS+fPKO1tu1+KnvBnyZ+rYl22l5I=;
        b=KTk91H+tEr7txJ4UgUgyOMAe5p6O+UsCwEXkoXyExjnI81O5ZPFVu1/k/tcjZIBPzL+V3k
        tekOZVhpmysm68nQThYgBQMhYLehmlk6U+XrbHCxTVwgcndvB6+oRIBUx5KxkOo6AAtRho
        z68/qihWvPGhW+zTQFecAiDJJjUuKdc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-yo6PH1nlNbie3fsaqQq5hw-1; Thu, 13 Oct 2022 06:47:17 -0400
X-MC-Unique: yo6PH1nlNbie3fsaqQq5hw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD5181C05EAD;
        Thu, 13 Oct 2022 10:46:50 +0000 (UTC)
Received: from localhost (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2C712011568;
        Thu, 13 Oct 2022 10:46:39 +0000 (UTC)
Date:   Thu, 13 Oct 2022 18:46:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     john.p.donnelly@oracle.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        "samasth.norway.ananda" <samasth.norway.ananda@oracle.com>
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Message-ID: <Y0fsi4+T6k/OO0hx@MiWiFi-R3L-srv>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
 <a80c2b7e-a510-8e45-1f3c-7e2ddf79bc37@huawei.com>
 <1d89e2cb-de26-0f85-7a2a-f68599a1b143@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d89e2cb-de26-0f85-7a2a-f68599a1b143@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/22 at 09:55am, john.p.donnelly@oracle.com wrote:
> On 8/1/22 9:47 PM, Leizhen (ThunderTown) wrote:
......
> > > Do you have plan to pick this series so that it can be taken into 5.20
> > > rc-1~3?
> > 
> > Hi, Catalin:
> >    Only function reserve_crashkernel() is modified in these two patches. The core
> > process of the arm64 architecture is not affected. I remember you suggested that
> > arm64 and x86 share the same kdump code, so these two subfeatures are needed.
> > Maybe we can lay the foundation first for the people who build the road. Unifying
> > the external interfaces of kdump on arm64 and x86 does not seem to hurt.
> > 
> > 
> > > 
> > > We have back ported the basic crashkernel=high, low, support into our
> > > distros and have taken wide testing on arm64 servers, need this patchset
> > > to back port for more testing.
> > > 
> > 
> Hi ,
> 
> What is the progress of this series ?
> 
> Without this patch set we are seeing  larger crashkernel=896M failures on
> Arm  with Linux-6.0.rc7.  This larger value is needed for
> iSCSI booted systems with certain network adapters.

This change is located in arch/arm64 folder, I have pinged arm64
maintainer to consider merging this patchset. Not sure if they are
still thinking, or ignore this.

Hi Catalin, Will,

Ping again!

Do you have plan to accept this patchset? It's very important for
crashkernel setting on arm64 with a simple and default syntax.

Thanks
Baoquan

