Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5B6C5ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCVXnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjCVXn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:43:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB231E15;
        Wed, 22 Mar 2023 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1k27qB2kPnk4X5H75z968d6xQhaksZU9LGt7xqBOfIY=; b=OeiV9RLui/uqQFjVMtvOvhlPwh
        Z+VjaBqQv5esdbsbpgh7yGG/ApfyaW2xfegh6CnU4X7LLRLaIRXFqd6tgfpOed3J5JG6M75h9kyo+
        tXbVsSI2TzQuOCo8vLC+47p197rI43QLawz61uk1TVoafq4shvb7vDOX+WQIVxJL6vl4LcriMiclX
        NHL4VMngzDTN32spVJ72YFbBemal6RPJqTgZ+nKmGwlCiMchdjGHZq5yfhDekxgCR8r1qiU1H2DlK
        t5r2xTkk3g1Kktfkt2aWElNvHrMdri3YlWZXcVYKL/Tcu6gbNo63HQaO28rmLXJZZPGaAaxpowuuZ
        dlBvxrWw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pf86g-000Btz-38;
        Wed, 22 Mar 2023 23:43:02 +0000
Date:   Wed, 22 Mar 2023 16:43:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org
Subject: Re: [PATCH 0/5] module: ELF validation enhancement and cleanups
Message-ID: <ZBuShv1hx03WmzH4@bombadil.infradead.org>
References: <20230319213542.1790479-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319213542.1790479-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 02:35:37PM -0700, Luis Chamberlain wrote:
> While doing a cleanup of load_module() to do less work before we allocate [0],
> one of the undocumented tricks we pull off is memcpy'ing the struct module
> from the module.mod.c into the kernel, with the modifications we've made
> to it on load_module(). This puts a bit of love to make the clearer, and
> extends our ELF validity checker to ensure we verify this before allowing
> us to even process a module.
> 
> This effort has discovered a new possible build issue we have to fix:
> 
> It is in theory possible today to modify the module struct module size,
> let a kernel developer lazily just build the module (say make fs/xfs/)
> and then try to insert that module without ensuring the module size
> expected should have grown. You can verify the size with:
> 
> nm --print-size --size-sort fs/xfs/xfs.ko | grep __this_module
> 0000000000000000 0000000000000500 D __this_module
> 
> The struct module size will be different per each kernel configuration,
> and so this is system build dependent. The new ELF check put in place
> prevents this situation and also make the use case of memcpying the
> struct module very clear, along with ensuring we keep all modifications
> we've made to it.
> 
> [0] https://lkml.kernel.org/r/20230311051712.4095040-1-mcgrof@kernel.org

I've taken these into modules-next for more testing. If folks spot                                                                                                                            
issues in them though let me know and I can yank them before the merge                                                                                                                        
window.

  Luis
