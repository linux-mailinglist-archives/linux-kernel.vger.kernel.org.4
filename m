Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92167F245
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjA0XeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjA0XeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:34:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AA1757AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674862405;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M6k4SK0tssJUsReKgWrMbkASPa1DRov0Livqs+ZaJ88=;
        b=fTn5uxdEYz2qx6YAWWwbpvqcKHr+5fwNXF6EXCaYX2UEDtb5vS3wzsqg0OTum74DWmf9mo
        aruJKRrn/S7QGf+/PkYmDz+2l4t+3iegOurJszMMPnrHCvncvK+wU9xRUHB/VT8CW1B8KY
        h/+5VZ3Ru0yeg9fpS5SfNyLVGR168sw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-Ybk-MWwANHCBmQf3YXeg-w-1; Fri, 27 Jan 2023 18:33:21 -0500
X-MC-Unique: Ybk-MWwANHCBmQf3YXeg-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 651E829AA3B9;
        Fri, 27 Jan 2023 23:33:20 +0000 (UTC)
Received: from [10.64.54.64] (vpn2-54-64.bne.redhat.com [10.64.54.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 497E52166B26;
        Fri, 27 Jan 2023 23:33:11 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 2/4] KVM: arm64: Add helper vgic_write_guest_lock()
To:     Zenghui Yu <zenghui.yu@linux.dev>, kvmarm@lists.linux.dev
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pbonzini@redhat.com,
        corbet@lwn.net, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        yuzhe@nfschina.com, isaku.yamahata@intel.com, seanjc@google.com,
        ricarkol@google.com, eric.auger@redhat.com, renzhengeek@gmail.com,
        reijiw@google.com, shan.gavin@gmail.com
References: <20230126235451.469087-1-gshan@redhat.com>
 <20230126235451.469087-3-gshan@redhat.com>
 <a4b3ee35-a0d7-80f6-c64f-f9056c5b6110@linux.dev>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <9a8260b1-15f9-f8c9-34a7-0cce8e62a386@redhat.com>
Date:   Sat, 28 Jan 2023 10:33:09 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a4b3ee35-a0d7-80f6-c64f-f9056c5b6110@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 1/28/23 2:57 AM, Zenghui Yu wrote:
> [ just coming back from holiday, sorry for the late reply ]
> 

Hope you have a nice refresh. Thanks for your review.

> On 2023/1/27 07:54, Gavin Shan wrote:
>> Currently, the unknown no-running-vcpu sites are reported when a
>> dirty page is tracked by mark_page_dirty_in_slot(). Until now, the
>> only known no-running-vcpu site is saving vgic/its tables through
>> KVM_DEV_ARM_{VGIC_GRP_CTRL, ITS_SAVE_TABLES} command on KVM device
>> "kvm-arm-vgic-its". Unfortunately, there are more unknown sites to
>> be handled and no-running-vcpu context will be allowed in these
>> sites: (1) KVM_DEV_ARM_{VGIC_GRP_CTRL, ITS_RESTORE_TABLES} command
>> on KVM device "kvm-arm-vgic-its" to restore vgic/its tables. The
>> vgic3 LPI pending status could be restored. (2) Save vgic3 pending
> 
> We typically write it as "VGICv3".
> 

Ok. I will fix by replacing 'vgic3' with 'VGICv3' in v4. However, the
term 'vgic/its' will be kept.

>> table through KVM_DEV_ARM_{VGIC_GRP_CTRL, VGIC_SAVE_PENDING_TABLES}
>> command on KVM device "kvm-arm-vgic-v3".
>>
>> In order to handle those unknown cases, we need a unified helper
>> vgic_write_guest_lock(). struct vgic_dist::save_its_tables_in_progress
>> is also renamed to struct vgic_dist::save_tables_in_progress.
> 
> How about renaming it to 'write_tables_in_progress' which would look a
> bit more generic? The rest looks good to me.
> 

'write_tables_in_progress' works for me. I will have it in v4, which
will be posted shortly.

Thanks,
Gavin

