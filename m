Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2D622808
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKIKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKIKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:08:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079A25FCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:08:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 952D6B81D7B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C97C43146;
        Wed,  9 Nov 2022 10:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667988502;
        bh=GBRFNikc4eTm8FKDZ6jVQsXeo+tz2Vw6KgcrdQllQ44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGt9dv/lrqjU7zuyozV8LHGHlOwfzq52OfdxP/+V1QcuTubN+VOSPPQf28E2HeqZ6
         Ad7ICR9DuHRsptbGxejnP+EcTpAQlrnSFDMDE5tvE/NWve/Mn5hluHMaMLh1e2ei+/
         pf8Vrp7QZ1j5HySgZNmBta39tW4vAVDGtdiZa2L8=
Date:   Wed, 9 Nov 2022 11:08:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     zhengyejian1@huawei.com, dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org, sivanich@hpe.com,
        lkp@intel.com
Subject: Re: [PATCH v7] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <Y2t8E597OQ8nk4D1@kroah.com>
References: <20221109093347.228761-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109093347.228761-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:33:47PM +0800, Zheng Wang wrote:
> Gts may be freed in gru_check_chiplet_assignment.
> The caller still use it after that, UAF happens.
> 
> Fix it by introducing a return value to see if it's in error path or not.
> Free the gts in caller if gru_check_chiplet_assignment check failed.
> 
> Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Acked-by: Dimitri Sivanich <sivanich@hpe.com>
> Tested-by: kernel test robot <lkp@intel.com>

The kernel robot did not provide a tested-by comment for this as they
did not test it.

Please never add tags that the person does not submit to you.

greg k-h
