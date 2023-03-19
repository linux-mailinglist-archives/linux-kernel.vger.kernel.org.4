Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B86C05A8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCSVf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCSVfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:35:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3FD11653;
        Sun, 19 Mar 2023 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4+NzyS15tvE5FVGnxGqo+lPc7QVVkfAfgOyCb7VB/XM=; b=2fCknlgWTdi0+x9lnrIeEbLIVF
        55fk6OZVI/R/W4zkljEDBoMJYWXrtaJ3bomUUBCust/KBP/LbuyJcwRnpNwLj0fQwv3ctcAgiL7ir
        7mqnmJkl2YYlTf7C/WvinuYJjuwQGhiGkj7+xfoIwfwhouTy4Vo8s07Ov7Ld+b82o4+peoc7s6kSF
        eVlDDuVqWNfzedPSw1AdAom95xddzlX/HSzVVsDfjrgjASpA8GPd59FXRWzIGaMkVqkxYi9FR+GwN
        JhuiVJdpgVggFx07x3Hwl1lkviNdIpBJRQs/r2zbxlaEy/53Iw5ybzma1Vl20ybB8e58/rbIEJtX1
        KA0KCVnw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0gp-007Vmp-1H;
        Sun, 19 Mar 2023 21:35:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 0/5] module: ELF validation enhancement and cleanups
Date:   Sun, 19 Mar 2023 14:35:37 -0700
Message-Id: <20230319213542.1790479-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing a cleanup of load_module() to do less work before we allocate [0],
one of the undocumented tricks we pull off is memcpy'ing the struct module
from the module.mod.c into the kernel, with the modifications we've made
to it on load_module(). This puts a bit of love to make the clearer, and
extends our ELF validity checker to ensure we verify this before allowing
us to even process a module.

This effort has discovered a new possible build issue we have to fix:

It is in theory possible today to modify the module struct module size,
let a kernel developer lazily just build the module (say make fs/xfs/)
and then try to insert that module without ensuring the module size
expected should have grown. You can verify the size with:

nm --print-size --size-sort fs/xfs/xfs.ko | grep __this_module
0000000000000000 0000000000000500 D __this_module

The struct module size will be different per each kernel configuration,
and so this is system build dependent. The new ELF check put in place
prevents this situation and also make the use case of memcpying the
struct module very clear, along with ensuring we keep all modifications
we've made to it.

[0] https://lkml.kernel.org/r/20230311051712.4095040-1-mcgrof@kernel.org

Luis Chamberlain (5):
  module: add sanity check for ELF module section
  module: add stop-grap sanity check on module memcpy()
  module: move more elf validity checks to elf_validity_check()
  module: merge remnants of setup_load_info() to elf validation
  module: fold usermode helper kmod into modules directory

 MAINTAINERS                |  13 +--
 kernel/Makefile            |   1 -
 kernel/module/Makefile     |   4 +-
 kernel/{ => module}/kmod.c |   0
 kernel/module/main.c       | 219 ++++++++++++++++++++++++-------------
 5 files changed, 148 insertions(+), 89 deletions(-)
 rename kernel/{ => module}/kmod.c (100%)

-- 
2.39.1

