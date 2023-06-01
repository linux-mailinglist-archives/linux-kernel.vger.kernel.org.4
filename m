Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B007718FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFAA7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFAA7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:59:39 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2BD15119;
        Wed, 31 May 2023 17:59:36 -0700 (PDT)
Received: from [172.30.38.103] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 80066180000131;
        Thu,  1 Jun 2023 08:59:33 +0800 (CST)
Message-ID: <a3905de3-265a-b69b-10f7-044bc18808b0@nfschina.com>
Date:   Thu, 1 Jun 2023 08:59:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/nouveau/nvif: use struct_size()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, airlied@redhat.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <00e84595-e2c9-48ea-8737-18da34eaafbf@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/31 16:31, Dan Carpenter wrote:
> On Wed, May 31, 2023 at 12:38:26PM +0800, Su Hui wrote:
>> Use struct_size() instead of hand writing it.
>> This is less verbose and more informative.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/gpu/drm/nouveau/nvif/object.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
>> index 4d1aaee8fe15..4bd693aa4ee0 100644
>> --- a/drivers/gpu/drm/nouveau/nvif/object.c
>> +++ b/drivers/gpu/drm/nouveau/nvif/object.c
>> @@ -65,7 +65,7 @@ nvif_object_sclass_get(struct nvif_object *object, struct nvif_sclass **psclass)
>>   	u32 size;
>>   
>>   	while (1) {
>> -		size = sizeof(*args) + cnt * sizeof(args->sclass.oclass[0]);
>> +		size = struct_size(args, sclass.oclass, cnt);
> This is from the original code, but now that you are using the
> struct_size() macro static checkers will complain about it.  (Maybe they
> don't yet?).  size is a u32.  Never save struct_size() returns to
> anything except unsigned long or size_t.  (ssize_t is also fine, I
> suppose).  Otherwise, you do not benefit from the integer overflow
> checking.
Sorry, I don't notice the issue caused by type size.
You are right, this patch is wrong because of the type mismatch.
Thanks for your reply!

Su Hui

>>   		if (!(args = kmalloc(size, GFP_KERNEL)))
>>   			return -ENOMEM;
>>   		args->ioctl.version = 0;
> regards,
> dan carpenter
