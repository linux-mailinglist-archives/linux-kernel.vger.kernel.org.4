Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979C17429C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjF2Pg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjF2Pg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16043E49;
        Thu, 29 Jun 2023 08:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A84E96157B;
        Thu, 29 Jun 2023 15:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8BCC433C8;
        Thu, 29 Jun 2023 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688053014;
        bh=kSpwvCZSrV4ZbYU3Q5FvpCaAemmPCQQhwe8ZxmoemxI=;
        h=Date:From:To:Cc:Subject:From;
        b=KVC28lW5yxngXLh5CccM8D8GYCbNrX2qHUHcnIIazRGP+JOx0zBuezE5LJR1VYZUD
         h5XRSfxiyXKlFyLAge4GsKqyWVi4IZtqkqV/Xfsxap2UKkUdYmcIdEs3QR0Y0qGNwr
         8PyTNSfEyEyrAh0Zwitxg0LlDGXYaXbrxejHBWLU=
Date:   Thu, 29 Jun 2023 17:36:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-usb@vger.kernel.org
Subject: UBSAN spat in valid xhci code in Linus's current tree (6.4+)
Message-ID: <2023062945-fencing-pebble-0411@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees.

Boris just reported to me a UBSAN splat in the USB xhci driver in
Linus's tree that wasn't present in 6.4-final, and given that no USB
changes are merged yet there, I was confused.

Turns out, I think you all missed a "variable length" structure in the
xhci driver, which UBSAN is calling out a being an overrun, when really
it isn't (it's just written that way...)

The splat is:

UBSAN: array-index-out-of-bounds in drivers/usb/host/xhci-hub.c:231:31
index 1 is out of range for type '__le32 [1]'
CPU: 0 PID: 1556 Comm: kworker/0:2 Not tainted 6.4.0+ #7


And yes, the code there:
	ssp_cap->bmSublinkSpeedAttr[offset++] = cpu_to_le32(attr);

is accessing the ssp_cap->bmSublinkSpeedAttr field with is declared as:
	_le32 bmSublinkSpeedAttr[1]; /* list of sublink speed attrib entries */

in include/uapi/linux/usb/ch9.h

So perhaps 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC") should be
reverted for now?  Or this field fixed up to properly be marked as a
variable length array of at least one entry?

thanks,

greg k-h

