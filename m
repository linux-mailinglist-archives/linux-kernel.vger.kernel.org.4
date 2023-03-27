Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4526CAC0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjC0RoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjC0RoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:44:19 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE9B1998;
        Mon, 27 Mar 2023 10:44:17 -0700 (PDT)
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PlgDG04W2z9sbl;
        Mon, 27 Mar 2023 19:44:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1679939054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KjDX25+NKaaKoD5YHcl9oKe8i5e92yTlVSF3eB2pmAA=;
        b=ZsFEgOxGPbZl0s8MAKoWU+degbW2c4xvF8EOESTFviixw7X8DR8QXTTgWmFisYsVVLwC64
        ur/Uey+Cwgc1fGvUva6WYfWKWdXidhKqDqGaQ5BdYUalzvIae7ZMtCvQISAmqg3OFwaCbh
        Jp5NGLdwhSwRyDPawbO4AN6aJqYz3ngGi99VHMmpLX/DM9orcRR3JbWC4++yffb1uMJRwC
        S9Kkqs195WrUG6Gea276f3oU6Bh1KwZ17Aqeoi0+KtXX06fb15ul6VxSRWj7D07eL/zhhK
        gVlSgG1PL+D7/XBnR74IcP3Z8uI3IshAoQJp48uDgvInOhwib9SD6VWedmsdnw==
Message-ID: <1de9eccd-8570-3b69-4be2-347e862bcc33@mailbox.org>
Date:   Mon, 27 Mar 2023 17:44:07 +0000
MIME-Version: 1.0
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
From:   Tor Vic <torvic9@mailbox.org>
Subject: [Question] Restore previous "local tag" behaviour
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c6ada957306ea23e075
X-MBO-RS-META: 1atenzh7tnubjtdnugqjqbrmbwkbf6xu
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I'm building my kernels, I used to tag my personal releases with a 
similar annotated tag commit as with vanilla kernel, just appending 
"-tv" or similar to it, i.e. "v6.3-rc4" becomes "v6.3-rc4-tv".

This has worked just fine so far, but...

Since commit 6ab7e1f95e96f0c688ae132b0e9a16c0f206689d ("setlocalversion: 
use only the correct release tag for git-describe"), this is not taken 
into account anymore, it uses the "git describe" tag instead of using 
the actually tagged commit as "kernelrelease".

Is there a way to restore the previous behaviour without having to 
revert this (and preceding) commits?

I know that we can disable CONFIG_LOCALVERSION_AUTO=y and append 
directly to CONFIG_LOCALVERSION, but maybe someone knows how to use the 
"old" way of using tags...?

In other words, when I have a local tag, I want "kernelrelease" to use 
just that tag, and when I don't tag anything, it should just use the 
standard "git describe" tag.

For the moment I have just reverted the related commits as they don't 
serve any purpose for my needs.

Cheers,

Tor Vic
