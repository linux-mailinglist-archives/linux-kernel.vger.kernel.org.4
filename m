Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E7712496
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbjEZK0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjEZK0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:26:38 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38584FB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:26:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=durui@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VjW4Oiz_1685096793;
Received: from localhost(mailfrom:durui@linux.alibaba.com fp:SMTPD_---0VjW4Oiz_1685096793)
          by smtp.aliyun-inc.com;
          Fri, 26 May 2023 18:26:34 +0800
From:   Du Rui <durui@linux.alibaba.com>
To:     alexl@redhat.com
Cc:     agk@redhat.com, dm-devel@redhat.com, durui@linux.alibaba.com,
        gscrivan@redhat.com, linux-kernel@vger.kernel.org,
        snitzer@kernel.org
Subject: Re: Re: dm overlaybd: targets mapping OverlayBD image
Date:   Fri, 26 May 2023 18:26:33 +0800
Message-Id: <20230526102633.31160-1-durui@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <CAL7ro1FPEqXyOuX_WPMYdsT6rW-bD5EU=v=oWKsd6XscykLF6Q@mail.gmail.com>
References: <CAL7ro1FPEqXyOuX_WPMYdsT6rW-bD5EU=v=oWKsd6XscykLF6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

> all the lvm volume changes and mounts during runtime caused
> weird behaviour (especially at scale) that was painful to manage (just
> search the docker issue tracker for devmapper backend). In the end
> everyone moved to a filesystem based implementation (overlayfs based).

Yes, we had exactly the same experience. This is another reason why
this proposal is for dm and lvm, not for container. 
(BTW, we are using TCMU and ublk for overlaybd in production. They are awesome.)


> This solution doesn't even allow page cache sharing between shared
> layers (like current containers do), much less between independent
> layers.

Page cache sharing can be realized with DAX support of the dm targets
(and the inner file system), together with virtual pmem device backend.

> Erofs already has some block-level support for container images

It is interesting. Erofs runs insider a block device in the first place,
like what many file systems do. But do you konw why it implements another 
"some block-level support" by itself?

> And this new approach doesn't help
No. It is intended for dm and lvm.
