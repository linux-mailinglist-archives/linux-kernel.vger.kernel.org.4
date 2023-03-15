Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B146BB940
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCOQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjCOQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:13:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29820067;
        Wed, 15 Mar 2023 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5rwJplJ2Ycm0wxh0yripe2j21lzEr4vD59xx7yAbxXQ=; b=MDVRD5L34cHEzbRDDnPcSdajwt
        eW3wMzS0AHMUqWq4XbaupsX2NtCMUjcbBSn+Y9VwFP8aQpkbVwGd6wB9SMlMn9Prw9ikwvoAUk6eu
        5t1x/GAkxZcVccvGtWv64rXqZ8tZBUNaEvL2aExFld0M67TVIqc27gNz8aS11APH8Zg8s5oMAZAVx
        yGdxxNHDpct6QOD7a3wclkz9ZmPL+S3EzMdLBIgIWGZRwKGFJUjmi0ZiZmi3q3Gh2th7NcI11aVuK
        itM7ZXbADb3NR9Qfi0dnmiIVk0mni2wbezdQpZfPb3nYHR2LmqnSVsIKSpXfeZ6pc0MVhPGnksUXh
        XeiwezSQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcTjy-00E22a-1p;
        Wed, 15 Mar 2023 16:12:38 +0000
Date:   Wed, 15 Mar 2023 09:12:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org, pmladek@suse.com, david@redhat.com,
        prarit@redhat.com
Subject: Re: [RFC 12/12] module: use aliases to find module on
 find_module_all()
Message-ID: <ZBHudqNmLVsCg4JQ@bombadil.infradead.org>
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <20230311051712.4095040-13-mcgrof@kernel.org>
 <18363c7d-ddec-df1a-8a8e-dd5321499545@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18363c7d-ddec-df1a-8a8e-dd5321499545@suse.com>
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

On Wed, Mar 15, 2023 at 03:43:54PM +0100, Petr Pavlu wrote:
> On 3/11/23 06:17, Luis Chamberlain wrote:
> > Modules can have a series of aliases, but we don't currently use
> > them to check if a module is already loaded. Part of this is because
> > load_module() will stick to checking for already loaded modules using
> > the actual module name, not an alias. Its however desriable to also
> > check for aliases on find_module_all() for existing callers and future
> > callers. The curent gain to using aliases on find_module_all() will
> > simply be to be able to support unloading modules using the alias using
> > the delete_module() syscall.
> 
> Different modules can have same aliases. Running
> 'sort modules.alias | cut -d' ' -f2 | uniq -dc' shows a list of them.

Ah then nevermind then thanks! I'll be sure to document this moving
forwward!

> When a modprobe load of such an alias is requested, my reading is that this
> new find_module_all() logic (if enabled) causes that only the first matched
> module is inserted and others get recognized as duplicates, which doesn't look
> right to me.
> 
> In general, I'm not sure that I understand motivation to keep track of these
> aliases in the kernel. Do you have links to previous discussions that I could
> perhaps read?

The idea was an old one and if it could help, but the above makes the
idea useless, and so the only value for these aliases in-kernel could be
for debugging, that's all.

Removing this will also simplify this patch series anyway.

  Luis
