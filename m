Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877CB6B6DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCMDPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMDPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:15:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E42A17A;
        Sun, 12 Mar 2023 20:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ji7+a6ofks+Li2M+ae8+nfJ2DML3rf+ANMTi4oZMLuk=; b=XSTwqNt4ZTEY5L2M5iHubZhRM3
        lUcu/5RXBfl6Zp8g09q1RU3NEV4yPIBQ44dRBPSBa9Bdl/UvCvgrIqEWDUf+oz7PoQ3/QaV/H0Gs/
        aub10sfui8yA+n3RB/rIDxL9MCIQHvR4xwyhOtwV59RfDU5Eaa2RdZTDHnEqbxEqkfThPTQ871xyx
        J+1FDGSLjdUo4raPO2hD2UTP0B68TWUlH3qDSbmWinGIJcWgUpaCBGEUB3bUBoP+WAi/d3pvIcfi3
        iFkSbjqpsSCDp2/VLq2/0V58OwqN/gCEX2eBmAUN5q+xB4cMu3zaofdJUAykR9PlrhxDEVkN+naDy
        nDnx02AQ==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbYez-0047iq-C2; Mon, 13 Mar 2023 03:15:41 +0000
Message-ID: <1c308360-a820-26ed-847c-56726afe0ec3@infradead.org>
Date:   Sun, 12 Mar 2023 20:15:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] kconfig: Update config changed flag before calling
 callback
Content-Language: en-US
To:     Jurica Vukadin <jura@vukad.in>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230307194039.8825-1-jura@vukad.in>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230307194039.8825-1-jura@vukad.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/7/23 11:40, Jurica Vukadin wrote:
> Prior to commit 5ee546594025 ("kconfig: change sym_change_count to a
> boolean flag"), the conf_updated flag was set to the new value *before*
> calling the callback. xconfig's save action depends on this behaviour,
> because xconfig calls conf_get_changed() directly from the callback and
> now sees the old value, thus never enabling the save button or the
> shortcut.
> 
> Restore the previous behaviour.
> 
> Fixes: 5ee546594025 ("kconfig: change sym_change_count to a boolean flag")
> Signed-off-by: Jurica Vukadin <jura@vukad.in>

Thanks! I was wondering what had happened to that, but I never
got around to bisecting it.

Now the Disk icon is live instead of being greyed out after
a change is made.


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  scripts/kconfig/confdata.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index b7c9f1dd5e42..992575f1e976 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -1226,10 +1226,12 @@ static void (*conf_changed_callback)(void);
>  
>  void conf_set_changed(bool val)
>  {
> -	if (conf_changed_callback && conf_changed != val)
> -		conf_changed_callback();
> +	bool changed = conf_changed != val;
>  
>  	conf_changed = val;
> +
> +	if (conf_changed_callback && changed)
> +		conf_changed_callback();
>  }
>  
>  bool conf_get_changed(void)

-- 
~Randy
