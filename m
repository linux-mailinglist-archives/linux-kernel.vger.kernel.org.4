Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1B6897FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjBCLn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBCLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:43:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3389D5A9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:43:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCF8161EF5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65765C433D2;
        Fri,  3 Feb 2023 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675424633;
        bh=bdG0+WxxVuAZJfBPDcGrmMEOLzt798S3/6MWjbjbXmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fe1TZ2Tt93/AWCPcC45OePpNi178aMDslin1VHJGVSeDGzHFG67mZGu3zqXLo5drF
         2SEEP7M9qH+bMITtshxctuGx6dAJMprl8wNmq0WC7MGt0smow14AxpOspKcV7NLJh6
         RofRpdHBcCRFtm3VwzKowUssZrkJaCqE/I84XxHMDaAiBsnqQNOq+uHX7MV/bla+0C
         dm6cNyrwBL4nRp09vb6La6jvfJ/Iz7rHVEBCyesuhHbLm4TsqDph6HYHqaPn3/X+DX
         FE36FkuLOisZ6s8ZE6TxheQLtVpjC8BnL2OxlQ00FNNGZzNeUuAH/lfgPEhzYz4iJk
         G7BiAQlwvXSrg==
Date:   Fri, 3 Feb 2023 17:13:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neill Kapron <nkapron@google.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Zhong <zyw@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] phy: rockchip-typec: fix tcphy_get_mode error case
Message-ID: <Y9zzdBZiQx460D/z@matsya>
References: <20230126001013.3707873-1-nkapron@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126001013.3707873-1-nkapron@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-23, 00:10, Neill Kapron wrote:
> The existing logic in tcphy_get_mode() can cause the phy to be
> incorrectly configured to USB UFP or DisplayPort mode when
> extcon_get_state returns an error code.
> 
> extcon_get_state() can return 0, 1, or a negative error code.
> 
> It is possible to get into the failing state with an extcon driver
> which does not support the extcon connector id specified as the
> second argument to extcon_get_state().
> 
> tcphy_get_mode()
> ->extcon_get_state()
> -->find_cable_index_by_id()
> --->return -EINVAL;

Applied, thanks

-- 
~Vinod
