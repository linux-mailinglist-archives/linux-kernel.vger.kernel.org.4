Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F056F4CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjEBWLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEBWLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:11:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50834198C;
        Tue,  2 May 2023 15:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hq9UcYCw0YGefVJ8NzRgUGcDPFfhETx+38qR+9vdsYI=; b=3Mo0bgBM7LM+k3C8aD/hoX1SiY
        PFgn7K/tLRtVMWDSPf352AxVALEjONXmqJfKhZnGiBqqD8h8h4LtvA25JF20PTCfuIbHIXmSrUZTu
        ITNPT7Uha6MzLcy/ibK7h7YPYpEBVWfVffhBPoksiwIotdTwE/nm8wjc4h99sZ9kmQLI6BTu/rB1I
        JcraGc+LOd5apI7DAeHKY+HG7TC7l3VMlVsxxeVNBME4GoExLxeBM6mj3D+luAJPl+kkIuAZwyonJ
        ccDiO8tHqmH+Dr4www25ETJTO6P4NMsd0UbjolKx7/s5Eh1fO83hf5W8JgnaHiwz9i7csjB7bUAPR
        W9DocdwA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ptyD4-002l2b-1K;
        Tue, 02 May 2023 22:10:58 +0000
Date:   Tue, 2 May 2023 15:10:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Dave Airlie <airlied@redhat.com>, linux-modules@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] modules/firmware: add a new option to denote a firmware
 group to choose one.
Message-ID: <ZFGKcnwqzlyWniVo@bombadil.infradead.org>
References: <20230419043652.1773413-1-airlied@gmail.com>
 <ck2dzxvllhhh74oa3vjlacutc7rdmgl7cfrfq7vgx4w3jcufrz@7jbgxcat42yn>
 <CAPM=9tw0Y2A4DvuTHT_yd58Eit+tUmo63pbEOHwRJ66LeqznEQ@mail.gmail.com>
 <fsleccud43leoioli6bj4xoydwbdcjb5qr4denuf6morhgtqki@t6xya2mygon5>
 <ZEcJNcz+ArLfUSJ1@bombadil.infradead.org>
 <n6gwizwt26ucpuva2kt35rprth6iqeibi3inq2qrn5qhs3aa3b@4hjbhgnskutq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n6gwizwt26ucpuva2kt35rprth6iqeibi3inq2qrn5qhs3aa3b@4hjbhgnskutq>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 11:11:58AM -0700, Lucas De Marchi wrote:
> Based on the above and my previous reply, I think we should have
> something more explicit about the order rather than relying on the
> toolchain behavior.

You can open code ELF sections and provide SORT() but you can also use
helpers for all this. Long ago I provided low level ELF helpers to
provide the ability to easily sort through data / code using
linker-tables [0], to help with ELF section with explicit ordering,
perhaps this could be leveraged?

I *think* for instance, one could do, using the built-in firmware
conversion as a slightly relateed example [1], provide a firmware helper for
drivers which uses something like DECLARE_FIRMWARE_TABLE(acme_gpu_fw),
then that is declared as the ELF table for acme_gpu_fw, the firmware API
could then get the hint to use that table for iterating over with
linktable_for_each(fw, acme_gpu_fw). One would not be using the linker
table for the actual firmware but instead for the firmware odering.


The firmware loader could be extended with something like

#define DECLARE_FIRMWARE_TABLE(fw_table)  DECLARE_LINKTABLE_RO(struct fw_foo, fw_table)

struct fw_foo {
	const char *opt_subfamily;
};

#define FW_NAME_ORDERED(__level, __family, __sub_family)	\
	static LINKTABLE_INIT_DATA(fw_foo, __level) 		\
	__fw_ordered_##__family = {		     		\
	opt_subfamily = sub_family,				\
};

Then firmware could would use 

FW_NAME_ORDERED(01, acme_gpu_fw, coyote);

And helpers can use it to look for the firmware an firmare API call.

As to why linker-tables never got upstream? It promised / documented
too much, we need to just make the API conversion smooth and target
that. The ordering is a secondary win. The fact that we can simplify
init levels etc, is more futuristic and should only be documented once
we get there.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20170620-linker-tables-v8
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?h=20170620-linker-tables-v8&id=162698d2f1a2406c6a7a4d39f13113ca789fd2ec

  Luis
