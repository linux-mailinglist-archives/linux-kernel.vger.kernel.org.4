Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC269C767
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjBTJKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBTJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:10:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE15EF8B;
        Mon, 20 Feb 2023 01:09:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E6360D2E;
        Mon, 20 Feb 2023 09:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37103C433EF;
        Mon, 20 Feb 2023 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676884197;
        bh=Z0ZDV3DncdycoiOXjiRXE7xcN6gZ3+6NznW5mUk3Xxg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uSS2VxJMyafs1e7hh0bUXARu4TfQZ8AnWbfP31xq+8YepvDFXzl4I7JdyVtTOeOWU
         a9bjZqFTyUYX1nfHIb1rM8NwUmJYfP43nw1MqxYlW7E65ZeQfu/Ux7kpH5FfcqDPf7
         QXZw7arIiyHvpwU0lAZRRChYveGtb27xwQ+G8tBK1IeTudSSpDrGt/2Jwh0lH91yOx
         ar/UORj3IY8knLWZaP3DHbYOP1TabPxPiFGfpMH3yDWHk8h17zBO7SnqNGPLG6coF6
         XHSHHmZtUBUbH7sG7xuXFVf3PhfqdmxK7o7Chha2Cz5qH5jT+RoSMq0UXtN8grsDJO
         yNMJk8Lvf4t1w==
Date:   Mon, 20 Feb 2023 10:09:59 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Rishi Gupta <gupt21@gmail.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: mcp-2221: prevent UAF in delayed work
In-Reply-To: <20230215-wip-mcp2221-v2-1-109f71fd036e@redhat.com>
Message-ID: <nycvar.YFH.7.76.2302201009430.1142@cbobk.fhfr.pm>
References: <20230215-wip-mcp2221-v2-1-109f71fd036e@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023, Benjamin Tissoires wrote:

> If the device is plugged/unplugged without giving time for mcp_init_work()
> to complete, we might kick in the devm free code path and thus have
> unavailable struct mcp_2221 while in delayed work.
> 
> Canceling the delayed_work item is enough to solve the issue, because
> cancel_delayed_work_sync will prevent the work item to requeue itself.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks Benjamin.

-- 
Jiri Kosina
SUSE Labs

