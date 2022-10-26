Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A0660E586
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiJZQep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJZQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:34:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAB32D1CF;
        Wed, 26 Oct 2022 09:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CEF8B82381;
        Wed, 26 Oct 2022 16:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4D8C433B5;
        Wed, 26 Oct 2022 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666802078;
        bh=0OyATpcFpMtfgLWCG8arPflGf4wLgAo29PwRBcaXU7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rq4Mxi0kWqi0Mf0HO1Sk3X9j00MMjiOG5P1k57nofpBmBYYBaCEN33upwhoXThPIu
         UGAM7fKsz41ESBlW61TjPC/44dX1Ur+8aBRoS7HcBTwyoZXFIp86AboZ/npjFjgJ9x
         SO+abeadcBXvIxQe+RTsvyAi4WWpOGMwhYESo833sWWHgbV8JwN4OCysriP+C4hRl1
         RDwX1C9+ro8LPN5InnwxBVFcMFMqk5X7YCjFAfofZTAG7JKCMf+mY2ekd4PlAIw1Sp
         P1k9I4+QnEjhBt5N7CdBd+W0GEm3PuDn5GRjUR8Msy2KAxrR4hDn4vNrEF8W56TteL
         PsvDdBFS4FCfg==
Date:   Wed, 26 Oct 2022 10:34:35 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Dawei Li <set_pte_at@outlook.com>, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: simplify blksize_bits() implementation
Message-ID: <Y1lhmzQ9L2vxJzns@kbusch-mbp.dhcp.thefacebook.com>
References: <TYCP286MB2323169D81A806A7C1F7FDF1CA309@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <30ea2fa3-0e4d-788b-b990-3bdb9e687377@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ea2fa3-0e4d-788b-b990-3bdb9e687377@acm.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:29:21AM -0700, Bart Van Assche wrote:
> On 10/26/22 08:14, Dawei Li wrote:
> > Convert current looping-based implementation into bit operation,
> > which can bring improvement for:
> > 
> > 1) bitops is more efficient for its arch-level optimization.
> 
> As far as I know blksize_bits() is not used in the hot path so performance
> of this function is not critical.

blksize_bits() is used on every IO going through iomap_dio_bio_iter(),
though the usage there is completely unnecessary and can be removed.
