Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E03717CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbjEaKCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEaKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:02:11 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FCBE9F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 03:02:07 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxHeseG3dk8ewCAA--.2072S3;
        Wed, 31 May 2023 18:02:06 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLL4dG3dkSzSCAA--.14949S3;
        Wed, 31 May 2023 18:02:06 +0800 (CST)
Subject: Re: [PATCH v3] LoongArch: Add support to clone a time namespace
To:     Youling Tang <tangyouling@loongson.cn>
References: <1685519761-20425-1-git-send-email-yangtiezhu@loongson.cn>
 <526b7cdc-9d10-d213-4e98-10973483b4cd@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d116627c-f21f-1f6b-3c3d-96bea9a29393@loongson.cn>
Date:   Wed, 31 May 2023 18:02:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <526b7cdc-9d10-d213-4e98-10973483b4cd@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxLL4dG3dkSzSCAA--.14949S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ar4UWr1fXry7AFyxWF48Zwb_yoW8WF4Dpw
        4kArWvkr4UGr1fGFyfGw13uwnrJws7uw1YgFW3ZrW2kFnxJFyDZr4vgrn8GF15Zw4UAry0
        934kZwsYva48JwUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxYiiDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/31/2023 04:34 PM, Youling Tang wrote:
> Hi, Tiezhu
>
> On 05/31/2023 03:56 PM, Tiezhu Yang wrote:

...

> It can also be changed as follows,
>
> enum vvar_pages {
>     VVAR_GENERIC_PAGE_OFFSET,
>     VVAR_TIMENS_PAGE_OFFSET,
>     VVAR_LOONGARCH_PAGES_START,
>     VVAR_LOONGARCH_PAGES_END = VVAR_LOONGARCH_PAGES_START +
> LOONGARCH_VDSO_DATA_PAGES - 1,
>     VVAR_NR_PAGES,
> };
>
> #define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
>
> Which do you think is better?

Thanks, it seems more simple to define VVAR_SIZE and works well
as expected. Let us wait for more review comments before respin.

I will send v4 with the following changes based on the current
patch in the next week.

$ git diff
diff --git a/arch/loongarch/include/asm/vdso/vdso.h 
b/arch/loongarch/include/asm/vdso/vdso.h
index fa6049ef635e..7e9bceb8c009 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -33,15 +33,17 @@ struct loongarch_vdso_data {
   */
  #define LOONGARCH_VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct 
loongarch_vdso_data))
  #define LOONGARCH_VDSO_DATA_PAGES (LOONGARCH_VDSO_DATA_SIZE >> PAGE_SHIFT)
-#define VVAR_SIZE (VVAR_LOONGARCH_PAGES_START * PAGE_SIZE + 
LOONGARCH_VDSO_DATA_SIZE)

  enum vvar_pages {
         VVAR_GENERIC_PAGE_OFFSET,
         VVAR_TIMENS_PAGE_OFFSET,
         VVAR_LOONGARCH_PAGES_START,
         VVAR_LOONGARCH_PAGES_END = VVAR_LOONGARCH_PAGES_START + 
LOONGARCH_VDSO_DATA_PAGES - 1,
+       VVAR_NR_PAGES,
  };

+#define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
+
  static inline unsigned long get_vdso_base(void)
  {
         unsigned long addr;

Thanks,
Tiezhu

