Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607CC6420DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiLEAws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLEAwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:52:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5141A1147D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 16:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670201507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jyOn0zCqUHzr00gkE+WrihCChip5DaN83C5WKz94T9o=;
        b=A+dBBL1B/EHpZlQ3rMH8QniN2FOrTCh5qvvAN6Qpr5u0hNOI4WuLxNPEAfjqhDkuW0+bm4
        Z8B8amgvh45/4hjsCHcdv/c6jkb+2Ij/OdG//I5l0oq48oJn1cfLH6fVta+tMqhpOMKTh1
        9L8iAqwhr/+Baoo6MNRfyILIta8xuQI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-32-cIDA3Di8P-eEUcHpaE2Ybg-1; Sun, 04 Dec 2022 19:51:46 -0500
X-MC-Unique: cIDA3Di8P-eEUcHpaE2Ybg-1
Received: by mail-il1-f197.google.com with SMTP id h10-20020a056e021b8a00b00302671bb5fdso11059061ili.21
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 16:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyOn0zCqUHzr00gkE+WrihCChip5DaN83C5WKz94T9o=;
        b=Msa7nQgbbvVkP2l4bCCJ3K/X9WqDwo7LxsdwU2kLa4NWaUUrKmloz94DhicB6o9oG9
         8qRayyDfJow8zWO5e/+baYVgifPAgyMoNv0o9CNpYzVsoyu/VyJOFQFOOEOE8GZp7uQh
         KjW6aOzX5/ByMegGfrnqAauu1C4vxkyKc0+lMy6bsog57+5y3vAIhWDSCbnoSDhjo9LM
         Rlz7fW+jNEPnI0LLe30d+ndJqWKdqH6+OaAi88G22CCWd3kpv5SAtJy9q5tqdflgaiMK
         qbShudEXFWun8xFGW4FLc6Ze3BAQ2nmY0RZiklOLxVeX03hANzLU76fA/wAM/avEqBkL
         vhww==
X-Gm-Message-State: ANoB5plO+ZGM5F+uX2LwO0UQ6renSm42vAEUbo8LFosJr8Mj5JwLVOjT
        hzzKLshHzQhfXYM3ONhi8dV183BzD9WKXQiahCx+wGiOPTpPBFN4lLn8oP7t5+FXt++iXts0j9B
        4MDH7wPFyyDJZKaX7j68S//8k
X-Received: by 2002:a05:6602:2143:b0:6bc:6352:9853 with SMTP id y3-20020a056602214300b006bc63529853mr35427223ioy.65.1670201505084;
        Sun, 04 Dec 2022 16:51:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6qBOm8mQO/x/Lw1rl0Iy6Xk4eFLp0sKfVqFatl9b10bhQP9TrpcKRN/3msQCFGy6Z8h84OCA==
X-Received: by 2002:a05:6602:2143:b0:6bc:6352:9853 with SMTP id y3-20020a056602214300b006bc63529853mr35427215ioy.65.1670201504802;
        Sun, 04 Dec 2022 16:51:44 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h20-20020a056e020d5400b0030287ff00fesm4715510ilj.60.2022.12.04.16.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 16:51:44 -0800 (PST)
Date:   Sun, 4 Dec 2022 17:51:42 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "mb@lab.how" <mb@lab.how>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        kraxel@redhat.com, kvm@vger.kernel.org, lersek@redhat.com,
        linux-kernel@vger.kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH 2/2] vfio/pci: Remove console drivers
Message-ID: <20221204175142.658d5c37.alex.williamson@redhat.com>
In-Reply-To: <CAEdEoBYXHq9cCzsbMYTpG1B41Yz=-QAjFx7bJDOnPanN5Tmo7A@mail.gmail.com>
References: <CAEdEoBYXHq9cCzsbMYTpG1B41Yz=-QAjFx7bJDOnPanN5Tmo7A@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2022 17:12:38 -0700
"mb@lab.how" <mb@lab.how> wrote:

> Hi,
> 
> I hope it is ok to reply to this old thread.

It is, but the only relic of the thread is the subject.  For reference,
the latest version of this posted is here:

https://lore.kernel.org/all/20220622140134.12763-4-tzimmermann@suse.de/

Which is committed as:

d17378062079 ("vfio/pci: Remove console drivers")

> Unfortunately, I found a
> problem only now after upgrading to 6.0.
> 
> My setup has multiple GPUs (2), and I depend on EFIFB to have a working console.
> pre-patch behavior, when I bind the vfio-pci to my secondary GPU both
> the passthrough and the EFIFB keep working fine.
> post-patch behavior, when I bind the vfio-pci to the secondary GPU,
> the EFIFB disappears from the system, binding the console to the
> "dummy console".
> Whenever you try to access the terminal, you have the screen stuck in
> whatever was the last buffer content, which gives the impression of
> "freezing," but I can still type.
> Everything else works, including the passthrough.

This sounds like the call to aperture_remove_conflicting_pci_devices()
is removing the conflicting driver itself rather than removing the
device from the driver.  Is it not possible to unbind the GPU from
efifb before binding the GPU to vfio-pci to effectively nullify the
added call?
 
> I can only think about a few options:
> 
> - Is there a way to have EFIFB show up again? After all it looks like
> the kernel has just abandoned it, but the buffer is still there. I
> can't find a single message about the secondary card and EFIFB in
> dmesg, but there's a message for the primary card and EFIFB.
> - Can we have a boolean controlling the behavior of vfio-pci
> altogether or at least controlling the behavior of vfio-pci for that
> specific ID? I know there's already some option for vfio-pci and VGA
> cards, would it be appropriate to attach this behavior to that option?

I suppose we could have an opt-out module option on vfio-pci to skip
the above call, but clearly it would be better if things worked by
default.  We cannot make full use of GPUs with vfio-pci if they're
still in use by host console drivers.  The intention was certainly to
unbind the device from any low level drivers rather than disable use of
a console driver entirely.  DRM/GPU folks, is that possibly an
interface we could implement?  Thanks,

Alex

