Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC06B4272
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjCJOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjCJODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:03:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87993F8;
        Fri, 10 Mar 2023 06:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=32YGKG3ZrlhBGDQG6eI/L9mbKOd387mZfJEcK12WmaY=; b=meAwlmeZzy/oqHwZsp/bzke2JP
        tAla67x+tTCnPp5qJSQ8iWYfKGvd1GYqCbXyl/5j+y/fBW6GQktPpyj2v0aMaEqgvRyE8EN9f/EWG
        9unCk+8rBLIQkfV5SKgYxMhR50muNLswJkLhkyNKSv7aPYHtGc9EQgjzU9uIlbrCwPmBAwiIOy13N
        /ktFNIRW8NWoTDdXrE692RDVs6Q3+iF7G756TkP411KynuYqjPLXPMldsTbz1f4EedLZQLHbSo5yk
        ARDLy7qhoE+e+WabbL7OQ4uYQX3Yp240THSvuGzPMA91z87WhytgZddz2rJ+pVB9JfUUupkUvJPgB
        gno8gU3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1padKZ-00Eg1r-Rk; Fri, 10 Mar 2023 14:02:47 +0000
Date:   Fri, 10 Mar 2023 06:02:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Yu <chao@kernel.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com, bvanassche@acm.org,
        hch@infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
Message-ID: <ZAs4h2Mu90u4gc3/@infradead.org>
References: <20230310123604.1820231-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310123604.1820231-1-chao@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	/* If command type is WRITE or DISCARD, set bitmap as dirty */
> -	if (ufshpb_is_write_or_discard(cmd)) {
> +	/* If command type is WRITE, set bitmap as dirty */
> +	if (op_is_write(req_op(scsi_cmd_to_rq(cmd)))) {

Umm, a driver has absolutely no business poking into the UNMAP
payload.   Someone needs to fix the UFS driver first to not do this.
