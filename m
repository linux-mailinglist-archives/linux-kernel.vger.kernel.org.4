Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08A2730D58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbjFOCsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbjFOCsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:48:15 -0400
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76688E3;
        Wed, 14 Jun 2023 19:48:13 -0700 (PDT)
Received: from ed3e173716be.home.arpa (unknown [124.16.138.129])
        by APP-05 (Coremail) with SMTP id zQCowACHpwTne4pkHH2QAg--.41156S2;
        Thu, 15 Jun 2023 10:48:08 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     keescook@chromium.org
Cc:     tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] pstore/platform: Add check for kstrdup
Date:   Thu, 15 Jun 2023 10:48:06 +0800
Message-Id: <20230615024806.39381-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACHpwTne4pkHH2QAg--.41156S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1DGF48Xry7JF4kWFy3Arb_yoW8XF45p3
        ykKFn8JFW0g3Wqgw1kX3W5ur4Y9a1vgr4rJ3y8ta1Ivas8Wr1DuryjgF4Y9FW8Xr97Gw10
        qFWF9F15Z3s8ZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4U
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5vtCUUUUU
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 03:01:30PM +0800, Kees Cook wrote:
> On Wed, Jun 14, 2023 at 06:00:20PM +0800, Jiasheng Jiang wrote:
>> Add check for the return value of kstrdup() and return the error
>> if it fails in order to avoid NULL pointer dereference.
>> 
>> Fixes: 563ca40ddf40 ("pstore/platform: Switch pstore_info::name to const")
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>> ---
>>  fs/pstore/platform.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
>> index cbc0b468c1ab..afe07f0d1216 100644
>> --- a/fs/pstore/platform.c
>> +++ b/fs/pstore/platform.c
>> @@ -631,6 +631,10 @@ int pstore_register(struct pstore_info *psi)
>>  	 * through /sys/module/pstore/parameters/backend
>>  	 */
>>  	backend = kstrdup(psi->name, GFP_KERNEL);
>> +	if (!backend) {
>> +		mutex_unlock(&psinfo_lock);
>> +		return -ENOMEM;
>> +	}
> 
> Hmm, I think this isn't the right place since there's been a bunch of
> other allocations and registrations. I think it would be better to
> allocate a copy (but not assign to "backend" yet) earlier, perhaps
> before the taking the psinfo_lock lock? Like:
> 
> 	char *new_backend;
> 	...
> 	new_backend = kstrdup(psi->name, GFP_KERNEL);
> 	if (!new_backend)
> 		return -ENOMEM;
> 
>         mutex_lock(&psinfo_lock);
>         if (psinfo) {
> 		...
>                 mutex_unlock(&psinfo_lock);
> 		kfree(new_backend);
>                 return -EBUSY;
>         }
> 	...
> 	backend = new_backend;

Fine, I will submit a v2 to allocate earlier.

Thanks,
Jiasheng

