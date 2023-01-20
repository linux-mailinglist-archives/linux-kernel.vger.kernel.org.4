Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B32675A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjATQhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjATQhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:37:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9405A702AE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674232632; x=1705768632;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=O6wpBdznok9WWQi6tGstvlF0qyv4xAofY8+th1qvITo=;
  b=Tbg/QMdVZcpQNP80PSuKiLpGJRukw/hJhXLi7hyQHZK/IXe5+Q4Y3pIx
   4G07n+ZTf2Is6tMJVx8wqE638cgEtzX1jyP9h96LZGGZJKFayRr8h26d0
   gBMAwsN57ixyxb9JMdtMwC0x2rjmDX+BTYtErlsiLd0OKx81o4a6H6CRC
   qqWpAaa0+Ro6iTHPha6ZVJp1JS/fZ7VdUp6t1fbYMiyYpegZIBr4QSn+t
   wKenz3Xu0Yr1WQGvdeO6RO0kjS9VamO7tuCn3C2vSP9jf1Iz9/I6HqYs9
   aln++fxeu5XjkP+bujVE0cJGdtkNaPugQZ+wMTSBxHhvfvD6chA1I6Y2w
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309190331"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="309190331"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:29:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="638203235"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="638203235"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 08:29:12 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 3/6] virtio 9p: Fix an overflow
In-Reply-To: <20230120074817-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-4-alexander.shishkin@linux.intel.com>
 <20230120074817-mutt-send-email-mst@kernel.org>
Date:   Fri, 20 Jan 2023 18:29:11 +0200
Message-ID: <871qnpqieg.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jan 19, 2023 at 03:57:18PM +0200, Alexander Shishkin wrote:
>> From: Andi Kleen <ak@linux.intel.com>
>> 
>> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
>> index 3c27ffb781e3..a78e4d80e5ba 100644
>> --- a/net/9p/trans_virtio.c
>> +++ b/net/9p/trans_virtio.c
>> @@ -629,7 +629,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>>  		err = -EINVAL;
>>  		goto out_free_vq;
>>  	}
>> -	tag = kzalloc(tag_len + 1, GFP_KERNEL);
>> +	tag = kzalloc((u32)tag_len + 1, GFP_KERNEL);
>>  	if (!tag) {
>>  		err = -ENOMEM;
>>  		goto out_free_vq;
>
> Hmm are you sure there's a difference in behaviour? I thought C will just
> extend the integer to int.

Actually, you're right, integer promotion would extend the original
expression to int. I'll drop this patch also.

Thanks,
--
Alex
