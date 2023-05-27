Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4486713218
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbjE0DNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjE0DN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:13:26 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCDEA
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:13:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=durui@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjYXb68_1685157200;
Received: from localhost(mailfrom:durui@linux.alibaba.com fp:SMTPD_---0VjYXb68_1685157200)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 11:13:20 +0800
From:   Du Rui <durui@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com
Cc:     agk@redhat.com, alexl@redhat.com, dm-devel@redhat.com,
        durui@linux.alibaba.com, gscrivan@redhat.com,
        linux-kernel@vger.kernel.org, snitzer@kernel.org
Subject: Re: dm overlaybd: targets mapping OverlayBD image
Date:   Sat, 27 May 2023 11:13:19 +0800
Message-Id: <20230527031319.92200-1-durui@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <ac8519fd-85f4-e778-0c6c-b2e893a37628@linux.alibaba.com>
References: <ac8519fd-85f4-e778-0c6c-b2e893a37628@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Block drivers has nothing to do on filesystem page cache stuffs, also
> currently your approach has nothing to do with pmem stuffs (If you must
> mention "DAX" to proposal your "page cache sharing", please _here_
> write down your detailed design first and explain how it could work to
> ours if you really want to do.)

We have already done experiments (by virtio pmem), to make virtual PMEM
device in QEMU, make guest vm sharing only one memory mapping on host,
with filesystem that supports DAX. In guest vm, fs keeps no page cache,
maybe "sharing pagecache" is not such accurate description, but sharing
memory pages on host can do prevent making duplicated pagecache pages in
VMs.

Please make sure that you have already understood that dm-overlaybd are
for GENERIC purpose. It is NOT a special design for container, and have
nothing related to filesystem implementations.
