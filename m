Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FEC715DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjE3Lu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjE3Lu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB60F0;
        Tue, 30 May 2023 04:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C367762492;
        Tue, 30 May 2023 11:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B71C433EF;
        Tue, 30 May 2023 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685447455;
        bh=SViWi0+Y4kbgwEoqaRBIp7trJUsmkoHJ1///quKPNaU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AO9jIJI5J2nA828jr2PkKwj+6C364JzJWqF8mpWKYd4CDfypOI+q3EM9k9worYCsA
         Un3WWEGUUzGQ0zX4LwJNNh8McRU3AU06GhIw4IyLfwQDN0YF19skoE3w9CXNhh+Ton
         yHdNp/RilsgzF8IOeV7cJEmXd9oXVc/gNpCun+3Mhf7Q6jLIPILsN2IgGHzarwUKwN
         VsGrMy5ljOsP2sqjt7lklXRlIUKM2QWYDP/KTb3qHGZ6KPiMZYO5NzkQyRIAiPTkdv
         CV5WzYCmE3oqGf7VP5a2rdncPzjxIwVFndN8in7O5J0Hj4eZ2cvanat7SiQshYT9WY
         8NHBgqf4yC4sw==
Message-ID: <1b4eba7e-2771-b0c8-ec23-2ed882374e5d@kernel.org>
Date:   Tue, 30 May 2023 13:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 3/4] dt-bindings: remoteproc: add compatibility for
 TEE support
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
 <20230523091350.292221-4-arnaud.pouliquen@foss.st.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230523091350.292221-4-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 11:13, Arnaud Pouliquen wrote:
> Rework compatibility description according to the support of
> the authenticated firmware relying on OP-TEE authentication.
> 
> The expected behavior is:
> - with legacy compatible "st,stm32mp1-m4" the Linux kernel loads a
>   non-signed (ELF) firmware image,
> - with compatible "st,stm32mp1-m4-tee" the Linux kernel load a signed
>   firmware image. In this case it calls TEE services to manage the firmware
>   loading and the remoteproc life-cycle.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested.
Please resend and include all necessary entries.

Because of above and RFC, I assume there is no need for review. Just to
be clear - that's a no.

Best regards,
Krzysztof

