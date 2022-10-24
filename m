Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CA60B94E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJXUIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiJXUH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:07:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE04082875;
        Mon, 24 Oct 2022 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sD1/9KUepwxnnbZHmOxcQ0nb2LDnGCi+U3tMVxTFuSE=; b=ShSp2+NTgj4NbO//OTI9ybjHre
        /+4idaGTfOP2cZZepFuVzG6VTj106A725AmvchWCyGPhWW0ULuEu9DESP6S6HnDAZcwb/1eiFs/Ci
        j5KU9irR0d90+K8+3LNua77wdl1V/SNAlKyMa/t7P4h2siKyDhWQ6pyEHXHIrybXYLUutHjNs+QHK
        nhFt5+e0jO/84nYFbMU3YyCT27pYCUZFLRZuUQcj1KLM9OcabmPUK6f8sQY93XZBo642wxbKfXltd
        aw1qFRMAKxER3crTMWbM10pDCoXSJKAtbHaxOXAIv1nUG8KRZtBNUY3iMbLLUKak3RZjS0oBe4a1r
        AWDX7Z2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on0me-002PNe-1e; Mon, 24 Oct 2022 16:58:40 +0000
Date:   Mon, 24 Oct 2022 09:58:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     jejb@linux.ibm.com, Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Message-ID: <Y1bEQMS5SNTbZO/3@infradead.org>
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
 <30a056c8-071f-4259-3253-75e718af619d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a056c8-071f-4259-3253-75e718af619d@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 03:20:43PM +0200, Juergen Gross wrote:
> Dom0 is (normally) a PV domain, so the physical memory can be still above
> 4 GB even with dom0_mem set to 4GB.

Which means that we need to ensure the DMA ops for Xen-PV (which is
always xen-swiotlb I think?) need to return DMA_BIT_MASK(64) or whatever
is the highest possible address.
