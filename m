Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC2602611
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJRHqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJRHqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9280C5F6D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666079160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oh14aX9pGA5a+7uHwqpL1Vv3ss7Q0VlmUNCbF+7O5n8=;
        b=ach6T3mOuKrQkenTbuDmwop2HXCoL4C1Wlp6FzIl30oChvSLsl71TuFURBnSlAzxVkyfu8
        XNEicgl5ITNsbDBnVenTlk2YtQdN5fB0LNE9F+X7Mtqfd3crMQ20xvvZ8fEJ7WadMbT5a/
        yGMU5bmk4VfMkkeZM/UPcAQzy6lG270=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-136-trNbHAv-NOWpSjjHpyybCA-1; Tue, 18 Oct 2022 03:45:58 -0400
X-MC-Unique: trNbHAv-NOWpSjjHpyybCA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-132b47fe3bdso5589696fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oh14aX9pGA5a+7uHwqpL1Vv3ss7Q0VlmUNCbF+7O5n8=;
        b=bjpHRMtw5GSk6VZ4u4loVA7X9q7XBjdMJSzrP7J/g/qsU/XAong/n1/B0YTQun1SFr
         360JDjzGj3ltlLoOCIhnz2ElGk1RWWvRLG1FyaJCSbFrxBTxC63mmn7IHZV5PJknUeOv
         zXHZ4cjGRFr5Q62X1rVMNZdcTeERkZhNfuZMsavUbR/DZCgL7g1wmBEURsiOq242j/Le
         QwYOZqo5uCWZFVPoCC8GXm1WtXWkR14vD1F8Q3nS+Ve9snPff8KjFE7j0pRvR+erMwQZ
         zCdmud4qTxp6WdwE1bpoStk4hMss6VCRBe8wI2QWy2BfVox5Z7E7e7e7gwM4eXNugWaE
         2Ylg==
X-Gm-Message-State: ACrzQf0d0vtr9wnDSQ55wmZRoC+lyGBo2J4X3UNIsf+lSR5bfZvExNQU
        WfK5mH039e+xSp/iNY4CaxC0B4uy2lP7SpGgxYPdC9E7xbDQgMuWgSLRj4PahHs6Nt3dofQ2UZu
        TizQi2cPA9/x/Xw8D94ZZjlCw
X-Received: by 2002:a05:6871:5cb:b0:136:9624:e222 with SMTP id v11-20020a05687105cb00b001369624e222mr17195470oan.96.1666079157536;
        Tue, 18 Oct 2022 00:45:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5hCe0mSMNZtpfSFw+XmMePrbLktt0DMcLiAawJYgdbw6HHaYB+xhLJJJRGdU3QC2YyC0xxZA==
X-Received: by 2002:a17:90a:5e04:b0:20b:1f20:5069 with SMTP id w4-20020a17090a5e0400b0020b1f205069mr36729853pjf.126.1666079146715;
        Tue, 18 Oct 2022 00:45:46 -0700 (PDT)
Received: from [10.72.13.80] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b001745662d568sm7911726plg.278.2022.10.18.00.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:45:46 -0700 (PDT)
Message-ID: <84027fbd-a340-4d85-e609-f8f1e1466825@redhat.com>
Date:   Tue, 18 Oct 2022 15:45:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        eperezma <eperezma@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Gautam Dawar <gdawar@xilinx.com>, Cindy Lu <lulu@redhat.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        Eli Cohen <elic@nvidia.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
 <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
 <afe960d3-730a-b52c-e084-40bf080b27fa@oracle.com>
 <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
 <c5a96de5-699a-8b5e-0e89-bfe1822e1105@oracle.com>
 <CACGkMEsJZshW6cMiGPBu4LBSAQYr3ZhsD006v2ncCvNgXW6RJw@mail.gmail.com>
 <8a4e3998-f4ae-a295-0cd5-5629776aec6a@oracle.com>
 <886bf07b-838d-2f7b-cb99-664c3e76a291@redhat.com>
 <e613a51c-c8c3-1021-6ac8-8ca485f4a9a5@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <e613a51c-c8c3-1021-6ac8-8ca485f4a9a5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/18 02:43, Si-Wei Liu 写道:
>
>
> On 10/13/2022 12:10 AM, Jason Wang wrote:
>>
>> 在 2022/10/7 08:35, Si-Wei Liu 写道:
>>>
>>>
>>> On 9/28/2022 9:55 PM, Jason Wang wrote:
>>>> On Tue, Sep 27, 2022 at 5:41 PM Si-Wei Liu <si-wei.liu@oracle.com> 
>>>> wrote:
>>>>>
>>>>>
>>>>> On 9/26/2022 8:59 PM, Jason Wang wrote:
>>>>>
>>>>> On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu <si-wei.liu@oracle.com> 
>>>>> wrote:
>>>>>
>>>>>
>>>>> On 9/26/2022 12:11 AM, Jason Wang wrote:
>>>>>
>>>>> On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <si-wei.liu@oracle.com> 
>>>>> wrote:
>>>>>
>>>>>
>>>>> On 9/21/2022 7:43 PM, Jason Wang wrote:
>>>>>
>>>>> This patch implements features provisioning for vdpa_sim_net.
>>>>>
>>>>> 1) validating the provisioned features to be a subset of the parent
>>>>>      features.
>>>>> 2) clearing the features that is not wanted by the userspace
>>>>>
>>>>> For example:
>>>>>
>>>>> # vdpa mgmtdev show
>>>>> vdpasim_net:
>>>>>     supported_classes net
>>>>>     max_supported_vqs 3
>>>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT 
>>>>> VERSION_1 ACCESS_PLATFORM
>>>>>
>>>>> Sighs, not to blame any one and it's perhaps too late, but this
>>>>> "dev_features" attr in "mgmtdev show" command output should have been
>>>>> called "supported_features" in the first place.
>>>>>
>>>>> Not sure I get this, but I guess this is the negotiated features 
>>>>> actually.
>>>>>
>>>>> Actually no, that is why I said the name is a bit confusing and 
>>>>> "supported_features" might sound better.
>>>>>
>>>>> You're right, it's an mgmtdev show actually.
>>>>>
>>>>> This attribute in the parent device (mgmtdev) denotes the real 
>>>>> device capability for what virtio features can be supported by the 
>>>>> parent device. Any unprivileged user can check into this field to 
>>>>> know parent device's capability without having to create a child 
>>>>> vDPA device at all. The features that child vDPA device may 
>>>>> support should be a subset of, or at most up to what the parent 
>>>>> device offers. For e.g. the vdpa device dev1 you created below can 
>>>>> expose less or equal device_features bit than 0x308820028 (MTU MAC 
>>>>> CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but 
>>>>> shouldn't be no more than what the parent device can actually 
>>>>> support.
>>>>>
>>>>> Yes, I didn't see anything wrong with "dev_features",
>>>>>
>>>>> Yep, it didn't appear to me anything wrong either at first sight, 
>>>>> then I gave my R-b on the series introduced this attribute. But 
>>>>> it's not a perfect name, either, on the other hand. Parav later 
>>>>> pointed out that the corresponding enum definition for this 
>>>>> attribute should follow pre-existing naming convention that we 
>>>>> should perhaps do 
>>>>> s/VDPA_ATTR_DEV_SUPPORTED_FEATURES/VDPA_ATTR_MGMTDEV_SUPPORTED_FEATURES/ 
>>>>> to get it renamed, as this is a mgmtdev level attribute, which I 
>>>>> agree. Now that with the upcoming "device_features" attribute 
>>>>> (vdpa dev level) from this series, it's subject to another 
>>>>> confusions between these two similar names, but actually would 
>>>>> represent things at different level. While all other attributes in 
>>>>> "mgmtdev dev show" seem to be aligned with the "supported_" 
>>>>> prefix, e.g. supported_classes, max_supported_vqs, from which I 
>>>>> think the stance of device is already implied through "mgmtdev" in 
>>>>> the command. For the perspective of clarify and easy distinction, 
>>>>> "supported_features" seems to be a better name than "dev_features".
>>>> See another reply, I think I get your point,
>>>>
>>>> 1) VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES (lingshan's series) and
>>>> VDPA_ATTR_VDPA_DEV_FEATURES should be equivalent and unified to a
>>>> single attribute.
>>>> 2) A better name to "supported_features" should be fine, patches 
>>>> are welcomed
>>>>
>>>>>   it aligns to the
>>>>> virtio spec which means the features could be used to create a vdpa
>>>>> device. But if everyone agree on the renaming, I'm fine.
>>>>>
>>>>> Never mind, if it's late don't have to bother.
>>>>>
>>>>>
>>>>>
>>>>> I think Ling Shan is working on reporting both negotiated features
>>>>> with the device features.
>>>>>
>>>>> Does it imply this series is connected to another work in 
>>>>> parallel? Is it possible to add a reference in the cover letter?
>>>>>
>>>>> I'm not sure, I remember Ling Shan did some work to not block the
>>>>> config show in this commit:
>>>>>
>>>>> commit a34bed37fc9d3da319bb75dfbf02a7d3e95e12de
>>>>> Author: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>> Date:   Fri Jul 22 19:53:07 2022 +0800
>>>>>
>>>>>      vDPA: !FEATURES_OK should not block querying device config space
>>>>>
>>>>> We need some changes in the vdpa tool to show device_features
>>>>> unconditionally in the "dev config show" command.
>>>>>
>>>>> That's true, I think I ever pointed it out to Lingshan before, 
>>>>> that it's not needed to bother exposing those config space fields 
>>>>> in "dev config show" output, if the only intent is for live 
>>>>> migration of device features between nodes. For vDPA live 
>>>>> migration, what cares most is those configuration parameters 
>>>>> specified on vdpa creation, and userspace VMM (QEMU) is supposed 
>>>>> to take care of saving and restoring live device states. I think 
>>>>> it's easier to extend "vdpa dev show" output to include 
>>>>> device_features and other config params as well, rather than count 
>>>>> on validity of various config space fields.
>>>> Probably, but for the migration it's more about the ability of the
>>>> mgmtdev instead of the vDPA device itself I think.
>>> If picking the appropriate device for migration is what it is 
>>> concerned, it's subject to the capability that mgmtdev offers. 
>>> That's true, for sure.
>>>
>>> On the other hand, mgmt software would also need to take care of 
>>> reconstructing the destination device with the same configuration as 
>>> that at the source side. For example, a mgmtdev on source supports 
>>> features A, B, C, D,  and destination mgmtdev supports features B, 
>>> C, D, E. When vdpa device on the source is initially created with 
>>> features B and C but without feature D (noted: creation with a 
>>> subset of mgmtdev features was already supported before, and this 
>>> series just makes it more explicit), the mgmt software is supposed 
>>> to equally create a device with features B and C on dest, even 
>>> though the destination may support feature D that the mgmtdev on 
>>> both sides can support. My point is, we should have some flexibility 
>>> on the mgmt software implementation that allows the mgmt software to 
>>> easily tell apart the exact features (i.e. B and C in the above 
>>> example) and the exact configuration a specific vdpa device was 
>>> originally created with, via some simple query command. Having mgmt 
>>> software to remember the vdpa creation args could work, but on the 
>>> other hand it'd be nice to allow lightweight software implementation 
>>> without having to persist the list of vdpa args and make vdpa tool 
>>> more self-contained.
>>>
>>> I will post a patch (series) shortly to demonstrate this idea. 
>>> Basically, there's no actual need to mess around with those config 
>>> space values for live migration. It was not built for that purpose.
>>
>>
>> Ok, let's see.
>>
>>
>>>
>>>>
>>>>> https://lore.kernel.org/virtualization/454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com/ 
>>>>>
>>>>>
>>>>> It's not just insufficient, but sometimes is incorrect to create 
>>>>> vDPA device using the config space fields.  For instance, MAC 
>>>>> address in config space can be changed temporarily (until device 
>>>>> reset) via ctrl_vq VIRTIO_NET_CTRL_MAC_ADDR_SET command. It's 
>>>>> incorrect to create vDPA using the MAC address shown in the config 
>>>>> space.
>>>> I think it's still a must for create the mac with the exact mac 
>>>> address:
>>>>
>>>> 1) VIRTIO_NET_F_CTRL_MAC is not a must
>>>> 2) there's no way for us to know whether or not the mac has been 
>>>> changed
>>> Noted I think here we are still talking about VERSION_1 device which 
>>> is spec conforming. So far as I understand the spec, if the 
>>> VIRTIO_NET_F_CTRL_MAC feature is not negotiated, there's no way for 
>>> driver to change the default MAC address.
>>
>>
>> For 1.0 device yes.
>>
>>
>>>
>>> Even if we want to simulate or support a legacy device model, when 
>>> MAC address is changed by legacy driver somehow, QEMU should be able 
>>> to detect this and issue a vdpa ioctl call to change the MAC address 
>>> filter underneath. I don't see that it ever happens in today's code, 
>>> so I presume the only possibility this may work is that the specific 
>>> vDPA device may have an internal learning bridge that adapts to what 
>>> MAC address the driver actually sends. 
>>
>>
>> This is not true AFAIK. E.g when switchdev is enabled for mlx5 parent.
> Hmmm, I guess you mean switchdev mode with external learning bridge 
> software e.g. Open vSwitch? It's conceptionally the same with device 
> internal learning bridge, no?


I was told by Eli that when switchdev is enabled there will be no 
learning bridge. I might be wrong, cc Eli for more comments.


>
> OK, though the point was that QEMU should anyway notify the backend of 
> the mac address change for vDPA driver to apply the new MAC filter, 
> similar to the way how CTRL_MAC ctrl_vq command is doing.


Yes.


> It should not blindly assume that the every vDPA hardware may have 
> underlying learning bridge construct, being internal or external. 
> Basically it's not a universal assumption on the existence of learning 
> bridge, this won't work for any other vDPA NIC without switchdev or 
> learning bridge.
>
>>
>>
>>> In this case, since the device doesn't care, recreate with the MAC 
>>> in use is not needed, and technically it is even incorrect. In data 
>>> centers or cloud environment, MAC address is usually controlled and 
>>> managed by some central entity/service. If a driver can dominate the 
>>> MAC address in use by deliberately overriding the default MAC and 
>>> bypassing the central rule via live migration, that'd be a more 
>>> severe security issue to address in the first place.
>>
>>
>> There used to be a discussion to allow trust and spoof check as what 
>> SR-IOV did. For safety, we can filter out CTRL_MAC right now. But I 
>> think it's something out of the scope for this discussion.
> Sorry I don't get what you mean here, but I guess we may talk about 
> different thing here (it seems you talked about trusted model that 
> allows any MAC address, but it's orthogonal to programming MAC address 
> filter to the underlying hardware as far as I understand).


Probably, what I meant is that, most SRIOV vendor allow to forbid change 
VF mac addresses and other filter for safety.


>
>>
>> But I still don't get what's wrong with have the same mac address 
>> provisioned in both src and dst.
> It looks like we may have misunderstood each other - that's exactly 
> the point I want to make. The persistent mac address provisioned in 
> dst by the mgmt software should stay the same with that on src, which 
> is the default mac address rather than whatever other (temporary) mac 
> address the VM might be using at the time of migration switchover at 
> the source.


Yes, I think we are at the same page now.


>
>> It is the model used currently (e.g libvirt will guarantee the same 
>> mac in both src and dst). The mgmt software can then guarantee that 
>> the mac was fetched from the centralized manager.
> Right, this is exactly the way our mgmt software works.
>
>> And we can't depend purely on the migration since in some case it 
>> can't work: e.g src MTU 4000 dst MTU 1500, migration will fail and 
>> mgmt stack need to provision an 4000 to work.
> This seems like a bug of libvirt. For our case, we strictly prohibit 
> unequal MTU on src & dst to work. Even migrating from MTU 1500 to 
> 4000, it effectively changes the underlying behavior for packet 
> dropping and network setup at which maximum size the packet should be 
> allowed when entering the VM.


Yes, this means the management layer should guarantee exact the same 
attribute for vDPA provisioned in both source and destination.


>>
>>
>>>
>>>> 3) migration code can restore the mac during restore
>>>>
>>>> So exactly the same mac address is still required. (This is the same
>>>> as we are doing for live migration on software virtio)
>>>>
>>>>>   Another example, if the source vDPA device has MAC address table 
>>>>> size limit of 100, then in the destination we should pick parent 
>>>>> device with size limit no smaller than that, and create vDPA on 
>>>>> remote node matching the exact same size. There's nothing config 
>>>>> space field can assist here.
>>>> Two ways:
>>>>
>>>> 1) mgmtdev should show the mac table size so mgmt layer can provision
>>>> the mac table size
>>>> 2) If the mac table exceeds what is supported in the destination, it
>>>> needs to enable the all uni in this case.
>>> Yep, so no field in the config space can help with these two 
>>> solutions, right? MAC table size is not showing up there. Whether 
>>> the parent device supports ALLUNI via VIRTIO_NET_F_CTRL_RX is not 
>>> there, either. (showing them in the 'vdpa mgmtdev show' output is 
>>> the right thing IMHO).
>>>
>>>>
>>>>> One example further, in the future, if we are going to introduce 
>>>>> mandatory feature (for e.g. VERSION_1, RING_PACKED) that the 
>>>>> device is unable to support the opposite case, the destination 
>>>>> device should be created with equally same mandatory device 
>>>>> features, which only vDPA creation parameters should matter. While 
>>>>> I can't think of a case that the mgmt software or live migration 
>>>>> tool would have to count on config space fields only.
>>>> Yes, in this case we need to introduce new netlink attributes for both
>>>> getting mandatory features from the management device and provisioning
>>>> those manadating features.
>>> True, management device level thing again, not related to anything 
>>> in the config space.
>>>
>>>>
>>>>>
>>>>>
>>>>>
>>>>> 1) provision vDPA device with all features that are supported by the
>>>>>      net simulator
>>>>>
>>>>> # vdpa dev add name dev1 mgmtdev vdpasim_net
>>>>> # vdpa dev config show
>>>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>>>     negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 
>>>>> ACCESS_PLATFORM
>>>>>
>>>>> Maybe not in this patch, but for completeness for the whole series,
>>>>> could we also add device_features to the output?
>>>>>
>>>>> Lingshan, could you please share your thoughts or patch on this?
>>>>>
>>>>> Noted here the device_features argument specified during vdpa 
>>>>> creation is introduced by this series itself, it somehow slightly 
>>>>> changed the original semantics of what device_features used to be.
>>>>>
>>>>> I'm not sure I get this, we don't support device_features in the past
>>>>> and it is used to provision device features to the vDPA device which
>>>>> seems to be fine.
>>>>>
>>>>> Before this change, only look at the dev_features in "mgmtdev 
>>>>> show" and remember creation parameters is sufficient to get to all 
>>>>> needed info for creating vDPA at destination.
>>>> Note that even with the same vendor, mgmtdev may support different 
>>>> features.
>>>>
>>>>> After this change, dev_features in "mgmtdev show" becomes less 
>>>>> relevant, as it would need to remember vdpa creation parameters 
>>>>> plus the device_features attribute. While this series allows cross 
>>>>> vendor live migration, it would complicate the implementation of 
>>>>> mgmt software, on the other hand.
>>>> To allow cross vendor live migration I couldn't find a better way.
>>> The idea itself is great, I think, though the CLI interface may have 
>>> some space for improvement. For example, user has to supply the 
>>> heximal value consisting of each feature bit, which is a bit 
>>> challenging for normal users who are not super familiar with each 
>>> virtio feature. On the other hand, there could be ambiguity against 
>>> other vdpa create option, e.g. users may do "vdpa dev add name vdpa0 
>>> mgmtdev ... mtu 1500 device_features 0x300020000" (no F_MTU feature 
>>> bit in device_features) that needs special validation in the code.
>>
>>
>> We can accept e.g XML in the future I think.
> Regardless of XML being a good interface or not for end users, but I 
> don't see how it relates to the issue here i.e. conflict/ambiguity or 
> extra validation in the (kernel) code.


It's only about choosing a suitable interface between vdpa tool and 
mangment layer instead of solely depending on the command line arguments 
since we may support a lot of different features in the future.


>
>>
>>
>>>
>>> How about we follow the CPU flags model or QEMU virtio-net-pci args 
>>> to define property representing each feature bit? I think the 
>>> current convention for each "vdpa dev add" option implies that the 
>>> corresponding feature bit will be enabled once specified in 
>>> creation. Similarly we can introduce additional option representing 
>>> each feature bit, along with a new features_default property 
>>> denoting the initial value for device_feature bits:
>>>
>>> # vdpa mgmtdev show
>>> vdpasim_net:
>>>   supported_classes net
>>>   max_supported_vqs 3
>>>   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 
>>> ACCESS_PLATFORM
>>> # vdpa dev add name dev1 mgmtdev vdpasim_net features_default off \
>>>                           csum on guest_csum on mtu 2000 ctrl_vq on 
>>> version1 on access_platform on
>>> # vdpa dev show
>>> dev1: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 3 
>>> max_vq_size 256
>>>    features_default off mtu 2000
>>>    device_features CSUM GUEST_CSUM MTU CTRL_VQ VERSION_1 
>>> ACCESS_PLATFORM
>>>
>>> If the features_default property is left unspecified or with the 
>>> "inherited" value, it would just inherit all of the 
>>> supported_features from mgmtdev (which is already the case of today).
>>>
>>> # vdpa dev add name dev1 mgmtdev vdpasim_net features_default inherited
>>> # vdpa dev show
>>> dev1: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 3 
>>> max_vq_size 256
>>>   features_default inherited
>>>   device_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 
>>> ACCESS_PLATFORM
>>>
>>> I can definitely help implement this model if you find it fits.
>>
>>
>> I prefer XML since it could be reused and we may exceed 64bit 
>> limitation in the future. But we can hear from others.
> I don't see how this can be re-used by QEMU as QMP is not 
> taking/exporting XML. Are we talking about libvirt here, which happens 
> to be one amongst many others? My personal feeling is that not quite a 
> lot of human end users (rather than management software or script) 
> today would prefer using XML. Instead, like any other iproute utility, 
> json seems to a more popular interface for script and mgmt software to 
> consume, which vdpa tool supports natively already.
>
> I think basically we can support two set of CLI interfaces, one 
> friendly enough for human users, and another scriptable and parseable 
> by management software users. IMO for now we should start to focus on 
> the human oriented CLI design first. Whether XML v.s. json being an 
> ideal interface for managment software would be another discussion 
> that would need more inputs from the broader range of extended 
> community, which is not worth distracting from.


That's fine, is the end user is more about a program but a human, json 
should be better.

Thanks


>
>>
>>>
>>>>
>>>>>
>>>>>
>>>>> When simply look at the "vdpa dev config show" output, I cannot 
>>>>> really
>>>>> tell the actual device_features that was used in vdpa creation. 
>>>>> For e.g.
>>>>> there is a missing feature ANY_LAYOUT from negotiated_features 
>>>>> compared
>>>>> with supported_features in mgmtdev, but the orchestration software
>>>>> couldn't tell if the vdpa device on destination host should be 
>>>>> created
>>>>> with or without the ANY_LAYOUT feature.
>>>>>
>>>>> I think VERSION_1 implies ANY_LAYOUT.
>>>>>
>>>>> Right, ANY_LAYOUT is a bad example. A good example might be that, 
>>>>> I knew the parent mgmtdev on migration source node supports 
>>>>> CTRL_MAC_ADDR, but I don't find it in negotiated_features.
>>>>>
>>>>> I think we should use the features that we got from "mgmtdev show"
>>>>> instead of "negotiated features".
>>>>>
>>>>> That was how it's supposed to work previously, but with this 
>>>>> series, I think the newly introduced device_features will be 
>>>>> needed instead of the one in "mgmtdev show".
>>>> Just to clarify, there won't be a device_features in mgmtdev show
>>>> since it is device specific, each individual device can have its own
>>>> device features which are subset of what is supported by the mgmtdev.
>>> Yep.
>>>>
>>>>>
>>>>> On the migration destination node, the parent device does support 
>>>>> all features as the source offers, including CTRL_MAC_ADDR. What 
>>>>> device features you would expect the mgmt software to create 
>>>>> destination vdpa device with, if not otherwise requiring mgmt 
>>>>> software to remember all the arguments on device creation?
>>>> So the provisioning in the destination should use exactly the same
>>>> device_feautres as what the vdpa device has in the source. But before
>>>> this, management layer should guarantee to provision a vDPA device
>>>> whose device_features can be supported on the destination in order to
>>>> allow live migration.
>>> Exactly.
>>>>
>>>>> So in this example, we need use "dev_features" so we get exact the
>>>>> same features after and operation as either src or dst.
>>>>>
>>>>> If the device_features vDPA created with at the source doesn't 
>>>>> include CTRL_MAC_ADDR even though parent supports it, then the 
>>>>> vDPA to be created at the destination shouldn't come with 
>>>>> CTRL_MAC_ADDR either, regardless of whether or not CTRL_MAC_ADDR 
>>>>> is present in destination "mgmtdev show".
>>>>>
>>>>> However, if just taking look at negotiated_features, some mgmt 
>>>>> software implementations which don't persist the creation 
>>>>> parameters can't get the device features a certain vDPA device at 
>>>>> the source node was created with.
>>>>>
>>>>>
>>>>> SOURCE# vdpa mgmtdev show
>>>>> vdpasim_net:
>>>>>     supported_classes net
>>>>>     max_supported_vqs 3
>>>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT 
>>>>> VERSION_1 ACCESS_PLATFORM
>>>>> SOURCE# vdpa dev config show
>>>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>>>     negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>>>>
>>>>> DESTINATION# vdpa mgmtdev show
>>>>> vdpasim_net:
>>>>>     supported_classes net
>>>>>     max_supported_vqs 3
>>>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT 
>>>>> VERSION_1 ACCESS_PLATFORM
>>>>>
>>>>>   But it should be sufficient to
>>>>> use features_src & feature_dst in this case. Actually, it should work
>>>>> similar as to the cpu flags, the management software should introduce
>>>>> the concept of cluster which means the maximal set of common features
>>>>> is calculated and provisioned during device creation to allow
>>>>> migration among the nodes inside the cluster.
>>>>>
>>>>> Yes, this is one way mgmt software may implement, but I am not 
>>>>> sure if it's the only way. For e.g. for cpu flags, mgmt software 
>>>>> can infer the guest cpus features in use from all qemu command 
>>>>> line arguments and host cpu features/capability, which doesn't 
>>>>> need to remember creation arguments and is easy to recover from 
>>>>> failure without having to make the VM config persistent in data 
>>>>> store. I thought it would be great if vdpa CLI design could offer 
>>>>> the same.
>>>>>
>>>>> One minor difference is that we have cpu model abstraction, so we can
>>>>> have things like:
>>>>>
>>>>> ./qemu-system-x86_64 -cpu EPYC
>>>>>
>>>>> Which implies the cpu features/flags where vDPA doesn't have. But
>>>>> consider it's just a 64bit (or 128 in the future), it doesn't 
>>>>> seems to
>>>>> be too complex for the management to know, we probably need to start
>>>>> from this and then we can try to introduce some generation/model 
>>>>> after
>>>>> it is agreed on most of the vendors.
>>>>>
>>>>> What you refer to is the so-called named model for CPU flags. I 
>>>>> think it's a good addition to have some generation or named model 
>>>>> defined for vDPA. But I don't get the point for how it relates to 
>>>>> exposing the actual value of device features? Are you saying in 
>>>>> this case you'd rather expose the model name than the actual value 
>>>>> of feature bits? Well, I think we can expose both in different 
>>>>> fields when there's really such a need.
>>>> It's something like:
>>>>
>>>> vdpa dev add name dev1 mgmtdev vdpasim_net device_features 
>>>> VDPA_NET_MODEL_1
>>>>
>>>> and VDPA_NET_MODEL_1 implies some feature sets.
>>>
>>> Not sure if this could be very useful for virtio devices, given we 
>>> don't have a determined set of virtio features unlike CPU 
>>> generation/model, but I think even with the features_default 
>>> property we can still achieve that.
>>>
>>> -Siwei
>>
>>
>> Yes.
> Let me get some time to implement and post the relevant patches 
> (mostly in iproute) later. Basically this would supplement those 
> config attributes introduced through the 'vdpa dev show' series below 
> [1] with provisioned device features to reference:
>
> [1] 
> https://lore.kernel.org/virtualization/1665793690-28120-1-git-send-email-si-wei.liu@oracle.com/
>
>
> Thanks,
> -Siwei
>
>>
>> Thanks
>>
>>
>>>
>>>>
>>>>> BTW with regard to the cpu model in mgmt software implementation, 
>>>>> the one implemented in libvirt is a mixed "Host model" [1] with 
>>>>> taking advantage of QEMU named model and exposing additional 
>>>>> individual CPU features that gets close to what host CPU offers.
>>>> So creating vDPA device without "device_features" is somehow the host
>>>> model, it will have all features that is supported by the parent.
>>>>
>>>>> I think this implies that mgmt software should have to understand 
>>>>> what the model name really means in terms of individual CPU 
>>>>> features, so having feature bit value exposed will just do more 
>>>>> help if vDPA goes the same way.
>>>> Exactly.
>>>>
>>>> Thanks
>>>>
>>>>>
>>>>> Regards,
>>>>> -Siwei
>>>>>
>>>>> [1] 
>>>>> https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html#two-ways-to-configure-cpu-models-with-qemu-kvm
>>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>> Thanks,
>>>>> -Siwei
>>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>> Thanks,
>>>>> -Siwei
>>>>>
>>>>>
>>>>> 2) provision vDPA device with a subset of the features
>>>>>
>>>>> # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 
>>>>> 0x300020000
>>>>> # vdpa dev config show
>>>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>>>     negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>>>>
>>>>> Reviewed-by: Eli Cohen <elic@nvidia.com>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>> ---
>>>>>    drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
>>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c 
>>>>> b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>>>> index 886449e88502..a9ba02be378b 100644
>>>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>>>> @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct 
>>>>> vdpa_mgmt_dev *mdev, const char *name,
>>>>>        dev_attr.work_fn = vdpasim_net_work;
>>>>>        dev_attr.buffer_size = PAGE_SIZE;
>>>>>
>>>>> +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>>>>> +             if (config->device_features &
>>>>> +                 ~dev_attr.supported_features)
>>>>> +                     return -EINVAL;
>>>>> +             dev_attr.supported_features &=
>>>>> +                      config->device_features;
>>>>> +     }
>>>>> +
>>>>>        simdev = vdpasim_create(&dev_attr);
>>>>>        if (IS_ERR(simdev))
>>>>>                return PTR_ERR(simdev);
>>>>> @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
>>>>>        .id_table = id_table,
>>>>>        .ops = &vdpasim_net_mgmtdev_ops,
>>>>>        .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>>>>> -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>>>>> +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
>>>>> +                          1 << VDPA_ATTR_DEV_FEATURES),
>>>>>        .max_supported_vqs = VDPASIM_NET_VQ_NUM,
>>>>>        .supported_features = VDPASIM_NET_FEATURES,
>>>>>    };
>>>>>
>>>>>
>>>>>
>>>
>>
>

