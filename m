Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3E708653
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjERRCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41FD121;
        Thu, 18 May 2023 10:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 596AA6508F;
        Thu, 18 May 2023 17:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99697C433D2;
        Thu, 18 May 2023 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684429356;
        bh=79AycYGWyrOQGPq3/yfTreinQpf172phqCKZ12EBcSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spj3g1H5gdhvCnAM7rSXem86Ykpv72fmpCnJQkzgLdUgWBWH7uvG19mO4+R8d+A5I
         3rc71yaT/owlcNDhqfuUiUIalXA1AfNNlk5d/uy6zOSHCztRMPpmHT6jy69q2GJQ5x
         DMLVRo055Y0JfHRuxHX3e07koRVko78Q8ojlCL3/tLH9kioFOwXBfLpYGaepwi7yzs
         0Hplzq5p5NT/979I6Onxxt93X1YBfo4ucrSN+d8VP1n3kNvF9zlijpJnElzZFXFXf7
         cQ+Hfsc2xaxcXJ2KBsdi1FmaMRbp3UW4B0pAwVbjoJsicqjGcBOGizHtXsu8lpLNTx
         WiTKQ5jzWMy8A==
Date:   Thu, 18 May 2023 13:02:35 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        bleung@chromium.org, groeck@chromium.org,
        kevin.chiu.17802@gmail.com,
        scott_chao@wistron.corp-partner.google.com,
        zoey_wu@wistron.corp-partner.google.com,
        hellojacky0226@hotmail.com, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.3 34/44] media: cros-ec-cec: Don't exit early
 in .remove() callback
Message-ID: <ZGZaK2lp8NCvyAmk@sashalap>
References: <20230501025632.3253067-1-sashal@kernel.org>
 <20230501025632.3253067-34-sashal@kernel.org>
 <20230501152632.ccsvhl2c6ihuizcf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230501152632.ccsvhl2c6ihuizcf@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 05:26:32PM +0200, Uwe Kleine-König wrote:
>Hello,
>
>On Sun, Apr 30, 2023 at 10:56:22PM -0400, Sasha Levin wrote:
>> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> [ Upstream commit 0ff7aee24e47beb4306ce050824b54147f2fabfa ]
>>
>> Exiting early in remove without releasing all acquired resources yields
>> leaks. Note that e.g. memory allocated with devm_zalloc() is freed after
>> .remove() returns, even if the return code was negative.
>>
>> While blocking_notifier_chain_unregister() won't fail and so the
>> change is somewhat cosmetic, platform driver's .remove callbacks are
>> about to be converted to return void. To prepare that, keep the error
>> message but don't return early.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>While I'm positive this change doesn't break anything, it also doesn't
>fix anything and is only cosmetic (+ preparing a later change).
>
>Unless you need it as a dependency I'd say, don't backport it for
>stable.

Ack, dropped. Thanks!

-- 
Thanks,
Sasha
