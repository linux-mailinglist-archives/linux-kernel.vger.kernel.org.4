Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E205E619605
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKDMQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKDMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:16:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C817F2C10D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:16:35 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id qvcdoY7T8XaejqvcdoQyhD; Fri, 04 Nov 2022 13:16:34 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Nov 2022 13:16:34 +0100
X-ME-IP: 86.243.100.34
Message-ID: <e9c15b05-6515-cc40-d842-4bdaca96b0c8@wanadoo.fr>
Date:   Fri, 4 Nov 2022 13:16:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 02/26] mmc: core: Prepare to support SD UHS-II cards
Content-Language: fr
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-3-victor.shih@genesyslogic.com.tw>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221019110647.11076-3-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/10/2022 à 13:06, Victor Shih a écrit :
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Updates in V4:
>   - Re-based, updated a comment and removed white-space.
>   - Moved MMC_VQMMC2_VOLTAGE_180 into a later patch in the series.
> 
> Update in previous version:
> The SD UHS-II interface was introduced to the SD spec v4.00 several years
> ago. The interface is fundamentally different from an electrical and a
> protocol point of view, comparing to the legacy SD interface.
> 
> However, the legacy SD protocol is supported through a specific transport
> layer (SD-TRAN) defined in the UHS-II addendum of the spec. This allows the
> SD card to be managed in a very similar way as a legacy SD card, hence a
> lot of code can be re-used to support these new types of cards through the
> mmc subsystem.
> 
> Moreover, an SD card that supports the UHS-II interface shall also be
> backwards compatible with the legacy SD interface, which allows a UHS-II
> card to be inserted into a legacy slot. As a matter of fact, this is
> already supported by mmc subsystem as of today.
> 
> To prepare to add support for UHS-II, this change puts the basic foundation
> in the mmc core in place, allowing it to be more easily reviewed before
> subsequent changes implements the actual support.
> 
> Basically, the approach here adds a new UHS-II bus_ops type and adds a
> separate initialization path for the UHS-II card. The intent is to avoid us
> from sprinkling the legacy initialization path, but also to simplify
> implementation of the UHS-II specific bits.
> 
> At this point, there is only one new host ops added to manage the various
> ios settings needed for UHS-II. Additional host ops that are needed, are
> being added from subsequent changes.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

[]

> +static int sd_uhs2_attach(struct mmc_host *host)
> +{
> +	int err;
> +
> +	err = sd_uhs2_power_up(host);
> +	if (err)
> +		goto err;
> +
> +	err = sd_uhs2_phy_init(host);
> +	if (err)
> +		goto err;
> +
> +	err = sd_uhs2_init_card(host);
> +	if (err)
> +		goto err;
> +
> +	mmc_attach_bus(host, &sd_uhs2_ops);
> +
> +	mmc_release_host(host);
> +
> +	err = mmc_add_card(host->card);
> +	if (err)
> +		goto remove_card;
> +
> +	mmc_claim_host(host);
> +	return 0;
> +
> +remove_card:
> +	mmc_remove_card(host->card);

Hi,

If we arrive here, mmc_add_card() has failed.
is it correct to call mmc_remove_card() in such a case?

> +	host->card = NULL;
> +	mmc_claim_host(host);
> +	mmc_detach_bus(host);
> +err:
> +	sd_uhs2_power_off(host);

If sd_uhs2_power_up() fails, we arrive here.
Is its correct to call sd_uhs2_power_off() in such a case, or should we 
return directly if sd_uhs2_power_up() fails?

CJ

> +	return err;
> +}
> +

[]

