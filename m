Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B458E6B560E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCJXyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjCJXyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:54:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4831112CBA7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pxINQc+Ngasq0Mq+gPAA8xkkXnRUKv144A0HUyerW4g=; b=EuxiFJtH+TrAf9qF7mBCZJgaqs
        WV1/Q5gqm2U169x2MZySKm85KTT0Q2ycAUaGnStZCBDx+nkZf5wZ/qyxRSRcAqvNNm12OhBdLfjzf
        C7U7eFt59QCGCsAFHXeiKY8cj8NkJDHfJEBG3P45dOLCuy2hb+GP04XNnUeF4SIjcoz/7clVaP7YB
        vdw7OjaVOK3olZfXBbB1etEpiiVaytUr1/XNeBSzSoptH79z1WKEV4w89niwyUp3ycALlLEhWE8Nk
        L2MJFs99OHkIAo4Ikvk7MH8cK7iZfRtwkm5GIbfRXkWotsJfntkNbib17zK+mtekNNK6z71lTlB+u
        WpxT9J3A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamZN-00GkyF-S1; Fri, 10 Mar 2023 23:54:41 +0000
Date:   Fri, 10 Mar 2023 15:54:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] dyndbg: cleanup dynamic usage in ib_srp.c
Message-ID: <ZAvDQdY14BVKz09h@bombadil.infradead.org>
References: <20230310212728.82021-1-jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310212728.82021-1-jbaron@akamai.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 04:27:28PM -0500, Jason Baron wrote:
> Currently, in dynamic_debug.h we only provide
> DEFINE_DYNAMIC_DEBUG_METADATA() and DYNAMIC_DEBUG_BRANCH()
> definitions if CONFIG_DYNAMIC_CORE is enabled. Thus, drivers
> such as infiniband srp (see: drivers/infiniband/ulp/srp/ib_srp.c)
> must provide their own definitions for !CONFIG_DYNAMIC_CORE.
> 
> Thus, let's move this !CONFIG_DYNAMIC_CORE case into dynamic_debug.h.
> However, the dynamic debug interfaces should really only be defined
> if CONFIG_DYNAMIC_DEBUG is set or CONFIG_DYNAMIC_CORE is set along
> with DYNAMIC_DEBUG_MODULE, (see:
> Documentation/admin-guide/dynamic-debug-howto.rst). Thus, the
> undefined case becomes: !((CONFIG_DYNAMIC_DEBUG ||
> (CONFIG_DYNAMIC_CORE && DYNAMIC_DEBUG_MODULE)).
> With those changes in place, we can remove the !CONFIG_DYNAMIC_CORE
> case from ib_srp.c
> 
> This change was prompted by a build breakeage in ib_srp.c stemming
> from the inclusion of dynamic_debug.h unconditionally in module.h, due
> to commit 7deabd674988 ("dyndbg: use the module notifier callbacks").
> In that case, if we have CONFIG_DYNAMIC_CORE=y and
> CONFIG_DYNAMIC_DEBUG=n then the definitions for
> DEFINE_DYNAMIC_DEBUG_METADATA() and DYNAMIC_DEBUG_BRANCH() are defined
> once in ib_srp.c and then again in the dynamic_debug.h. This had been
> working prior to the above referenced commit because dynamic_debug.h
> was only pulled into ib_srp.c conditinally via printk.h if
> CONFIG_DYNAMIC_DEBUG was set.
> 
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Fixes: 7deabd674988 ("dyndbg: use the module notifier callbacks")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/202303071444.sIbZTDCy-lkp@intel.com/__;!!GjvTz_vk!S6X1T0wd8DP8kxf6V06_uDcxrNwKJhPOU_7dY0PNghJRL0ahqvE8bh-5544ThnyRkpVyK4Q$
> Signed-off-by: Jason Baron <jbaron@akamai.com>

Thanks, applied and pushed to modules-next!

  Luis
