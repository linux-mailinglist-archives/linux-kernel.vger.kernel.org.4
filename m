Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44616FE336
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbjEJRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjEJRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C85258
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683739495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOlTwDHCPmwBSiEB7KGHM6ax/5uNDH7N9wFeFfqRMeY=;
        b=P10d85hAXXcqllRtVucrisAtia1PbFo/6+nlXY0lTF23N8EIskzCrHDoEXo5aCrJOgBqth
        9baRrQt62gz2K2wEA3/wVTtxgbsE4ZnYcqJcYZnxaKWCQWVM7KDwfMRK3/V5C6GdYEH/T4
        jP6vROvyIXhJmYc7Oi/88iRvz1vUzHU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-4-8kf_xiO_K1f07bEe-UMQ-1; Wed, 10 May 2023 13:24:53 -0400
X-MC-Unique: 4-8kf_xiO_K1f07bEe-UMQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-331195f31acso105849835ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683739493; x=1686331493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOlTwDHCPmwBSiEB7KGHM6ax/5uNDH7N9wFeFfqRMeY=;
        b=Wc4kEhuMB5JTa8J94W6XdddmXoMfaxt1UN3M3ql9o/RD0F5AkjMeDbllOXRavPXXxy
         GHfATwpDL/KxuzZyVaQUwu96H9TAsJtcF/ojstDU0gDDznOVgzSXLeMG7rtnosLVEjr7
         6BXY0FrMVJaAE820F7ZXvPVu1LNDrkXF4tWIY9cxq+KpOnYDLs1NZDQ9fkJhG7xFeG8+
         eReYTONMP4AbSDdKMWvMGFav9/+Zfd4ABkRmjEkGSkJ14X+9RgCM0llNNUd9BUNh/sg+
         XMkiswlAw1gOfxiF4K6w9apDUqNE8CHBpK5Taq6TlHalfOcc1x/kHVvxrM4zinwFeKnk
         ygnA==
X-Gm-Message-State: AC+VfDxr1DVKyP80uxZ93Hs4UNFYQvFkqYZzNwKnfS8ZdnNrO2UuOGts
        ZoAf13MamQvfaAeCWwu+g7XNXhi/ZQxK0PLZ+8PAoW0RXNsy0sm2NFUARcJAnr07PVQwoanFdyX
        Ay8D80yUBTAKn+XPLlh+ee/ag
X-Received: by 2002:a92:ce43:0:b0:335:7be2:26ca with SMTP id a3-20020a92ce43000000b003357be226camr6559716ilr.19.1683739492923;
        Wed, 10 May 2023 10:24:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6aATEZtRjDFDBRUdblfba170+1PnNywYygpeU1CiHkIiKx2rqdcbsSIF4GYmhHueY8CAz2kQ==
X-Received: by 2002:a92:ce43:0:b0:335:7be2:26ca with SMTP id a3-20020a92ce43000000b003357be226camr6559700ilr.19.1683739492692;
        Wed, 10 May 2023 10:24:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c16-20020a92cf50000000b0032aef6b60adsm2578467ilr.34.2023.05.10.10.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 10:24:52 -0700 (PDT)
Date:   Wed, 10 May 2023 11:24:49 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Lu, Baolu" <baolu.lu@intel.com>
Subject: Re: vPASID capability for VF
Message-ID: <20230510112449.4d766f6f.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB52764BE569672A02FE2A8CCA8C769@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB52764BE569672A02FE2A8CCA8C769@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 08:34:53 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> According to PCIe spec (7.8.9 PASID Extended Capability Structure):
> 
>   The PASID configuration of the single non-VF Function representing
>   the device is also used by all VFs in the device. A PF is permitted
>   to implement the PASID capability, but VFs must not implement it.
> 
> To enable PASID on VF then one open is where to locate the PASID
> capability in VF's vconfig space. vfio-pci doesn't know which offset
> may contain VF specific config registers. Finding such offset must
> come from a device specific knowledge.

Backup for a moment, VFs are governed by the PASID capability on the
PF.  The PASID capability exposes control registers that imply the
ability to manage various feature enable bits.  The VF owner does not
have privileges to manipulate those bits.  For example, the PASID Enable
bit should restrict the endpoint from sending TLPs with a PASID prefix,
but this can only be changed at the PF level for all associated VFs.

The protocol specified in 7.8.9.3 defines this enable bit as RW.  How do
we virtualize that?  Either it's virtualized to be read-only and we
violate the spec or we allow it to be read-write and it has no effect,
which violates the spec.

Is this capability really intended to be mirrored by software to the
VFs or do we need to expose the PASID capabilities of the VF in some
other way?  Thanks,

Alex

