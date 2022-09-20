Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7005BDE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiITH0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiITH0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:26:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E951A35;
        Tue, 20 Sep 2022 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qteLBBo7gVyIzY+cqTBV2I+NHOr6YHBw0FIcyQI9tp8=; b=U3km51K/9URRR722eOD617czlB
        kqYZuclNDxR6GAVHQG3rJZMaxuqea8tUvU/koafALedar/8WuJg+KJyLEcsxoXQJByN3xPoakhMPJ
        McLagTM5reMYyM+mDumkJtDVs5/+tUkMbn5vLgLPvsygRLLzh8gJuUluxOZOtOZyrR1raZN8lIQor
        0Msm8hPNHjhhNr4I5brlzrtuOyyRV2Xh/TkvUNtjgyfONhZ7B7LC3xcst135iXYeUB9hKvkX5Ej78
        EomQxwVHT7hkQvUVfVUSIxO126iYx9NuGH/aSRN7sRx8oyBpXjRNwF6SuleSfBnyNEktiOCW7eQdy
        yKds+8xA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXdh-001LTm-Vw; Tue, 20 Sep 2022 07:25:53 +0000
Date:   Tue, 20 Sep 2022 00:25:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v2 3/3] blk-wbt: don't enable throttling if default
 elevator is bfq
Message-ID: <YylrAbQ75wCAj5va@infradead.org>
References: <20220919070916.2738443-1-yukuai1@huaweicloud.com>
 <20220919070916.2738443-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919070916.2738443-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matching names is always is a bad idea.

Just ad a flags field to elevator_mq_ops, add a DISABLE_WBT flag
to it, and check for that and everything should become much, much
simpler.

