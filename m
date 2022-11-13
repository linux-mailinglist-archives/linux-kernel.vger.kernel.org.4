Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875C7626D49
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 02:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiKMBLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 20:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiKMBLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 20:11:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F1513F30
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ouyz0uvCF051aOaxqe1j8nXB1jO4S3Lii7seD6A2SpY=; b=TS/BlNnRMj0ZpcsIBKdz3cBcqE
        c1oPvKn2NWH19F9GncZQcnkqPwh8DC4QIYD+S3srC7mc+LKknQb0nqWYFRyhOjbUBHnCbqJnbNog5
        dU+9T7WZAJNT8pRBDgs3TAMXju5K4DvtRItMIrBgGFY4/3V0v3wySkrIHf2Jse+gc/651R6hcdu50
        Ni6TK9BnUebmqJ+SmZ+U3sN8HdVeP3AbyoKKk4X4EGoqVDsn8jn2rAq1Y4VXo5IF9XvdlzyQluYrV
        QjVgibky0B/5Chh9KTy05t0tc4Aijfll0LJDnXhmDoPYYv968r8aPFghK185QS7sNxz7iGAgF5qV6
        cNqHPSSg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ou1Wz-008kzq-5E; Sun, 13 Nov 2022 01:11:29 +0000
Message-ID: <abdb1b8d-859d-669b-6bbf-604febb643b2@infradead.org>
Date:   Sat, 12 Nov 2022 17:11:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: include: linux: slab: kmalloc_trace undefined when compiling
 drivers
Content-Language: en-US
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <Y2/Luovqgz8O+Kqa@rhino>
 <f83aca33-3a5f-97ac-625e-aa7c72bf60ba@infradead.org> <Y3AXVRAoZA5YEho+@rhino>
 <1df133ef-d5e9-f323-7c67-fc9ffed04274@infradead.org> <Y3A9waTkehESUyn+@rhino>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y3A9waTkehESUyn+@rhino>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/22 16:43, Ian Cowan wrote:
> On Sat, Nov 12, 2022 at 04:34:18PM -0800, Randy Dunlap wrote:
>>
>>
>> On 11/12/22 13:59, Ian Cowan wrote:
>>> On Sat, Nov 12, 2022 at 09:21:34AM -0800, Randy Dunlap wrote:
>>>> Hi--
>>>>
>>>> On 11/12/22 08:37, Ian Cowan wrote:
>>>>> When compiling drivers (speficially drivers/pci/hotplug), I am receiving
>>>>> the following modpost error for both `kmalloc_trace` and
>>>>> `kmalloc_node_trace` on the staging/staging-next branch:
>>>>>
>>
>> Ian, what do you mean by "on the staging/staging-next branch"?
>>
>> What kernel version are you trying to build?
>>
>> The .config that you sent is for v6.1.0-rc1.
> 
> I am building from the staging repository (gregkh/staging) and my
> working branch when building is staging-next. So I am trying to build
> from staging and not a particular version. I have also run `make modules_prepare`
> and updated the .config per that script. However, when I do build
> v6.1.0-rc1 from the main repository (torvalds/linux), I run into the same problem.

Have you built the entire kernel already and then you are trying to build
only drivers/pci/hotplug?

If I build *only* drivers/pci/hotplug, I do get undefined symbols:

WARNING: modpost: "strcmp" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: "kfree" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: "pci_slots_kset" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: "acpiphp_unregister_attention" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: "acpi_remove_notify_handler" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: "sysfs_remove_bin_file" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: "acpi_evaluate_object" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: "__kmalloc" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: "memcpy" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: "acpi_walk_namespace" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
WARNING: modpost: suppressed 14 unresolved symbol warnings because there were too many)

but that's understandable since the object files that would contain those symbols
have not been built yet.

-- 
~Randy
