Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C8F6C3380
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjCUN47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCUN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAED6199;
        Tue, 21 Mar 2023 06:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F06861C14;
        Tue, 21 Mar 2023 13:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23950C433D2;
        Tue, 21 Mar 2023 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679407007;
        bh=ezAwooPCONqOE3wCgSpV5G/v4lBoltOn+J+AETmWWLk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VLi5xk4+KrQZ3LPmifTMt/HGiUMRfZnocFTOrMRPwIU2YG90z6qMuDvzqDGbinAp8
         FCrOWWN98c+cTc+mLR3760ZYW+c1zKyu7FMwVNHBI5VrRQ7D42uiKp45DZpj0O+W8z
         KHBxpiplb3BOj3uTvaArK3VbmYzktIF3aLQLH5PDUIx27O12YDy94gfTQarH8JaFKD
         09uVZxnPSLP9uMsqC7NY2+Xl6DnjASr4FADJDxenOSf4Q5bFPCPM9zJJPQlpVrHUjj
         YH5JJleSHdYUbR00x4KUAiZp6/oqQCGPk5lAwfIi8twyt93JhRL9uWKTytXk2ohJ8+
         it2hd92EtM3pQ==
Message-ID: <32bcb19f-db74-8660-7270-305e81363376@kernel.org>
Date:   Tue, 21 Mar 2023 15:56:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
Content-Language: en-US
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230228-topic-qos-v7-6-815606092fff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thank you for working on this and sorry about jumping a bit late into
the discussion.

On 8.03.23 23:40, Konrad Dybcio wrote:
> Some (but not all) providers (or their specific nodes) require
> specific clocks to be turned on before they can be accessed. Failure
> to ensure that results in a seemingly random system crash (which
> would usually happen at boot with the interconnect driver built-in),
> resulting in the platform not booting up properly.

These "interface" clocks seem to be used only to program QoS for the
respective ip block (eg ufs). So if we don't program QoS, there should
be no crashes, right?

I believe that in downstream they defer setting QoS until the first
non-zero bandwidth request because of drivers that probe asynchronously
or there is some firmware booting involved (IPA maybe). And bad stuff
might happen if we touch the clock while the firmware is still booting.
So setting the QoS on the first non-zero bandwidth request might not be
a bad idea. Such nodes should probably be also excluded from sync_state
by implementing get_bw() to return 0 bandwidth.

BR,
Georgi

> 
> Limit the number of bus_clocks to 2 (which is the maximum that SMD
> RPM interconnect supports anyway) and handle non-scaling clocks
> separately. Update MSM8996 and SDM660 drivers to make sure they do
> not regress with this change.
> 
> This unfortunately has to be done in one patch to prevent either
> compile errors or broken bisect.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 52 ++++++++++++++++++++++++++++++-------
>   drivers/interconnect/qcom/icc-rpm.h | 14 ++++++++--
>   drivers/interconnect/qcom/msm8996.c | 22 +++++++---------
>   drivers/interconnect/qcom/sdm660.c  | 16 +++++-------
>   4 files changed, 70 insertions(+), 34 deletions(-)
> 
[..]

