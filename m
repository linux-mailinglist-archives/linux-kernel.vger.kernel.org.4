Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EC26F9E17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjEHDJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEHDJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:09:14 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270157ED0
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 20:09:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vhz46DB_1683515348;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vhz46DB_1683515348)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 11:09:08 +0800
Message-ID: <1683515269.507076-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V2] tools/virtio: fix build break for aarch64
Date:   Mon, 8 May 2023 11:07:49 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>, mst@redhat.com,
        jasowang@redhat.com, mie@igel.co.jp,
        virtualization@lists.linux-foundation.org
References: <20230323040024.3809108-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230323040024.3809108-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 12:00:24 +0800, "Peng Fan (OSS)" <peng.fan@oss.nxp.com> wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> "-mfunction-return=thunk -mindirect-branch-register" are only valid
> for x86. So introduce compiler operation check to avoid such issues
>
> Fixes: 0d0ed4006127 ("tools/virtio: enable to build with retpoline")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V2:
>  Use /dev/null as output dest
>  Move call cc-option to the original CFLAGS
>
>  tools/virtio/Makefile | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 7b7139d97d74..d128925980e0 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -4,7 +4,18 @@ test: virtio_test vringh_test
>  virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
>
> -CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
> +try-run = $(shell set -e;		\
> +	if ($(1)) >/dev/null 2>&1;	\
> +	then echo "$(2)";		\
> +	else echo "$(3)";		\
> +	fi)
> +
> +__cc-option = $(call try-run,\
> +	$(1) -Werror $(2) -c -x c /dev/null -o /dev/null,$(2),)
> +cc-option = $(call __cc-option, $(CC),$(1))

Can we sqush these to one function?

> +
> +CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h $(call cc-option,-mfunction-return=thunk) $(call cc-option,-fcf-protection=none) $(call cc-option,-mindirect-branch-register)

nit: this line is too long. Can we split it?

Thanks.

> +
>  CFLAGS += -pthread
>  LDFLAGS += -pthread
>  vpath %.c ../../drivers/virtio ../../drivers/vhost
> --
> 2.37.1
>
