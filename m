Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E46D4B61
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjDCPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjDCPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:07:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4F4E74
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:07:19 -0700 (PDT)
Received: from [192.168.2.163] (109-252-124-32.nat.spd-mgts.ru [109.252.124.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D210F66030F1;
        Mon,  3 Apr 2023 16:07:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680534438;
        bh=BJ0rhRc9niR6251Zs1LeEbn51nnEzPsY8IYv6hl3WEU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gj4QTf52O23oWVQTDoPfhHBcaSM60R7JFwdcDkcwdy7ae+qLGtaL5d9E8EcLsGGku
         9S0+pw9We4NkcMyWa6a9AK1Y/Dmu7hbMkEjORRJ0jJAZ/TNPizWGHbKLKdvhS0pAHW
         YxRugV5unfDHoUMNZ26K96FTUITMxYpvAjGADzSRLD/eGeHqEZ2EMkCsqcrk7P7qNT
         DgTLIjAUX6fiDmT0+efn4ECpKTUAl6bk8ddGYIr7lKcXHXpjSKroGT71TZzlsKWOGF
         Tdj03ICtv4vXOh5jWEug3EySPJsRcY6UWK/W5vAOajHQghHTHff5FF0XfjgBHHGvKQ
         /iSxlYPxQuFnQ==
Message-ID: <d3f27ec6-bf80-ca18-9704-caf5008aeb3f@collabora.com>
Date:   Mon, 3 Apr 2023 18:07:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/2] drm/virtio: Support sync objects
Content-Language: en-US
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Emil Velikov <emil.velikov@collabora.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
References: <20230323230755.1094832-1-dmitry.osipenko@collabora.com>
 <20230323230755.1094832-3-dmitry.osipenko@collabora.com>
 <ZCXF4q81wPcczkqx@arch-x395>
 <3618a293-4f61-b076-0a9c-c70812436431@collabora.com>
 <CACvgo51GWRCQuiJDVrqo=xzd3frKvs6WNcc755pbu8jNk6t-Rg@mail.gmail.com>
 <CACvgo53bkvDm7CXN_zFETZeuWas50tJys6u+nc5DO_MWK4SZfw@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CACvgo53bkvDm7CXN_zFETZeuWas50tJys6u+nc5DO_MWK4SZfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 16:22, Emil Velikov wrote:
> On Mon, 3 Apr 2023 at 14:00, Emil Velikov <emil.l.velikov@gmail.com> wrote:
> 
>>>> I think we should zero num_(in|out)_syncobjs when the respective parse
>>>> fails. Otherwise we get one "cleanup" within the parse function itself
>>>> and a second during the cleanup_submit. Haven't looked at it too closely
>>>> but I suspect that will trigger an UAF or two.
>>>
>>> There are checks for NULL pointers in the code that will prevent the
>>> UAF.  I'll add zeroing of the nums for more consistency.
>>>
>>
>> Riiiight the drm_syncobj is attached to the encapsulating struct
>> virtio_gpu_submit _only_ on success.
>> By clearing the num variables,  the NULL checks will no longer be
>> needed ... in case you'd want to drop that.
>>
>> Either way - even as-is the code is safe.
>>
> 
> Err or not. The NULL check itself will cause NULL pointer deref.
> 
> In more detail: in/out syncobjs are memset() to NULL in
> virtio_gpu_init_submit(). The virtio_gpu_parse_(|post_)deps() will
> fail and leave them unchanged. Then virtio_gpu_free_syncobjs() and
> virtio_gpu_reset_syncobjs() will trigger a NULL ptr deref, because
> they are accessing the elements of a the (NULL) array.
> 
> Apart from the num_(in|out)_syncobjcs=0, I would drop the NULL checks
> - they give a false sense of security IMHO.

The reset/free are both under the NULL check on cleanup. I think it
should work okay on error. Will improve it anyways to make more
intuitive. Thanks!

static void virtio_gpu_cleanup_submit(struct virtio_gpu_submit *submit)
{
	if (submit->in_syncobjs) {
		virtio_gpu_reset_syncobjs(submit->in_syncobjs,
					  submit->num_in_syncobjs);

		virtio_gpu_free_syncobjs(submit->in_syncobjs,
					 submit->num_in_syncobjs);
	}

-- 
Best regards,
Dmitry

