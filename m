Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86DF6D6C8A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjDDSo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjDDSoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE21734
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680633819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVe2x7+RkmWzTA4UkLZDpP7zxrG0357xafz+5+qM8mk=;
        b=R/I1XlhwKX6/AVZ7whWqVvXMRX0ikOIqFLfaLONGlm+ZNFzvaO1HsIFbl1zJaIKcaZVGoq
        h9n6jWOC/Ud3jmPfEeNNlAHz8+rOY1RUZ8d9qtV67FsrsBRVxTZziu7r1f8KvD+vtE/jxy
        Sep/XNIkxVQwdVYYbEZZZ9HzaAfXb7A=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-dt6Z0HhoMaaCAVS5zyD0DA-1; Tue, 04 Apr 2023 14:43:38 -0400
X-MC-Unique: dt6Z0HhoMaaCAVS5zyD0DA-1
Received: by mail-il1-f199.google.com with SMTP id n17-20020a056e02141100b003259a56715bso21596427ilo.15
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680633817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVe2x7+RkmWzTA4UkLZDpP7zxrG0357xafz+5+qM8mk=;
        b=3XV4tpTbjmt9Sdzn9UeNb485MU0yA54u09JFYZhrMuhyr72oL8KAjM3JMwhvNVsPKP
         zvlbkLCfYDYmQ/DAIInSZM7Tpd3JX4pkyPfj/thBI+bo4uxa2mR5Gdg+fwjFJHFy83Sq
         Dg4VbqUzzskO/oW1t24oklbxHaWSUZYjq7I2DfEr3Iem23fBBAjQSpwAz+h6+4S9xg1+
         WcaIQ3rsSRkrSX6MwFYOOUGAIeN7DtQY9nwMn+7DjEcw5kVMpWgMnkza24IHNt25x/Ax
         QUSrTW0dnniN3RW3A0wDH9O2OMnnPQs32JU/UaUttMMCbs7ZyFycUwuJUfrxfeU5wVJF
         P4hQ==
X-Gm-Message-State: AAQBX9cgtC7d8lEkSk14V+aY+shAYQtLLcevLupDAHqQqAAh8Xb/8uLS
        E3dlN/zgH5lN+eZAJ5kW8/GeKLSyjRpHkKZosRydEwA6GIMhM1ENUF5W2xBxkJeVV8NoElZZ9es
        us8JG1S0eo2IyzHlpeLoV2GnL
X-Received: by 2002:a92:c688:0:b0:326:1bc5:3008 with SMTP id o8-20020a92c688000000b003261bc53008mr2426930ilg.32.1680633816960;
        Tue, 04 Apr 2023 11:43:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350bHhX25VBcEeAEy0phZawAEsaaqr+RqtIiHUEv4/fRP348Ef5cjI0z1ZqE0AE8rK/vx5e4UqQ==
X-Received: by 2002:a92:c688:0:b0:326:1bc5:3008 with SMTP id o8-20020a92c688000000b003261bc53008mr2426916ilg.32.1680633816676;
        Tue, 04 Apr 2023 11:43:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g14-20020a056e021a2e00b0032649ee77d6sm3201232ile.56.2023.04.04.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:43:36 -0700 (PDT)
Date:   Tue, 4 Apr 2023 12:43:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "darwi@linutronix.de" <darwi@linutronix.de>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "tom.zanussi@linux.intel.com" <tom.zanussi@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 7/8] vfio/pci: Support dynamic MSI-x
Message-ID: <20230404124334.45cddae2.alex.williamson@redhat.com>
In-Reply-To: <ad8c9137-bd57-4862-46c8-2c77a21b3419@intel.com>
References: <cover.1680038771.git.reinette.chatre@intel.com>
        <419f3ba2f732154d8ae079b3deb02d0fdbe3e258.1680038771.git.reinette.chatre@intel.com>
        <20230330164050.0069e2a5.alex.williamson@redhat.com>
        <20230330164214.67ccbdfa.alex.williamson@redhat.com>
        <688393bf-445c-15c5-e84d-1c16261a4197@intel.com>
        <20230331162456.3f52b9e3.alex.williamson@redhat.com>
        <e15d588e-b63f-ab70-f6ae-91ceea8be79a@intel.com>
        <20230403142227.1328b373.alex.williamson@redhat.com>
        <57a8c701-bf97-fddd-9ac0-fc4d09e3cb16@intel.com>
        <20230403211841.0e206b67.alex.williamson@redhat.com>
        <BN9PR11MB527626CAE4BA7ECB64F0E9728C939@BN9PR11MB5276.namprd11.prod.outlook.com>
        <ad8c9137-bd57-4862-46c8-2c77a21b3419@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 10:29:14 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Hi Kevin,
> 
> On 4/3/2023 8:51 PM, Tian, Kevin wrote:
> >> From: Alex Williamson <alex.williamson@redhat.com>
> >> Sent: Tuesday, April 4, 2023 11:19 AM  
> >>>
> >>> Thank you very much for your guidance. I will digest this some more and
> >>> see how wrappers could be used. In the mean time while trying to think  
> >> how  
> >>> to unify this code I do think there is an issue in this patch in that
> >>> the get_cached_msi_msg()/pci_write_msi_msg()
> >>> should not be in an else branch.
> >>>
> >>> Specifically, I think it needs to be:
> >>> 	if (msix) {
> >>> 		if (irq == -EINVAL) {
> >>> 			/* dynamically allocate interrupt */
> >>> 		}
> >>> 		get_cached_msi_msg(irq, &msg);
> >>> 		pci_write_msi_msg(irq, &msg);
> >>> 	}  
> >>
> >> Yes, that's looked wrong to me all along, I think that resolves it.
> >> Thanks,
> >>  
> > 
> > Do you mind elaborating why this change is required? I thought
> > pci_msix_alloc_irq_at() will compose a new msi message to write
> > hence no need to get cached value again in that case...  
> 
> With this change an interrupt allocated via pci_msix_alloc_irq_at()
> is treated the same as an interrupt allocated via pci_alloc_irq_vectors().
> 
> get_cached_msi_msg()/pci_write_msi_msg() is currently called for
> every allocated interrupt and this snippet intends to maintain
> this behavior.
> 
> One flow I considered that made me think this is fixing a bug is
> as follows:
> Scenario A (current behavior):
> - host/user enables vectors 0, 1, 2 ,3 ,4
>   - kernel allocates all interrupts via pci_alloc_irq_vectors()
>   - get_cached_msi_msg()/pci_write_msi_msg() is called for each interrupt

In this scenario, I think the intention is that there's non-zero
time since pci_alloc_irq_vectors() such that a device reset or other
manipulation of the vector table may have occurred, therefore we're
potentially restoring the programming of the vector table with this
get/write.

> Scenario B (this series):
> - host/user enables vector 0
>   - kernel allocates interrupt 0 via pci_alloc_irq_vectors()
>   - get_cached_msi_msg()/pci_write_msi_msg() is called for interrupt 0
> - host/user enables vector 1
>   - kernel allocates interrupt 1 via pci_msix_alloc_irq_at()
>   - get_cached_msi_msg()/pci_write_msi_msg() is NOT called for interrupt 1
>     /* This seems a bug since host may expect same outcome as in scenario A */
> 
> I am not familiar with how the MSI messages are composed though and I surely
> could have gotten this wrong. I would like to learn more after you considered
> the motivation for this change.

I think Kevin has a point, if it's correct that we do this get/write in
order to account for manipulation of the device since we wrote into the
vector table via either pci_alloc_irq_vectors() or
pci_msix_alloc_irq_at(), then it really only makes sense to do that
restore if we haven't allocated the irq and written the vector table
immediately prior.  Thanks,

Alex

