Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E376A06CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjBWK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjBWK50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:57:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D046B2;
        Thu, 23 Feb 2023 02:57:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE370B819A1;
        Thu, 23 Feb 2023 10:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B20C433EF;
        Thu, 23 Feb 2023 10:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677149842;
        bh=hW85lN5X4tT+6zN53XVarJV1CUQAWkY21KNdrbsSBPg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=buEjSrDnKrOEpPiw82BSZZMJn1rFuU7aoPjIBHXxHn7BcJBdPOISGm3xZfK+3V55C
         tdw5JxsLzpX31fY4juIpWimeeMnRKKUEKaxKCqHTJvTJngnynetMylQt2ig1Uj5eqU
         8thp7iS5ubOHz5pDC4NwKfLmcGl7epe7NaO9hGEqZXgwUmRYOQsDj2k4wmoutV7uJx
         vbFQegSw23cUBqXIqXOW0RXGiRqzjSkOi821pZBGuzUu67f3tUPIdJAAJYAiATyO/k
         4J1m+oHQwTRj80104Z3Rhl8XbcQjXxEB1bGxeUjBiIZKAqg9gJ3N5FYLQSs/3IMDQ5
         MQWpeLe3LIXvQ==
Date:   Thu, 23 Feb 2023 11:57:24 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lee Jones <lee@kernel.org>
cc:     benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/2] HID: core: Provide new max_buffer_size attribute
 to over-ride the default
In-Reply-To: <20230123123912.360651-1-lee@kernel.org>
Message-ID: <nycvar.YFH.7.76.2302231156420.1142@cbobk.fhfr.pm>
References: <20230123123912.360651-1-lee@kernel.org>
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

On Mon, 23 Jan 2023, Lee Jones wrote:

> Presently, when a report is processed, its proposed size, provided by
> the user of the API (as Report Size * Report Count) is compared against
> the subsystem default HID_MAX_BUFFER_SIZE (16k).  However, some
> low-level HID drivers allocate a reduced amount of memory to their
> buffers (e.g. UHID only allocates UHID_DATA_MAX (4k) buffers), rending
> this check inadequate in some cases.
> 
> In these circumstances, if the received report ends up being smaller
> than the proposed report size, the remainder of the buffer is zeroed.
> That is, the space between sizeof(csize) (size of the current report)
> and the rsize (size proposed i.e. Report Size * Report Count), which can
> be handled up to HID_MAX_BUFFER_SIZE (16k).  Meaning that memset()
> shoots straight past the end of the buffer boundary and starts zeroing
> out in-use values, often resulting in calamity.
> 
> This patch introduces a new variable into 'struct hid_ll_driver' where
> individual low-level drivers can over-ride the default maximum value of
> HID_MAX_BUFFER_SIZE (16k) with something more sympathetic to the
> interface.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v1 => v2:
>  - Edit the commit message to be less focused on UHID

Now applied to hid.git#for-6.3/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

