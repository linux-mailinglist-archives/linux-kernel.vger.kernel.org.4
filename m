Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A605F40B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJDKVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJDKVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:21:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518592CE14;
        Tue,  4 Oct 2022 03:21:39 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C775D660225F;
        Tue,  4 Oct 2022 11:21:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664878897;
        bh=kCRfJ9AaObCTjuMjz/60HoCPWoad2V9bCCyPAOpjvdw=;
        h=Date:Cc:To:From:Subject:From;
        b=MHjFcUDlBvTz76+UUO+VE8j0qQs95Z2vH5n9LKMosEviQfegqNYyh7iKn8LBzH8df
         w81mgNZzNP8KWWMjsZPy7CuntUVZSUdwBneEBwEGU+vjiD3+SCGmyFsqQEDy3aMAFK
         QKmt/4ym7sJrNZq0XP9PNZ2Q8Xr2NKwZq5gsDfxTY/d9K8Vs13c7TnlmVQrRJtapgX
         G0MKNEuUNTg4tCJa3qete5UujYXHAob7JotlR+UdBt6vHQ7fX3mwY2V3s27lPfSYI1
         FdDD+1X4DSQBqNrisJoTYUpfDYbVRC7NPRYU9zFeq3ffKbjwrJlX30TVfpy4u7sCTW
         YF7m2iSEhharg==
Message-ID: <6ffc4718-afb3-883e-418c-79376082ec7a@collabora.com>
Date:   Tue, 4 Oct 2022 15:21:30 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Cc:     usama.anjum@collabora.com, LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
Content-Language: en-US
To:     Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [Bug report] Possible wrong condition
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems there is some dead or not-needed code. Either the if condition
isn't needed or condition is wrong. As this
greater-than-or-equal-to-zero comparison of an unsigned value is always
true. "version_minor >= 0". Please have a look at it.

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 012b72d00e04..be9a6aad8541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -526,6 +526,8 @@ int amdgpu_gfx_rlc_init_microcode(struct
amdgpu_device *adev,
        if (version_major == 2 && version_minor == 1)
                adev->gfx.rlc.is_rlc_v2_1 = true;

+       // The following condition is always true as version_minor is
unsigned.
+       // Why is this condition needed at all?
        if (version_minor >= 0) {
                err = amdgpu_gfx_rlc_init_microcode_v2_0(adev);
                if (err) {

-- 
Muhammad Usama Anjum

