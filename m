Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C19E69B6A5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBRAUF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Feb 2023 19:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBRAUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:20:03 -0500
X-Greylist: delayed 70 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Feb 2023 16:20:01 PST
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.31.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B1766CCF;
        Fri, 17 Feb 2023 16:20:01 -0800 (PST)
Received: from [80.82.223.85] (helo=mail.piie.net)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <peter@piie.net>)
        id 1pTAwB-0004qO-FT; Sat, 18 Feb 2023 01:18:47 +0100
MIME-Version: 1.0
Date:   Sat, 18 Feb 2023 00:18:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.16.0
From:   "=?utf-8?B?UGV0ZXIgS8Okc3RsZQ==?=" <peter@piie.net>
Message-ID: <f4c85800d8ff4ea362750b3164592979@piie.net>
Subject: Re: acerhdf thermal question
To:     "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>
Cc:     "Mark Gross" <markgross@kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Y+4XbJR/WxCyN0EK@windriver.com>
References: <Y+4XbJR/WxCyN0EK@windriver.com>
 <59c24c3d-eb1e-cdee-3d2e-aa1dda5a96fe@linaro.org>
 <ee826228-3fbb-bf66-b2a1-8e8be2776175@redhat.com>
X-Df-Sender: cGV0ZXJAcGlpZS5uZXQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

16. Februar 2023 12:46, "Paul Gortmaker" <paul.gortmaker@windriver.com> schrieb:

> [Re: acerhdf thermal question] On 16/02/2023 (Thu 10:08) Hans de Goede wrote:
> 
>> Hi Daniel,
>> 
>> On 2/16/23 09:57, Daniel Lezcano wrote:
>> 
>> Hi,
>> 
>> the polling interval is specified and modified via a kernel module parameter [1]
>> 
>> The value is used to change the polling interval of the thermal zone, implying that is accessing
>> the thermal zone device structure internals directly [2]
>> 
>> In real use case, is the interval changed at runtime? Or just when the module is loaded? If the
>> latter, the interval can be passed to the thermal zone at init time without doing a polling change
>> rate after the thermal zone started. In this case, we can remove the polling_delay_jiffies change
>> in the code and fix the structure leakage in this driver.
>> 
>> I believe this very likely only is used at module load-time.
>> So the changes you suggest are fine with me.
>> 
>> I have added Paul Gortmaker to the Cc, Paul is the last person
>> to have done any real (*) work on acerhfd AFAICT.
>> 
>> Paul any objections against making the acerhdf.interval parameter
>> something which only works when set at boot / module load time
>> and removing the ability to change it at runtime ?
> 
> Not that I have any real authority, beyond "touched it last", but
> that aside, I'd say that if it is blocking other subsystem cleanups,
> then by all means make it load-time only.
> 
> It was already obsolete hardware when I was tinkering with it, and
> to my surprise -- that was already five years ago! There can't be a
> large user base out there - and even less tinkering with poll delay.

At least I'm still using it :)  Setting the interval at module load-time is good enough.

-- 
Thanks,
--peter;
