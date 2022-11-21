Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC510632561
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiKUORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKUOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:16:54 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D543B3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=RzwUXYL+lOes2ybdcf0NZZVm/N58p9fAtL62cIEmTQ8=; b=LrQQfp2vf+LInWD7Pq23o3xJGr
        DUEtxldzGHAomYP2XolcLqhKbKSnWpTJJlP9m28pm3MlR1hX1kM7yhn2xAFZSea4MP7FJ8UqUop5E
        w5OZHh2vOuH/2PE8QwURiSh1gVZWysiN3bm8ta6I/Xnv7sEQZsRrOTCdA/jDu1C/Wkq6rUAiy/6Ol
        OAvSAxIj0pEetsQ92u1JjNdfWAZ+fkLCrcUUfcLk6VUq9J2jXoVUQa01jrziXw/Z+r8ylSOR8JMHS
        CzskN+efWyyjFT9Nsd/LaN9zKzvGGe4SRW1Hdj5sOgp7oHcoTkI2IJuhxksOuHZIh/E2KfyXKdxGJ
        0wJsNNE1VComS4uJlfk2VaZQlZN7Gsjl9T467w5lE7caRW5Qe8qieoZ+B1hWwNnhGndlDXE+jMICf
        PNbgZM8HRBnL7MaTgOdAqeS5HzoXvZ9N4SaXIrMuLTD0fl9c0FWGQJ9Vf/As64zgJvBQE3n8d4VYM
        c3158o6e92/M2V89Xkhi5tNUt7W/GFNc/qGWWu4WMTHtuoyFkq+cXgjCZSIKkjtA2g5Cm6xRfEQQA
        E473z7aYo/k/mI/R624PSVseVf6KnYhNm05hDUARAPFBghvGjyVVJDWt9zAriVM0OAZgzYvc5K9mP
        N7Q8W+dbcZ9fhupbI6AEyj7UI+PNLlILKPNh5HjB0=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     GUO Zihua <guozihua@huawei.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] 9p/xen: check logical size for buffer size
Date:   Mon, 21 Nov 2022 15:16:10 +0100
Message-ID: <8926859.ZlztnY0qrB@silver>
In-Reply-To: <Y3hADWgV9JeajmfF@codewreck.org>
References: <20221118135542.63400-1-asmadeus@codewreck.org>
 <alpine.DEB.2.22.394.2211181713420.1049131@ubuntu-linux-20-04-desktop>
 <Y3hADWgV9JeajmfF@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, November 19, 2022 3:31:41 AM CET Dominique Martinet wrote:
[...]
> > I made this change and tried the two patches together. Unfortunately I
> > get the following error as soon as I try to write a file:
> > 
> > /bin/sh: can't create /mnt/file: Input/output error
> > 
> > 
> > Next I reverted the second patch and only kept this patch. With that, it
> > worked as usual. It looks like the second patch is the problem. I have
> > not investigated further.
> 
> Thanks -- it's now obvious I shouldn't send patches without testing
> before bedtime...
> I could reproduce easily with virtio as well, this one was silly as well
> (>= instead of >). . . With another problem when zc requests get
> involved, as we don't actually allocate more than 4k for the rpc itself.
> 
> If I adjust it to also check with the zc 'inlen' as follow it appears to
> work:
> https://github.com/martinetd/linux/commit/162015a0dac40eccc9e8311a5eb031596ad35e82
> But that inlen isn't actually precise, and trans_virtio (the only
> transport implementing zc rpc) actually takes some liberty with the
> actual sg size to better fit hardwre, so that doesn't really make
> sense either and we probably should just trust trans_virtio at this
> point?
> 
> This isn't obvious, so I'll just drop this patch for now.
> Checking witih msize isn't any good but it can wait till we sort it out
> as transports now all already check this one way or another; I'd like to
> get the actual fixes out first.
> 
> (Christian, if you have time to look at it and take over I'd appreciate
> it, but there's no hurry.)

OK, I'll look at this.

Best regards,
Christian Schoenebeck


