Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB86A57FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjB1LZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjB1LYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:24:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F192CFC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:46 -0800 (PST)
Received: from [192.168.2.206] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B91E6602FDB;
        Tue, 28 Feb 2023 11:23:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677583420;
        bh=E6qt90GxOfucMcC6bgFlkh6pyweclyl9Mhp2XoIESkc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YDjzY7PLJkIFAF01dNDVw8heJ+9gQNPuvtd1JND0dcYRRzev52TSdtMBmSjgnSITw
         sp/8nV9TKGiIDVvVSAZbZAZWr0AO2dsN6whyLFH3s2YvxRxcSZh70rKnfXX/HK565/
         fIq3gJPzie4UGVNTXZnNkawobX78EWBgIzLT6cJYJD22q/inVAqXi2DkqE48Askn38
         i1W7Zauiyp+l+NWiuZfd2vYH+sPzeBytqTk6+1kx8r7tVisAazq2A/MCMgxTnuNm0E
         lq1JEYRnMMLljU2Uy4T0GvJNMxcLNOFKR4iLsWR+EeiY8Z8RQ6HRemD1l0N4rHuc0p
         SbKdBvJz49nhA==
Message-ID: <33f03f9e-4af3-3237-00dc-d79570d9022a@collabora.com>
Date:   Tue, 28 Feb 2023 14:23:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Ryan Neph <ryanneph@chromium.org>,
        David Airlie <airlied@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20230224180225.2477641-1-robdclark@gmail.com>
 <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
 <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
 <20230228062809.ccyzgnvizh6jidn4@sirius.home.kraxel.org>
 <87a60yywo0.fsf@minerva.mail-host-address-is-not-set>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87a60yywo0.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 12:19, Javier Martinez Canillas wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> Hello Gerd,
> 
>> On Mon, Feb 27, 2023 at 07:40:11AM -0800, Rob Clark wrote:
>>> On Sun, Feb 26, 2023 at 10:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>> On Fri, Feb 24, 2023 at 10:02:24AM -0800, Rob Clark wrote:
>>>>> From: Rob Clark <robdclark@chromium.org>
>>>>>
>>>>> Add a build option to disable modesetting support.  This is useful in
>>>>> cases where the guest only needs to use the GPU in a headless mode, or
>>>>> (such as in the CrOS usage) window surfaces are proxied to a host
>>>>> compositor.
>>>> Why make that a compile time option?  There is a config option for the
>>>> number of scanouts (aka virtual displays) a device has.  Just set that
>>>> to zero (and fix the driver to not consider that configuration an
>>>> error).
>>> The goal is to not advertise DRIVER_MODESET (and DRIVER_ATOMIC).. I
>>> guess that could be done based on whether there are any scanouts, but
>>> it would mean making the drm_driver struct non-const.
>> Apparently there is a drm_device->driver_features override,
>> (amdgpu uses that).  The driver could simply drop the DRIVER_MODESET and
>> DRIVER_ATOMIC bits in case no scanout is present instead of throwing an
>> error.
>>
>>> And I think it is legitimate to allow the guest to make this choice,
>>> regardless of what the host decides to expose, since it is about the
>>> ioctl surface area that the guest kernel exposes to guest userspace.
>> I think it is a bad idea to make that a compile time option, I'd suggest
>> a runtime switch instead, for example a module parameter to ask the
>> driver to ignore any scanouts.
>>
> I don't think there's a need for a new module parameter, there's already
> the virtio-gpu 'modeset' module parameter to enable/disable modsetting
> and the global 'nomodeset' kernel cmdline parameter to do it for all DRM
> drivers.
> 
> Currently, many drivers just fail to probe when 'nomodeset' is present,
> but others only disable modsetting but keep the rendering part. In fact,
> most DRM only drivers just ignore the 'nomodeset' parameter.

IIUC, Rob's main point for having a config option is solely for security
reasons. The config option eliminates possibility of accidentally (or
intentionally) enabling KMS from software, which is better to have in
case of shipping a product (Chromebook) on which multiple teams are
working on.

-- 
Best regards,
Dmitry

