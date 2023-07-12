Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B8C750439
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjGLKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjGLKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:15:18 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2174E19A6;
        Wed, 12 Jul 2023 03:15:14 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id BE9606076583E;
        Wed, 12 Jul 2023 18:15:09 +0800 (CST)
Message-ID: <5194f82f-12d6-05aa-33b7-69c88923e455@nfschina.com>
Date:   Wed, 12 Jul 2023 18:15:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/virtio: remove some redundant code
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org,
        olvaffe@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <b82057bf-3126-4721-87f5-79ca3682cee4@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/12 14:36, Dan Carpenter wrote:

> On Wed, Jul 12, 2023 at 09:18:42AM +0800, Su Hui wrote:
>> On 2023/7/11 19:13, Dan Carpenter wrote:
>>> On Tue, Jul 11, 2023 at 05:00:31PM +0800, Su Hui wrote:
>>>> virtio_gpu_get_vbuf always be successful,
>>>> so remove the error judgment.
>>>>
>>> No, just ignore the static checker false positive in this case.  The
>>> intent of the code is clear that if it did have an error it should
>>> return an error pointer.
>> Hi, Dan,
>>
>> Function "virtio_gpu_get_vbuf" call "kmem_cache_zalloc (vgdev->vbufs,
>> GFP_KERNEL | __GFP_NOFAIL)" to
>> allocate memory. Adding the " __GFP_NOFAIL”flag make sure it won't fail. And
>> "virtio_gpu_get_vbuf" never
>> return an error code, so I think this is not a false positive.
> We all see this and agree.
>
> However the check for if (IS_ERR()) is written deliberately because we
> might change the code to return error pointers in the future.  Static
> checkers are looking for code that does something unintentional but in
> this case the code was written that way deliberately.
Got it ,  I shouldn't remove it because the check may be useful in the 
future.
Thanks for your explanation.

Su Hui

>
> regards,
> dan carpenter
>
