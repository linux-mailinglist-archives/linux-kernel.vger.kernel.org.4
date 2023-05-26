Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA02711F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjEZGEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242087AbjEZGEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:04:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9760F99
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:04:47 -0700 (PDT)
Received: from dggpemm500003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QSDpn74ZDzYspp;
        Fri, 26 May 2023 14:02:25 +0800 (CST)
Received: from [10.67.145.254] (10.67.145.254) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 14:04:35 +0800
Message-ID: <ba387464-59d5-0639-1d05-84bb7e764231@hisilicon.com>
Date:   Fri, 26 May 2023 14:04:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
From:   wangwudi <wangwudi@hisilicon.com>
Subject: [Question about gic vmovp cmd] Consider adding VINVALL after VMOVP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.145.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

During vpe migration, VMOVP needs to be executed.
If the vpe is migrated for the first time, especially before it is scheduled for the first time, there may be some unusual hanppens over kexec.
We might consider adding a VINVALL cmd after VMOVP to increase robustness.

@@ -1327,6 +1327,7 @@ static void its_send_vmovp(struct its_vpe *vpe)

                desc.its_vmovp_cmd.col = &its->collections[col_id];
                its_send_single_vcommand(its, its_build_vmovp_cmd, &desc);
+               its_send_vinvall(its, vpe);
        }

Do you think it's all right?

Thanks,
Wudi
