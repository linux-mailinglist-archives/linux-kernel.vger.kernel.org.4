Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97306F9E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjEHDND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjEHDNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9897EDC
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683515533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nyAgUbuTjzD6fHJpqxIZiFQeyCjpbJk624bFTFNpfo=;
        b=dqAL4kMtn1iPVye9ftLbseCCSTCjkzdJSEHmWjTl6S72iWjsgp3N2vv26LhkwWXAXioEUH
        X3C+siAfl1JAm+J/w9JsmL1jK4uveIo2/adgi4TCAwvzim522IUnzI/CAgheEgGZ+t+WZ/
        Us0YeHduY8an97DUjCrI7KEkmp8BqkY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-iMBp1UA4MUG3xziycPYeuA-1; Sun, 07 May 2023 23:12:12 -0400
X-MC-Unique: iMBp1UA4MUG3xziycPYeuA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ac6193a1e3so7979895ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 20:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683515531; x=1686107531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nyAgUbuTjzD6fHJpqxIZiFQeyCjpbJk624bFTFNpfo=;
        b=biM5lZu5xj1yBjLrqa3wZMxt5f1DRtnHZh+qRoQSbtxdZeM8cSLRXf/rk40RzY/eBu
         A9TgWT6Fpxiv+ebo9RSXMHxRfcLfX5c4dqnrHQCB4d1gMNrlLVWN6MZa+IgmOlMXo14j
         XF0YUfleiv1fHHXHoh6BMnRfkOGz/p5gi3WNXkd/Suv+Mfp5iBNhcMTGQ0vzPEhbK8cT
         A0OBcClTm8+7ezhPjDRdMndwS9ZR4p9vtJHJ7r+ky//VY7q4i07P4xnQw+8lpblhkk47
         JrvG3sYqRlqAmehwMDQOxNdHEv7DN2nePi4Yk9gw1JlChoplGZsfDlF0WNr9esssmAtC
         DE1w==
X-Gm-Message-State: AC+VfDzJ9p87fqjyROHMkQ5nP2Xab4hJDEIxdU7NJbhb3Cf2oZBcFpTr
        4wZVIThaq19PRhRDwj/71bGShQzO1jeoPfR48xD+of78za+cB9hNlv7HZkDqiVH0JqUW9eyufJ9
        nTTlMACGo9GPlTWAOE6vZelqW
X-Received: by 2002:a17:902:a516:b0:1ab:1355:1a45 with SMTP id s22-20020a170902a51600b001ab13551a45mr8724900plq.30.1683515530940;
        Sun, 07 May 2023 20:12:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Dsr/5I/1xDjPCTgBELpkfYOze5JmdS9lW2LqmCICvddW3VQUgjgtMk5CSsiE4sTTKAkq0Yg==
X-Received: by 2002:a17:902:a516:b0:1ab:1355:1a45 with SMTP id s22-20020a170902a51600b001ab13551a45mr8724890plq.30.1683515530640;
        Sun, 07 May 2023 20:12:10 -0700 (PDT)
Received: from [10.72.12.58] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902d4c400b00199193e5ea1sm5857923plg.61.2023.05.07.20.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 20:12:10 -0700 (PDT)
Message-ID: <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
Date:   Mon, 8 May 2023 11:12:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wenliang Wang <wangwenliang.1995@bytedance.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zhengqi.arch@bytedance.com,
        willemdebruijn.kernel@gmail.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
 <20230507093328-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230507093328-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/7 21:34, Michael S. Tsirkin 写道:
> On Fri, May 05, 2023 at 11:28:25AM +0800, Jason Wang wrote:
>> On Thu, May 4, 2023 at 10:27 AM Wenliang Wang
>> <wangwenliang.1995@bytedance.com> wrote:
>>> For multi-queue and large ring-size use case, the following error
>>> occurred when free_unused_bufs:
>>> rcu: INFO: rcu_sched self-detected stall on CPU.
>>>
>>> Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
>>> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
>>> ---
>>> v2:
>>> -add need_resched check.
>>> -apply same logic to sq.
>>> v3:
>>> -use cond_resched instead.
>>> v4:
>>> -add fixes tag
>>> ---
>>>   drivers/net/virtio_net.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 8d8038538fc4..a12ae26db0e2 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -3560,12 +3560,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
>>>                  struct virtqueue *vq = vi->sq[i].vq;
>>>                  while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
>>>                          virtnet_sq_free_unused_buf(vq, buf);
>>> +               cond_resched();
>> Does this really address the case when the virtqueue is very large?
>>
>> Thanks
>
> it does in that a very large queue is still just 64k in size.
> we might however have 64k of these queues.


Ok, but we have other similar loops especially the refill, I think we 
may need cond_resched() there as well.

Thanks


>
>>>          }
>>>
>>>          for (i = 0; i < vi->max_queue_pairs; i++) {
>>>                  struct virtqueue *vq = vi->rq[i].vq;
>>>                  while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
>>>                          virtnet_rq_free_unused_buf(vq, buf);
>>> +               cond_resched();
>>>          }
>>>   }
>>>
>>> --
>>> 2.20.1
>>>

