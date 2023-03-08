Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1B6B1148
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCHSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCHSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:46:06 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E51B5FFE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:46:03 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id a65so6035278qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678301162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVBdIKHHQIlozrwDSyokrUQ99OB0FIBgwsdDZfTjYBo=;
        b=I8qlI/xYUNoVL2ftAUKd+1580i7lApVAWYltO3dBfTKIj5AL4raEE5/I21mP0kGYOq
         OeZerKsCcmcn6kHQibvsugK6oBoNZt5dHqhilF9lM+mqX5wLXuQJvHUzyUv+rnbs86rR
         WdGPXJ/iVfUbJYKUKUa7HhFCOyqSLpi02JPV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVBdIKHHQIlozrwDSyokrUQ99OB0FIBgwsdDZfTjYBo=;
        b=kc6M7lUQXP88ugL4zRuZ2veNoBOoUt71WljFtVrzSgOMCZDPcJ4NqrEAGx0tq5on8l
         uiX2j6J0bC64fciipQjm0FOv1bkByHTeV8WQgKVHzqgYfarDjhBRQPA2u75hyiPjoDFY
         85+aIhoL3X1brMlOOLSPElgQ1co23aKp39VUrExMcPMlzbTAX2VzlzdiexHIEdlySxG3
         Vz/VFofi9n2Y+6ta5I9VkhPMu7lnlv7iIIEya5WvRnhnZLy0nfM0QhwFnLSej4nZ1Brf
         1PfVxnZ/jWSShR/UKfoKLM0/apDYAlIO1W7O+WpO56fxRemZd1cMWtZHRmUSgaqQg9qt
         KiNg==
X-Gm-Message-State: AO0yUKVE5uN/xNFULUT06el2aTPXiINQix54KuH+NjDxUWTIp4RRnp2V
        NHzIBNvJK2ohJQkt/wTVdvrEKydOwpH6d0N1j7FXBg==
X-Google-Smtp-Source: AK7set8GVbBlnuwTdKD2XjecV0EwSum6wnpsdbB33xC/u495HhSJkpBJtTvBCc8Vg2MYdq/cIjusyP/wCmKBI3U2CQk=
X-Received: by 2002:a05:620a:1288:b0:71f:b88c:a646 with SMTP id
 w8-20020a05620a128800b0071fb88ca646mr5443068qki.13.1678301162032; Wed, 08 Mar
 2023 10:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20230307220553.631069-1-jaz@semihalf.com> <20230307164158.4b41e32f.alex.williamson@redhat.com>
 <CAH76GKNapD8uB0B2+m70ZScDaOM8TmPNAii9TGqRSsgN4013+Q@mail.gmail.com> <20230308104944.578d503c.alex.williamson@redhat.com>
In-Reply-To: <20230308104944.578d503c.alex.williamson@redhat.com>
From:   Dominik Behr <dbehr@chromium.org>
Date:   Wed, 8 Mar 2023 10:45:51 -0800
Message-ID: <CABUrSUD6hE=h3-Ho7L_J=OYeRUw_Bmg9o4fuw591iw9QyBQv9A@mail.gmail.com>
Subject: Re: [PATCH] vfio/pci: Propagate ACPI notifications to the user-space
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
        dmy@semihalf.com, tn@semihalf.com, upstream@semihalf.com,
        dtor@google.com, jgg@ziepe.ca, kevin.tian@intel.com,
        cohuck@redhat.com, abhsahu@nvidia.com, yishaih@nvidia.com,
        yi.l.liu@intel.com, kvm@vger.kernel.org,
        Dominik Behr <dbehr@chromium.org>, libvir-list@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 9:49=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:

> Adding libvirt folks.  This intentionally designs the interface in a
> way that requires a privileged intermediary to monitor netlink on the
> host, associate messages to VMs based on an attached device, and
> re-inject the event to the VMM.  Why wouldn't we use a channel
> associated with the device for such events, such that the VMM has
> direct access?  The netlink path seems like it has more moving pieces,
> possibly scalability issues, and maybe security issues?

It is the same interface as other ACPI events like AC adapter LID etc
are forwarded to user-space.
 ACPI events are not particularly high frequency like interrupts.

> > > What sort of ACPI events are we expecting to see here and what does u=
ser space do with them?
The use we are looking at right now are D-notifier events about the
GPU power available to mobile discrete GPUs.
The firmware notifies the GPU driver and resource daemon to
dynamically adjust the amount of power that can be used by the GPU.

> The proposed interface really has no introspection, how does the VMM
> know which devices need ACPI tables added "upfront"?  How do these
> events factor into hotplug device support, where we may not be able to
> dynamically inject ACPI code into the VM?

The VMM can examine PCI IDs and the associated firmware node of the
PCI device to figure out what events to expect and what ACPI table to
generate to support it but that should not be necessary.
A generic GPE based ACPI event forwarder as Grzegorz proposed can be
injected at VM init time and handle any notification that comes later,
even from hotplug devices.

> The acpi_bus_generate_netlink_event() below really only seems to form a
> u8 event type from the u32 event.  Is this something that could be
> provided directly from the vfio device uAPI with an ioeventfd, thus
> providing introspection that a device supports ACPI event notifications
> and the ability for the VMM to exclusively monitor those events, and
> only those events for the device, without additional privileges?

From what I can see these events are 8 bit as they come from ACPI.
They also do not carry any payload and it is up to the receiving
driver to query any additional context/state from the device.
This will work the same in the VM where driver can query the same
information from the passed through PCI device.
There are multiple other netflink based ACPI events forwarders which
do exactly the same thing for other devices like AC adapter, lid/power
button, ACPI thermal notifications, etc.
They all use the same mechanism and can be received by user-space
programs whether VMMs or others.
