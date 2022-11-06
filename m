Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F6A61E6D1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 23:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKFWLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 17:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKFWLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 17:11:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA9DDF8D;
        Sun,  6 Nov 2022 14:11:39 -0800 (PST)
Received: from [192.168.2.238] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32BBF6602261;
        Sun,  6 Nov 2022 22:11:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667772697;
        bh=uj2dLo8EulDe9eQh23LWWOKmwfSsFi4WmR5legeb4QU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QgSUe6x0xNv1vzxK6hnDqpCJMMOd9suyAd7SQfgQRIE6aADyx2/C9cA65f+deB6i8
         U4qVRT3V3Q8sH6EdZroifIOmd3T3JtYEv6O7PSsHQbQ9CEkRZy6i9QFySS0z941TqG
         IcOnn4InF4j2M7L3MyR3KfR1KW6EoLijIckDseInKIOSjVN5wEP97XPDrdGriTXJQU
         7M783fLfVUCPjyoSM4w6JuI3PAEHBfuZP/cF6T2UzcRRMCAtefi8trCm1v3XX699l+
         fd4YMRMqBiNm3OZUEGCE9hxm9MC7C9K07OSK7zYzmbOyoYPOqsjqotk6YhQzqWnJtP
         PQOSjTcQTlIKA==
Message-ID: <b58e2678-8d2a-a323-07e4-12cc01c8c3c2@collabora.com>
Date:   Mon, 7 Nov 2022 01:11:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
To:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Helen Koike <helen.koike@collabora.com>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        nicolas@ndufresne.ca, Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        tfiga@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-media@vger.kernel.org
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com>
 <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
 <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
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

On 11/5/22 18:19, Hsia-Jun Li wrote:
> Hello Helen
> 
> I didn't see any updates from V6 and V7-WIP in your repo. That is what I
> need to for our complex tile formats in our platform.
> 
> Any future plane here?
> 
> Besides I have some ideas on these patches.

I was looking into updating this patchset few months ago and the biggest
blocker was the absence of immediate upstream user for this new UAPI.
What your platform is? Is the driver stack completely opensource?

-- 
Best regards,
Dmitry

