Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364DD62C38C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiKPQJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiKPQJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:09:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2137048751;
        Wed, 16 Nov 2022 08:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VmgAragsKad3DYDyPDvmvr2wQDM0kWOdioTveI4D4l0=; b=IzmhQ/hf+Y2l47FEm5QYxzZ+KY
        hhl4Bq66giceiIZQUcJiz7IUC6+T1QgfP1Jks1Cng+Sf+jYxbLU+jFrg0vxrzLsLNW46loRXx0Dgn
        slbyu9YZGav8WaHGFiZ56JbD1jyAjQgmV8NobnvKGcN+U/q4nweqwwFN49SHOWl61pciS9c9EkxjD
        N0bnwD1Ammq7ZSlSWIsWzU1aYMghlMHA0ELu7aSadGhJFDNZHR6rPYAv4y4pNyqSIwzpL2wsukH5l
        1zAC10TII8GMRRn5re5EW5gjLuLaswQXXA+WipDsK0+vtyrA3VVRmXGJhhMBJ4UiZ7Ww0961AtqVA
        9MCtLhNw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovKyW-005iVS-Em; Wed, 16 Nov 2022 16:09:20 +0000
Message-ID: <a314cfc6-3d3a-7f45-55cd-187d9e575ab4@infradead.org>
Date:   Wed, 16 Nov 2022 08:09:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/4] driver core: Add fw_devlink.timeout param to stop
 waiting for devlinks
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, John Stultz <jstultz@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>
References: <20221116115348.517599-1-javierm@redhat.com>
 <20221116120159.519908-1-javierm@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221116120159.519908-1-javierm@redhat.com>
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

On 11/16/22 04:01, Javier Martinez Canillas wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774..38138a44d5ed 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1581,6 +1581,13 @@
>  			dependencies. This only applies for fw_devlink=on|rpm.
>  			Format: <bool>
>  
> +	fw_devlink.timeout=
> +			[KNL] Debugging option to set a timeout in seconds for
> +			drivers to give up waiting on dependencies and to probe
> +			these are optional. A timeout of 0 will timeout at the
> +			end of initcalls. If the time out hasn't expired, it'll

			                         timeout

> +			be restarted by each successful driver registration.

-- 
~Randy
