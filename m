Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A84A745C75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjGCMp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCMpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE15BC;
        Mon,  3 Jul 2023 05:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF23260F1E;
        Mon,  3 Jul 2023 12:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B49C433C7;
        Mon,  3 Jul 2023 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688388323;
        bh=aPhviO+6gR3kw19K1RPOfSMPLnc5aEdn3cO2oF8ecBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwA9qcQ7EoE0uU+5LDOVbwvV0l+VLBzBd0BpMHA1z3wg9/xoTqu0K0sQzeHf26Csi
         khDJkCglgQuP1ps9tE5eIK33+0jaOXWuNtYKew7Rf3sqDXxl/KeB1BT3oxa602StNY
         ZbEDNyNeVSTQUlSG9XL0WfGLsUmAnvfgikkHHXus=
Date:   Mon, 3 Jul 2023 14:45:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        John Keeping <john@keeping.me.uk>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Dan Carpenter <error27@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: functionfs: avoid memcpy() field overflow warning
Message-ID: <2023070309-outlook-predator-c3dc@gregkh>
References: <20230703123053.3117488-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703123053.3117488-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 02:30:32PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> __ffs_func_bind_do_os_desc() copies both the CompatibleID and SubCompatibleID
> fields of the usb_ext_compat_desc structure into an array, which triggers
> a warning in the fortified memcpy():
> 
> In file included from drivers/usb/gadget/function/f_fs.c:17:
> In file included from include/linux/string.h:254:
> include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __read_overflow2_field(q_size_field, size);
> 
> Usually we can avoid this by using a struct_group() inside of the structure
> definition, but this might cause problems in userspace since it is in a uapi
> header.

We use this in other uapi .h files, what is unique about these fields
that makes it so that they can not be used?  Because it's not the last
field?

thanks,

greg k-h
