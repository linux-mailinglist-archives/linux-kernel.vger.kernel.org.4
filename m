Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0963273E257
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFZOmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFZOmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE71A1B1;
        Mon, 26 Jun 2023 07:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A5860E55;
        Mon, 26 Jun 2023 14:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CC0C433C0;
        Mon, 26 Jun 2023 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687790564;
        bh=Gab6lcu7mVHazv0MiFHxVMu9wPMkAGpd3kPAvaB3cxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bv0+bJD1hKs+AJk2QCOzLXhOZhBH6NBaUuFc4Lt+UynZ0NFh0WX1B/XNmgQMLAaUn
         pskdIbnWpZDvyFzodwSb8wN8g27l4Ka1lhtxEfN+h7rfpjsg1Yy1KwNKhoZ2gK8bGf
         6WOtz6Cg9zVGBcePe03vxaxVASN/Att+E2NxN8Mc=
Date:   Mon, 26 Jun 2023 16:42:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min15.li@samsung.com>
Cc:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: add check that partition length needs to be
 aligned with block size
Message-ID: <2023062625-macaw-chant-e515@gregkh>
References: <CGME20230626091207epcas5p2a2957dfe97c4d82e39defa557d7ffd0e@epcas5p2.samsung.com>
 <20230626171021.5895-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626171021.5895-1-min15.li@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 05:10:21PM +0000, Min Li wrote:
> Before calling add partition or resize partition, there is no check
> on whether the length is aligned with the logical block size.
> If the logical block size of the disk is larger than 512 bytes,
> then the partition size maybe not the multiple of the logical block size,
> and when the last sector is read, bio_truncate() will adjust the bio size,
> resulting in an IO error if the size of the read command is smaller than
> the logical block size.If integrity data is supported, this will also
> result in a null pointer dereference when calling bio_integrity_free.
> 
> Signed-off-by: Min Li <min15.li@samsung.com>

What commit id does this fix?

thanks,

greg k-h
