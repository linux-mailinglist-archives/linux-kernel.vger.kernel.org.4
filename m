Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD36CC975
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjC1RlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC1RlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:41:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC8AF09
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XA3V/SqCMK03TX/XK2Fih6eGxCHfmkEQA7ESYIGi5Fk=; b=wSBhrhYnvDL1WlDW+LBAElxarl
        ZR2NCQ2dBSyG9IhbY5oWyVLJGh0Yc3uNJZ7hiV3EiTSqux8Fa/936yvG4bjeQ3F6+auHlCsNZYe2j
        UWqkpvzzMvld0VUXKopREQfYoOAn5GBnLiISGA3Mv1vqRtqBVrNuLGUTDBkJ6cXz8cUOy/1XfPdi8
        m2j/hLjPyWNp+m5ShslGKL+X4ndyaaHFZj+PraJxfT6esn+4g9Ms49NZFXVE2W0vLjWco1U4SZDIB
        eNvtI97S8YJpvgWbXEm4hcReX9tq9JhmM4Bhg3FW9yboPKIkJMPXwSc/nGazL2qODu3KJYjQXBfVe
        LgdAEKZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phDJe-00FLag-0g;
        Tue, 28 Mar 2023 17:41:02 +0000
Date:   Tue, 28 Mar 2023 10:41:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: 9p caching with cache=loose and cache=fscache
Message-ID: <ZCMmrnmZFcH65Orp@bombadil.infradead.org>
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
 <ZCHU6k56nF5849xj@bombadil.infradead.org>
 <ZCJRlqc/epbRhm93@codewreck.org>
 <2391219.DQnbcWml7j@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2391219.DQnbcWml7j@silver>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:53:49PM +0200, Christian Schoenebeck wrote:
> Hi Luis,
> 
> not sure which QEMU wiki page you are referring to. AFAIK we currently have 3
> QEMU wiki pages concerning 9p:
> 
> 1. 9p documentation for users:
> https://wiki.qemu.org/Documentation/9psetup

It was this one. I hadn't looked at the other ones.

> 2. 9p documentation for developers only:
> https://wiki.qemu.org/Documentation/9p
> 
> 3. How to setup an entire guest on top of a 9p root filesystem:
> https://wiki.qemu.org/Documentation/9p_root_fs
> 
> Only the latter wiki page mentions cache=loose at all:
> 
>   "To speedup things you can also consider to use e.g. cache=loose instead. 
>    That will deploy a filesystem cache on guest side and reduces the amount
>    of 9p requests to hosts. As a consequence however guest might not 
>    immediately see file changes performed on host side. So choose wisely upon
>    intended use case scenario. You can change between cache=mmap or e.g.
>    cache=loose at any time."
> 
> Which I now changed to:
> 
>   "To speedup things you can also consider to use e.g. cache=loose instead.

My experience is that cache=loose is totally useless.

>    That will deploy a filesystem cache on guest side and reduces the amount of
>    9p requests to hosts. As a consequence however guest might not see file
>    changes performed on host side *at* *all*

I think that makes it pretty useless, aren't most setups on the guest read-only?

It is not about "may not see", just won't. For example I modified the
Makefile and compiled a full kernel and even with those series of
changes, the guest *minutes later* never saw any updates.

> (as Linux kernel's 9p client 
>    currently does not revalidate for fs changes on host side at all, which is
>    planned to be changed on Linux kernel side soon though). So choose wisely
>    upon intended use case scenario. You can change between cache=mmap or e.g.
>    cache=loose at any time."
> 
> On the user page it was already clearly mentioned though:
> 
>   "Mount the shared folder on guest using
> 
>       mount -t 9p -o trans=virtio test_mount /tmp/shared/ -oversion=9p2000.L,posixacl,msize=104857600,cache=none
> 
>   In the above example the folder /home/guest/9p_setup/ shared of the host
>   is shared with the folder /tmp/shared on the guest. We use no cache because
>   current caching mechanisms need more work and the results are not what you
>   would expect."

I got a wiki account now and I was the one who had clarified this.

  Luis
