Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9C6CB214
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjC0XCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjC0XCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:02:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5608D1FF3;
        Mon, 27 Mar 2023 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pX5mbDI4mPib0i+fafxYiU/1Pb3MyNg+wGAHRkR1vfY=; b=wrZBwDV5pKDLzuuoVkC1O+gwaQ
        OLlh83Ze53CQKJNqbfyLOXpUfro7/eBuk691x6bbcqd5C2J9xgBavy7Zr8HanfT8uM3W5ikJp/x5q
        UxCnNFBTeixwr4CXYFaySZnaD0wVoR7OltZ6Plt1AINHfkoqsMf2nr/owaY+XfivpYFZHhucnua8U
        aSnoIh9IL79691Bsgxw3wO/Q0ufduFssfD0OVtSMInWwrpAfd4E9HCvrENz7j+3lsPs9TIcNPG0I+
        DU2KNEq82Ebf787KS8m/kwXtJjsMiISV2JUWomfQfrSIDxBNZYIh0gv5ywUeSwxzE0pD20B1CyPdA
        ySJR2QQQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgvqk-00Ccn0-0U;
        Mon, 27 Mar 2023 23:02:02 +0000
Date:   Mon, 27 Mar 2023 16:02:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: annotate bdev_disk_changed() deprecation with a
 symbol namespace
Message-ID: <ZCIgavqUnw0Z3A3t@bombadil.infradead.org>
References: <20230327184410.2881786-1-mcgrof@kernel.org>
 <ZCIVx2UNN8VAWYAH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCIVx2UNN8VAWYAH@infradead.org>
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

On Mon, Mar 27, 2023 at 03:16:39PM -0700, Christoph Hellwig wrote:
> On Mon, Mar 27, 2023 at 11:44:10AM -0700, Luis Chamberlain wrote:
> > Instead of relying on fragile documentation which can easily let us
> > slip, use a symbol namespace to annotate which symbols should not be
> > used by others.
> > 
> > This ensures no other users pop up by mistake easily and provides
> > us a with an easy vehicle to do the same with other routines should
> > we need it later.
> 
> I don't think deprecated really cuts it.  For these two drivers we
> can't really get rid of the calls as it is part of their ABI.

Ah yes.

> What I'd really want is something like an
> 
> EXPORT_SYMBOL_FOR(bdev_disk_changed, loop, CONFIG_BLK_DEV_LOOP);
> EXPORT_SYMBOL_FOR(bdev_disk_changed, dasd_kmod, CONFIG_DASD);
> 
> Which ensures that the symbol lookup only succeeds for loop.ko and
> dasd_kmod.ko, and that the export only happens if the relevant
> symbols are set.

I think that could be done, sure.

  Luis
