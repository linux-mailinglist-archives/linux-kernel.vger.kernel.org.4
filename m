Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF26C126D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjCTM5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCTM4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:56:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F125818B1E;
        Mon, 20 Mar 2023 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ADLNbCBgARDvGliHTHsRdELELKEzlWyTEbb1tm2A9/c=; b=GMRbDaSTe+fcRst0OrIuX0irjc
        Na41Xcouc+1VcuTRyNwCUNGMZvIskZisv6JaurOnwGkqpHzXkPtV+48aJeU78jwYvy6FyQrcqQUJX
        Hk+ISH5eVK+k4PHookOCMR4wRxHqyNwTYxOM0kwO5WA+lKpJ2qzqjCPW0K4/yXv9MQICPnnq1b6cx
        /w4VMJXqUCWgU3K3G3pLDzJ2hOC8x2Js9HOgycgVgXOXWXIoFsLfMncosIn/tHhbyREnjKdYeC7lP
        wjKHW7sgFi61LOE7Gp29R/CdS4oY7w8USgxDhsp8SKxB/WxmsRxppbt8VFTxnykM3uF/o2SBKpGJj
        Widf4exw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peF2V-0091J8-13;
        Mon, 20 Mar 2023 12:55:03 +0000
Date:   Mon, 20 Mar 2023 05:55:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Subject: Re: [PATCH] scsi: ufs: support IO traces for zoned block device
Message-ID: <ZBhXpyeg5zo6DOyi@infradead.org>
References: <20230215190448.1687786-1-jaegeuk@kernel.org>
 <Y+3GzX6yMOKUFTh3@infradead.org>
 <Y/05p0jYrg2wfXw6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/05p0jYrg2wfXw6@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:15:51PM -0800, Jaegeuk Kim wrote:
> On 02/15, Christoph Hellwig wrote:
> > Why does UFS even have it's own common tracing instad of just relying
> > on the core SCSI one, and even worse pokes into command set specifics
> > which is a no-go for LLDDs.  This code simply needs to go away instead
> > of beeing "enhanced".
> 
> I'm not sure how all the other vendors use the trace tho, at least to me,
> it's quite useful when debugging any UFS-specific information such as
> group_id

The group ID isn't even ever set, how can it be useful to you?
