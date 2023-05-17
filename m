Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A451F706401
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEQJVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjEQJVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:21:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290ED4495;
        Wed, 17 May 2023 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=81YOFZSHjnf1JcYzLoU/VUaJMnEqM1w8O3ew3wo1Z8g=; b=oyDtW7h7lIi/s2Ib4UPKrov9Ef
        gcOpoQqjHci1O7fI6eEAKR5Zgt0ePsISRbKOJ2RwOuvGlBa9XB7dWn7TRRTtLwlsj/aHcDkSg1WvE
        a7QMikgY9SgBya+gjoz9OzJHg3ByNgRCZUtq2Ecf86i7oo1+dvQvsNX7VPRZn7q0wleV0VLkrdL5f
        JHTVEnnHIdVaqYFkeeP6wB4LFkRb36o6BJUqBAvWe7HNPMZFKqsXwGyIwe4Xh4arG9TGmVLMlkqpS
        LnwLV6+PVdW+dlMDVylYH/uoxM29gYbBAS+WNMIwc/ZHr0m/iE5yNEkOiyez0f7uaEZ0kJSjrp1eZ
        wkODJbSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzDLk-0092Ls-2o;
        Wed, 17 May 2023 09:21:36 +0000
Date:   Wed, 17 May 2023 02:21:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Pradeep P V K <quic_pragalla@quicinc.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
Message-ID: <ZGScoCeOILHpc8c1@infradead.org>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
 <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
 <a2f86cd7-776c-d7ed-8815-62683a14ba36@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f86cd7-776c-d7ed-8815-62683a14ba36@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 06:20:19PM +0900, Damien Le Moal wrote:
> twice for the same icq. The missing rcu lock in ioc_exit_icqs() already was in
> itself a bug, and the missing flag check is another.

spinlocks imply a rcu critical section, no need to duplicate it.
