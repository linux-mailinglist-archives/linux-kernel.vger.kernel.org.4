Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EFB6B2CDA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCISZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCISZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:25:22 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779CBF63A7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:25:16 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r16so2997089qtx.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 10:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1678386315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCIYarRByQoUrBuBZ+peDsEg9BoCl4xGT1U1QymR6yQ=;
        b=fIGepsB3+3dl0A+jOXVDI5l3Okn4Z4D2jFHGH8CXebRjUpm1zcoCr3j7q7hPp3it8n
         ytXfnvVePPXqAIWbx9RPor96ZlnjcITTBF0McVJYh53yx1bHE1JJOtEdSDXQo6rb31j2
         KtJg7xQSBxwQsBdCAcKQOOBwcaZx17bVdTH6TXito33E3Fh1g7L4fprWW7pIpF4AMzH4
         tQ4oOZHDa1a5Ju848vWqqBNd2JrJ6pEWca6B6MsnLqnPmdellKAceWlZcEvrAgih2yEd
         OLL6sVgZRRCUjhH5nhDEt52/GBDtG38PW91EkpokXXbBfUC+4WKpwlFAPCm6d4/3bW4N
         +SUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678386315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCIYarRByQoUrBuBZ+peDsEg9BoCl4xGT1U1QymR6yQ=;
        b=3ZKUhlx5bqcJuNZ481jXsZibfmEbdZHR8IOhRrQKdY5WGsDexXfPrJ7kV95OV1G26F
         xIEzgfk+TEVfMZAkDTQYBgHvUVNQcr6WHVBuTtkAAAcD52WFB97jSk1F3trHf26xxiWc
         7/dQDeeDnyus2bXo2xkOO+HGZA7b84Kx7LqFlISpYtpNkhzXGyqAPMu07KDE1nmZEM56
         2OwU9KJpENnlO7d5enET7k55VxCkYJV599uVxmKIm7YHGZsCwNPCLb9TpBuYbVm3dzkp
         BODPfOw/ZozpSUYjXA+USqklmC2u5qnXFC3gqj/Rl7ZzjY5QB2CNzuUHy1BYg/CIb/vX
         4IqA==
X-Gm-Message-State: AO0yUKVppSBfyjPyPl3ivPQzpGYAsGzBBFZ0NUp3AX92JiR65yZIHIGV
        5+mE3GPf8cpsDoUjh//tIDAcvQ==
X-Google-Smtp-Source: AK7set+HWAzUffR9jmS31HAqYiOrRWFVvC3r4b1eOQRbH1o/N8h/MJYBt/XY9a3aO27urwlmaSf+ng==
X-Received: by 2002:ac8:5755:0:b0:3bd:19b1:ccc with SMTP id 21-20020ac85755000000b003bd19b10cccmr6962668qtx.33.1678386315584;
        Thu, 09 Mar 2023 10:25:15 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b142-20020ae9eb94000000b007423dad060bsm13963951qkg.87.2023.03.09.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:25:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1paKwz-00F8Jw-Lx;
        Thu, 09 Mar 2023 14:25:13 -0400
Date:   Thu, 9 Mar 2023 14:25:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dominik Behr <dbehr@chromium.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        linux-kernel@vger.kernel.org, dmy@semihalf.com, tn@semihalf.com,
        upstream@semihalf.com, dtor@google.com, kevin.tian@intel.com,
        cohuck@redhat.com, abhsahu@nvidia.com, yishaih@nvidia.com,
        yi.l.liu@intel.com, kvm@vger.kernel.org, libvir-list@redhat.com
Subject: Re: [PATCH] vfio/pci: Propagate ACPI notifications to the user-space
Message-ID: <ZAokiR4EC3gFAuJ1@ziepe.ca>
References: <20230307220553.631069-1-jaz@semihalf.com>
 <20230307164158.4b41e32f.alex.williamson@redhat.com>
 <CAH76GKNapD8uB0B2+m70ZScDaOM8TmPNAii9TGqRSsgN4013+Q@mail.gmail.com>
 <20230308104944.578d503c.alex.williamson@redhat.com>
 <CABUrSUD6hE=h3-Ho7L_J=OYeRUw_Bmg9o4fuw591iw9QyBQv9A@mail.gmail.com>
 <20230308130619.3736cf18.alex.williamson@redhat.com>
 <CABUrSUBBbXRVRo6b1EKBpgu7zk=8yZhQ__UXFGL_GpO+BA4Pkg@mail.gmail.com>
 <20230308163803.6bfc2922.alex.williamson@redhat.com>
 <CABUrSUAbJJJfGYQuXe-k+partE8UebEvK47zuGXEAtdAjg-yPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABUrSUAbJJJfGYQuXe-k+partE8UebEvK47zuGXEAtdAjg-yPA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 05:51:32PM -0800, Dominik Behr wrote:
> All other ACPI events that are available to userspace are on netlink already.
> As for translation of ACPI paths. It is sort of a requirement for VMM
> to translate the PCI path from host to guest because the PCI device
> tree in the guest is totally different already. The same follows for
> ACPI paths.
> 
> What would you propose instead of netlink?
> Sysfs entry for VFIO PCI device that accepts eventfd and signals the
> events via eventfd? Or moving it into ACPI layer entirely and adding
> eventfd sysfs interface for all ACPI devices?

I think Alex is asking why wouldn't you push it through the vfio
device FD? There is an unambiguous relationship between the QEMU vPCI
identity and the VFIO device, and we already have a good security
model for VMM access to the device FD.

Jason
