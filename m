Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F6669489A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjBMOuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMOuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:50:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBED01C5A3;
        Mon, 13 Feb 2023 06:50:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9088FB81258;
        Mon, 13 Feb 2023 14:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52788C433D2;
        Mon, 13 Feb 2023 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676299799;
        bh=m0Chpo40bobQ2eEBsgYq2sC8P/wqR6TPt8UCc2tCPf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KA4RgytHpbAv8I5kNhM16QsS6vuPHJeZmeierPXj2riN1zQ5GF0XKL9UBs15okDmg
         XeceNDzyG0cdVPq6zXL35nAjQxA9SMc8XSA9QS2WTXtuC+biJXCPEp2cO9YG/0fF7V
         bglsnzQlktYrSwkfndentHAXKy4B94WNrRxwUGrbQ81u4HNlbp533spWW3+6efRoNo
         mqKOfwBnmp/Y5GURsr0+FOdb8QEPfo9rZTPHYGnMptlGae8i5lLKD4iqsVB4Dz99LT
         0cjHuMKGCm8UXavJHlItwPxCnxMHnXZjUw6ZawGtwfXmKrgA7Tam/fgxHXJ9ZTY5F3
         tBSYGDlZyqzXA==
Date:   Mon, 13 Feb 2023 15:49:51 +0100
From:   Robert Richter <rric@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/port: Disable decoder setup for endpoints in RCD mode
Message-ID: <Y+pOD5+DAsm3IKup@rric.localdomain>
References: <20230208071758.658652-1-rrichter@amd.com>
 <63e52846175ae_36c729428@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e52846175ae_36c729428@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 09.02.23 09:07:18, Dan Williams wrote:
> Robert Richter wrote:
> > In RCD mode the HDM decoder capability is optional for endpoints and
> > may not exist. The HDM range registers are used instead. Since the
> > driver relies on the existence of an HDM decoder capability, its
> > absence will cause the initialization of a memory card to fail.
> > 
> > Moreover, the driver also tries to enable or reuse enabled memory
> > ranges. In the worst case this may lead to a system hang due to
> > disabling system memory that was previously provided and setup by
> > system firmware.
> > 
> > To solve the issues described, disable decoder setup for RCD endpoints
> > and instead rely exclusively on system firmware to enable those memory
> > ranges. Decoders are used by the kernel to setup and configure CXL
> > memory regions, esp. to enable and disable them. Since Hot-plug is not
> > supported for devices in RCD mode, the ability to disable that memory
> > by the kernel using a decoder is not a necessarily requirement,
> > decoders are not needed then.
> > 
> > Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Does Dave's series address this problem?
> 
> https://lore.kernel.org/linux-cxl/167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local/
> 
> ...that is arranging for the driver to carry-on in the absence of the
> HDM Decoder Capability.

it might only solve the missing hdm decoder capability. I need to take
a closer look if that also solves a system hang I was debugging which
is caused by clearing the memory disable bit in the hdm dvsec range
register. So the best would be to use this patch now to fix decoder
initialization in RCD mode and then have Dave's patches on top. I am
going to test the series too.

Thanks,

-Robert
