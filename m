Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F56BA65C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCOEwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCOEwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD035C9E8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 21:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678855875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAc44bIyeunVqM7F9oum4Kb/lC4PewNL7pDwUADmf8I=;
        b=iPjcIz6/xBVS7W5Y5aQ8H2R6+0HiT3sSU3Ir8AuozEuSuf5ZMUfCN76qwCBaWZDo/yJ/nr
        1k/PRqOQjEtj1xJimX39xHh4Yl6RDOWjvDIC/lgijp9DL/FlItdOIhJkbuRW6kL5tMJmeW
        TellwnRpAdSRd6Mbtpaw6BgvnxPr9nE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-2ZdsxzaOPGil7W4n2afiNA-1; Wed, 15 Mar 2023 00:51:06 -0400
X-MC-Unique: 2ZdsxzaOPGil7W4n2afiNA-1
Received: by mail-pg1-f200.google.com with SMTP id q30-20020a631f5e000000b0050760997f4dso4135405pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 21:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678855865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAc44bIyeunVqM7F9oum4Kb/lC4PewNL7pDwUADmf8I=;
        b=KHmxF6oljt3AUd20he0BozAAEzE+zhuHN9sJjXNAhbuRhA1FX3LrjK2iinYfEre+78
         mM0bcnCVbfMVz3n09ujOREYeoan0lMNsweiXVN1SYcnbeUY7pOBskS+2ASSScTs9izDI
         kZ//bILTCPr6ZxkXTWG0ItK3jPzDhQ2tQtK/v1q56zP4tPEAkXsvoky9+8IEEGrseGLP
         IDBuDFbBHYACdrvc2larzDoOQv2+WxzmCkV34x1/x+jN4VS+gsLFUWllZP0nPgNPHUE1
         9J64Q7FKMhEBjfBkwtU6RQeHJCFPu7yXOo6jpWz97yUCbnKZ0cn5vZlD60aQRqZOZp7b
         0tsg==
X-Gm-Message-State: AO0yUKXNIzrxVhGLpWOYMxBEeFrwQXvUN3shCl5O0YVlE+0PmsJpltNX
        Y+mKQXvOntZuTVx4Kic7t/YDHLBjspkpaaFkpvYY0QsSOuYiT1T6/fVjMOhHusYe6bmjVIZkzX8
        Tx0UWOWTzJ5voeFgfDsZ095zl
X-Received: by 2002:a05:6a20:160a:b0:cc:88af:12ab with SMTP id l10-20020a056a20160a00b000cc88af12abmr46431417pzj.28.1678855865470;
        Tue, 14 Mar 2023 21:51:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set+nSocWLK/26+zU8BB7aj5/6EfcMGupuzmB02JjazwKDlIXCcdY2K6NOnUTCqz4CJ7oFY/GUQ==
X-Received: by 2002:a05:6a20:160a:b0:cc:88af:12ab with SMTP id l10-20020a056a20160a00b000cc88af12abmr46431406pzj.28.1678855865138;
        Tue, 14 Mar 2023 21:51:05 -0700 (PDT)
Received: from [10.72.12.84] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u21-20020a62ed15000000b00593c1c5bd0esm2404326pfh.164.2023.03.14.21.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 21:51:04 -0700 (PDT)
Message-ID: <e8c01176-dc61-47de-ffab-4d328e3c60b9@redhat.com>
Date:   Wed, 15 Mar 2023 12:50:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH net-next v2 13/14] sfc: update vdpa device MAC address
Content-Language: en-US
To:     Gautam Dawar <gdawar@amd.com>, Gautam Dawar <gautam.dawar@amd.com>
Cc:     linux-net-drivers@amd.com, Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        eperezma@redhat.com, harpreet.anand@amd.com, tanuj.kamde@amd.com,
        koushik.dutta@amd.com
References: <20230307113621.64153-1-gautam.dawar@amd.com>
 <20230307113621.64153-14-gautam.dawar@amd.com>
 <CACGkMEuY4KoiZKswjMDNfoeUTqUagXye-_qe-iP2JJq0schObQ@mail.gmail.com>
 <e563f5a5-2d1a-fbc9-be2d-986b050c6548@amd.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <e563f5a5-2d1a-fbc9-be2d-986b050c6548@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/13 14:37, Gautam Dawar 写道:
> On 3/10/23 10:35, Jason Wang wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> On Tue, Mar 7, 2023 at 7:38 PM Gautam Dawar <gautam.dawar@amd.com> 
>> wrote:
>>> As the VF MAC address can now be updated using `devlink port 
>>> function set`
>> What happens if we run this while the vpda is being used by a VM?
> IIUC, updating the MAC address using devlink interface requires 
> unbinding the device from driver and hence updating the MAC while vdpa 
> device is in-use won't be possible. It can only be done via control vq 
> VIRTIO_NET_CTRL_MAC_ADDR_SET command, when available.


Good to know that.


>>
>>> interface, fetch the vdpa device MAC address from the underlying VF 
>>> during
>>> vdpa device creation.
>>>
>>> Signed-off-by: Gautam Dawar <gautam.dawar@amd.com>
>>> ---
>>>   drivers/net/ethernet/sfc/ef100_vdpa.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/sfc/ef100_vdpa.c 
>>> b/drivers/net/ethernet/sfc/ef100_vdpa.c
>>> index 30ca4ab00175..32182a01f6a5 100644
>>> --- a/drivers/net/ethernet/sfc/ef100_vdpa.c
>>> +++ b/drivers/net/ethernet/sfc/ef100_vdpa.c
>>> @@ -272,6 +272,18 @@ static int get_net_config(struct ef100_vdpa_nic 
>>> *vdpa_nic)
>>>          vdpa_nic->net_config.max_virtqueue_pairs =
>>>                  cpu_to_efx_vdpa16(vdpa_nic, 
>>> vdpa_nic->max_queue_pairs);
>>>
>>> +       rc = ef100_get_mac_address(efx, vdpa_nic->mac_address,
>>> +                                  efx->client_id, true);
>>> +       if (rc) {
>>> +               dev_err(&vdpa_nic->vdpa_dev.dev,
>>> +                       "%s: Get MAC for vf:%u failed:%d\n", __func__,
>>> +                       vdpa_nic->vf_index, rc);
>>> +               return rc;
>>> +       }
>> Can this override what is provisioned by the userspace?
>
> No, this was carefully avoided by overwriting the userspace 
> provisioned MAC in ef100_vdpa_create():
>
>         rc = get_net_config(vdpa_nic);
>         if (rc)
>                 goto err_put_device;
>
>         if (mac) {
>                 ether_addr_copy(vdpa_nic->mac_address, mac);
>                 vdpa_nic->mac_configured = true;
>         }


Ah, I see.

Thanks


>
>>
>> Thanks
>>
>>
>>> +
>>> +       if (is_valid_ether_addr(vdpa_nic->mac_address))
>>> +               vdpa_nic->mac_configured = true;
>>> +
>>>          rc = efx_vdpa_get_mtu(efx, &mtu);
>>>          if (rc) {
>>>                  dev_err(&vdpa_nic->vdpa_dev.dev,
>>> -- 
>>> 2.30.1
>>>
>

