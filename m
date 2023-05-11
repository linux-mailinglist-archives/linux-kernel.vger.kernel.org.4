Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23D76FF610
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbjEKPeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjEKPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:34:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D755B9;
        Thu, 11 May 2023 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xhaK2YJhS01Edz36x6rlrMEpbRMzClC0qIef6ZatYys=; b=hUKHDIOfLOGJGTM8PG9Bw/V/Zq
        fiVPS0DcKvzGZEe90/nK8LG5GKM250qzdASPE0J3N3qRRbIJnAPK1F37gHnlf7hZC8c9RPHXccVNB
        8zAHo3aWRcONC27CkFLKcPljIQXE4SDhCqrau/MODBh/dAypgVg1So9NKfl2uxBDXsD9wrkUecD/N
        ozhvC/yHBvn8uA4oGk4bYJf4yc/hXZXw7lhwREJ1VsBItvPJb3zZickbwFk7FpTmsZEfus8qtWSSj
        lqlsFZorU/8OJznHZXHGCNUOVaQOqjbubnFy9PzpX9XbgSlYfSRtFBTOEbQGTeUl5GQdg60rB6Miz
        +bpHk0RQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1px8Iu-009DtS-30;
        Thu, 11 May 2023 15:34:04 +0000
Date:   Thu, 11 May 2023 08:34:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/2] ufs: don't use the fair tag sharings
Message-ID: <ZF0K7A6G2cYBjSgn@infradead.org>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509065230.32552-3-ed.tsai@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 02:52:30PM +0800, Ed Tsai wrote:
> The tags allocation is limited by the fair sharing algorithm. It hurts
> the performance for UFS devices, because the queue depth of general I/O
> is reduced by half once the UFS send a control command.

But it is there for a reason.  You completely fail to explain why you
think your change is safe, and also why you did not try to even explain
where the overhead is and how else you tried to mitigate it.
