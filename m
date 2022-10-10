Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A65F9A54
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiJJHqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiJJHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:46:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9665588
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:42:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE64268AA6; Mon, 10 Oct 2022 09:42:34 +0200 (CEST)
Date:   Mon, 10 Oct 2022 09:42:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Phil Chang =?utf-8?B?KOW8teS4luWLsyk=?= 
        <Phil.Chang@mediatek.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Message-ID: <20221010074234.GA20788@lst.de>
References: <20221002002326.946620-1-ira.weiny@intel.com> <20221002002326.946620-3-ira.weiny@intel.com> <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com> <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com> <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com> <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:20:16AM -0700, Linus Torvalds wrote:
> Actually, I think even then we shouldn't support vmalloc - and
> register_shm_helper() just needs to be changed to pass in an array of
> actual page pointers instead.
> 
> At that point TEE_SHM_USER_MAPPED should also go away, because then
> it's the caller that should just do either the user space page
> pinning, or pass in the kernel page pointer.
> 
> JensW, is there some reason that wouldn't work?

I suspect the best long term option would be to just pass an iov_iter..
