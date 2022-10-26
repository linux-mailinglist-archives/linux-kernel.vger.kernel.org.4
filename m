Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA0560DA65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJZEo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJZEoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0F17E32
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666759491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dj+eqQDOPnxD1d2xex/P6auBK55p9rCcO9+QKsmGE10=;
        b=hEtCMTZmo0b2LnNDAnbuaZKloQFTwnqco5V8Q9HWjDR5sezz0hZsF6lRg5m7Hk+cHzXRoe
        cykVW+fM/H+SgBXjUgXjTPKv2aykeFMs2MtHNfE9qlZoefe0F6R9C83299xi67IIgLEJdQ
        bwcYTFy5+ADWK5dLNEQk69i1onmhIm8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-396-c6Cpwb8JM8KQMej759P9Rg-1; Wed, 26 Oct 2022 00:44:50 -0400
X-MC-Unique: c6Cpwb8JM8KQMej759P9Rg-1
Received: by mail-pl1-f198.google.com with SMTP id x18-20020a170902ec9200b001869f20da7eso5590264plg.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj+eqQDOPnxD1d2xex/P6auBK55p9rCcO9+QKsmGE10=;
        b=ICIMKo115zaqhj5L9qp/qXUqYYT09gVEHJwhkiVHl8TeRhAZ2XD/Y/fcmz+VsTd65e
         paF3pt2TMLPLm3+F12/ShG6bAJXSjcxP0bmkrpVILJ/UsGDeO1UNkzB7VDSmvN3QccQ2
         bJ+8WDHcQMplY6oLNQTxW6gd1L41p7A3VKpEfnyNmHdx9y4YvCiN6okrBMVG2HcUhF6U
         kfZZPebkr0g3fvFq/tS/EnrSbF9K7BVG9vMM4m2E8ZglHGSZo3nt9rqQxcl5vPyOp0+R
         JgN3j7OyFqdM1quvuYxDi8N4/2UYWvSH+HrdqqbnqVdSTFDXQq73g6DuWVgPkfSA7Ax5
         zS+w==
X-Gm-Message-State: ACrzQf2ZCbrXrzh99npJcL3IYDdHKYoeOWYR464g6vES1tNZQNP2F4/h
        EA6FIJ+aeCplPAEJo2bWLdVGdKe5ZyfRwxCZuyUE6hSpWx4ff7zjgLp+32/xIqn7EqYEVmgjhlI
        rKK+RG0kkuHvsU9gtFUlKpsnG
X-Received: by 2002:a17:902:d503:b0:185:457a:9325 with SMTP id b3-20020a170902d50300b00185457a9325mr42447897plg.140.1666759489113;
        Tue, 25 Oct 2022 21:44:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51Uj/BKr6QFJxAeGAR4GWGNOqPqsbobwFcc2aqfQB26RzAJ5cNyT5rBLRlf102Ah3jupd4OQ==
X-Received: by 2002:a17:902:d503:b0:185:457a:9325 with SMTP id b3-20020a170902d50300b00185457a9325mr42447874plg.140.1666759488743;
        Tue, 25 Oct 2022 21:44:48 -0700 (PDT)
Received: from [10.72.13.65] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090a718c00b002132f3e71c6sm384827pjk.52.2022.10.25.21.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 21:44:48 -0700 (PDT)
Message-ID: <38b9648b-8795-5b41-b06c-d13a1a6d5d3f@redhat.com>
Date:   Wed, 26 Oct 2022 12:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
 <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
 <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
 <25a18d7a-ebae-3647-32f0-14ad733118be@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <25a18d7a-ebae-3647-32f0-14ad733118be@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/26 09:10, Si-Wei Liu 写道:
>
>
> On 10/24/2022 7:24 PM, Jason Wang wrote:
>> On Tue, Oct 25, 2022 at 3:14 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>> On 10/24/2022 1:40 AM, Jason Wang wrote:
>>>> On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>>>> Live migration of vdpa would typically require re-instate vdpa
>>>>> device with an idential set of configs on the destination node,
>>>>> same way as how source node created the device in the first
>>>>> place. In order to save orchestration software from memorizing
>>>>> and keeping track of vdpa config, it will be helpful if the vdpa
>>>>> tool provides the aids for exporting the initial configs as-is,
>>>>> the way how vdpa device was created. The "vdpa dev show" command
>>>>> seems to be the right vehicle for that. It is unlike the "vdpa dev
>>>>> config show" command output which usually goes with the live value
>>>>> in the device config space, and is not quite reliable subject to
>>>>> the dynamics of feature negotiation or possible change by the
>>>>> driver to the config space.
>>>>>
>>>>> Examples:
>>>>>
>>>>> 1) Create vDPA by default without any config attribute
>>>>>
>>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
>>>>> $ vdpa dev show vdpa0
>>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>>>> $ vdpa dev -jp show vdpa0
>>>>> {
>>>>>       "dev": {
>>>>>           "vdpa0": {
>>>>>               "type": "network",
>>>>>               "mgmtdev": "pci/0000:41:04.2",
>>>>>               "vendor_id": 5555,
>>>>>               "max_vqs": 9,
>>>>>               "max_vq_size": 256,
>>>>>           }
>>>>>       }
>>>>> }
>>>>>
>>>>> 2) Create vDPA with config attribute(s) specified
>>>>>
>>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>>>>>       mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>>> $ vdpa dev show
>>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>>>>     initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>>> $ vdpa dev -jp show
>>>>> {
>>>>>       "dev": {
>>>>>           "vdpa0": {
>>>>>               "type": "network",
>>>>>               "mgmtdev": "pci/0000:41:04.2",
>>>>>               "vendor_id": 5555,
>>>>>               "max_vqs": 9,
>>>>>               "max_vq_size": 256,
>>>>>               "initial_config": {
>>>>>                   "mac": "e4:11:c6:d3:45:f0",
>>>>>                   "max_vq_pairs": 4
>>>>>               }
>>>>>           }
>>>>>       }
>>>>> }
>>>>>
>>>>> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
>>>>> ---
>>>>>    drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 39 insertions(+)
>>>>>
>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>>> index bebded6..bfb8f54 100644
>>>>> --- a/drivers/vdpa/vdpa.c
>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>>>>>    }
>>>>>
>>>>>    static int
>>>>> +vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
>>>>> +{
>>>>> +       struct vdpa_dev_set_config *cfg = &vdev->init_cfg;
>>>>> +       int err = -EMSGSIZE;
>>>>> +
>>>>> +       if (!cfg->mask)
>>>>> +               return 0;
>>>>> +
>>>>> +       switch (device_id) {
>>>>> +       case VIRTIO_ID_NET:
>>>>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
>>>>> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
>>>>> +                           sizeof(cfg->net.mac), cfg->net.mac))
>>>>> +                       return err;
>>>>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
>>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg->net.mtu))
>>>>> +                       return err;
>>>>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
>>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
>>>>> +                               cfg->net.max_vq_pairs))
>>>>> +                       return err;
>>>>> +               break;
>>>>> +       default:
>>>>> +               break;
>>>>> +       }
>>>>> +
>>>>> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
>>>>> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
>>>>> +                             cfg->device_features, VDPA_ATTR_PAD))
>>>>> +               return err;
>>>> A question: If any of those above attributes were not provisioned,
>>>> should we show the ones that are inherited from the parent?
>>> A simple answer would be yes, but the long answer is that I am not sure
>>> if there's any for the moment - there's no  default value for mtu, mac,
>>> and max_vqp that can be inherited from the parent (max_vqp by default
>>> being 1 is spec defined, not something inherited from the parent).
>> Note that it is by default from driver level that if _F_MQ is not
>> negotiated. But I think we are talking about something different that
>> is out of the spec here, what if:
>>
>> vDPA inherit _F_MQ but mqx_vqp is not provisioned via netlink.
>>
>> Or is it not allowed?
> My understanding is that this is not allowed any more since the 
> introduction of max_vqp attribute. Noted, currently we don't have a 
> way for vendor driver to report the default value for mqx_vqp, 


I think it can be reported in this patch?


> if not otherwise specified in the CLI. Without getting the default 
> value reported in 'vdpa mgmtdev show' level, it'd just confuse mgmt 
> software even more.


Yes, this is something that we need to fix. And what's more in order to 
support dynamic provisioning, we need a way to report the number of 
available instances that could be used for vDPA device provisioning.


>
>>    At least some time in the past, mlx5 were
>> enabled with MQ with 8 queue pairs by default.
> That was the situation when there's no max_vqp attribute support from 
> vdpa netlink API level. I think now every driver honors the vdpa core 
> disposition to get a single queue pair if max_vqp config is missing.

So we have:

int vdpa_register_device(struct vdpa_device *vdev, int nvqs)

This means technically, parent can allocate a multiqueue devices with 
_F_MQ features if max_vqp and device_features is not provisioned. And 
what's more, what happens if _F_MQ is provisioned by max_vqp is not 
specified?

The question is:

When a attribute is not specificed/provisioned via net link, what's the 
default value? The answer should be consistent: if device_features is 
determined by the parent, we should do the same for mqx_vqp. And it 
looks to me all of those belongs to the initial config (self-contained)


> And the mlx5_vdpa driver with 8 queue pairs in the wild days is just 
> irrelevant to be manageable by mgmt software, regardless of live 
> migration.
>>> And
>>> the device_features if inherited is displayed at 'vdpa dev config show'
>>> output. Can you remind me of a good example for inherited value that we
>>> may want to show here?
>> Some other cases:
>>
>> 1) MTU: there should be something that the device needs to report if
>> _F_MTU is negotiated even if it is not provisioned from netlink.
> I am not sure I understand the ask here. Noted the QEMU argument has 
> to offer host_mtu=X with the maximum MTU value for guest to use (and 
> applied as the initial MTU config during virtio-net probing for Linux 
> driver), 


Adding Cindy.

I think it's a known issue that we need to do sanity check to make sure 
cli parameters matches what is provisioned from netlink.


> and the way to get the parent device MTU and whether that's relevant 
> to vdpa device's MTU is very vendor specific.


So I think the max MTU of parent should be equal to the max MTU of the vDPA.


> I think we would need new attribute(s) in the mgmtdev level to support 
> what you want here?


Not sure, but what I want to ask is consider we provision MTU feature 
but without max MTU value, do we need to report the initial max MTU here?


>
>> 2) device_features: if device_features is not provisioned, we should
>> still report it via netlink here
> Not the way I expected it, but with Lingshan's series to expose fields 
> out of FEATURES_OK, the device_features is now reported through 'vdpa 
> dev config show' regardless being specified or not, if I am not mistaken?


Yes.


>
> Currently we export the config attributes upon vdpa creation under the 
> "initial_config" key. If we want to expose more default values 
> inherited from mgmtdev, I think we can wrap up these default values 
> under another key "inherited_config" to display in 'vdpa dev show' 
> output. Does it fit what you have in mind?


I wonder if it's better to merge those two, or is there any advantages 
of splitting them?


>
>> or do you mean the mgmt can assume it
>> should be the same as mgmtdev. Anyhow if we don't show device_features
>> if it is not provisioned, it will complicate the mgmt software.
> Yes, as I said earlier, since the device_features attr getting added 
> to the 'vdpa dev config show' command, this divergence started to 
> complicate mgmt software already.
>
> Thanks,


Thanks


> -Siwei
>> Thanks
>>
>>> Thanks,
>>> -Siwei
>>>
>>>
>>>> Thanks
>>>>
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>> +static int
>>>>>    vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
>>>>>                 int flags, struct netlink_ext_ack *extack)
>>>>>    {
>>>>> @@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>>>>>           if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>>>>>                   goto msg_err;
>>>>>
>>>>> +       err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
>>>>> +       if (err)
>>>>> +               goto msg_err;
>>>>> +
>>>>>           genlmsg_end(msg, hdr);
>>>>>           return 0;
>>>>>
>>>>> --
>>>>> 1.8.3.1
>>>>>
>

