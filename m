Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7FE5F8A38
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJIIn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJIInX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59FD2B263
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665305000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYS4uJjG8NOAqQO/6mCNiUr/KBmDt3on4NuOsmdeooA=;
        b=YqPLVR5JSOVlZoZz/oSZ9gXqe/shgBXmZcN8CSBmHZ+Vzb0jQ6xXMAu7iwdqbkOw7NB1FW
        vnKcxBfFUrGDsWpm505KpCqk47aZZuR5TPHzIWCE0rDC9NoP1Qdm1ot6cRPaBvo9fRnK6g
        I6H3QyOQekOZ2Oez6bMgwoanFnnX/Is=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-lKnXu4bsPLK-M9Mw6MG34A-1; Sun, 09 Oct 2022 04:43:17 -0400
X-MC-Unique: lKnXu4bsPLK-M9Mw6MG34A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6F6C29AA3BD;
        Sun,  9 Oct 2022 08:43:16 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB9D82166B4D;
        Sun,  9 Oct 2022 08:43:09 +0000 (UTC)
Date:   Sun, 9 Oct 2022 16:43:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [blk] 8c5035dfbb: fio.read_iops -10.6% regression
Message-ID: <Y0KJmODYOh83OtGa@T590>
References: <202210081045.77ddf59b-yujie.liu@intel.com>
 <d5279fc2-38b3-6d20-4404-604d5c7277e2@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5279fc2-38b3-6d20-4404-604d5c7277e2@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 04:00:10PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2022/10/08 10:50, kernel test robot 写道:
> > Greeting,
> > 
> > FYI, we noticed a -10.6% regression of fio.read_iops due to commit:
> 
> I don't know how this is working but I'm *sure* this commit won't affect

Looks it is wrong to move 

	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));

before rq_qos_add() in wbt_init().

Without adding wbt rq_qos, wbt_set_write_cache is just a nop.


thanks,
Ming

