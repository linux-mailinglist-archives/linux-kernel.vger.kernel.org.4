Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00915731679
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbjFOL0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFOL0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:26:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD79F268C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B78762692
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD3DC433C0;
        Thu, 15 Jun 2023 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686828376;
        bh=k0FnXL/BbFimPaXcCZL/2rfJcOIW6w+DKVjXbvJhhvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cvo0pZBZkbVA5PvZZOdEYOeTiQqtrmpdE+Bbp6RR+bWQh07/Fb5ZV5SKurb7eHp+L
         hfMDOmAJd4pVp4kWkd4mRC9vt8avYQqRzRentc0j1FPbSq4j7WHeFcYhRHJEZxa957
         SCj16RfpBqM6pS/RKsohp3czmYFQX9CwSnkLsD3s=
Date:   Thu, 15 Jun 2023 13:26:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v4 0/4] NVMEM cells in sysfs
Message-ID: <2023061503-boneless-salon-4fa3@gregkh>
References: <20230614063018.2419043-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614063018.2419043-1-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 08:30:14AM +0200, Miquel Raynal wrote:
> Hello,
> 
> As part of a previous effort, support for dynamic NVMEM layouts was
> brought into mainline, helping a lot in getting information from NVMEM
> devices at non-static locations. One common example of NVMEM cell is the
> MAC address that must be used. Sometimes the cell content is mainly (or
> only) useful to the kernel, and sometimes it is not. Users might also
> want to know the content of cells such as: the manufacturing place and
> date, the hardware version, the unique ID, etc. Two possibilities in
> this case: either the users re-implement their own parser to go through
> the whole device and search for the information they want, or the kernel
> can expose the content of the cells if deemed relevant. This second
> approach sounds way more relevant than the first one to avoid useless
> code duplication, so here is a series bringing NVMEM cells content to
> the user through sysfs.
> 
> Here is a real life example with a Marvell Armada 7040 TN48m switch:
> 
> $ nvmem=/sys/bus/nvmem/devices/1-00563/
> $ for i in `ls -1 $nvmem/cells/*`; do basename $i; hexdump -C $i | head -n1; done
> country-code
> 00000000  54 57                                             |TW|
> crc32
> 00000000  bb cd 51 98                                       |..Q.|
> device-version
> 00000000  02                                                |.|
> diag-version
> 00000000  56 31 2e 30 2e 30                                 |V1.0.0|
> label-revision
> 00000000  44 31                                             |D1|
> mac-address
> 00000000  18 be 92 13 9a 00                                 |......|
> manufacture-date
> 00000000  30 32 2f 32 34 2f 32 30  32 31 20 31 38 3a 35 39  |02/24/2021 18:59|
> manufacturer
> 00000000  44 4e 49                                          |DNI|
> num-macs
> 00000000  00 40                                             |.@|
> onie-version
> 00000000  32 30 32 30 2e 31 31 2d  56 30 31                 |2020.11-V01|
> platform-name
> 00000000  38 38 46 37 30 34 30 2f  38 38 46 36 38 32 30     |88F7040/88F6820|
> product-name
> 00000000  54 4e 34 38 4d 2d 50 2d  44 4e                    |TN48M-P-DN|
> serial-number
> 00000000  54 4e 34 38 31 50 32 54  57 32 30 34 32 30 33 32  |TN481P2TW2042032|
> vendor
> 00000000  44 4e 49                                          |DNI|
> 
> Here is a list of known limitations though:
> * It is currently not possible to know whether the cell contains ASCII
>   or binary data, so by default all cells are exposed in binary form.
> * For now the implementation focuses on the read aspect. Technically
>   speaking, in some cases, it could be acceptable to write the cells, I
>   guess, but for now read-only files sound more than enough. A writable
>   path can be added later anyway.
> * The sysfs entries are created when the device probes, not when the
>   NVMEM driver does. This means, if an NVMEM layout is used *and*
>   compiled as a module *and* not installed properly in the system (a
>   usermode helper tries to load the module otherwise), then the sysfs
>   cells won't appear when the layout is actually insmod'ed because the
>   sysfs folders/files have already been populated.
> 
> Changes in v4:
> * Use a core helper to count the number of cells in a list.
> * Provide sysfs attributes a private member which is the entry itself to
>   avoid the need for looking up the nvmem device and then looping over
>   all the cells to find the right one.
> 
> Changes in v3:
> * Patch 1 is new: fix a style issue which bothered me when reading the
>   core.
> * Patch 2 is new: Don't error out when an attribute group does not
>   contain any attributes, it's easier for developers to handle "empty"
>   directories this way. It avoids strange/bad solutions to be
>   implemented and does not cost much.
> * Drop the is_visible hook as it is no longer needed.
> * Stop allocating an empty attribute array to comply with the sysfs core
>   checks (this check has been altered in the first commits).
> * Fix a missing tab in the ABI doc.
> 
> Changes in v2:
> * Do not mention the cells might become writable in the future in the
>   ABI documentation.
> * Fix a wrong return value reported by Dan and kernel test robot.
> * Implement .is_bin_visible().
> * Avoid overwriting the list of attribute groups, but keep the cells
>   attribute group writable as we need to populate it at run time.
> * Improve the commit messages.
> * Give a real life example in the cover letter.
> 
> 
> Miquel Raynal (4):
>   sysfs: Improve readability by following the kernel coding style
>   sysfs: Skip empty folders creation
>   ABI: sysfs-nvmem-cells: Expose cells through sysfs
>   nvmem: core: Expose cells through sysfs
> 
>  Documentation/ABI/testing/sysfs-nvmem-cells |  19 ++++
>  drivers/nvmem/core.c                        | 109 +++++++++++++++++++-
>  fs/sysfs/group.c                            |  12 ++-
>  3 files changed, 132 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
