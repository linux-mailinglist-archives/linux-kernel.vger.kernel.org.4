Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C07278D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjFHHbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjFHHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966B1BE4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD25661329
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6A7C433D2;
        Thu,  8 Jun 2023 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686209467;
        bh=kTmeeuXGB/+uirXthK09oxGfwSwfsVio1le6AZ12jjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N97GX1UbLT0k6RJpDYSvg20+/ukDUTfuB9L3eIXLShgk5KVEpDabykNWn6vfqytAQ
         3t4cNlyK7jgtPHADSTGbknvksOizd0ejX+vNo48W0BzbOqmTKbN54vo+4zeQoRuOPI
         7plAGojqz1NIUiphStoPXWWuVE6CrgREGXjZNaBUg0MHjSmwLmQa9nbWU1IQbJfllR
         NjujqWPSv1rdNE0wDaSEGnBOwThLswqeoaik3iaUg6vsy11FEYl8tV+xcUmjGTCpeH
         LhuBzF68Q+koEv3LjgbZDVvavYCMQNGSyMxio0cWk48Uyk0YCl2QFPiWv7SQ1ja+gs
         GSrxX8WFKz7NQ==
Date:   Thu, 8 Jun 2023 09:31:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, gehao@kylinos.cn,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] scripts/gdb: Fix SB_* constants parsing
Message-ID: <20230608-sinkt-melodie-5816a03405de@brauner>
References: <20230607221337.2781730-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607221337.2781730-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 03:13:35PM -0700, Florian Fainelli wrote:
> After f15afbd34d8f ("fs: fix undefined behavior in bit shift for
> SB_NOUSER") the constants were changed from plain integers which
> LX_VALUE() can parse to constants using the BIT() macro which causes the
> following:
> 
> Reading symbols from build/linux-custom/vmlinux...done.
> Traceback (most recent call last):
>   File "/home/fainelli/work/buildroot/output/arm64/build/linux-custom/vmlinux-gdb.py", line 25, in <module>
>     import linux.constants
>   File "/home/fainelli/work/buildroot/output/arm64/build/linux-custom/scripts/gdb/linux/constants.py", line 5
>     LX_SB_RDONLY = ((((1UL))) << (0))
> 
> Use LX_GDBPARSED() which does not suffer from that issue.
> 
> f15afbd34d8f ("fs: fix undefined behavior in bit shift for SB_NOUSER")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Fine by me,
Acked-by: Christian Brauner <brauner@kernel.org>
