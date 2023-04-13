Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E56E0B93
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDMKlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDMKkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:40:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1AE8A51
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:40:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q6so2282673wrc.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681382445; x=1683974445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt8QYWYgXcWDb0H4PzSCSB86AxQEfmL5GXKTxvwufWc=;
        b=vgr124BoHwdFxO+8XR7kdg8rVvjTn0NVgvqh2IRic5l3kYQUOHhoQTaVNENat3MtFT
         m04F+OZzwB9jdXFcnIsy4aWQ3aKr0ztkHTOY6lQZ0EIMXvg5dVLnUFVklSWIiXyUg4so
         TPyVIYoQ1qePdYzwdUatim3ab6+GMl+0NJj8xfSvKLwJQnSK51k2RUJ7jcnHU8E/hRB/
         BKNyh1LoGZg8FGwx9Hl1BU7tjqrmd6G8BpbRurNdgS7Iv9KFU3t9Z9C/31kJSRwapfUb
         Cgvxo+ND0LV1gCZDa3V6SUHKfqXrfdHaqn3DoKaK9742YoxMJDoe4T2PQI3CKdzzH6ru
         7PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382445; x=1683974445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt8QYWYgXcWDb0H4PzSCSB86AxQEfmL5GXKTxvwufWc=;
        b=BQFYi0umPpm50lqmQrDm/fABE8axhQBWRSig6+7j5VDboSzu1E/9CNKamjKfi27dRP
         uemuixnlWGpfPmCm5ovg5PjxhS1t849QmoXK5BGSaAfVcwVuAKNrcx+S1vemFtUkgI+U
         yX8gQbacyEIxXYHKz+W/x0f1Qm8vXo9zdvppNjQ7z6ZmS4xFn3hpgwdtcA0/rWNfu4r0
         E4mGHum39tQUAUWbsfS8qN5DXGk3/i+rjZ4OkZO+9Ep+zQioENqrVUFmNNQkAuIreoZB
         Ur2JGv7QQnZZ2vrwE3XuMJt3sUSSRXQD9eAcre7sNXdHkOXcELp+yXdCNd1kmrwOSdjn
         yptg==
X-Gm-Message-State: AAQBX9cuT95hVKiEqMNQzmpyxT1HA1Vb5HawfU/iLH7Z9reH02XsbLiQ
        hjY2uyLmjvtFPKZ437X25nsFYg==
X-Google-Smtp-Source: AKy350ZKTDVRuGJL5YYI5HJoiDXvklp7EVihRfgojTs66okpvLm6QBr1zfRfZkA+Oait71i9Hok2BQ==
X-Received: by 2002:adf:e352:0:b0:2ef:b1bd:786 with SMTP id n18-20020adfe352000000b002efb1bd0786mr1002307wrj.13.1681382444786;
        Thu, 13 Apr 2023 03:40:44 -0700 (PDT)
Received: from myrica ([5.69.146.176])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4d01000000b002e5f6f8fc4fsm990119wrt.100.2023.04.13.03.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:40:44 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:40:41 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Eric Auger <eric.auger@redhat.com>,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: virtio-iommu hotplug issue
Message-ID: <20230413104041.GA3295191@myrica>
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 13, 2023 at 01:49:43PM +0900, Akihiko Odaki wrote:
> Hi,
> 
> Recently I encountered a problem with the combination of Linux's
> virtio-iommu driver and QEMU when a SR-IOV virtual function gets disabled.
> I'd like to ask you what kind of solution is appropriate here and implement
> the solution if possible.
> 
> A PCIe device implementing the SR-IOV specification exports a virtual
> function, and the guest can enable or disable it at runtime by writing to a
> configuration register. This effectively looks like a PCI device is
> hotplugged for the guest.

Just so I understand this better: the guest gets a whole PCIe device PF
that implements SR-IOV, and so the guest can dynamically create VFs?  Out
of curiosity, is that a hardware device assigned to the guest with VFIO,
or a device emulated by QEMU?

> In such a case, the kernel assumes the endpoint is
> detached from the virtio-iommu domain, but QEMU actually does not detach it.
> 
> This inconsistent view of the removed device sometimes prevents the VM from
> correctly performing the following procedure, for example:
> 1. Enable a VF.
> 2. Disable the VF.
> 3. Open a vfio container.
> 4. Open the group which the PF belongs to.
> 5. Add the group to the vfio container.
> 6. Map some memory region.
> 7. Close the group.
> 8. Close the vfio container.
> 9. Repeat 3-8
> 
> When the VF gets disabled, the kernel assumes the endpoint is detached from
> the IOMMU domain, but QEMU actually doesn't detach it. Later, the domain
> will be reused in step 3-8.
> 
> In step 7, the PF will be detached, and the kernel thinks there is no
> endpoint attached and the mapping the domain holds is cleared, but the VF
> endpoint is still attached and the mapping is kept intact.
> 
> In step 9, the same domain will be reused again, and the kernel requests to
> create a new mapping, but it will conflict with the existing mapping and
> result in -EINVAL.
> 
> This problem can be fixed by either of:
> - requesting the detachment of the endpoint from the guest when the PCI
> device is unplugged (the VF is disabled)

Yes, I think this is an issue in the virtio-iommu driver, which should be
sending a DETACH request when the VF is disabled, likely from
viommu_release_device(). I'll work on a fix unless you would like to do it

> - detecting that the PCI device is gone and automatically detach it on
> QEMU-side.
> 
> It is not completely clear for me which solution is more appropriate as the
> virtio-iommu specification is written in a way independent of the endpoint
> mechanism and does not say what should be done when a PCI device is
> unplugged.

Yes, I'm not sure it's in scope for the specification, it's more about
software guidance

Thanks,
Jean
