Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE9474CAA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGJDiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGJDiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF32AF;
        Sun,  9 Jul 2023 20:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA3E60DC5;
        Mon, 10 Jul 2023 03:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122C6C433C7;
        Mon, 10 Jul 2023 03:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688960287;
        bh=v0OsTtvNKU6Dld3+w3JG1lJowk+7fQMnwswrEl/ZXho=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I3vszjayKwTZgx7pu48sWg1k5KBKxkXctrW6bu353IwqtA9FDkUA7UB58Thl0EhHA
         B70Ik7KJ+gLjEd/EJMekP58Fj22ciYqtrwFfDgaE8piXiARykGJpw4fmJMr0abMiYv
         kznZLRTeIpAciA+le/inMAv0/2rIwFn7wPgoi0g6V+OEpDki3zv82reX0K4OX0Vk6U
         Pk3PpnvQIPIwP0lZqaH5XhB2u9jeRgPYAmJw6E9/kj6Hic8bm2+vgsnEqqkEqgA9Ri
         Z5P+PafgNNhL27TXboyzGxGeY4OuUhIK5umaEMLtbzeoYff/FKxbLMUD0g8AMLhDai
         VEhKaDKNhWjAg==
Message-ID: <fd95e3cb-d7b7-ec8b-c48b-d86634f07dfd@kernel.org>
Date:   Sun, 9 Jul 2023 22:38:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] vgacon, arch/*: remove unused screen_info definitions
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     javierm@redhat.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
References: <20230707095415.1449376-1-arnd@kernel.org>
 <20230707095415.1449376-4-arnd@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230707095415.1449376-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 04:52, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A number of architectures either kept the screen_info definition for
> historical purposes as it used to be required by the generic VT code, or
> they copied it from another architecture in order to build the VGA
> console driver in an allmodconfig build.
> 
> Now that vgacon no longer builds on these architectures, remove the
> stale definitions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/csky/kernel/setup.c          | 12 ------------
>   arch/hexagon/kernel/Makefile      |  2 --
>   arch/hexagon/kernel/screen_info.c |  3 ---
>   arch/nios2/kernel/setup.c         |  5 -----

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

