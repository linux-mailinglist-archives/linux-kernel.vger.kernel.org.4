Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B257F60CA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJYKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiJYKgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:36:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB48E11A1D;
        Tue, 25 Oct 2022 03:36:08 -0700 (PDT)
Received: from [192.168.2.138] (109-252-112-196.nat.spd-mgts.ru [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 944CD660239C;
        Tue, 25 Oct 2022 11:36:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666694167;
        bh=asjeGT77iVFKNvBoOyaKFQC3C+LKDkA03+0QH0yhYDw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A8oFHe5QT2rpBTeO3g1xKqFH3MqBiHEtVQD5XLYnX48k1/Sr3bW68/RwvUWNzDNoh
         yYlaTiq7uOg8ZYqcMeccNE3cd83c9xPHY6hKH3KMe/UmPLemJK4MWAdEUe6lcEHCiu
         6YBPdxMWAc7ocs5/fwGX5WPTHlDjKsmRY9jo9DcmKS95HkrJPa0S0LK5hTwtm+r196
         RsVqTCzH7GJ/EitJN+T5xzYw7P1udtStBztJYhLwiDKXIayVDsGs3fYDWr0S41sgKw
         QXwFxzoZ78wYuFf0LWj/WX1Lx/VnF43H14BTfmcgLv+JBkGjbrZVHuGYzGAPtfnYFZ
         FcYujIB725WIQ==
Message-ID: <fcf78a88-ab27-3a6a-db06-66504fc18e10@collabora.com>
Date:   Tue, 25 Oct 2022 13:36:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1] media: cedrus: Propagate error code from
 cedrus_h265_skip_bits()
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220914150105.209484-1-dmitry.osipenko@collabora.com>
 <d75c0597-2323-27f2-a7e2-b319667bdcf6@xs4all.nl>
 <12078224.O9o76ZdvQC@jernej-laptop>
 <3a26e105-9c50-8cdd-b4be-ba97b3306261@collabora.com>
 <1103d833-6c29-6ccb-05dd-a2883eaa2281@xs4all.nl>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1103d833-6c29-6ccb-05dd-a2883eaa2281@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 13:23, Hans Verkuil wrote:
> On 10/25/22 11:34, Dmitry Osipenko wrote:
>> On 10/25/22 07:59, Jernej Škrabec wrote:
>>> Dne ponedeljek, 24. oktober 2022 ob 13:38:36 CEST je Hans Verkuil napisal(a):
>>>> Hi Dmitry,
>>>>
>>>> This patch has a conflict with this patch from Jernej:
>>>>
>>>> https://patchwork.linuxtv.org/project/linux-media/patch/20221017194413.11983
>>>> 01-1-jernej.skrabec@gmail.com/
>>>>
>>>> I decided to take Jernej's patch first. Can you make a v2 that sits on top
>>>> of that patch?
>>> I believe you already merged first version of the patch for 6.1. No need for 
>>> this version though, first version already solves main issue.
>>
>> That was a followup to the first version.
>>
> 
> I have no idea what you are both talking about :-)
> 
> "I believe you already merged first version of the patch for 6.1" Which patch
> are you referring to?

This is about [1] that was already merged. This patch implements the
error propagation that Jernej asked [2] when he reviewed [1].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=91db7a3fc7fe670cf1770a398a43bb4a1f776bf1

[2] https://lore.kernel.org/lkml/1733932.VLH7GnMWUR@kista/

I'll prepare the v2 if this change is still desired by Jernej.

-- 
Best regards,
Dmitry

