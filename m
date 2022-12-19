Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC25A650965
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiLSJhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiLSJhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:37:43 -0500
X-Greylist: delayed 935 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Dec 2022 01:37:42 PST
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23AD55FAE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qni9Y
        MWkKo/+ezfpz43WDevGp+Vw59ephUbClSDLIOU=; b=l5QXtX2e/+C1H01sEDzjT
        W5/HS4g5/+EZXmblRdbMF1MYhrKP6aRT4y7rp7rI208a7wnSk4HiLgZ0+oevrZuy
        PPo491RVnzJ49WQbX2YVVXY+U6EBjQMkryaJJdYi3nRUgHRvLkl7jfq5Jj8deleL
        F3OxVsbsbcTJs80SSY/1qU=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by smtp18 (Coremail) with SMTP id JNxpCgAX2dkjLaBji9tsBw--.36020S2;
        Mon, 19 Dec 2022 17:21:40 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     zhi.a.wang@intel.com
Cc:     1002992920@qq.com, airlied@gmail.com, airlied@linux.ie,
        alex000young@gmail.com, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, hackerzheng666@gmail.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        security@kernel.org, tvrtko.ursulin@linux.intel.com,
        zhenyuw@linux.intel.com, zyytlz.wz@163.com
Subject: Re: [Intel-gfx] [PATCH v3] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
Date:   Mon, 19 Dec 2022 17:21:39 +0800
Message-Id: <20221219092139.222456-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <11728bc1-7b59-1623-b517-d1a0d57eb275@intel.com>
References: <11728bc1-7b59-1623-b517-d1a0d57eb275@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: JNxpCgAX2dkjLaBji9tsBw--.36020S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur13ArW7Cw17tr47Gr4xtFb_yoWfGrgEgr
        1jq3s8Cw4UJFnrtw45Kayxtry7KrWfJrW8J34kua9rCryrZFs3CasrCrnxX3WfXr4v9Fs5
        Kr1rGwsFyry2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtMKCJUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXATcU1Xl5Jg2UQAAs8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang, Zhi A <zhi.a.wang@intel.com> 于2022年12月19日周一 16:22写道：

>
> I think it is a case-by-case thing. For example:
>
> The current scenario in this function looks like below:
>
> caller pass spt a
> function
>         alloc spt b
>         something error
>         free spt a
>         return error
>
> The problem is: the function wrongly frees the spt a instead free what
> it allocates.

Thanks for your clear explaination. It’s really helpfult to me.
I think I might know how to fix now.

> A proper fix should be:
>
> caller pass spt a
> function
>         alloc spt b
>         something error
>         *free spt b*
>         return error
>
As it's a case-by-case thing, I'll extract the un-done-mapping-dma part from
ppgtt_invalidate_spt and put it in error path. Then I'll add the code of freeing
new allocated spt. If I misunderstand your meaning, feel free to let me know.
Working on a new fix now.

Best regards,
Zheng Wang

