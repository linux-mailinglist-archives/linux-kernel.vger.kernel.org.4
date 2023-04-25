Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F276EE057
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjDYK3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjDYK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:29:00 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F8F12CA7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:28:28 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Q5J966X28z9sjC;
        Tue, 25 Apr 2023 12:27:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1682418458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzoOwKMdJiLKK3BSiCIwb6001/mIm7hyJsaLnt4CuOY=;
        b=gcckeR9ypTnpx8tyY5QCL0wq+wig31N845d0UcpgHbiaBysK4rFUe7QTKjgoOtzw1yVQ9q
        olCCPx4pt5kj2OjdDr++5kP2lbKTA+FYGmlnG2iKIMxCqG35wvvyZpq5phrD6Cxl4yocRY
        LmCfwgcbto4PAo+Y+Le1GYzh8f/3BiYcoljJjTFHOIw/d5tZ6vpsMPwwSdi1gEJa/Ib3On
        CPHZY0jOb8D5GDUaneWnMb1ZBU8kDWZ6mMsjAEKHYV6EmaCNAdtDJ4qXGIo0GkrKn0qiiW
        mdhcfwqZbywi1z+Q6+4ZrmVSsXBerBKQ4d6jj+FwVX+LmTuyvY/gfLCH8tpCbw==
Message-ID: <784561bb-0937-befc-3774-892d6f6a4318@mailbox.org>
Date:   Tue, 25 Apr 2023 12:27:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: Mark contexts guilty for any reset type
Content-Language: de-CH-frami, en-CA
To:     =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-dev@igalia.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>
References: <20230424014324.218531-1-andrealmeid@igalia.com>
 <d7264c5a-29b4-0fb3-153b-673a8a73d635@amd.com>
 <CAAxE2A6Soq28ACV-m1OzG8CA-_VWp+N2wapsABzm2Nda=Qe+yA@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CAAxE2A6Soq28ACV-m1OzG8CA-_VWp+N2wapsABzm2Nda=Qe+yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e4acb3074d567e8fc3c
X-MBO-RS-META: qakb7pkk8zexswyiqwxbcthy4cfcgjgp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 18:45, Marek Olšák wrote:
> Soft resets are fatal just as hard resets, but no reset is "always fatal". There are cases when apps keep working depending on which features are being used. It's still unsafe.

Agreed, in theory.

In practice, from a user PoV, right now there's pretty much 0 chance of the user session surviving if the GPU context in certain critical processes (e.g. the Wayland compositor or Xwayland) hits a fatal reset. There's a > 0 chance of it surviving after a soft reset. There's ongoing work towards making user-space components more robust against fatal resets, but it's taking time. Meanwhile, I suspect most users would take the > 0 chance.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

