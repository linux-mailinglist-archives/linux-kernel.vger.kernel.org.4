Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77A680CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbjA3MCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbjA3MCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:02:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1410C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:02:16 -0800 (PST)
Received: from [192.168.2.197] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E15296602E28;
        Mon, 30 Jan 2023 12:02:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675080134;
        bh=CHRlgWCrCpxZAOuChuXDaANCOZzcJofZwQqqPaAf7sQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R7G71otP2Pf4OrQ5BkXCg17Bng7TkOykH17FKAqo+NkrjEIywalYsM/SbF3vB6tvn
         Z218ErZnlZHHyHx2VH/ade50zdsB193IuY/ePdei+ptVgqrnIIsAhgNKREm2yY/x1d
         VISY3fpEYUn331iy1m9QAGJ2vI08C7rRBEA2dhIpyyQnCEWfMnxwv5KR+o+VtJ6Top
         Xd2G2TFtw4wPTsquTgh6D1foaT4PW1QBcACi27/KNTkyWogQ0Pt/+6/A20MM0i6Ssc
         XRvVnLFWLpApaJrZMyiYRm4C34SfWe1eDNEfhLApR9NxsCjmNogwkID0Z1gdI6g1JS
         kZ0ft4yyYvDMg==
Message-ID: <0081b2c3-56c9-3ed8-b419-5ce8a151999e@collabora.com>
Date:   Mon, 30 Jan 2023 15:02:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        David Airlie <airlied@gmail.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <e5e9e8dd-a5b6-cfd2-44d6-4d5aa768e56c@collabora.com>
 <20230127081339.yovxofpboc4gfdgo@sirius.home.kraxel.org>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230127081339.yovxofpboc4gfdgo@sirius.home.kraxel.org>
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

On 1/27/23 11:13, Gerd Hoffmann wrote:
> On Thu, Jan 26, 2023 at 01:55:09AM +0300, Dmitry Osipenko wrote:
>> Hello Thomas and Gerd,
>>
>> On 1/9/23 00:04, Dmitry Osipenko wrote:
>>> This series:
>>>
>>>   1. Makes minor fixes for drm_gem_lru and Panfrost
>>>   2. Brings refactoring for older code
>>>   3. Adds common drm-shmem memory shrinker
>>>   4. Enables shrinker for VirtIO-GPU driver
>>>   5. Switches Panfrost driver to the common shrinker
>>>
>>> Changelog:
>>>
>>> v10:- Rebased on a recent linux-next.
>>>
>>>     - Added Rob's ack to MSM "Prevent blocking within shrinker loop" patch.
>>>
>>>     - Added Steven's ack/r-b/t-b for the Panfrost patches.
>>>
>>>     - Fixed missing export of the new drm_gem_object_evict() function.
>>>
>>>     - Added fixes tags to the first two patches that are making minor fixes,
>>>       for consistency.
>>
>> Do you have comments on this version? Otherwise ack will be appreciated.
>> Thanks in advance!
> 
> Don't feel like signing off on the locking changes, I'm not that
> familiar with the drm locking rules.  So someone else looking at them
> would be good.  Otherwise the series and specifically the virtio changes
> look good to me.
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Thomas was looking at the the DRM core changes. I expect he'll ack them.

Thank you for reviewing the virtio patches!

-- 
Best regards,
Dmitry

