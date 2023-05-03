Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9BA6F5B93
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjECPzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjECPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:55:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7E6EB8;
        Wed,  3 May 2023 08:55:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E76E68AA6; Wed,  3 May 2023 17:55:02 +0200 (CEST)
Date:   Wed, 3 May 2023 17:55:01 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/15] block: blk-integiry: add helper functions for
 bio_integrity_add_page
Message-ID: <20230503155501.GB31700@lst.de>
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4> <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p3> <20230503100220epcms2p33e69fd7d5f04b305c621799792e8155f@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503100220epcms2p33e69fd7d5f04b305c621799792e8155f@epcms2p3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/blk-integiry/blk-integrity/ in the subject.

> +static inline bool bip_full(struct bio_integrity_payload *bip, unsigned int len)

> +static bool bip_try_merge_hw_seg(struct request_queue *q,
> +				 struct bio_integrity_payload *bip,
> +				 struct page *page, unsigned int len,
> +				 unsigned int offset, bool *same_page)

... but adding static functions without users will cause a compile
error anyway, so I'd suggest to just merge it into the patch adding
users.

But I wonder if we really want to duplicate all this logic anyway.
If we passed a bio_vec array, the vec count and an iter, we should
be able to just share the logic with the bio data payload.
