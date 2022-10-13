Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C925FDDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJMP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJMP6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:58:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C320DAC7B;
        Thu, 13 Oct 2022 08:58:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C1C813D5;
        Thu, 13 Oct 2022 08:58:19 -0700 (PDT)
Received: from [10.57.5.87] (unknown [10.57.5.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A70873F67D;
        Thu, 13 Oct 2022 08:58:11 -0700 (PDT)
Message-ID: <77cfc218-0c87-7dd7-6f60-2c2c12f9f892@arm.com>
Date:   Thu, 13 Oct 2022 16:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/governors: Remove integral_cutoff parameter, IPA
 is more regulated
Content-Language: en-US
To:     Qibo Huang <huangqibo.tech@gmail.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com
References: <20221013090733.28462-1-huangqibo.tech@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221013090733.28462-1-huangqibo.tech@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qibo,

On 10/13/22 10:07, Qibo Huang wrote:
> Reason 1: If the integral_cutoff parameter is 0,
> the current temperature is greater than the control
> temperature, and err_integral continues to increase.
> If an abnormal situation occurs suddenly, the err_integral
> value will become very large. Even if the current
> temperature is lower than the control temperature,
> err_integral will always exist, which will cause the
> IPA to run out of control and cannot return to normal.
> This is the problem I'm actually having.
> 
> Reason 2: The integral_cutoff parameter is difficult to
> confirm the optimal, and can not bring good results.

Have you tired different 'k_i', 'k_po', 'k_pu' settings,
not the default from binding estimation?

These coefficients help to control the behavior of IPA
and how good the control loop could work.

The integral cutoff in default is set to 0, which means
we account the error when we overshoot the temperature
vs our desired control temperature value.

Please also pay attention to the type for those variables:
err, i, p and how they are treated (and when).
In current implementation we account 'err' negative, so we
reduce the power budget. Next time, even when we are below
control temperature, we still 'remember' those
overshoot mistakes, so we upfront shrink the possible
budget (to avoid overshooting). We clean the accumulated
error when the temperature drops below 'enable' trip point.

Could you describe a bit more what kind of problems you
observe, please?

Regards,
Lukasz
