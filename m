Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFAB6D135A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjC3Xdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjC3Xdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C728A5FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680219186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HFKIO15sTpdAt8JGYcoib0o9EwbibSfqk1NxeizxC3g=;
        b=GQOtV3wTHTa3GJUQnSt9+ZXRuLp0ErCLwM/e9U57kA+WZ+/Vw91oIb6bfklil53zFyNhoy
        gACnIit32GC2gF01hORkMQJwnDSpCxcKu7Fd41JWlYhtW1DRZ81tclCz8bOwS2MuOfMoql
        J8sJ8MPEilF9fn4ob5ctPCzwg1LMNEU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-KMXxKy-dMLmNmEpxqNMX8w-1; Thu, 30 Mar 2023 19:33:01 -0400
X-MC-Unique: KMXxKy-dMLmNmEpxqNMX8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 625BB3C0F231;
        Thu, 30 Mar 2023 23:33:00 +0000 (UTC)
Received: from localhost (ovpn-12-64.pek2.redhat.com [10.72.12.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F368202701E;
        Thu, 30 Mar 2023 23:32:58 +0000 (UTC)
Date:   Fri, 31 Mar 2023 07:32:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "chenjiahao (C)" <chenjiahao16@huawei.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
        bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
        atishp@rivosinc.com, thunder.leizhen@huawei.com, horms@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH -next v2 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZCYcJos4MLBvpP9/@MiWiFi-R3L-srv>
References: <20230328115150.2700016-1-chenjiahao16@huawei.com>
 <20230328115150.2700016-2-chenjiahao16@huawei.com>
 <ZCQewkvSpaI52DSM@MiWiFi-R3L-srv>
 <b8a32e3c-c083-20de-16d1-f628b02b739b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a32e3c-c083-20de-16d1-f628b02b739b@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/23 at 09:40pm, chenjiahao (C) wrote:
......
> Agreed, I will clean this up later in next version.
> > > +		if (ret || !crash_size)
> > > +			return;
> > > +
> > > +		/*
> > > +		 * crashkernel=Y,low is valid only when crashkernel=X,high
> > > +		 * is passed and high memory is reserved successful.
> > > +		 */
> > > +		ret = parse_crashkernel_low(boot_command_line, 0, &crash_low_size, &crash_base);
> > > +		if (ret == -ENOENT)
> > > +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > > +		else if (ret)
> > > +			return;
> > > +
> > > +		search_start = dma32_phys_limit;
> > > +	} else if (ret || !crash_size) {
> > > +		/* Invalid argument value specified */
> > >   		return;
> > > +	}
> > >   	crash_size = PAGE_ALIGN(crash_size);
> > > @@ -1201,16 +1246,26 @@ static void __init reserve_crashkernel(void)
> > >   	 */
> > >   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> > >   					       search_start,
> > > -					       min(search_end, (unsigned long) SZ_4G));
> > > +					       min(search_end, (unsigned long)dma32_phys_limit));
> > >   	if (crash_base == 0) {
> > The above conditional check isn't right. If crashkernel=size@offset
> > specified, the reservation failure won't trigger retry. This seems to be
> > originally introduced by old commit, while this need be fixed firstly.
> 
> Just a little curious about the rule to cope with this specific case. If
> "crashkernel=size@offset" was passed
> 
> but reserve failed, should try again to allocate in high memory, regardless
> the specified size@offset,
> 
> or just throw a warning and return? Since I noticed the current logic here
> on Arm64 is to check if !fixed_base first

Yeah, we need mark the "crashkernel=size@offset" case and avoid to
retry. Because you won't succeed if  memblock has already failed to
reserve an unavailable memory region, retry is meaningless. This has
been done in x86, arm64.

