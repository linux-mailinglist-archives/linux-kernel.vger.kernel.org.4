Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B0962247A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKIHLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIHLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:11:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702581132
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667977837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z8NegCm67J0S4B/NxO8RqNLn7F2CnpTCF2plvOYoaYI=;
        b=gO3r/5KqJ8LcxMfZTm5xSGArVBV9nVZwpgBFvz2uL57pWd1KCKajkg8KbeJj9G65XxwOl1
        7CO3vGWFiY8M6oKfg65r5gy4jwABD+kqy+MU1+a4FN4dsuDFusQnCeL6n067JWNUw0oae2
        DwNudSh/qC5/X10cCTQRRfuqNpUOmRI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-6SbiXU3aMjWovhalKnt6Vg-1; Wed, 09 Nov 2022 02:10:36 -0500
X-MC-Unique: 6SbiXU3aMjWovhalKnt6Vg-1
Received: by mail-qt1-f200.google.com with SMTP id fz10-20020a05622a5a8a00b003a4f466998cso11973255qtb.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 23:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8NegCm67J0S4B/NxO8RqNLn7F2CnpTCF2plvOYoaYI=;
        b=oDYZNmncVmxhdJIn0TNALwWRX5F6KTxFm2TUnZl0E9GhlOy24K2/onRNeXzfglBqLl
         iJnCLeerFdqT3Yg3zA2EC7TIeVrkgRyTzR4FYNB6bzhutJ8o5YM+MvTYn3jklzQmfTsa
         KUF79rdSn5n6GTrdxSGgC8pFcbwF/3RlUWu7CrhBYFLx2jsjeAloH7ane4lvw0Q+/8Ah
         s8vWdps+1jvsYDUo6KHmsHs5jjV4qXtYcytRtXOtcjPZtdbtDZ2JC+dLKMi7HEYS5LCR
         63zjYUozHsZpPrztW3scac5QNkHBg+OTlBoAVQWjd3jkzQKyDe/4hqlpoupd9QYA4FYr
         Uv4g==
X-Gm-Message-State: ACrzQf3ljxM3AvA4g1TzZQy1J4o/FGrHcx3HlviDk5y05ulDKC6uwMpj
        PFu1MmOSOGh2zaIFogorSV/NqxqxDY6P+Ec1SlCcbw2kWP7FN4ejqFqiqQWyFZOraIsQFpm2ENM
        wBEoPLuh1+szr6peJHHayGA4g
X-Received: by 2002:a05:622a:4aca:b0:3a5:24ff:3236 with SMTP id fx10-20020a05622a4aca00b003a524ff3236mr41013849qtb.236.1667977835704;
        Tue, 08 Nov 2022 23:10:35 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4o1UZNJwnAx3xV8v2WrRTPd3WHBu9N3h0WnM4N4iaoom/yw8bC88Px39Vzi/5VRUQcRnNMKg==
X-Received: by 2002:a05:622a:4aca:b0:3a5:24ff:3236 with SMTP id fx10-20020a05622a4aca00b003a524ff3236mr41013838qtb.236.1667977835482;
        Tue, 08 Nov 2022 23:10:35 -0800 (PST)
Received: from redhat.com ([185.195.59.52])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a28d300b006ec771d8f89sm11156496qkp.112.2022.11.08.23.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 23:10:34 -0800 (PST)
Date:   Wed, 9 Nov 2022 02:10:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wei Gong <gongwei833x@gmail.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221109020614-mutt-send-email-mst@kernel.org>
References: <20221109043617.GA900761@zander>
 <20221109051234.GA532217@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109051234.GA532217@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:12:34PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 09, 2022 at 04:36:17AM +0000, Wei Gong wrote:
> > O Tue, Nov 08, 2022 at 01:02:35PM -0500, Michael S. Tsirkin wrote:
> > > On Tue, Nov 08, 2022 at 11:58:53AM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Nov 08, 2022 at 10:19:07AM -0500, Michael S. Tsirkin wrote:
> > > > > On Tue, Nov 08, 2022 at 09:02:28AM -0600, Bjorn Helgaas wrote:
> > > > > > On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> > > > > > > On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > virtio uses the same driver for VFs and PFs.
> > > > > > > > Accordingly, pci_device_is_present is used to detect
> > > > > > > > device presence. This function isn't currently working
> > > > > > > > properly for VFs since it attempts reading device and
> > > > > > > > vendor ID.
> > > > > > > 
> > > > > > > > As VFs are present if and only if PF is present,
> > > > > > > > just return the value for that device.
> > > > > > > 
> > > > > > > VFs are only present when the PF is present *and* the PF
> > > > > > > has VF Enable set.  Do you care about the possibility that
> > > > > > > VF Enable has been cleared?
> > > > 
> > > > I think you missed this question.
> > > 
> > > I was hoping Wei will answer that, I don't have the hardware.
> > 
> > In my case I don't care that VF Enable has been cleared.
> 
> OK, let me rephrase that :)
> 
> I think pci_device_is_present(VF) should return "false" if the PF is
> present but VFs are disabled.
> 
> If you think it should return "true" when the PF is present and VFs
> are disabled, we should explain why.
> 
> We would also need to fix the commit log, because "VFs are present if
> and only if PF is present" is not actually true.  "VFs are present
> only if PF is present" is true, but "VFs are present if PF is present"
> is not.
> 
> Bjorn

Bjorn, I don't really understand the question.

How does one get a vf pointer without enabling sriov?
They are only created by sriov_add_vfs after calling
pcibios_sriov_enable.



-- 
MST

