Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98B36231E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiKIRum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiKIRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:50:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F66578
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668016174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+dtq26cOHViC7MMC06CZ0KeR+b2Q/p3nrVuuPwQv2U=;
        b=Js9AnaHyLSkA2MYuXLGs8s3Lb36c9kXQ9OzgJ+LEhWZvFkQs2LyzDIFeojMZqXDErE+zVU
        cQ6AvtqKpRDDjub68LQB501kGLksNSIRvGHXCR7QChSf1A2uDJNO48iZjniRZBJkVbwNUT
        FiedrDgxsiTymuSiqFO3UwrwxU0Ddi0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-8aAZfB32O1a2euEoNjse4g-1; Wed, 09 Nov 2022 12:49:32 -0500
X-MC-Unique: 8aAZfB32O1a2euEoNjse4g-1
Received: by mail-qt1-f198.google.com with SMTP id y19-20020a05622a121300b003a526e0ff9bso13044215qtx.15
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 09:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+dtq26cOHViC7MMC06CZ0KeR+b2Q/p3nrVuuPwQv2U=;
        b=jCoSv/TpHNEoKQiX071ufKyzAN3QAhslM+yv3DaIJrpzT2GTjGJnvQmPpOZFmKmQbR
         bvugqivUJUQTopty4yTHwCmSxgVDBj0wQnzTXKL7eekXqLHSatS3nbAhZMPJ5KCflZvI
         I9EQt2NKu7wqeEuevTcDbhMID2WUCKxrERr+zPnCR1Danh1vXJeiip7XGR7b2yIy8on/
         e1XVw/rg5uGrfav1erSKgR4l0wP1DQs8Q8ju2x5Vhi9Vd5EzHa+1ktZtvI7y8ibX1sWl
         0mLNy/qpJgZ0GFHHEQzXQLHzoljF9VU1LZNwFe5WmkLJA/n3h5lxu2U5y5563CVG8DkD
         aXdA==
X-Gm-Message-State: ACrzQf2ghYxussQ5Z679DD6eNL+emWfoq4x7q+nbzRt+1fQUTDgFazy4
        3LNKR/Rv8gX+3nGvVWauiOhwOL9Ybjygrdf2sGbIZ6wbn0NXyGNgyp27ctZXhADNZOHOwxkHer6
        9xL9SOaGU0wRv1cQasODH+sSg
X-Received: by 2002:a05:620a:208d:b0:6fa:b41e:8a02 with SMTP id e13-20020a05620a208d00b006fab41e8a02mr15491282qka.540.1668016171677;
        Wed, 09 Nov 2022 09:49:31 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4IS4VBS1CYlf0r8rb8sLXJK1uvZEJYaJucuYdB6gBD8fjx4zwhxQLRwyvQuNm0SdVqZaleTA==
X-Received: by 2002:a05:620a:208d:b0:6fa:b41e:8a02 with SMTP id e13-20020a05620a208d00b006fab41e8a02mr15491259qka.540.1668016171349;
        Wed, 09 Nov 2022 09:49:31 -0800 (PST)
Received: from redhat.com ([185.195.59.47])
        by smtp.gmail.com with ESMTPSA id v22-20020a05620a441600b006eeaf9160d6sm11660121qkp.24.2022.11.09.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:49:31 -0800 (PST)
Date:   Wed, 9 Nov 2022 12:49:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wei Gong <gongwei833x@gmail.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221109124803-mutt-send-email-mst@kernel.org>
References: <20221109020614-mutt-send-email-mst@kernel.org>
 <20221109173029.GA554381@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109173029.GA554381@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:30:29AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 09, 2022 at 02:10:30AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 08, 2022 at 11:12:34PM -0600, Bjorn Helgaas wrote:
> > > On Wed, Nov 09, 2022 at 04:36:17AM +0000, Wei Gong wrote:
> > > > O Tue, Nov 08, 2022 at 01:02:35PM -0500, Michael S. Tsirkin wrote:
> > > > > On Tue, Nov 08, 2022 at 11:58:53AM -0600, Bjorn Helgaas wrote:
> > > > > > On Tue, Nov 08, 2022 at 10:19:07AM -0500, Michael S. Tsirkin wrote:
> > > > > > > On Tue, Nov 08, 2022 at 09:02:28AM -0600, Bjorn Helgaas wrote:
> > > > > > > > On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> > > > > > > > > On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > > > virtio uses the same driver for VFs and PFs.
> > > > > > > > > > Accordingly, pci_device_is_present is used to detect
> > > > > > > > > > device presence. This function isn't currently working
> > > > > > > > > > properly for VFs since it attempts reading device and
> > > > > > > > > > vendor ID.
> > > > > > > > > 
> > > > > > > > > > As VFs are present if and only if PF is present,
> > > > > > > > > > just return the value for that device.
> > > > > > > > > 
> > > > > > > > > VFs are only present when the PF is present *and* the PF
> > > > > > > > > has VF Enable set.  Do you care about the possibility that
> > > > > > > > > VF Enable has been cleared?
> > > > > > 
> > > > > > I think you missed this question.
> > > > > 
> > > > > I was hoping Wei will answer that, I don't have the hardware.
> > > > 
> > > > In my case I don't care that VF Enable has been cleared.
> > > 
> > > OK, let me rephrase that :)
> > > 
> > > I think pci_device_is_present(VF) should return "false" if the PF is
> > > present but VFs are disabled.
> > > 
> > > If you think it should return "true" when the PF is present and VFs
> > > are disabled, we should explain why.
> > > 
> > > We would also need to fix the commit log, because "VFs are present if
> > > and only if PF is present" is not actually true.  "VFs are present
> > > only if PF is present" is true, but "VFs are present if PF is present"
> > > is not.
> > 
> > Bjorn, I don't really understand the question.
> > 
> > How does one get a vf pointer without enabling sriov?
> > They are only created by sriov_add_vfs after calling
> > pcibios_sriov_enable.
> 
> Oh, I think I see where you're coming from.  The fact that we have a
> VF pointer means VFs were enabled in the past, and as long as the PF
> is still present, the VFs should still be enabled.
> 
> Since the continued existence of the VF device depends on VF Enable, I
> guess my question is whether we need to worry about VF Enable being
> cleared, e.g., via sysfs reset or a buggy PF driver.
> 
> Taking a step back, I don't understand the
> "if (!pci_device_is_present()) virtio_break_device()" strategy because
> checking for device presence is always unreliable.

The point is to break out of loops.


>  I assume the
> consumer of vq->broken, e.g., virtnet_send_command(), would see a
> failed PCI read that probably returns ~0 data.  Could it not check for
> that and then figure out whether that's valid data or an error
> indication?

No, it's not doing any reads - it is waiting for a DMA.

> It looks like today, virtnet_send_command() might sit in that "while"
> loop calling virtqueue_get_buf() repeatedly until virtio_pci_remove()
> notices the device is gone and marks it broken.  Something must be
> failing in virtqueue_get_buf() in that interval between the device
> disappearing and virtio_pci_remove() noticing it.
> 
> Bjorn

Nope - it is just doing posted writes, these disappear into thin ether
if there's no target.

-- 
MST

