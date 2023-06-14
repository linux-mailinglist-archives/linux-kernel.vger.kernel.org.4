Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761B6718B60
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjEaUlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 16:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjEaUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:41:37 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF098121
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:40:46 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-75b050b4fa0so653371585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685565646; x=1688157646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2MHMFRCtTpRq4HekvDMncZqof6fHitP/tkQ4Bwp4iw=;
        b=d5hiM6SMZe3g0Y85lj1v7hh45KG6r/L9rXoKoWKCLSE2vSoATw8sqAwwBZB3ajq5UV
         KqL+hVPTuFG4inL/CXS36kezHphHsrGqH2Vk7BzcgLuhYIDBsjD3JyqXm9g0Y41ZoFE2
         aNzLsj7rEY07aUnaG1sZYEeVFpiZYHx0hO3TsJBBVmilzXRwRBE5ykG/rKKMXuLpIeA2
         tResy7h1bah2RtxdWzp/3FQeAzH32BiWCjlE8xBrFk1K46S+EbLPvit+9VNqWRQ7zRm5
         gnGzec96bqqu2a9SSaVS/Q1IyBz/Iahg0G8vYOP0OyRmYB+FMidi9KAXAIl+5YkHQNBU
         teJg==
X-Gm-Message-State: AC+VfDzC64KcSz29VOG8AKTvj8s0dVxuIotSeJ/oyn0Voa/XHSMkm9qu
        lKbkedlxLpd8w+rMRLSnW/DF
X-Google-Smtp-Source: ACHHUZ5kdx7S499hJRV8/H2S3RWG6Tr6vcGeL7BQ9XuPUWxOMtGzpZSxerK1wVcQWCuUeme2JGtCZA==
X-Received: by 2002:a05:6214:d85:b0:616:5f27:b96a with SMTP id e5-20020a0562140d8500b006165f27b96amr7207768qve.27.1685565645712;
        Wed, 31 May 2023 13:40:45 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id s12-20020a05621412cc00b005fe4a301350sm6354991qvv.48.2023.05.31.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 13:40:45 -0700 (PDT)
Date:   Wed, 31 May 2023 16:40:44 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 1/5] block: Don't invalidate pagecache for invalid
 falloc modes
Message-ID: <ZHewzOfOdXu+kN75@redhat.com>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <20230518223326.18744-2-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518223326.18744-2-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18 2023 at  6:33P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.
> 
> Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
> Cc: stable@vger.kernel.org
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

Jens, this one is independent of the rest of the patchset and should
be ready to go upstream whenever you are able.

Thanks,
Mike
