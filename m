Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D4746951
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGDGFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGDGFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C5BCE;
        Mon,  3 Jul 2023 23:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 365C16113B;
        Tue,  4 Jul 2023 06:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B090C433C7;
        Tue,  4 Jul 2023 06:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688450717;
        bh=19LKfZBc3Esf04ryoJNH2YTdCewnxeOCzfggqe7jPgc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r+J5n76ZlHfm+4z4MmLEe6JBVMDBOAMyr2F9P7wwAV9eZV2M5Ev7pHwgPWjBYL1Qp
         Wz6e4aVQE+qi2enJqRdK9VBFvlBQhNTfOt22mquuoFXmhWkH6xGfHwFYash/rasZP+
         C6kPuaTLKut2InLqKr8I1eoARhaICoKGf5ATYWfOZ98GAGp0/CjE+qCTIzH0TP/vh9
         lYawywwOSTC1MntXJuKYNb0aDMHT+rx5wghNssFStqjRROEwWp2UcSvZuIOolqc7Tt
         dOKtY3tO6A/tJPQzDRcu74fdIKaNoZ2sXA2vFN9Dz0lk6XYp8i0FRqo4bT9tDCTn+z
         uan7+J7bMvJ1Q==
Message-ID: <3fde3786-24c8-1a03-bd35-5f83ee3474ba@kernel.org>
Date:   Tue, 4 Jul 2023 08:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated ramoops
 memory regions
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     John Stultz <jstultz@google.com>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
References: <20230622005213.458236-1-isaacmanjarres@google.com>
 <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
 <202306212212.5E53607@keescook> <ZJSES98P+zzrhBI5@google.com>
 <3A2CFB4D-27D0-4FEB-93B4-2F888305DE5A@kernel.org>
 <a2c9417b-3a50-bea4-dd39-2f021c196fa1@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <a2c9417b-3a50-bea4-dd39-2f021c196fa1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 21:51, Elliot Berman wrote:
>> Boot 1.
>> Get address Foo.
>> Crash, write to Foo.
>> Boot 2.
>> Get address Bar, different from Foo.
>> Nothing found at Bar, so nothing populated in pstorefs; crash report from Boot 1 unavailable.
>>
>> I feel like there is something I don't understand about the Foo/Bar addresses in my example.
>>
> 
> I believe this is being added to support the QCOM SoC minidump feature. 
> Mukesh has posted it on the mailing lists here:
> 
> https://lore.kernel.org/all/1683133352-10046-1-git-send-email-quic_mojha@quicinc.com/
> 
> https://lore.kernel.org/all/1683133352-10046-10-git-send-email-quic_mojha@quicinc.com/

And since this is coming bypassing DT maintainers and clearly against
Rob's feedback so far, that's a no.

> 
> Mukesh, could you comment whether this patch is wanted for us in the 
> version you have posted? It looks like maybe not based on the commit 
> text in patch #9.


Best regards,
Krzysztof

