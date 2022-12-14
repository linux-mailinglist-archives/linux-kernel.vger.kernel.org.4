Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CA464C265
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiLNCwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiLNCwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E721E00
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670986288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qQk9ADgibSy8NmUYT5gPp7mGF+QH9fTOK/8Sedoi10U=;
        b=ZaEd4ptxnj+GQdJEeThD4SSknkRlofBrK7Hw7XwoYK9aXIFgBR9dUfqvxK2XGFInDM/gnb
        GMUaQi62PmEEZmv65+Nv0yqgtPag2A5h4VmQE7t3vLbbvAj4EPJagbPu6YYPX5IVOkIWC8
        l3CtKcypJHTUf3iiR1owQqqZBhhok/c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-l95CNPfmNyibDInMNjPGhA-1; Tue, 13 Dec 2022 21:51:19 -0500
X-MC-Unique: l95CNPfmNyibDInMNjPGhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B0A985A5A6;
        Wed, 14 Dec 2022 02:51:18 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 630052166B26;
        Wed, 14 Dec 2022 02:51:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Dennis Zhou <dennis@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] lib/percpu-refcount: fix use-after-free by late ->release
Date:   Wed, 14 Dec 2022 10:50:58 +0800
Message-Id: <20221214025101.1268437-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The pattern of wait_event(percpu_ref_is_zero()) may cause
percpu_ref_exit() to be called before ->release() is done, so
user-after-free may be caused, fix the issue by draining ->release()
in percpu_ref_exit().


Ming Lei (3):
  lib/percpu-refcount: support to exit refcount automatically during
    releasing
  lib/percpu-refcount: apply PERCPU_REF_AUTO_EXIT
  lib/percpu-refcount: drain ->release() in perpcu_ref_exit()

 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  4 +--
 include/linux/percpu-refcount.h        | 36 ++++++++++++++++++++++++--
 lib/percpu-refcount.c                  | 31 +++++++++++++++++++---
 mm/memcontrol.c                        |  5 ++--
 4 files changed, 66 insertions(+), 10 deletions(-)

-- 
2.38.1

