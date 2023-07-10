Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16EC74CF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjGJIOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjGJINU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:13:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5443BE1;
        Mon, 10 Jul 2023 01:13:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE26D21E95;
        Mon, 10 Jul 2023 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688976797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8Qf7yQhkpIDFSE/7LQCLIc2ZQ8OuhBKadYzy9Ww5b4=;
        b=vZw/xNLiNv8xBtbYQWSKrAUI54ZT+td8vCMhypzL7tgvJIhOWqEdXcPd4iydz83MHCyYiI
        qYs6AedS0JYx4W4SzzvDdIsqb4X77iKtjvFzXWGB1iSWVdH/ekiPbFiQ9eqN16x9pxmNgn
        iXnXjQQPbFLZ5xDPy512COTLCJoZzQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688976797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8Qf7yQhkpIDFSE/7LQCLIc2ZQ8OuhBKadYzy9Ww5b4=;
        b=zZYoyHi7O1KjDjFi+PlQntA6HC9pudWQ/H72oH5oG/cR1Av+v8ja0g1neTk5cUrsO+pP8g
        gxLPvVh3RDLyc5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AB4C13A05;
        Mon, 10 Jul 2023 08:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ULMlD529q2SGBwAAMHmgww
        (envelope-from <dkirjanov@suse.de>); Mon, 10 Jul 2023 08:13:17 +0000
Message-ID: <7a561aac-08c6-5a20-6254-82b2c2601d13@suse.de>
Date:   Mon, 10 Jul 2023 11:13:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ethernet: e1000e: Fix possible uninit bug
Content-Language: en-US
To:     Yu Hao <yhao016@ucr.edu>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CA+UBctC57Lx=8Eh6P51cVz+cyb02GE_B-dWnYhffWoc-nm7v6Q@mail.gmail.com>
From:   Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <CA+UBctC57Lx=8Eh6P51cVz+cyb02GE_B-dWnYhffWoc-nm7v6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/23 03:10, Yu Hao wrote:
> The variable phy_data should be initialized in function e1e_rphy.
> However, there is not return value check, which means there is a
> possible uninit read later for the variable.
> 
> Signed-off-by: Yu Hao <yhao016@ucr.edu>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 771a3c909c45..455af5e55cc6 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6910,8 +6910,11 @@ static int __e1000_resume(struct pci_dev *pdev)
>     /* report the system wakeup cause from S3/S4 */
>     if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
>         u16 phy_data;
> +       s32 ret_val;
> 
> -       e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
> +       ret_val = e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
> +       if (ret_val)
> +           return ret_val;
>         if (phy_data) {
>             e_info("PHY Wakeup cause - %s\n",
>                    phy_data & E1000_WUS_EX ? "Unicast Packet" :

the same case appears in other places in the driver like e1000_setup_rctl()

