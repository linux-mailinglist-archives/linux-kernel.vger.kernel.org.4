Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5933A60B969
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiJXUKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiJXUIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:08:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64E340039;
        Mon, 24 Oct 2022 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rmYsPiQAe01mPUbVVVEiS6SzJmrWKoOMvVqAUcXlI3E=; b=tv4ds0D7DIvDaukA98ZSEiuXsj
        5bqFYvG7Kxc26coWWzyB01UmgmfRdJ9NHPgGN6+MQ7K4t49rWSudQCsuaeA2oImMNf7NVrvZZ9/uD
        LvzpmEf/Q3O+XSsEElVRnf67XBDZEQpKYSLXlClNzP2bbrz/OL+1qNcB8wfxo54awzWM5rIQW5SQ/
        mR7WVWNmsqKU02JvuN3+2ectX7Y6LsXwS8vxfIVuIqrpT2VhpH1Qyb4ulEE9SK5kFgYa/qJZTiELn
        BbRs/CqIvv5s4bT0EFrEYnFdKZlIxXYw4/DTUf4Iv1wnoozDaByH7HaF9dz2HWVwJ+sJRQ7vuPAgn
        7hdtcQuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on1Jk-002Tzq-40; Mon, 24 Oct 2022 17:32:52 +0000
Date:   Mon, 24 Oct 2022 10:32:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "adi@kriegisch.at" <adi@kriegisch.at>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Message-ID: <Y1bMRNhmq41/y3Jb@infradead.org>
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
 <30a056c8-071f-4259-3253-75e718af619d@suse.com>
 <Y1bEQMS5SNTbZO/3@infradead.org>
 <858a4288-46ac-d423-a529-b3b77b7fbc8a@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <858a4288-46ac-d423-a529-b3b77b7fbc8a@citrix.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 05:28:05PM +0000, Andrew Cooper wrote:
> I don't know exactly how this translates to Linux internals, but most
> devices are fine and it's routinely the mpt2/3sas drivers which
> encounter problems.  It would be lovely if we could get to the bottom of
> this for once and for all.

So to summarize my two mails:  I think te use of dma_get_required_mask
in mpt3sas is wrong, and the dma_get_required_mask return value from
xen-swiotlb is also wrong.  Fixing either one should fix this problem,
and I think we should fix both.
