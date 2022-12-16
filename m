Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7C164E7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLPHNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLPHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:13:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375C72E68C;
        Thu, 15 Dec 2022 23:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rbdP76tLSLd0zXbJ7Ayy7yAOCBynRgWdD+HyAwvTvH4=; b=m0+OLoWtPz8unWkSr4hKaAJVp7
        FCyWa6+VyYFNVyBxJLY/OYIvymTzNjmoPqxgATo04jrLoz55cV6sENFU0SpPjK3SEtABL/MBJ+Cg1
        /jd9QApAUcLaqH7FJt5TLDU2Uh9MP5A6bQjweSuCrenwOMOpCIQ3IhppLY31fLPLIMCyFEHgBJPn+
        8e59gq9nDL2lQNjwRul99jyClPji6Lu6z3MH4b+SaqtXxGHzDliH2ZDI9bj0drxvpqxzfjIEqkCGH
        I6UcdeKfCzvV3S2NXQz2PQU804l4yQa1hzThOOu28DGd6MaNMk4iy3zlT5HJgaNlf/fdrjjqy/vhl
        cDSZ8IRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p64sD-00DKqT-10; Fri, 16 Dec 2022 07:11:13 +0000
Date:   Thu, 15 Dec 2022 23:11:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     haowenchao@huawei.com, open-iscsi <open-iscsi@googlegroups.com>,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        michael.christie@oracle.com, Chris Leech <cleech@redhat.com>,
        Lee Duncan <lduncan@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Antw: [EXT] Re: [PATCH 0/2] scsi:donot skip lun if inquiry
 returns PQ=1 for all hosts
Message-ID: <Y5waEc0iqfGkkN7f@infradead.org>
References: <20221214070846.1808300-1-haowenchao@huawei.com>
 <Y5rHX95Vvl1aLhbp@infradead.org>
 <639AD5C0020000A100050749@gwsmtp.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639AD5C0020000A100050749@gwsmtp.uni-regensburg.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 09:07:28AM +0100, Ulrich Windl wrote:
> Actusally I have no idea, but as a user of FC SAN systems I can remember a case when a storage system had to present a dummy LUN0 to enable hosts to find other LUNs (while LUN0 was never actually used). Maybe the client code was imperfect, I don't know.

Ignoring some of the well known LU bits that never really became
practically relevant, lun0 is needed to use the REPORT_LUNS command
to scane for the other logical units.  But unless the PQ says it
actually is a valid logic unit, we never add a sdev for it.
