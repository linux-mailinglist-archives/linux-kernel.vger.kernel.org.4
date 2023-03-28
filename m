Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FE76CB34B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjC1Box (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC1Bov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:44:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6068E;
        Mon, 27 Mar 2023 18:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yiAuOvNscONHKuowuI7HPYf77O2fp0glVUU+c2+auVE=; b=DZ6krAY2JsYaX67+UjU/+As5YC
        bCJzMrVwBrXnwljWtkhhKTI+tneNR+5PJYmO12KAbAmuJX3yTTc/rD7gbEG5BwjL7WahvM16V9ey9
        uLIAzejFUMiXPiDdjWy5rYxjTakhPcg2xPFu1U0XnkBsFapLFWwr9NaP6CXea6JFDj7HswJRjVsGe
        qEUqk2sO8EUP4mq5e1gLb4Q5inbHtX8wEDqT8YKv++q6EsQvYk6W8etr3eiIKwLehZmG1DzuKyIhJ
        9db9sQP3xXIT0ExLuuxMqovuAIjWc3FgTuyD+aMgPEQTvWJYqUm18AYs5ceoxhSGUbEs3hrPSlg3b
        YvK13GDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgyOF-00CoIS-3A;
        Tue, 28 Mar 2023 01:44:47 +0000
Date:   Mon, 27 Mar 2023 18:44:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ye Bin <yebin@huaweicloud.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs: fix BUG_ON in xfs_getbmap()
Message-ID: <ZCJGjxfyeIebn0vj@infradead.org>
References: <20230327140218.4154709-1-yebin@huaweicloud.com>
 <20230327151524.GC16180@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327151524.GC16180@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 08:15:24AM -0700, Darrick J. Wong wrote:
> [add Christoph to cc since he added/last touched this assert, I think]

I only really moved the ASSERT as part of an interface rewrite.  I'll
try to throw in my 2 cents anyway..
