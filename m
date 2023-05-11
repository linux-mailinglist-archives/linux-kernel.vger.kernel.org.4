Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC41A6FE989
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbjEKBnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjEKBn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:43:29 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F08C40CB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NIad5
        o/gCF/UbBioYF/NhdVu7OxbA2d0uZxhfg7phII=; b=EqDt6WIJwLIN9EIlhPeEq
        su1mQn9rqyxiIKdCJ1yrMEap+ZOAmyDVKyFK4wWwgErhuOOEKhYDeFreqKP3oETK
        yBppZY6aZ6L+w80vuh+ZQsV6yGABJyBMTbkEIAVyhj8hAXvGHeCx/cpENUPbebV4
        VKedhJPIcr918o2Jzq9o8I=
Received: from zhangf-virtual-machine.localdomain (unknown [180.111.102.183])
        by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wCHxjYWSFxkD+YgBg--.56513S2;
        Thu, 11 May 2023 09:42:46 +0800 (CST)
From:   zhangfei <zhang_fei_0403@163.com>
To:     ajones@ventanamicro.com
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zhang_fei_0403@163.com,
        zhangfei@nj.iscas.ac.cn
Subject: Re: [PATCH] riscv: Optimize memset 
Date:   Thu, 11 May 2023 09:42:43 +0800
Message-Id: <20230511014243.3336-1-zhang_fei_0403@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510-0adf0b2a2956ca1cd426a2d2@orel>
References: <20230510-0adf0b2a2956ca1cd426a2d2@orel>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHxjYWSFxkD+YgBg--.56513S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy7urW3XF4rWF1xXrWkJFb_yoW8Aw17pr
        95JF1DKF4qgwnakw429w4IqrWYk3Z5JF1rXFWUJ3srA3s0g34rtF93KF4Y9a9rGrnakay2
        vr45Xr1fXF1UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEGYLDUUUUU=
X-Originating-IP: [180.111.102.183]
X-CM-SenderInfo: x2kd0w5bihxsiquqjqqrwthudrp/1tbiWxVsl2I0Z+m5pQABsw
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangfei <zhangfei@nj.iscas.ac.cn>

On Wed, May 10, 2023 at 14:58:22PM +0200, Andrew Jones wrote:
> On Wed, May 10, 2023 at 11:52:43AM +0800, zhangfei wrote:
> > From: zhangfei <zhangfei@nj.iscas.ac.cn>
> > 
> > On Tue, May 09, 2023 11:16:33AM +0200, Andrew Jones wrote: 
> > > On Tue, May 09, 2023 at 10:22:07AM +0800, zhangfei wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > I filled head and tail with minimal branching. Each conditional ensures that 
> > > > all the subsequently used offsets are well-defined and in the dest region.
> > > 
> > > I know. You trimmed my comment, so I'll quote myself, here
> > > 
> > > """
> > > After the check of a2 against 6 above we know that offsets 6(t0)
> > > and -7(a3) are safe. Are we trying to avoid too may redundant
> > > stores with these additional checks?
> > > """
> > > 
> > > So, again. Why the additional check against 8 above and, the one you
> > > trimmed, checking 10?
> > 
> > Hi,
> > 
> > These additional checks are to avoid too many redundant stores. 
> > 
> > Adding a check for more than 8 bytes is because after the loop 
> > segment '3' comes out, the remaining bytes are less than 8 bytes, 
> > which also avoids redundant stores.
> 
> So the benchmarks showed these additional checks were necessary to avoid
> making memset worse? Please add comments to the code explaining the
> purpose of the checks.

Hi,

As you mentioned, the lack of these additional tests can make memset worse. 
When I removed the checks for 8 and 10 above, the benchmarks showed that the 
memset changed to 0.21 bytes/ns at 8B. Although this is better than storing 
byte by byte, additional detections will bring a better improvement to 0.27 bytes/ns.

Due to the chaotic response in my previous email, I am sorry for this. I have 
reorganized patch v2 and sent it to you. Please reply under the latest patch.

Thanks,
Fei Zhang

