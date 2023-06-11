Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6272B4BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 01:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjFKXHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 19:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKXHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 19:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E0DBE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686524793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gjgfXYOFN5jYOOlMUW18ina9zsTbph6o7zvLiTOdS/k=;
        b=WU3M2EYdlUMBAem+c5/4Dty3dfkqmWAKw1hK8MmTiXAUrwM6hd6MJdEjhlMFArLUEvhbWR
        WPG923EfQHkOkkv8dNEmdy50MRwA/FSdBA2rURSQTDh89nR4CjqqBdV4ryjcLff3W1xv4z
        frhAYGYHPkCuW/nBGPCZEeJ6R7e0hBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-aVl3TWueNKSnFTzX2a4T2w-1; Sun, 11 Jun 2023 19:06:29 -0400
X-MC-Unique: aVl3TWueNKSnFTzX2a4T2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BF168032FE;
        Sun, 11 Jun 2023 23:06:29 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B90240AE1E9;
        Sun, 11 Jun 2023 23:06:28 +0000 (UTC)
Date:   Mon, 12 Jun 2023 07:06:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        horms@kernel.org, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/2] arm64: kdump: simplify the reservation behaviour
 of crashkernel=,high
Message-ID: <ZIZTcEjdJOqXanJS@MiWiFi-R3L-srv>
References: <20230515060259.830662-1-bhe@redhat.com>
 <168633894002.3180904.11323833556978641615.b4-ty@arm.com>
 <ZIW6y9IK+pqMSfoc@MiWiFi-R3L-srv>
 <ZIXayAr6r1tnFQ5i@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIXayAr6r1tnFQ5i@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/23 at 03:31pm, Catalin Marinas wrote:
> On Sun, Jun 11, 2023 at 08:15:07PM +0800, Baoquan He wrote:
> > On 06/09/23 at 08:30pm, Catalin Marinas wrote:
> > > On Mon, 15 May 2023 14:02:57 +0800, Baoquan He wrote:
> > > > In v5 patch, Catalin helped review and acked the patch. However, an
> > > > uninitialized local varilable is warned out by static checker when Will
> > > > tried to merge the patch. And Will complained the code flow in
> > > > reserve_crashkernel() is hard to follow, required to refactor. While
> > > > when I tried to do the refactory, I feel it's not easy, the existing
> > > > several cases causes that.
> > > > 
> > > > [...]
> > > 
> > > Applied to arm64 (for-next/kdump).
> > > 
> > > I reworte some of the paragraphs in the documentation patch, removed
> > > some sentences to make it easier to read (some details were pretty
> > > obvious). Please have a look, if you think I missed something important,
> > > just send a patch on top. Thanks.
> > > 
> > > [1/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
> > >       https://git.kernel.org/arm64/c/6c4dcaddbd36
> > > [2/2] Documentation: add kdump.rst to present crashkernel reservation on arm64
> > >       https://git.kernel.org/arm64/c/03dc0e05407f
> > 
> > Could you help add below code change into the document patch commit? I
> > forgot adding it and got warning report from lkp test robot.
> > 
> > https://lore.kernel.org/oe-kbuild-all/202306110549.ynH2Juok-lkp@intel.com/
> > 
> > diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> > index ae21f8118830..dcfebddb6088 100644
> > --- a/Documentation/arm64/index.rst
> > +++ b/Documentation/arm64/index.rst
> > @@ -25,6 +25,7 @@ ARM64 Architecture
> >      sve
> >      tagged-address-abi
> >      tagged-pointers
> > +    kdump
> 
> I've seen the warning as well. Please send a patch fixing this as I try
> to avoid rebasing. Also we keep this part in alphabetical order.

Has sent a patch to fix that, thanks.

