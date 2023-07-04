Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8180746952
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGDGFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGDGFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF29BE70;
        Mon,  3 Jul 2023 23:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D6AC6113D;
        Tue,  4 Jul 2023 06:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D83C433C7;
        Tue,  4 Jul 2023 06:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688450728;
        bh=MObqXSJhC9pFJuxzQ3CMP1Qblbm3eFB3otVRR5NOrG8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tQFzJZu+utt8GGzFRxpDRZQdNDK4y2KdMslT/LKMVdJqFfTcy2r7V3h56wb5eR/qf
         +PaKAmINJAXiE4nQ5b2LgG1Z1oH05tX6s+N0OyR7mFqnjMmKENMxkVpnsyo8hJoPQj
         Kfg2c/MpB4m6OT9sUSl70HtAaPm1/U1FD3Z6khq+lUeMdD9b53maSHMMYYl9nGp3oZ
         XCQTh+B/pwHsVnMBbz+mj1ZoQPqCd4GCuc2xORHM+Q+cXDtSxioynBq/YT9bxsYiTX
         7uyW/EoeB9u002/LFIDcrYuXr7XoG8xREGS9H26UWouJC9oFQnKSyMx1l6G8m/cBc8
         oNd1RAW42qqFQ==
Message-ID: <946f9db2-41a0-b58c-771a-5a82fdf28039@kernel.org>
Date:   Tue, 4 Jul 2023 08:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated ramoops
 memory regions
Content-Language: en-US
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622005213.458236-1-isaacmanjarres@google.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230622005213.458236-1-isaacmanjarres@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 02:52, Isaac J. Manjarres wrote:
> From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
> 
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This is not desirable
> in environments where it is preferred for the region to be dynamically
> allocated early during boot (i.e. the memory region is defined with
> the "alloc-ranges" property instead of the "reg" property).
> 
> If the location of the ramoops region is not fixed via the "reg"
> devicetree property, the call to platform_get_resource() will fail
> because resources of type IORESOURCE_MEM must be described with the
> "reg" property.
> 
> Since ramoops regions are part of the reserved-memory devicetree
> node, they exist in the reserved_mem array. This means that the
> of_reserved_mem_lookup() function can be used to retrieve the
> reserved_mem structure for the ramoops region, and that structure
> contains the base and size of the region, even if it has been
> dynamically allocated.
> 
> Thus invoke of_reserved_mem_lookup() in case the call to
> platform_get_resource() fails in order to support dynamically
> allocated ramoops memory regions.

You missed change to Devicetree binding, so the reg is still required
for all DT-based platforms. For such, this patch is just half-baked.

You also did not CC DT maintainers, which would be nice considering some
improper advises for minidump like here:
https://lore.kernel.org/lkml/e25723bf-be85-b458-a84c-1a45392683bb@gmail.com/

DT is not for some dynamically allocated properties or dynamic system
configuration. You don't need DT for that. Therefore if you remove the
reg, I question the entire point of this binding.

See also:
https://lore.kernel.org/lkml/CAL_JsqJ_TTnGjjB2d8_FKHpWBRG5GHLoWnabCKjsdeZ4QFdNEg@mail.gmail.com/

https://lore.kernel.org/lkml/20230202235916.GA2931100-robh@kernel.org/


Best regards,
Krzysztof

