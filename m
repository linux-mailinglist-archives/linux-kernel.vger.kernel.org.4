Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3740760C831
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiJYJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiJYJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:35:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85141C433;
        Tue, 25 Oct 2022 02:35:01 -0700 (PDT)
Received: from [192.168.2.138] (109-252-112-196.nat.spd-mgts.ru [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 44DBF6602382;
        Tue, 25 Oct 2022 10:34:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666690500;
        bh=9H3ap7nNN5/shD4ZmOj4Q3xLd0xKoSmpDa5xm6abCu8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LAxz63o+kM6uHymx+0Y1C43OyctUWaw03IWbvz29YC+ftXh+4jQOqIoFB/EJiPKZQ
         Xtiwb0z5cTW45tSf9K0xA5aM4VfuC7bYaE35oHbaXcpqH5lqCBVGmmCB+sUfgVt9uF
         bjg/yrgYjwTpQ7qNOEPuLOZ6XAfHxQxS9Pt2hRNLuNDaX2UrCuCsyoiB6h/Y+4iCbu
         S5uKbUhPFD6YC6Vo3KwFiV0TzEyMHvPlKVLh1LTwWjILhYPruHkTW4hYuyxzsHsQWg
         K3A6QfqjLpzExS2V7oDPBYp5i4ce+I2sGdE5x+Dt0zE+06PEStIvniz2aCufOEOxZd
         xV2MXM2C60w/g==
Message-ID: <3a26e105-9c50-8cdd-b4be-ba97b3306261@collabora.com>
Date:   Tue, 25 Oct 2022 12:34:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1] media: cedrus: Propagate error code from
 cedrus_h265_skip_bits()
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220914150105.209484-1-dmitry.osipenko@collabora.com>
 <d75c0597-2323-27f2-a7e2-b319667bdcf6@xs4all.nl>
 <12078224.O9o76ZdvQC@jernej-laptop>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <12078224.O9o76ZdvQC@jernej-laptop>
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

On 10/25/22 07:59, Jernej Škrabec wrote:
> Dne ponedeljek, 24. oktober 2022 ob 13:38:36 CEST je Hans Verkuil napisal(a):
>> Hi Dmitry,
>>
>> This patch has a conflict with this patch from Jernej:
>>
>> https://patchwork.linuxtv.org/project/linux-media/patch/20221017194413.11983
>> 01-1-jernej.skrabec@gmail.com/
>>
>> I decided to take Jernej's patch first. Can you make a v2 that sits on top
>> of that patch?
> I believe you already merged first version of the patch for 6.1. No need for 
> this version though, first version already solves main issue.

That was a followup to the first version.

-- 
Best regards,
Dmitry

