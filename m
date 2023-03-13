Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96B6B81F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCMT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCMT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:57:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722CC84F4E;
        Mon, 13 Mar 2023 12:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DB088CE1177;
        Mon, 13 Mar 2023 19:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6F3C433D2;
        Mon, 13 Mar 2023 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678737464;
        bh=SE/kLlvb22yM3HfdWJ2vyvNY7QKQkNPUOvGqbw17aZk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R+RaCeTb5li4mVAuenrk+Tgs7Z1IVYD7n11bWd/A5GFp+KgVkY1LqnlDRvstVkRLc
         zTsAkn07STHJUvihJM151923lNIgqb9i3+YPmcx/9zIsnU5ipQEDIppp/HM9kSxoSt
         vFgTPwG+ZQRYnYzhwawFV9qBVUZLkfu9wLU7PqzRcI1iSF1omykb9zRL4i2JhrTem7
         PgExx1og2dyfubRBa8UI5aJIpE/sTHCqroypDNogjgOW1HUPi7rHNZI3TiXISAo35A
         d0cqrmycr28KTMXDkFT6WM2Bj6OEJ//fckOk7pgb7TSt21sNHdq0d65UwK0ljXUPAD
         NZQGUd35WQ5Ng==
Message-ID: <3995e6b4-b222-6152-0292-29ed3704de02@kernel.org>
Date:   Mon, 13 Mar 2023 21:57:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] interconnect: qcom: rpm: fix msm8996 interconnect
 registration
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313084953.24088-1-johan+linaro@kernel.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230313084953.24088-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Thank you for all the fixes!

On 13.03.23 10:49, Johan Hovold wrote:
> Christophe noticed that a recent patch adding a missing clock disable to
> one of the Qualcomm rpm driver error paths was broken. This would lead
> to the provider not being registered on msm8996 which is the only
> platform using this code path.

Thanks Christophe for catching this!

> Turns out, however, that the power domain attach during probe is bogus
> and would always succeed as any power domain would already have been
> attached by the platform bus code.

Thanks Konrad for testing and confirming!

> Georgi, the offending commit is currently in your icc-next (and local
> icc-fixes) branch. Perhaps you can fold in the fixup unless you prefer
> applying it on top.
> 
> The bogus PM domain lookup is redundant and confusing but should
> otherwise be benign so the removal could be applied to either branch.

Maybe then I'll just drop this:
	interconnect: qcom: rpm: fix probe PM domain error handling
and apply this one instead:
	interconnect: qcom: rpm: drop bogus pm domain attach

BR,
Georgi

> 
> Johan
> 
> 
> Johan Hovold (2):
>    interconnect: qcom: rpm: fix msm8996 interconnect registration
>    interconnect: qcom: rpm: drop bogus pm domain attach
> 
>   drivers/interconnect/qcom/icc-rpm.c | 5 -----
>   drivers/interconnect/qcom/icc-rpm.h | 1 -
>   drivers/interconnect/qcom/msm8996.c | 1 -
>   3 files changed, 7 deletions(-)
> 

