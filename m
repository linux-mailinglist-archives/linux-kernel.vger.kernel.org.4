Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F8B6711CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjARDYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjARDY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:24:29 -0500
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F225A4FCD8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:24:27 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-05 (Coremail) with SMTP id zQCowACHjelgZsdjDF2pAA--.36255S2;
        Wed, 18 Jan 2023 11:24:17 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     daniel@ffwll.ch
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH 1/2] drm: Add DRM-managed alloc_workqueue() and alloc_ordered_workqueue()
Date:   Wed, 18 Jan 2023 11:24:13 +0800
Message-Id: <20230118032413.6496-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACHjelgZsdjDF2pAA--.36255S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1DCF47Xr15GF1xZw4fXwb_yoWkZrb_GF
        9YgrnrWw4UGr1093Z7Jr1jqa4Ivr48Ar1jgayrX3s3try2qFWrXanrCrsav34fWws5CFsx
        uFyqgayavr9FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbz8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 10, 2023 at 11:24:47PM +0800, Jiasheng Jiang wrote:
>> Add drmm_alloc_workqueue() and drmm_alloc_ordered_workqueue(), the helpers
>> that provide managed workqueue cleanup. The workqueue will be destroyed
>> with the final reference of the DRM device.
>> 
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> 
> Yeah I think this looks nice.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'm assuming driver maintainers will pick this up, if not please holler.
> 
> Also the threading seems broken, it's not a patch series. The b4 tool or
> git send-email (of all the patches of the entire series at once, not each
> individually) should get this right.
> 
> Unfortunately I did't find the right link in the kernel docs, or at least
> they're not as detailed as I hoped.
> 
> Also your previous submission had iirc a bunch more patches, do you plan
> to include them all in the next patch set?

I have found that some previous patches have already been applied.
Need I just convert alloc*workqueue into drmm_alloc*workqueue and remove
the destroy_workqueue?
Or need I convert all the alloc*workqueue in the DRM?

Thanks,
Jiang

