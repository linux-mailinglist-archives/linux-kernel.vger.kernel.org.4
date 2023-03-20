Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8029D6C1283
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCTNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCTNAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:00:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C5193D4;
        Mon, 20 Mar 2023 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+crC4dGYsz6T67x08q4z29IFmwO1ZpfQLhOdC3e6Aw8=; b=4YcwwUhnutcuyzWQ8rvJd5hPw8
        yNdL1CfyZXNDmF9BYcuE7B35iFZMmSHv3SLi9AGW+B07w6xasyrV8hM43RLboep9DG7iXLTkyvVUw
        hRdJLkRyTn8t9jyw3ruR6+X29aPCnXdaYX4nZ1gnldqUuZRLD57P08bkyecBNKVYAe+B89uJ4pnhH
        Z27mgh2IwuxyfBSkA6r7tEF20rH5mA5bpP+M4Aami04F7HWSRsU85+Ueu/J8ahVSPz9rnUrOa1jGC
        xKas1swgd+vCVxxEH1EwXV3YgL6B39nRF85qGzdA+7DRtRlrI/mgUHNi4fMn3eB8wxO6EG2THwvaj
        rWEtdvvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peF7f-0092BU-2v;
        Mon, 20 Mar 2023 13:00:23 +0000
Date:   Mon, 20 Mar 2023 06:00:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, martin.petersen@oracle.com,
        jejb@linux.ibm.com, bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
Message-ID: <ZBhY5wL9W/QDwIfE@infradead.org>
References: <20230310123604.1820231-1-chao@kernel.org>
 <ZAs4h2Mu90u4gc3/@infradead.org>
 <9e3ffff0-6cc8-b01a-4d2e-5ec49a936415@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e3ffff0-6cc8-b01a-4d2e-5ec49a936415@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 09:44:47AM +0800, Chao Yu wrote:
> IIUC，originally, HPB driver tries to lookup LBA range{,s} from WRITE/DISCARD
> request, and will dirty mapped HPB regions based on LBA range{,s}, do you mean
> HPB driver should not parse DISCARD request?

Eww..  This just means we really need to drop this bogus HPB code.
It will otherwise break every single time when a new SCSI command get
added that modifies LBA content.
