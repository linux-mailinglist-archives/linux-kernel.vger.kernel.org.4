Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D786D0D33
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjC3Rzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjC3Rzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:55:35 -0400
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1EE068
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:55:30 -0700 (PDT)
Date:   Thu, 30 Mar 2023 13:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680198929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPNJJiq4961Alex7wQuB9qz7b+RqDrA7sJot4b5JPCY=;
        b=u6UMhIg/xEzp2vBN3rKqogxCAl7TFQsZEJYnKjGtnkWRaFbBjMQ4xxuRANBOMqYc4Z7gNK
        BcAVOewzeCnqa4h1D2kfMiXeb1OScqJNzflLOLJrJf52cZbGFl5CexDdB/QohKoWoLS4QK
        pDiEozbTfDu45VmH4hb4k7eLukgq6r4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] block: Rework bio_for_each_segment_all()
Message-ID: <ZCXNDQ6Eslhj+9g5@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-2-kent.overstreet@linux.dev>
 <52a5bd5c-d3a1-71d7-e1e5-7965501818bd@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a5bd5c-d3a1-71d7-e1e5-7965501818bd@squashfs.org.uk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:50:27PM +0100, Phillip Lougher wrote:
> There is a problem with the above code, on testing I get the following
> results:
> 
> Index 78018785329, offset 49, bvec.bv_len 1024: In same bio, metadata length
> 32780

Could you share how you're doing your testing? I set up a basic test
(created images using every compression type, tested reading them) and
so far I'm not able to reproduce this.
