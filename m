Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50C865512A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiLWODU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:03:17 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DE0644A;
        Fri, 23 Dec 2022 06:03:16 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2240568AA6; Fri, 23 Dec 2022 15:03:13 +0100 (CET)
Date:   Fri, 23 Dec 2022 15:03:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] vmalloc: reject vmap with VM_FLUSH_RESET_PERMS
Message-ID: <20221223140312.GA26826@lst.de>
References: <20221223092703.61927-1-hch@lst.de> <20221223092703.61927-3-hch@lst.de> <Y6WB2ZGoL7FaFK+f@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6WB2ZGoL7FaFK+f@lucifer>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 10:24:25AM +0000, Lorenzo Stoakes wrote:
> Might it be worth adding a specific vmap mask that explicitly indicates what
> flags are permissible on vmap()? Then this could become e.g.:-
> 
> 	if (WARN_ON_ONCE(flags & ~VM_VMAP_PERMITTED_MASK))
> 		return NULL;
> 
> And would be self-documenting as to why we are disallowing flags (i.e. they are
> not part of the permitted vmap mask).

That's probably a good idea.  It might need some time to audit
for use of all the flags, though.
