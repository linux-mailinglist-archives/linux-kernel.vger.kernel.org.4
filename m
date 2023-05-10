Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED596FD4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjEJDxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjEJDxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:53:21 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB80C40FD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=p9uHm
        CC4GlxQ1KU1bCyXbYnX5kCC6wGpCXGXt/a9UPs=; b=aLE2OGyMktksauQZV60GQ
        2juJOIJXrU0JD9B222ZqcM6sR9AJIsiwXQdhRxvNNfmViY9XXBkX0uN4/pRMaMCW
        sYEc17UWX9zcfKiEN+TUnoE9LbYZ5tkM0VtuMayg8y4slJ9Zfi0+2sT7HQ+l6XR2
        kLBJQo/m4iAIYAeutBnIkk=
Received: from zhangf-virtual-machine.localdomain (unknown [180.111.102.183])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wBHlVQOFVtk+zPWBQ--.60792S5;
        Wed, 10 May 2023 11:52:59 +0800 (CST)
From:   zhangfei <zhang_fei_0403@163.com>
To:     ajones@ventanamicro.com
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zhang_fei_0403@163.com,
        zhangfei@nj.iscas.ac.cn
Subject: Re: [PATCH] riscv: Optimize memset 
Date:   Wed, 10 May 2023 11:52:43 +0800
Message-Id: <20230510035243.8586-4-zhang_fei_0403@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510035243.8586-1-zhang_fei_0403@163.com>
References: <20230509-b0dc346928ddc8d2b5690f67@orel>
 <20230510035243.8586-1-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHlVQOFVtk+zPWBQ--.60792S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4fCw18Ww4rtF4DtFW7twb_yoWfCwb_G3
        yUJrnYkwn8ArZakFs3Kr45WrWqy34DArW5Wr18Xw12gr9YqrWDZ3yvkr9Yva48G3WI9Fnx
        CFyYqayUAr1S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiBHqJUUUUU==
X-Originating-IP: [180.111.102.183]
X-CM-SenderInfo: x2kd0w5bihxsiquqjqqrwthudrp/xtbCfBBrl2DcJd-5swAAsc
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

On Tue, May 09, 2023 11:16:33AM +0200, Andrew Jones wrote: 
> On Tue, May 09, 2023 at 10:22:07AM +0800, zhangfei wrote:
> > 
> > Hi,
> > 
> > I filled head and tail with minimal branching. Each conditional ensures that 
> > all the subsequently used offsets are well-defined and in the dest region.
> 
> I know. You trimmed my comment, so I'll quote myself, here
> 
> """
> After the check of a2 against 6 above we know that offsets 6(t0)
> and -7(a3) are safe. Are we trying to avoid too may redundant
> stores with these additional checks?
> """
> 
> So, again. Why the additional check against 8 above and, the one you
> trimmed, checking 10?

Hi,

These additional checks are to avoid too many redundant stores. 

Adding a check for more than 8 bytes is because after the loop 
segment '3' comes out, the remaining bytes are less than 8 bytes, 
which also avoids redundant stores.

Thanks,
Fei Zhang

