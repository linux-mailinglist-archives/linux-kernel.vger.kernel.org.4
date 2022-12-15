Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D633164D982
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLOK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLOK0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:26:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570532E4;
        Thu, 15 Dec 2022 02:26:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C5061D51;
        Thu, 15 Dec 2022 10:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3973EC433EF;
        Thu, 15 Dec 2022 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671100007;
        bh=BLExdwvBmXZ2P7ZABWJyTRWc1Fir1N+SQnl5ofyV3SE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JPHsIO6wbV1ihtJBhWXaHpaO+7bDOmFEVsqT098twHxMWuGJCEXjpPg6E3IW7v7qg
         2gd4w7yzvJ2ixeTQckUdZ2MIH2446e+OW/auL39wtNxmJqFGJZvfOEaqxnYNlgAmgL
         QF7u5yg2vJOnphO2o+U6HWuDXZYgT1GIWaTiEZmoez1jRER+1DpcVLorhYcy2yzB7p
         SI8NYL4AhKqMe4n8RUaXgFxGNaKbCupxAFmA8bdCTRAl9PgnNy7ZGN7WRhwDYmCUgy
         RJs4HvS95uALvbPFlSn9Q0rDpm4h5EvKGb6VWljkpCLzO2061fkqiOWpZJZB94rwgj
         +vykIuQ5yotrA==
Date:   Thu, 15 Dec 2022 11:26:46 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Adrian Freund <adrian@freund.io>
cc:     kernel test robot <lkp@intel.com>, linux-input@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ivan Dovgal <iv.dovg@gmail.com>,
        "Luke D . Jones" <luke@ljones.dev>
Subject: Re: [PATCH] HID: amd_sfh: Add support for tablet-mode-switch
 sensor
In-Reply-To: <3447483d-11bc-8ab2-8aba-96870b42281b@freund.io>
Message-ID: <nycvar.YFH.7.76.2212151125090.9000@cbobk.fhfr.pm>
References: <20221214214127.15347-1-adrian@freund.io> <202212151621.e3OmYctb-lkp@intel.com> <3447483d-11bc-8ab2-8aba-96870b42281b@freund.io>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022, Adrian Freund wrote:

> >     In file included from drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c:15:
> >>> drivers/hid/amd-sfh-hid/sfh1_1/../hid_descriptor/amd_sfh_hid_report_desc.h:649:17:
> >>> warning: 'tms_report_descriptor' defined but not used
> >>> [-Wunused-const-variable=]
> >       649 | static const u8 tms_report_descriptor[] = {
> >           |                 ^~~~~~~~~~~~~~~~~~~~~
> hid_descriptor/amd_sfh_hid_report_desc.h is included from both
> hid_descriptor/amd_sfh_hid_desc.c and sfh1_1/amd_sfh_desc.c, the first of
> which has 4 usages of tms_report_descriptor. The later is for sensor fusion
> hub 1.1. I don't have access to a devices using sfh1.1, so I can't add support
> for the tablet mode switch there, causing the variable to be unused for that
> import.

I'd say either move the rdesc directly to 
hid_descriptor/amd_sfh_hid_desc.c, or alternatively mark it with 
__attribute__((used)).

-- 
Jiri Kosina
SUSE Labs

