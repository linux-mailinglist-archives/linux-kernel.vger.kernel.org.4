Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2EB6D4CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjDCPwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjDCPwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AA23C07;
        Mon,  3 Apr 2023 08:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976ED62062;
        Mon,  3 Apr 2023 15:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE39C4339B;
        Mon,  3 Apr 2023 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680537109;
        bh=sttDs4JUXkcG5X9tQx1Tw6YAw8ozdvjehYun78az3GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPA6CDzULnd9smJFkZSl5BiibMQ9jwJlrLt/Sdb9/ZHrxa8ojlMjlnX6Kz5ps/oqk
         iXdPd2FRdczYF56wwREIM6Opl9GQ374bRhlwsDqxQCqxTmZFeMt1+O6fkaL1/EaxLT
         Bc3f81t8+uEIaEDkbpXsjX/OtT16hKCsGAXNww2yCd/+q/gz3MP4rN6RTk+X2ai0BC
         mVQB3GgXoVIUcVnl3s0VSaPN2qCbe+GMw1g95QwywMRdg1m7flBe/7rvxXQixVTl+e
         zs18LnjEVayZZD5cDETFZ/LjPoLBN51EPyRC34vOnEqGhWFCcSvyW1GH5Wizxl0ZQM
         +aBuJjc+A89Dw==
Date:   Mon, 3 Apr 2023 08:51:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: linux-next: Tree for Apr 3
Message-ID: <20230403155147.GA239124@dev-arch.thelio-3990X>
References: <20230403202412.66d43f13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403202412.66d43f13@canb.auug.org.au>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen (and Greg, just as an FYI):

On Mon, Apr 03, 2023 at 08:24:12PM +1000, Stephen Rothwell wrote:

...

> Merging driver-core/driver-core-next (43ba3d4af7a7 pktcdvd: simplify the class_pktcdvd logic)

...

> Merging char-misc/char-misc-next (48a6c7bced2a cdx: add device attributes)

There is a semantic conflict between these two trees:

  drivers/cdx/cdx.c:393:8: error: incompatible function pointer types initializing 'ssize_t (*)(const struct bus_type *, const char *, size_t)' (aka 'long (*)(const struct bus_type *, const char *, unsigned long)') with an expression of type
   'ssize_t (struct bus_type *, const char *, size_t)' (aka 'long (struct bus_type *, const char *, unsigned long)') [-Wincompatible-function-pointer-types]
  static BUS_ATTR_WO(rescan);
         ^~~~~~~~~~~~~~~~~~~
  include/linux/device/bus.h:129:42: note: expanded from macro 'BUS_ATTR_WO'
          struct bus_attribute bus_attr_##_name = __ATTR_WO(_name)
                                                  ^~~~~~~~~~~~~~~~
  include/linux/sysfs.h:135:11: note: expanded from macro '__ATTR_WO'
          .store  = _name##_store,                                        \
                    ^~~~~~~~~~~~~
  <scratch space>:30:1: note: expanded from here
  rescan_store
  ^~~~~~~~~~~~
  1 error generated.

caused by commit 75cff725d956 ("driver core: bus: mark the struct
bus_type for sysfs callbacks as constant") in the driver-core tree
interacting with commit 2959ab247061 ("cdx: add the cdx bus driver") in
the char-misc tree. The following diff fixes it for me, could it be
applied to the merge of the char-misc tree (if I am reading the order of
your merges correctly)?

If there is a better or more appropriate way to report this, please let
me know.

Cheers,
Nathan

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 67c32cb2c006..38511fd36325 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -363,7 +363,7 @@ static struct attribute *cdx_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cdx_dev);
 
-static ssize_t rescan_store(struct bus_type *bus,
+static ssize_t rescan_store(const struct bus_type *bus,
 			    const char *buf, size_t count)
 {
 	struct cdx_controller *cdx;
