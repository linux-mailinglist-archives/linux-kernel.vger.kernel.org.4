Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E98602D01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJRNb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJRNbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:31:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11647C90F1;
        Tue, 18 Oct 2022 06:31:20 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8Dxu9ilqk5jE3AAAA--.2541S3;
        Tue, 18 Oct 2022 21:31:17 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxLeCkqk5jpbcAAA--.2979S3;
        Tue, 18 Oct 2022 21:31:17 +0800 (CST)
Subject: Re: [PATCH] ACPI: scan: Fix DMA range assignment
To:     Robin Murphy <robin.murphy@arm.com>, rafael@kernel.org
Cc:     yangyicong@huawei.com, lpieralisi@kernel.org,
        chenhuacai@loongson.cn, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lenb@kernel.org,
        jeremy.linton@arm.com
References: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <3793c2e8-15ad-2628-0660-f04d4f1071fd@loongson.cn>
Date:   Tue, 18 Oct 2022 21:31:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxLeCkqk5jpbcAAA--.2979S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr4DKrWDWr4Utr1ruFyUZFb_yoW8Gw4fp3
        yYg34UCr4xJrs5Wr1xJws3ua1Y9395WrW8urW5C3sa93ZxGF90yrWrCry5u3Z3JF95JF4x
        ZFnI9F18CFWUJrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
        8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems good. Thanks very much.

Reviewed-by: Jianmin Lv <lvjianmin@loongson.cn>

On 2022/10/18 下午9:14, Robin Murphy wrote:
> Assigning the device's dma_range_map from the iterator variable after
> the loop means it always points to the empty terminator at the end of
> the map, which is not what we want. Similarly, freeing the iterator on
> error when it points to somwhere in the middle of the allocated array
> won't work either. Fix this.
> 
> Fixes: bf2ee8d0c385 ("ACPI: scan: Support multiple DMA windows with different offsets")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/acpi/scan.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 558664d169fc..024cc373a197 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1509,9 +1509,12 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   			goto out;
>   		}
>   
> +		*map = r;
> +
>   		list_for_each_entry(rentry, &list, node) {
>   			if (rentry->res->start >= rentry->res->end) {
> -				kfree(r);
> +				kfree(*map);
> +				*map = NULL;
>   				ret = -EINVAL;
>   				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>   				goto out;
> @@ -1523,8 +1526,6 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   			r->offset = rentry->offset;
>   			r++;
>   		}
> -
> -		*map = r;
>   	}
>    out:
>   	acpi_dev_free_resource_list(&list);
> 

