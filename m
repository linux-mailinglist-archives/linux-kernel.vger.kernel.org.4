Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8DE748191
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjGEKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGEKAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:00:17 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98462E41
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:00:15 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QwwBf62Pcz9st7;
        Wed,  5 Jul 2023 12:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1688551210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQq2nzlBvqs3LR1ATp7LlQkGuwAdsoU/HQzWWBGdLIw=;
        b=bXVa/v8QQNAnFngBbvUcsMVuH+/SPoQAZfblpknVcvwO6MGo/8NvOLZUIKyxmIU6hd31dL
        h10otONCenoNL9X/8ZhxH5tbqT2jTxS7DuRQ3tfqJiiHcPuF6x1AsUqfr8p1kxqgJ+Csbk
        OCl56xkrYxHXbdV6KFuYrE8IP14+W8TTwMNAF85xYtDBW1R5Eg2bHp9F1LEi08wO3tMBVU
        5iatrMHZvgyRNfQrbnbQZsNzkbt0Fa7eNE3/C5IBGJyA2slAQVttxnF31KiF15Yb+U4Nh9
        nyFHA1xUmekdto9eR1l/5JaAOkdVsD0SRyNXbgKZOmNRkj0x/2N8bPKNpJtLAw==
Message-ID: <fdf51523-a955-e5d0-0ea4-4c614b6f45b2@mailbox.org>
Date:   Wed, 5 Jul 2023 12:00:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/6] drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic
 commits
Content-Language: de-CH-frami, en-CA
To:     Sebastian Wick <sebastian.wick@redhat.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Italo Nicola <italonicola@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, hwentlan@amd.com,
        christian.koenig@amd.com, joshua@froggi.es
References: <20230701020917.143394-1-andrealmeid@igalia.com>
 <20230701020917.143394-2-andrealmeid@igalia.com>
 <CA+hFU4y+kHitNsqb1WC6dHE5hr=1S6gJeyHXC5mv9Ads5mdgWw@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CA+hFU4y+kHitNsqb1WC6dHE5hr=1S6gJeyHXC5mv9Ads5mdgWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 42841dc9c0b77bbe99d
X-MBO-RS-META: x149rw5ddd5djf7m5nw57pee9poq3fos
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 19:06, Sebastian Wick wrote:
> On Sat, Jul 1, 2023 at 4:09 AM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> @@ -949,6 +949,15 @@ struct hdr_output_metadata {
>>   * Request that the page-flip is performed as soon as possible, ie. with no
>>   * delay due to waiting for vblank. This may cause tearing to be visible on
>>   * the screen.
>> + *
>> + * When used with atomic uAPI, the driver will return an error if the hardware
>> + * doesn't support performing an asynchronous page-flip for this update.
>> + * User-space should handle this, e.g. by falling back to a regular page-flip.
>> + *
>> + * Note, some hardware might need to perform one last synchronous page-flip
>> + * before being able to switch to asynchronous page-flips. As an exception,
>> + * the driver will return success even though that first page-flip is not
>> + * asynchronous.
> 
> What would happen if one commits another async KMS update before the
> first page flip? Does one receive EAGAIN, does it amend the previous
> commit?

Should be the former. DRM_MODE_PAGE_FLIP_ASYNC just means the flip may complete outside of vertical blank, it doesn't change anything else.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

