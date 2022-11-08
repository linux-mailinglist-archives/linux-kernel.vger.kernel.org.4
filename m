Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4907162178F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiKHO6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiKHO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:58:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5E93BE;
        Tue,  8 Nov 2022 06:58:22 -0800 (PST)
Received: from [192.168.2.123] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8307366028F8;
        Tue,  8 Nov 2022 14:58:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667919500;
        bh=2nhSUtwlfkDl6ZAggiriMabwXiSsWaNnaSXtFyROEeg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gsEbaLHrrYJ7cXSzv4ksiPtsO22D/AfUduXhxbcKmRmAmaYOa9BC6UJjfwAaDuY0n
         h22dUtissv/joiR2nzScYrZT/Sq/VzKXCEWVqA18HHqUjxa9/KWffAbb92AZ++EiM1
         0tx8VvExminzc8Tjt4wgMKRe7/BKL0LrRfB50xJktoxbJF5kp7URKe4isABwJ21wxx
         9P+tBBQ5k27nZe2oyTM7HIPElGTBNiA1LZ6o7cuzmh+MSzcR2jSZAJnLdQ+Pyloaej
         OHI3+4hFwYw7f9btESiKybn8eDF6oW3nP6e4ssPj9i7DhtuFkggiw8o4mhzQUXmh/0
         UYAhuViUUcN1w==
Message-ID: <8dc44cc4-b107-a384-02fa-2b5ec0d61c3b@collabora.com>
Date:   Tue, 8 Nov 2022 17:58:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Helen Koike <helen.koike@collabora.com>, mchehab@kernel.org,
        hans.verkuil@cisco.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        nicolas@ndufresne.ca, Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        tfiga@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-media@vger.kernel.org,
        "frkoenig@chromium.org" <frkoenig@chromium.org>
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com>
 <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
 <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <b58e2678-8d2a-a323-07e4-12cc01c8c3c2@collabora.com>
 <Y2jCHofGnLSaE5nk@pendragon.ideasonboard.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <Y2jCHofGnLSaE5nk@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 11:30, Laurent Pinchart wrote:
> On Mon, Nov 07, 2022 at 01:11:32AM +0300, Dmitry Osipenko wrote:
>> On 11/5/22 18:19, Hsia-Jun Li wrote:
>>> Hello Helen
>>>
>>> I didn't see any updates from V6 and V7-WIP in your repo. That is what I
>>> need to for our complex tile formats in our platform.
>>>
>>> Any future plane here?
>>>
>>> Besides I have some ideas on these patches.
>>
>> I was looking into updating this patchset few months ago and the biggest
>> blocker was the absence of immediate upstream user for this new UAPI.
>> What your platform is? Is the driver stack completely opensource?
> 
> libcamera could be a good place to test (part of) this API in userspace.
> We could really do with the data offset feature for instance.

Since we don't have a user for the new UAPI right now, perhaps we can
put the new UAPI behind the staging Kconfig until it will get a
real/production user.

On the other hand, I had unpleasant experience with having UAPI gated by
staging Kconfig for other kernel subsystem in a sense that it
permanently stays a staging UAPI because nobody has time for unstaging it.

I see a common demand in this new UAPI which only becomes stronger over
time. Won't hurt to refresh this patchset. I had a rebased version
locally, but likely it needs to be rebased again. Will try to allocate
time for this.

-- 
Best regards,
Dmitry

